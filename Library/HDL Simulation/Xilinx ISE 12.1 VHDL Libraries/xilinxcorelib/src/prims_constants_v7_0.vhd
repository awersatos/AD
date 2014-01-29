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

-- $Id: prims_constants_v7_0.vhd,v 1.13 2008/09/08 20:06:16 akennedy Exp $
--
-- Filename - prims_constants_v7_0.vhd
-- Author - Xilinx
-- Creation - 19 Aug 1999
--
-- Description - This file contains the type declarations for
--				 baseblocks primitives enumerated types for generic parameters.

package prims_constants_v7_0 is

	constant c_set : integer := 0;
	constant c_clear : integer := 1;
	
	constant c_override : integer := 0;
	constant c_no_override : integer := 1;
	
	constant c_signed : integer := 0;
	constant c_unsigned : integer := 1;
	constant c_pin : integer := 2;
	
	constant c_add : integer := 0;
	constant c_sub : integer := 1;
	constant c_add_sub : integer := 2;

	constant c_and : integer := 0;
	constant c_nand : integer := 1;
	constant c_or : integer := 2;
	constant c_nor : integer := 3;
	constant c_xor : integer := 4;
	constant c_xnor : integer := 5;
	constant c_inv : integer := 6;
	constant c_buf : integer := 7;
	
	-- These must match the c_add, c_sub and c_add_sub values respectively!
	constant c_up : integer := 0;
	constant c_down : integer := 1;
	constant c_updown : integer := 2;
	
	-- For C_DIST_MEM...
	constant c_rom : integer := 0;
	constant c_sp_ram : integer := 1;
	constant c_dp_ram : integer := 2;
	constant c_srl16 : integer := 3;
	
	constant c_single_port : integer := 0;
	constant c_dual_port : integer := 1;
	
	constant c_lut_based : integer := 0;
	constant c_buft_based : integer := 1;
	
	constant c_fixed : integer := 0;
	constant c_variable_lossless : integer := 1;
	constant c_variable_lossy : integer := 2;
	
	constant c_lsb_to_msb : integer := 0;
	constant c_msb_to_lsb : integer := 1;
	constant c_bidirectional : integer := 2;
	
	constant c_zeros : integer := 0;
	constant c_ones : integer := 1;
	constant c_lsb : integer := 2;
	constant c_msb : integer := 3;
	constant c_wrap : integer := 4;
	constant c_sdin : integer := 5;
	
end prims_constants_v7_0;


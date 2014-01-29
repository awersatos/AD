-- $Id: prims_constants_v5_0.vhd,v 1.17 2008/09/08 20:05:58 akennedy Exp $
--
-- Filename - prims_constants_v5_0.vhd
-- Author - Xilinx
-- Creation - 19 Aug 1999
--
-- Description - This file contains the type declarations for
--				 baseblocks primitives enumerated types for generic parameters.

package prims_constants_v5_0 is

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
	
end prims_constants_v5_0;


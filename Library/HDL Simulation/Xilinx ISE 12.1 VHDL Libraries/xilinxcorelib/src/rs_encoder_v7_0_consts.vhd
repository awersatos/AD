--------------------------------------------------------------------------------
--  (c) Copyright 1995-2009 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES. 
--------------------------------------------------------------------------------
--
-- $RCSfile: rs_encoder_v7_0_consts.vhd,v $ $Revision: 1.3 $ $Date: 2009/09/08 16:10:54 $
--
--------------------------------------------------------------------------------
--
-- Constants and functions for use in top level component statement.
--

LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;

PACKAGE rs_encoder_v7_0_consts IS

--------------------------------------------------------------------------------
--
-- Defaults
--
--------------------------------------------------------------------------------
CONSTANT c_family_default          : STRING   := "no_family";  -- needed for XCC
CONSTANT c_xdevicefamily_default   : STRING   := "no_family";  -- needed for XCC
CONSTANT c_gen_poly_type_default   : INTEGER  := 0;
CONSTANT c_gen_start_default       : INTEGER  := 0;
CONSTANT c_h_default               : INTEGER  := 1;
CONSTANT c_ce_default              : INTEGER  := 0;
CONSTANT c_n_in_default            : INTEGER  := 0;
CONSTANT c_nd_default              : INTEGER  := 0;
CONSTANT c_r_in_default            : INTEGER  := 0;
CONSTANT c_rdy_default             : INTEGER  := 0;
CONSTANT c_rfd_default             : INTEGER  := 0;
CONSTANT c_rffd_default            : INTEGER  := 0;
CONSTANT c_sclr_default            : INTEGER  := 0;
CONSTANT c_k_default               : INTEGER  := 188;
CONSTANT c_mem_init_prefix_default : STRING   := "rse1";
CONSTANT c_elaboration_dir_default : STRING   := "./";
CONSTANT c_memstyle_default        : INTEGER  := 2; -- = automatic
CONSTANT c_n_default               : INTEGER  := 204;
CONSTANT c_num_channels_default    : INTEGER  := 1;
CONSTANT c_optimization_default    : INTEGER  := 2; --optimize for speed
CONSTANT c_polynomial_default      : INTEGER  := 0;
CONSTANT c_spec_default            : INTEGER  := 0;
CONSTANT c_symbol_width_default    : INTEGER  := 8;
CONSTANT c_userpm_default          : INTEGER  := 0; -- No longer used

--------------------------------------------------------------------------------
--
-- Constants to define dual basis or normal basis
--
--------------------------------------------------------------------------------
CONSTANT c_spec_min : INTEGER := 0;
CONSTANT c_spec_max : INTEGER := 2;

SUBTYPE spec_type IS INTEGER RANGE c_spec_min TO c_spec_max;

CONSTANT j83_b_spec   : spec_type := 2;
CONSTANT ccsds_spec   : spec_type := 1;
CONSTANT custom_spec  : spec_type := 0;
CONSTANT default_spec : spec_type := custom_spec;

--------------------------------------------------------------------------------
--
-- min/max's
--
--------------------------------------------------------------------------------
CONSTANT min_symbol_width : INTEGER := 3;
CONSTANT max_symbol_width : INTEGER := 12;
CONSTANT max_symbol_width_minus_1 : INTEGER := max_symbol_width - 1;
CONSTANT max_num_channels : INTEGER := 128;



--------------------------------------------------------------------------------
--
-- FUNCTION declarations
--
--------------------------------------------------------------------------------
FUNCTION integer_width( integer_value : INTEGER ) RETURN INTEGER;
      
END rs_encoder_v7_0_consts;
          
          
          
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
PACKAGE BODY rs_encoder_v7_0_consts IS

FUNCTION integer_width( integer_value : INTEGER ) RETURN INTEGER IS
    VARIABLE width : INTEGER := 1;
BEGIN
  FOR i IN 30 DOWNTO 0 LOOP
    IF integer_value >= 2**i THEN
      width := i+1;
      EXIT;
    END IF;
  END LOOP;

  RETURN width;

END integer_width;
  



END rs_encoder_v7_0_consts;


--------------------------------------------------------------------------------

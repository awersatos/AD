--------------------------------------------------------------------------------
--  Copyright(C) 2007 by Xilinx, Inc. All rights reserved.
--  This text/file contains proprietary, confidential
--  information of Xilinx, Inc., is distributed under license
--  from Xilinx, Inc., and may be used, copied and/or
--  disclosed only pursuant to the terms of a valid license
--  agreement with Xilinx, Inc.  Xilinx hereby grants you
--  a license to use this text/file solely for design, simulation,
--  implementation and creation of design files limited
--  to Xilinx devices or technologies. Use with non-Xilinx
--  devices or technologies is expressly prohibited and
--  immediately terminates your license unless covered by
--  a separate agreement.
--
--  Xilinx is providing this design, code, or information
--  "as is" solely for use in developing programs and
--  solutions for Xilinx devices.  By providing this design,
--  code, or information as one possible implementation of
--  this feature, application or standard, Xilinx is making no
--  representation that this implementation is free from any
--  claims of infringement.  You are responsible for
--  obtaining any rights you may require for your implementation.
--  Xilinx expressly disclaims any warranty whatsoever with
--  respect to the adequacy of the implementation, including
--  but not limited to any warranties or representations that this
--  implementation is free from claims of infringement, implied
--  warranties of merchantability or fitness for a particular
--  purpose.
--
--  Xilinx products are not intended for use in life support
--  appliances, devices, or systems. Use in such applications are
--  expressly prohibited.
--
--  This copyright and support notice must be retained as part
--  of this text at all times. (c) Copyright 1995-2007 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------
--
-- $RCSfile: rs_encoder_v6_1_consts.vhd,v $ $Revision: 1.7 $ $Date: 2008/09/09 15:24:49 $
--
--------------------------------------------------------------------------------
--
-- Constants and functions for use in top level component statement.
--

LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;

PACKAGE rs_encoder_v6_1_consts IS

--------------------------------------------------------------------------------
--
-- Defaults
--
--------------------------------------------------------------------------------
CONSTANT c_family_default          : STRING   := "virtex4";
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
      
END rs_encoder_v6_1_consts;
          
          
          
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
PACKAGE BODY rs_encoder_v6_1_consts IS

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
  



END rs_encoder_v6_1_consts;


--------------------------------------------------------------------------------

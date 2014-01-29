-- $RCSfile: sid_v5_1_comp_pkg.vhd,v $
--
--  Copyright(C) 2008 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2008 Xilinx, Inc.
--  All rights reserved.


-- Description: Consts/Functions for Component statement
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE sid_v5_1_comp_pkg IS

FUNCTION bits_needed_to_represent(a_value : NATURAL) RETURN NATURAL;
  
FUNCTION select_integer(i0  : INTEGER;
                    i1  : INTEGER;
                    sel : BOOLEAN) RETURN INTEGER;
  
-- Rectangular-block limits
CONSTANT abs_min_num_rows        : INTEGER := 1;
CONSTANT abs_min_num_cols        : INTEGER := 2;

-- c_family_int constants
CONSTANT c_virtex                : INTEGER := 0;
CONSTANT c_virtex2               : INTEGER := 1;

-- c_type constants
CONSTANT c_rectangular_block     : INTEGER := 0;
CONSTANT c_random_block          : INTEGER := 1;
CONSTANT c_relative_prime_block  : INTEGER := 2;
CONSTANT c_dvb_rcs_block         : INTEGER := 3;
CONSTANT c_umts_block            : INTEGER := 4;
-- 5-19 are reserved for future block-based types
CONSTANT c_forney_convolutional  : INTEGER := 20;
CONSTANT c_ramsey1_convolutional : INTEGER := 21;
CONSTANT c_ramsey2_convolutional : INTEGER := 22;
CONSTANT c_ramsey3_convolutional : INTEGER := 23;
CONSTANT c_ramsey4_convolutional : INTEGER := 24;
-- 25-40 are reserved for future convolutional-based types
-- c_mode constants
CONSTANT c_interleaver           : INTEGER := 0;
CONSTANT c_deinterleaver         : INTEGER := 1;
-- c_row_type, c_col_type, c_block_size_type, and c_branch_length_type constants
CONSTANT c_constant              : INTEGER := 0; -- c_row_type, c_col_type, c_block_size_type, c_branch_length_type
CONSTANT c_variable              : INTEGER := 1; -- c_row_type, c_col_type, c_block_size_type
CONSTANT c_selectable            : INTEGER := 2; -- c_row_type, c_col_type
CONSTANT c_row_x_col             : INTEGER := 3; -- c_block_size_type
CONSTANT c_file                  : INTEGER := 4; -- c_branch_length_type
-- c_memstyle constants
CONSTANT c_distmem               : INTEGER := 0;
CONSTANT c_blockmem              : INTEGER := 1;
CONSTANT c_automatic             : INTEGER := 2;
-- c_pipe_level constants
CONSTANT c_minimum               : INTEGER := 0;
CONSTANT c_maximum               : INTEGER := 2;


-- c_architecture constants
-- For Convolutional interleaver
CONSTANT c_use_rom               : INTEGER := 0;
CONSTANT c_use_logic             : INTEGER := 1;

END sid_v5_1_comp_pkg;


PACKAGE BODY sid_v5_1_comp_pkg IS

--------------------------------------------------------------------------------
-- Return number of bits required to represent the supplied parameter
--------------------------------------------------------------------------------
FUNCTION bits_needed_to_represent(a_value : NATURAL) RETURN NATURAL IS
  VARIABLE return_value : NATURAL := 1;
BEGIN

  FOR i IN 30 DOWNTO 0 LOOP
    IF a_value >= 2**i THEN
        return_value := i+1;
        EXIT;
    END IF;
  END LOOP;

  RETURN return_value;
  
END bits_needed_to_represent;

--------------------------------------------------------------------------------
-- Return i0 if sel = FALSE, i1 if sel = TRUE
--------------------------------------------------------------------------------
FUNCTION select_integer(i0  : INTEGER;
                    i1  : INTEGER;
                    sel : BOOLEAN) RETURN INTEGER IS
BEGIN
  IF sel THEN
    RETURN i1;
  ELSE
    RETURN i0;
  END IF; -- sel
END select_integer;
  

END sid_v5_1_comp_pkg;

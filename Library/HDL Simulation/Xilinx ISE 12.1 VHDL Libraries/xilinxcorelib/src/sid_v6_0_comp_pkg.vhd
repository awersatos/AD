-- $RCSfile: sid_v6_0_comp_pkg.vhd,v $
--
--  (c) Copyright 1995-2010 Xilinx, Inc. All rights reserved.
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


-- Description: Consts/Functions for Component statement
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE sid_v6_0_comp_pkg IS

FUNCTION bits_needed_to_represent(a_value : NATURAL) RETURN NATURAL;
  
FUNCTION select_integer(i0  : INTEGER;
                    i1  : INTEGER;
                    sel : BOOLEAN) RETURN INTEGER;
  
-- Rectangular-block limits
CONSTANT abs_min_num_rows        : INTEGER := 1;
CONSTANT abs_min_num_cols        : INTEGER := 2;

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

END sid_v6_0_comp_pkg;


PACKAGE BODY sid_v6_0_comp_pkg IS

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
  

END sid_v6_0_comp_pkg;


-- $RCSfile: sid_v5_1.vhd,v $
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
--
-------------------------------------------------------------------------------
-- Behavioural Model
-------------------------------------------------------------------------------
  
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v9_0.ALL;
USE XilinxCoreLib.prims_utils_v9_0.ALL;



---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
--                                                                          ---*
--                PACKAGE sid_const_pkg_behav_v5_1                          ---*
--                                                                          ---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*


PACKAGE sid_const_pkg_behav_v5_1 IS

--Here are constants that may be used in the vhdl
--behavioral model.

-- Assign no_debug as false to enable display of debug info.
CONSTANT no_debug                : BOOLEAN := TRUE;


CONSTANT abs_max_bm_depth_vx2       : INTEGER := 1048576; -- Block mem for Vx2
CONSTANT abs_max_bm_depth_vx        : INTEGER := 262144;  -- Block mem for Vx
CONSTANT max_dm_depth_vx2           : INTEGER := 131072; -- Dist mem for Vx2
CONSTANT max_dm_depth_vx            : INTEGER := 32768;  -- Dist mem for Vx

CONSTANT min_symbol_width           : INTEGER := 1;
CONSTANT max_symbol_width           : INTEGER := 256;
CONSTANT abs_max_num_branches       : INTEGER := 256;
CONSTANT abs_min_num_branches       : INTEGER := 2;
CONSTANT min_branch_length_constant : INTEGER := 1;
CONSTANT upper_branch_length_constant : INTEGER :=
  2 * (abs_max_bm_depth_vx2 - abs_min_num_branches) /
                                      (abs_min_num_branches * (abs_min_num_branches-1));

CONSTANT abs_max_num_configurations : INTEGER := 64;
CONSTANT abs_min_num_configurations : INTEGER := 1;

-- c_family constants
CONSTANT c_virtex  : INTEGER := 0;
CONSTANT c_virtex2 : INTEGER := 1;


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
CONSTANT c_medium                : INTEGER := 1;
CONSTANT c_maximum               : INTEGER := 2;

-- c_architecture constants
-- For Convolutional interleaver
CONSTANT c_use_rom               : INTEGER := 0;
CONSTANT c_use_logic             : INTEGER := 1;


CONSTANT DEFAULT_C_TYPE          : INTEGER := c_forney_convolutional;
CONSTANT DEFAULT_MEM_INIT_PREFIX : STRING := "int_1";
CONSTANT DEFAULT_MODE            : INTEGER := c_interleaver;
CONSTANT DEFAULT_SYMBOL_WIDTH    : INTEGER := 8;
   

CONSTANT new_line : string(1 TO 1) := (1 => lf); -- for assertion reports

CONSTANT abs_min_num_rows        : INTEGER := 1;
CONSTANT abs_min_num_cols        : INTEGER := 2;

CONSTANT c_sp_ram                : INTEGER := 1;
CONSTANT c_dp_ram                : INTEGER := 2;

CONSTANT SID_CONST_PKG_BEHAV_mif_width : INTEGER := 32;

ATTRIBUTE qualified_by_project_dir : BOOLEAN; -- copy of definition in xcc.ccdir


END sid_const_pkg_behav_v5_1;

---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
--                                                                          ---*
--                PACKAGE sid_mif_pkg_behav_v5_1                            ---*
--                                                                          ---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
LIBRARY std;
USE std.textio.ALL;
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--  

-- This package contains functions to read and write Memory Initialization
-- Files into or from a memory stored as a single BIT_VECTOR

PACKAGE sid_mif_pkg_behav_v5_1 IS

  FUNCTION read_meminit_file(
                              filename: IN STRING;
                              depth   : IN POSITIVE;
                              width   : IN POSITIVE;
                              lines   : IN POSITIVE
                            ) RETURN BIT_VECTOR;
                             
END sid_mif_pkg_behav_v5_1;


PACKAGE BODY sid_mif_pkg_behav_v5_1 IS

  ------------------------------------------------------------------------------
  -- Function to read a MIF file and place the data in a BIT_VECTOR
  -- Takes parameters:
  --   filename : Name of the file from which to read data
  --   depth    : Depth of memory in words
  --   width    : Width of memory in bits
  --   lines    : Number of lines to be read from file
  --              If the file has fewer lines then only the available
  --              data is read. If lines > depth then the RETURN vector
  --              is padded with '0's.
  FUNCTION read_meminit_file(
                              filename: IN STRING;
                              depth   : IN POSITIVE;
                              width   : IN POSITIVE;
                              lines   : IN POSITIVE
                            ) RETURN BIT_VECTOR IS
--    FILE     meminitfile : TEXT IS IN filename; -- This is '87 specific
    FILE     meminitfile : TEXT IS filename; -- This works with '93 and '87
    VARIABLE bit         : INTEGER;
    VARIABLE bitline     : LINE;
    VARIABLE bitchar     : CHARACTER;
    VARIABLE bits_good   : BOOLEAN;
    VARIABLE offset      : INTEGER;
    VARIABLE total_lines : INTEGER;
    VARIABLE num_lines   : INTEGER;
    VARIABLE mem_vector  : STRING(width DOWNTO 1);
    VARIABLE return_vect : BIT_VECTOR(width*lines-1 DOWNTO 0) := (OTHERS=>'0');
  BEGIN
        IF (lines > 0 AND lines <= depth) THEN
          total_lines := lines;
        ELSE
          total_lines := depth;
        END IF;
        
        num_lines := 0;
        offset := 0;
        
        
        WHILE (NOT(ENDFILE(meminitfile)) AND (num_lines < total_lines)) LOOP
          READLINE(meminitfile, bitline);
          READ(bitline, mem_vector, bits_good);
          
          ASSERT bits_good
            REPORT "Error: problem reading memory initialization file, " & filename
            SEVERITY FAILURE;
          
          FOR bit IN 0 TO width-1 LOOP
            bitchar := mem_vector(bit+1);
            IF (bitchar = '1') THEN
              return_vect(offset+bit) := '1';
            ELSE
              return_vect(offset+bit) := '0';
            END IF;
          END LOOP; -- FOR
          
          num_lines := num_lines+1;
          offset := offset + width;
          
        END LOOP; -- WHILE

    RETURN return_vect;
    
  END read_meminit_file;
  
END sid_mif_pkg_behav_v5_1;

---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
--                                                                          ---*
--                PACKAGE sid_pkg_behav                                     ---*
--                                                                          ---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY xilinxcorelib;
USE xilinxcorelib.sid_const_pkg_behav_v5_1.ALL;
USE xilinxcorelib.sid_mif_pkg_behav_v5_1.ALL;

PACKAGE sid_pkg_behav_v5_1 IS



TYPE integer_vector IS ARRAY(natural RANGE <>) OF integer;


------------------------------------------------------------------------------
--
-- FUNCTION PROTOTYPES
--
------------------------------------------------------------------------------
FUNCTION hello(param : INTEGER)
  RETURN INTEGER;

FUNCTION get_family_int(fam : STRING) RETURN INTEGER;
  
FUNCTION get_max_block_size(max_rows              : INTEGER;
                            max_cols              : INTEGER;
                            c_block_size_constant : INTEGER;
                            c_block_size_type     : INTEGER;
                            c_block_size_width    : INTEGER) RETURN INTEGER;
  
FUNCTION get_max_dimension(dimension_type     : INTEGER;
                           dimension_constant : INTEGER;
                           dimension_width    : INTEGER;
                           selectable_vector  : integer_vector) 
    RETURN INTEGER;

FUNCTION integer_to_string(int_value : integer) RETURN string;

FUNCTION bits_needed_to_represent(a_value : natural) RETURN natural;

FUNCTION select_integer(i0  : INTEGER;
                    i1  : INTEGER;
                    sel : BOOLEAN) RETURN INTEGER;
  
FUNCTION two_comp(vect : std_logic_vector) RETURN std_logic_vector;

FUNCTION bit_vector_to_integer(bv : IN bit_vector) RETURN integer;

FUNCTION bit_vector_to_integer_vector(
  bv : IN bit_vector;
  bv_element_length : IN integer)
RETURN integer_vector;

FUNCTION check_forney_generics(
    c1mode                   : INTEGER;
    c1symbol_width           : INTEGER;
    c1num_branches           : INTEGER;
    c1branch_length_type     : INTEGER;
    c1branch_length_constant : INTEGER) RETURN BOOLEAN;

FUNCTION get_integer_vector_from_mif(really_read_mif : BOOLEAN;
                                   mif_name        : STRING;
                                   mif_depth       : INTEGER;
                                   mif_width       : INTEGER)
    RETURN integer_vector;

FUNCTION get_sum(a : integer_vector) RETURN INTEGER;

FUNCTION get_max(a : integer_vector) RETURN INTEGER;

FUNCTION get_branch_length_vector(ccmode                   : INTEGER;
                                  ccnum_branches           : INTEGER;
--                                  ccbranch_length_type     : INTEGER;
                                  ccbranch_length_constant : INTEGER)
--                                  ccbranch_length_file     : STRING)
    RETURN integer_vector;

FUNCTION calc_branch_start_vector(branch_length_vector : integer_vector)
    RETURN integer_vector;

FUNCTION calc_branch_read_start_vector(branch_length_vector : integer_vector)
    RETURN integer_vector;

FUNCTION calc_branch_end_vector(branch_length_vector : integer_vector)
    RETURN integer_vector;

FUNCTION integer_to_std_logic_vector(
  value, bitwidth : integer) RETURN std_logic_vector;
  
FUNCTION std_logic_vector_to_natural(
  in_val:IN STD_LOGIC_VECTOR) RETURN NATURAL;

FUNCTION select_val(i0  : INTEGER;
                    i1  : INTEGER;
                    sel : BOOLEAN) RETURN INTEGER;

FUNCTION calc_wss_delay(pruned        : BOOLEAN;
                      block_size_type : INTEGER;
                      col_type        : INTEGER;
                      row_type        : INTEGER) RETURN INTEGER;
                      
FUNCTION calc_xvalid_buffer_length(wss_delay         : INTEGER;
                        block_size_type : INTEGER;
                        col_type        : INTEGER;
                        row_type        : INTEGER) RETURN INTEGER;

FUNCTION get_max_bm_depth(width    : INTEGER;
                          c_family : INTEGER) RETURN INTEGER;
                        
FUNCTION get_mem_depth(required_depth : INTEGER;
                     mem_style      : INTEGER) RETURN INTEGER;

FUNCTION get_mem_depth_dp(reqd_depth : INTEGER;
                        mem_style  : INTEGER) RETURN INTEGER;

FUNCTION get_memstyle(depth    : INTEGER;
                    width    : INTEGER;
                    style    : INTEGER;
                    mem_type : INTEGER;
                    c_family : INTEGER;
                    smart    : BOOLEAN) RETURN INTEGER;

------------------------------------------------------------------------------
-- calculate fdo latency, which is a FUNCTION of the length of branch 0
--
FUNCTION calc_fdo_proc_delay(
  numbranches : INTEGER;
  branchlength0 : INTEGER) RETURN INTEGER;

FUNCTION get_max_num_branches(
    ccnum_configurations : INTEGER;
    ccnum_branches : INTEGER;
    ccmif_width : INTEGER;
    ccbranch_length_file : STRING) RETURN INTEGER;

END sid_pkg_behav_v5_1;

PACKAGE BODY sid_pkg_behav_v5_1 IS


  FUNCTION hello(param : INTEGER)
  RETURN INTEGER IS
    BEGIN
      ASSERT false
      REPORT "I'm here"
      SEVERITY NOTE;
    RETURN 1;
  END hello;
  
  
--------------------------------------------------------------------------------
--
-- Return INTEGER value to represent family
-- 0 => Virtex based, 1 => Virtex-II based
--
FUNCTION get_family_int(fam : STRING) RETURN INTEGER IS
  VARIABLE res : INTEGER;   
BEGIN
  IF(fam = "virtex" OR fam = "virtexe" OR
     fam = "spartan2"  OR fam = "spartan2e") THEN
   res := c_virtex;
  ELSE
   res := c_virtex2;
  END IF;  
  RETURN res;
END get_family_int;
   



--------------------------------------------------------------------------------
--
-- This function returns the maximum number of rows (or columns) for the 
-- rectangular block type for given values of c_x_type, c_x_constant,
-- c_x_width and selectable_x_vector, where x refers to row or col. 
-- The selectable_x_vector contains integers values corresponding to the
-- values read from a mif.
--
--------------------------------------------------------------------------------
FUNCTION get_max_dimension(dimension_type     : INTEGER;
                           dimension_constant : INTEGER;
                           dimension_width    : INTEGER;
                           selectable_vector  : integer_vector) 
RETURN INTEGER IS
  VARIABLE result : INTEGER;
BEGIN
  --
  -- Find which parameters are relevant for defining the maximum number of
  -- rows or columns
  --
  IF (dimension_type = c_constant) THEN
    result := dimension_constant;
  ELSIF (dimension_type = c_variable) THEN
    result := 2**dimension_width - 1;
  ELSIF (dimension_type = c_selectable) THEN
    result := get_max(selectable_vector);
  ELSE -- throw error
    ASSERT FALSE
      REPORT "ERROR: sid_v5_1 - get_max_dimension(): dimension_type not supported!"
      SEVERITY FAILURE;
  END IF;
  
  RETURN result;
END get_max_dimension;

--------------------------------------------------------------------------------
-- Return maximum number of symbols in a rectangular block
--
FUNCTION get_max_block_size(max_rows              : INTEGER;
                            max_cols              : INTEGER;
                            c_block_size_constant : INTEGER;
                            c_block_size_type     : INTEGER;
                            c_block_size_width    : INTEGER) RETURN INTEGER IS
  VARIABLE return_val : INTEGER := 0;
BEGIN
  IF c_block_size_type = c_row_x_col THEN
    return_val := max_rows * max_cols;
  ELSIF c_block_size_type = c_constant THEN
    return_val := c_block_size_constant;
  ELSIF c_block_size_type = c_variable THEN
    return_val := 2**c_block_size_width-1;
  ELSE
    ASSERT FALSE
      REPORT "ERROR: sid_v5_1 - get_max_block_size() Invalid block_size." & new_line
      SEVERITY FAILURE;
  END IF;
  
  RETURN return_val;
END get_max_block_size;



--------------------------------------------------------------------------------
-- Convert INTEGER to STRING
--------------------------------------------------------------------------------
FUNCTION integer_to_string(int_value : INTEGER) RETURN STRING IS

  VARIABLE digit        : INTEGER;
  VARIABLE value        : INTEGER;
  VARIABLE length       : INTEGER := 0;
  VARIABLE posn         : INTEGER;
  VARIABLE start_length : INTEGER;
  CONSTANT str          : STRING(1 TO 10) := "0123456789";
  VARIABLE ret_value    : STRING(1 TO 11);

BEGIN

  IF int_value < 0 THEN
    -- Largest possible negative number
    IF int_value < -2147483647 THEN
      RETURN ("less than VHDL minimum INTEGER value");
    ELSE
      value := -1 * int_value;
      start_length := 1;
      ret_value(1) := '-';
    END IF;
  ELSE
    value := int_value;
    start_length := 0;
  END IF;

  IF (value = 0) THEN
    RETURN "0";
  ELSIF (value < 10) THEN
    length := 1 + start_length;
  ELSIF (value < 100) THEN
    length := 2 + start_length;
  ELSIF (value < 1000) THEN
    length := 3 + start_length;
  ELSIF (value < 10000) THEN
    length := 4 + start_length;
  ELSIF (value < 100000) THEN
    length := 5 + start_length;
  ELSIF (value < 1000000) THEN
    length := 6 + start_length;
  ELSIF (value < 10000000) THEN
    length := 7 + start_length;
  ELSIF (value < 100000000) THEN
    length := 8 + start_length;
  ELSIF (value < 1000000000) THEN
    length := 9 + start_length;
  ELSE
    length := 10 + start_length;
  END IF;

  IF (length > 0) THEN -- Required because Metamor bombs without it
    posn := length;
    WHILE (value /= 0) LOOP
    digit := value MOD 10;
    ret_value(posn) := str(digit+1);
    value := value/10;
    posn := posn - 1;
    END LOOP;
  END IF;

  RETURN ret_value(1 TO length);

END integer_to_string;

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
  

------------------------------------------------------------------------------
-- Gets the maximum value from an array of integers
------------------------------------------------------------------------------
FUNCTION get_max(a : integer_vector) RETURN INTEGER IS
  VARIABLE max : INTEGER;
BEGIN
  max := INTEGER'LOW;
  FOR i IN a'LOW TO a'HIGH LOOP
    IF a(i) > max THEN
      max := a(i);
    END IF;
  END LOOP;
  RETURN max;
END get_max;

--------------------------------------------------------------------------------
-- Return 2's complement of input vector
--------------------------------------------------------------------------------
FUNCTION two_comp(vect : STD_LOGIC_VECTOR) RETURN std_logic_vector IS
  VARIABLE local_vect : STD_LOGIC_VECTOR(vect'HIGH DOWNTO 0);
  VARIABLE toggle     : INTEGER := 0;
BEGIN

  FOR i IN 0 TO vect'HIGH LOOP
    IF (toggle = 1) THEN
      IF (vect(i) = '0') THEN
        local_vect(i) := '1';
      ELSE
        local_vect(i) := '0';
      END IF;
    ELSE
      local_vect(i) := vect(i);
      IF (vect(i) = '1') THEN
        toggle := 1;
      END IF;
    END IF;
  END LOOP;

  RETURN local_vect;
END two_comp;


  ------------------------------------------------------------------------------
  --
  -- This FUNCTION checks the values entered for the forney_convolutional
  -- core's GENERICs
  --
  ------------------------------------------------------------------------------
  FUNCTION check_forney_generics(
    c1mode                   : INTEGER;
    c1symbol_width           : INTEGER;
    c1num_branches           : INTEGER;
    c1branch_length_type     : INTEGER;
    c1branch_length_constant : INTEGER) RETURN BOOLEAN IS

  BEGIN
    ASSERT (c1mode = c_interleaver OR c1mode = c_deinterleaver)
      REPORT "ERROR: sid_v5_1 - c_mode must be either " &
             integer_to_string(c_interleaver) & " or " &
             integer_to_string(c_deinterleaver) & new_line
      SEVERITY FAILURE;
      
    ASSERT (c1symbol_width >= min_symbol_width AND
            c1symbol_width <= max_symbol_width)
      REPORT "ERROR: sid_v5_1 - c_symbol_width must be in range " &
             integer_to_string(min_symbol_width) & " to " &
             integer_to_string(max_symbol_width) & new_line
      SEVERITY FAILURE;
    
    ASSERT (c1num_branches >= abs_min_num_branches AND
            c1num_branches <= abs_max_num_branches)
      REPORT "ERROR: sid_v5_1 - c_num_branches must be in range " &
             integer_to_string(abs_min_num_branches) & " to " &
             integer_to_string(abs_max_num_branches) & new_line
      SEVERITY FAILURE;
      
    ASSERT (c1branch_length_type=c_constant OR c1branch_length_type=c_file)
      REPORT "ERROR: c_branch_length_type = " &
             integer_to_string(c1branch_length_type) & " is not supported."
      SEVERITY FAILURE;
      
    ASSERT no_debug
      REPORT new_line &
             "upper_branch_length_constant = " & 
             integer_to_string(upper_branch_length_constant) & new_line
      SEVERITY NOTE;

    ASSERT (c1branch_length_constant >= min_branch_length_constant AND
            c1branch_length_constant <= upper_branch_length_constant)
      REPORT "ERROR: sid_v5_1 - c_branch_length_constant must be in range " &
             integer_to_string(min_branch_length_constant) & " to " &
             integer_to_string(upper_branch_length_constant) & new_line
      SEVERITY FAILURE;
             
    RETURN TRUE;
  END check_forney_generics;

--------------------------------------------------------------------------------
-- Convert BIT_VECTOR to INTEGER
-- BIT_VECTOR must have a descending range and be in 2's complement notation
--------------------------------------------------------------------------------
FUNCTION bit_vector_to_integer(
  bv : IN bit_vector) 
RETURN integer IS
  VARIABLE found_msb : boolean := false;
  VARIABLE msb : integer := 0;
  VARIABLE unsigned_result : integer := 0;
BEGIN
  IF bv'length > 32 THEN
    ASSERT false
    REPORT "bit_vector_to_integer FUNCTION doesn't support bv_element_length > 32"
    SEVERITY failure;
  END IF;
  found_msb := false;
  FOR i IN bv'RANGE LOOP
    IF found_msb = true THEN
      unsigned_result := unsigned_result * 2 + bit'pos(bv(i));
      msb := msb*2;
    ELSE 
      IF bit'pos(bv(i)) = 1 THEN
        msb := -1;
      END IF;
      found_msb := true;
    END IF;
  END LOOP;
  RETURN msb + unsigned_result;
END bit_vector_to_integer;

  --------------------------------------------------------------------------------
  --
  -- convert bit_vector to integer_vector
  --
  --------------------------------------------------------------------------------
  FUNCTION bit_vector_to_integer_vector(
    bv : IN bit_vector;
    bv_element_length : IN integer)
  RETURN integer_vector IS
    CONSTANT bv_length : integer := bv'length;
    CONSTANT iv_length : integer := bv_length/bv_element_length;
    
    CONSTANT num_bits : natural := iv_length*bv_element_length;
    VARIABLE bv_element : bit_vector(bv_element_length - 1 DOWNTO 0) := (OTHERS => '0');
    VARIABLE result : integer_vector(0 TO iv_length - 1);
  BEGIN
    IF bv_element_length > 32 THEN
      ASSERT false
      REPORT "bit_vector_to_integer_vector FUNCTION doesn't support bv_element_length > 32"
      SEVERITY failure;
    END IF;
    FOR ai IN 0 TO (iv_length - 1) LOOP -- ai = address index
      -- build up element bit_vector
      FOR bi IN (bv_element_length - 1) DOWNTO 0 LOOP
        bv_element(bi) := bv(ai*bv_element_length + bi); 
      END LOOP; -- bi
      result(ai) := bit_vector_to_integer(bv_element);
    END LOOP; -- ai
    RETURN result;
  END bit_vector_to_integer_vector;

  FUNCTION get_integer_vector_from_mif(
    really_read_mif : BOOLEAN;
    mif_name : STRING;
    mif_depth : INTEGER;
    mif_width : INTEGER)
  RETURN integer_vector IS
    VARIABLE bv : bit_vector((mif_depth*mif_width - 1) DOWNTO 0);
    VARIABLE iv : integer_vector(0 TO (mif_depth - 1));
  BEGIN
    IF (really_read_mif) THEN
      bv := read_meminit_file(mif_name, mif_depth, mif_width, mif_depth);
      iv := bit_vector_to_integer_vector(bv, mif_width);
    END IF;
    RETURN iv;
  END get_integer_vector_from_mif;
  
  --------------------------------------------------------------------------------
  -- Gets the sum of an array of integers
  --------------------------------------------------------------------------------
  FUNCTION get_sum(a : integer_vector) RETURN INTEGER IS
    VARIABLE sum : INTEGER;
  BEGIN
    sum := 0;
    FOR i IN a'RANGE LOOP
      sum := sum + a(i);
    END LOOP;
    RETURN sum;
  END get_sum;

  --------------------------------------------------------------------------------
  FUNCTION get_branch_length_vector(
    ccmode : INTEGER;
    ccnum_branches : INTEGER;

    ccbranch_length_constant : INTEGER)

  RETURN integer_vector IS
    VARIABLE result : INTEGER_VECTOR(0 TO (ccnum_branches - 1)); 
    -- all mif files shall have mif_width bits per line

  BEGIN

    IF ccmode = c_interleaver THEN
      FOR bi IN 0 TO ccnum_branches - 1 LOOP
        --
        -- the extra 1 in the following equation takes account of the 
        -- extra level of pipelining added to each branch so that
        -- location zero can be used for the first branch.
        --
        result(bi) := bi*ccbranch_length_constant + 1;
      END LOOP; -- bit
    ELSIF ccmode = c_deinterleaver THEN
      FOR bi IN 0 TO ccnum_branches - 1 LOOP
        result(bi) := (ccnum_branches - 1 - bi)*ccbranch_length_constant + 1;
      END LOOP; -- bit
    ELSE -- catch errant ccmode values
      ASSERT false
      REPORT "c_mode = " & integer_to_string(ccmode) & " is not supported!"
      SEVERITY failure;
    END IF;

    RETURN result;
   END get_branch_length_vector;

   --------------------------------------------------------------------------------
   FUNCTION calc_branch_start_vector(
     branch_length_vector :  integer_vector)
   RETURN integer_vector IS
     VARIABLE result : integer_vector(0 TO branch_length_vector'high); 
   BEGIN
     result(0):= 0;
     FOR i IN 0 TO branch_length_vector'high - 1 LOOP
       result(i+1) := result(i) + branch_length_vector(i);
     END LOOP;
     RETURN result;
   END calc_branch_start_vector;
 
   --------------------------------------------------------------------------------
   FUNCTION calc_branch_end_vector(
     branch_length_vector :  integer_vector)
   RETURN integer_vector IS
     VARIABLE result : integer_vector(0 TO branch_length_vector'high); 
   BEGIN
     result(0):= branch_length_vector(0)-1;
     FOR i IN 0 TO branch_length_vector'high - 1 LOOP
       result(i+1) := result(i) + branch_length_vector(i+1);
     END LOOP;
     RETURN result;
   END calc_branch_end_vector;
 
   --------------------------------------------------------------------------------
   FUNCTION calc_branch_read_start_vector(
     branch_length_vector :  integer_vector)
   RETURN integer_vector IS
     VARIABLE result : integer_vector(0 TO branch_length_vector'high); 
     VARIABLE branch_start_vector : integer_vector(0 TO branch_length_vector'high); 
   BEGIN
     branch_start_vector(0):= 0;
     FOR i IN 0 TO branch_length_vector'high - 1 LOOP
       branch_start_vector(i+1) := branch_start_vector(i) + branch_length_vector(i);
     END LOOP;
     FOR i IN 0 TO branch_length_vector'high LOOP
       IF branch_length_vector(i) = 1 THEN
          result(i):= branch_start_vector(i);
       ELSE
          result(i):= branch_start_vector(i) + 1;
       END IF;
     END LOOP;
     RETURN result;
   END calc_branch_read_start_vector;
 
   --------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Convert INTEGER to a STD_LOGIC_VECTOR
--------------------------------------------------------------------------------
FUNCTION integer_to_std_logic_vector(value, bitwidth : INTEGER)
  RETURN STD_LOGIC_VECTOR IS

  VARIABLE running_value  : INTEGER := value;
  VARIABLE running_result : STD_LOGIC_VECTOR(bitwidth-1 DOWNTO 0);
BEGIN

  IF (value < 0) THEN
    running_value := -1 * value;
  END IF;

  FOR i IN 0 TO bitwidth-1 LOOP

    IF running_value MOD 2 = 0 THEN
      running_result(i) := '0';
    ELSE
      running_result(i) := '1';
    END IF;
      running_value := running_value/2;
  END LOOP;

  IF (value < 0) THEN -- find the 2s complement
    RETURN two_comp(running_result);
  ELSE
    RETURN running_result;
  END IF;

END integer_to_std_logic_vector;

--------------------------------------------------------------------------------
-- Convert STD_LOGIC_VECTOR to NATURAL
--------------------------------------------------------------------------------
FUNCTION std_logic_vector_to_natural(in_val:IN STD_LOGIC_VECTOR) RETURN NATURAL IS
    VARIABLE result  : NATURAL := 0;
    VARIABLE failure : BOOLEAN := FALSE;
BEGIN
    FOR i IN in_val'RANGE LOOP
        result := result * 2;

        IF (in_val(i) = '1' OR in_val(i) = 'H') THEN
            result := result + 1;
        ELSIF (in_val(i) /= '0' AND in_val(i) /= 'L') THEN
            failure   := TRUE;
        END IF;
    END LOOP;

    IF failure THEN
            ASSERT FALSE
            REPORT "ERROR: std_logic_vector_to_natural: There is a non-numeric bit in the argument."&
                   " It has been converted to 0."
            SEVERITY WARNING;
    END IF;

    RETURN result;
END std_logic_vector_to_natural;

   --------------------------------------------------------------------------------
   --
   -- calculate the variable part of the delay for rectangular block type
   --
   -- Function identical to that used in the structural code.
   --------------------------------------------------------------------------------
   FUNCTION calc_wss_delay(pruned          : BOOLEAN;
                           block_size_type : INTEGER;
                           col_type        : INTEGER;
                           row_type        : INTEGER) RETURN INTEGER IS
     VARIABLE wss_delay_val : INTEGER;
   BEGIN
     IF NOT(pruned) OR block_size_type = c_constant THEN
       wss_delay_val := 1;
     ELSIF col_type = c_constant AND row_type = c_constant THEN
       wss_delay_val := 3;
     ELSE
       wss_delay_val := 6;
     END IF;
     RETURN wss_delay_val;
   END calc_wss_delay;


   --------------------------------------------------------------------------------
   --
   -- Function to calculate the (row_valid etc) buffer length
   --------------------------------------------------------------------------------
   FUNCTION calc_xvalid_buffer_length(wss_delay         : INTEGER;
                             block_size_type : INTEGER;
                             col_type        : INTEGER;
                             row_type        : INTEGER) RETURN INTEGER IS
                             
     VARIABLE valid_delay_val : INTEGER;
   BEGIN

     valid_delay_val := wss_delay+1;
   
     IF block_size_type = c_row_x_col THEN
   
       IF (row_type = c_selectable OR col_type = c_selectable) THEN
         -- Possible 2 extra cycles required due to delay line on
         -- row_x_col_block_size enable in rfd generation circuit
         valid_delay_val := valid_delay_val+2;
       END IF;
         
     END IF; -- c_block_size_type
     
     RETURN valid_delay_val;
   END calc_xvalid_buffer_length;

--------------------------------------------------------------------------------
FUNCTION get_mem_depth(required_depth : INTEGER;
                       mem_style      : INTEGER) RETURN INTEGER IS
  VARIABLE extra      : NATURAL;
  VARIABLE addr_width : NATURAL;
  VARIABLE result     : INTEGER := 0;
BEGIN
  IF mem_style = c_distmem THEN
    extra := required_depth MOD 16;        
    IF (extra = 0) THEN
      result := required_depth;
    ELSE
      result := (required_depth + 16 - extra);
    END IF;
  ELSIF mem_style = c_blockmem THEN
    -- block mems must be 16, 32, 64, 128, 256 or n * 256 deep
    IF required_depth <= 16 THEN
      result := 16;
    ELSIF required_depth <= 256 THEN
      result := 2**(bits_needed_to_represent(required_depth-1));
    ELSE
      result := 256 + (256 * ((required_depth-1)/256));
    END IF; -- required_depth
  END IF; -- mem_style
  
  RETURN result;
END get_mem_depth;

--------------------------------------------------------------------------------
-- 
-- Dual-port block memory must be a multiple of 16 for dist mem and 256
-- for block mem.
--
--------------------------------------------------------------------------------
FUNCTION get_mem_depth_dp(reqd_depth : INTEGER;
                          mem_style  : INTEGER) RETURN INTEGER IS
  VARIABLE extra  : NATURAL;
  VARIABLE result : INTEGER := 0;
BEGIN
  IF mem_style = c_distmem THEN
    extra := reqd_depth MOD 16;        
    IF (extra = 0) THEN
      result := reqd_depth;
    ELSE
      result := (reqd_depth + 16 - extra);
    END IF;
  ELSIF mem_style = c_blockmem THEN
    extra := reqd_depth MOD 256;
    IF (extra = 0) THEN
      result := reqd_depth;
    ELSE
      result := (reqd_depth + 256 - extra);
    END IF;
  END IF; -- mem_style
  
  RETURN result;
END get_mem_depth_dp;

--------------------------------------------------------------------------------
-- Return maximum depth of Virtex block memory for a given width
-- These numbers were obtained from the block mem GUIs.
--------------------------------------------------------------------------------
FUNCTION get_max_bm_depth(width    : INTEGER;
                          c_family : INTEGER) RETURN INTEGER IS
  VARIABLE max_depth : INTEGER;
BEGIN
  IF width < 4 THEN
    max_depth := 262144;
  ELSIF width < 7 THEN
    max_depth := 131072;
  ELSIF width < 13 THEN
    max_depth := 65536;
  ELSIF width < 25 THEN
    max_depth := 32768;
  ELSIF width < 49 THEN
    max_depth := 16384;
  ELSIF width < 97 THEN
    max_depth := 8192;
  ELSIF width < 193 THEN
    max_depth := 4096;
  ELSE
    max_depth := 2048;
  END IF;
  
  IF c_family = c_virtex THEN
    RETURN max_depth;
  ELSE
    RETURN max_depth * 4; -- Virtex-II
  END IF;
  
END get_max_bm_depth;

--------------------------------------------------------------------------------
FUNCTION get_memstyle(depth    : INTEGER;
                      width    : INTEGER;
                      style    : INTEGER;
                      mem_type : INTEGER;
                      c_family : INTEGER;
                      smart    : BOOLEAN) RETURN INTEGER IS
  VARIABLE max_bm_depth           : INTEGER;                    
  VARIABLE mem_size               : INTEGER;
  VARIABLE result                 : INTEGER := c_distmem;
  VARIABLE actual_block_mem_depth : INTEGER;
  VARIABLE actual_dist_mem_depth  : INTEGER;
BEGIN
  max_bm_depth := get_max_bm_depth(width, c_family);
  
  -- Round up to actual depth required for each memory style
  actual_dist_mem_depth  := get_mem_depth(depth, c_distmem);
  actual_block_mem_depth := get_mem_depth(depth, c_blockmem);
  
  -- Check depth doesn't exceed limits
  IF (c_family = c_virtex AND
      actual_dist_mem_depth > max_dm_depth_vx AND
      actual_block_mem_depth <= max_bm_depth) OR
     (c_family /= c_virtex AND
      actual_dist_mem_depth > max_dm_depth_vx2 AND
      actual_block_mem_depth <= max_bm_depth) THEN
    result := c_blockmem;
      
  ELSIF (c_family = c_virtex AND
         actual_block_mem_depth > max_bm_depth AND
         actual_dist_mem_depth <= max_dm_depth_vx) OR
        (c_family /= c_virtex AND
         actual_block_mem_depth > max_bm_depth AND
         actual_dist_mem_depth <= max_dm_depth_vx2) THEN
                  
    result := c_distmem;
      
  ELSE
    -- If depth didn't exceed max limits then determine style to use based
    -- on size and style parameter
    mem_size := actual_dist_mem_depth * width;
    -- Return value depends on memory size
    IF mem_type = c_dp_ram THEN
      mem_size := mem_size * 2; -- Only actually true for dist mem
    END IF;
 
    IF style = c_distmem THEN
      result := c_distmem;
      
    ELSIF style = c_blockmem THEN
      IF smart THEN
        IF mem_size <= 64 THEN
          result := c_distmem;
        ELSE
          result := c_blockmem;
        END IF; -- mem_size
      ELSE
        result := c_blockmem;
      END IF; -- smart
      
    ELSIF style = c_automatic THEN
      IF mem_size <= 512 THEN
        result := c_distmem;
      ELSE
        result := c_blockmem;
      END IF;
    END IF; -- style
    
  END IF; -- c_family
  RETURN result;
END get_memstyle;


--------------------------------------------------------------------------------
-- Return i0 if sel = FALSE, i1 if sel = TRUE
--------------------------------------------------------------------------------
FUNCTION select_val(i0 : INTEGER; i1 : INTEGER; sel : BOOLEAN) RETURN INTEGER IS
BEGIN
  IF sel THEN
    RETURN i1;
  ELSE
    RETURN i0;
  END IF; -- sel
END select_val;


------------------------------------------------------------------------------
-- calculate fdo latency, which is a FUNCTION of the length of branch 0
--
FUNCTION calc_fdo_proc_delay(
  numbranches : INTEGER;
  branchlength0 : INTEGER)
RETURN INTEGER IS

  VARIABLE result : INTEGER:=999;
  BEGIN
    IF (branchlength0-1) = 0 THEN
      result := 1;
    ELSE
      result := (branchlength0-1) * numbranches
        + 1;--(The +1 is added for v3.1 because process fdo_proc is tidied up)  
    END IF;
    RETURN result;
  END calc_fdo_proc_delay;

--------------------------------------------------------------------------------
--Function to calculate the maximum number of branches
--------------------------------------------------------------------------------
FUNCTION get_max_num_branches(
    ccnum_configurations : INTEGER;
    ccnum_branches : INTEGER;
    ccmif_width : INTEGER;
    ccbranch_length_file : STRING) RETURN INTEGER IS

  VARIABLE num_branches_vector : INTEGER_VECTOR(0 TO ccnum_configurations-1) := (OTHERS=>0);
  VARIABLE result : INTEGER := 0;

BEGIN


    IF ccnum_configurations=1 THEN
          result := ccnum_branches;
    ELSIF ccnum_configurations>1 THEN
          --The first ccnum_configurations entries are the number of branches vector.
          --If ccnum_configurations>1 and this constant is used to select
          --the number of branches, depending on the value on the config_sel port.
          --If ccnum_configurations>1 and ccbranch_length_type=c_file, this constant is
          --also used to find the total number of mif file values.
          num_branches_vector :=  get_integer_vector_from_mif(TRUE,
                                                   ccbranch_length_file,
                                                   ccnum_configurations,
                                                   ccmif_width);

          result := 0;
          FOR cfg IN 0 TO ccnum_configurations-1 LOOP
              IF num_branches_vector(cfg) > result THEN
                  result := num_branches_vector(cfg);
              END IF;    
          END LOOP;
    ELSE --ccnum_configurations<1 THEN
      --ERROR!    
      ASSERT false
      REPORT "c_num_configurations = " & integer_to_string(ccnum_configurations) & " is not supported!"
      SEVERITY failure;
    END IF;
    RETURN result;
END get_max_num_branches;


                                                                    

END sid_pkg_behav_v5_1;




---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
--                                                                          ---*
--                FORNEY INTERLEAVER / DEINTERLEAVER                        ---*
--                                                                          ---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY std;
USE std.textio.ALL;

LIBRARY xilinxcorelib;
USE xilinxcorelib.sid_const_pkg_behav_v5_1.ALL;
USE xilinxcorelib.sid_pkg_behav_v5_1.ALL;
USE xilinxcorelib.sid_mif_pkg_behav_v5_1.ALL;


ENTITY sid_bhv_forney_v5_1 IS
GENERIC (
  c_mode                 : INTEGER;
  c_symbol_width         : INTEGER;
  -- Forney specific generics
  c_num_branches         : INTEGER;
  c_branch_length_type   : INTEGER;
  c_branch_length_constant : INTEGER;
  c_branch_length_file   : STRING  := "";
  c_has_fdo              : INTEGER;
  c_has_ndo              : INTEGER;
  -- Implementation generics
  c_pipe_level           : INTEGER;
  -- Optional pin generics
  c_has_ce               : INTEGER;
  c_has_sclr             : INTEGER;
  c_has_aclr             : INTEGER;
  c_has_rdy              : INTEGER;
  c_has_rffd             : INTEGER;
  c_has_rfd              : INTEGER;
  --New generics for v4_0
  c_external_ram         : INTEGER;
  c_ext_addr_width       : INTEGER;
  c_num_configurations   : INTEGER);
PORT (
    -- Mandatory pins
  clk              : IN STD_LOGIC;
  fd               : IN STD_LOGIC;
  din              : IN STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);
  -- Optional input pins
  nd               : IN STD_LOGIC := '1';
  ce               : IN STD_LOGIC := '1';
  sclr             : IN STD_LOGIC := '0';
  aclr             : IN STD_LOGIC := '0';
  -- Mandatory output pins
  dout             : OUT STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);
  -- optional output pins
  rdy              : OUT STD_LOGIC;
  rffd             : OUT STD_LOGIC;
  rfd              : OUT STD_LOGIC;
  fdo              : OUT STD_LOGIC;
  ndo              : OUT STD_LOGIC;
  --New ports for v4_0
  new_config       : IN STD_LOGIC := '0';
  config_sel       : IN STD_LOGIC_VECTOR(
                    select_val(
                    bits_needed_to_represent(c_num_configurations-1),
                    1, c_num_configurations <= 1) -1 DOWNTO 0);
  rd_data          : IN STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0); -- Read data from external RAM
  rd_en            : OUT STD_LOGIC;
  wr_en            : OUT STD_LOGIC;
  rd_addr          : OUT STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0);
  wr_addr          : OUT STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0);
  wr_data          : OUT STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0)); -- Write data to external RAM
END sid_bhv_forney_v5_1;


ARCHITECTURE behavioral OF sid_bhv_forney_v5_1 IS


  CONSTANT cc_type       : INTEGER := c_forney_convolutional;


  CONSTANT max_num_branches : INTEGER :=
              get_max_num_branches(c_num_configurations, c_num_branches, SID_CONST_PKG_BEHAV_mif_width, c_branch_length_file);

  SUBTYPE BVECTOR IS INTEGER_VECTOR(0 TO max_num_branches-1);

  TYPE BLV_REC IS RECORD
       fld_num_branches : NATURAL RANGE 0 TO max_num_branches;
       fld_bl_vect : BVECTOR;
       fld_branch_start_vector : BVECTOR;
       fld_branch_end_vector : BVECTOR;
       fld_branch_read_start_vector : BVECTOR;
       fld_fdo_proc_delay : INTEGER;
  END RECORD;

  TYPE BVECTOR_ARRAY IS ARRAY(natural RANGE <>) OF BLV_REC;


  --------------------------------------------------------------------------------
  --
  -- convert integer_vector to bvector (vector of branch lengths)
  --
  --------------------------------------------------------------------------------
  FUNCTION integer_vector_to_bvector(
    iv : IN integer_vector)
  RETURN BVECTOR IS
    VARIABLE result : BVECTOR;
  BEGIN
    FOR ai IN iv'low TO iv'high LOOP -- ai = address index
      result(ai) := iv(ai);
    END LOOP; -- ai
    RETURN result;
  END integer_vector_to_bvector;

  --------------------------------------------------------------------------------
  --Function to extract the array of selectable branch_vectors from a mif file vector
  --------------------------------------------------------------------------------
--   TYPE BLV_REC IS RECORD
--        num_branches : NATURAL RANGE 0 TO max_num_branches;
--        bl_vect : BVECTOR;
--        branch_start_vector : BVECTOR;
--        branch_end_vector : BVECTOR;
--        branch_read_start_vector : BVECTOR;
--        fdo_proc_delay : INTEGER;
--   END RECORD;


  FUNCTION get_forney_params(
      ccnum_configurations : INTEGER;
      ccmode : INTEGER;
      ccnum_branches : INTEGER;
      ccbranch_length_constant : INTEGER;
      ccbranch_length_type : INTEGER;
      ccbranch_length_file : STRING) RETURN BVECTOR_ARRAY IS


    CONSTANT max_mif_file_size  : INTEGER := 
          select_val(ccnum_configurations*(1+max_num_branches),
                     ccnum_branches,
                     ccnum_configurations=1);

    VARIABLE fileptr      : INTEGER:=0;
    VARIABLE c2_num_branches_array : INTEGER_VECTOR(0 TO ccnum_configurations-1) := (OTHERS=>0);
    VARIABLE num_total_mif_values : INTEGER := 0;
    VARIABLE num_branches : INTEGER := 0;
    VARIABLE branch_length_constant : INTEGER := 0;
    VARIABLE total_mif_file_vector : INTEGER_VECTOR(0 TO max_mif_file_size-1) := (OTHERS=>0);
    VARIABLE blvi : INTEGER_VECTOR(0 TO max_num_branches-1) := (OTHERS=>0);
    VARIABLE blv : BVECTOR := (OTHERS=>0);
    VARIABLE result : BVECTOR_ARRAY(0 TO ccnum_configurations-1);

  BEGIN

      IF ccnum_configurations=1 THEN
            result(0).fld_num_branches := ccnum_branches;
            IF ccbranch_length_type=c_constant THEN
                blvi := get_branch_length_vector(ccmode,ccnum_branches,ccbranch_length_constant);
                blv :=  integer_vector_to_bvector(blvi);
            ELSE
                blvi :=  get_integer_vector_from_mif(TRUE,
                              ccbranch_length_file,
                              ccnum_branches,
                              SID_CONST_PKG_BEHAV_mif_width);
                blv :=  integer_vector_to_bvector(blvi);
                FOR bi IN 0 TO ccnum_branches - 1 LOOP
                   -- always add one to each branch length vector element.
                   -- doing this ensures that zero length branches are automatically
                   -- supported without affecting latency.
                   blv(bi) := blv(bi) + 1;
                END LOOP; -- bi
            END IF;
            result(0).fld_bl_vect := blv;
            result(0).fld_fdo_proc_delay :=  calc_fdo_proc_delay(ccnum_branches,blv(0));
            
      ELSIF ccnum_configurations>1 THEN
            --The first ccnum_configurations entries are the number of branches vector.
            --If ccnum_configurations>1 and this constant is used to select
            --the number of branches, depending on the value on the config_sel port.
            --If ccnum_configurations>1 and ccbranch_length_type=c_file, this constant is
            --also used to find the total number of mif file values.
            c2_num_branches_array :=  get_integer_vector_from_mif(TRUE,
                                                     ccbranch_length_file,
                                                     ccnum_configurations,
                                                     SID_CONST_PKG_BEHAV_mif_width);

            IF ccbranch_length_type=c_constant THEN
               num_total_mif_values := 2*ccnum_configurations;
            ELSE
               num_total_mif_values := ccnum_configurations+get_sum(c2_num_branches_array);
            END IF;

            --Now read the whole mif_file
            total_mif_file_vector(0 TO num_total_mif_values-1)
                                  :=  get_integer_vector_from_mif(TRUE,
                                                                 ccbranch_length_file,
                                                                 num_total_mif_values,
                                                                 SID_CONST_PKG_BEHAV_mif_width);

            fileptr := ccnum_configurations;  --needed for parsing branch length vectors
            FOR cfg IN 0 TO ccnum_configurations-1 LOOP
                num_branches := total_mif_file_vector(cfg);
                result(cfg).fld_num_branches := num_branches;
                IF ccbranch_length_type=c_constant THEN
                      branch_length_constant := total_mif_file_vector(cfg+ccnum_configurations);
                      blvi(0 TO num_branches-1) := get_branch_length_vector
                                          (ccmode,
                                          num_branches,
                                          branch_length_constant);
                      blv :=  integer_vector_to_bvector(blvi);
                ELSE
                      --extract a branch_length_vector from the input vector
                      FOR i IN 0 TO num_branches-1 LOOP
                        blvi(i) := total_mif_file_vector(fileptr)
                                     +1; --Add 1 to each element!
                        fileptr := fileptr+1;
                      END LOOP;
                      blv :=  integer_vector_to_bvector(blvi);
                END IF;
                --store the extracted single branch_length_vector in the array
                result(cfg).fld_bl_vect := blv;  
                result(cfg).fld_fdo_proc_delay :=  calc_fdo_proc_delay(num_branches,blv(0));
            END LOOP;
      ELSE --ccnum_configurations>1 THEN
            --ERROR!    
            ASSERT false
            REPORT "c_num_configurations = " & integer_to_string(ccnum_configurations) & " is not supported!"
            SEVERITY failure;
      END IF;

      FOR cfg IN 0 TO ccnum_configurations-1 LOOP
            blvi := calc_branch_start_vector(result(cfg).fld_bl_vect);
            result(cfg).fld_branch_start_vector := integer_vector_to_bvector(blvi);

            blvi := calc_branch_read_start_vector(result(cfg).fld_bl_vect);
            result(cfg).fld_branch_read_start_vector := integer_vector_to_bvector(blvi);

            blvi := calc_branch_end_vector(result(cfg).fld_bl_vect);
            result(cfg).fld_branch_end_vector := integer_vector_to_bvector(blvi);
      END LOOP;

      RETURN result;
  END get_forney_params;


--------------------------------------------------------------------------------
  -- get the largest value in the branch length vector.
  -- ie the length of the longest branch +1.
  --
  FUNCTION get_max_blv_value(
    num_configurations : INTEGER;
    fparams : BVECTOR_ARRAY)
  RETURN INTEGER IS
    VARIABLE result : INTEGER; 
  BEGIN
    result := 0;
    FOR cfg IN 0 TO num_configurations-1 LOOP
        FOR this_branch IN 0 TO fparams(cfg).fld_num_branches - 1 LOOP
            IF fparams(cfg).fld_bl_vect(this_branch) > result THEN
                result := fparams(cfg).fld_bl_vect(this_branch);
            END IF;    
        END LOOP;
    END LOOP;
    RETURN result;
  END get_max_blv_value;

--------------------------------------------------------------------------------
  FUNCTION get_max_fdo_proc_delay(
    num_configurations : INTEGER;
    fparams : BVECTOR_ARRAY)
  RETURN INTEGER IS
    VARIABLE result : INTEGER; 
  BEGIN
    result := 0;
    FOR cfg IN 0 TO num_configurations-1 LOOP
        IF fparams(cfg).fld_fdo_proc_delay > result THEN
            result := fparams(cfg).fld_fdo_proc_delay;
        END IF;    
    END LOOP;
    RETURN result;
  END get_max_fdo_proc_delay;

--------------------------------------------------------------------------------
  --Extract an array of c_num_configurations branch length vectors from the total mif file vector
  CONSTANT forney_params : BVECTOR_ARRAY(0 TO c_num_configurations-1)
                            := get_forney_params(c_num_configurations,
                                                 c_mode,
                                                 c_num_branches,
                                                 c_branch_length_constant,
                                                 c_branch_length_type,
                                                 c_branch_length_file);

  --CONSTANT hi :INTEGER := hello(1); --tbd: For debugging
  CONSTANT max_blv_value : INTEGER :=
                get_max_blv_value(c_num_configurations, forney_params);

  CONSTANT max_fdo_proc_delay : INTEGER :=
                get_max_fdo_proc_delay(c_num_configurations, forney_params);

--Data types;

  SUBTYPE SID_SYMBOL IS STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);

  SUBTYPE SID_FORNEY_SWITCH IS INTEGER RANGE -1 TO max_num_branches-1;

  CONSTANT do_check_generics : BOOLEAN :=
    check_forney_generics(c_mode, c_symbol_width, c_num_branches,
                          c_branch_length_type, c_branch_length_constant);

  CONSTANT ndo_delay : INTEGER := select_val(3,4, c_pipe_level=c_maximum);

  CONSTANT output_delay : TIME := 1 ns;

  TYPE DATABUFFER IS ARRAY (NATURAL RANGE <>) OF SID_SYMBOL;



  TYPE MEM IS ARRAY (0 TO (2**c_ext_addr_width)-1) OF SID_SYMBOL;

  ------------------------------------------------------------------------------
  SIGNAL   ce_int            : STD_LOGIC;
  SIGNAL   sclr_int          : STD_LOGIC;
  SIGNAL   power             : STD_LOGIC :='0';
  SIGNAL   aclr_init         : STD_LOGIC :='0';

  -- Inputs registered if c_pipe_level/=c_minimum, else unregistered
  SIGNAL   din_r             : SID_SYMBOL := (OTHERS =>'0');
  SIGNAL   nd_r              : STD_LOGIC;
  SIGNAL   v_fd_r            : STD_LOGIC;
  SIGNAL   abort_r           : STD_LOGIC;
  SIGNAL   fd_received_r     : STD_LOGIC;
  
  SIGNAL   fd_received       : STD_LOGIC;
  SIGNAL   rffd_int          : STD_LOGIC;

  SIGNAL   sync_0            : STD_LOGIC;
  SIGNAL   sync_1            : STD_LOGIC;
  SIGNAL   sync_delayed      : STD_LOGIC;

  SIGNAL   f_sw              : SID_FORNEY_SWITCH;
  SIGNAL   shiftbr_0         : SID_FORNEY_SWITCH;
  SIGNAL   shiftbr_1         : SID_FORNEY_SWITCH;
  SIGNAL   shiftbr_delayed   : SID_FORNEY_SWITCH := -1;
  SIGNAL   shiftbr_raddr_r   : SID_FORNEY_SWITCH := -1;

  SIGNAL   nd_0              : STD_LOGIC;
  SIGNAL   nd_1              : STD_LOGIC := '0';
  SIGNAL   nd_delayed        : STD_LOGIC := '0';
  SIGNAL   nd_raddr_r        : STD_LOGIC := '0';

  SIGNAL   fd_0              : STD_LOGIC;
  SIGNAL   fd_1              : STD_LOGIC;
  SIGNAL   fd_delayed        : STD_LOGIC;

  SIGNAL   ndo_vect          : STD_LOGIC_VECTOR(ndo_delay DOWNTO 0);
  SIGNAL   ndo_d             : STD_LOGIC;
  SIGNAL   ndo_int           : STD_LOGIC;

  SIGNAL   rd_addr_nd_vect   : STD_LOGIC_VECTOR(ndo_delay DOWNTO 0);

  SIGNAL   fdo_proc_vect     : STD_LOGIC_VECTOR(max_fdo_proc_delay DOWNTO 0);
  SIGNAL   fdo_d             : STD_LOGIC;
  SIGNAL   fdo_q             : STD_LOGIC;
  SIGNAL   fdo_int           : STD_LOGIC;

  SIGNAL   rdy_enable_d      : STD_LOGIC;
  SIGNAL   rdy_enable_q      : STD_LOGIC;
  SIGNAL   rdy_enable_int    : STD_LOGIC;

  SIGNAL   dout_int          : SID_SYMBOL := (OTHERS=>'0');

  SIGNAL   rdy_int           : STD_LOGIC;
  SIGNAL   rfd_int           : STD_LOGIC; --not used in Forney

  SIGNAL   rd_en_d           : STD_LOGIC := '1';
  SIGNAL   rd_en_int         : STD_LOGIC := '1';

  SIGNAL   rd_addr_int       : STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0)
                                   := (OTHERS=>'0');
  SIGNAL   wr_addr_int       : STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0)
                                   := (OTHERS=>'0');

  SIGNAL   wr_data_int       : STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);

  SIGNAL   wr_en_d           : STD_LOGIC := '0';
  SIGNAL   wr_en_int         : STD_LOGIC := '0';

  SIGNAL   smem  :MEM := (OTHERS =>(OTHERS=>'0'));  -- internal symbol memory.


  --Signals for selecting parameters when c_num_configurations>1
  CONSTANT config_sel_width  : INTEGER := bits_needed_to_represent(c_num_configurations-1);
  SIGNAL config_sel_r        : STD_LOGIC_VECTOR(config_sel_width-1 DOWNTO 0);
  SIGNAL config_sel_0        : NATURAL RANGE 0 TO c_num_configurations-1 :=0;
  SIGNAL config_sel_1        : NATURAL RANGE 0 TO c_num_configurations-1 :=0;
  SIGNAL config_sel_delayed  : NATURAL RANGE 0 TO c_num_configurations-1 :=0;
  SIGNAL config_sel_raddr_r  : NATURAL RANGE 0 TO c_num_configurations-1 :=0;
  SIGNAL config_sel_valid_0  : STD_LOGIC :='0';
  SIGNAL config_sel_valid_1  : STD_LOGIC :='0';
  SIGNAL config_sel_valid_delayed  : STD_LOGIC :='0';
  SIGNAL config_sel_valid_raddr_r  : STD_LOGIC :='0';
  SIGNAL new_config_0        : STD_LOGIC :='0';
  SIGNAL new_config_1        : STD_LOGIC :='0';
  SIGNAL new_config_delayed  : STD_LOGIC :='0';
  SIGNAL new_config_raddr_r  : STD_LOGIC :='0';
  SIGNAL sync_raddr_r        : STD_LOGIC :='0';
  SIGNAL config_sel_valid_rffd  : STD_LOGIC :='0';

  SIGNAL new_config_r        : STD_LOGIC;
  SIGNAL new_config_int      : STD_LOGIC;

--------------------------------------------------------------------------------
-- START OF ARCHITECTURE -------------------------------------------------------
--------------------------------------------------------------------------------

BEGIN


   -- Output delay process
   -- add setup delay to data output signal
   output_t_proc: PROCESS(dout_int,rd_data,rdy_int)
      VARIABLE dout_t   : SID_SYMBOL;
      BEGIN
        IF c_external_ram/=0 THEN
            dout_t := rd_data;
        ELSE
            IF c_num_configurations>1 THEN
                IF rdy_int/='1' THEN
                   dout_t := (OTHERS => 'X');
                ELSE
                   dout_t := dout_int;
                END IF;
            ELSE
                dout_t := dout_int;
            END IF;
        END IF;    
        dout <= dout_t AFTER output_delay;
   END PROCESS;

   --ce process
   ce_proc: PROCESS(ce)
      BEGIN
        IF c_has_ce/=0 THEN
           ce_int <= ce;
        ELSE
           ce_int <= '1';
        END IF;   
   END PROCESS;
 
   --sclr process
   sclr_proc: PROCESS(sclr)
      BEGIN
        IF c_has_sclr/=0 THEN
           sclr_int <= sclr;
        ELSE
           sclr_int <= '0';
        END IF;   
   END PROCESS;
 
   --new_config process
   new_config_proc: PROCESS(new_config)
      BEGIN
        IF c_num_configurations > 1 THEN
           new_config_int <= new_config;
        ELSE
           new_config_int <= '0';
        END IF;   
   END PROCESS;
 
  --Powerup process - runs once only
  powerup: PROCESS
      BEGIN
         power <= '1' AFTER 1 ns;
         WAIT;
  END PROCESS; --powerup   


  --aclr process
   aclr_proc: PROCESS(power, aclr)
       BEGIN
          IF c_has_aclr/=0 THEN
             aclr_init <= aclr OR NOT power;
          ELSE
             aclr_init <= NOT power;
          END IF;   
   END PROCESS; --aclr_proc   

   --Optional rdy process
   optional_rdy: PROCESS(rdy_int)
      BEGIN
        IF c_has_rdy/=0 THEN rdy <= rdy_int AFTER output_delay;
        ELSE rdy <= 'U';
        END IF;   
   END PROCESS;
  
   --Optional rffd process
   optional_rffd: PROCESS(rffd_int)
      BEGIN
        IF c_has_rffd/=0 THEN rffd <= rffd_int AFTER output_delay;
        ELSE rffd <= 'U';
        END IF;   
    END PROCESS;

   rfd_int <= '0'; --not used in Forney
   --Optional rfd process
   optional_rfd: PROCESS(rfd_int)
      BEGIN
        IF c_has_rfd=0 THEN
           rfd <= 'U';
        ELSIF cc_type = c_forney_convolutional THEN
           rfd <= '1';
        ELSE
           rfd <= rfd_int AFTER output_delay;
        END IF;   
   END PROCESS;



   --config_sel process
   config_sel_proc: PROCESS(clk,aclr_init)

     VARIABLE config_sel_nat      : NATURAL RANGE 0 TO 2**config_sel_width-1;

     BEGIN
      IF c_num_configurations=1 THEN
          config_sel_valid_0 <= '1';
          config_sel_0 <= 0;
      ELSIF aclr_init='1' THEN
          --config_sel_valid_0 <= '0';
          --config_sel_0 <= 0;
      ELSIF clk'event AND clk='1' THEN
              IF ce_int='1' THEN
                 IF sclr_int='1' THEN
                     config_sel_valid_0 <= '0';
                     config_sel_0 <= 0;
                 ELSIF new_config_r='1' THEN
                     config_sel_nat := std_logic_vector_to_natural(config_sel_r);
                     IF config_sel_nat > c_num_configurations-1 THEN
                        config_sel_valid_0 <= '0';
                        config_sel_0 <= 0;
                     ELSE   
                        config_sel_valid_0 <= '1';
                        config_sel_0 <= config_sel_nat;
                     END IF;   
                 END IF;
              END IF;   
      END IF;   
   END PROCESS;


  --Register inputs
  reg_inputs: PROCESS(clk, aclr_init, nd, fd, din, fd_received)
     BEGIN
       IF c_pipe_level /= c_minimum THEN
           IF aclr_init = '1' THEN
              nd_r <= '0';
              v_fd_r <= '0';
              fd_received_r <= '0';
           ELSIF clk'event AND clk = '1' THEN
              IF ce_int = '1' THEN
                  IF sclr_int = '1' THEN
                      nd_r <= '0';
                      v_fd_r <= '0';
                      fd_received_r <= '0';
                  ELSE
                      nd_r <= nd;
                      v_fd_r <= fd AND nd;
                      fd_received_r <= fd_received;
                  END IF;
                  din_r  <= din;
              END IF;    
           END IF;   
       ELSE
           nd_r <= nd;
           v_fd_r <= fd AND nd;
           din_r  <= din;
           fd_received_r <= fd_received;
       END IF;
  END PROCESS;

  --Register inputs (for c_num_configurations>1)
  reg_config_inputs: PROCESS(clk, aclr_init, nd, fd, new_config_int, config_sel)
     BEGIN
       IF c_pipe_level /= c_minimum THEN
           IF aclr_init = '1' THEN
              new_config_r <= '0';
              config_sel_r <= (OTHERS=>'0');
           ELSIF clk'event AND clk = '1' THEN
              IF ce_int = '1' THEN
                  IF sclr_int = '1' THEN
                      new_config_r <= '0';
                      config_sel_r <= (OTHERS=>'0');
                  ELSE
                      new_config_r <= new_config_int AND fd AND nd;
                      config_sel_r <= config_sel;
                  END IF;
              END IF;    
           END IF;   
       ELSE
           new_config_r <= new_config_int AND fd AND nd;
           config_sel_r <= config_sel;
       END IF;
  END PROCESS;

  --Register abort signal
  reg_abort: PROCESS(clk, aclr_init, nd, fd, din, rffd_int, new_config_int, fd_received)
     BEGIN
       IF c_pipe_level /= c_minimum THEN
           IF aclr_init = '1' THEN
              abort_r <= '0';
           ELSIF clk'event AND clk = '1' THEN
              IF ce_int = '1' THEN
                  IF sclr_int = '1' THEN
                      abort_r <= '0';
                  ELSE
                      abort_r <= (fd AND nd AND NOT rffd_int) OR (fd AND nd AND NOT fd_received);
                  END IF;
              END IF;    
           END IF;   
       ELSE
           abort_r <= (fd AND nd AND NOT rffd_int) OR (fd AND nd AND NOT fd_received);
       END IF;
  END PROCESS;

  --Add pipelining to read address
  pipe_raddr: PROCESS(clk,aclr_init,shiftbr_delayed,config_sel_delayed,config_sel_valid_delayed,
                      new_config_delayed,nd_delayed,sync_delayed)
     BEGIN
       IF c_pipe_level=c_maximum THEN
           IF clk'event AND clk = '1' THEN
              IF ce_int = '1' THEN
                  sync_raddr_r <= sync_delayed;
                  new_config_raddr_r <= new_config_delayed;
                  config_sel_raddr_r <= config_sel_delayed;
                  config_sel_valid_raddr_r <= config_sel_valid_delayed;
                  IF sclr_int='1' OR abort_r='1' THEN
                      shiftbr_raddr_r <= -1;
                      nd_raddr_r <= '0';
                  ELSE
                      shiftbr_raddr_r <= shiftbr_delayed;
                      nd_raddr_r <= nd_delayed;
                  END IF;
              END IF;    
           END IF;   
       ELSE
           shiftbr_raddr_r <= shiftbr_delayed;
           sync_raddr_r <= sync_delayed;
           new_config_raddr_r <= new_config_delayed;
           config_sel_raddr_r <= config_sel_delayed;
           config_sel_valid_raddr_r <= config_sel_valid_delayed;
           nd_raddr_r <= nd_delayed;
       END IF;
  END PROCESS;

  --Register outputs
  reg_outputs: PROCESS(clk, aclr_init,rdy_enable_d,fdo_d)
     BEGIN
       IF c_pipe_level=c_maximum THEN
           IF aclr_init='1' THEN
              fdo_q <= '0';
              rdy_enable_q <= '0';
           ELSIF clk'event AND clk='1' THEN
              IF ce_int='1' THEN
                  IF sclr_int='1' OR abort_r='1'THEN
                      fdo_q <= '0';
                      rdy_enable_q <= '0';
                  ELSE
                      fdo_q <= fdo_d;
                      rdy_enable_q <= rdy_enable_d;
                  END IF;
              END IF;    
           END IF;   
       ELSE
           fdo_q <= fdo_d;
           rdy_enable_q <= rdy_enable_d;
       END IF;
  END PROCESS;


  --Process that adds an extra stage of delay to fdo for ext ram
  fdo_adjust: PROCESS(clk, aclr_init, fdo_q, rdy_enable_d)
     BEGIN
       IF c_external_ram/=0 THEN
           IF aclr_init='1' THEN
              fdo_int <= '0';
              rdy_enable_int <= '0';
           ELSIF clk'event AND clk='1' THEN
              IF ce_int='1' THEN
                  IF sclr_int='1' OR (abort_r='1') THEN
                      fdo_int <= '0';
                      rdy_enable_int <= '0';
                  ELSE
                      fdo_int <= fdo_q;
                      rdy_enable_int <= rdy_enable_q;
                  END IF;
              END IF;    
           END IF;   
       ELSE
           fdo_int <= fdo_q;
           rdy_enable_int <= rdy_enable_q;
       END IF;
  END PROCESS;

  --Process that adds an extra stage of delay to ndo for ext ram
  ndo_adjust: PROCESS(clk, aclr_init, ndo_d)
     BEGIN
       IF c_external_ram/=0 THEN
           IF aclr_init='1' THEN
              ndo_int <= '0';
              rd_en_int <= '0';
           ELSIF clk'event AND clk='1' THEN
              IF ce_int='1' THEN
                  IF sclr_int='1' OR (abort_r='1') THEN
                      ndo_int <= '0';
                      rd_en_int <= '0';
                  ELSE
                      ndo_int <= ndo_d;
                      rd_en_int <= rd_en_d;
                  END IF;
              END IF;    
           END IF;   
       ELSE
           ndo_int <= ndo_d;
       END IF;
  END PROCESS;

  --Process that adds an extra stage of delay to wr_en for ext ram
  wr_en_adjust: PROCESS(clk, aclr_init)
     BEGIN
       IF power/='1' THEN
          wr_en_int <= '0';
       ELSIF aclr_init='1' THEN
          wr_en_int <= '0';
       ELSIF clk'event AND clk='1' THEN
          IF ce_int='1' THEN
              IF sclr_int='1' OR (abort_r='1') THEN
                  wr_en_int <= '0';
              ELSE
                  wr_en_int <= wr_en_d;
              END IF;
          END IF;    
       END IF;   
  END PROCESS;

  --Delayed signals process
  delsigs: PROCESS(clk, aclr_init)
     BEGIN
       IF aclr_init = '1' THEN
          IF c_pipe_level=c_maximum THEN 
              nd_delayed <= '0';
          END IF;
          shiftbr_1 <= -1;
          nd_1 <= '0';
          nd_0 <= '0';
          fd_delayed <= '0';
          fd_1 <= '0';
          fd_0 <= '0';
          --config_sel_delayed <= 0;
          --config_sel_1 <= 0;
          --config_sel_valid_delayed <= '0';
          --config_sel_valid_1 <= '0';
          new_config_delayed <= '0';
          new_config_1 <= '0';
       ELSIF clk'event AND clk = '1' THEN
          IF ce_int = '1' THEN
              IF sclr_int = '1' THEN
                  shiftbr_1 <= -1;
                  fd_delayed <= '0';
                  fd_1 <= '0';
                  fd_0 <= '0';
                  config_sel_delayed <= 0;
                  config_sel_1 <= 0;
                  config_sel_valid_delayed <= '0';
                  config_sel_valid_1 <= '0';
                  new_config_delayed <= '0';
                  new_config_1 <= '0';
              ELSE
                  IF c_external_ram=0 AND abort_r = '1' THEN
                    shiftbr_1 <= -1;
                  ELSE
                    shiftbr_1 <= shiftbr_0;
                  END IF;
                  config_sel_delayed <= config_sel_1;
                  config_sel_1 <= config_sel_0;
                  config_sel_valid_delayed <= config_sel_valid_1;
                  config_sel_valid_1 <= config_sel_valid_0;
                  IF abort_r = '1' THEN
                  --need to resync, therefore, abort by purging registers
                    new_config_delayed <= '0';
                    new_config_1 <= '0';
                    new_config_0 <= new_config_r;
                    fd_delayed <= '0';
                    fd_1 <= '0';
                    fd_0 <= '1';
                    nd_delayed <= '0';
                    nd_1 <= '0';
                  ELSE
                    new_config_delayed <= new_config_1;
                    new_config_1 <= new_config_0;
                    new_config_0 <= new_config_r;
                    fd_delayed <= fd_1;
                    fd_1 <= fd_0;
                    fd_0 <= v_fd_r;
                    nd_delayed <= nd_1;
                    nd_1 <= nd_0;
                  END IF;
                  IF (fd_received_r = '1' OR v_fd_r = '1') THEN
                      nd_0 <= nd_r;
                  END IF;    
              END IF;
          END IF;    
       END IF;   
  END PROCESS;

  --shifbr_delayed process
  shifbr_delayed_proc: PROCESS(clk, aclr_init)
     BEGIN
       IF aclr_init = '1' AND c_pipe_level=c_maximum THEN 
              shiftbr_delayed <= -1;
       ELSIF clk'event AND clk = '1' THEN
          IF ce_int = '1' THEN
              IF sclr_int = '1' THEN
                  shiftbr_delayed <= -1;
              ELSE
                  IF c_external_ram=0 AND abort_r = '1' THEN
                    shiftbr_delayed <= -1;
                  ELSE
                    shiftbr_delayed <= shiftbr_1;
                  END IF;
              END IF;
          END IF;    
       END IF;   
  END PROCESS;

  --FD received process
  --Indicates whether a valid fd has ever been received.
  fd_received_proc : PROCESS (clk, aclr_init)
  BEGIN  -- process register_output
    IF aclr_init = '1' THEN
      fd_received <= '0';
    ELSIF (clk'event AND clk = '1') THEN 
      IF ce_int='1' THEN
          IF sclr_int='1' THEN
            fd_received <= '0';
          ELSIF fd ='1' AND nd ='1' THEN
            fd_received <= '1';
          END IF;
      END IF;
    END IF;
  END PROCESS fd_received_proc;

  --rffd_int process
  rffd_int_proc: PROCESS(f_sw,config_sel_valid_rffd,fd_received)
     BEGIN
       IF fd_received/='1' THEN
           rffd_int <= '1';
       ELSE
           IF f_sw=0 THEN
              rffd_int <= '1';
           ELSE
              rffd_int <= '0';
           END IF;
       END IF;
  END PROCESS;

  
  -- Switch position process
  -- This process determines which one of the branches
  -- is active.
  switch_posn: PROCESS(clk, aclr_init)

      VARIABLE  config_sel_nat  : NATURAL RANGE 0 TO 2**config_sel_width-1;
      VARIABLE  num_branches    : INTEGER := abs_min_num_branches;
      VARIABLE  fd_rx           : BOOLEAN := FALSE;

      PROCEDURE park_switch IS
         BEGIN
              fd_rx := FALSE;
              f_sw <= 0;   --clear all contacts
         END park_switch;
          
      PROCEDURE start_switch IS
         BEGIN
              fd_rx := TRUE;
              f_sw <= 1;   --set position 1
              IF c_num_configurations>1 THEN
                  IF new_config_int='1' THEN
                     config_sel_nat := std_logic_vector_to_natural(config_sel);
                     IF config_sel_nat > c_num_configurations-1 THEN
                        config_sel_valid_rffd <= '0';
                        num_branches := forney_params(0).fld_num_branches;
                     ELSE   
                        config_sel_valid_rffd <= '1';
                        num_branches := forney_params(config_sel_nat).fld_num_branches;
                     END IF;   
                  END IF;
              ELSE
                 num_branches := c_num_branches;
              END IF;
         END start_switch;
          
      PROCEDURE rotate_switch(num_branches : IN INTEGER) IS
         BEGIN
              f_sw <= (f_sw + 1) MOD num_branches;--wrap position 0
         END rotate_switch;
          
      BEGIN

      IF aclr_init = '1' THEN
        park_switch;
      ELSIF clk'event AND clk = '1' THEN
        IF ce_int ='1' THEN
          IF sclr_int = '1' THEN
            park_switch;
          ELSIF (fd = '1' AND nd = '1' AND NOT fd_rx) THEN  --first fd
            start_switch;
          ELSIF (fd = '1' AND nd = '1' AND rffd_int = '0') THEN  --abort
            start_switch;
          ELSIF (fd = '1' AND nd = '1' AND new_config_int = '1') THEN  --abort
            start_switch;
          ELSIF nd = '1' AND fd_rx THEN  --running
            rotate_switch(num_branches);
          END IF;  
        END IF;         
      END IF;

  END PROCESS;

  -- shiftbr_0_proc process
  -- This process determines which one of the branches
  -- is to be shifted
  shiftbr_0_proc: PROCESS(clk, aclr_init)

      VARIABLE  config_sel_nat  : NATURAL RANGE 0 TO 2**config_sel_width-1;
      VARIABLE  num_branches    : INTEGER := abs_min_num_branches;
      VARIABLE  fd_rx           : BOOLEAN := FALSE;

      PROCEDURE clear_shiftbr IS
         BEGIN
              fd_rx := FALSE;
              shiftbr_0 <= -1;
         END clear_shiftbr;

      PROCEDURE reset_shiftbr IS
         BEGIN
              fd_rx := TRUE;
              shiftbr_0 <= 0;
              IF c_num_configurations>1 THEN
                  IF new_config_r='1' THEN
                     config_sel_nat := std_logic_vector_to_natural(config_sel_r);
                     IF config_sel_nat > c_num_configurations-1 THEN
                        num_branches := forney_params(0).fld_num_branches;
                     ELSE   
                        num_branches := forney_params(config_sel_nat).fld_num_branches;
                     END IF;   
                  END IF;
              ELSE
                 num_branches := c_num_branches;
              END IF;
         END reset_shiftbr;

      PROCEDURE rotate_shiftbr(num_branches : IN INTEGER) IS
         BEGIN
              shiftbr_0 <= (shiftbr_0 + 1) MOD num_branches;--wrap position 0
         END rotate_shiftbr;
          
      BEGIN

      IF aclr_init = '1' THEN
        clear_shiftbr;
      ELSIF clk'event AND clk = '1' THEN
        IF ce_int ='1' THEN
            IF sclr_int='1' THEN
               clear_shiftbr;
            ELSIF nd_r = '1' THEN
               IF v_fd_r = '1' THEN
                  reset_shiftbr;
               ELSIF fd_rx THEN
                  rotate_shiftbr(num_branches);
               END IF;  
            END IF;         
        END IF;
      END IF;

  END PROCESS; --shiftbr_0_proc


    --Process to generate write data
    write_data_proc : PROCESS(clk, power)

    CONSTANT wr_data_buf_length : INTEGER := select_val(1,2,c_pipe_level=c_maximum)
                                           + select_val(1,0,c_external_ram=0);
    VARIABLE wr_data_buf : DATABUFFER(0 TO wr_data_buf_length):= (OTHERS=>(OTHERS=>'0'));

    BEGIN

      IF power/='1' THEN
        wr_data_int <= (OTHERS =>'0');
      ELSIF (clk'event AND clk = '1') THEN
        IF ce_int = '1' THEN
            --wr_data is unaffected by sclr or nd
            wr_data_int <= wr_data_buf(wr_data_buf_length-1);
            FOR i IN wr_data_buf_length-1 DOWNTO 0 LOOP
                 wr_data_buf(i+1) := wr_data_buf(i);
            END LOOP;
            wr_data_buf(0) := din_r;
        END IF; --ce_int
      END IF; --power

    END PROCESS;       
 

    --Process to generate write address
    write_address_proc : PROCESS(clk, power)

    VARIABLE write_addr_vect  : BVECTOR;
    VARIABLE wr_addr_nat      : NATURAL RANGE 0 TO (2**c_ext_addr_width)-1;
    VARIABLE wr_addr_buf      : INTEGER_VECTOR(0 TO 3); --Use to adjust delay
    VARIABLE wshiftbr         : SID_FORNEY_SWITCH;
    VARIABLE nd_w             : STD_LOGIC;
    VARIABLE new_config_w     : STD_LOGIC := '0';
    VARIABLE sync_w           : STD_LOGIC := '0';
    VARIABLE config_sel_valid_w  : STD_LOGIC := '0';
    VARIABLE config_sel_w     : NATURAL RANGE 0 TO c_num_configurations-1 :=0;
    VARIABLE config_sel_w_in  : NATURAL RANGE 0 TO c_num_configurations-1 :=0;
    VARIABLE this_branch      : NATURAL RANGE 0 TO max_num_branches-1 :=0;
    VARIABLE num_branches     : INTEGER;
    VARIABLE firstrotation    : STD_LOGIC := '0'; --'1' on first rotation of the switch


    BEGIN

      IF power/='1' THEN
        wr_addr_int <= (OTHERS=>'0');
        wr_addr_nat := 0;
        wr_addr_buf := (OTHERS=>0);
        config_sel_w := 0;
        config_sel_w_in := 0;
        new_config_w := '0';
        config_sel_valid_w := '0';
        write_addr_vect := forney_params(0).fld_branch_end_vector;
        num_branches := forney_params(0).fld_num_branches;
        wshiftbr   := -1;
        nd_w := '0';
        sync_w := '0';
        firstrotation := '0';

      ELSIF (clk'event AND clk = '1') THEN

        IF ce_int = '1' THEN

            IF c_pipe_level/=c_maximum THEN
               wshiftbr   := shiftbr_1;
               nd_w := nd_1;
               sync_w := sync_1;
               config_sel_w_in := config_sel_1;
               new_config_w := new_config_1;
               config_sel_valid_w := config_sel_valid_1;
            ELSE
               wshiftbr   := shiftbr_delayed;
               nd_w := nd_delayed;
               sync_w := sync_delayed;
               config_sel_w_in := config_sel_delayed;
               new_config_w := new_config_delayed;
               config_sel_valid_w := config_sel_valid_delayed;
            END IF;
            
            IF new_config_w='1' THEN
                firstrotation := '1';
                IF config_sel_valid_w='1' THEN
                    config_sel_w := config_sel_w_in;
                ELSE
                    config_sel_w := 0;
                END IF;
                write_addr_vect := forney_params(config_sel_w).fld_branch_end_vector;
                write_addr_vect(0) := forney_params(config_sel_w).fld_branch_start_vector(0);
                num_branches := forney_params(config_sel_w).fld_num_branches;
                wr_addr_buf(0) := write_addr_vect(0);
            ELSIF firstrotation='1' AND sync_w='1' THEN
                write_addr_vect := forney_params(config_sel_w).fld_branch_end_vector;
                write_addr_vect(0) := forney_params(config_sel_w).fld_branch_start_vector(0);
                wr_addr_buf(0) := write_addr_vect(0);
            ELSIF (sync_1='1' AND c_pipe_level=c_maximum) OR sync_0 ='1' OR abort_r='1' OR sclr_int='1' THEN
               --do nothing
            ELSE
                IF wshiftbr/=-1 AND nd_w='1' THEN
                    IF wshiftbr=0 THEN
                        firstrotation := '0';
                    END IF;
                    this_branch := wshiftbr;
                    --Shift the branch pointed to by the switch
                    IF (
                        write_addr_vect(this_branch)=
                            forney_params(config_sel_w).fld_branch_end_vector(this_branch)
                       )THEN
                       write_addr_vect(this_branch) := 
                            forney_params(config_sel_w).fld_branch_start_vector(this_branch); --reset
                    ELSE
                       write_addr_vect(this_branch) := 
                            write_addr_vect(this_branch)+1; --add 1
                    END IF;         
                    --Select the write address pointed to by the switch
                    wr_addr_buf(0) := write_addr_vect(this_branch);
                END IF; --wshiftbr
            END IF;         
            --Back end delay can be adjusted by changing the wr_addr_buf index
            wr_addr_nat := wr_addr_buf(0);
            wr_addr_int <= integer_to_std_logic_vector(wr_addr_buf(0),c_ext_addr_width);

            IF wr_en_d='1' THEN
                IF abort_r/='1' AND sclr_int/='1' THEN
                    smem(wr_addr_nat) <= wr_data_int;
                END IF;
            END IF;

        END IF; --ce_int
      END IF; --power

    END PROCESS;       


    --Process to generate read address --incorporating symbol memory
    read_address_proc : PROCESS(clk, aclr_init)

    VARIABLE read_addr_vect : BVECTOR;
    VARIABLE num_branches   : INTEGER;
    VARIABLE config         : NATURAL RANGE 0 TO c_num_configurations-1 :=0;
    VARIABLE this_branch    : NATURAL RANGE 0 TO max_num_branches-1 :=0;
    VARIABLE firstrotation  : STD_LOGIC := '0'; --'1' on first rotation of the switch
    VARIABLE rd_addr_d      : NATURAL RANGE 0 TO (2**c_ext_addr_width)-1;

    BEGIN

      IF power/='1' THEN
         read_addr_vect := forney_params(0).fld_branch_start_vector;
         num_branches := forney_params(0).fld_num_branches;
         rd_addr_int <= (OTHERS => '0');
         rd_addr_d := 0;
         config := 0;
         firstrotation := '0';
      ELSIF (clk'event AND clk = '1') THEN
        IF ce_int = '1' THEN
            IF nd_raddr_r = '1' THEN
                IF new_config_raddr_r='1' THEN
                    firstrotation := '1';
                    config := config_sel_raddr_r;

                    read_addr_vect := forney_params(config).fld_branch_start_vector;
                    num_branches := forney_params(config).fld_num_branches;

                    IF read_addr_vect(0)=forney_params(config).fld_branch_end_vector(0) THEN
                        read_addr_vect(0) := forney_params(config).fld_branch_start_vector(0); --reset
                    ELSE
                        read_addr_vect(0) := read_addr_vect(0)+1; --add 1
                    END IF;         
                    rd_addr_d := read_addr_vect(0);
                    rd_addr_int <= integer_to_std_logic_vector(read_addr_vect(0),c_ext_addr_width);

                ELSIF firstrotation='1' AND sync_raddr_r='1' THEN
                    read_addr_vect := forney_params(config).fld_branch_start_vector;
                    IF read_addr_vect(0)=forney_params(config).fld_branch_end_vector(0) THEN
                        read_addr_vect(0) := forney_params(config).fld_branch_start_vector(0); --reset
                    ELSE
                        read_addr_vect(0) := read_addr_vect(0)+1; --add 1
                    END IF;         
                    rd_addr_d := read_addr_vect(0);
                    rd_addr_int <= integer_to_std_logic_vector(read_addr_vect(0),c_ext_addr_width);
                
                ELSE
                    IF shiftbr_raddr_r=0 THEN
                        firstrotation := '0';
                    END IF;
                    IF shiftbr_raddr_r/=-1 THEN
                        this_branch := shiftbr_raddr_r;
                        IF (
                           read_addr_vect(this_branch)=
                                forney_params(config).fld_branch_end_vector(this_branch)
                        )THEN
                               read_addr_vect(this_branch) := 
                                   forney_params(config).fld_branch_start_vector(this_branch); --reset
                        ELSE
                               read_addr_vect(this_branch) := 
                                   read_addr_vect(this_branch)+1; --add 1
                        END IF;         
                        --Select one read address (Rotate the output switch)
                        IF abort_r/='1' AND sclr_int/='1' THEN
                               rd_addr_d := read_addr_vect(this_branch);
                        END IF;
                        
                        rd_addr_int <= integer_to_std_logic_vector
                               (read_addr_vect(this_branch),c_ext_addr_width);
                    END IF;
                END IF;
            END IF; --nd_raddr_r
            IF rd_en_d='1' THEN
                IF abort_r/='1' THEN
                    dout_int <= smem(rd_addr_d);
                END IF;
            END IF;
        END IF; --ce
      END IF; --power
    END PROCESS;       
 
    --FDO port
    fdoport: PROCESS(fdo_int,ndo_int)
    BEGIN
       IF c_has_fdo/=0 THEN
          fdo <= (fdo_int AND ndo_int) AFTER output_delay;
       ELSE
          fdo <= 'U';
       END IF;   
    END PROCESS;

    --NDO PORT process
    ndoport: PROCESS(ndo_int)
    BEGIN
       IF c_has_ndo/=0 THEN
          ndo <=  ndo_int AFTER output_delay;
       ELSE
          ndo <= 'U';
       END IF;   
    END PROCESS;

    --RD_EN PORT process
    rd_en_d <= ndo_vect(ndo_delay-1);
    rd_en_port: PROCESS(clk, aclr_init, rd_en_int)
    BEGIN
       IF c_external_ram/=0 THEN
          rd_en <= rd_en_int AFTER output_delay;
       ELSE
          rd_en <= 'U';
       END IF;   
    END PROCESS; --rd_en_port

    --WR_EN PORT process
    wr_en_d <= ndo_vect(ndo_delay-2);
    wr_en_port: PROCESS(wr_en_int)
    BEGIN
       IF c_external_ram/=0 THEN
          wr_en <= wr_en_int AFTER output_delay;
       ELSE
          wr_en <= 'U';
       END IF;   
    END PROCESS;

    --WR_DATA PORT process
    wr_data_port: PROCESS(wr_data_int)
    BEGIN
       IF c_external_ram/=0 THEN
          wr_data <= wr_data_int AFTER output_delay;
       ELSE
          wr_data <= (OTHERS=>'U');
       END IF;   
    END PROCESS;

    --RD_ADDR PORT process (Forney)
    rd_addr_port: PROCESS(rd_addr_int, rd_en_int)
    BEGIN
       IF c_external_ram/=0 THEN
          IF rd_en_int='1' THEN
             rd_addr <=  rd_addr_int AFTER output_delay;
          ELSE
             rd_addr <= (OTHERS=>'X') AFTER output_delay;
          END IF;   
       ELSE
          rd_addr <= (OTHERS=>'U');
       END IF;   
    END PROCESS;

    --WR_ADDR PORT process
    wr_addr_port: PROCESS(wr_addr_int, wr_en_int)
    BEGIN
       IF c_external_ram/=0 THEN
          IF wr_en_int='1' THEN
             wr_addr <=  wr_addr_int AFTER output_delay;
          ELSE
             wr_addr <= (OTHERS=>'X') AFTER output_delay;
          END IF;
       ELSE
          wr_addr <= (OTHERS=>'U');
       END IF;   
    END PROCESS;

    --RDY port
    --for when the length of branch 0 is 0, rdy is the same as ndo
    rdyport: PROCESS(ndo_int,rdy_enable_int)
    BEGIN
       rdy_int <= (ndo_int AND (rdy_enable_int)) AFTER output_delay;
    END PROCESS;


    --FDO proc process
    fdo_proc : PROCESS (clk, aclr_init)
    
    VARIABLE fdo_proc_delay : INTEGER;

    BEGIN
        fdo_proc_delay := forney_params(config_sel_delayed).fld_fdo_proc_delay;

        IF aclr_init = '1' THEN
          fdo_proc_vect <= (OTHERS => '0');
          fdo_d <= '0';
        ELSIF (clk'event AND clk = '1') THEN 
             IF ce_int='1' THEN
                IF sclr_int='1' THEN
                    fdo_proc_vect <= (OTHERS => '0');
                    fdo_d <= '0';
                ELSE
                    IF fdo_proc_delay >1 THEN
                      IF fd_delayed = '1' THEN
                         fdo_proc_vect <= (OTHERS => '0');
                         fdo_proc_vect(0) <= fd_delayed;
                         fdo_d <= '0';
                      ELSE     
                         fdo_d <= fdo_proc_vect(fdo_proc_delay-2);  
                         IF nd_delayed = '1' THEN
                              FOR n IN (fdo_proc_delay-1) DOWNTO 0 LOOP
                                fdo_proc_vect(n+1) <= fdo_proc_vect(n);
                              END LOOP;
                              fdo_proc_vect(0) <= fd_delayed;
                         END IF;     
                      END IF;
                    ELSE
                      IF abort_r = '1' THEN
                         fdo_d <= '0';
                      ELSE
                         fdo_d <= fd_delayed;  
                      END IF;   
                    END IF;
                END IF;
             END IF;
        END IF;
    END PROCESS;


    --RDY_enable process
    --rdy is enabled when the first fdo is output
    rdy_enable_proc : PROCESS (clk, aclr_init)
    
    VARIABLE fdo_proc_delay : INTEGER;

    BEGIN
        fdo_proc_delay := forney_params(config_sel_delayed).fld_fdo_proc_delay;

        IF aclr_init = '1' THEN
          rdy_enable_d <= '0';
        ELSIF (clk'event AND clk = '1') THEN 
             IF ce_int='1' THEN
                IF sclr_int='1' THEN
                    rdy_enable_d <= '0';
                ELSE
                    IF fdo_proc_delay >1 THEN
                      IF abort_r='1' THEN
                         rdy_enable_d <= '0';  
                      ELSIF (fdo_proc_vect(fdo_proc_delay-2)='1'
                         AND  fd_delayed /= '1'  -- because this clears fdo_proc_vect
                         AND  sync_0 /= '1'  -- because and abort occurred
                         AND  sync_1 /= '1'  -- because and abort occurred
                         AND  sync_delayed /= '1'  -- because and abort occurred
                         ) THEN
                         rdy_enable_d <= '1';  
                      END IF;
                    ELSE
                      IF abort_r='1' THEN
                           rdy_enable_d <= '0';
                      ELSIF fd_delayed='1' THEN
                           rdy_enable_d <= '1';  
                      END IF;   
                    END IF;
                END IF;
             END IF;
        END IF;
    END PROCESS;

    sync_proc : PROCESS (clk, aclr_init)
    
    BEGIN  -- process register_output
        IF aclr_init = '1' THEN
          sync_delayed <= '0';
          sync_1 <= '0';
          sync_0 <= '0';
        ELSIF (clk'event AND clk = '1') THEN 
             IF ce_int='1' THEN
                IF sclr_int='1' THEN
                  sync_delayed <= '0';
                  sync_1 <= '0';
                  sync_0 <= '0';
                ELSE
                  sync_delayed <= sync_1;
                  sync_1 <= sync_0;
                  sync_0 <= abort_r;
                END IF;
             END IF;
        END IF;
    END PROCESS;

    --NDO delay process
    --ndo is nd_r, delayed by (ndo_delay) clocks
    ndo_delay_proc : PROCESS (clk, aclr_init)
    
    BEGIN
        IF aclr_init = '1' THEN
          ndo_vect <= (OTHERS => '0');
          ndo_d <= '0';
        ELSIF (clk'event AND clk = '1') THEN 
             IF ce_int='1' THEN
                IF sclr_int='1' OR (fd_received_r = '0') THEN
                   ndo_vect <= (OTHERS => '0');
                   ndo_d <= '0';
                   ndo_vect(0) <= v_fd_r; --load a 1 if first fd
                ELSE
                  IF abort_r='1' THEN--abort condition
                    -- purge shift register
                    ndo_vect <= (OTHERS => '0');
                    ndo_vect(0) <= nd_r;
                    ndo_d <= '0';
                  ELSE
                    ndo_d <= ndo_vect(ndo_delay-1);  
                    ndo_vect(0) <= nd_r;
                    FOR n IN 1 TO (ndo_delay-1) LOOP
                       ndo_vect(n) <= ndo_vect(n-1);
                    END LOOP;  -- n
                  END IF;  
                END IF;   
             END IF;
        END IF;
    END PROCESS;


END behavioral;



---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*

---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
--            RECTANGULAR BLOCK INTERLEAVER / DEINTERLEAVER                 ---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*


LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;
--USE ieee.std_logic_arith.ALL;

LIBRARY std;
USE std.textio.ALL;

LIBRARY xilinxcorelib;
USE xilinxcorelib.sid_const_pkg_behav_v5_1.all ;
USE xilinxcorelib.sid_pkg_behav_v5_1.all ;
USE xilinxcorelib.sid_mif_pkg_behav_v5_1.ALL;

ENTITY sid_bhv_rectangular_block_v5_1 IS
GENERIC (
        c_family               : STRING;
        c_mode                 : INTEGER;
        c_symbol_width         : INTEGER;
        -- Row specific generics
        c_row_type             : INTEGER;
        c_row_constant         : INTEGER;
        c_has_row              : INTEGER;
        c_has_row_valid        : INTEGER;
        c_min_num_rows         : INTEGER;
        c_row_width            : INTEGER;
        c_num_selectable_rows  : INTEGER;
        c_row_select_file      : STRING  := "";
        c_has_row_sel          : INTEGER;
        c_has_row_sel_valid    : INTEGER;
        c_use_row_permute_file : INTEGER;
        c_row_permute_file     : STRING := "";
        -- Column specific generics
        c_col_type             : INTEGER;
        c_col_constant         : INTEGER;
        c_has_col              : INTEGER;
        c_has_col_valid        : INTEGER;
        c_min_num_cols         : INTEGER;
        c_col_width            : INTEGER;
        c_num_selectable_cols  : INTEGER;
        c_col_select_file      : STRING  := "";
        c_has_col_sel          : INTEGER;
        c_has_col_sel_valid    : INTEGER;
        c_use_col_permute_file : INTEGER;
        c_col_permute_file     : STRING  := "";
        -- Block size specific generics
        c_block_size_type      : INTEGER;
        c_block_size_constant  : INTEGER;
        c_has_block_size       : INTEGER;
        c_block_size_width     : INTEGER;
        c_has_block_size_valid : INTEGER;
        -- Implementation generics
        c_memstyle             : INTEGER;
        c_pipe_level           : INTEGER;
        -- Optional pin generics
        c_has_ce               : INTEGER;
        c_has_nd               : INTEGER;
        c_has_sclr             : INTEGER;
        c_has_aclr             : INTEGER;
        c_has_rdy              : INTEGER;
        c_has_rffd             : INTEGER;
        c_has_rfd              : INTEGER;
        c_has_block_start      : INTEGER;
        c_has_block_end        : INTEGER;

        --New for generics v4_0
        c_architecture         : INTEGER;
        c_external_ram         : INTEGER;
        c_ext_addr_width       : INTEGER);
PORT (
          -- Mandatory pins
        clk              : IN STD_LOGIC;
        fd               : IN STD_LOGIC;
        din              : IN STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);
        -- Optional input pins
        ce               : IN STD_LOGIC;
        nd               : IN STD_LOGIC;
        sclr             : IN STD_LOGIC;
        aclr             : IN STD_LOGIC;
        row              : IN STD_LOGIC_VECTOR(c_row_width-1 DOWNTO 0);
        row_sel          : IN STD_LOGIC_VECTOR(
                      bits_needed_to_represent(c_num_selectable_rows-1) - 1 DOWNTO 0);
        col              : IN STD_LOGIC_VECTOR(c_col_width-1 DOWNTO 0);
        col_sel          : IN STD_LOGIC_VECTOR(
                      bits_needed_to_represent(c_num_selectable_cols-1) - 1 DOWNTO 0);
        block_size       : IN STD_LOGIC_VECTOR(c_block_size_width-1 DOWNTO 0);
        -- Mandatory output pins
        dout             : OUT STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);
        -- optional output pins
        rfd              : OUT STD_LOGIC;
        rdy              : OUT STD_LOGIC;
        rffd             : OUT STD_LOGIC;
        row_valid        : OUT STD_LOGIC;
        col_valid        : OUT STD_LOGIC;
        row_sel_valid    : OUT STD_LOGIC;
        col_sel_valid    : OUT STD_LOGIC;
        block_size_valid : OUT STD_LOGIC;
        block_start      : OUT STD_LOGIC;
        block_end        : OUT STD_LOGIC;
        --New ports for v4_0
        rd_data          : IN STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0); -- Read data from external RAM
        rd_en            : OUT STD_LOGIC;
        wr_en            : OUT STD_LOGIC;
        rd_addr          : OUT STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0);
        wr_addr          : OUT STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0);
        wr_data          : OUT STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0)); -- Write data to external RAM

END sid_bhv_rectangular_block_v5_1;

ARCHITECTURE behavioral OF sid_bhv_rectangular_block_v5_1 IS

 -- Set to 0 for Virtex or Spartan2 based family, else set to 1
 CONSTANT c_family_int : INTEGER := get_family_int(c_family);
  

 CONSTANT output_delay : TIME := 1 ns;

 ------------------------------------------------------------------------------
 -- Return number of values in the total rcl permute vector
 --The number of values in the total_rcl_permute_vector equals the total of all
 --the values in the rcl select vector.
 --
 FUNCTION get_num_total_permute_vals(rcl_type            : INTEGER;
                                     num_rcls            : INTEGER;
                                     rcl_select_vector   : INTEGER_VECTOR
                                     ) RETURN INTEGER IS
   VARIABLE return_val : INTEGER := 0;
 BEGIN
   IF rcl_type = c_selectable THEN
      return_val := get_sum(rcl_select_vector);
   ELSIF rcl_type = c_constant THEN
      return_val := num_rcls;
   ELSE
      return_val := 1;
   END IF;
   
   RETURN return_val;
 END get_num_total_permute_vals;

 ------------------------------------------------------------------------------
 CONSTANT max_num_selectable_rows : INTEGER := 32; --defined in spec
 CONSTANT max_num_selectable_cols : INTEGER := 32; --defined in spec
 CONSTANT max_num_selectable_rcls : INTEGER := 32; --where rcl is row or col


 CONSTANT row_sel_width : INTEGER := bits_needed_to_represent(c_num_selectable_rows-1);
 CONSTANT col_sel_width : INTEGER := bits_needed_to_represent(c_num_selectable_cols-1);

 CONSTANT really_read_row_select_mif : BOOLEAN := (c_row_type = c_selectable);

 CONSTANT row_select_vector : integer_vector(0 TO c_num_selectable_rows-1)
          := get_integer_vector_from_mif(really_read_row_select_mif,
                                         c_row_select_file,
                                         c_num_selectable_rows,
                                         SID_CONST_PKG_BEHAV_mif_width);
                                         


 -- max_num_rows is the biggest value in row_select_vector, or is determined
 -- by 'row' generics
 CONSTANT max_num_rows : INTEGER := get_max_dimension(c_row_type,
                                                      c_row_constant,
                                                      c_row_width,
                                                      row_select_vector);
 
 CONSTANT really_read_col_select_mif : BOOLEAN := (c_col_type = c_selectable);
 
 CONSTANT col_select_vector : integer_vector(0 TO c_num_selectable_cols-1)
          := get_integer_vector_from_mif(really_read_col_select_mif,
                                         c_col_select_file,
                                         c_num_selectable_cols,
                                         SID_CONST_PKG_BEHAV_mif_width);
          
 -- max_num_cols is the biggest value in col_select_vector, or is determined
 -- by 'col' generics
 CONSTANT max_num_cols : INTEGER := get_max_dimension(c_col_type,
                                                      c_col_constant,
                                                      c_col_width,
                                                      col_select_vector);
                                                      

 CONSTANT max_block_size : INTEGER :=
          get_max_block_size(max_num_rows, max_num_cols, c_block_size_constant,
                             c_block_size_type, c_block_size_width);
   
 CONSTANT max_num_symbol_ram_cells : INTEGER := max_num_rows * max_num_cols;

 CONSTANT num_symbol_ram_cells : INTEGER := max_block_size;
  
 -- Round up to nearest 16 prior to get_memstyle calculation
 CONSTANT symbol_ram_depth_tmp : INTEGER :=
                              get_mem_depth_dp(num_symbol_ram_cells, c_distmem);
                                       
 -- Select appropriate memstyle for symbol memory
 CONSTANT symbol_mem_style : INTEGER :=
      get_memstyle(symbol_ram_depth_tmp, c_symbol_width, c_memstyle, c_sp_ram,
                   c_family_int, TRUE);
                                    

 CONSTANT rectangle_size : INTEGER := max_num_rows * max_num_cols;
  
 CONSTANT pruned : BOOLEAN := max_block_size < rectangle_size OR
                               c_block_size_type = c_variable;
  
 CONSTANT pruned_single_row : BOOLEAN :=
                            pruned AND c_row_type=c_constant AND max_num_rows=1;
                            
 CONSTANT wss_delay: INTEGER := calc_wss_delay(pruned,
                           c_block_size_type,
                           c_col_type,
                           c_row_type);

 CONSTANT wsip_delay_val: INTEGER :=
                select_val(1,3, c_use_row_permute_file/=0 OR c_use_col_permute_file/=0);


 CONSTANT output_buffer_length: INTEGER := wss_delay
              + select_val(0,2, c_use_row_permute_file/=0 OR c_use_col_permute_file/=0)
              + 1;--for v4_0
 
 CONSTANT input_buffer_length: INTEGER := wss_delay + 1
              + select_val(0,2, c_use_row_permute_file/=0 OR c_use_col_permute_file/=0);
 
 CONSTANT addr_buffer_length: INTEGER := wss_delay
              + select_val(0,2, c_use_row_permute_file/=0 OR c_use_col_permute_file/=0);

 CONSTANT wr_en_buffer_length: INTEGER := wss_delay + 1
              + select_val(0,2, c_use_row_permute_file/=0 OR c_use_col_permute_file/=0);
 
 CONSTANT rd_en_buffer_length: INTEGER := wss_delay + 1
              + select_val(0,2, c_use_row_permute_file/=0 OR c_use_col_permute_file/=0);
 
 --delay between fd and assertion of row_valid etc.
 CONSTANT xvalid_buffer_length : INTEGER := calc_xvalid_buffer_length
                 (wss_delay,c_block_size_type,c_col_type,c_row_type);

 --The number of values in the total permute vector is not
 --greater than largest value in the row/column select vector
 --times the number of selectable rows/columns.
 CONSTANT max_total_row_permute_vals : INTEGER := max_num_rows * c_num_selectable_rows;
 CONSTANT max_total_col_permute_vals : INTEGER := max_num_cols * c_num_selectable_cols;


 --The number of values in the total_row_permute_vector equals the total of all
 --the values in the row select vector.
 CONSTANT num_total_row_permute_values : NATURAL := get_num_total_permute_vals
                        (c_row_type, c_row_constant, row_select_vector);
  
 CONSTANT really_read_total_row_permute_mif : BOOLEAN := (c_use_row_permute_file/=0);

 CONSTANT initial_total_row_permute_vector : integer_vector(0 TO (num_total_row_permute_values-1))
           := get_integer_vector_from_mif(really_read_total_row_permute_mif,
                                          c_row_permute_file,
                                          num_total_row_permute_values,
                                          SID_CONST_PKG_BEHAV_mif_width);

 --The number of values in the total_col_permute_vector equals the total of all
 --the values in the col select vector.
 CONSTANT num_total_col_permute_values : NATURAL := get_num_total_permute_vals
                        (c_col_type, c_col_constant, col_select_vector);
  
 CONSTANT really_read_total_col_permute_mif : BOOLEAN := (c_use_col_permute_file/=0);

 CONSTANT initial_total_col_permute_vector : integer_vector(0 TO (num_total_col_permute_values-1))
           := get_integer_vector_from_mif(really_read_total_col_permute_mif,
                                          c_col_permute_file,
                                          num_total_col_permute_values,
                                          SID_CONST_PKG_BEHAV_mif_width);

                                         
 ------------------------------------------------------------------------------
 -- Make row or column permute offset vector
 --
 --The maximum number of selectable row/col permute vectors is given by the
 --max_num_selectable_rows/cols.(i.e 32)
 --create an array of row/col permute offsets to store the start addresses of the
 --possible selectable row/col permute vectors.
 --The number of values in a particular row/col permute vector equals the 
 --corresponding value in the row/col select vector.                                       
 FUNCTION make_permute_offset_vector(rcl_type : INTEGER;
                                     num_selectable_rcls : INTEGER;
                                     rcl_select_vector: integer_vector)
                                     RETURN integer_vector IS

   VARIABLE offset  : integer_vector(0 TO num_selectable_rcls-1) := (OTHERS => 0);
 BEGIN
   IF rcl_type /= c_selectable THEN
      offset := (OTHERS =>0);
   ELSE
      offset(0) := 0;
      FOR i IN 1 TO num_selectable_rcls-1 LOOP
         offset(i) := offset(i-1)+rcl_select_vector(i-1);
      END LOOP;
   END IF;          
   RETURN offset;
 END make_permute_offset_vector;
 

 CONSTANT row_permute_offset_vector : integer_vector(0 TO c_num_selectable_rows-1)
          := make_permute_offset_vector(c_row_type,
             c_num_selectable_rows, row_select_vector);

 CONSTANT col_permute_offset_vector : integer_vector(0 TO c_num_selectable_cols-1)
          := make_permute_offset_vector(c_col_type,
             c_num_selectable_cols, col_select_vector);


 ------------------------------------------------------------------------------
 -- If interleaver, need to make inverse total row or column permute vector
 --
 FUNCTION get_actual_total_permute_vector(mode : INTEGER;
                                     initial_total_rcl_permute_vector : integer_vector;
                                     num_total_rcl_permute_values : INTEGER;
                                     rcl_type : INTEGER;
                                     num_rcls : INTEGER;
                                     num_selectable_rcls : INTEGER;
                                     rcl_select_vector: integer_vector)
                                     RETURN integer_vector IS

   VARIABLE ivect  : integer_vector(0 TO num_total_rcl_permute_values-1) := (OTHERS => 0);
   VARIABLE offset : INTEGER;
 BEGIN
   IF mode = c_interleaver THEN
       IF rcl_type = c_selectable THEN
          offset:=0;
          FOR s IN 0 TO num_selectable_rcls-1 LOOP
             FOR i IN 0 to rcl_select_vector(s)-1 LOOP
                --sweep for target
                FOR j IN 0 to rcl_select_vector(s)-1 LOOP
                    IF initial_total_rcl_permute_vector(offset+j) = i THEN
                       ivect(i+offset) := j;
                    END IF;   
                END LOOP;
             END LOOP;   
             offset := offset + rcl_select_vector(s);
          END LOOP;
       ELSIF rcl_type = c_constant THEN
          FOR i IN 0 to num_rcls-1 LOOP
             FOR j IN 0 to num_rcls-1 LOOP
                 --Search through the vector till i is found.
                 --Put the location of it into the output
                 --vector
                 IF initial_total_rcl_permute_vector(j) = i THEN
                    ivect(i) := j;
                 END IF;   
             END LOOP;
          END LOOP;   
       ELSE
          ivect := (OTHERS => 0); --rcl_type = c_variable: permutations not allowed
       END IF;          
   ELSE
       ivect := initial_total_rcl_permute_vector;
   END IF; 
   RETURN ivect;
 END get_actual_total_permute_vector;
 

 CONSTANT total_row_permute_vector : integer_vector(0 TO (num_total_row_permute_values-1))
           := get_actual_total_permute_vector(c_mode,
                                     initial_total_row_permute_vector,
                                     num_total_row_permute_values,
                                     c_row_type,
                                     c_row_constant,
                                     c_num_selectable_rows,
                                     row_select_vector);

 CONSTANT total_col_permute_vector : integer_vector(0 TO (num_total_col_permute_values-1))
           := get_actual_total_permute_vector(c_mode,
                                     initial_total_col_permute_vector,
                                     num_total_col_permute_values,
                                     c_col_type,
                                     c_col_constant,
                                     c_num_selectable_cols,
                                     col_select_vector);

 -------------------------------------------------------------------------------
 --Data types;

 SUBTYPE SID_SYMBOL IS STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);

 SUBTYPE MEM_ADDRESS IS NATURAL RANGE 0 TO max_num_symbol_ram_cells-1;

 TYPE MEM IS ARRAY (0 TO max_num_symbol_ram_cells-1) OF SID_SYMBOL;
 TYPE OPBUF IS ARRAY (0 TO output_buffer_length) OF SID_SYMBOL;
 TYPE IPBUF IS ARRAY (0 TO input_buffer_length) OF SID_SYMBOL;
 TYPE MEM_ADDRESS_BUF IS ARRAY (0 TO addr_buffer_length) OF MEM_ADDRESS;


 TYPE FSM_STATE_TYPE IS (IDLE,IDLE_1,START,WRITING,READING,READING_0,READING_1);

 -------------------------------------------------------------------------------
 FUNCTION calc_col_length_vector (num_rows   : NATURAL;
                                  num_cols   : NATURAL;
                                  blocksize  : NATURAL)
                                  RETURN INTEGER_VECTOR IS

   VARIABLE result : INTEGER_VECTOR(0 TO num_cols-1) := (OTHERS => 0);

 BEGIN
   FOR ci IN 0 TO num_cols-1 LOOP
       IF num_cols*(num_rows-1) + ci > blocksize-1 THEN
          result(ci) := num_rows - 1; --pruned column
       ELSE   
          result(ci) := num_rows;  --unpruned column
       END IF;   
   END LOOP;    
   RETURN result;

 END calc_col_length_vector;

 ------------------------------------------------------------------------------
  

 SIGNAL   ce_int            : STD_LOGIC;
 SIGNAL   sclr_int          : STD_LOGIC;
 SIGNAL   power             : STD_LOGIC :='0';
 SIGNAL   aclr_init         : STD_LOGIC :='0';

 SIGNAL   din_0             : SID_SYMBOL;
 SIGNAL   din_1             : SID_SYMBOL;
 SIGNAL   din_del           : SID_SYMBOL;

 SIGNAL   nd_int            : STD_LOGIC;
 SIGNAL   nd_0              : STD_LOGIC;
 SIGNAL   nd_del            : STD_LOGIC;
 SIGNAL   v_fd_b            : STD_LOGIC;
 SIGNAL   v_fd_0            : STD_LOGIC;
 SIGNAL   v_fd_del          : STD_LOGIC;
 SIGNAL   abort_b           : STD_LOGIC;
 SIGNAL   abort_0           : STD_LOGIC;

 SIGNAL   row_0             : STD_LOGIC_VECTOR(c_row_width-1 DOWNTO 0);
 SIGNAL   row_sel_0         : STD_LOGIC_VECTOR(
                     bits_needed_to_represent(c_num_selectable_rows-1) - 1 DOWNTO 0);
 SIGNAL   col_0             : STD_LOGIC_VECTOR(c_col_width-1 DOWNTO 0);
 SIGNAL   col_sel_0         : STD_LOGIC_VECTOR(
                     bits_needed_to_represent(c_num_selectable_cols-1) - 1 DOWNTO 0);
 SIGNAL   block_size_0      : STD_LOGIC_VECTOR(c_block_size_width-1 DOWNTO 0);

 SIGNAL   row_valid_int        : STD_LOGIC;
 SIGNAL   col_valid_int        : STD_LOGIC;
 SIGNAL   row_sel_valid_int    : STD_LOGIC;
 SIGNAL   col_sel_valid_int    : STD_LOGIC;
 SIGNAL   block_size_valid_int : STD_LOGIC;

 SIGNAL   rffd_int             : STD_LOGIC;
 SIGNAL   rfd_int              : STD_LOGIC;

 SIGNAL   block_start_int      : STD_LOGIC;
 SIGNAL   block_end_int        : STD_LOGIC;
 SIGNAL   rdy_int              : STD_LOGIC;

 SIGNAL   dout_int             : SID_SYMBOL;
 

 SIGNAL   sram_raddr_int     : STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0)
                                    := (OTHERS => '0');
 SIGNAL   sram_waddr_int     : STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0)
                                    := (OTHERS => '0');
 SIGNAL   wr_data_int       : STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0)
                                    := (OTHERS => '0');
 SIGNAL   wr_en_int         : STD_LOGIC := '0';
 SIGNAL   rd_en_int         : STD_LOGIC := '1';



 --------------------------------------------------------------------------------
 -- START OF ARCHITECTURE behavioral OF sid_bhv_rectangular_block_v5_1
 --------------------------------------------------------------------------------
 
 BEGIN
 
   -- Output delay process
   -- add setup delay to data output signal
   output_t_proc: PROCESS(dout_int,rdy_int,rd_data)
      VARIABLE dout_t   : SID_SYMBOL;
      BEGIN
        IF rdy_int = '1' THEN
            IF c_external_ram=0 THEN
               dout_t := dout_int;
            ELSE
               dout_t := rd_data;
            END IF;    
        ELSE    
            dout_t := (OTHERS => 'X');
        END IF;    
        dout <= dout_t AFTER output_delay;
   END PROCESS;

   --ce process
   ce_proc: PROCESS(ce)
      BEGIN
        IF c_has_ce/=0 THEN
           ce_int <= ce;
        ELSE
           ce_int <= '1';
        END IF;   
   END PROCESS;
 
   --sclr process
   sclr_proc: PROCESS(sclr)
      BEGIN
        IF c_has_sclr/=0 THEN
           sclr_int <= sclr;
        ELSE
           sclr_int <= '0';
        END IF;   
   END PROCESS;
 
   --Powerup process - runs once only
   powerup: PROCESS
      BEGIN
          power <= '1' AFTER 1 ns;
          WAIT;
   END PROCESS; --powerup   
 

   --aclr process
   aclr_proc: PROCESS(power, aclr)
      BEGIN
           IF c_has_aclr/=0 THEN
              aclr_init <= aclr OR NOT power;
           ELSE
              aclr_init <= NOT power;
           END IF;   
    END PROCESS; --aclr_proc   
 
   --Optional rdy process
   optional_rdy: PROCESS(rdy_int)
      BEGIN
        IF c_has_rdy/=0 THEN rdy <= rdy_int AFTER output_delay;
        ELSE rdy <= 'U';
        END IF;   
    END PROCESS;
 
   --Optional rffd process
   optional_rffd: PROCESS(rffd_int)
      BEGIN
        IF c_has_rffd/=0 THEN rffd <= rffd_int AFTER output_delay;
        ELSE rffd <= 'U';
        END IF;   
    END PROCESS;
 

   --Optional rfd process
   optional_rfd: PROCESS(rfd_int)
      BEGIN
        IF c_has_rfd/=0 THEN rfd <= rfd_int AFTER output_delay;
        ELSE rfd <= 'U';
        END IF;   
    END PROCESS;
 
   --nd process
   nd_proc: PROCESS(nd)
      BEGIN
        IF c_has_nd/=0 THEN
           nd_int <= nd;
        ELSE
           nd_int <= '1';
        END IF;   
   END PROCESS;
 
   --Delay data and control inputs

   abort_b_proc: PROCESS(nd_int,fd,rffd_int)
      BEGIN
        v_fd_b  <= fd AND nd_int;
        IF c_has_rffd /= 0 THEN
            abort_b <= fd AND nd_int AND NOT rffd_int;
        ELSE    
            abort_b <= '0';
        END IF;    
   END PROCESS;


  --RD_EN port is always '1'
  rd_en <= '1';


  --WR_EN PORT process
  wr_en_port: PROCESS(wr_en_int)
     BEGIN
       IF c_external_ram/=0 THEN
          wr_en <= wr_en_int AFTER output_delay;
       ELSE
          wr_en <= 'U';
       END IF;   
  END PROCESS;

  --WR_DATA PORT process
  wr_data_port: PROCESS(wr_data_int)
     BEGIN
       IF c_external_ram/=0 THEN
          wr_data <= wr_data_int AFTER output_delay;
       ELSE
          wr_data <= (OTHERS=>'U');
       END IF;   
  END PROCESS;

  --RD_ADDR PORT process
  --Note - Memory is single port, so rd_addr is identical to wr_addr
  rd_addr_port: PROCESS(sram_raddr_int,sram_waddr_int,rd_en_int,wr_en_int)
     BEGIN
       IF c_external_ram/=0 THEN
          IF wr_en_int='1' THEN
             rd_addr <= sram_waddr_int AFTER output_delay;
          ELSIF rd_en_int='1' THEN
             rd_addr <= sram_raddr_int AFTER output_delay;
          ELSE
             rd_addr <= (OTHERS=>'X') AFTER output_delay;
          END IF;
       ELSE
          rd_addr <= (OTHERS=>'U');
       END IF;   
  END PROCESS;


  --WR_ADDR PORT process
  --Note - Memory is single port
  --Note - Memory is single port, so wr_addr is identical to rd_addr
  wr_addr_port: PROCESS(sram_raddr_int,sram_waddr_int,rd_en_int,wr_en_int)
     BEGIN
       IF c_external_ram/=0 THEN
          IF wr_en_int='1' THEN
             wr_addr <= sram_waddr_int AFTER output_delay;
          ELSIF rd_en_int='1' THEN
             wr_addr <= sram_raddr_int AFTER output_delay;
          ELSE
             wr_addr <= (OTHERS=>'X') AFTER output_delay;
          END IF;
       ELSE
          wr_addr <= (OTHERS=>'U');
       END IF;   
  END PROCESS;


   delsigs: PROCESS(clk,aclr_init)
      BEGIN
        IF power /= '1' THEN
           nd_0 <= '0';
           nd_del <= '0';
           din_0  <= (OTHERS =>'0');
           din_del  <= (OTHERS =>'0');
           din_0  <= (OTHERS =>'0');
           din_1  <= (OTHERS =>'0');
           v_fd_0 <= '0';
           v_fd_del <= '0';
           row_0 <= (OTHERS =>'0');
           row_sel_0 <= (OTHERS =>'0');
           col_0 <= (OTHERS =>'0');
           col_sel_0 <= (OTHERS =>'0');
           block_size_0 <= (OTHERS =>'0');
        ELSIF aclr_init = '1' THEN
           v_fd_0 <= '0';
           v_fd_del <= '0';
           nd_del <= '0';
           abort_0 <= '0';
        ELSIF clk'event AND clk = '1' THEN
           IF ce_int = '1' THEN
               nd_del <= nd_0;
               din_del <= din_0;
               din_1 <= din_0;
               IF nd_int = '1' THEN
                   din_0 <= din;
               END IF;    
               nd_0 <= nd_int;
               row_0 <= row;
               row_sel_0 <= row_sel;
               col_0 <= col;
               col_sel_0 <= col_sel;
               block_size_0 <= block_size;
               IF sclr_int = '1' THEN
                   v_fd_del <= '0';
                   v_fd_0  <= '0';
                   abort_0 <= '0';
               ELSE
                   v_fd_del <= v_fd_0;
                   v_fd_0  <= v_fd_b;
                   abort_0 <= abort_b;
               END IF;    
           END IF;    
        END IF;   
   END PROCESS;
 
   --Optional row_sel_valid process
   optional_row_sel_valid: PROCESS(row_sel_valid_int)
      BEGIN
        IF c_has_row_sel_valid/=0 THEN row_sel_valid <= row_sel_valid_int AFTER output_delay;
        ELSE row_sel_valid <= 'U';
        END IF;   
    END PROCESS;
 
   --Optional col_sel_valid process
   optional_col_sel_valid: PROCESS(col_sel_valid_int)
      BEGIN
        IF c_has_col_sel_valid/=0 THEN col_sel_valid <= col_sel_valid_int AFTER output_delay;
        ELSE col_sel_valid <= 'U';
        END IF;   
    END PROCESS;
 
   --Optional row_valid process
   optional_row_valid: PROCESS(row_valid_int)
      BEGIN
        IF c_has_row_valid/=0 THEN row_valid <= row_valid_int AFTER output_delay;
        ELSE row_valid <= 'U';
        END IF;   
    END PROCESS;
 
   --Optional col_valid process
   optional_col_valid: PROCESS(col_valid_int)
      BEGIN
        IF c_has_col_valid/=0 THEN col_valid <= col_valid_int AFTER output_delay;
        ELSE col_valid <= 'U';
        END IF;   
    END PROCESS;
 
   --Optional block_size_valid process
   optional_block_size_valid: PROCESS(block_size_valid_int)
      BEGIN
        IF c_has_block_size_valid/=0 THEN block_size_valid <= block_size_valid_int AFTER output_delay;
        ELSE block_size_valid <= 'U';
        END IF;   
    END PROCESS;
 
   --Optional block_start process
   optional_block_start: PROCESS(block_start_int)
      BEGIN
        IF c_has_block_start/=0 THEN block_start <= block_start_int AFTER output_delay;
        ELSE block_start <= 'U';
        END IF;   
    END PROCESS;
 
   --Optional block_end process
   optional_block_end: PROCESS(block_end_int)
      BEGIN
        IF c_has_block_end/=0 THEN block_end <= block_end_int AFTER output_delay;
        ELSE block_end <= 'U';
        END IF;   
    END PROCESS;
 
 

 
   --Symbol Memory Process
   smem_proc: PROCESS(clk,aclr_init,power)


      --delay between fd and rffd if inputs not valid.
      CONSTANT rffd_delay          : NATURAL := xvalid_buffer_length + 2;
      CONSTANT read                : BOOLEAN := TRUE;
      CONSTANT write               : BOOLEAN := NOT read;

      VARIABLE fsm_state_rdy       : FSM_STATE_TYPE;
      VARIABLE fsm_state_rfd       : FSM_STATE_TYPE;
      VARIABLE smem                : MEM :=(OTHERS => (OTHERS => '0'));
      VARIABLE dout_buffer         : OPBUF;
      VARIABLE din_buffer          : IPBUF :=(OTHERS => (OTHERS => '0'));
      VARIABLE sram_raddr_buffer   : MEM_ADDRESS_BUF := (OTHERS => 0);
      VARIABLE sram_waddr_buffer   : MEM_ADDRESS_BUF := (OTHERS => 0);
      VARIABLE wr_en_buffer        : STD_LOGIC_VECTOR (0 TO wr_en_buffer_length) := (OTHERS => '0');
      VARIABLE rd_en_buffer        : STD_LOGIC_VECTOR (0 TO rd_en_buffer_length) := (OTHERS => '1');
      VARIABLE rdy_buffer          : STD_LOGIC_VECTOR (0 TO output_buffer_length);

      VARIABLE block_size_valid_buffer       : STD_LOGIC_VECTOR (0 TO xvalid_buffer_length);
      VARIABLE row_valid_buffer       : STD_LOGIC_VECTOR (0 TO xvalid_buffer_length);
      VARIABLE v_fd_buffer            : STD_LOGIC_VECTOR (0 TO xvalid_buffer_length) := (OTHERS => '0');
      VARIABLE row_sel_valid_buffer   : STD_LOGIC_VECTOR (0 TO xvalid_buffer_length);
      VARIABLE col_valid_buffer       : STD_LOGIC_VECTOR (0 TO xvalid_buffer_length);
      VARIABLE col_sel_valid_buffer   : STD_LOGIC_VECTOR (0 TO xvalid_buffer_length);
      VARIABLE all_valid_buffer       : STD_LOGIC_VECTOR (0 TO xvalid_buffer_length);


      VARIABLE v_fd_rdy        : STD_LOGIC;
      VARIABLE nd_rdy          : STD_LOGIC;

      VARIABLE smem_block_end : STD_LOGIC;
      VARIABLE write_done     : STD_LOGIC;
      VARIABLE read_done      : STD_LOGIC;
      VARIABLE rdy_set        : STD_LOGIC;
      VARIABLE rdy_clr        : STD_LOGIC;
      VARIABLE rdy_abort      : STD_LOGIC;
      VARIABLE rdy_valid      : STD_LOGIC;
      VARIABLE rdy_set_buffer : STD_LOGIC_VECTOR (0 TO output_buffer_length);
      VARIABLE rdy_clr_buffer : STD_LOGIC_VECTOR (0 TO output_buffer_length);
      VARIABLE rdy_abort_buffer : STD_LOGIC_VECTOR (0 TO output_buffer_length);
      VARIABLE rdy_valid_buffer : STD_LOGIC_VECTOR (0 TO output_buffer_length);
      VARIABLE block_end_buffer : STD_LOGIC_VECTOR (0 TO output_buffer_length);


      VARIABLE col_length_vector   : INTEGER_VECTOR (0 TO max_num_cols-1);
      VARIABLE i                   : NATURAL;
      VARIABLE rfd_read            : STD_LOGIC;
      VARIABLE rfd_write           : STD_LOGIC;
      VARIABLE rfd_wcount          : NATURAL;
      VARIABLE rfd_rcount          : NATURAL;
      VARIABLE wcount              : NATURAL := 0;
      VARIABLE wri,p_wri           : NATURAL := 0;
      VARIABLE wci,p_wci           : NATURAL := 0;
      VARIABLE rcount              : NATURAL := 0;
      VARIABLE rri,p_rri           : NATURAL := 0;
      VARIABLE rci,p_rci           : NATURAL := 0;
      VARIABLE smem_waddr          : MEM_ADDRESS;
      VARIABLE smem_raddr          : MEM_ADDRESS;

      VARIABLE selected_num_rows   : NATURAL RANGE 0 TO max_num_rows :=1;
      VARIABLE selected_num_cols   : NATURAL RANGE 0 TO max_num_cols :=1;
      VARIABLE selected_block_size : NATURAL RANGE 0 TO max_block_size :=1;
      VARIABLE max_wcount          : NATURAL;
      VARIABLE max_rcount          : NATURAL;
      VARIABLE selected_row_pv_offset : NATURAL RANGE 0 TO max_total_row_permute_vals;
      VARIABLE selected_col_pv_offset : NATURAL RANGE 0 TO max_total_col_permute_vals;
      VARIABLE all_valid           : STD_LOGIC;
      VARIABLE rdy_old             : STD_LOGIC;
      VARIABLE all_valid_rfd       : STD_LOGIC; --all_valid, delayed by xvalid_buffer_length
      VARIABLE abort_rfd           : STD_LOGIC;
      VARIABLE rfd_valid           : STD_LOGIC;
      VARIABLE sram_raddr_int_d    : MEM_ADDRESS := 0;
      VARIABLE sram_waddr_int_d    : MEM_ADDRESS := 0;
      VARIABLE selected_num_rows_rdy : NATURAL RANGE 0 TO max_num_rows :=1;
      VARIABLE selected_num_cols_rdy : NATURAL RANGE 0 TO max_num_cols :=1;
      VARIABLE selected_block_size_rdy : NATURAL RANGE 0 TO max_block_size :=1;
      VARIABLE max_wcount_rdy          : NATURAL;
      VARIABLE max_rcount_rdy          : NATURAL;
      VARIABLE selected_row_pv_offset_rdy : NATURAL RANGE 0 TO max_total_row_permute_vals;
      VARIABLE selected_col_pv_offset_rdy : NATURAL RANGE 0 TO max_total_col_permute_vals;
      VARIABLE all_valid_rdy           : STD_LOGIC;
      VARIABLE invalid_block_size  : BOOLEAN;
      VARIABLE smem_dout           : SID_SYMBOL;

      VARIABLE row_nat             : NATURAL RANGE 0 TO 2**c_row_width-1;
      VARIABLE row_is_valid        : STD_LOGIC;
      VARIABLE row_sel_nat         : NATURAL RANGE 0 TO 2**row_sel_width-1;
      VARIABLE row_sel_is_valid    : STD_LOGIC;
      VARIABLE col_nat             : NATURAL RANGE 0 TO 2**c_col_width-1;
      VARIABLE col_is_valid        : STD_LOGIC;
      VARIABLE col_sel_nat         : NATURAL RANGE 0 TO 2**col_sel_width-1;
      VARIABLE col_sel_is_valid    : STD_LOGIC;
      VARIABLE block_size_nat      : NATURAL RANGE 0 TO 2**c_block_size_width-1;
      VARIABLE block_size_is_valid : STD_LOGIC := '1';




      PROCEDURE init_vars IS
          BEGIN
               fsm_state_rdy := IDLE;
               fsm_state_rfd := IDLE;
               rffd_int <= '1';
               rfd_int <= '1';
               rfd_wcount := 0;
               rfd_rcount := 0;
               rfd_read := '0';
               rfd_write := '0';

               selected_num_rows := max_num_rows;
               selected_num_cols := max_num_cols;
               selected_block_size := max_block_size;
               max_wcount := selected_block_size-1;
               max_rcount := selected_block_size-1;
               selected_row_pv_offset :=0;
               selected_col_pv_offset :=0;
               rdy_old := '0';
               all_valid := '1';
               all_valid_rfd := '1';
               abort_rfd := '0';
               rfd_valid := '1';
               row_nat := 0;
               row_sel_nat := 0;
               col_nat := 0;
               col_sel_nat := 0;
               block_size_nat := 0;
               rdy_buffer := (OTHERS => '0');
               rdy_int <= '0';
               row_is_valid := '1';
               row_valid_int <= '1';
               row_sel_is_valid := '1';
               row_sel_valid_int <= '1';
               block_size_valid_buffer := (OTHERS => '1');
               row_valid_buffer := (OTHERS => '1');
               row_sel_valid_buffer := (OTHERS => '1');
               col_valid_buffer := (OTHERS => '1');
               col_sel_valid_buffer := (OTHERS => '1');
               v_fd_buffer := (OTHERS => '0');
               all_valid_buffer := (OTHERS => '1');
               col_is_valid := '1';
               col_valid_int <= '1';
               col_sel_is_valid := '1';
               col_sel_valid_int <= '1';

               block_size_is_valid := '1';
               block_size_valid_int <= '1';
               block_start_int <= '0';
               block_end_int <= '0';

               write_done     := '0';
               read_done      := '0';
               smem_block_end := '0';
               rdy_set        := '0';
               rdy_clr        := '0';
               rdy_abort      := '0';
               rdy_set_buffer := (OTHERS => '0');
               rdy_clr_buffer := (OTHERS => '0');
               rdy_abort_buffer := (OTHERS => '0');
               rdy_valid_buffer := (OTHERS => '1');
               block_end_buffer := (OTHERS => '0');

               selected_num_rows_rdy := selected_num_rows;
               selected_num_cols_rdy := selected_num_cols;
               selected_block_size_rdy := selected_block_size;
               all_valid_rdy := '1';
               max_wcount_rdy := max_wcount;
               max_rcount_rdy := max_rcount;
               selected_row_pv_offset_rdy := selected_row_pv_offset;
               selected_col_pv_offset_rdy := selected_col_pv_offset;


          END init_vars;
 

      PROCEDURE load_sel_params IS
          BEGIN
            all_valid := '1';
            -- all_valid will go false if any one of the required input values is
            -- out of range.
            -- Note: is_x is in std_logic_1164. Returns TRUE if value is U|X|Z|W|-.
            -- This is required to cater for the case where the input is indeterminate.
            -- In which case all_valid must also go indeterminate.

            rfd_valid := '1';
            -- rfd_valid will go false if the conditions for rfd and rffd 
            -- being determinate are met.

            CASE c_row_type IS
               WHEN c_constant =>
                        selected_num_rows := c_row_constant;
                        row_valid_int <= 'X';  --Not relevant. Don't care.
               WHEN c_variable => 
                        IF is_x(row) THEN
                           all_valid := 'X';
                           row_is_valid := 'X';
                        ELSE   
                            row_nat := std_logic_vector_to_natural(row);
                            IF row_nat < c_min_num_rows THEN
                               all_valid := '0';
                               row_is_valid := '0';
                            ELSE
                               row_is_valid := '1';
                            END IF;
                            selected_num_rows := row_nat;
                        END IF;       
               WHEN c_selectable => 
                        IF is_x(row_sel) THEN
                           all_valid := 'X';
                           row_sel_is_valid := 'X';
                        ELSE   
                            row_sel_nat := std_logic_vector_to_natural(row_sel);
                            IF row_sel_nat > c_num_selectable_rows-1 THEN
                               row_sel_is_valid := '0';
                               all_valid := '0';
                               --If not valid, default to row_select_vector(0)
                               selected_num_rows := row_select_vector(0);
                            ELSE   
                               row_sel_is_valid := '1';
                               selected_num_rows := row_select_vector(row_sel_nat);
                               IF c_use_row_permute_file = 1 THEN
                                  selected_row_pv_offset := row_permute_offset_vector(row_sel_nat);
                               END IF;   
                            END IF;   
                        END IF;       
               WHEN OTHERS => NULL;
            END CASE;
               
            CASE c_col_type IS
               WHEN c_constant =>
                        selected_num_cols := c_col_constant;
                        col_valid_int <= 'X';  --Not relevant. Don't care.
               WHEN c_variable => 
                        IF is_x(col) THEN
                           all_valid := 'X';
                           col_is_valid := 'X';
                        ELSE   
                            col_nat := std_logic_vector_to_natural(col);
                            IF col_nat < c_min_num_cols THEN
                               all_valid := '0';
                               col_is_valid := '0';
                            ELSE
                               col_is_valid := '1';
                            END IF;
                            selected_num_cols := col_nat;
                        END IF;       
               WHEN c_selectable => 
                        IF is_x(col_sel) THEN
                           all_valid := 'X';
                           col_sel_is_valid := 'X';
                        ELSE   
                            col_sel_nat := std_logic_vector_to_natural(col_sel);
                            IF col_sel_nat > c_num_selectable_cols-1 THEN
                               col_sel_is_valid := '0';
                               all_valid := '0';
                               --If not valid, default to col_select_vector(0)
                               selected_num_cols := col_select_vector(0);
                            ELSE   
                               col_sel_is_valid := '1';
                               selected_num_cols := col_select_vector(col_sel_nat);
                               IF c_use_col_permute_file = 1 THEN
                                  selected_col_pv_offset := col_permute_offset_vector(col_sel_nat);
                               END IF;   
                            END IF;   
                        END IF;       
               WHEN OTHERS => NULL;
            END CASE;
               

            invalid_block_size := FALSE;
            block_size_is_valid := '1';
            rfd_valid := all_valid;

            CASE c_block_size_type IS
               WHEN c_constant => 
                        selected_block_size := c_block_size_constant;
               WHEN c_row_x_col => 
                        selected_block_size := selected_num_rows * selected_num_cols;
                        IF selected_block_size < 6 THEN
                           selected_block_size := 6;
                           rfd_valid := '0';
                           invalid_block_size := TRUE;
                        END IF;

               WHEN c_variable => 
                        block_size_nat := std_logic_vector_to_natural(block_size);
                        selected_block_size := block_size_nat;
                        --This IF - END IF block checks if the selected block size would
                        --result in unused rows(interleaver) or cols(deinterleaver)
                        IF block_size_nat < (selected_num_rows-1)*selected_num_cols+1 THEN
                            IF max_block_size > (selected_num_rows-1)*selected_num_cols+1 THEN
                               selected_block_size := (selected_num_rows-1)*selected_num_cols+1;
                            ELSE
                               selected_block_size := max_block_size;
                            END IF;
                            invalid_block_size := TRUE;
                            rfd_valid := '0';
                        END IF;    
                        -------------------------------------------------------------------

                        IF block_size_nat > selected_num_rows * selected_num_cols THEN
                            IF max_block_size > selected_num_rows*selected_num_cols THEN
                               selected_block_size := selected_num_rows*selected_num_cols;
                            ELSE
                               selected_block_size := max_block_size;
                            END IF;
                            invalid_block_size := TRUE;
                            rfd_valid := '0';
                        END IF;                  

                        IF selected_block_size < 6 THEN
                            selected_block_size := 6;
                            invalid_block_size := TRUE;
                            rfd_valid := '0';
                        END IF;                  

               WHEN OTHERS => NULL;

            END CASE;

            --If either the row or col is invalid, then the
            --state of block_size_valid will be indeterminate
            IF all_valid /= '1' THEN
                block_size_is_valid := 'X';
            ELSE            
                IF invalid_block_size THEN
                   block_size_is_valid := '0';
                   all_valid := '0';
                ELSE   
                   block_size_is_valid := '1';
                END IF;   
            END IF;

            --constrain to be at least the minimum allowed.
            IF selected_num_rows < abs_min_num_rows THEN
                selected_num_rows := abs_min_num_rows;
            END IF;    

            --constrain to be at least the minimum allowed.
            IF selected_num_cols < abs_min_num_cols THEN
                selected_num_cols := abs_min_num_cols;
            END IF;    

            --limit the selected block_size to selected_num_rows * selected_num_cols
            --so as not to exceed the range of row_pv when not valid
            IF selected_block_size > selected_num_rows * selected_num_cols THEN
                selected_block_size := selected_num_rows * selected_num_cols;
            END IF;

            max_wcount := selected_block_size-1;
            max_rcount := selected_block_size-1;

          END load_sel_params;
 

      PROCEDURE load_sel_params_rdy IS
          BEGIN
                selected_num_rows_rdy := selected_num_rows;
                selected_num_cols_rdy := selected_num_cols;
                selected_block_size_rdy := selected_block_size;
                all_valid_rdy := all_valid;

                IF c_mode = c_interleaver THEN
                    max_wcount_rdy := selected_block_size_rdy-1;
                    max_rcount_rdy := selected_num_rows_rdy * selected_num_cols_rdy-1;
                ELSE
                    max_wcount_rdy := selected_num_rows_rdy * selected_num_cols_rdy-1;
                    max_rcount_rdy := selected_block_size_rdy-1;
                END IF;

                IF all_valid_rdy = '1' THEN
                    selected_row_pv_offset_rdy := selected_row_pv_offset;
                    selected_col_pv_offset_rdy := selected_col_pv_offset;
                    col_length_vector(0 TO selected_num_cols_rdy-1) := calc_col_length_vector(
                                     selected_num_rows_rdy,selected_num_cols_rdy,
                                     selected_block_size_rdy);
                ELSE
                    selected_row_pv_offset_rdy := 0;
                    selected_col_pv_offset_rdy := 0;
                    col_length_vector := (OTHERS => selected_num_rows_rdy);
                END IF;


          END load_sel_params_rdy;
 

      PROCEDURE row_permute(a : IN NATURAL; pa : OUT NATURAL) IS
         BEGIN
             IF c_use_row_permute_file/=0 THEN
                pa := total_row_permute_vector(a+selected_row_pv_offset_rdy);  --Apply permutation
             ELSE
                pa := a; -- no permutation
             END IF;
         END row_permute;

      PROCEDURE col_permute(a : IN NATURAL; pa : OUT NATURAL) IS
         BEGIN
             IF c_use_col_permute_file/=0 THEN
                pa := total_col_permute_vector(a+selected_col_pv_offset_rdy);  --Apply permutation
             ELSE
                pa := a; -- no permutation
             END IF;
         END col_permute;


      PROCEDURE clear_wcount IS
          BEGIN
              wri := 0;
              wci := 0;
              wcount := 0;
              smem_waddr := 0;
          END clear_wcount;


      PROCEDURE clear_rcount IS
          BEGIN
              rri := 0;
              rci := 0;
              rcount := 0;
              IF c_mode=c_interleaver THEN
                 row_permute(rri,p_rri);  --Apply row permutation
                 col_permute(rci,p_rci);  --Apply col permutation
                 smem_raddr := p_rri*selected_num_cols_rdy + p_rci;
              ELSE
                 IF NOT pruned THEN
                    col_permute(rri,p_rri);  --Apply col permutation
                    row_permute(rci,p_rci);  --Apply row permutation
                    smem_raddr := p_rri*selected_num_rows_rdy + p_rci;
                 ELSE
                    smem_raddr := 0;
                 END IF;
              END IF;
          END clear_rcount;


      PROCEDURE next_waddr IS
          BEGIN
                IF wcount = selected_block_size_rdy-1 THEN
                    clear_wcount;
                    clear_rcount;
                    fsm_state_rdy := READING_0;                 --TBD this statement should be part of the fsm
                    IF all_valid_rdy = '1' THEN                 --TBD this statement should be part of the fsm
                        write_done := '1'; --only if all valid  --TBD this statement should be part of the fsm
                    END IF;    
                ELSIF nd_rdy='1' THEN
                    wcount := wcount + 1;        
                END IF;
                smem_waddr := wcount;
          END next_waddr;


      PROCEDURE next_rcount IS
          BEGIN
                IF rcount = selected_block_size_rdy-1 THEN
                    clear_rcount;
                    fsm_state_rdy := IDLE;  --TBD this statement should be part of the fsm
                    read_done := '1';       --TBD this statement should be part of the fsm
                    smem_block_end := '1';  --TBD this statement should be part of the fsm
                ELSE
                    IF c_mode=c_interleaver THEN 
                       --read col-wise with pruning by column-length vector.
                       --Apply permutation.
                       IF rri=col_length_vector(rci)-1 THEN
                           rci := rci + 1;
                           rri := 0;
                       ELSE
                           rri := rri + 1;    
                       END IF;
                       row_permute(rri,p_rri);  --Apply row permutation
                       col_permute(rci,p_rci);  --Apply col permutation
                       smem_raddr := p_rri*selected_num_cols_rdy + p_rci;
                    ELSE
                       --For deinterleaver,
                       --read col-wise. With permutation. Only works if not pruned!
                       IF NOT pruned THEN
                           IF rri=selected_num_cols_rdy-1 THEN
                               rci := rci + 1;
                               rri := 0;
                           ELSE
                               rri := rri + 1;
                           END IF;
                           col_permute(rri,p_rri);  --Apply col permutation
                           row_permute(rci,p_rci);  --Apply row permutation
                           smem_raddr := p_rri*selected_num_rows_rdy + p_rci;
                       ELSE
                           IF rri=selected_num_cols_rdy-1 THEN
                               rci := rci + 1;
                               rri := 0;
                               smem_raddr := rci;
                           ELSE
                               smem_raddr := smem_raddr + col_length_vector(rri);
                               rri := rri + 1;
                           END IF;
                       END IF;
                    END IF;       
                    rcount := rcount + 1;        
                END IF;       
          END next_rcount;


      BEGIN

        IF power /= '1' THEN
             init_vars;
             wr_en_int <=  '0';
     	     wr_en_buffer := (OTHERS => '0');
             wr_en_int <=  '0';
     	     rd_en_buffer := (OTHERS => '0');
             rd_en_int <=  '0';

        ELSIF c_has_aclr=1 AND aclr = '1' THEN
             init_vars;
     	     wr_en_buffer := (OTHERS => 'X');
             wr_en_int <=  'X';
     	     rd_en_buffer := (OTHERS => 'X');
             rd_en_int <=  'X';

        ELSIF clk'event AND clk = '1' THEN
           IF ce_int = '1' THEN
               IF sclr_int = '1' THEN
                   init_vars;
                   
               ELSE

                   rdy_old := rdy_int;

                   --Handle rfd and rffd.
                   --Following a valid fd,
                   --rffd goes to '1' after 'block-size' samples,
                   --plus 'block-size' clocks.


                   CASE fsm_state_rfd IS
                       WHEN IDLE =>
                             abort_rfd := '0';
                       WHEN IDLE_1 =>
                             abort_rfd := v_fd_b;
                       WHEN WRITING =>
                             abort_rfd := v_fd_b;
                             IF rfd_wcount = max_wcount-1 AND nd_int = '1' THEN
                                --the sample now on din will be the last,
                                --after which, we are no longer ready for data
                                rfd_int <= '0';
                             END IF;      
                             IF rfd_wcount = max_wcount THEN
                                --no need for nd, because last sample has now been written
                                rfd_wcount := 0;
                                rfd_rcount := 0;
                                fsm_state_rfd := READING;
                             ELSIF nd_int = '1' THEN
                                rfd_wcount := rfd_wcount+1;
                             END IF;      
                                      
                       WHEN READING =>
                             abort_rfd := v_fd_b;
                             IF rfd_rcount = (selected_block_size-1)-1 THEN
                                --the next value now on dout will be the last,
                                --so we are ready for new data
                                rfd_int <= '1';
                                rffd_int <= '1';
                             END IF;      
                             IF rfd_rcount = (selected_block_size-1) THEN
                                rfd_rcount := 0;
                                fsm_state_rfd := IDLE;
                                abort_rfd := '0'; --if here, a v_fd_b is not an abort
                             ELSE
                                rfd_rcount := rfd_rcount + 1;
                             END IF;      

                       WHEN OTHERS => null;
                   END CASE;    

                   -- x_valid indicates when row_valid, col_valid, row_sel_valid, col_sel_valid
                   --and block_size_valid are asserted. 

                   --if something is invalid, assert rffd and rfd after rffd delay
                   --one clock after all_valid_rfd is deasserted.
                   IF all_valid_rfd = '0' THEN
                       IF (c_has_row_valid=1 AND row_valid_int = '0') OR
                          (c_has_col_valid=1 AND col_valid_int = '0') OR
                          (c_has_row_sel_valid=1 AND row_sel_valid_int = '0') OR
                          (c_has_col_sel_valid=1 AND col_sel_valid_int = '0') OR
                          (c_has_block_size_valid=1 AND block_size_valid_int = '0') THEN
                           rffd_int <= '1';
                           rfd_int <= '1';
                       ELSE --if here, something is invalid, for which there is 
                           -- no *valid pin, so rffd and rfd are undefined.
                           rffd_int <= 'X';
                           rfd_int <= 'X';
                       END IF;
                       fsm_state_rfd := IDLE_1;
                   END IF;

                   --block_size_valid is updated a few clock cycles after the latest v_fd_b
                   IF v_fd_buffer(xvalid_buffer_length-1) = '1' THEN
                      block_size_valid_int <= block_size_valid_buffer(xvalid_buffer_length-1);
                   END IF;   
                   FOR n IN xvalid_buffer_length-1 DOWNTO 0 LOOP
                       v_fd_buffer(n+1) := v_fd_buffer(n);
                   END LOOP;
                   IF abort_b /= '0' THEN  --i.e if 0 or X
                       block_size_valid_buffer := (OTHERS => 'X');
                       block_size_valid_int <= 'X';
                   END IF;    

                   IF v_fd_b = '1' THEN
                            load_sel_params;
                            all_valid_buffer := (OTHERS => '1');
                            rffd_int <= '0';
                            rfd_wcount := 0;
                            rfd_rcount := 0;
                            IF all_valid /= '1' THEN
                               fsm_state_rfd := IDLE_1;
                               rfd_int <= 'X';
                            ELSE
                               fsm_state_rfd := WRITING;
                               rfd_int <= '1';
                            END IF;
                   END IF;

                   v_fd_buffer(0) := v_fd_b;


                   IF rfd_valid = '0' AND v_fd_b /= '1' THEN
                       --The conditions for rffd and rfd being determinate are not
                       --met.
                       --Note that rffd=0 and rfd=1 always immediately after valid fd
                       rffd_int <= 'X';
                       rfd_int <= 'X';
                   END IF;
                     

                   all_valid_rfd := all_valid_buffer(xvalid_buffer_length-1);
                   FOR n IN xvalid_buffer_length-1 DOWNTO 0 LOOP
                       all_valid_buffer(n+1) := all_valid_buffer(n);
                   END LOOP;
                   all_valid_buffer(0) := all_valid;
                   
                   
                   --Shift the xvalid FIFO.
                   row_valid_int <= row_valid_buffer(xvalid_buffer_length-1);
                   row_sel_valid_int <= row_sel_valid_buffer(xvalid_buffer_length-1);
                   col_valid_int <= col_valid_buffer(xvalid_buffer_length-1);
                   col_sel_valid_int <= col_sel_valid_buffer(xvalid_buffer_length-1);
                   FOR n IN xvalid_buffer_length-1 DOWNTO 0 LOOP
                       block_size_valid_buffer(n+1) := block_size_valid_buffer(n);
                       row_valid_buffer(n+1) := row_valid_buffer(n);
                       row_sel_valid_buffer(n+1) := row_sel_valid_buffer(n);
                       col_valid_buffer(n+1) := col_valid_buffer(n);
                       col_sel_valid_buffer(n+1) := col_sel_valid_buffer(n);
                   END LOOP;
                   block_size_valid_buffer(0) := block_size_is_valid;
                   row_valid_buffer(0) := row_is_valid;
                   row_sel_valid_buffer(0) := row_sel_is_valid;
                   col_valid_buffer(0) := col_is_valid;
                   col_sel_valid_buffer(0) := col_sel_is_valid;
                   



                   smem_dout := smem(smem_raddr);

                   v_fd_rdy := v_fd_0;
                   nd_rdy := nd_0;

                   IF fsm_state_rdy = IDLE THEN
                       read_done := '0';
                       smem_block_end := '0';
                       IF v_fd_rdy = '1' THEN
                           load_sel_params_rdy;
                           clear_wcount;
                           clear_rcount;
                           fsm_state_rdy := WRITING;
                       END IF;    

                   ELSIF fsm_state_rdy = START THEN
                       read_done := '0';
                       smem_block_end := '0';

                       IF symbol_mem_style = c_distmem THEN
                           --read before write
                           smem_dout := smem(smem_waddr);
                           smem(smem_waddr) := din_del;
                       ELSE
                           --write before read
                           smem_dout := din_del;
                           smem(smem_waddr) := din_del;
                       END IF;

                       IF v_fd_rdy = '1' THEN
                           load_sel_params_rdy;
                           clear_wcount;
                           fsm_state_rdy := WRITING;
                       ELSE    
                           --update the write address
                           next_waddr;
                           IF nd_rdy = '1' THEN --nothing happens unless nd_rdy is asserted
                               fsm_state_rdy := WRITING;
                           END IF;  --nd_rdy 
                       END IF;    

                   ELSIF fsm_state_rdy = WRITING THEN
                       read_done := '0';
                       smem_block_end := '0';

                       IF symbol_mem_style = c_distmem THEN
                           --read before write
                           smem_dout := smem(smem_waddr);
                           smem(smem_waddr) := din_del;
                       ELSE
                           --write before read
                           smem_dout := din_del;
                           smem(smem_waddr) := din_del;
                       END IF;

                       IF v_fd_rdy = '1' THEN
                           load_sel_params_rdy;
                           write_done := '0';
                           clear_wcount;
                           fsm_state_rdy := WRITING;
                       ELSE
                           next_waddr;
                       END IF;    


                   ELSIF fsm_state_rdy = READING_0 THEN
                       write_done := '0';
                       IF v_fd_rdy = '1' THEN
                           load_sel_params_rdy;
                           clear_wcount;
                           clear_rcount;
                           read_done := '1';
                           fsm_state_rdy := START;
                       ELSE
                           next_rcount;
                           fsm_state_rdy := READING_1;
                       END IF;    

                   ELSIF fsm_state_rdy = READING_1 THEN
                       IF v_fd_rdy = '1' THEN
                           next_rcount;
                           IF rcount=0 THEN
                              load_sel_params_rdy;
                              clear_wcount;
                              clear_rcount;
                              fsm_state_rdy := WRITING;
                           ELSE
                              load_sel_params_rdy;
                              clear_wcount;
                              clear_rcount;
                              fsm_state_rdy := START;
                           END IF;
                           read_done := '1';   
                       ELSE
                           next_rcount;
                       END IF;    

                   END IF; --fsm_state_rdy   

                   IF v_fd_rdy = '1' THEN
  	                   rdy_abort_buffer := (OTHERS => '0');
                   END IF;        

                   IF write_done = '1' THEN
  	                   rdy_set_buffer := (OTHERS => '0');
                   END IF;

                   IF read_done = '1' THEN
  	                   rdy_clr_buffer := (OTHERS => '0');
                   END IF;

                   rdy_abort := rdy_abort_buffer(output_buffer_length-1);
                   rdy_valid := rdy_valid_buffer(output_buffer_length-1);
                   rdy_set := rdy_set_buffer(output_buffer_length-1);
                   rdy_clr := rdy_clr_buffer(output_buffer_length-1);
                   FOR n IN output_buffer_length-1 DOWNTO 0 LOOP
                       rdy_set_buffer(n+1) := rdy_set_buffer(n);
                       rdy_clr_buffer(n+1) := rdy_clr_buffer(n);
                       rdy_abort_buffer(n+1) := rdy_abort_buffer(n);
                       rdy_valid_buffer(n+1) := rdy_valid_buffer(n);
                       block_end_buffer(n+1) := block_end_buffer(n);
                   END LOOP;
                   rdy_set_buffer(0) := write_done;
                   rdy_clr_buffer(0) := read_done;
                   block_end_buffer(0) := smem_block_end;
                   rdy_abort_buffer(0) := v_fd_rdy;
                   rdy_valid_buffer(0) := all_valid_rdy;

                   IF rdy_valid/='1' THEN
                       rdy_int <= 'X';
                       block_end_int <= 'X';
                       block_start_int <= 'X';
                   ELSE
                       IF rdy_abort = '1' THEN
                           rdy_int <= '0';
  	                       block_end_buffer := (OTHERS => '0');
                       ELSIF rdy_set = '1' THEN
                           rdy_int <= '1';
                       ELSIF rdy_clr = '1' THEN
                           rdy_int <= '0';
                       END IF;        
                       block_end_int <= block_end_buffer(output_buffer_length-1);
                       block_start_int <= rdy_set;
                   END IF;        



                   --Shift the output FIFO.
                   dout_buffer(0) := smem_dout;
                   dout_int <= dout_buffer(output_buffer_length-1);
                   FOR n IN output_buffer_length-1 DOWNTO 0 LOOP
                       dout_buffer(n+1) := dout_buffer(n);
                   END LOOP;


               END IF; --sclr   

               IF c_external_ram/=0 THEN

                   --Shift the input FIFO.
                   wr_data_int <= din_buffer(input_buffer_length-1);
                   FOR n IN input_buffer_length-1 DOWNTO 0 LOOP
                       din_buffer(n+1) := din_buffer(n);
                   END LOOP;
                   IF nd_int='1' THEN
                       IF all_valid='1' THEN
                           din_buffer(0) := din;
                       ELSE    
                           --if here, deliberately write garbage into the ram
                           --to highlight an invalid block;
                           din_buffer(0) := (OTHERS=>'1');
                       END IF;
                   END IF;    

                   FOR n IN addr_buffer_length-1 DOWNTO 0 LOOP
                       sram_raddr_buffer(n+1) := sram_raddr_buffer(n);
                   END LOOP;
     	           sram_raddr_buffer(0) := smem_raddr;
                   sram_raddr_int <= integer_to_std_logic_vector(sram_raddr_int_d,c_ext_addr_width);
                   sram_raddr_int_d := sram_raddr_buffer(addr_buffer_length-1);

                   FOR n IN addr_buffer_length-1 DOWNTO 0 LOOP
                       sram_waddr_buffer(n+1) := sram_waddr_buffer(n);
                   END LOOP;
     	           sram_waddr_buffer(0) := smem_waddr;
                   sram_waddr_int <= integer_to_std_logic_vector(sram_waddr_int_d,c_ext_addr_width);
                   sram_waddr_int_d := sram_waddr_buffer(addr_buffer_length-1);


                   FOR n IN wr_en_buffer_length-1 DOWNTO 0 LOOP
                       wr_en_buffer(n+1) := wr_en_buffer(n);
                   END LOOP;
                   -- If something is invalid, the timing of 
                   -- wr_en is indeterminate.
                   IF all_valid_rdy/='1' THEN
                       wr_en_buffer(0) := 'X';
                   ELSIF (fsm_state_rdy = WRITING) OR (fsm_state_rdy = START) THEN
                       wr_en_buffer(0) := '1';
                   ELSE
     	               wr_en_buffer(0) := '0';
                   END IF;    

                   wr_en_int <=  wr_en_buffer(wr_en_buffer_length-1);

                   FOR n IN rd_en_buffer_length-1 DOWNTO 0 LOOP
                       rd_en_buffer(n+1) := rd_en_buffer(n);
                   END LOOP;
                   -- If something is invalid, the timing of 
                   -- rd_en is indeterminate.
                   IF all_valid_rdy/='1' THEN
                       rd_en_buffer(0) := 'X';
                   ELSIF (fsm_state_rdy = READING_0) OR (fsm_state_rdy = READING_1) THEN
                       rd_en_buffer(0) := '1';
                   ELSE
     	               rd_en_buffer(0) := '0';
                   END IF;    
                   rd_en_int <=  rd_en_buffer(rd_en_buffer_length-1);

               END IF;    

               -- If abort during read, and
               -- something is invalid, the timing of 
               -- rd_en, rdy, block_start and block_end is indeterminate.
               -- No alternative but to make them all X.
               IF (all_valid_rdy/= '1'
                     AND v_fd_b = '1' 
                     AND v_fd_0 = '0'
                     AND v_fd_rdy = '0'
                     AND rdy_old/='0') THEN
                   rd_en_int <= 'X';
  	               rd_en_buffer := (OTHERS => 'X');
                   rdy_int <= 'X';
                   rdy_set := 'X';
                   rdy_clr := 'X';
   	               rdy_set_buffer := (OTHERS => 'X');
   	               rdy_clr_buffer := (OTHERS => 'X');
  	               block_end_buffer := (OTHERS => 'X');
                   block_start_int <= 'X';
                   block_end_int <= 'X';
               END IF;    

           ELSE
               --This statement is needed because the write enable to distributed memory
               --is not gated with ce_int. The contents of the current address will
               --change even if ce_int is '0'.
               IF (fsm_state_rdy = WRITING) OR (fsm_state_rdy = START) THEN
                   smem(smem_waddr) := din_del;
               END IF;    

           END IF; --ce_int   

        END IF; -- clk

   END PROCESS;

END behavioral;



---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
--                                                                          ---*
--        TOP LEVEL ENTITY FOR FORNEY INTERLEAVER / DEINTERLEAVER           ---*
--                                                                          ---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY xilinxcorelib;
USE xilinxcorelib.sid_const_pkg_behav_v5_1.ALL;
USE xilinxcorelib.sid_pkg_behav_v5_1.ALL;


--core_if on entity
  entity sid_v5_1 is
    GENERIC (
      c_xdevicefamily : STRING := "find_05241217";  -- specifies target Xilinx FPGA family
      c_family       : STRING := "virtex2";
      c_architecture : INTEGER :=  0;
      c_mem_init_prefix : STRING :=  "sid1";
      c_elaboration_dir : STRING  := "./";
      c_type : INTEGER :=  40;
      c_mode : INTEGER :=  0;
      c_symbol_width : INTEGER :=  1;
      c_row_type : INTEGER :=  0;
      c_row_constant : INTEGER :=  16;
      c_has_row : INTEGER :=  0;
      c_has_row_valid : INTEGER :=  1;
      c_min_num_rows : INTEGER :=  2;
      c_row_width : INTEGER :=  4;
      c_num_selectable_rows : INTEGER :=  4;
      c_row_select_file : STRING :=  "null.mif";
      c_has_row_sel : INTEGER :=  0;
      c_has_row_sel_valid : INTEGER :=  0;
      c_use_row_permute_file : INTEGER :=  0;
      c_row_permute_file : STRING :=  "null.mif";
      c_col_type : INTEGER :=  0;
      c_col_constant : INTEGER :=  16;
      c_has_col : INTEGER :=  0;
      c_has_col_valid : INTEGER :=  1;
      c_min_num_cols : INTEGER :=  2;
      c_col_width : INTEGER :=  4;
      c_num_selectable_cols : INTEGER :=  4;
      c_col_select_file : STRING :=  "null.mif";
      c_has_col_sel : INTEGER :=  0;
      c_has_col_sel_valid : INTEGER :=  0;
      c_use_col_permute_file : INTEGER :=  0;
      c_col_permute_file : STRING :=  "null.mif";
      c_block_size_type : INTEGER :=  0;
      c_block_size_constant : INTEGER :=  256;
      c_has_block_size : INTEGER :=  0;
      c_block_size_width : INTEGER :=  8;
      c_has_block_size_valid : INTEGER :=  0;
--obsolete       c_seed : INTEGER :=  0;
--obsolete       c_use_spreads : INTEGER :=  0;
--obsolete       c_spread1 : INTEGER :=  1;
--obsolete       c_spread2 : INTEGER :=  1;
--obsolete       c_add_symmetry_constraint : INTEGER :=  0;
--obsolete       c_use_k : INTEGER :=  0;
--obsolete       c_k : INTEGER :=  2;
--obsolete       c_relative_prime : INTEGER :=  1;
      c_num_branches : INTEGER :=  16;
      c_branch_length_type : INTEGER :=  0;
      c_branch_length_constant : INTEGER :=  1;
      c_branch_length_file : STRING :=  "null.mif";
      c_num_configurations : INTEGER :=  1;
--obsolete       c_n1 : INTEGER :=  3;
--obsolete       c_n2 : INTEGER :=  1;
      c_external_ram : INTEGER :=  0;
      c_ext_addr_width : INTEGER :=  900;
      c_memstyle : INTEGER :=  0;
      c_pipe_level : INTEGER :=  0;
      c_throughput_mode : INTEGER :=  0;
      c_enable_rlocs : INTEGER :=  0;
      c_has_ce : INTEGER :=  0;
      c_has_nd : INTEGER :=  0;
      c_has_sclr : INTEGER :=  0;
      c_has_aclr : INTEGER :=  0;
      c_has_rdy : INTEGER :=  0;
      c_has_rfd : INTEGER :=  0;
      c_has_rffd : INTEGER :=  0;
      c_has_block_start : INTEGER :=  0;
      c_has_block_end : INTEGER :=  0;
      c_has_fdo : INTEGER :=  0;
      c_has_ndo : INTEGER :=  0
      );
    PORT (
      clk : IN STD_LOGIC;
      fd : IN STD_LOGIC;
      nd : IN STD_LOGIC :='1';
      din : IN STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);
      ce : IN STD_LOGIC := '1';
      sclr : IN STD_LOGIC := '0';
      aclr : IN STD_LOGIC := '0';
      row : IN STD_LOGIC_VECTOR(c_row_width-1 DOWNTO 0) := (OTHERS=>'0');
      row_sel : IN STD_LOGIC_VECTOR((bits_needed_to_represent(c_num_selectable_rows-1) -1)	DOWNTO 0) := (OTHERS=>'0');
      col : IN STD_LOGIC_VECTOR((c_col_width - 1) DOWNTO 0) := (OTHERS=>'0');
      col_sel : IN STD_LOGIC_VECTOR((bits_needed_to_represent(c_num_selectable_cols-1) -1) DOWNTO 0) := (OTHERS=>'0');
      block_size : IN STD_LOGIC_VECTOR((c_block_size_width-1) DOWNTO 0) := (OTHERS=>'0');
      config_sel : IN STD_LOGIC_VECTOR(select_integer(bits_needed_to_represent(c_num_configurations-1),1, c_num_configurations <= 1) -1 DOWNTO 0) := (OTHERS=>'0');
      new_config : IN STD_LOGIC := '0';
      rd_data : IN STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0) := (OTHERS=>'0');
--obsolete       np : IN STD_LOGIC := '0';
--obsolete       p0 : IN STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS=>'0');
--obsolete       p1 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS=>'0');
--obsolete       p2 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS=>'0');
--obsolete       p3 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS=>'0');
      dout : OUT STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);
      rd_en : OUT STD_LOGIC;
      wr_en : OUT STD_LOGIC;
      rd_addr : OUT STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0);
      wr_addr : OUT STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0);
      wr_data : OUT STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);
      rfd : OUT STD_LOGIC;
      rdy : OUT STD_LOGIC;
      rffd : OUT STD_LOGIC;
      row_valid : OUT STD_LOGIC;
      col_valid : OUT STD_LOGIC;
      row_sel_valid : OUT STD_LOGIC;
      col_sel_valid : OUT STD_LOGIC;
      block_size_valid : OUT STD_LOGIC;
      block_start : OUT STD_LOGIC;
      block_end : OUT STD_LOGIC;
      fdo : OUT STD_LOGIC;
      ndo : OUT STD_LOGIC
      );
--core_if off
END sid_v5_1;

ARCHITECTURE behavioral OF sid_v5_1 IS

--Components
COMPONENT sid_bhv_forney_v5_1
  GENERIC (
    c_mode                 : INTEGER;
    c_symbol_width         : INTEGER;
    -- Forney specific generics
    c_num_branches         : INTEGER;
    c_branch_length_type   : INTEGER;
    c_branch_length_constant : INTEGER;
    c_branch_length_file   : STRING  := "";
    c_has_fdo              : INTEGER;
    c_has_ndo              : INTEGER;
    -- Implementation generics
    c_pipe_level           : INTEGER;
    -- Optional pin generics
    c_has_ce               : INTEGER;
    c_has_sclr             : INTEGER;
    c_has_aclr             : INTEGER;
    c_has_rdy              : INTEGER;
    c_has_rffd             : INTEGER;
    c_has_rfd              : INTEGER;
    --New generics for v4_0
    c_external_ram         : INTEGER;
    c_ext_addr_width       : INTEGER;
    c_num_configurations   : INTEGER);
  PORT (
      -- Mandatory pins
    clk              : IN STD_LOGIC;
    fd               : IN STD_LOGIC;
    nd               : IN STD_LOGIC;
    din              : IN STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);
    -- Optional input pins
    ce               : IN STD_LOGIC;
    sclr             : IN STD_LOGIC;
    aclr             : IN STD_LOGIC;
    -- Mandatory output pins
    dout             : OUT STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);
    -- optional output pins
    rdy              : OUT STD_LOGIC;
    rffd             : OUT STD_LOGIC;
    rfd              : OUT STD_LOGIC;
    fdo              : OUT STD_LOGIC;
    ndo              : OUT STD_LOGIC;
    --New ports for v4_0
    new_config       : IN STD_LOGIC;
    config_sel       : IN STD_LOGIC_VECTOR(
                      select_val(
                      bits_needed_to_represent(c_num_configurations-1),
                      1, c_num_configurations <= 1) -1 DOWNTO 0);
    rd_data          : IN STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0); -- Read data from external RAM
    rd_en            : OUT STD_LOGIC;
    wr_en            : OUT STD_LOGIC;
    rd_addr          : OUT STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0);
    wr_addr          : OUT STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0);
    wr_data          : OUT STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0)); -- Write data to external RAM
END COMPONENT;

COMPONENT sid_bhv_rectangular_block_v5_1
  GENERIC (
          c_family               : STRING;
          c_mode                 : INTEGER;
          c_symbol_width         : INTEGER;
          -- Row specific generics
          c_row_type             : INTEGER;
          c_row_constant         : INTEGER;
          c_has_row              : INTEGER;
          c_has_row_valid        : INTEGER;
          c_min_num_rows         : INTEGER;
          c_row_width            : INTEGER;
          c_num_selectable_rows  : INTEGER;
          c_row_select_file      : STRING  := "";
          c_has_row_sel          : INTEGER;
          c_has_row_sel_valid    : INTEGER;
          c_use_row_permute_file : INTEGER;
          c_row_permute_file     : STRING := "";
          -- Column specific generics
          c_col_type             : INTEGER;
          c_col_constant         : INTEGER;
          c_has_col              : INTEGER;
          c_has_col_valid        : INTEGER;
          c_min_num_cols         : INTEGER;
          c_col_width            : INTEGER;
          c_num_selectable_cols  : INTEGER;
          c_col_select_file      : STRING  := "";
          c_has_col_sel          : INTEGER;
          c_has_col_sel_valid    : INTEGER;
          c_use_col_permute_file : INTEGER;
          c_col_permute_file     : STRING  := "";
          -- Block size specific generics
          c_block_size_type      : INTEGER;
          c_block_size_constant  : INTEGER;
          c_has_block_size       : INTEGER;
          c_block_size_width     : INTEGER;
          c_has_block_size_valid : INTEGER;
          -- Implementation generics
          c_memstyle             : INTEGER;
          c_pipe_level           : INTEGER;
          -- Optional pin generics
          c_has_ce               : INTEGER;
          c_has_nd               : INTEGER;
          c_has_sclr             : INTEGER;
          c_has_aclr             : INTEGER;
          c_has_rdy              : INTEGER;
          c_has_rffd             : INTEGER;
          c_has_rfd              : INTEGER;
          c_has_block_start      : INTEGER;
          c_has_block_end        : INTEGER;
          --New for generics v4_0
          c_architecture         : INTEGER;
          c_external_ram         : INTEGER;
          c_ext_addr_width       : INTEGER);
  PORT (
            -- Mandatory pins
          clk              : IN STD_LOGIC;
          fd               : IN STD_LOGIC;
          din              : IN STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);
          -- Optional input pins
          ce               : IN STD_LOGIC;
          nd               : IN STD_LOGIC;
          sclr             : IN STD_LOGIC;
          aclr             : IN STD_LOGIC;
          row              : IN STD_LOGIC_VECTOR(c_row_width-1 DOWNTO 0);
          row_sel          : IN STD_LOGIC_VECTOR(
                        bits_needed_to_represent(c_num_selectable_rows-1) - 1 DOWNTO 0);
          col              : IN STD_LOGIC_VECTOR(c_col_width-1 DOWNTO 0);
          col_sel          : IN STD_LOGIC_VECTOR(
                        bits_needed_to_represent(c_num_selectable_cols-1) - 1 DOWNTO 0);
          block_size       : IN STD_LOGIC_VECTOR(c_block_size_width-1 DOWNTO 0);
          -- Mandatory output pins
          dout             : OUT STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);
          -- optional output pins
          rfd              : OUT STD_LOGIC;
          rdy              : OUT STD_LOGIC;
          rffd             : OUT STD_LOGIC;
          row_valid        : OUT STD_LOGIC;
          col_valid        : OUT STD_LOGIC;
          row_sel_valid    : OUT STD_LOGIC;
          col_sel_valid    : OUT STD_LOGIC;
          block_size_valid : OUT STD_LOGIC;
          block_start      : OUT STD_LOGIC;
          block_end        : OUT STD_LOGIC;
          --New ports for v4_0
          rd_data          : IN STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0); -- Read data from external RAM
          rd_en            : OUT STD_LOGIC;
          wr_en            : OUT STD_LOGIC;
          rd_addr          : OUT STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0);
          wr_addr          : OUT STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0);
          wr_data          : OUT STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0)); -- Write data to external RAM
END COMPONENT; -- sid_bhv_rectangular_block_v5_1



BEGIN

  -- If c_type is forney, instantiate the forney interleaver/de-interleaver
  -- model

  fi_g: IF c_type = c_forney_convolutional GENERATE
    u1: sid_bhv_forney_v5_1
    GENERIC MAP (
      c_mode                 => c_mode,
      c_symbol_width         => c_symbol_width,
      -- Forney specific generics
      c_num_branches         => c_num_branches,
      c_branch_length_type   => c_branch_length_type,
      c_branch_length_constant => c_branch_length_constant,
      c_branch_length_file   => c_branch_length_file,
      c_has_fdo              => c_has_fdo,
      c_has_ndo              => c_has_ndo,
      -- Implementation generics
      c_pipe_level           => c_pipe_level,
      -- Optional pin generics  -- Optional pin generic
      c_has_ce               => c_has_ce,           
      c_has_sclr             => c_has_sclr,         
      c_has_aclr             => c_has_aclr,         
      c_has_rdy              => c_has_rdy,          
      c_has_rffd             => c_has_rffd,         
      c_has_rfd              => c_has_rfd,         
      --New generics for v4_0
      c_external_ram         => c_external_ram,
      c_ext_addr_width       => c_ext_addr_width,
      c_num_configurations   => c_num_configurations)
    PORT MAP (
      clk              => clk,
      fd               => fd,             
      nd               => nd,             
      din              => din,            
      ce               => ce,             
      sclr             => sclr,           
      aclr             => aclr,           
      dout             => dout,           
      rdy              => rdy,            
      rffd             => rffd,            
      rfd              => rfd,            
      fdo              => fdo,
      ndo              => ndo,
      --New ports for v4_0
      new_config => new_config,
      config_sel => config_sel, --INPUT
      rd_data => rd_data, --INPUT
      rd_en => rd_en,
      wr_en => wr_en,
      rd_addr => rd_addr,
      wr_addr => wr_addr,
      wr_data => wr_data);
  END GENERATE; --fi_g

  -- If c_type is c_rectangular_block, instantiate a 
  -- block interleaver/de-interleaver model

  rbg : IF c_type = c_rectangular_block GENERATE

    -- Rectangular block type
    u1: sid_bhv_rectangular_block_v5_1
    GENERIC MAP (
      c_family               => c_family,
      c_mode                 => c_mode,
      c_symbol_width         => c_symbol_width,
      -- Row specific generics
      c_row_type             =>  c_row_type,
      c_row_constant         =>  c_row_constant,        
      c_has_row              =>  c_has_row,             
      c_has_row_valid        =>  c_has_row_valid,             
      c_min_num_rows         =>  c_min_num_rows,
      c_row_width            =>  c_row_width,           
      c_num_selectable_rows  =>  c_num_selectable_rows, 
      c_row_select_file      =>  c_row_select_file,     
      c_has_row_sel          =>  c_has_row_sel,         
      c_has_row_sel_valid    =>  c_has_row_sel_valid,   
      c_use_row_permute_file =>  c_use_row_permute_file,
      c_row_permute_file     =>  c_row_permute_file,    
      -- Column specific generics
      c_col_type             =>  c_col_type,             
      c_col_constant         =>  c_col_constant,         
      c_has_col              =>  c_has_col,              
      c_has_col_valid        =>  c_has_col_valid,             
      c_min_num_cols         =>  c_min_num_cols,
      c_col_width            =>  c_col_width,            
      c_num_selectable_cols  =>  c_num_selectable_cols,  
      c_col_select_file      =>  c_col_select_file,      
      c_has_col_sel          =>  c_has_col_sel,          
      c_has_col_sel_valid    =>  c_has_col_sel_valid,    
      c_use_col_permute_file =>  c_use_col_permute_file, 
      c_col_permute_file     =>  c_col_permute_file,     
      -- Block size specific generics
      c_block_size_type      => c_block_size_type,     
      c_block_size_constant  => c_block_size_constant, 
      c_has_block_size       => c_has_block_size,      
      c_block_size_width     => c_block_size_width,    
      c_has_block_size_valid => c_has_block_size_valid,
      -- Implementation generics
      c_memstyle             => c_memstyle,
      c_pipe_level           => c_pipe_level,
      -- Optional pin generics  -- Optional pin generic
      c_has_ce               => c_has_ce,           
      c_has_nd               => c_has_nd,           
      c_has_sclr             => c_has_sclr,         
      c_has_aclr             => c_has_aclr,         
      c_has_rdy              => c_has_rdy,          
      c_has_rffd             => c_has_rffd,         
      c_has_rfd              => c_has_rfd,         
      c_has_block_start      => c_has_block_start,  
      c_has_block_end        => c_has_block_end,
      --New generics for v4_0
      c_external_ram         => c_external_ram,
      c_ext_addr_width       => c_ext_addr_width,
      c_architecture         => c_architecture)
    PORT MAP (
      clk              => clk,
      fd               => fd,             
      nd               => nd,             
      din              => din,            
      ce               => ce,             
      sclr             => sclr,           
      aclr             => aclr,           
      row              => row,            
      row_sel          => row_sel,        
      col              => col,            
      col_sel          => col_sel,        
      block_size       => block_size,     
      rfd              => rfd,            
      dout             => dout,           
      rdy              => rdy,            
      rffd             => rffd,            
      row_valid        => row_valid,   
      col_valid        => col_valid,   
      row_sel_valid    => row_sel_valid,   
      col_sel_valid    => col_sel_valid,   
      block_size_valid => block_size_valid,
      block_start      => block_start,     
      block_end        => block_end,       
      --New ports for v4_0
      rd_data => rd_data, --INPUT
      rd_en => rd_en,
      wr_en => wr_en,
      rd_addr => rd_addr,
      wr_addr => wr_addr,
      wr_data => wr_data);
  END GENERATE; -- rbg

END behavioral;

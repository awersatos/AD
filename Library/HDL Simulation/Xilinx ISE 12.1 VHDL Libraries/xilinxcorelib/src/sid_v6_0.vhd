-- $RCSfile: sid_v6_0.vhd,v $
--
--  (c) Copyright 1995-2008, 2010 Xilinx, Inc. All rights reserved.
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
--
-------------------------------------------------------------------------------
-- Behavioural Model
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.bip_utils_pkg_v2_0.all;


---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
--                                                                          ---*
--                PACKAGE sid_const_pkg_behav_v6_0                          ---*
--                                                                          ---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*


package sid_const_pkg_behav_v6_0 is

--Here are constants that may be used in the vhdl
--behavioral model.

-- Assign no_debug as false to enable display of debug info.
  constant no_debug : boolean := true;

  constant abs_max_bm_depth_vx2 : integer := 1048576;  -- Block mem for Vx2
  constant max_dm_depth_vx2     : integer := 131072;   -- Dist mem for Vx2

  constant min_symbol_width             : integer := 1;
  constant max_symbol_width             : integer := 256;
  constant abs_max_num_branches         : integer := 256;
  constant abs_min_num_branches         : integer := 2;
  constant min_branch_length_constant   : integer := 1;
  constant upper_branch_length_constant : integer :=
    2 * (abs_max_bm_depth_vx2 - abs_min_num_branches) /
    (abs_min_num_branches * (abs_min_num_branches-1));

  constant abs_max_num_configurations : integer := 64;
  constant abs_min_num_configurations : integer := 1;


-- c_type constants
  constant c_rectangular_block     : integer := 0;
  constant c_random_block          : integer := 1;
  constant c_relative_prime_block  : integer := 2;
  constant c_dvb_rcs_block         : integer := 3;
  constant c_umts_block            : integer := 4;
-- 5-19 are reserved for future block-based types
  constant c_forney_convolutional  : integer := 20;
  constant c_ramsey1_convolutional : integer := 21;
  constant c_ramsey2_convolutional : integer := 22;
  constant c_ramsey3_convolutional : integer := 23;
  constant c_ramsey4_convolutional : integer := 24;
-- 25-40 are reserved for future convolutional-based types
-- c_mode constants
  constant c_interleaver           : integer := 0;
  constant c_deinterleaver         : integer := 1;
-- c_row_type, c_col_type, c_block_size_type, and c_branch_length_type constants
  constant c_constant              : integer := 0;  -- c_row_type, c_col_type, c_block_size_type, c_branch_length_type
  constant c_variable              : integer := 1;  -- c_row_type, c_col_type, c_block_size_type
  constant c_selectable            : integer := 2;  -- c_row_type, c_col_type
  constant c_row_x_col             : integer := 3;  -- c_block_size_type
  constant c_file                  : integer := 4;  -- c_branch_length_type
-- c_memstyle constants
  constant c_distmem               : integer := 0;
  constant c_blockmem              : integer := 1;
  constant c_automatic             : integer := 2;
-- c_pipe_level constants
  constant c_minimum               : integer := 0;
  constant c_medium                : integer := 1;
  constant c_maximum               : integer := 2;

-- c_architecture constants
-- For Convolutional interleaver
  constant c_use_rom   : integer := 0;
  constant c_use_logic : integer := 1;


  constant DEFAULT_C_TYPE          : integer := c_forney_convolutional;
  constant DEFAULT_MEM_INIT_PREFIX : string  := "int_1";
  constant DEFAULT_MODE            : integer := c_interleaver;
  constant DEFAULT_SYMBOL_WIDTH    : integer := 8;


  constant new_line : string(1 to 1) := (1 => lf);  -- for assertion reports

  constant abs_min_num_rows : integer := 1;
  constant abs_min_num_cols : integer := 2;

  constant c_sp_ram : integer := 1;
  constant c_dp_ram : integer := 2;

  constant SID_CONST_PKG_BEHAV_mif_width : integer := 32;

end sid_const_pkg_behav_v6_0;

---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
--                                                                          ---*
--                PACKAGE sid_mif_pkg_behav_v6_0                            ---*
--                                                                          ---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
library std;
use std.textio.all;
--
library ieee;
use ieee.std_logic_1164.all;
--  

-- This package contains functions to read and write Memory Initialization
-- Files into or from a memory stored as a single BIT_VECTOR

package sid_mif_pkg_behav_v6_0 is

  function read_meminit_file(
    filename : in string;
    depth    : in positive;
    width    : in positive;
    lines    : in positive
    ) return bit_vector;

end sid_mif_pkg_behav_v6_0;

package body sid_mif_pkg_behav_v6_0 is

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
  function read_meminit_file(
    filename : in string;
    depth    : in positive;
    width    : in positive;
    lines    : in positive
    ) return bit_vector is

    file meminitfile     : text is filename;  -- This works with '93 and '87
    variable bit         : integer;
    variable bitline     : line;
    variable bitchar     : character;
    variable bits_good   : boolean;
    variable offset      : integer;
    variable total_lines : integer;
    variable num_lines   : integer;
    variable mem_vector  : string(width downto 1);
    variable return_vect : bit_vector(width*lines-1 downto 0) := (others => '0');
  begin
    if (lines > 0 and lines <= depth) then
      total_lines := lines;
    else
      total_lines := depth;
    end if;

    num_lines := 0;
    offset    := 0;


    while (not(ENDFILE(meminitfile)) and (num_lines < total_lines)) loop
      READLINE(meminitfile, bitline);
      READ(bitline, mem_vector, bits_good);

      assert bits_good
        report "Error: problem reading memory initialization file, " & filename
        severity failure;
      
      for bit in 0 to width-1 loop
        bitchar := mem_vector(bit+1);
        if (bitchar = '1') then
          return_vect(offset+bit) := '1';
        else
          return_vect(offset+bit) := '0';
        end if;
      end loop;  -- FOR

      num_lines := num_lines+1;
      offset    := offset + width;
      
    end loop;  -- WHILE

    return return_vect;
    
  end read_meminit_file;
  
end sid_mif_pkg_behav_v6_0;

---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
--                                                                          ---*
--                PACKAGE sid_pkg_behav                                     ---*
--                                                                          ---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*


library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.sid_const_pkg_behav_v6_0.all;
use xilinxcorelib.sid_mif_pkg_behav_v6_0.all;

package sid_pkg_behav_v6_0 is



  type integer_vector is array(natural range <>) of integer;


------------------------------------------------------------------------------
--
-- FUNCTION PROTOTYPES
--
------------------------------------------------------------------------------

  function get_max_block_size(max_rows              : integer;
                              max_cols              : integer;
                              c_block_size_constant : integer;
                              c_block_size_type     : integer;
                              c_block_size_width    : integer) return integer;

  function get_max_dimension(dimension_type     : integer;
                             dimension_constant : integer;
                             dimension_width    : integer;
                             selectable_vector  : integer_vector) 
    return integer;

  function integer_to_string(int_value : integer) return string;

  function bits_needed_to_represent(a_value : natural) return natural;

  function select_integer(i0  : integer;
                          i1  : integer;
                          sel : boolean) return integer;

  function two_comp(vect : std_logic_vector) return std_logic_vector;

  function bit_vector_to_integer(bv : in bit_vector) return integer;

  function bit_vector_to_integer_vector(
    bv                : in bit_vector;
    bv_element_length : in integer)
    return integer_vector;

  function check_forney_generics(
    c1mode                   : integer;
    c1symbol_width           : integer;
    c1num_branches           : integer;
    c1branch_length_type     : integer;
    c1branch_length_constant : integer) return boolean;

  function get_integer_vector_from_mif(really_read_mif : boolean;
                                       mif_name        : string;
                                       mif_depth       : integer;
                                       mif_width       : integer)
    return integer_vector;

  function get_sum(a : integer_vector) return integer;

  function get_max(a : integer_vector) return integer;

  function get_branch_length_vector(ccmode                   : integer;
                                    ccnum_branches           : integer;
                                    ccbranch_length_constant : integer)
    return integer_vector;

  function calc_branch_start_vector(branch_length_vector : integer_vector)
    return integer_vector;

  function calc_branch_read_start_vector(branch_length_vector : integer_vector)
    return integer_vector;

  function calc_branch_end_vector(branch_length_vector : integer_vector)
    return integer_vector;

  function integer_to_std_logic_vector(
    value, bitwidth : integer) return std_logic_vector;

  function std_logic_vector_to_natural(
    in_val : in std_logic_vector) return natural;

  function select_val(i0  : integer;
                      i1  : integer;
                      sel : boolean) return integer;

  function calc_wss_delay(pruned          : boolean;
                          block_size_type : integer;
                          col_type        : integer;
                          row_type        : integer) return integer;

  function calc_xvalid_buffer_length(wss_delay       : integer;
                                     block_size_type : integer;
                                     col_type        : integer;
                                     row_type        : integer) return integer;

  function get_max_bm_depth(width    : integer) return integer;

  function get_mem_depth(required_depth : integer;
                         mem_style      : integer) return integer;

  function get_mem_depth_dp(reqd_depth : integer;
                            mem_style  : integer) return integer;

  function get_memstyle(depth    : integer;
                        width    : integer;
                        style    : integer;
                        mem_type : integer;
                        smart    : boolean) return integer;

------------------------------------------------------------------------------
-- calculate fdo latency, which is a FUNCTION of the length of branch 0
--
  function calc_fdo_proc_delay(
    numbranches   : integer;
    branchlength0 : integer) return integer;

  function get_max_num_branches(
    ccnum_configurations : integer;
    ccnum_branches       : integer;
    ccmif_width          : integer;
    ccbranch_length_file : string) return integer;

end sid_pkg_behav_v6_0;

package body sid_pkg_behav_v6_0 is



--------------------------------------------------------------------------------
--
-- This function returns the maximum number of rows (or columns) for the 
-- rectangular block type for given values of c_x_type, c_x_constant,
-- c_x_width and selectable_x_vector, where x refers to row or col. 
-- The selectable_x_vector contains integers values corresponding to the
-- values read from a mif.
--
--------------------------------------------------------------------------------
  function get_max_dimension(dimension_type     : integer;
                             dimension_constant : integer;
                             dimension_width    : integer;
                             selectable_vector  : integer_vector) 
    return integer is
    variable result : integer;
  begin
    --
    -- Find which parameters are relevant for defining the maximum number of
    -- rows or columns
    --
    if (dimension_type = c_constant) then
      result := dimension_constant;
    elsif (dimension_type = c_variable) then
      result := 2**dimension_width - 1;
    elsif (dimension_type = c_selectable) then
      result := get_max(selectable_vector);
    else                                -- throw error
      assert false
        report "ERROR: sid_v6_0 - get_max_dimension(): dimension_type not supported!"
        severity failure;
    end if;

    return result;
  end get_max_dimension;

--------------------------------------------------------------------------------
-- Return maximum number of symbols in a rectangular block
--
  function get_max_block_size(max_rows              : integer;
                              max_cols              : integer;
                              c_block_size_constant : integer;
                              c_block_size_type     : integer;
                              c_block_size_width    : integer) return integer is
    variable return_val : integer := 0;
  begin
    if c_block_size_type = c_row_x_col then
      return_val := max_rows * max_cols;
    elsif c_block_size_type = c_constant then
      return_val := c_block_size_constant;
    elsif c_block_size_type = c_variable then
      return_val := 2**c_block_size_width-1;
    else
      assert false
        report "ERROR: sid_v6_0 - get_max_block_size() Invalid block_size." & new_line
        severity failure;
    end if;

    return return_val;
  end get_max_block_size;


--------------------------------------------------------------------------------
-- Convert INTEGER to STRING
--------------------------------------------------------------------------------
  function integer_to_string(int_value : integer) return string is

    variable digit        : integer;
    variable value        : integer;
    variable length       : integer         := 0;
    variable posn         : integer;
    variable start_length : integer;
    constant str          : string(1 to 10) := "0123456789";
    variable ret_value    : string(1 to 11);

  begin

    if int_value < 0 then
      -- Largest possible negative number
      if int_value < -2147483647 then
        return ("less than VHDL minimum INTEGER value");
      else
        value        := -1 * int_value;
        start_length := 1;
        ret_value(1) := '-';
      end if;
    else
      value        := int_value;
      start_length := 0;
    end if;

    if (value = 0) then
      return "0";
    elsif (value < 10) then
      length := 1 + start_length;
    elsif (value < 100) then
      length := 2 + start_length;
    elsif (value < 1000) then
      length := 3 + start_length;
    elsif (value < 10000) then
      length := 4 + start_length;
    elsif (value < 100000) then
      length := 5 + start_length;
    elsif (value < 1000000) then
      length := 6 + start_length;
    elsif (value < 10000000) then
      length := 7 + start_length;
    elsif (value < 100000000) then
      length := 8 + start_length;
    elsif (value < 1000000000) then
      length := 9 + start_length;
    else
      length := 10 + start_length;
    end if;

    if (length > 0) then  -- Required because Metamor bombs without it
      posn := length;
      while (value /= 0) loop
        digit           := value mod 10;
        ret_value(posn) := str(digit+1);
        value           := value/10;
        posn            := posn - 1;
      end loop;
    end if;

    return ret_value(1 to length);

  end integer_to_string;

--------------------------------------------------------------------------------
-- Return number of bits required to represent the supplied parameter
--------------------------------------------------------------------------------
  function bits_needed_to_represent(a_value : natural) return natural is
    variable return_value : natural := 1;
  begin

    for i in 30 downto 0 loop
      if a_value >= 2**i then
        return_value := i+1;
        exit;
      end if;
    end loop;

    return return_value;

  end bits_needed_to_represent;

--------------------------------------------------------------------------------
-- Return i0 if sel = FALSE, i1 if sel = TRUE
--------------------------------------------------------------------------------
  function select_integer(i0  : integer;
                          i1  : integer;
                          sel : boolean) return integer is
  begin
    if sel then
      return i1;
    else
      return i0;
    end if;  -- sel
  end select_integer;


------------------------------------------------------------------------------
-- Gets the maximum value from an array of integers
------------------------------------------------------------------------------
  function get_max(a : integer_vector) return integer is
    variable max : integer;
  begin
    max := integer'low;
    for i in a'low to a'high loop
      if a(i) > max then
        max := a(i);
      end if;
    end loop;
    return max;
  end get_max;

--------------------------------------------------------------------------------
-- Return 2's complement of input vector
--------------------------------------------------------------------------------
  function two_comp(vect : std_logic_vector) return std_logic_vector is
    variable local_vect : std_logic_vector(vect'high downto 0);
    variable toggle     : integer := 0;
  begin

    for i in 0 to vect'high loop
      if (toggle = 1) then
        if (vect(i) = '0') then
          local_vect(i) := '1';
        else
          local_vect(i) := '0';
        end if;
      else
        local_vect(i) := vect(i);
        if (vect(i) = '1') then
          toggle := 1;
        end if;
      end if;
    end loop;

    return local_vect;
  end two_comp;


  ------------------------------------------------------------------------------
  --
  -- This FUNCTION checks the values entered for the forney_convolutional
  -- core's GENERICs
  --
  ------------------------------------------------------------------------------
  function check_forney_generics(
    c1mode                   : integer;
    c1symbol_width           : integer;
    c1num_branches           : integer;
    c1branch_length_type     : integer;
    c1branch_length_constant : integer) return boolean is

  begin
    assert (c1mode = c_interleaver or c1mode = c_deinterleaver)
      report "ERROR: sid_v6_0 - c_mode must be either " &
      integer_to_string(c_interleaver) & " or " &
      integer_to_string(c_deinterleaver) & new_line
      severity failure;
    
    assert (c1symbol_width >= min_symbol_width and
            c1symbol_width <= max_symbol_width)
      report "ERROR: sid_v6_0 - c_symbol_width must be in range " &
      integer_to_string(min_symbol_width) & " to " &
      integer_to_string(max_symbol_width) & new_line
      severity failure;
    
    assert (c1num_branches >= abs_min_num_branches and
            c1num_branches <= abs_max_num_branches)
      report "ERROR: sid_v6_0 - c_num_branches must be in range " &
      integer_to_string(abs_min_num_branches) & " to " &
      integer_to_string(abs_max_num_branches) & new_line
      severity failure;
    
    assert (c1branch_length_type = c_constant or c1branch_length_type = c_file)
      report "ERROR: c_branch_length_type = " &
      integer_to_string(c1branch_length_type) & " is not supported."
      severity failure;
    
    assert no_debug
      report new_line &
      "upper_branch_length_constant = " &
      integer_to_string(upper_branch_length_constant) & new_line
      severity note;

    assert (c1branch_length_constant >= min_branch_length_constant and
            c1branch_length_constant <= upper_branch_length_constant)
      report "ERROR: sid_v6_0 - c_branch_length_constant must be in range " &
      integer_to_string(min_branch_length_constant) & " to " &
      integer_to_string(upper_branch_length_constant) & new_line
      severity failure;
    
    return true;
  end check_forney_generics;

--------------------------------------------------------------------------------
-- Convert BIT_VECTOR to INTEGER
-- BIT_VECTOR must have a descending range and be in 2's complement notation
--------------------------------------------------------------------------------
  function bit_vector_to_integer(
    bv : in bit_vector) 
    return integer is
    variable found_msb       : boolean := false;
    variable msb             : integer := 0;
    variable unsigned_result : integer := 0;
  begin
    if bv'length > 32 then
      assert false
        report "bit_vector_to_integer FUNCTION doesn't support bv_element_length > 32"
        severity failure;
    end if;
    found_msb := false;
    for i in bv'range loop
      if found_msb = true then
        unsigned_result := unsigned_result * 2 + bit'pos(bv(i));
        msb             := msb*2;
      else
        if bit'pos(bv(i)) = 1 then
          msb := -1;
        end if;
        found_msb := true;
      end if;
    end loop;
    return msb + unsigned_result;
  end bit_vector_to_integer;

  --------------------------------------------------------------------------------
  --
  -- convert bit_vector to integer_vector
  --
  --------------------------------------------------------------------------------
  function bit_vector_to_integer_vector(
    bv                : in bit_vector;
    bv_element_length : in integer)
    return integer_vector is
    constant bv_length : integer := bv'length;
    constant iv_length : integer := bv_length/bv_element_length;

    constant num_bits   : natural                                    := iv_length*bv_element_length;
    variable bv_element : bit_vector(bv_element_length - 1 downto 0) := (others => '0');
    variable result     : integer_vector(0 to iv_length - 1);
  begin
    if bv_element_length > 32 then
      assert false
        report "bit_vector_to_integer_vector FUNCTION doesn't support bv_element_length > 32"
        severity failure;
    end if;
    for ai in 0 to (iv_length - 1) loop  -- ai = address index
      -- build up element bit_vector
      for bi in (bv_element_length - 1) downto 0 loop
        bv_element(bi) := bv(ai*bv_element_length + bi);
      end loop;  -- bi
      result(ai) := bit_vector_to_integer(bv_element);
    end loop;  -- ai
    return result;
  end bit_vector_to_integer_vector;

  function get_integer_vector_from_mif(
    really_read_mif : boolean;
    mif_name        : string;
    mif_depth       : integer;
    mif_width       : integer)
    return integer_vector is
    variable bv : bit_vector((mif_depth*mif_width - 1) downto 0);
    variable iv : integer_vector(0 to (mif_depth - 1));
  begin
    if (really_read_mif) then
      bv := read_meminit_file(mif_name, mif_depth, mif_width, mif_depth);
      iv := bit_vector_to_integer_vector(bv, mif_width);
    end if;
    return iv;
  end get_integer_vector_from_mif;

  --------------------------------------------------------------------------------
  -- Gets the sum of an array of integers
  --------------------------------------------------------------------------------
  function get_sum(a : integer_vector) return integer is
    variable sum : integer;
  begin
    sum := 0;
    for i in a'range loop
      sum := sum + a(i);
    end loop;
    return sum;
  end get_sum;

  --------------------------------------------------------------------------------
  function get_branch_length_vector(
    ccmode         : integer;
    ccnum_branches : integer;

    ccbranch_length_constant : integer)

    return integer_vector is
    variable result : INTEGER_VECTOR(0 to (ccnum_branches - 1));
    -- all mif files shall have mif_width bits per line

  begin

    if ccmode = c_interleaver then
      for bi in 0 to ccnum_branches - 1 loop
        --
        -- the extra 1 in the following equation takes account of the 
        -- extra level of pipelining added to each branch so that
        -- location zero can be used for the first branch.
        --
        result(bi) := bi*ccbranch_length_constant + 1;
      end loop;  -- bit
    elsif ccmode = c_deinterleaver then
      for bi in 0 to ccnum_branches - 1 loop
        result(bi) := (ccnum_branches - 1 - bi)*ccbranch_length_constant + 1;
      end loop;  -- bit
    else                                -- catch errant ccmode values
      assert false
        report "c_mode = " & integer_to_string(ccmode) & " is not supported!"
        severity failure;
    end if;

    return result;
  end get_branch_length_vector;

  --------------------------------------------------------------------------------
  function calc_branch_start_vector(
    branch_length_vector : integer_vector)
    return integer_vector is
    variable result : integer_vector(0 to branch_length_vector'high);
  begin
    result(0) := 0;
    for i in 0 to branch_length_vector'high - 1 loop
      result(i+1) := result(i) + branch_length_vector(i);
    end loop;
    return result;
  end calc_branch_start_vector;

  --------------------------------------------------------------------------------
  function calc_branch_end_vector(
    branch_length_vector : integer_vector)
    return integer_vector is
    variable result : integer_vector(0 to branch_length_vector'high);
  begin
    result(0) := branch_length_vector(0)-1;
    for i in 0 to branch_length_vector'high - 1 loop
      result(i+1) := result(i) + branch_length_vector(i+1);
    end loop;
    return result;
  end calc_branch_end_vector;

  --------------------------------------------------------------------------------
  function calc_branch_read_start_vector(
    branch_length_vector : integer_vector)
    return integer_vector is
    variable result              : integer_vector(0 to branch_length_vector'high);
    variable branch_start_vector : integer_vector(0 to branch_length_vector'high);
  begin
    branch_start_vector(0) := 0;
    for i in 0 to branch_length_vector'high - 1 loop
      branch_start_vector(i+1) := branch_start_vector(i) + branch_length_vector(i);
    end loop;
    for i in 0 to branch_length_vector'high loop
      if branch_length_vector(i) = 1 then
        result(i) := branch_start_vector(i);
      else
        result(i) := branch_start_vector(i) + 1;
      end if;
    end loop;
    return result;
  end calc_branch_read_start_vector;

  --------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Convert INTEGER to a STD_LOGIC_VECTOR
--------------------------------------------------------------------------------
  function integer_to_std_logic_vector(value, bitwidth : integer)
    return std_logic_vector is

    variable running_value  : integer := value;
    variable running_result : std_logic_vector(bitwidth-1 downto 0);
  begin

    if (value < 0) then
      running_value := -1 * value;
    end if;

    for i in 0 to bitwidth-1 loop

      if running_value mod 2 = 0 then
        running_result(i) := '0';
      else
        running_result(i) := '1';
      end if;
      running_value := running_value/2;
    end loop;

    if (value < 0) then                 -- find the 2s complement
      return two_comp(running_result);
    else
      return running_result;
    end if;

  end integer_to_std_logic_vector;

--------------------------------------------------------------------------------
-- Convert STD_LOGIC_VECTOR to NATURAL
--------------------------------------------------------------------------------
  function std_logic_vector_to_natural(in_val : in std_logic_vector) return natural is
    variable result  : natural := 0;
    variable failure : boolean := false;
  begin
    for i in in_val'range loop
      result := result * 2;

      if (in_val(i) = '1' or in_val(i) = 'H') then
        result := result + 1;
      elsif (in_val(i) /= '0' and in_val(i) /= 'L') then
        failure := true;
      end if;
    end loop;

    if failure then
      assert false
        report "ERROR: std_logic_vector_to_natural: There is a non-numeric bit in the argument."&
        " It has been converted to 0."
        severity warning;
    end if;

    return result;
  end std_logic_vector_to_natural;

  --------------------------------------------------------------------------------
  --
  -- calculate the variable part of the delay for rectangular block type
  --
  -- Function identical to that used in the structural code.
  --------------------------------------------------------------------------------
  function calc_wss_delay(pruned          : boolean;
                          block_size_type : integer;
                          col_type        : integer;
                          row_type        : integer) return integer is
    variable wss_delay_val : integer;
  begin
    if not(pruned) or block_size_type = c_constant then
      wss_delay_val := 1;
    elsif col_type = c_constant and row_type = c_constant then
      wss_delay_val := 3;
    else
      wss_delay_val := 6;
    end if;
    return wss_delay_val;
  end calc_wss_delay;


  --------------------------------------------------------------------------------
  --
  -- Function to calculate the (row_valid etc) buffer length
  --------------------------------------------------------------------------------
  function calc_xvalid_buffer_length(wss_delay       : integer;
                                     block_size_type : integer;
                                     col_type        : integer;
                                     row_type        : integer) return integer is

    variable valid_delay_val : integer;
  begin

    valid_delay_val := wss_delay+1;

    if block_size_type = c_row_x_col then
      
      if (row_type = c_selectable or col_type = c_selectable) then
        -- Possible 2 extra cycles required due to delay line on
        -- row_x_col_block_size enable in rfd generation circuit
        valid_delay_val := valid_delay_val+2;
      end if;
      
    end if;  -- c_block_size_type

    return valid_delay_val;
  end calc_xvalid_buffer_length;

--------------------------------------------------------------------------------
  function get_mem_depth(required_depth : integer;
                         mem_style      : integer) return integer is
    variable extra      : natural;
    variable addr_width : natural;
    variable result     : integer := 0;
  begin
    if mem_style = c_distmem then
      extra := required_depth mod 16;
      if (extra = 0) then
        result := required_depth;
      else
        result := (required_depth + 16 - extra);
      end if;
    elsif mem_style = c_blockmem then
      -- block mems must be 16, 32, 64, 128, 256 or n * 256 deep
      if required_depth <= 16 then
        result := 16;
      elsif required_depth <= 256 then
        result := 2**(bits_needed_to_represent(required_depth-1));
      else
        result := 256 + (256 * ((required_depth-1)/256));
      end if;  -- required_depth
    end if;  -- mem_style

    return result;
  end get_mem_depth;

--------------------------------------------------------------------------------
-- 
-- Dual-port block memory must be a multiple of 16 for dist mem and 256
-- for block mem.
--
--------------------------------------------------------------------------------
  function get_mem_depth_dp(reqd_depth : integer;
                            mem_style  : integer) return integer is
    variable extra  : natural;
    variable result : integer := 0;
  begin
    if mem_style = c_distmem then
      extra := reqd_depth mod 16;
      if (extra = 0) then
        result := reqd_depth;
      else
        result := (reqd_depth + 16 - extra);
      end if;
    elsif mem_style = c_blockmem then
      extra := reqd_depth mod 256;
      if (extra = 0) then
        result := reqd_depth;
      else
        result := (reqd_depth + 256 - extra);
      end if;
    end if;  -- mem_style

    return result;
  end get_mem_depth_dp;

--------------------------------------------------------------------------------
-- Return maximum depth of block memory for a given width
-- These numbers were obtained from the block mem GUIs.
--------------------------------------------------------------------------------
  function get_max_bm_depth(width    : integer) return integer is
    variable max_depth : integer;
  begin
    if width < 4 then
      max_depth := 262144;
    elsif width < 7 then
      max_depth := 131072;
    elsif width < 13 then
      max_depth := 65536;
    elsif width < 25 then
      max_depth := 32768;
    elsif width < 49 then
      max_depth := 16384;
    elsif width < 97 then
      max_depth := 8192;
    elsif width < 193 then
      max_depth := 4096;
    else
      max_depth := 2048;
    end if;

    return max_depth * 4;

    
  end get_max_bm_depth;

--------------------------------------------------------------------------------
  function get_memstyle(depth    : integer;
                        width    : integer;
                        style    : integer;
                        mem_type : integer;
                        smart    : boolean) return integer is
    variable max_bm_depth           : integer;
    variable mem_size               : integer;
    variable result                 : integer := c_distmem;
    variable actual_block_mem_depth : integer;
    variable actual_dist_mem_depth  : integer;
  begin
    max_bm_depth := get_max_bm_depth(width);

    -- Round up to actual depth required for each memory style
    actual_dist_mem_depth  := get_mem_depth(depth, c_distmem);
    actual_block_mem_depth := get_mem_depth(depth, c_blockmem);

    -- Check depth doesn't exceed limits
    if (actual_dist_mem_depth > max_dm_depth_vx2 and
        actual_block_mem_depth <= max_bm_depth) then
      result := c_blockmem;
      
    elsif (actual_block_mem_depth > max_bm_depth and
           actual_dist_mem_depth <= max_dm_depth_vx2) then

      result := c_distmem;
      
    else
      -- If depth didn't exceed max limits then determine style to use based
      -- on size and style parameter
      mem_size := actual_dist_mem_depth * width;
      -- Return value depends on memory size
      if mem_type = c_dp_ram then
        mem_size := mem_size * 2;       -- Only actually true for dist mem
      end if;

      if style = c_distmem then
        result := c_distmem;
        
      elsif style = c_blockmem then
        if smart then
          if mem_size <= 64 then
            result := c_distmem;
          else
            result := c_blockmem;
          end if;  -- mem_size
        else
          result := c_blockmem;
        end if;  -- smart
        
      elsif style = c_automatic then
        if mem_size <= 512 then
          result := c_distmem;
        else
          result := c_blockmem;
        end if;
      end if;  -- style
      
    end if;  
    return result;
  end get_memstyle;


--------------------------------------------------------------------------------
-- Return i0 if sel = FALSE, i1 if sel = TRUE
--------------------------------------------------------------------------------
  function select_val(i0 : integer; i1 : integer; sel : boolean) return integer is
  begin
    if sel then
      return i1;
    else
      return i0;
    end if;  -- sel
  end select_val;


------------------------------------------------------------------------------
-- calculate fdo latency, which is a FUNCTION of the length of branch 0
--
  function calc_fdo_proc_delay(
    numbranches   : integer;
    branchlength0 : integer)
    return integer is

    variable result : integer := 999;
  begin
    if (branchlength0-1) = 0 then
      result := 1;
    else
      result := (branchlength0-1) * numbranches
                + 1;  --(The +1 is added for v3.1 because process fdo_proc is tidied up)  
    end if;
    return result;
  end calc_fdo_proc_delay;

--------------------------------------------------------------------------------
--Function to calculate the maximum number of branches
--------------------------------------------------------------------------------
  function get_max_num_branches(
    ccnum_configurations : integer;
    ccnum_branches       : integer;
    ccmif_width          : integer;
    ccbranch_length_file : string) return integer is

    variable num_branches_vector : INTEGER_VECTOR(0 to ccnum_configurations-1) := (others => 0);
    variable result              : integer                                     := 0;

  begin


    if ccnum_configurations = 1 then
      result := ccnum_branches;
    elsif ccnum_configurations > 1 then
      --The first ccnum_configurations entries are the number of branches vector.
      --If ccnum_configurations>1 and this constant is used to select
      --the number of branches, depending on the value on the config_sel port.
      --If ccnum_configurations>1 and ccbranch_length_type=c_file, this constant is
      --also used to find the total number of mif file values.
      num_branches_vector := get_integer_vector_from_mif(true,
                                                          ccbranch_length_file,
                                                          ccnum_configurations,
                                                          ccmif_width);

      result := 0;
      for cfg in 0 to ccnum_configurations-1 loop
        if num_branches_vector(cfg) > result then
          result := num_branches_vector(cfg);
        end if;
      end loop;
    else                                --ccnum_configurations<1 THEN
      --ERROR!    
      assert false
        report "c_num_configurations = " & integer_to_string(ccnum_configurations) & " is not supported!"
        severity failure;
    end if;
    return result;
  end get_max_num_branches;


  

end sid_pkg_behav_v6_0;




---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
--                                                                          ---*
--                FORNEY INTERLEAVER / DEINTERLEAVER                        ---*
--                                                                          ---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*


library ieee;
use ieee.std_logic_1164.all;

library std;
use std.textio.all;

library xilinxcorelib;
use xilinxcorelib.sid_const_pkg_behav_v6_0.all;
use xilinxcorelib.sid_pkg_behav_v6_0.all;
use xilinxcorelib.sid_mif_pkg_behav_v6_0.all;


entity sid_bhv_forney_v6_0 is
  generic (
    c_mode                   : integer;
    c_symbol_width           : integer;
    -- Forney specific generics
    c_num_branches           : integer;
    c_branch_length_type     : integer;
    c_branch_length_constant : integer;
    c_branch_length_file     : string := "";
    c_has_fdo                : integer;
    c_has_ndo                : integer;
    -- Implementation generics
    c_pipe_level             : integer;
    -- Optional pin generics
    c_has_ce                 : integer;
    c_has_sclr               : integer;
    c_has_rdy                : integer;
    c_has_rffd               : integer;
    c_has_rfd                : integer;
    --New generics for v4_0
    c_external_ram           : integer;
    c_ext_addr_width         : integer;
    c_num_configurations     : integer);
  port (
    -- Mandatory pins
    clk        : in  std_logic;
    fd         : in  std_logic;
    din        : in  std_logic_vector(c_symbol_width-1 downto 0);
    -- Optional input pins
    nd         : in  std_logic  := '1';
    ce         : in  std_logic  := '1';
    sclr       : in  std_logic  := '0';
    -- Mandatory output pins
    dout       : out std_logic_vector(c_symbol_width-1 downto 0);
    -- optional output pins
    rdy        : out std_logic;
    rffd       : out std_logic;
    rfd        : out std_logic;
    fdo        : out std_logic;
    ndo        : out std_logic;
    --New ports for v4_0
    new_config : in  std_logic  := '0';
    config_sel : in  std_logic_vector(
      select_val(
        bits_needed_to_represent(c_num_configurations-1),
        1, c_num_configurations <= 1) -1 downto 0);
    rd_data    : in  std_logic_vector(c_symbol_width-1 downto 0);  -- Read data from external RAM
    rd_en      : out std_logic;
    wr_en      : out std_logic;
    rd_addr    : out std_logic_vector(c_ext_addr_width-1 downto 0);
    wr_addr    : out std_logic_vector(c_ext_addr_width-1 downto 0);
    wr_data    : out std_logic_vector(c_symbol_width-1 downto 0));  -- Write data to external RAM
end sid_bhv_forney_v6_0;


architecture behavioral of sid_bhv_forney_v6_0 is


  constant cc_type : integer := c_forney_convolutional;


  constant max_num_branches : integer :=
    get_max_num_branches(c_num_configurations, c_num_branches, SID_CONST_PKG_BEHAV_mif_width, c_branch_length_file);

  subtype BVECTOR is INTEGER_VECTOR(0 to max_num_branches-1);

  type BLV_REC is record
    fld_num_branches             : natural range 0 to max_num_branches;
    fld_bl_vect                  : BVECTOR;
    fld_branch_start_vector      : BVECTOR;
    fld_branch_end_vector        : BVECTOR;
    fld_branch_read_start_vector : BVECTOR;
    fld_fdo_proc_delay           : integer;
  end record;

  type BVECTOR_ARRAY is array(natural range <>) of BLV_REC;


  --------------------------------------------------------------------------------
  --
  -- convert integer_vector to bvector (vector of branch lengths)
  --
  --------------------------------------------------------------------------------
  function integer_vector_to_bvector(
    iv : in integer_vector)
    return BVECTOR is
    variable result : BVECTOR;
  begin
    for ai in iv'low to iv'high loop    -- ai = address index
      result(ai) := iv(ai);
    end loop;  -- ai
    return result;
  end integer_vector_to_bvector;

  --------------------------------------------------------------------------------
  --Function to extract the array of selectable branch_vectors from a mif file vector
  --------------------------------------------------------------------------------
  function get_forney_params(
    ccnum_configurations     : integer;
    ccmode                   : integer;
    ccnum_branches           : integer;
    ccbranch_length_constant : integer;
    ccbranch_length_type     : integer;
    ccbranch_length_file     : string) return BVECTOR_ARRAY is


    constant max_mif_file_size : integer :=
      select_val(ccnum_configurations*(1+max_num_branches),
                 ccnum_branches,
                 ccnum_configurations = 1);

    variable fileptr                : integer                                     := 0;
    variable c2_num_branches_array  : INTEGER_VECTOR(0 to ccnum_configurations-1) := (others => 0);
    variable num_total_mif_values   : integer                                     := 0;
    variable num_branches           : integer                                     := 0;
    variable branch_length_constant : integer                                     := 0;
    variable total_mif_file_vector  : INTEGER_VECTOR(0 to max_mif_file_size-1)    := (others => 0);
    variable blvi                   : INTEGER_VECTOR(0 to max_num_branches-1)     := (others => 0);
    variable blv                    : BVECTOR                                     := (others => 0);
    variable result                 : BVECTOR_ARRAY(0 to ccnum_configurations-1);

  begin

    if ccnum_configurations = 1 then
      result(0).fld_num_branches := ccnum_branches;
      if ccbranch_length_type = c_constant then
        blvi := get_branch_length_vector(ccmode, ccnum_branches, ccbranch_length_constant);
        blv  := integer_vector_to_bvector(blvi);
      else
        blvi := get_integer_vector_from_mif(true,
                                             ccbranch_length_file,
                                             ccnum_branches,
                                             SID_CONST_PKG_BEHAV_mif_width);
        blv := integer_vector_to_bvector(blvi);
        for bi in 0 to ccnum_branches - 1 loop
          -- always add one to each branch length vector element.
          -- doing this ensures that zero length branches are automatically
          -- supported without affecting latency.
          blv(bi) := blv(bi) + 1;
        end loop;  -- bi
      end if;
      result(0).fld_bl_vect        := blv;
      result(0).fld_fdo_proc_delay := calc_fdo_proc_delay(ccnum_branches, blv(0));
      
    elsif ccnum_configurations > 1 then
      --The first ccnum_configurations entries are the number of branches vector.
      --If ccnum_configurations>1 and this constant is used to select
      --the number of branches, depending on the value on the config_sel port.
      --If ccnum_configurations>1 and ccbranch_length_type=c_file, this constant is
      --also used to find the total number of mif file values.
      c2_num_branches_array := get_integer_vector_from_mif(true,
                                                            ccbranch_length_file,
                                                            ccnum_configurations,
                                                            SID_CONST_PKG_BEHAV_mif_width);

      if ccbranch_length_type = c_constant then
        num_total_mif_values := 2*ccnum_configurations;
      else
        num_total_mif_values := ccnum_configurations+get_sum(c2_num_branches_array);
      end if;

      --Now read the whole mif_file
      total_mif_file_vector(0 to num_total_mif_values-1)
        := get_integer_vector_from_mif(true,
                                        ccbranch_length_file,
                                        num_total_mif_values,
                                        SID_CONST_PKG_BEHAV_mif_width);

      fileptr := ccnum_configurations;  --needed for parsing branch length vectors
      for cfg in 0 to ccnum_configurations-1 loop
        num_branches                 := total_mif_file_vector(cfg);
        result(cfg).fld_num_branches := num_branches;
        if ccbranch_length_type = c_constant then
          branch_length_constant    := total_mif_file_vector(cfg+ccnum_configurations);
          blvi(0 to num_branches-1) := get_branch_length_vector
                                       (ccmode,
                                        num_branches,
                                        branch_length_constant);
          blv := integer_vector_to_bvector(blvi);
        else
          --extract a branch_length_vector from the input vector
          for i in 0 to num_branches-1 loop
            blvi(i) := total_mif_file_vector(fileptr)
                       +1;              --Add 1 to each element!
            fileptr := fileptr+1;
          end loop;
          blv := integer_vector_to_bvector(blvi);
        end if;
        --store the extracted single branch_length_vector in the array
        result(cfg).fld_bl_vect        := blv;
        result(cfg).fld_fdo_proc_delay := calc_fdo_proc_delay(num_branches, blv(0));
      end loop;
    else                                --ccnum_configurations>1 THEN
      --ERROR!    
      assert false
        report "c_num_configurations = " & integer_to_string(ccnum_configurations) & " is not supported!"
        severity failure;
    end if;

    for cfg in 0 to ccnum_configurations-1 loop
      blvi                                := calc_branch_start_vector(result(cfg).fld_bl_vect);
      result(cfg).fld_branch_start_vector := integer_vector_to_bvector(blvi);

      blvi                                     := calc_branch_read_start_vector(result(cfg).fld_bl_vect);
      result(cfg).fld_branch_read_start_vector := integer_vector_to_bvector(blvi);

      blvi                              := calc_branch_end_vector(result(cfg).fld_bl_vect);
      result(cfg).fld_branch_end_vector := integer_vector_to_bvector(blvi);
    end loop;

    return result;
  end get_forney_params;


--------------------------------------------------------------------------------
  -- get the largest value in the branch length vector.
  -- ie the length of the longest branch +1.
  --
  function get_max_blv_value(
    num_configurations : integer;
    fparams            : BVECTOR_ARRAY)
    return integer is
    variable result : integer;
  begin
    result := 0;
    for cfg in 0 to num_configurations-1 loop
      for this_branch in 0 to fparams(cfg).fld_num_branches - 1 loop
        if fparams(cfg).fld_bl_vect(this_branch) > result then
          result := fparams(cfg).fld_bl_vect(this_branch);
        end if;
      end loop;
    end loop;
    return result;
  end get_max_blv_value;

--------------------------------------------------------------------------------
  function get_max_fdo_proc_delay(
    num_configurations : integer;
    fparams            : BVECTOR_ARRAY)
    return integer is
    variable result : integer;
  begin
    result := 0;
    for cfg in 0 to num_configurations-1 loop
      if fparams(cfg).fld_fdo_proc_delay > result then
        result := fparams(cfg).fld_fdo_proc_delay;
      end if;
    end loop;
    return result;
  end get_max_fdo_proc_delay;

--------------------------------------------------------------------------------
  --Extract an array of c_num_configurations branch length vectors from the total mif file vector
  constant forney_params : BVECTOR_ARRAY(0 to c_num_configurations-1)
    := get_forney_params(c_num_configurations,
                         c_mode,
                         c_num_branches,
                         c_branch_length_constant,
                         c_branch_length_type,
                         c_branch_length_file);

  constant max_blv_value : integer :=
    get_max_blv_value(c_num_configurations, forney_params);

  constant max_fdo_proc_delay : integer :=
    get_max_fdo_proc_delay(c_num_configurations, forney_params);

--Data types;

  subtype SID_SYMBOL is std_logic_vector(c_symbol_width-1 downto 0);

  subtype SID_FORNEY_SWITCH is integer range -1 to max_num_branches-1;

  constant do_check_generics : boolean :=
    check_forney_generics(c_mode, c_symbol_width, c_num_branches,
                          c_branch_length_type, c_branch_length_constant);

  constant ndo_delay : integer := select_val(3, 4, c_pipe_level = c_maximum);

  constant output_delay : time := 1 ns;

  type DATABUFFER is array (natural range <>) of SID_SYMBOL;



  type MEM is array (0 to (2**c_ext_addr_width)-1) of SID_SYMBOL;

  ------------------------------------------------------------------------------
  signal ce_int    : std_logic;
  signal sclr_int  : std_logic;
  signal power     : std_logic := '0';
  signal reset     : std_logic := '0';

  -- Inputs registered if c_pipe_level/=c_minimum, else unregistered
  signal din_r         : SID_SYMBOL := (others => '0');
  signal nd_r          : std_logic;
  signal v_fd_r        : std_logic;
  signal abort_r       : std_logic;
  signal fd_received_r : std_logic;

  signal fd_received : std_logic;
  signal rffd_int    : std_logic;

  signal sync_0       : std_logic;
  signal sync_1       : std_logic;
  signal sync_delayed : std_logic;

  signal f_sw            : SID_FORNEY_SWITCH;
  signal shiftbr_0       : SID_FORNEY_SWITCH;
  signal shiftbr_1       : SID_FORNEY_SWITCH;
  signal shiftbr_delayed : SID_FORNEY_SWITCH := -1;
  signal shiftbr_raddr_r : SID_FORNEY_SWITCH := -1;

  signal nd_0       : std_logic;
  signal nd_1       : std_logic := '0';
  signal nd_delayed : std_logic := '0';
  signal nd_raddr_r : std_logic := '0';

  signal fd_0       : std_logic;
  signal fd_1       : std_logic;
  signal fd_delayed : std_logic;

  signal ndo_vect : std_logic_vector(ndo_delay downto 0);
  signal ndo_d    : std_logic;
  signal ndo_int  : std_logic;

  signal rd_addr_nd_vect : std_logic_vector(ndo_delay downto 0);

  signal fdo_proc_vect : std_logic_vector(max_fdo_proc_delay downto 0);
  signal fdo_d         : std_logic;
  signal fdo_q         : std_logic;
  signal fdo_int       : std_logic;

  signal rdy_enable_d   : std_logic;
  signal rdy_enable_q   : std_logic;
  signal rdy_enable_int : std_logic;

  signal dout_int : SID_SYMBOL := (others => '0');

  signal rdy_int : std_logic;
  signal rfd_int : std_logic;           --not used in Forney

  signal rd_en_d   : std_logic := '1';
  signal rd_en_int : std_logic := '1';

  signal rd_addr_int : std_logic_vector(c_ext_addr_width-1 downto 0)
    := (others => '0');
  signal wr_addr_int : std_logic_vector(c_ext_addr_width-1 downto 0)
    := (others => '0');

  signal wr_data_int : std_logic_vector(c_symbol_width-1 downto 0);

  signal wr_en_d   : std_logic := '0';
  signal wr_en_int : std_logic := '0';

  signal smem : MEM := (others => (others => '0'));  -- internal symbol memory.


  --Signals for selecting parameters when c_num_configurations>1
  constant config_sel_width       : integer                                   := bits_needed_to_represent(c_num_configurations-1);
  signal config_sel_r             : std_logic_vector(config_sel_width-1 downto 0);
  signal config_sel_0             : natural range 0 to c_num_configurations-1 := 0;
  signal config_sel_1             : natural range 0 to c_num_configurations-1 := 0;
  signal config_sel_delayed       : natural range 0 to c_num_configurations-1 := 0;
  signal config_sel_raddr_r       : natural range 0 to c_num_configurations-1 := 0;
  signal config_sel_valid_0       : std_logic                                 := '0';
  signal config_sel_valid_1       : std_logic                                 := '0';
  signal config_sel_valid_delayed : std_logic                                 := '0';
  signal config_sel_valid_raddr_r : std_logic                                 := '0';
  signal new_config_0             : std_logic                                 := '0';
  signal new_config_1             : std_logic                                 := '0';
  signal new_config_delayed       : std_logic                                 := '0';
  signal new_config_raddr_r       : std_logic                                 := '0';
  signal sync_raddr_r             : std_logic                                 := '0';
  signal config_sel_valid_rffd    : std_logic                                 := '0';

  signal new_config_r   : std_logic;
  signal new_config_int : std_logic;

--------------------------------------------------------------------------------
-- START OF ARCHITECTURE -------------------------------------------------------
--------------------------------------------------------------------------------

begin


  -- Output delay process
  -- add setup delay to data output signal
  output_t_proc : process(dout_int, rd_data, rdy_int)
    variable dout_t : SID_SYMBOL;
  begin
    if c_external_ram /= 0 then
      dout_t := rd_data;
    else
      if c_num_configurations > 1 then
        if rdy_int /= '1' then
          dout_t := (others => 'X');
        else
          dout_t := dout_int;
        end if;
      else
        dout_t := dout_int;
      end if;
    end if;
    dout <= dout_t after output_delay;
  end process;

  --ce process
  ce_proc : process(ce)
  begin
    if c_has_ce /= 0 then
      ce_int <= ce;
    else
      ce_int <= '1';
    end if;
  end process;

  --sclr process
  sclr_proc : process(sclr)
  begin
    if c_has_sclr /= 0 then
      sclr_int <= sclr;
    else
      sclr_int <= '0';
    end if;
  end process;

  --new_config process
  new_config_proc : process(new_config)
  begin
    if c_num_configurations > 1 then
      new_config_int <= new_config;
    else
      new_config_int <= '0';
    end if;
  end process;


  --Powerup process - runs once only
  powerup : process
  begin
    power <= '1' after 1 ns;
    wait;
  end process;  --powerup   

  --reset process
  reset_proc : process(power)
  begin
    reset <= not power;
  end process;  --reset_proc   

  --Optional rdy process
  optional_rdy : process(rdy_int)
  begin
    if c_has_rdy /= 0 then rdy <= rdy_int after output_delay;
    else rdy                   <= 'U';
    end if;
  end process;

  --Optional rffd process
  optional_rffd : process(rffd_int)
  begin
    if c_has_rffd /= 0 then rffd <= rffd_int after output_delay;
    else rffd                    <= 'U';
    end if;
  end process;

  rfd_int <= '0';                       --not used in Forney
  --Optional rfd process
  optional_rfd : process(rfd_int)
  begin
    if c_has_rfd = 0 then
      rfd <= 'U';
    elsif cc_type = c_forney_convolutional then
      rfd <= '1';
    else
      rfd <= rfd_int after output_delay;
    end if;
  end process;



  --config_sel process
  config_sel_proc : process(clk, reset)

    variable config_sel_nat : natural range 0 to 2**config_sel_width-1;

  begin
    if c_num_configurations = 1 then
      config_sel_valid_0 <= '1';
      config_sel_0       <= 0;
    elsif reset = '1' then
    elsif clk'event and clk = '1' then
      if ce_int = '1' then
        if sclr_int = '1' then
          config_sel_valid_0 <= '0';
          config_sel_0       <= 0;
        elsif new_config_r = '1' then
          config_sel_nat := std_logic_vector_to_natural(config_sel_r);
          if config_sel_nat > c_num_configurations-1 then
            config_sel_valid_0 <= '0';
            config_sel_0       <= 0;
          else
            config_sel_valid_0 <= '1';
            config_sel_0       <= config_sel_nat;
          end if;
        end if;
      end if;
    end if;
  end process;


  --Register inputs
  reg_inputs : process(clk, reset, nd, fd, din, fd_received)
  begin
    if c_pipe_level /= c_minimum then
      if reset = '1' then
        nd_r          <= '0';
        v_fd_r        <= '0';
        fd_received_r <= '0';
      elsif clk'event and clk = '1' then
        if ce_int = '1' then
          if sclr_int = '1' then
            nd_r          <= '0';
            v_fd_r        <= '0';
            fd_received_r <= '0';
          else
            nd_r          <= nd;
            v_fd_r        <= fd and nd;
            fd_received_r <= fd_received;
          end if;
          din_r <= din;
        end if;
      end if;
    else
      nd_r          <= nd;
      v_fd_r        <= fd and nd;
      din_r         <= din;
      fd_received_r <= fd_received;
    end if;
  end process;

  --Register inputs (for c_num_configurations>1)
  reg_config_inputs : process(clk, reset, nd, fd, new_config_int, config_sel)
  begin
    if c_pipe_level /= c_minimum then
      if reset = '1' then
        new_config_r <= '0';
        config_sel_r <= (others => '0');
      elsif clk'event and clk = '1' then
        if ce_int = '1' then
          if sclr_int = '1' then
            new_config_r <= '0';
            config_sel_r <= (others => '0');
          else
            new_config_r <= new_config_int and fd and nd;
            config_sel_r <= config_sel;
          end if;
        end if;
      end if;
    else
      new_config_r <= new_config_int and fd and nd;
      config_sel_r <= config_sel;
    end if;
  end process;

  --Register abort signal
  reg_abort : process(clk, reset, nd, fd, din, rffd_int, new_config_int, fd_received)
  begin
    if c_pipe_level /= c_minimum then
      if reset = '1' then
        abort_r <= '0';
      elsif clk'event and clk = '1' then
        if ce_int = '1' then
          if sclr_int = '1' then
            abort_r <= '0';
          else
            abort_r <= (fd and nd and not rffd_int) or (fd and nd and not fd_received);
          end if;
        end if;
      end if;
    else
      abort_r <= (fd and nd and not rffd_int) or (fd and nd and not fd_received);
    end if;
  end process;

  --Add pipelining to read address
  pipe_raddr : process(clk, reset, shiftbr_delayed, config_sel_delayed, config_sel_valid_delayed,
                      new_config_delayed, nd_delayed, sync_delayed)
  begin
    if c_pipe_level = c_maximum then
      if clk'event and clk = '1' then
        if ce_int = '1' then
          sync_raddr_r             <= sync_delayed;
          new_config_raddr_r       <= new_config_delayed;
          config_sel_raddr_r       <= config_sel_delayed;
          config_sel_valid_raddr_r <= config_sel_valid_delayed;
          if sclr_int = '1' or abort_r = '1' then
            shiftbr_raddr_r <= -1;
            nd_raddr_r      <= '0';
          else
            shiftbr_raddr_r <= shiftbr_delayed;
            nd_raddr_r      <= nd_delayed;
          end if;
        end if;
      end if;
    else
      shiftbr_raddr_r          <= shiftbr_delayed;
      sync_raddr_r             <= sync_delayed;
      new_config_raddr_r       <= new_config_delayed;
      config_sel_raddr_r       <= config_sel_delayed;
      config_sel_valid_raddr_r <= config_sel_valid_delayed;
      nd_raddr_r               <= nd_delayed;
    end if;
  end process;

  --Register outputs

  reg_outputs : process(clk, reset, rdy_enable_d, fdo_d)
  begin
    if c_pipe_level = c_maximum then
      if reset = '1' then
        fdo_q        <= '0';
        rdy_enable_q <= '0';
      elsif clk'event and clk = '1' then
        if ce_int = '1' then
          if sclr_int = '1' or abort_r = '1'then
            fdo_q        <= '0';
            rdy_enable_q <= '0';
          else
            fdo_q        <= fdo_d;
            rdy_enable_q <= rdy_enable_d;
          end if;
        end if;
      end if;
    else
      fdo_q        <= fdo_d;
      rdy_enable_q <= rdy_enable_d;
    end if;
  end process;


  --Process that adds an extra stage of delay to fdo for ext ram
  fdo_adjust : process(clk, reset, fdo_q, rdy_enable_d)
  begin
    if c_external_ram /= 0 then
      if reset = '1' then
        fdo_int        <= '0';
        rdy_enable_int <= '0';
      elsif clk'event and clk = '1' then
        if ce_int = '1' then
          if sclr_int = '1' or (abort_r = '1') then
            fdo_int        <= '0';
            rdy_enable_int <= '0';
          else
            fdo_int        <= fdo_q;
            rdy_enable_int <= rdy_enable_q;
          end if;
        end if;
      end if;
    else
      fdo_int        <= fdo_q;
      rdy_enable_int <= rdy_enable_q;
    end if;
  end process;

  --Process that adds an extra stage of delay to ndo for ext ram
  ndo_adjust : process(clk, reset, ndo_d)
  begin
    if c_external_ram /= 0 then
      if reset = '1' then
        ndo_int   <= '0';
        rd_en_int <= '0';
      elsif clk'event and clk = '1' then
        if ce_int = '1' then
          if sclr_int = '1' or (abort_r = '1') then
            ndo_int   <= '0';
            rd_en_int <= '0';
          else
            ndo_int   <= ndo_d;
            rd_en_int <= rd_en_d;
          end if;
        end if;
      end if;
    else
      ndo_int <= ndo_d;
    end if;
  end process;

  --Process that adds an extra stage of delay to wr_en for ext ram
  wr_en_adjust : process(clk, reset)
  begin
    if power /= '1' then
      wr_en_int <= '0';
    elsif reset = '1' then
      wr_en_int <= '0';
    elsif clk'event and clk = '1' then
      if ce_int = '1' then
        if sclr_int = '1' or (abort_r = '1') then
          wr_en_int <= '0';
        else
          wr_en_int <= wr_en_d;
        end if;
      end if;
    end if;
  end process;

  --Delayed signals process
  delsigs : process(clk, reset)
  begin
    if reset = '1' then
      if c_pipe_level = c_maximum then
        nd_delayed <= '0';
      end if;
      shiftbr_1          <= -1;
      nd_1               <= '0';
      nd_0               <= '0';
      fd_delayed         <= '0';
      fd_1               <= '0';
      fd_0               <= '0';
      new_config_delayed <= '0';
      new_config_1       <= '0';
    elsif clk'event and clk = '1' then
      if ce_int = '1' then
        if sclr_int = '1' then
          shiftbr_1                <= -1;
          fd_delayed               <= '0';
          fd_1                     <= '0';
          fd_0                     <= '0';
          config_sel_delayed       <= 0;
          config_sel_1             <= 0;
          config_sel_valid_delayed <= '0';
          config_sel_valid_1       <= '0';
          new_config_delayed       <= '0';
          new_config_1             <= '0';
        else
          if c_external_ram = 0 and abort_r = '1' then
            shiftbr_1 <= -1;
          else
            shiftbr_1 <= shiftbr_0;
          end if;
          config_sel_delayed       <= config_sel_1;
          config_sel_1             <= config_sel_0;
          config_sel_valid_delayed <= config_sel_valid_1;
          config_sel_valid_1       <= config_sel_valid_0;
          if abort_r = '1' then
            --need to resync, therefore, abort by purging registers
            new_config_delayed <= '0';
            new_config_1       <= '0';
            new_config_0       <= new_config_r;
            fd_delayed         <= '0';
            fd_1               <= '0';
            fd_0               <= '1';
            nd_delayed         <= '0';
            nd_1               <= '0';
          else
            new_config_delayed <= new_config_1;
            new_config_1       <= new_config_0;
            new_config_0       <= new_config_r;
            fd_delayed         <= fd_1;
            fd_1               <= fd_0;
            fd_0               <= v_fd_r;
            nd_delayed         <= nd_1;
            nd_1               <= nd_0;
          end if;
          if (fd_received_r = '1' or v_fd_r = '1') then
            nd_0 <= nd_r;
          end if;
        end if;
      end if;
    end if;
  end process;

  --shifbr_delayed process
  shifbr_delayed_proc : process(clk, reset)
  begin
    if reset = '1' and c_pipe_level = c_maximum then
      shiftbr_delayed <= -1;
    elsif clk'event and clk = '1' then
      if ce_int = '1' then
        if sclr_int = '1' then
          shiftbr_delayed <= -1;
        else
          if c_external_ram = 0 and abort_r = '1' then
            shiftbr_delayed <= -1;
          else
            shiftbr_delayed <= shiftbr_1;
          end if;
        end if;
      end if;
    end if;
  end process;

  --FD received process
  --Indicates whether a valid fd has ever been received.
  fd_received_proc : process (clk, reset)
  begin  -- process register_output
    if reset = '1' then
      fd_received <= '0';
    elsif (clk'event and clk = '1') then
      if ce_int = '1' then
        if sclr_int = '1' then
          fd_received <= '0';
        elsif fd = '1' and nd = '1' then
          fd_received <= '1';
        end if;
      end if;
    end if;
  end process fd_received_proc;

  --rffd_int process
  rffd_int_proc : process(f_sw, config_sel_valid_rffd, fd_received)
  begin
    if fd_received /= '1' then
      rffd_int <= '1';
    else
      if f_sw = 0 then
        rffd_int <= '1';
      else
        rffd_int <= '0';
      end if;
    end if;
  end process;


  -- Switch position process
  -- This process determines which one of the branches
  -- is active.
  switch_posn : process(clk, reset)

    variable config_sel_nat : natural range 0 to 2**config_sel_width-1;
    variable num_branches   : integer := abs_min_num_branches;
    variable fd_rx          : boolean := false;

    procedure park_switch is
    begin
      fd_rx := false;
      f_sw  <= 0;                       --clear all contacts
    end park_switch;

    procedure start_switch is
    begin
      fd_rx := true;
      f_sw  <= 1;                       --set position 1
      if c_num_configurations > 1 then
        if new_config_int = '1' then
          config_sel_nat := std_logic_vector_to_natural(config_sel);
          if config_sel_nat > c_num_configurations-1 then
            config_sel_valid_rffd <= '0';
            num_branches          := forney_params(0).fld_num_branches;
          else
            config_sel_valid_rffd <= '1';
            num_branches          := forney_params(config_sel_nat).fld_num_branches;
          end if;
        end if;
      else
        num_branches := c_num_branches;
      end if;
    end start_switch;

    procedure rotate_switch(num_branches : in integer) is
    begin
      f_sw <= (f_sw + 1) mod num_branches;  --wrap position 0
    end rotate_switch;
    
  begin

    if reset = '1' then
      park_switch;
    elsif clk'event and clk = '1' then
      if ce_int = '1' then
        if sclr_int = '1' then
          park_switch;
        elsif (fd = '1' and nd = '1' and not fd_rx) then             --first fd
          start_switch;
        elsif (fd = '1' and nd = '1' and rffd_int = '0') then        --abort
          start_switch;
        elsif (fd = '1' and nd = '1' and new_config_int = '1') then  --abort
          start_switch;
        elsif nd = '1' and fd_rx then                                --running
          rotate_switch(num_branches);
        end if;
      end if;
    end if;

  end process;

  -- shiftbr_0_proc process
  -- This process determines which one of the branches
  -- is to be shifted
  shiftbr_0_proc : process(clk, reset)

    variable config_sel_nat : natural range 0 to 2**config_sel_width-1;
    variable num_branches   : integer := abs_min_num_branches;
    variable fd_rx          : boolean := false;

    procedure clear_shiftbr is
    begin
      fd_rx     := false;
      shiftbr_0 <= -1;
    end clear_shiftbr;

    procedure reset_shiftbr is
    begin
      fd_rx     := true;
      shiftbr_0 <= 0;
      if c_num_configurations > 1 then
        if new_config_r = '1' then
          config_sel_nat := std_logic_vector_to_natural(config_sel_r);
          if config_sel_nat > c_num_configurations-1 then
            num_branches := forney_params(0).fld_num_branches;
          else
            num_branches := forney_params(config_sel_nat).fld_num_branches;
          end if;
        end if;
      else
        num_branches := c_num_branches;
      end if;
    end reset_shiftbr;

    procedure rotate_shiftbr(num_branches : in integer) is
    begin
      shiftbr_0 <= (shiftbr_0 + 1) mod num_branches;  --wrap position 0
    end rotate_shiftbr;
    
  begin

    if reset = '1' then
      clear_shiftbr;
    elsif clk'event and clk = '1' then
      if ce_int = '1' then
        if sclr_int = '1' then
          clear_shiftbr;
        elsif nd_r = '1' then
          if v_fd_r = '1' then
            reset_shiftbr;
          elsif fd_rx then
            rotate_shiftbr(num_branches);
          end if;
        end if;
      end if;
    end if;

  end process;  --shiftbr_0_proc


  --Process to generate write data
  write_data_proc : process(clk, power)

    constant wr_data_buf_length : integer                             := select_val(1, 2, c_pipe_level = c_maximum)
    + select_val(1, 0, c_external_ram = 0);
    variable wr_data_buf        : DATABUFFER(0 to wr_data_buf_length) := (others => (others => '0'));

  begin

    if power /= '1' then
      wr_data_int <= (others => '0');
    elsif (clk'event and clk = '1') then
      if ce_int = '1' then
        --wr_data is unaffected by sclr or nd
        wr_data_int <= wr_data_buf(wr_data_buf_length-1);
        for i in wr_data_buf_length-1 downto 0 loop
          wr_data_buf(i+1) := wr_data_buf(i);
        end loop;
        wr_data_buf(0) := din_r;
      end if;  --ce_int
    end if;  --power

  end process;


  --Process to generate write address
  write_address_proc : process(clk, power)

    variable write_addr_vect    : BVECTOR;
    variable wr_addr_nat        : natural range 0 to (2**c_ext_addr_width)-1;
    variable wr_addr_buf        : INTEGER_VECTOR(0 to 3);  --Use to adjust delay
    variable wshiftbr           : SID_FORNEY_SWITCH;
    variable nd_w               : std_logic;
    variable new_config_w       : std_logic                                 := '0';
    variable sync_w             : std_logic                                 := '0';
    variable config_sel_valid_w : std_logic                                 := '0';
    variable config_sel_w       : natural range 0 to c_num_configurations-1 := 0;
    variable config_sel_w_in    : natural range 0 to c_num_configurations-1 := 0;
    variable this_branch        : natural range 0 to max_num_branches-1     := 0;
    variable num_branches       : integer;
    variable firstrotation      : std_logic                                 := '0';  --'1' on first rotation of the switch


  begin

    if power /= '1' then
      wr_addr_int        <= (others => '0');
      wr_addr_nat        := 0;
      wr_addr_buf        := (others => 0);
      config_sel_w       := 0;
      config_sel_w_in    := 0;
      new_config_w       := '0';
      config_sel_valid_w := '0';
      write_addr_vect    := forney_params(0).fld_branch_end_vector;
      num_branches       := forney_params(0).fld_num_branches;
      wshiftbr           := -1;
      nd_w               := '0';
      sync_w             := '0';
      firstrotation      := '0';

    elsif (clk'event and clk = '1') then

      if ce_int = '1' then

        if c_pipe_level /= c_maximum then
          wshiftbr           := shiftbr_1;
          nd_w               := nd_1;
          sync_w             := sync_1;
          config_sel_w_in    := config_sel_1;
          new_config_w       := new_config_1;
          config_sel_valid_w := config_sel_valid_1;
        else
          wshiftbr           := shiftbr_delayed;
          nd_w               := nd_delayed;
          sync_w             := sync_delayed;
          config_sel_w_in    := config_sel_delayed;
          new_config_w       := new_config_delayed;
          config_sel_valid_w := config_sel_valid_delayed;
        end if;

        if new_config_w = '1' then
          firstrotation := '1';
          if config_sel_valid_w = '1' then
            config_sel_w := config_sel_w_in;
          else
            config_sel_w := 0;
          end if;
          write_addr_vect    := forney_params(config_sel_w).fld_branch_end_vector;
          write_addr_vect(0) := forney_params(config_sel_w).fld_branch_start_vector(0);
          num_branches       := forney_params(config_sel_w).fld_num_branches;
          wr_addr_buf(0)     := write_addr_vect(0);
        elsif firstrotation = '1' and sync_w = '1' then
          write_addr_vect    := forney_params(config_sel_w).fld_branch_end_vector;
          write_addr_vect(0) := forney_params(config_sel_w).fld_branch_start_vector(0);
          wr_addr_buf(0)     := write_addr_vect(0);
        elsif (sync_1 = '1' and c_pipe_level = c_maximum) or sync_0 = '1' or abort_r = '1' or sclr_int = '1' then
          --do nothing
        else
          if wshiftbr /= -1 and nd_w = '1' then
            if wshiftbr = 0 then
              firstrotation := '0';
            end if;
            this_branch := wshiftbr;
            --Shift the branch pointed to by the switch
            if (
              write_addr_vect(this_branch)=
              forney_params(config_sel_w).fld_branch_end_vector(this_branch)
              )then
              write_addr_vect(this_branch) :=
                forney_params(config_sel_w).fld_branch_start_vector(this_branch);  --reset
            else
              write_addr_vect(this_branch) :=
                write_addr_vect(this_branch)+1;  --add 1
            end if;
            --Select the write address pointed to by the switch
            wr_addr_buf(0) := write_addr_vect(this_branch);
          end if;  --wshiftbr
        end if;
        --Back end delay can be adjusted by changing the wr_addr_buf index
        wr_addr_nat := wr_addr_buf(0);
        wr_addr_int <= integer_to_std_logic_vector(wr_addr_buf(0), c_ext_addr_width);

        if wr_en_d = '1' then
          if abort_r /= '1' and sclr_int /= '1' then
            smem(wr_addr_nat) <= wr_data_int;
          end if;
        end if;

      end if;  --ce_int
    end if;  --power

  end process;


  --Process to generate read address --incorporating symbol memory
  read_address_proc : process(clk, reset)

    variable read_addr_vect : BVECTOR;
    variable num_branches   : integer;
    variable config         : natural range 0 to c_num_configurations-1 := 0;
    variable this_branch    : natural range 0 to max_num_branches-1     := 0;
    variable firstrotation  : std_logic                                 := '0';  --'1' on first rotation of the switch
    variable rd_addr_d      : natural range 0 to (2**c_ext_addr_width)-1;

  begin

    if power /= '1' then
      read_addr_vect := forney_params(0).fld_branch_start_vector;
      num_branches   := forney_params(0).fld_num_branches;
      rd_addr_int    <= (others => '0');
      rd_addr_d      := 0;
      config         := 0;
      firstrotation  := '0';
    elsif (clk'event and clk = '1') then
      if ce_int = '1' then
        if nd_raddr_r = '1' then
          if new_config_raddr_r = '1' then
            firstrotation := '1';
            config        := config_sel_raddr_r;

            read_addr_vect := forney_params(config).fld_branch_start_vector;
            num_branches   := forney_params(config).fld_num_branches;

            if read_addr_vect(0) = forney_params(config).fld_branch_end_vector(0) then
              read_addr_vect(0) := forney_params(config).fld_branch_start_vector(0);  --reset
            else
              read_addr_vect(0) := read_addr_vect(0)+1;  --add 1
            end if;
            rd_addr_d   := read_addr_vect(0);
            rd_addr_int <= integer_to_std_logic_vector(read_addr_vect(0), c_ext_addr_width);

          elsif firstrotation = '1' and sync_raddr_r = '1' then
            read_addr_vect := forney_params(config).fld_branch_start_vector;
            if read_addr_vect(0) = forney_params(config).fld_branch_end_vector(0) then
              read_addr_vect(0) := forney_params(config).fld_branch_start_vector(0);  --reset
            else
              read_addr_vect(0) := read_addr_vect(0)+1;  --add 1
            end if;
            rd_addr_d   := read_addr_vect(0);
            rd_addr_int <= integer_to_std_logic_vector(read_addr_vect(0), c_ext_addr_width);
            
          else
            if shiftbr_raddr_r = 0 then
              firstrotation := '0';
            end if;
            if shiftbr_raddr_r /= -1 then
              this_branch := shiftbr_raddr_r;
              if (
                read_addr_vect(this_branch)=
                forney_params(config).fld_branch_end_vector(this_branch)
                )then
                read_addr_vect(this_branch) :=
                  forney_params(config).fld_branch_start_vector(this_branch);  --reset
              else
                read_addr_vect(this_branch) :=
                  read_addr_vect(this_branch)+1;  --add 1
              end if;
              --Select one read address (Rotate the output switch)
              if abort_r /= '1' and sclr_int /= '1' then
                rd_addr_d := read_addr_vect(this_branch);
              end if;

              rd_addr_int <= integer_to_std_logic_vector
                             (read_addr_vect(this_branch), c_ext_addr_width);
            end if;
          end if;
        end if;  --nd_raddr_r
        if rd_en_d = '1' then
          if abort_r /= '1' then
            dout_int <= smem(rd_addr_d);
          end if;
        end if;
      end if;  --ce
    end if;  --power
  end process;

  --FDO port
  fdoport : process(fdo_int, ndo_int)
  begin
    if c_has_fdo /= 0 then
      fdo <= (fdo_int and ndo_int) after output_delay;
    else
      fdo <= 'U';
    end if;
  end process;

  --NDO PORT process
  ndoport : process(ndo_int)
  begin
    if c_has_ndo /= 0 then
      ndo <= ndo_int after output_delay;
    else
      ndo <= 'U';
    end if;
  end process;

  --RD_EN PORT process
  rd_en_d <= ndo_vect(ndo_delay-1);

  rd_en_port : process(clk, reset, rd_en_int)
  begin
    if c_external_ram /= 0 then
      rd_en <= rd_en_int after output_delay;
    else
      rd_en <= 'U';
    end if;
  end process;  --rd_en_port

  --WR_EN PORT process
  wr_en_d <= ndo_vect(ndo_delay-2);
  wr_en_port : process(wr_en_int)
  begin
    if c_external_ram /= 0 then
      wr_en <= wr_en_int after output_delay;
    else
      wr_en <= 'U';
    end if;
  end process;

  --WR_DATA PORT process
  wr_data_port : process(wr_data_int)
  begin
    if c_external_ram /= 0 then
      wr_data <= wr_data_int after output_delay;
    else
      wr_data <= (others => 'U');
    end if;
  end process;

  --RD_ADDR PORT process (Forney)
  rd_addr_port : process(rd_addr_int, rd_en_int)
  begin
    if c_external_ram /= 0 then
      if rd_en_int = '1' then
        rd_addr <= rd_addr_int after output_delay;
      else
        rd_addr <= (others => 'X') after output_delay;
      end if;
    else
      rd_addr <= (others => 'U');
    end if;
  end process;

  --WR_ADDR PORT process
  wr_addr_port : process(wr_addr_int, wr_en_int)
  begin
    if c_external_ram /= 0 then
      if wr_en_int = '1' then
        wr_addr <= wr_addr_int after output_delay;
      else
        wr_addr <= (others => 'X') after output_delay;
      end if;
    else
      wr_addr <= (others => 'U');
    end if;
  end process;

  --RDY port
  --for when the length of branch 0 is 0, rdy is the same as ndo
  rdyport : process(ndo_int, rdy_enable_int)
  begin
    rdy_int <= (ndo_int and (rdy_enable_int)) after output_delay;
  end process;


  --FDO proc process

  fdo_proc : process (clk, reset)
    
    variable fdo_proc_delay : integer;

  begin
    fdo_proc_delay := forney_params(config_sel_delayed).fld_fdo_proc_delay;

    if reset = '1' then
      fdo_proc_vect <= (others => '0');
      fdo_d         <= '0';
    elsif (clk'event and clk = '1') then
      if ce_int = '1' then
        if sclr_int = '1' then
          fdo_proc_vect <= (others => '0');
          fdo_d         <= '0';
        else
          if fdo_proc_delay > 1 then
            if fd_delayed = '1' then
              fdo_proc_vect    <= (others => '0');
              fdo_proc_vect(0) <= fd_delayed;
              fdo_d            <= '0';
            else
              fdo_d <= fdo_proc_vect(fdo_proc_delay-2);
              if nd_delayed = '1' then
                fdo_proc_vect(fdo_proc_delay downto 1) <= fdo_proc_vect((fdo_proc_delay -1) downto 0);

                fdo_proc_vect(0) <= fd_delayed;
                                                          
              end if;
            end if;
          else
            if abort_r = '1' then
              fdo_d <= '0';
            else
              fdo_d <= fd_delayed;
            end if;
          end if;
        end if;
      end if;
    end if;
  end process;


  --RDY_enable process
  --rdy is enabled when the first fdo is output
  rdy_enable_proc : process (clk, reset)
    
    variable fdo_proc_delay : integer;

  begin
    fdo_proc_delay := forney_params(config_sel_delayed).fld_fdo_proc_delay;

    if reset = '1' then
      rdy_enable_d <= '0';
    elsif (clk'event and clk = '1') then
      if ce_int = '1' then
        if sclr_int = '1' then
          rdy_enable_d <= '0';
        else
          if fdo_proc_delay > 1 then
            if abort_r = '1' then
              rdy_enable_d <= '0';
            elsif (fdo_proc_vect(fdo_proc_delay-2) = '1'
                   and fd_delayed /= '1'  -- because this clears fdo_proc_vect
                   and sync_0 /= '1'    -- because and abort occurred
                   and sync_1 /= '1'    -- because and abort occurred
                   and sync_delayed /= '1'  -- because and abort occurred
                   ) then
              rdy_enable_d <= '1';
            end if;
          else
            if abort_r = '1' then
              rdy_enable_d <= '0';
            elsif fd_delayed = '1' then
              rdy_enable_d <= '1';
            end if;
          end if;
        end if;
      end if;
    end if;
  end process;

  sync_proc : process (clk, reset)

  begin  -- process register_output
    if reset = '1' then
      sync_delayed <= '0';
      sync_1       <= '0';
      sync_0       <= '0';
    elsif (clk'event and clk = '1') then
      if ce_int = '1' then
        if sclr_int = '1' then
          sync_delayed <= '0';
          sync_1       <= '0';
          sync_0       <= '0';
        else
          sync_delayed <= sync_1;
          sync_1       <= sync_0;
          sync_0       <= abort_r;
        end if;
      end if;
    end if;
  end process;

  --NDO delay process
  --ndo is nd_r, delayed by (ndo_delay) clocks
  ndo_delay_proc : process (clk, reset)

  begin
    if reset = '1' then
      ndo_vect <= (others => '0');
      ndo_d    <= '0';
    elsif (clk'event and clk = '1') then
      if ce_int = '1' then
        if sclr_int = '1' or (fd_received_r = '0') then
          ndo_vect    <= (others => '0');
          ndo_d       <= '0';
          ndo_vect(0) <= v_fd_r;        --load a 1 if first fd
        else
          if abort_r = '1' then         --abort condition
            -- purge shift register
            ndo_vect    <= (others => '0');
            ndo_vect(0) <= nd_r;
            ndo_d       <= '0';
          else
            ndo_d       <= ndo_vect(ndo_delay-1);
            ndo_vect(0) <= nd_r;
            for n in 1 to (ndo_delay-1) loop
              ndo_vect(n) <= ndo_vect(n-1);
            end loop;  -- n
          end if;
        end if;
      end if;
    end if;
  end process;


end behavioral;



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


library ieee;
use ieee.STD_LOGIC_1164.all;

library std;
use std.textio.all;

library xilinxcorelib;
use xilinxcorelib.sid_const_pkg_behav_v6_0.all;
use xilinxcorelib.sid_pkg_behav_v6_0.all;
use xilinxcorelib.sid_mif_pkg_behav_v6_0.all;

entity sid_bhv_rectangular_block_v6_0 is
  generic (
    c_family               : string;
    c_mode                 : integer;
    c_symbol_width         : integer;
    -- Row specific generics
    c_row_type             : integer;
    c_row_constant         : integer;
    c_has_row              : integer;
    c_has_row_valid        : integer;
    c_min_num_rows         : integer;
    c_row_width            : integer;
    c_num_selectable_rows  : integer;
    c_row_select_file      : string := "";
    c_has_row_sel          : integer;
    c_has_row_sel_valid    : integer;
    c_use_row_permute_file : integer;
    c_row_permute_file     : string := "";
    -- Column specific generics
    c_col_type             : integer;
    c_col_constant         : integer;
    c_has_col              : integer;
    c_has_col_valid        : integer;
    c_min_num_cols         : integer;
    c_col_width            : integer;
    c_num_selectable_cols  : integer;
    c_col_select_file      : string := "";
    c_has_col_sel          : integer;
    c_has_col_sel_valid    : integer;
    c_use_col_permute_file : integer;
    c_col_permute_file     : string := "";
    -- Block size specific generics
    c_block_size_type      : integer;
    c_block_size_constant  : integer;
    c_has_block_size       : integer;
    c_block_size_width     : integer;
    c_has_block_size_valid : integer;
    -- Implementation generics
    c_memstyle             : integer;
    c_pipe_level           : integer;
    -- Optional pin generics
    c_has_ce               : integer;
    c_has_nd               : integer;
    c_has_sclr             : integer;
    c_has_rdy              : integer;
    c_has_rffd             : integer;
    c_has_rfd              : integer;
    c_has_block_start      : integer;
    c_has_block_end        : integer;

    --New for generics v4_0
    c_architecture   : integer;
    c_external_ram   : integer;
    c_ext_addr_width : integer);
  port (
    -- Mandatory pins
    clk              : in  std_logic;
    fd               : in  std_logic;
    din              : in  std_logic_vector(c_symbol_width-1 downto 0);
    -- Optional input pins
    ce               : in  std_logic;
    nd               : in  std_logic;
    sclr             : in  std_logic;
    row              : in  std_logic_vector(c_row_width-1 downto 0);
    row_sel          : in  std_logic_vector(
      bits_needed_to_represent(c_num_selectable_rows-1) - 1 downto 0);
    col              : in  std_logic_vector(c_col_width-1 downto 0);
    col_sel          : in  std_logic_vector(
      bits_needed_to_represent(c_num_selectable_cols-1) - 1 downto 0);
    block_size       : in  std_logic_vector(c_block_size_width-1 downto 0);
    -- Mandatory output pins
    dout             : out std_logic_vector(c_symbol_width-1 downto 0);
    -- optional output pins
    rfd              : out std_logic;
    rdy              : out std_logic;
    rffd             : out std_logic;
    row_valid        : out std_logic;
    col_valid        : out std_logic;
    row_sel_valid    : out std_logic;
    col_sel_valid    : out std_logic;
    block_size_valid : out std_logic;
    block_start      : out std_logic;
    block_end        : out std_logic;

    rd_data          : in  std_logic_vector(c_symbol_width-1 downto 0);  -- Read data from external RAM
    rd_en            : out std_logic;
    wr_en            : out std_logic;
    rd_addr          : out std_logic_vector(c_ext_addr_width-1 downto 0);
    wr_addr          : out std_logic_vector(c_ext_addr_width-1 downto 0);
    wr_data          : out std_logic_vector(c_symbol_width-1 downto 0));  -- Write data to external RAM

end sid_bhv_rectangular_block_v6_0;

architecture behavioral of sid_bhv_rectangular_block_v6_0 is

  constant output_delay : time := 1 ns;

  ------------------------------------------------------------------------------
  -- Return number of values in the total rcl permute vector
  --The number of values in the total_rcl_permute_vector equals the total of all
  --the values in the rcl select vector.
  --
  function get_num_total_permute_vals(rcl_type          : integer;
                                      num_rcls          : integer;
                                      rcl_select_vector : INTEGER_VECTOR
                                      ) return integer is
    variable return_val : integer := 0;
  begin
    if rcl_type = c_selectable then
      return_val := get_sum(rcl_select_vector);
    elsif rcl_type = c_constant then
      return_val := num_rcls;
    else
      return_val := 1;
    end if;

    return return_val;
  end get_num_total_permute_vals;

  ------------------------------------------------------------------------------
  constant max_num_selectable_rows : integer := 32;  --defined in spec
  constant max_num_selectable_cols : integer := 32;  --defined in spec
  constant max_num_selectable_rcls : integer := 32;  --where rcl is row or col


  constant row_sel_width : integer := bits_needed_to_represent(c_num_selectable_rows-1);
  constant col_sel_width : integer := bits_needed_to_represent(c_num_selectable_cols-1);

  constant really_read_row_select_mif : boolean := (c_row_type = c_selectable);

  constant row_select_vector : integer_vector(0 to c_num_selectable_rows-1)
    := get_integer_vector_from_mif(really_read_row_select_mif,
                                   c_row_select_file,
                                   c_num_selectable_rows,
                                   SID_CONST_PKG_BEHAV_mif_width);



  -- max_num_rows is the biggest value in row_select_vector, or is determined
  -- by 'row' generics
  constant max_num_rows : integer := get_max_dimension(c_row_type,
                                                       c_row_constant,
                                                       c_row_width,
                                                       row_select_vector);

  constant really_read_col_select_mif : boolean := (c_col_type = c_selectable);

  constant col_select_vector : integer_vector(0 to c_num_selectable_cols-1)
    := get_integer_vector_from_mif(really_read_col_select_mif,
                                   c_col_select_file,
                                   c_num_selectable_cols,
                                   SID_CONST_PKG_BEHAV_mif_width);

  -- max_num_cols is the biggest value in col_select_vector, or is determined
  -- by 'col' generics
  constant max_num_cols : integer := get_max_dimension(c_col_type,
                                                       c_col_constant,
                                                       c_col_width,
                                                       col_select_vector);


  constant max_block_size : integer :=
    get_max_block_size(max_num_rows, max_num_cols, c_block_size_constant,
                       c_block_size_type, c_block_size_width);

  constant max_num_symbol_ram_cells : integer := max_num_rows * max_num_cols;

  constant num_symbol_ram_cells : integer := max_block_size;

  -- Round up to nearest 16 prior to get_memstyle calculation
  constant symbol_ram_depth_tmp : integer :=
    get_mem_depth_dp(num_symbol_ram_cells, c_distmem);

  -- Select appropriate memstyle for symbol memory
  constant symbol_mem_style : integer := get_memstyle(
    depth     => symbol_ram_depth_tmp,
    width     => c_symbol_width,
    style     => c_memstyle,
    mem_type => c_sp_ram,
    smart     => true
    );


  constant rectangle_size : integer := max_num_rows * max_num_cols;

  constant pruned : boolean := max_block_size < rectangle_size or
                               c_block_size_type = c_variable;
  
  constant pruned_single_row : boolean :=
    pruned and c_row_type = c_constant and max_num_rows = 1;
  
  constant wss_delay : integer := calc_wss_delay(pruned,
                                                c_block_size_type,
                                                c_col_type,
                                                c_row_type);

  constant wsip_delay_val : integer :=
    select_val(1, 3, c_use_row_permute_file /= 0 or c_use_col_permute_file /= 0);


  constant output_buffer_length : integer := wss_delay
                                            + select_val(0, 2, c_use_row_permute_file /= 0 or c_use_col_permute_file /= 0)
                                            + 1;  
  
  constant input_buffer_length : integer := wss_delay + 1
                                           + select_val(0, 2, c_use_row_permute_file /= 0 or c_use_col_permute_file /= 0);
  
  constant addr_buffer_length : integer := wss_delay
                                          + select_val(0, 2, c_use_row_permute_file /= 0 or c_use_col_permute_file /= 0);

  constant wr_en_buffer_length : integer := wss_delay + 1
                                           + select_val(0, 2, c_use_row_permute_file /= 0 or c_use_col_permute_file /= 0);
  
  constant rd_en_buffer_length : integer := wss_delay + 1
                                           + select_val(0, 2, c_use_row_permute_file /= 0 or c_use_col_permute_file /= 0);

  --delay between fd and assertion of row_valid etc.
  constant xvalid_buffer_length : integer := calc_xvalid_buffer_length
                                             (wss_delay, c_block_size_type, c_col_type, c_row_type);

  --The number of values in the total permute vector is not
  --greater than largest value in the row/column select vector
  --times the number of selectable rows/columns.
  constant max_total_row_permute_vals : integer := max_num_rows * c_num_selectable_rows;
  constant max_total_col_permute_vals : integer := max_num_cols * c_num_selectable_cols;


  --The number of values in the total_row_permute_vector equals the total of all
  --the values in the row select vector.
  constant num_total_row_permute_values : natural := get_num_total_permute_vals
                                                     (c_row_type, c_row_constant, row_select_vector);
  
  constant really_read_total_row_permute_mif : boolean := (c_use_row_permute_file /= 0);

  constant initial_total_row_permute_vector : integer_vector(0 to (num_total_row_permute_values-1))
    := get_integer_vector_from_mif(really_read_total_row_permute_mif,
                                   c_row_permute_file,
                                   num_total_row_permute_values,
                                   SID_CONST_PKG_BEHAV_mif_width);

  --The number of values in the total_col_permute_vector equals the total of all
  --the values in the col select vector.
  constant num_total_col_permute_values : natural := get_num_total_permute_vals
                                                     (c_col_type, c_col_constant, col_select_vector);
  
  constant really_read_total_col_permute_mif : boolean := (c_use_col_permute_file /= 0);

  constant initial_total_col_permute_vector : integer_vector(0 to (num_total_col_permute_values-1))
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
  function make_permute_offset_vector(rcl_type            : integer;
                                      num_selectable_rcls : integer;
                                      rcl_select_vector   : integer_vector)
    return integer_vector is

    variable offset : integer_vector(0 to num_selectable_rcls-1) := (others => 0);
  begin
    if rcl_type /= c_selectable then
      offset := (others => 0);
    else
      offset(0) := 0;
      for i in 1 to num_selectable_rcls-1 loop
        offset(i) := offset(i-1)+rcl_select_vector(i-1);
      end loop;
    end if;
    return offset;
  end make_permute_offset_vector;


  constant row_permute_offset_vector : integer_vector(0 to c_num_selectable_rows-1)
    := make_permute_offset_vector(c_row_type,
                                  c_num_selectable_rows, row_select_vector);

  constant col_permute_offset_vector : integer_vector(0 to c_num_selectable_cols-1)
    := make_permute_offset_vector(c_col_type,
                                  c_num_selectable_cols, col_select_vector);


  ------------------------------------------------------------------------------
  -- If interleaver, need to make inverse total row or column permute vector
  --
  function get_actual_total_permute_vector(mode                             : integer;
                                           initial_total_rcl_permute_vector : integer_vector;
                                           num_total_rcl_permute_values     : integer;
                                           rcl_type                         : integer;
                                           num_rcls                         : integer;
                                           num_selectable_rcls              : integer;
                                           rcl_select_vector                : integer_vector)
    return integer_vector is

    variable ivect  : integer_vector(0 to num_total_rcl_permute_values-1) := (others => 0);
    variable offset : integer;
  begin
    if mode = c_interleaver then
      if rcl_type = c_selectable then
        offset := 0;
        for s in 0 to num_selectable_rcls-1 loop
          for i in 0 to rcl_select_vector(s)-1 loop
            --sweep for target
            for j in 0 to rcl_select_vector(s)-1 loop
              if initial_total_rcl_permute_vector(offset+j) = i then
                ivect(i+offset) := j;
              end if;
            end loop;
          end loop;
          offset := offset + rcl_select_vector(s);
        end loop;
      elsif rcl_type = c_constant then
        for i in 0 to num_rcls-1 loop
          for j in 0 to num_rcls-1 loop
            --Search through the vector till i is found.
            --Put the location of it into the output
            --vector
            if initial_total_rcl_permute_vector(j) = i then
              ivect(i) := j;
            end if;
          end loop;
        end loop;
      else
        ivect := (others => 0);  --rcl_type = c_variable: permutations not allowed
      end if;
    else
      ivect := initial_total_rcl_permute_vector;
    end if;
    return ivect;
  end get_actual_total_permute_vector;


  constant total_row_permute_vector : integer_vector(0 to (num_total_row_permute_values-1))
    := get_actual_total_permute_vector(c_mode,
                                       initial_total_row_permute_vector,
                                       num_total_row_permute_values,
                                       c_row_type,
                                       c_row_constant,
                                       c_num_selectable_rows,
                                       row_select_vector);

  constant total_col_permute_vector : integer_vector(0 to (num_total_col_permute_values-1))
    := get_actual_total_permute_vector(c_mode,
                                       initial_total_col_permute_vector,
                                       num_total_col_permute_values,
                                       c_col_type,
                                       c_col_constant,
                                       c_num_selectable_cols,
                                       col_select_vector);

  -------------------------------------------------------------------------------
  --Data types;

  subtype SID_SYMBOL is std_logic_vector(c_symbol_width-1 downto 0);

  subtype MEM_ADDRESS is natural range 0 to max_num_symbol_ram_cells-1;

  type MEM is array (0 to max_num_symbol_ram_cells-1) of SID_SYMBOL;
  type OPBUF is array (0 to output_buffer_length) of SID_SYMBOL;
  type IPBUF is array (0 to input_buffer_length) of SID_SYMBOL;
  type MEM_ADDRESS_BUF is array (0 to addr_buffer_length) of MEM_ADDRESS;


  type FSM_STATE_TYPE is (IDLE, IDLE_1, START, WRITING, READING, READING_0, READING_1);

  -------------------------------------------------------------------------------
  function calc_col_length_vector (num_rows  : natural;
                                   num_cols  : natural;
                                   blocksize : natural)
    return INTEGER_VECTOR is

    variable result : INTEGER_VECTOR(0 to num_cols-1) := (others => 0);

  begin
    for ci in 0 to num_cols-1 loop
      if num_cols*(num_rows-1) + ci > blocksize-1 then
        result(ci) := num_rows - 1;     --pruned column
      else
        result(ci) := num_rows;         --unpruned column
      end if;
    end loop;
    return result;

  end calc_col_length_vector;

  ------------------------------------------------------------------------------


  signal ce_int    : std_logic;
  signal sclr_int  : std_logic;
  signal power     : std_logic := '0';
  signal reset : std_logic := '0';

  signal din_0   : SID_SYMBOL;
  signal din_1   : SID_SYMBOL;
  signal din_del : SID_SYMBOL;

  signal nd_int   : std_logic;
  signal nd_0     : std_logic;
  signal nd_del   : std_logic;
  signal v_fd_b   : std_logic;
  signal v_fd_0   : std_logic;
  signal v_fd_del : std_logic;
  signal abort_b  : std_logic;
  signal abort_0  : std_logic;

  signal row_0 : std_logic_vector(c_row_width-1 downto 0);
  signal row_sel_0 : std_logic_vector(
    bits_needed_to_represent(c_num_selectable_rows-1) - 1 downto 0);
  signal col_0 : std_logic_vector(c_col_width-1 downto 0);
  signal col_sel_0 : std_logic_vector(
    bits_needed_to_represent(c_num_selectable_cols-1) - 1 downto 0);
  signal block_size_0 : std_logic_vector(c_block_size_width-1 downto 0);

  signal row_valid_int        : std_logic;
  signal col_valid_int        : std_logic;
  signal row_sel_valid_int    : std_logic;
  signal col_sel_valid_int    : std_logic;
  signal block_size_valid_int : std_logic;

  signal rffd_int : std_logic;
  signal rfd_int  : std_logic;

  signal block_start_int : std_logic;
  signal block_end_int   : std_logic;
  signal rdy_int         : std_logic;

  signal dout_int : SID_SYMBOL;


  signal sram_raddr_int : std_logic_vector(c_ext_addr_width-1 downto 0)
    := (others => '0');
  signal sram_waddr_int : std_logic_vector(c_ext_addr_width-1 downto 0)
    := (others => '0');
  signal wr_data_int : std_logic_vector(c_symbol_width-1 downto 0)
    := (others => '0');
  signal wr_en_int : std_logic := '0';
  signal rd_en_int : std_logic := '1';



  --------------------------------------------------------------------------------
  -- START OF ARCHITECTURE behavioral OF sid_bhv_rectangular_block_v6_0
  --------------------------------------------------------------------------------
  
begin

  -- Output delay process
  -- add setup delay to data output signal
  output_t_proc : process(dout_int, rdy_int, rd_data)
    variable dout_t : SID_SYMBOL;
  begin
    if rdy_int = '1' then
      if c_external_ram = 0 then
        dout_t := dout_int;
      else
        dout_t := rd_data;
      end if;
    else
      dout_t := (others => 'X');
    end if;
    dout <= dout_t after output_delay;
  end process;

  --ce process
  ce_proc : process(ce)
  begin
    if c_has_ce /= 0 then
      ce_int <= ce;
    else
      ce_int <= '1';
    end if;
  end process;

  --sclr process
  sclr_proc : process(sclr)
  begin
    if c_has_sclr /= 0 then
      sclr_int <= sclr;
    else
      sclr_int <= '0';
    end if;
  end process;

  --Powerup process - runs once only
  powerup : process
  begin
    power <= '1' after 1 ns;
    wait;
  end process;  --powerup   


  --reset process

  reset_proc : process(power)
  begin
    reset <= not power;
  end process;  --reset_proc   

  --Optional rdy process
  optional_rdy : process(rdy_int)
  begin
    if c_has_rdy /= 0 then rdy <= rdy_int after output_delay;
    else rdy                   <= 'U';
    end if;
  end process;

  --Optional rffd process
  optional_rffd : process(rffd_int)
  begin
    if c_has_rffd /= 0 then rffd <= rffd_int after output_delay;
    else rffd                    <= 'U';
    end if;
  end process;


  --Optional rfd process
  optional_rfd : process(rfd_int)
  begin
    if c_has_rfd /= 0 then rfd <= rfd_int after output_delay;
    else rfd                   <= 'U';
    end if;
  end process;

  --nd process
  nd_proc : process(nd)
  begin
    if c_has_nd /= 0 then
      nd_int <= nd;
    else
      nd_int <= '1';
    end if;
  end process;

  --Delay data and control inputs

  abort_b_proc : process(nd_int, fd, rffd_int)
  begin
    v_fd_b <= fd and nd_int;
    if c_has_rffd /= 0 then
      abort_b <= fd and nd_int and not rffd_int;
    else
      abort_b <= '0';
    end if;
  end process;


  --RD_EN port is always '1'
  rd_en <= '1';


  --WR_EN PORT process
  wr_en_port : process(wr_en_int)
  begin
    if c_external_ram /= 0 then
      wr_en <= wr_en_int after output_delay;
    else
      wr_en <= 'U';
    end if;
  end process;

  --WR_DATA PORT process
  wr_data_port : process(wr_data_int)
  begin
    if c_external_ram /= 0 then
      wr_data <= wr_data_int after output_delay;
    else
      wr_data <= (others => 'U');
    end if;
  end process;

  --RD_ADDR PORT process
  --Note - Memory is single port, so rd_addr is identical to wr_addr
  rd_addr_port : process(sram_raddr_int, sram_waddr_int, rd_en_int, wr_en_int)
  begin
    if c_external_ram /= 0 then
      if wr_en_int = '1' then
        rd_addr <= sram_waddr_int after output_delay;
      elsif rd_en_int = '1' then
        rd_addr <= sram_raddr_int after output_delay;
      else
        rd_addr <= (others => 'X') after output_delay;
      end if;
    else
      rd_addr <= (others => 'U');
    end if;
  end process;


  --WR_ADDR PORT process
  --Note - Memory is single port
  --Note - Memory is single port, so wr_addr is identical to rd_addr
  wr_addr_port : process(sram_raddr_int, sram_waddr_int, rd_en_int, wr_en_int)
  begin
    if c_external_ram /= 0 then
      if wr_en_int = '1' then
        wr_addr <= sram_waddr_int after output_delay;
      elsif rd_en_int = '1' then
        wr_addr <= sram_raddr_int after output_delay;
      else
        wr_addr <= (others => 'X') after output_delay;
      end if;
    else
      wr_addr <= (others => 'U');
    end if;
  end process;


  delsigs : process(clk, reset)
  begin
    if power /= '1' then
      nd_0         <= '0';
      nd_del       <= '0';
      din_0        <= (others => '0');
      din_del      <= (others => '0');
      din_0        <= (others => '0');
      din_1        <= (others => '0');
      v_fd_0       <= '0';
      v_fd_del     <= '0';
      row_0        <= (others => '0');
      row_sel_0    <= (others => '0');
      col_0        <= (others => '0');
      col_sel_0    <= (others => '0');
      block_size_0 <= (others => '0');
    elsif reset = '1' then
      v_fd_0   <= '0';
      v_fd_del <= '0';
      nd_del   <= '0';
      abort_0  <= '0';
    elsif clk'event and clk = '1' then
      if ce_int = '1' then
        nd_del  <= nd_0;
        din_del <= din_0;
        din_1   <= din_0;
        if nd_int = '1' then
          din_0 <= din;
        end if;
        nd_0         <= nd_int;
        row_0        <= row;
        row_sel_0    <= row_sel;
        col_0        <= col;
        col_sel_0    <= col_sel;
        block_size_0 <= block_size;
        if sclr_int = '1' then
          v_fd_del <= '0';
          v_fd_0   <= '0';
          abort_0  <= '0';
        else
          v_fd_del <= v_fd_0;
          v_fd_0   <= v_fd_b;
          abort_0  <= abort_b;
        end if;
      end if;
    end if;
  end process;

  --Optional row_sel_valid process
  optional_row_sel_valid : process(row_sel_valid_int)
  begin
    if c_has_row_sel_valid /= 0 then row_sel_valid <= row_sel_valid_int after output_delay;
    else row_sel_valid                             <= 'U';
    end if;
  end process;

  --Optional col_sel_valid process
  optional_col_sel_valid : process(col_sel_valid_int)
  begin
    if c_has_col_sel_valid /= 0 then col_sel_valid <= col_sel_valid_int after output_delay;
    else col_sel_valid                             <= 'U';
    end if;
  end process;

  --Optional row_valid process
  optional_row_valid : process(row_valid_int)
  begin
    if c_has_row_valid /= 0 then row_valid <= row_valid_int after output_delay;
    else row_valid                         <= 'U';
    end if;
  end process;

  --Optional col_valid process
  optional_col_valid : process(col_valid_int)
  begin
    if c_has_col_valid /= 0 then col_valid <= col_valid_int after output_delay;
    else col_valid                         <= 'U';
    end if;
  end process;

  --Optional block_size_valid process
  optional_block_size_valid : process(block_size_valid_int)
  begin
    if c_has_block_size_valid /= 0 then block_size_valid <= block_size_valid_int after output_delay;
    else block_size_valid                                <= 'U';
    end if;
  end process;

  --Optional block_start process
  optional_block_start : process(block_start_int)
  begin
    if c_has_block_start /= 0 then block_start <= block_start_int after output_delay;
    else block_start                           <= 'U';
    end if;
  end process;

  --Optional block_end process
  optional_block_end : process(block_end_int)
  begin
    if c_has_block_end /= 0 then block_end <= block_end_int after output_delay;
    else block_end                         <= 'U';
    end if;
  end process;




  --Symbol Memory Process
  smem_proc : process(clk, reset, power)


    --delay between fd and rffd if inputs not valid.
    constant rffd_delay : natural := xvalid_buffer_length + 2;
    constant read       : boolean := true;
    constant write      : boolean := not read;

    variable fsm_state_rdy     : FSM_STATE_TYPE;
    variable fsm_state_rfd     : FSM_STATE_TYPE;
    variable smem              : MEM                                         := (others => (others => '0'));
    variable dout_buffer       : OPBUF;
    variable din_buffer        : IPBUF                                       := (others => (others => '0'));
    variable sram_raddr_buffer : MEM_ADDRESS_BUF                             := (others => 0);
    variable sram_waddr_buffer : MEM_ADDRESS_BUF                             := (others => 0);
    variable wr_en_buffer      : std_logic_vector (0 to wr_en_buffer_length) := (others => '0');
    variable rd_en_buffer      : std_logic_vector (0 to rd_en_buffer_length) := (others => '1');
    variable rdy_buffer        : std_logic_vector (0 to output_buffer_length);

    variable block_size_valid_buffer : std_logic_vector (0 to xvalid_buffer_length);
    variable row_valid_buffer        : std_logic_vector (0 to xvalid_buffer_length);
    variable v_fd_buffer             : std_logic_vector (0 to xvalid_buffer_length) := (others => '0');
    variable row_sel_valid_buffer    : std_logic_vector (0 to xvalid_buffer_length);
    variable col_valid_buffer        : std_logic_vector (0 to xvalid_buffer_length);
    variable col_sel_valid_buffer    : std_logic_vector (0 to xvalid_buffer_length);
    variable all_valid_buffer        : std_logic_vector (0 to xvalid_buffer_length);


    variable v_fd_rdy : std_logic;
    variable nd_rdy   : std_logic;

    variable smem_block_end   : std_logic;
    variable write_done       : std_logic;
    variable read_done        : std_logic;
    variable rdy_set          : std_logic;
    variable rdy_clr          : std_logic;
    variable rdy_abort        : std_logic;
    variable rdy_valid        : std_logic;
    variable rdy_set_buffer   : std_logic_vector (0 to output_buffer_length);
    variable rdy_clr_buffer   : std_logic_vector (0 to output_buffer_length);
    variable rdy_abort_buffer : std_logic_vector (0 to output_buffer_length);
    variable rdy_valid_buffer : std_logic_vector (0 to output_buffer_length);
    variable block_end_buffer : std_logic_vector (0 to output_buffer_length);


    variable col_length_vector : INTEGER_VECTOR (0 to max_num_cols-1);
    variable i                 : natural;
    variable rfd_read          : std_logic;
    variable rfd_write         : std_logic;
    variable rfd_wcount        : natural;
    variable rfd_rcount        : natural;
    variable wcount            : natural := 0;
    variable wri, p_wri        : natural := 0;
    variable wci, p_wci        : natural := 0;
    variable rcount            : natural := 0;
    variable rri, p_rri        : natural := 0;
    variable rci, p_rci        : natural := 0;
    variable smem_waddr        : MEM_ADDRESS;
    variable smem_raddr        : MEM_ADDRESS;

    variable selected_num_rows          : natural range 0 to max_num_rows   := 1;
    variable selected_num_cols          : natural range 0 to max_num_cols   := 1;
    variable selected_block_size        : natural range 0 to max_block_size := 1;
    variable max_wcount                 : natural;
    variable max_rcount                 : natural;
    variable selected_row_pv_offset     : natural range 0 to max_total_row_permute_vals;
    variable selected_col_pv_offset     : natural range 0 to max_total_col_permute_vals;
    variable all_valid                  : std_logic;
    variable rdy_old                    : std_logic;
    variable all_valid_rfd              : std_logic;  --all_valid, delayed by xvalid_buffer_length
    variable abort_rfd                  : std_logic;
    variable rfd_valid                  : std_logic;
    variable sram_raddr_int_d           : MEM_ADDRESS                       := 0;
    variable sram_waddr_int_d           : MEM_ADDRESS                       := 0;
    variable selected_num_rows_rdy      : natural range 0 to max_num_rows   := 1;
    variable selected_num_cols_rdy      : natural range 0 to max_num_cols   := 1;
    variable selected_block_size_rdy    : natural range 0 to max_block_size := 1;
    variable max_wcount_rdy             : natural;
    variable max_rcount_rdy             : natural;
    variable selected_row_pv_offset_rdy : natural range 0 to max_total_row_permute_vals;
    variable selected_col_pv_offset_rdy : natural range 0 to max_total_col_permute_vals;
    variable all_valid_rdy              : std_logic;
    variable invalid_block_size         : boolean;
    variable smem_dout                  : SID_SYMBOL;

    variable row_nat             : natural range 0 to 2**c_row_width-1;
    variable row_is_valid        : std_logic;
    variable row_sel_nat         : natural range 0 to 2**row_sel_width-1;
    variable row_sel_is_valid    : std_logic;
    variable col_nat             : natural range 0 to 2**c_col_width-1;
    variable col_is_valid        : std_logic;
    variable col_sel_nat         : natural range 0 to 2**col_sel_width-1;
    variable col_sel_is_valid    : std_logic;
    variable block_size_nat      : natural range 0 to 2**c_block_size_width-1;
    variable block_size_is_valid : std_logic := '1';




    procedure init_vars is
    begin
      fsm_state_rdy := IDLE;
      fsm_state_rfd := IDLE;
      rffd_int      <= '1';
      rfd_int       <= '1';
      rfd_wcount    := 0;
      rfd_rcount    := 0;
      rfd_read      := '0';
      rfd_write     := '0';

      selected_num_rows       := max_num_rows;
      selected_num_cols       := max_num_cols;
      selected_block_size     := max_block_size;
      max_wcount              := selected_block_size-1;
      max_rcount              := selected_block_size-1;
      selected_row_pv_offset  := 0;
      selected_col_pv_offset  := 0;
      rdy_old                 := '0';
      all_valid               := '1';
      all_valid_rfd           := '1';
      abort_rfd               := '0';
      rfd_valid               := '1';
      row_nat                 := 0;
      row_sel_nat             := 0;
      col_nat                 := 0;
      col_sel_nat             := 0;
      block_size_nat          := 0;
      rdy_buffer              := (others => '0');
      rdy_int                 <= '0';
      row_is_valid            := '1';
      row_valid_int           <= '1';
      row_sel_is_valid        := '1';
      row_sel_valid_int       <= '1';
      block_size_valid_buffer := (others => '1');
      row_valid_buffer        := (others => '1');
      row_sel_valid_buffer    := (others => '1');
      col_valid_buffer        := (others => '1');
      col_sel_valid_buffer    := (others => '1');
      v_fd_buffer             := (others => '0');
      all_valid_buffer        := (others => '1');
      col_is_valid            := '1';
      col_valid_int           <= '1';
      col_sel_is_valid        := '1';
      col_sel_valid_int       <= '1';

      block_size_is_valid  := '1';
      block_size_valid_int <= '1';
      block_start_int      <= '0';
      block_end_int        <= '0';

      write_done       := '0';
      read_done        := '0';
      smem_block_end   := '0';
      rdy_set          := '0';
      rdy_clr          := '0';
      rdy_abort        := '0';
      rdy_set_buffer   := (others => '0');
      rdy_clr_buffer   := (others => '0');
      rdy_abort_buffer := (others => '0');
      rdy_valid_buffer := (others => '1');
      block_end_buffer := (others => '0');

      selected_num_rows_rdy      := selected_num_rows;
      selected_num_cols_rdy      := selected_num_cols;
      selected_block_size_rdy    := selected_block_size;
      all_valid_rdy              := '1';
      max_wcount_rdy             := max_wcount;
      max_rcount_rdy             := max_rcount;
      selected_row_pv_offset_rdy := selected_row_pv_offset;
      selected_col_pv_offset_rdy := selected_col_pv_offset;


    end init_vars;


    procedure load_sel_params is
    begin
      all_valid := '1';
      -- all_valid will go false if any one of the required input values is
      -- out of range.
      -- Note: is_x is in std_logic_1164. Returns TRUE if value is U|X|Z|W|-.
      -- This is required to cater for the case where the input is indeterminate.
      -- In which case all_valid must also go indeterminate.

      rfd_valid := '1';
      -- rfd_valid will go false if the conditions for rfd and rffd 
      -- being determinate are met.

      case c_row_type is
        when c_constant =>
          selected_num_rows := c_row_constant;
          row_valid_int     <= 'X';     --Not relevant. Don't care.
        when c_variable =>
          if is_x(row) then
            all_valid    := 'X';
            row_is_valid := 'X';
          else
            row_nat := std_logic_vector_to_natural(row);
            if row_nat < c_min_num_rows then
              all_valid    := '0';
              row_is_valid := '0';
            else
              row_is_valid := '1';
            end if;
            selected_num_rows := row_nat;
          end if;
        when c_selectable =>
          if is_x(row_sel) then
            all_valid        := 'X';
            row_sel_is_valid := 'X';
          else
            row_sel_nat := std_logic_vector_to_natural(row_sel);
            if row_sel_nat > c_num_selectable_rows-1 then
              row_sel_is_valid  := '0';
              all_valid         := '0';
              --If not valid, default to row_select_vector(0)
              selected_num_rows := row_select_vector(0);
            else
              row_sel_is_valid  := '1';
              selected_num_rows := row_select_vector(row_sel_nat);
              if c_use_row_permute_file = 1 then
                selected_row_pv_offset := row_permute_offset_vector(row_sel_nat);
              end if;
            end if;
          end if;
        when others => null;
      end case;

      case c_col_type is
        when c_constant =>
          selected_num_cols := c_col_constant;
          col_valid_int     <= 'X';     --Not relevant. Don't care.
        when c_variable =>
          if is_x(col) then
            all_valid    := 'X';
            col_is_valid := 'X';
          else
            col_nat := std_logic_vector_to_natural(col);
            if col_nat < c_min_num_cols then
              all_valid    := '0';
              col_is_valid := '0';
            else
              col_is_valid := '1';
            end if;
            selected_num_cols := col_nat;
          end if;
        when c_selectable =>
          if is_x(col_sel) then
            all_valid        := 'X';
            col_sel_is_valid := 'X';
          else
            col_sel_nat := std_logic_vector_to_natural(col_sel);
            if col_sel_nat > c_num_selectable_cols-1 then
              col_sel_is_valid  := '0';
              all_valid         := '0';
              --If not valid, default to col_select_vector(0)
              selected_num_cols := col_select_vector(0);
            else
              col_sel_is_valid  := '1';
              selected_num_cols := col_select_vector(col_sel_nat);
              if c_use_col_permute_file = 1 then
                selected_col_pv_offset := col_permute_offset_vector(col_sel_nat);
              end if;
            end if;
          end if;
        when others => null;
      end case;


      invalid_block_size  := false;
      block_size_is_valid := '1';
      rfd_valid           := all_valid;

      case c_block_size_type is
        when c_constant =>
          selected_block_size := c_block_size_constant;
        when c_row_x_col =>
          selected_block_size := selected_num_rows * selected_num_cols;
          if selected_block_size < 6 then
            selected_block_size := 6;
            rfd_valid           := '0';
            invalid_block_size  := true;
          end if;

        when c_variable =>
          block_size_nat      := std_logic_vector_to_natural(block_size);
          selected_block_size := block_size_nat;
          --This IF - END IF block checks if the selected block size would
          --result in unused rows(interleaver) or cols(deinterleaver)
          if block_size_nat < (selected_num_rows-1)*selected_num_cols+1 then
            if max_block_size > (selected_num_rows-1)*selected_num_cols+1 then
              selected_block_size := (selected_num_rows-1)*selected_num_cols+1;
            else
              selected_block_size := max_block_size;
            end if;
            invalid_block_size := true;
            rfd_valid          := '0';
          end if;
          -------------------------------------------------------------------

          if block_size_nat > selected_num_rows * selected_num_cols then
            if max_block_size > selected_num_rows*selected_num_cols then
              selected_block_size := selected_num_rows*selected_num_cols;
            else
              selected_block_size := max_block_size;
            end if;
            invalid_block_size := true;
            rfd_valid          := '0';
          end if;

          if selected_block_size < 6 then
            selected_block_size := 6;
            invalid_block_size  := true;
            rfd_valid           := '0';
          end if;

        when others => null;

      end case;

      --If either the row or col is invalid, then the
      --state of block_size_valid will be indeterminate
      if all_valid /= '1' then
        block_size_is_valid := 'X';
      else
        if invalid_block_size then
          block_size_is_valid := '0';
          all_valid           := '0';
        else
          block_size_is_valid := '1';
        end if;
      end if;

      --constrain to be at least the minimum allowed.
      if selected_num_rows < abs_min_num_rows then
        selected_num_rows := abs_min_num_rows;
      end if;

      --constrain to be at least the minimum allowed.
      if selected_num_cols < abs_min_num_cols then
        selected_num_cols := abs_min_num_cols;
      end if;

      --limit the selected block_size to selected_num_rows * selected_num_cols
      --so as not to exceed the range of row_pv when not valid
      if selected_block_size > selected_num_rows * selected_num_cols then
        selected_block_size := selected_num_rows * selected_num_cols;
      end if;

      max_wcount := selected_block_size-1;
      max_rcount := selected_block_size-1;

    end load_sel_params;


    procedure load_sel_params_rdy is
    begin
      selected_num_rows_rdy   := selected_num_rows;
      selected_num_cols_rdy   := selected_num_cols;
      selected_block_size_rdy := selected_block_size;
      all_valid_rdy           := all_valid;

      if c_mode = c_interleaver then
        max_wcount_rdy := selected_block_size_rdy-1;
        max_rcount_rdy := selected_num_rows_rdy * selected_num_cols_rdy-1;
      else
        max_wcount_rdy := selected_num_rows_rdy * selected_num_cols_rdy-1;
        max_rcount_rdy := selected_block_size_rdy-1;
      end if;

      if all_valid_rdy = '1' then
        selected_row_pv_offset_rdy := selected_row_pv_offset;
        selected_col_pv_offset_rdy := selected_col_pv_offset;
        col_length_vector(0 to selected_num_cols_rdy-1) := calc_col_length_vector(
          selected_num_rows_rdy, selected_num_cols_rdy,
          selected_block_size_rdy);
      else
        selected_row_pv_offset_rdy := 0;
        selected_col_pv_offset_rdy := 0;
        col_length_vector          := (others => selected_num_rows_rdy);
      end if;


    end load_sel_params_rdy;


    procedure row_permute(a : in natural; pa : out natural) is
    begin
      if c_use_row_permute_file /= 0 then
        pa := total_row_permute_vector(a+selected_row_pv_offset_rdy);  --Apply permutation
      else
        pa := a;                        -- no permutation
      end if;
    end row_permute;

    procedure col_permute(a : in natural; pa : out natural) is
    begin
      if c_use_col_permute_file /= 0 then
        pa := total_col_permute_vector(a+selected_col_pv_offset_rdy);  --Apply permutation
      else
        pa := a;                        -- no permutation
      end if;
    end col_permute;


    procedure clear_wcount is
    begin
      wri        := 0;
      wci        := 0;
      wcount     := 0;
      smem_waddr := 0;
    end clear_wcount;


    procedure clear_rcount is
    begin
      rri    := 0;
      rci    := 0;
      rcount := 0;
      if c_mode = c_interleaver then
        row_permute(rri, p_rri);        --Apply row permutation
        col_permute(rci, p_rci);        --Apply col permutation
        smem_raddr := p_rri*selected_num_cols_rdy + p_rci;
      else
        if not pruned then
          col_permute(rri, p_rri);      --Apply col permutation
          row_permute(rci, p_rci);      --Apply row permutation
          smem_raddr := p_rri*selected_num_rows_rdy + p_rci;
        else
          smem_raddr := 0;
        end if;
      end if;
    end clear_rcount;


    procedure next_waddr is
    begin
      if wcount = selected_block_size_rdy-1 then
        clear_wcount;
        clear_rcount;
        fsm_state_rdy := READING_0;  --TBD this statement should be part of the fsm
        if all_valid_rdy = '1' then  --TBD this statement should be part of the fsm
          write_done := '1';  --only if all valid  --TBD this statement should be part of the fsm
        end if;
      elsif nd_rdy = '1' then
        wcount := wcount + 1;
      end if;
      smem_waddr := wcount;
    end next_waddr;


    procedure next_rcount is
    begin
      if rcount = selected_block_size_rdy-1 then
        clear_rcount;
        fsm_state_rdy  := IDLE;  --TBD this statement should be part of the fsm
        read_done      := '1';   --TBD this statement should be part of the fsm
        smem_block_end := '1';   --TBD this statement should be part of the fsm
      else
        if c_mode = c_interleaver then
          --read col-wise with pruning by column-length vector.
          --Apply permutation.
          if rri = col_length_vector(rci)-1 then
            rci := rci + 1;
            rri := 0;
          else
            rri := rri + 1;
          end if;
          row_permute(rri, p_rri);      --Apply row permutation
          col_permute(rci, p_rci);      --Apply col permutation
          smem_raddr := p_rri*selected_num_cols_rdy + p_rci;
        else
          --For deinterleaver,
          --read col-wise. With permutation. Only works if not pruned!
          if not pruned then
            if rri = selected_num_cols_rdy-1 then
              rci := rci + 1;
              rri := 0;
            else
              rri := rri + 1;
            end if;
            col_permute(rri, p_rri);    --Apply col permutation
            row_permute(rci, p_rci);    --Apply row permutation
            smem_raddr := p_rri*selected_num_rows_rdy + p_rci;
          else
            if rri = selected_num_cols_rdy-1 then
              rci        := rci + 1;
              rri        := 0;
              smem_raddr := rci;
            else
              smem_raddr := smem_raddr + col_length_vector(rri);
              rri        := rri + 1;
            end if;
          end if;
        end if;
        rcount := rcount + 1;
      end if;
    end next_rcount;


  begin

    if power /= '1' then
      init_vars;
      wr_en_int    <= '0';
      wr_en_buffer := (others => '0');
      wr_en_int    <= '0';
      rd_en_buffer := (others => '0');
      rd_en_int    <= '0';

    elsif clk'event and clk = '1' then
      if ce_int = '1' then
        if sclr_int = '1' then
          init_vars;
          
        else

          rdy_old := rdy_int;

          --Handle rfd and rffd.
          --Following a valid fd,
          --rffd goes to '1' after 'block-size' samples,
          --plus 'block-size' clocks.


          case fsm_state_rfd is
            when IDLE =>
              abort_rfd := '0';
            when IDLE_1 =>
              abort_rfd := v_fd_b;
            when WRITING =>
              abort_rfd := v_fd_b;
              if rfd_wcount = max_wcount-1 and nd_int = '1' then
                --the sample now on din will be the last,
                --after which, we are no longer ready for data
                rfd_int <= '0';
              end if;
              if rfd_wcount = max_wcount then
                --no need for nd, because last sample has now been written
                rfd_wcount    := 0;
                rfd_rcount    := 0;
                fsm_state_rfd := READING;
              elsif nd_int = '1' then
                rfd_wcount := rfd_wcount+1;
              end if;
              
            when READING =>
              abort_rfd := v_fd_b;
              if rfd_rcount = (selected_block_size-1)-1 then
                --the next value now on dout will be the last,
                --so we are ready for new data
                rfd_int  <= '1';
                rffd_int <= '1';
              end if;
              if rfd_rcount = (selected_block_size-1) then
                rfd_rcount    := 0;
                fsm_state_rfd := IDLE;
                abort_rfd     := '0';   --if here, a v_fd_b is not an abort
              else
                rfd_rcount := rfd_rcount + 1;
              end if;

            when others => null;
          end case;

          -- x_valid indicates when row_valid, col_valid, row_sel_valid, col_sel_valid
          --and block_size_valid are asserted. 

          --if something is invalid, assert rffd and rfd after rffd delay
          --one clock after all_valid_rfd is deasserted.
          if all_valid_rfd = '0' then
            if (c_has_row_valid = 1 and row_valid_int = '0') or
              (c_has_col_valid = 1 and col_valid_int = '0') or
              (c_has_row_sel_valid = 1 and row_sel_valid_int = '0') or
              (c_has_col_sel_valid = 1 and col_sel_valid_int = '0') or
              (c_has_block_size_valid = 1 and block_size_valid_int = '0') then
              rffd_int <= '1';
              rfd_int  <= '1';
            else  --if here, something is invalid, for which there is 
              -- no *valid pin, so rffd and rfd are undefined.
              rffd_int <= 'X';
              rfd_int  <= 'X';
            end if;
            fsm_state_rfd := IDLE_1;
          end if;

          --block_size_valid is updated a few clock cycles after the latest v_fd_b
          if v_fd_buffer(xvalid_buffer_length-1) = '1' then
            block_size_valid_int <= block_size_valid_buffer(xvalid_buffer_length-1);
          end if;
          for n in xvalid_buffer_length-1 downto 0 loop
            v_fd_buffer(n+1) := v_fd_buffer(n);
          end loop;
          if abort_b /= '0' then        --i.e if 0 or X
            block_size_valid_buffer := (others => 'X');
            block_size_valid_int    <= 'X';
          end if;

          if v_fd_b = '1' then
            load_sel_params;
            all_valid_buffer := (others => '1');
            rffd_int         <= '0';
            rfd_wcount       := 0;
            rfd_rcount       := 0;
            if all_valid /= '1' then
              fsm_state_rfd := IDLE_1;
              rfd_int       <= 'X';
            else
              fsm_state_rfd := WRITING;
              rfd_int       <= '1';
            end if;
          end if;

          v_fd_buffer(0) := v_fd_b;


          if rfd_valid = '0' and v_fd_b /= '1' then
            --The conditions for rffd and rfd being determinate are not
            --met.
            --Note that rffd=0 and rfd=1 always immediately after valid fd
            rffd_int <= 'X';
            rfd_int  <= 'X';
          end if;


          all_valid_rfd := all_valid_buffer(xvalid_buffer_length-1);
          for n in xvalid_buffer_length-1 downto 0 loop
            all_valid_buffer(n+1) := all_valid_buffer(n);
          end loop;
          all_valid_buffer(0) := all_valid;


          --Shift the xvalid FIFO.
          row_valid_int     <= row_valid_buffer(xvalid_buffer_length-1);
          row_sel_valid_int <= row_sel_valid_buffer(xvalid_buffer_length-1);
          col_valid_int     <= col_valid_buffer(xvalid_buffer_length-1);
          col_sel_valid_int <= col_sel_valid_buffer(xvalid_buffer_length-1);
          for n in xvalid_buffer_length-1 downto 0 loop
            block_size_valid_buffer(n+1) := block_size_valid_buffer(n);
            row_valid_buffer(n+1)        := row_valid_buffer(n);
            row_sel_valid_buffer(n+1)    := row_sel_valid_buffer(n);
            col_valid_buffer(n+1)        := col_valid_buffer(n);
            col_sel_valid_buffer(n+1)    := col_sel_valid_buffer(n);
          end loop;
          block_size_valid_buffer(0) := block_size_is_valid;
          row_valid_buffer(0)        := row_is_valid;
          row_sel_valid_buffer(0)    := row_sel_is_valid;
          col_valid_buffer(0)        := col_is_valid;
          col_sel_valid_buffer(0)    := col_sel_is_valid;




          smem_dout := smem(smem_raddr);

          v_fd_rdy := v_fd_0;
          nd_rdy   := nd_0;

          if fsm_state_rdy = IDLE then
            read_done      := '0';
            smem_block_end := '0';
            if v_fd_rdy = '1' then
              load_sel_params_rdy;
              clear_wcount;
              clear_rcount;
              fsm_state_rdy := WRITING;
            end if;

          elsif fsm_state_rdy = START then
            read_done      := '0';
            smem_block_end := '0';

            if symbol_mem_style = c_distmem then
              --read before write
              smem_dout        := smem(smem_waddr);
              smem(smem_waddr) := din_del;
            else
              --write before read
              smem_dout        := din_del;
              smem(smem_waddr) := din_del;
            end if;

            if v_fd_rdy = '1' then
              load_sel_params_rdy;
              clear_wcount;
              fsm_state_rdy := WRITING;
            else
              --update the write address
              next_waddr;
              if nd_rdy = '1' then  --nothing happens unless nd_rdy is asserted
                fsm_state_rdy := WRITING;
              end if;  --nd_rdy 
            end if;

          elsif fsm_state_rdy = WRITING then
            read_done      := '0';
            smem_block_end := '0';

            if symbol_mem_style = c_distmem then
              --read before write
              smem_dout        := smem(smem_waddr);
              smem(smem_waddr) := din_del;
            else
              --write before read
              smem_dout        := din_del;
              smem(smem_waddr) := din_del;
            end if;

            if v_fd_rdy = '1' then
              load_sel_params_rdy;
              write_done    := '0';
              clear_wcount;
              fsm_state_rdy := WRITING;
            else
              next_waddr;
            end if;


          elsif fsm_state_rdy = READING_0 then
            write_done := '0';
            if v_fd_rdy = '1' then
              load_sel_params_rdy;
              clear_wcount;
              clear_rcount;
              read_done     := '1';
              fsm_state_rdy := START;
            else
              next_rcount;
              fsm_state_rdy := READING_1;
            end if;

          elsif fsm_state_rdy = READING_1 then
            if v_fd_rdy = '1' then
              next_rcount;
              if rcount = 0 then
                load_sel_params_rdy;
                clear_wcount;
                clear_rcount;
                fsm_state_rdy := WRITING;
              else
                load_sel_params_rdy;
                clear_wcount;
                clear_rcount;
                fsm_state_rdy := START;
              end if;
              read_done := '1';
            else
              next_rcount;
            end if;

          end if;  --fsm_state_rdy   

          if v_fd_rdy = '1' then
            rdy_abort_buffer := (others => '0');
          end if;

          if write_done = '1' then
            rdy_set_buffer := (others => '0');
          end if;

          if read_done = '1' then
            rdy_clr_buffer := (others => '0');
          end if;

          rdy_abort := rdy_abort_buffer(output_buffer_length-1);
          rdy_valid := rdy_valid_buffer(output_buffer_length-1);
          rdy_set   := rdy_set_buffer(output_buffer_length-1);
          rdy_clr   := rdy_clr_buffer(output_buffer_length-1);
          for n in output_buffer_length-1 downto 0 loop
            rdy_set_buffer(n+1)   := rdy_set_buffer(n);
            rdy_clr_buffer(n+1)   := rdy_clr_buffer(n);
            rdy_abort_buffer(n+1) := rdy_abort_buffer(n);
            rdy_valid_buffer(n+1) := rdy_valid_buffer(n);
            block_end_buffer(n+1) := block_end_buffer(n);
          end loop;
          rdy_set_buffer(0)   := write_done;
          rdy_clr_buffer(0)   := read_done;
          block_end_buffer(0) := smem_block_end;
          rdy_abort_buffer(0) := v_fd_rdy;
          rdy_valid_buffer(0) := all_valid_rdy;

          if rdy_valid /= '1' then
            rdy_int         <= 'X';
            block_end_int   <= 'X';
            block_start_int <= 'X';
          else
            if rdy_abort = '1' then
              rdy_int          <= '0';
              block_end_buffer := (others => '0');
            elsif rdy_set = '1' then
              rdy_int <= '1';
            elsif rdy_clr = '1' then
              rdy_int <= '0';
            end if;
            block_end_int   <= block_end_buffer(output_buffer_length-1);
            block_start_int <= rdy_set;
          end if;



          --Shift the output FIFO.
          dout_buffer(0) := smem_dout;
          dout_int       <= dout_buffer(output_buffer_length-1);
          for n in output_buffer_length-1 downto 0 loop
            dout_buffer(n+1) := dout_buffer(n);
          end loop;


        end if;  --sclr   

        if c_external_ram /= 0 then

          --Shift the input FIFO.
          wr_data_int <= din_buffer(input_buffer_length-1);
          for n in input_buffer_length-1 downto 0 loop
            din_buffer(n+1) := din_buffer(n);
          end loop;
          if nd_int = '1' then
            if all_valid = '1' then
              din_buffer(0) := din;
            else
              --if here, deliberately write garbage into the ram
              --to highlight an invalid block;
              din_buffer(0) := (others => '1');
            end if;
          end if;

          for n in addr_buffer_length-1 downto 0 loop
            sram_raddr_buffer(n+1) := sram_raddr_buffer(n);
          end loop;
          sram_raddr_buffer(0) := smem_raddr;
          sram_raddr_int       <= integer_to_std_logic_vector(sram_raddr_int_d, c_ext_addr_width);
          sram_raddr_int_d     := sram_raddr_buffer(addr_buffer_length-1);

          for n in addr_buffer_length-1 downto 0 loop
            sram_waddr_buffer(n+1) := sram_waddr_buffer(n);
          end loop;
          sram_waddr_buffer(0) := smem_waddr;
          sram_waddr_int       <= integer_to_std_logic_vector(sram_waddr_int_d, c_ext_addr_width);
          sram_waddr_int_d     := sram_waddr_buffer(addr_buffer_length-1);


          for n in wr_en_buffer_length-1 downto 0 loop
            wr_en_buffer(n+1) := wr_en_buffer(n);
          end loop;
          -- If something is invalid, the timing of 
          -- wr_en is indeterminate.
          if all_valid_rdy /= '1' then
            wr_en_buffer(0) := 'X';
          elsif (fsm_state_rdy = WRITING) or (fsm_state_rdy = START) then
            wr_en_buffer(0) := '1';
          else
            wr_en_buffer(0) := '0';
          end if;

          wr_en_int <= wr_en_buffer(wr_en_buffer_length-1);

          for n in rd_en_buffer_length-1 downto 0 loop
            rd_en_buffer(n+1) := rd_en_buffer(n);
          end loop;
          -- If something is invalid, the timing of 
          -- rd_en is indeterminate.
          if all_valid_rdy /= '1' then
            rd_en_buffer(0) := 'X';
          elsif (fsm_state_rdy = READING_0) or (fsm_state_rdy = READING_1) then
            rd_en_buffer(0) := '1';
          else
            rd_en_buffer(0) := '0';
          end if;
          rd_en_int <= rd_en_buffer(rd_en_buffer_length-1);

        end if;

        -- If abort during read, and
        -- something is invalid, the timing of 
        -- rd_en, rdy, block_start and block_end is indeterminate.
        -- No alternative but to make them all X.
        if (all_valid_rdy /= '1'
            and v_fd_b = '1'
            and v_fd_0 = '0'
            and v_fd_rdy = '0'
            and rdy_old /= '0') then
          rd_en_int        <= 'X';
          rd_en_buffer     := (others => 'X');
          rdy_int          <= 'X';
          rdy_set          := 'X';
          rdy_clr          := 'X';
          rdy_set_buffer   := (others => 'X');
          rdy_clr_buffer   := (others => 'X');
          block_end_buffer := (others => 'X');
          block_start_int  <= 'X';
          block_end_int    <= 'X';
        end if;

      else
        --This statement is needed because the write enable to distributed memory
        --is not gated with ce_int. The contents of the current address will
        --change even if ce_int is '0'.
        if (fsm_state_rdy = WRITING) or (fsm_state_rdy = START) then
          smem(smem_waddr) := din_del;
        end if;

      end if;  --ce_int   

    end if;  -- clk

  end process;

end behavioral;



---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
--                                                                          ---*
--        TOP LEVEL ENTITY FOR FORNEY INTERLEAVER / DEINTERLEAVER           ---*
--                                                                          ---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*

library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.sid_const_pkg_behav_v6_0.all;
use xilinxcorelib.sid_pkg_behav_v6_0.all;


--core_if on entity sid_v6_0
  entity sid_v6_0 is
    generic (
      c_xdevicefamily          : string  := "DEFAULT_FAMILY"  ;  --  specifies target Xilinx FPGA family
      c_family                 : string  := "DEFAULT_FAMILY";
      c_architecture           : integer := 0;
      c_mem_init_prefix        : string  := "sid1";
      c_elaboration_dir        : string  := "./";
      c_type                   : integer := 0;
      c_mode                   : integer := 0;
      c_symbol_width           : integer := 1;
      c_row_type               : integer := 0;
      c_row_constant           : integer := 16;
      c_has_row                : integer := 0;
      c_has_row_valid          : integer := 0;
      c_min_num_rows           : integer := 2;
      c_row_width              : integer := 4;
      c_num_selectable_rows    : integer := 4;
      c_row_select_file        : string  := "null.mif";
      c_has_row_sel            : integer := 0;
      c_has_row_sel_valid      : integer := 0;
      c_use_row_permute_file   : integer := 0;
      c_row_permute_file       : string  := "null.mif";
      c_col_type               : integer := 0;
      c_col_constant           : integer := 16;
      c_has_col                : integer := 0;
      c_has_col_valid          : integer := 0;
      c_min_num_cols           : integer := 2;
      c_col_width              : integer := 4;
      c_num_selectable_cols    : integer := 4;
      c_col_select_file        : string  := "null.mif";
      c_has_col_sel            : integer := 0;
      c_has_col_sel_valid      : integer := 0;
      c_use_col_permute_file   : integer := 0;
      c_col_permute_file       : string  := "null.mif";
      c_block_size_type        : integer := 0;
      c_block_size_constant    : integer := 256;
      c_has_block_size         : integer := 0;
      c_block_size_width       : integer := 8;
      c_has_block_size_valid   : integer := 0;
      c_num_branches           : integer := 16;
      c_branch_length_type     : integer := 0;
      c_branch_length_constant : integer := 1;
      c_branch_length_file     : string  := "null.mif";
      c_num_configurations     : integer := 1;
      c_external_ram           : integer := 0;
      c_ext_addr_width         : integer := 700;
      c_memstyle               : integer := 0;
      c_pipe_level             : integer := 0;
      c_throughput_mode        : integer := 0;
      c_has_ce                 : integer := 0;
      c_has_nd                 : integer := 1;
      c_has_sclr               : integer := 0;
      c_has_rdy                : integer := 0;
      c_has_rfd                : integer := 0;
      c_has_rffd               : integer := 0;
      c_has_block_start        : integer := 0;
      c_has_block_end          : integer := 0;
      c_has_fdo                : integer := 0;
      c_has_ndo                : integer := 0
      );
    port (
      clk              : in  std_logic;
      fd               : in  std_logic;
      din              : in  std_logic_vector(c_symbol_width-1 downto 0);
      nd               : in  std_logic                                                                                                                    := '1';
      ce               : in  std_logic                                                                                                                    := '1';
      sclr             : in  std_logic                                                                                                                    := '0';
      row              : in  std_logic_vector(c_row_width-1 downto 0)                                                                                     := (others => '0');
      row_sel          : in  std_logic_vector((bits_needed_to_represent(c_num_selectable_rows-1) -1) downto 0)                                            := (others => '0');
      col              : in  std_logic_vector((c_col_width - 1) downto 0)                                                                                 := (others => '0');
      col_sel          : in  std_logic_vector((bits_needed_to_represent(c_num_selectable_cols-1) -1) downto 0)                                            := (others => '0');
      block_size       : in  std_logic_vector((c_block_size_width-1) downto 0)                                                                            := (others => '0');
      config_sel       : in  std_logic_vector(select_integer(bits_needed_to_represent(c_num_configurations-1), 1, c_num_configurations <= 1) -1 downto 0) := (others => '0');
      new_config       : in  std_logic                                                                                                                    := '0';
      rd_data          : in  std_logic_vector(c_symbol_width-1 downto 0)                                                                                  := (others => '0');  -- Read data from external RAM
      dout             : out std_logic_vector(c_symbol_width-1 downto 0);
      rd_en            : out std_logic;
      wr_en            : out std_logic;
      rd_addr          : out std_logic_vector(c_ext_addr_width-1 downto 0);
      wr_addr          : out std_logic_vector(c_ext_addr_width-1 downto 0);
      wr_data          : out std_logic_vector(c_symbol_width-1 downto 0);                                                                                                      -- Write data to external RAM
      rfd              : out std_logic;
      rdy              : out std_logic;
      rffd             : out std_logic;
      row_valid        : out std_logic;
      col_valid        : out std_logic;
      row_sel_valid    : out std_logic;
      col_sel_valid    : out std_logic;
      block_size_valid : out std_logic;
      block_start      : out std_logic;
      block_end        : out std_logic;
      fdo              : out std_logic;
      ndo              : out std_logic
      );
--core_if off
end sid_v6_0;

architecture behavioral of sid_v6_0 is

--Components
  component sid_bhv_forney_v6_0
    generic (
      c_mode                   : integer;
      c_symbol_width           : integer;
      -- Forney specific generics
      c_num_branches           : integer;
      c_branch_length_type     : integer;
      c_branch_length_constant : integer;
      c_branch_length_file     : string := "";
      c_has_fdo                : integer;
      c_has_ndo                : integer;
      -- Implementation generics
      c_pipe_level             : integer;
      -- Optional pin generics
      c_has_ce                 : integer;
      c_has_sclr               : integer;
      c_has_rdy                : integer;
      c_has_rffd               : integer;
      c_has_rfd                : integer;
      --New generics for v4_0
      c_external_ram           : integer;
      c_ext_addr_width         : integer;
      c_num_configurations     : integer);
    port (
      -- Mandatory pins
      clk        : in  std_logic;
      fd         : in  std_logic;
      nd         : in  std_logic;
      din        : in  std_logic_vector(c_symbol_width-1 downto 0);
      -- Optional input pins
      ce         : in  std_logic;
      sclr       : in  std_logic;
      -- Mandatory output pins
      dout       : out std_logic_vector(c_symbol_width-1 downto 0);
      -- optional output pins
      rdy        : out std_logic;
      rffd       : out std_logic;
      rfd        : out std_logic;
      fdo        : out std_logic;
      ndo        : out std_logic;
      --New ports for v4_0
      new_config : in  std_logic;
      config_sel : in  std_logic_vector(
        select_val(
          bits_needed_to_represent(c_num_configurations-1),
          1, c_num_configurations <= 1) -1 downto 0);
      rd_data    : in  std_logic_vector(c_symbol_width-1 downto 0);  -- Read data from external RAM
      rd_en      : out std_logic;
      wr_en      : out std_logic;
      rd_addr    : out std_logic_vector(c_ext_addr_width-1 downto 0);
      wr_addr    : out std_logic_vector(c_ext_addr_width-1 downto 0);
      wr_data    : out std_logic_vector(c_symbol_width-1 downto 0));  -- Write data to external RAM
  end component;

  component sid_bhv_rectangular_block_v6_0
    generic (
      c_family               : string;
      c_mode                 : integer;
      c_symbol_width         : integer;
      -- Row specific generics
      c_row_type             : integer;
      c_row_constant         : integer;
      c_has_row              : integer;
      c_has_row_valid        : integer;
      c_min_num_rows         : integer;
      c_row_width            : integer;
      c_num_selectable_rows  : integer;
      c_row_select_file      : string := "";
      c_has_row_sel          : integer;
      c_has_row_sel_valid    : integer;
      c_use_row_permute_file : integer;
      c_row_permute_file     : string := "";
      -- Column specific generics
      c_col_type             : integer;
      c_col_constant         : integer;
      c_has_col              : integer;
      c_has_col_valid        : integer;
      c_min_num_cols         : integer;
      c_col_width            : integer;
      c_num_selectable_cols  : integer;
      c_col_select_file      : string := "";
      c_has_col_sel          : integer;
      c_has_col_sel_valid    : integer;
      c_use_col_permute_file : integer;
      c_col_permute_file     : string := "";
      -- Block size specific generics
      c_block_size_type      : integer;
      c_block_size_constant  : integer;
      c_has_block_size       : integer;
      c_block_size_width     : integer;
      c_has_block_size_valid : integer;
      -- Implementation generics
      c_memstyle             : integer;
      c_pipe_level           : integer;
      -- Optional pin generics
      c_has_ce               : integer;
      c_has_nd               : integer;
      c_has_sclr             : integer;
      c_has_rdy              : integer;
      c_has_rffd             : integer;
      c_has_rfd              : integer;
      c_has_block_start      : integer;
      c_has_block_end        : integer;
      --New for generics v4_0
      c_architecture         : integer;
      c_external_ram         : integer;
      c_ext_addr_width       : integer);
    port (
      -- Mandatory pins
      clk              : in  std_logic;
      fd               : in  std_logic;
      din              : in  std_logic_vector(c_symbol_width-1 downto 0);
      -- Optional input pins
      ce               : in  std_logic;
      nd               : in  std_logic;
      sclr             : in  std_logic;
      row              : in  std_logic_vector(c_row_width-1 downto 0);
      row_sel          : in  std_logic_vector(
        bits_needed_to_represent(c_num_selectable_rows-1) - 1 downto 0);
      col              : in  std_logic_vector(c_col_width-1 downto 0);
      col_sel          : in  std_logic_vector(
        bits_needed_to_represent(c_num_selectable_cols-1) - 1 downto 0);
      block_size       : in  std_logic_vector(c_block_size_width-1 downto 0);
      -- Mandatory output pins
      dout             : out std_logic_vector(c_symbol_width-1 downto 0);
      -- optional output pins
      rfd              : out std_logic;
      rdy              : out std_logic;
      rffd             : out std_logic;
      row_valid        : out std_logic;
      col_valid        : out std_logic;
      row_sel_valid    : out std_logic;
      col_sel_valid    : out std_logic;
      block_size_valid : out std_logic;
      block_start      : out std_logic;
      block_end        : out std_logic;
      --New ports for v4_0
      rd_data          : in  std_logic_vector(c_symbol_width-1 downto 0);  -- Read data from external RAM
      rd_en            : out std_logic;
      wr_en            : out std_logic;
      rd_addr          : out std_logic_vector(c_ext_addr_width-1 downto 0);
      wr_addr          : out std_logic_vector(c_ext_addr_width-1 downto 0);
      wr_data          : out std_logic_vector(c_symbol_width-1 downto 0));  -- Write data to external RAM
  end component;  -- sid_bhv_rectangular_block_v6_0



begin

  -- If c_type is forney, instantiate the forney interleaver/de-interleaver
  -- model

  fi_g : if c_type = c_forney_convolutional generate
    u1 : sid_bhv_forney_v6_0
      generic map (
        c_mode                   => c_mode,
        c_symbol_width           => c_symbol_width,
        -- Forney specific generics
        c_num_branches           => c_num_branches,
        c_branch_length_type     => c_branch_length_type,
        c_branch_length_constant => c_branch_length_constant,
        c_branch_length_file     => c_branch_length_file,
        c_has_fdo                => c_has_fdo,
        c_has_ndo                => c_has_ndo,
        -- Implementation generics
        c_pipe_level             => c_pipe_level,
        -- Optional pin generics  -- Optional pin generic
        c_has_ce                 => c_has_ce,
        c_has_sclr               => c_has_sclr,
        c_has_rdy                => c_has_rdy,
        c_has_rffd               => c_has_rffd,
        c_has_rfd                => c_has_rfd,
        --New generics for v4_0
        c_external_ram           => c_external_ram,
        c_ext_addr_width         => c_ext_addr_width,
        c_num_configurations     => c_num_configurations)
      port map (
        clk        => clk,
        fd         => fd,
        nd         => nd,
        din        => din,
        ce         => ce,
        sclr       => sclr,
        dout       => dout,
        rdy        => rdy,
        rffd       => rffd,
        rfd        => rfd,
        fdo        => fdo,
        ndo        => ndo,
        --New ports for v4_0
        new_config => new_config,
        config_sel => config_sel,       --INPUT
        rd_data    => rd_data,          --INPUT
        rd_en      => rd_en,
        wr_en      => wr_en,
        rd_addr    => rd_addr,
        wr_addr    => wr_addr,
        wr_data    => wr_data);
  end generate;  --fi_g

  -- If c_type is c_rectangular_block, instantiate a 
  -- block interleaver/de-interleaver model

  rbg : if c_type = c_rectangular_block generate

    -- Rectangular block type
    u1 : sid_bhv_rectangular_block_v6_0
      generic map (
        c_family               => c_family,
        c_mode                 => c_mode,
        c_symbol_width         => c_symbol_width,
        -- Row specific generics
        c_row_type             => c_row_type,
        c_row_constant         => c_row_constant,
        c_has_row              => c_has_row,
        c_has_row_valid        => c_has_row_valid,
        c_min_num_rows         => c_min_num_rows,
        c_row_width            => c_row_width,
        c_num_selectable_rows  => c_num_selectable_rows,
        c_row_select_file      => c_row_select_file,
        c_has_row_sel          => c_has_row_sel,
        c_has_row_sel_valid    => c_has_row_sel_valid,
        c_use_row_permute_file => c_use_row_permute_file,
        c_row_permute_file     => c_row_permute_file,
        -- Column specific generics
        c_col_type             => c_col_type,
        c_col_constant         => c_col_constant,
        c_has_col              => c_has_col,
        c_has_col_valid        => c_has_col_valid,
        c_min_num_cols         => c_min_num_cols,
        c_col_width            => c_col_width,
        c_num_selectable_cols  => c_num_selectable_cols,
        c_col_select_file      => c_col_select_file,
        c_has_col_sel          => c_has_col_sel,
        c_has_col_sel_valid    => c_has_col_sel_valid,
        c_use_col_permute_file => c_use_col_permute_file,
        c_col_permute_file     => c_col_permute_file,
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
        c_has_rdy              => c_has_rdy,
        c_has_rffd             => c_has_rffd,
        c_has_rfd              => c_has_rfd,
        c_has_block_start      => c_has_block_start,
        c_has_block_end        => c_has_block_end,
        --New generics for v4_0
        c_external_ram         => c_external_ram,
        c_ext_addr_width       => c_ext_addr_width,
        c_architecture         => c_architecture)
      port map (
        clk              => clk,
        fd               => fd,
        nd               => nd,
        din              => din,
        ce               => ce,
        sclr             => sclr,
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
        rd_data          => rd_data,    --INPUT
        rd_en            => rd_en,
        wr_en            => wr_en,
        rd_addr          => rd_addr,
        wr_addr          => wr_addr,
        wr_data          => wr_data);
  end generate;  -- rbg

end behavioral;



-----------------------------------------------------------------------------
-- $RCSfile: blkmemdp_pkg_v6_3.vhd,v $
---------------------------------------------------------------------------
--
-- blkmemdp_pkg_v6_3 - VHDL Behavioral Model Function Package
--
-----------------------------------------------------------------------------
--                                                                       
-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
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
-- of this text at all times. (c) Copyright 1995-2004 Xilinx, Inc.
-- All rights reserved.
--
---------------------------------------------------------------------------
--
-- Filename:    blkmemdp_pkg_v6_3.vhd
--
-- Description: A package that contains constants, types and functions
-- used by the Dual Port Block Memory behavior model.
--
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- Package containing functions used in the Dual Port Block Memory Behavior
-- Model
---------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE blkmemdp_pkg_v6_3 IS

----------------------------------------------------------------------------
-- CONSTANT and TYPE DECLARATION
----------------------------------------------------------------------------

--------------- Define the family dependent constants  ---------------------
CONSTANT virtex         : INTEGER       := 1 ;
CONSTANT virtex2        : INTEGER       := 2 ;
CONSTANT v_index 	: INTEGER	:= 6 ;	--# of different port widths
                                                -- includes special single
                                                -- port case

CONSTANT c_sp_ram       : INTEGER       := 1; 

CONSTANT v2_index	: INTEGER	:= 7 ;  --# of different port widths
                                                -- includes special single
                                                -- port case
CONSTANT max_mux_width	: INTEGER	:= 72 ;
CONSTANT max_mux_depth	: INTEGER	:= 64 ;

--------------- Define the family dependent types  -------------------------
TYPE v_array IS ARRAY ((v_index-1) DOWNTO 0) OF INTEGER ;
TYPE v2_array IS ARRAY ((v2_index-1) DOWNTO 0) OF INTEGER ;

------------- Define the memory initalization types  -----------------------
TYPE INITP_ARRAY IS ARRAY (7 DOWNTO 0) OF BIT_VECTOR(255 DOWNTO 0);
TYPE INIT_ARRAY IS ARRAY (63 DOWNTO 0) OF BIT_VECTOR(255 DOWNTO 0);
TYPE MEM_ARRAY IS ARRAY (6 DOWNTO 1) OF STRING(1 TO 6);

----------- Define the family dependent constant arrays  -------------------
CONSTANT v_widths	: v_array	:= (1, 2, 4, 8, 16, 32) ;
CONSTANT v_depths	: v_array	:= (4096, 2048, 1024, 512, 256, 128) ;
CONSTANT v2_widths	: v2_array	:= (1, 2, 4, 9, 18, 36, 72) ;
CONSTANT v2_widths_nop  : v2_array      := (1, 2, 4, 8, 16, 32, 64) ;
CONSTANT v2_depths	: v2_array	:= (16384, 8192, 4096, 2048, 1024, 512, 256) ;

-- Define some constants needed in the sim parameters for the block memory V2

CONSTANT c_write_first    : INTEGER       := 0;
CONSTANT c_read_first     : INTEGER       := 1;
CONSTANT c_no_change      : INTEGER       := 2;
CONSTANT write_first_bits : STRING        := "WRITE_FIRST";
CONSTANT read_first_bits  : STRING        := "READ_FIRST";
CONSTANT no_change_bits   : STRING        := "NO_CHANGE";

--------- Define constants for memory initalization functions --------------
CONSTANT v2max_init_lines       : INTEGER := 64;
CONSTANT v2max_init_parity      : INTEGER := 8;
CONSTANT v2max_init_width       : INTEGER := 256;
CONSTANT vmax_init_lines        : INTEGER := 16;
CONSTANT vmax_init_width        : INTEGER := 256;

--------------- Define default value for top level generics ----------------
CONSTANT DEFAULT_FAMILY		: STRING  := "virtex";
CONSTANT DEFAULT_DEPTH 		: INTEGER := 2048;
CONSTANT DEFAULT_WIDTH 		: INTEGER := 9;
CONSTANT DEFAULT_ADD_WIDTH 	: INTEGER := 11;
CONSTANT DEFAULT_HAS_DIN 	: INTEGER := 1;
CONSTANT DEFAULT_MEM_CONFIG 	: INTEGER := c_sp_ram;
CONSTANT DEFAULT_WRITE_MODE 	: INTEGER := c_write_first;
CONSTANT DEFAULT_PIPE_STAGES 	: INTEGER := 1;
CONSTANT DEFAULT_LIMIT_PITCH 	: INTEGER := 18;
CONSTANT DEFAULT_HAS_LIMIT_PITCH : INTEGER:= 0;
CONSTANT DEFAULT_HAS_WE 	: INTEGER := 1;
CONSTANT DEFAULT_HAS_EN 	: INTEGER := 1;
CONSTANT DEFAULT_HAS_SINIT	: INTEGER := 1;
CONSTANT DEFAULT_SINIT_VALUE 	: STRING  := "000000000";
CONSTANT DEFAULT_HAS_DOUT 	: INTEGER := 1;
CONSTANT DEFAULT_REG_EN 	: INTEGER := 0;
CONSTANT DEFAULT_REG_INPUTS 	: INTEGER := 0;
CONSTANT DEFAULT_EN_RLOCS 	: INTEGER := 0;
CONSTANT DEFAULT_HAS_ND 	: INTEGER := 0;
CONSTANT DEFAULT_HAS_RFD 	: INTEGER := 0;
CONSTANT DEFAULT_HAS_RDY 	: INTEGER := 0;
CONSTANT DEFAULT_HAS_DEFAULT    : INTEGER := 1;
CONSTANT DEFAULT_DEFAULT_DATA   : STRING  := "0000";
CONSTANT DEFAULT_ADDA_WIDTH     : INTEGER := 9;
CONSTANT DEFAULT_ADDB_WIDTH     : INTEGER := 9;
CONSTANT DEFAULT_DEPTHA         : INTEGER := 512;
CONSTANT DEFAULT_DEPTHB         : INTEGER := 512;
CONSTANT DEFAULT_HAS_DINA       : INTEGER := 1;
CONSTANT DEFAULT_HAS_DINB       : INTEGER := 1;
CONSTANT DEFAULT_MEM_INIT       : STRING  := "mif_file_16_1";
CONSTANT DEFAULT_HAS_DOUTA      : INTEGER := 1;
CONSTANT DEFAULT_HAS_DOUTB      : INTEGER := 1;
CONSTANT DEFAULT_HAS_ENA        : INTEGER := 0;
CONSTANT DEFAULT_HAS_ENB        : INTEGER := 0;
CONSTANT DEFAULT_HAS_NDA        : INTEGER := 0;
CONSTANT DEFAULT_HAS_NDB        : INTEGER := 0;
CONSTANT DEFAULT_HAS_RDYA       : INTEGER := 0;
CONSTANT DEFAULT_HAS_RDYB       : INTEGER := 0;
CONSTANT DEFAULT_HAS_RFDA       : INTEGER := 0;
CONSTANT DEFAULT_HAS_RFDB       : INTEGER := 0;
CONSTANT DEFAULT_HAS_SINITA     : INTEGER := 0;
CONSTANT DEFAULT_HAS_SINITB     : INTEGER := 0;
CONSTANT DEFAULT_HAS_WEA        : INTEGER := 1;
CONSTANT DEFAULT_HAS_WEB        : INTEGER := 1;
CONSTANT DEFAULT_PIPE_STAGESA   : INTEGER := 0;
CONSTANT DEFAULT_PIPE_STAGESB   : INTEGER := 0;
CONSTANT DEFAULT_REG_ENA        : INTEGER := 0;
CONSTANT DEFAULT_REG_ENB        : INTEGER := 0;
CONSTANT DEFAULT_REG_INPUTSA    : INTEGER := 0;
CONSTANT DEFAULT_REG_INPUTSB    : INTEGER := 0;
CONSTANT DEFAULT_SINIT_VALUEA   : STRING  :="0000";
CONSTANT DEFAULT_SINIT_VALUEB   : STRING  :="0000";
CONSTANT DEFAULT_WIDTHA         : INTEGER := 16;
CONSTANT DEFAULT_WIDTHB         : INTEGER := 16;
CONSTANT DEFAULT_WRITE_MODEA    : INTEGER := c_write_first;
CONSTANT DEFAULT_WRITE_MODEB    : INTEGER := c_write_first;
-- DEFAULT_XMEM_INIT_ARRAY is not used in D_IP2 release
CONSTANT DEFAULT_XMEM_INIT_ARRAY: MEM_ARRAY := ("123456", "123456", "123456", "123456", "123456", "123456" );
-- DEFAULT VALUES ADDED FOR E_IP1
CONSTANT DEFAULT_ENA_IS_HIGH     : INTEGER := 1;
CONSTANT DEFAULT_ENB_IS_HIGH     : INTEGER := 1;
CONSTANT DEFAULT_CLKA_IS_RISING  : INTEGER := 1;
CONSTANT DEFAULT_CLKB_IS_RISING  : INTEGER := 1;
CONSTANT DEFAULT_PRIMITIVE_TYPE : STRING := "4kx4";
CONSTANT DEFAULT_SINITA_IS_HIGH  : INTEGER := 1;
CONSTANT DEFAULT_SINITB_IS_HIGH  : INTEGER := 1;
CONSTANT DEFAULT_USE_SINGLE_PRIMITIVE : INTEGER := 0;
CONSTANT DEFAULT_WEA_IS_HIGH     : INTEGER := 1;
CONSTANT DEFAULT_WEB_IS_HIGH     : INTEGER := 1;
CONSTANT DEFAULT_BOTTOM_ADDR    : STRING := "0";
CONSTANT DEFAULT_HIERARCHY      : STRING := "hierarchy1";
CONSTANT DEFAULT_MAKE_BMM       : INTEGER := 0;
CONSTANT DEFAULT_TOP_ADDR       : STRING := "1024";
CONSTANT DEFAULT_DISABLE_WARNINGS    : INTEGER := 1;
CONSTANT DEFAULT_SIM_COLLISION_CHECK : STRING := "NONE";
----------------------------------------------------------------------------
-- FUNCTION DECLARATION
----------------------------------------------------------------------------

FUNCTION get_offset(width_a:INTEGER; width_b:INTEGER; has_limit_data_pitch: INTEGER; limit_data_pitch:INTEGER)
RETURN INTEGER;

FUNCTION get_use_parity(width_a:INTEGER; depth_a:INTEGER; width_b:INTEGER; depth_b:INTEGER)
RETURN INTEGER;

FUNCTION slice_width_v2 (family: INTEGER; slice_start: INTEGER; ram_width: INTEGER; ram_depth: INTEGER; offset:INTEGER; use_parity:INTEGER)
RETURN v2_array ;

FUNCTION slice_width_v(family:INTEGER;slice_start: INTEGER;ram_width: INTEGER;ram_depth:INTEGER; offset:INTEGER)
RETURN v_array;

FUNCTION slide_array_v2(slide_array:v2_array;offset:INTEGER)
RETURN v2_array;

FUNCTION slide_array_v(slide_array:v_array;offset:INTEGER)
RETURN v_array;

FUNCTION slice_depth_v2 (ram_depth: INTEGER; offset: INTEGER)
RETURN v2_array ;

FUNCTION slice_depth_v  (ram_depth: INTEGER; offset: INTEGER)
RETURN v_array;

FUNCTION find_total_blk_count_v2 (family: INTEGER; max_slice_width: INTEGER; ram_width: INTEGER; ram_depth: INTEGER; offset: INTEGER; use_parity: INTEGER)
RETURN INTEGER ;

FUNCTION find_total_blk_count_v (family: INTEGER; max_slice_width: INTEGER; ram_width: INTEGER; ram_depth: INTEGER; offset: INTEGER)
RETURN INTEGER ;

FUNCTION find_start_slice_width_v2 (family: INTEGER; ram_width: INTEGER ; ram_depth: INTEGER ; is_single_port : INTEGER; offset: INTEGER; use_parity:INTEGER)
RETURN INTEGER ;

FUNCTION find_start_slice_width_v (family: INTEGER; ram_width: INTEGER ; ram_depth: INTEGER ; is_single_port : INTEGER; offset: INTEGER)
RETURN INTEGER ;

FUNCTION iterate_opt_slice_width_v2 (ram_width: INTEGER; ram_depth: INTEGER; index_start_slice: INTEGER; current_array: v2_array; offset: INTEGER; use_parity:INTEGER)
RETURN v2_array;

FUNCTION iterate_opt_slice_width_v (ram_width: INTEGER; ram_depth: INTEGER; index_start_slice: INTEGER; current_array:v_array; offset: INTEGER)
RETURN v_array;

FUNCTION find_min_blk_count_v2 (ram_width: INTEGER ; ram_depth: INTEGER; offset: INTEGER; use_parity:INTEGER)
RETURN INTEGER ;

FUNCTION find_min_blk_count_v (ram_width: INTEGER ; ram_depth: INTEGER; offset: INTEGER)
RETURN INTEGER ;

FUNCTION find_result_delay(c_reg_inputs: INTEGER; c_pipe_stages: INTEGER)
RETURN INTEGER;

-----------------------Functions for GUI------------------------------------
FUNCTION find_max_depth( family: STRING; width: INTEGER)
RETURN INTEGER;

FUNCTION find_num_blk_used (family: STRING; widtha: INTEGER; deptha: INTEGER; widthb: INTEGER;
depthb: INTEGER; has_limit_data_pitch: INTEGER; limit_data_pitch: INTEGER)
RETURN INTEGER;

FUNCTION find_portb_depth (widtha: INTEGER; deptha: INTEGER; widthb: INTEGER)
RETURN INTEGER;

FUNCTION find_valid_depthb_v2( widtha: INTEGER; deptha: INTEGER)
RETURN v2_array;

FUNCTION find_valid_depthb_v( widtha: INTEGER; deptha: INTEGER)
RETURN v2_array;

FUNCTION find_valid_depthb( family: STRING; widtha: INTEGER; deptha: INTEGER)
RETURN v2_array;

FUNCTION find_valid_widthb_v2( widtha: INTEGER; deptha: INTEGER)
RETURN v2_array;

FUNCTION find_valid_widthb_v( widtha: INTEGER; deptha: INTEGER)
RETURN v2_array;

FUNCTION find_valid_widthb( family: STRING; widtha: INTEGER; deptha: INTEGER)
RETURN v2_array;

FUNCTION limit_data_pitch_isvalid( family: STRING; widtha: INTEGER; widthb: INTEGER)
RETURN boolean;

END  blkmemdp_pkg_v6_3 ;

----------------------------------------------------------------------------
-- Definition of functions
----------------------------------------------------------------------------
--  1.  get_offset(width_a:INTEGER; width_b:INTEGER; has_limit_data_pitch: INTEGER; limit_data_pitch:INTEGER)
--      Given width_a and width_b, returns the corresponding offset for the
--      block RAM implementation algorithm.
--
--  2.  get_use_parity(width_a:INTEGER; depth_a:INTEGER; width_b:INTEGER; depth_b: INTEGER)
--      Returns 1 if parity bits will be used in the constructions of the memory.
--
--  8.	slice_width_v2 (family: INTEGER; slice_start: INTEGER; ram_width: 
--	INTEGER; ram_depth: INTEGER; offset: INTEGER)
--	Returns an array containing number of Block RAMs needed to achieve
--      a width of ram_width. This array uses the least number of block
--      RAMs given index_start_slice. Note that this function calls find_
--      optimized_slice_width_v2().
--
--  9.  slice_width_v(family:INTEGER;slice_start: INTEGER;ram_width:
--      INTEGER;ram_depth:INTEGER; offset:INTEGER)
--      Same as above only for Virtex. 
--
--  10. iterate_opt_slice_width_v2(ram_width: INTEGER; ram_depth: INTEGER;
--      index_start_slice: INTEGER; current_array: v2_array; offset: INTEGER)
--      Given memory width and depth, returns an array containing number of Block
--      RAMs needed to achieve a width of ram_width.  This array uses the least
--      number of block RAMs given index_start_slice.  Note that this function
--      calls slice_width_v2.
--
--  11. iterate_opt_slice_width_v (ram_width: INTEGER; ram_depth: INTEGER;
--      index_start_slice: INTEGER; current_array: v2_array; offset: INTEGER;
--      use_parity:INTEGER)
--      Same as above only for Virtex.
--
--  12.  slide_array_v2(slice_array: v_array; offset: INTEGER)
--      Returns a v2_array with its contents moved to "offset" index lower.
--
--  13.  slide_array_v(slice_array: v_array; offset: INTEGER)
--      Returns a v_array with its contents moved to "offset" index lower.
--      
--  14.	slice_depth_v2 (ram_depth: INTEGER; offset: INTEGER)
--	Returns an array containing number of Block RAMs needed to achieve
--	a depth of ram_depth.
--
--  15.	slice_depth_v (ram_depth: INTEGER; offset: INTEGER)
--	Returns an array containing number of Block RAMs needed to achieve
--	a depth of ram_depth
--
--  16.	find_total_blk_count_v2(family: INTEGER; max_slice_width: INTEGER; 
--	ram_width: INTEGER; ram_depth: INTEGER)
--	Given the relevant info, returns the total Block RAM count for
--      Virtex 2.
--
--  17.	find_total_blk_count_v(family: INTEGER; max_slice_width: INTEGER; 
--	ram_width: INTEGER; ram_depth: INTEGER)
--	Given the relevant info, returns the total Block RAM count for
--      Virtex.
--
--  18.	find_start_slice_width_v2(_v) (family: INTEGER; ram_width: INTEGER ; 
--	ram_depth: INTEGER; is_single_port : INTEGER)	
--	Given memory width and depth, returns which primitive should you use
--	to start the algorithm.
--
--  19.	find_min_blk_count_v2(_v) (ram_width: INTEGER ; ram_depth: INTEGER)
--	Returns the minimum Block RAM count for a particular ram_width and ram_depth.		
--
--  25.	find_result_delay(c_reg_inputs: INTEGER; c_pipe_stages: INTEGER)
--	Returns the core's input to output delay.
--
--  38. find_max_depth( family: STRING; width: INTEGER)
--      Returns the max depth given the width and the family.
--
--  39. find_num_blk_used (family: STRING; widtha: INTEGER; deptha: INTEGER;
--      widthb: INTEGER; depthb: INTEGER; has_limit_data_pitch: INTEGER;
--      limit_data_pitch: INTEGER)
--      Returns the number of block used to create memory.
--
--  40. find_portb_depth (widtha: INTEGER; deptha: INTEGER; widthb: INTEGER)
--      Returns port b depth given port a width, depth and port b width.
--
--  41. find_valid_depth_v2( widtha: INTEGER; deptha: INTEGER)
--      Returns an array of type v2_array containing the valid depth for port b
--      for Virtex2 implementation
--
--  42. find_valid_depth_v( widtha: INTEGER; deptha: INTEGER)
--      Returns an array of type v_array containing the valid depth for port b
--      for Virtex implementation
--
--  43. find_valid_depthb( family: STRING; widtha: INTEGER; deptha: INTEGER)
--      Returns an array of type v_array containing the valid depth for port b
--      for Virtex or Virtex-II architecture.
--
--  44. find_valid_widthb(_v2)(_v)( family: STRING; widtha: INTEGER; deptha: INTEGER)
--      Returns an array of type v2_array containing the valid width for port b
--      for Virtex or Virtex-II
--  
--  45. limit_data_pitch_isvalid( widtha: STRING; widthb: INTEGER: family: INTEGER)
--      Returns a boolean that indicates whether the limit data pitch option
--      is available to this core
--
----------------------------------------------------------------------------


PACKAGE BODY blkmemdp_pkg_v6_3 IS

-------------------------------------------------------------------------------
-- FUNCTION: get_offset
-- Given width_a and width_b this function determines the which block
-- primitives can be used for port a so that the port b will be able to use the
-- same number of blocks. It is assumed that port b is wider than port a.
-- The return value, which we call the offset, will tell us how many primitives
-- we should not consider, starting with the greatest width.  The offset will
-- at least be 1 because we cannot use the smallest width because it is only
-- possible using both ports of a dual port.A value of 0
-- allows the algorithm to consider all depths, a value of 1 allows the
-- algorithm to consider all depths except for the greatest depth, a value of 2
-- allows the algorithm to consider all depths except for the greatest 2 depths
-- and so on. The default value is 5, but care should be taken so that one of
-- the coniditions is met.
-------------------------------------------------------------------------------

FUNCTION get_offset(width_a:INTEGER; width_b:INTEGER; has_limit_data_pitch: INTEGER; limit_data_pitch:INTEGER)
  RETURN INTEGER IS
  VARIABLE multiplier : INTEGER := width_b/width_a;
BEGIN

  IF multiplier=1 THEN
    IF (has_limit_data_pitch=1) AND (limit_data_pitch=18) THEN  -- virtex2
      RETURN 2;
    ELSIF (has_limit_data_pitch=1) AND (limit_data_pitch=8) THEN  -- virtex
      RETURN 2;
    ELSE  
      RETURN 1;
    END IF;
  ELSIF multiplier=2 THEN
    RETURN 2;
  ELSIF multiplier=4 THEN 
    RETURN 3;
  ELSIF multiplier=8 THEN
    RETURN 4;
  ELSIF multiplier=16 THEN 
    RETURN 5;
  ELSIF multiplier=32 THEN
    RETURN 6;
  ELSE
    RETURN 5;
  END IF;

END get_offset;

----------------------------------------------------------------------------
-- FUNCTION : get_use_parity
-- Determines whether the parity bits in the RAM primitives would be used.
-- For D_IP2 release, only symmetric memories and implementations of
-- RAMB16_S18_S36, RAMB16_S9_S18 and RAMB16_S9_S36 primitives would use
-- parity.  Returns 1 if parity is used else returns 0.
----------------------------------------------------------------------------
FUNCTION get_use_parity(width_a:INTEGER; depth_a:INTEGER; width_b:INTEGER; depth_b: INTEGER)
RETURN INTEGER IS
  VARIABLE use_parity : INTEGER := 0;
BEGIN

  -- Use parity = 1 when
  -- 1. Building the following dual port block memory primitive
  --    RAMB16_S18_S36, RAM16_S9_S18, RAM16_S9_S36
  -- 2. When building symmetric memory
  IF ( (width_a=width_b)
       OR ((width_a=9)  AND (width_b=18) AND (depth_a<=2048) AND (depth_b<=1024))
       OR ((width_a=9)  AND (width_b=36) AND (depth_a<=2048) AND (depth_b<=512 ))
       OR ((width_a=18) AND (width_b=36) AND (depth_a<=1024) AND (depth_b<=512 ))
     )THEN
    use_parity := 1;
  END IF;

  RETURN use_parity;
END get_use_parity;

----------------------------------------------------------------------------
-- FUNCTION : slice_(the_)width_v2 (For VIRTEX2)
-- Returns an optimized array containing number of Block RAMs needed to achieve
-- a width of ram_width.     	   
----------------------------------------------------------------------------
FUNCTION slice_width_v2 (family    : INTEGER ; 
			 slice_start: INTEGER ; 
			 ram_width  : INTEGER ; 
			 ram_depth  : INTEGER ;
                         offset     : INTEGER ;
                         use_parity : INTEGER
                        )
RETURN v2_array IS
  --widths are{1,2,4,9,18,36,72} respectively
  VARIABLE slice_array 	: v2_array	:= (0,0,0,0,0,0,0) ;	
  VARIABLE remainder 	: INTEGER	:= 0 ;
  VARIABLE slice_width	: INTEGER	:= 0 ;
  VARIABLE i            : INTEGER       := offset;
  VARIABLE finish       : INTEGER       := 0;
BEGIN

  remainder := ram_width;

  -- iterate through all the possible primitive widths
  -- and while the flag "finish" is invalid
  WHILE (i < v2_index) and (finish = 0) LOOP
    -- choose slice widths with or without parity
    IF (use_parity=1) THEN
      slice_width := v2_widths(i) ;
    ELSE
      slice_width := v2_widths_nop(i) ;
    END IF;
    -- find the optimize number of blocks of a certain primitive 
    -- that is needed to implement ram_width x ram_depth 
    -- There are 4 cases to check.
  
    -- Case 1: If current primitive width larger than the 
    -- start width    
    IF (slice_start < slice_width) THEN
      slice_array(i) := 0;

    -- Case 2: If current primitive width is the indicated start
    -- width
    ELSIF (slice_start = slice_width) THEN

      -- requested RAM width is smaller than the primitive width
      IF (ram_width <= slice_width) THEN
        slice_array(i) := 1;
        remainder      := 0;
      -- requested RAM width is larger than the primitive width 
      -- and the remainding width to be processed is smaller or equal
      -- than the next primitive width
      ELSE
        slice_array(i) := (ram_width/slice_width) ;
        remainder      :=  ram_width - (slice_array(i) * slice_width);
        IF (remainder /= 0) THEN
          slice_array  := iterate_opt_slice_width_v2(remainder, ram_depth, i, slice_array,offset,use_parity);
        END IF;
      END IF;

      finish           := 1;
           
    -- Case 3: IF using the last index, primitive_width = 1
    ELSIF ( (slice_width = 1) AND (remainder > 0) ) THEN
      slice_array(i) := (remainder/slice_width);
      remainder := remainder - (slice_array(i)*slice_width);
      finish := 1;
    END IF;

    -- increment index
    i := i + 1;    

  END LOOP;

  RETURN slice_array ;
END slice_width_v2 ;

----------------------------------------------------------------------------
-- FUNCTION : slice_(the_)width_v (FOR VIRTEX)
-- Returns an optimized array containing number of Block RAMs needed to achieve
-- a width of ram_width.		   
----------------------------------------------------------------------------
FUNCTION slice_width_v (family: INTEGER ; 
			slice_start: INTEGER ; 
			ram_width: INTEGER ; 
			ram_depth: INTEGER;
                        offset   : INTEGER)
RETURN v_array IS
  --widths are{1,2,4,8,16,32} respectively
  VARIABLE slice_array 	: v_array	:= (0,0,0,0,0,0) ;	
  VARIABLE remainder 	: INTEGER	:= 0 ;
  VARIABLE slice_width	: INTEGER	:= 0 ;
  VARIABLE finish       : INTEGER       := 0;
  VARIABLE i            : INTEGER       :=offset;
BEGIN

  remainder := ram_width;

  -- iterate through all the possible primitive widths
  -- and while the flag "finish" is invalid
  WHILE (i < v_index) and (finish = 0) LOOP
    slice_width := v_widths(i) ;
    
    -- find the optimize number of blocks of a certain primitive 
    -- that is needed to implement ram_width x ram_depth 
    -- There are 4 cases to check.
  
    -- Case 1: If current primitive width larger than the 
    -- start width    
    IF (slice_start < slice_width) THEN
      slice_array(i) := 0;

    -- Case 2: If current primitive width is the indicated start
    -- width
    ELSIF (slice_start = slice_width) THEN

      -- requested RAM width is smaller than the primitive width
      IF (ram_width <= slice_width) THEN
        slice_array(i) := 1;
        remainder      := 0;
      -- requested RAM width is larger than the primitive width 
      -- and the remainding width to be processed is smaller or equal
      -- than the next primitive width
      ELSE
        slice_array(i) := (ram_width/slice_width) ;
        remainder      :=  ram_width - (slice_array(i) * slice_width);
        IF (remainder /= 0) THEN
          slice_array := iterate_opt_slice_width_v(remainder, ram_depth, i, slice_array,offset);
        END IF;
      END IF;

      finish         := 1;
           
    -- Case 3: IF using the last index, primitive_width = 1
    ELSIF ( (slice_width = 1) AND (remainder > 0) ) THEN
      slice_array(i) := (remainder/slice_width);
      remainder := remainder - (slice_array(i)*slice_width);
      finish := 1;
    END IF;

    -- increment index
    i := i + 1;    

  END LOOP;

  RETURN slice_array ;
END slice_width_v ;

----------------------------------------------------------------------------
-- FUNCTION : iterate_opt_slice_(the_)width_v2 (FOR VIRTEX2)
-- Returns an array containing an optimized number of Block RAMs needed to
-- achieve width of ram_width.  Note that this function is an extension of
-- function slice_width_v2 and is used to make the slice_width_v2 function
-- recursive.  (It even calls function slice_width_v2)
----------------------------------------------------------------------------
FUNCTION iterate_opt_slice_width_v2( ram_width : INTEGER;
                                     ram_depth : INTEGER;
                                     index_start_slice : INTEGER;
                                     current_array     : v2_array;
                                     offset            : INTEGER ;
                                     use_parity        : INTEGER )
RETURN v2_array IS
  CONSTANT depth_array : v2_array := slice_depth_v2(ram_depth, offset);
  VARIABLE start_width : INTEGER  := 0;
  VARIABLE best_width  : INTEGER  := 0;
  VARIABLE best_blocks : INTEGER  := 99999; -- arbritary large number
  VARIABLE best_width_array : v2_array := (0,0,0,0,0,0,0);
  VARIABLE width_array  : v2_array     := (0,0,0,0,0,0,0);
  VARIABLE total_blocks : INTEGER      := 0;
BEGIN

  -- start iterating from the last index used to the max index value
  FOR i IN index_start_slice TO (v2_index-1) LOOP
    -- choose slice widths with or without parity
    IF (use_parity=1) THEN
      start_width := v2_widths(i) ;
    ELSE
      start_width := v2_widths_nop(i) ;
    END IF;
    -- find the optimized width_array associated with the start width
    width_array  := slice_width_v2(virtex2, start_width, ram_width, ram_depth, offset,use_parity);

    -- calculate number of blocks used for this array
    total_blocks := 0;
    FOR j  IN offset TO (v2_index-1) LOOP
      total_blocks := total_blocks + (depth_array(j)*width_array(j));
    END LOOP;

    -- store the width array and start width with the smallest block count
    -- so far
    IF (total_blocks <= best_blocks) AND (total_blocks /= 0) THEN
      best_width_array := width_array;
      best_blocks := total_blocks ;
      best_width  := start_width  ;
    END IF;
  END LOOP;

  -- combine the previous v2_array with the new one
  FOR k IN 0 TO index_start_slice-1 LOOP
    best_width_array(k) := current_array(k);
  END LOOP;
    best_width_array(index_start_slice) := current_array(index_start_slice) + best_width_array(index_start_slice);


  RETURN best_width_array ;

END iterate_opt_slice_width_v2;

----------------------------------------------------------------------------
-- FUNCTION : iterate_opt_slice_(the_)width_v
-- Returns an array containing an optimized number of Block RAMs needed to
-- achieve width of ram_width.  Note that this function is an extension of
-- function slice_width_v2 and is used to make the slice_width_v2 function
-- recursive.  (It even calls function slice_width_v)   
----------------------------------------------------------------------------
FUNCTION iterate_opt_slice_width_v( ram_width : INTEGER;
                                    ram_depth : INTEGER;
                                    index_start_slice : INTEGER;
                                    current_array : v_array ;
                                    offset    : INTEGER )
RETURN v_array IS
  CONSTANT depth_array : v_array := slice_depth_v(ram_depth,offset);
  VARIABLE start_width : INTEGER  := 0;
  VARIABLE best_width  : INTEGER  := 0;
  VARIABLE best_blocks : INTEGER  := 99999; -- arbritary large number
  VARIABLE best_width_array : v_array := (0,0,0,0,0,0);
  VARIABLE width_array  : v_array     := (0,0,0,0,0,0);
  VARIABLE total_blocks : INTEGER      := 0; 
BEGIN

  -- start iterating from the last index used to the max index value
  FOR i IN index_start_slice TO (v_index-1) LOOP
    start_width := v_widths(i);
    -- find the optimized width_array associated with the start width
    width_array  := slice_width_v(virtex, start_width, ram_width, ram_depth,offset);

    -- calculate number of blocks used for this array
    total_blocks := 0;
    FOR j  IN offset TO (v_index-1) LOOP
      total_blocks := total_blocks + (depth_array(j)*width_array(j));
    END LOOP;

    -- store the width array and start width with the smallest block count
    -- so far
    IF (total_blocks <= best_blocks) AND (total_blocks /= 0) THEN
      best_width_array := width_array;
      best_blocks := total_blocks ;
      best_width  := start_width  ;
    END IF;
  END LOOP;

  -- combine the previous   v_array with the new one
  FOR k IN 0 TO index_start_slice-1 LOOP
    best_width_array(k) := current_array(k);
  END LOOP;
    best_width_array(index_start_slice) := current_array(index_start_slice) + best_width_array(index_start_slice);


  RETURN best_width_array ;

END iterate_opt_slice_width_v;

-------------------------------------------------------------------------------
--FUNCTION: slide_array_v (FOR VIRTEX)
--Slides the width or depth array over according the given offset.  Fills
--spaces not occupied by this slide with 0.  Never allows a non-zero value in
--the first location of the array (location corresponding to 128;special case for
--single port block memory)
-------------------------------------------------------------------------------
FUNCTION slide_array_v(slide_array:v_array;offset:integer)
  RETURN v_array IS
  VARIABLE return_array : v_array := (0,0,0,0,0,0);
 BEGIN
  -- starts at 1 because we cannot use 128 primitive
  FOR i IN (v_index-1) DOWNTO offset LOOP
    return_array(i-(offset-1)):=slide_array(i);  --offset-1 is equal to the
                                                 --number of slides we need for
                                                 --port B
  END LOOP;

  RETURN return_array;
END slide_array_v;

-------------------------------------------------------------------------------
--FUNCTION: slide_array_v2 (FOR VIRTEX 2)
--Slides the width or depth array over according the given offset.  Fills
--spaces not occupied by this slide with 0.  Never allows a non-zero value in
--the first location of the array (location corresponding to 256;special case
--for single port block memory)
-------------------------------------------------------------------------------
FUNCTION slide_array_v2(slide_array:v2_array;offset:integer)
  RETURN v2_array IS
  VARIABLE return_array : v2_array := (0,0,0,0,0,0,0);
BEGIN
  -- starts at 1 because we cannot use 128 primitive
  FOR i IN (v2_index-1) DOWNTO offset LOOP
    return_array(i-(offset-1)):=slide_array(i);  --offset-1 is equal to the
                                                 --number of slides we need for
                                                 --port B
  END LOOP;

  RETURN return_array;
END slide_array_v2;

----------------------------------------------------------------------------
-- FUNCTION : slice_(the_)depth_v2 (FOR VIRTEX 2)
-- Returns an array containing number of Block RAMs needed to achieve
-- a depth of ram_depth.                                           
----------------------------------------------------------------------------
FUNCTION slice_depth_v2 (ram_depth: INTEGER; offset: INTEGER)
RETURN v2_array IS
  VARIABLE slice_count 	: v2_array	:= (0,0,0,0,0,0,0) ;	
  --widths are{1,2,4,9,18,36} respectively
BEGIN
  FOR i IN offset TO (v2_index-1) LOOP
    IF (ram_depth > 0) THEN
      slice_count(i) := (((ram_depth-1)/v2_depths(i)) +1) ;
    ELSE
      slice_count(i) := 0 ;
    END IF ;				
  END LOOP ;
    RETURN slice_count ;
END slice_depth_v2 ;

----------------------------------------------------------------------------
-- FUNCTION : slice_(the_)depth_v (FOR VIRTEX)
-- Returns an array containing number of Block RAMs needed to achieve
-- a depth of ram_depth.                                           
----------------------------------------------------------------------------
FUNCTION slice_depth_v (ram_depth: INTEGER; offset: INTEGER)
RETURN v_array IS
  VARIABLE slice_count 	: v_array	:= (0,0,0,0,0,0) ;	
  --widths are{1,2,4,8,16,32} respectively
BEGIN
  FOR i IN offset TO (v_index-1) LOOP
    IF (ram_depth > 0) THEN
      slice_count(i) := (((ram_depth-1)/v_depths(i)) +1) ;
    ELSE
      slice_count(i) := 0 ;
    END IF ;				
  END LOOP ;
    RETURN slice_count ;
END slice_depth_v ;

----------------------------------------------------------------------------
-- FUNCTION : find_total_blk_count(_v2) (FOR VIRTEX2)
-- Given the relevant info, returns the total Block RAM count.
----------------------------------------------------------------------------
FUNCTION find_total_blk_count_v2 (family   : INTEGER ;
				  max_slice_width: INTEGER ;
				  ram_width: INTEGER ;   
				  ram_depth: INTEGER ;
                                  offset   : INTEGER ;
                                  use_parity: INTEGER )
RETURN INTEGER IS
  CONSTANT slice_array 	: v2_array	:= slice_width_v2 (family, max_slice_width, ram_width, ram_depth, offset, use_parity) ;
  CONSTANT block_count	: v2_array	:= slice_depth_v2 (ram_depth, offset) ;
  VARIABLE total_blocks	: INTEGER	:= 0 ;
BEGIN
  FOR i IN 0 TO (v2_index-1) LOOP
    total_blocks	:= total_blocks + (slice_array(i) * block_count(i)) ;
  END LOOP ;
  RETURN total_blocks ;
END find_total_blk_count_v2 ;

----------------------------------------------------------------------------
-- FUNCTION : find_total_blk_count(_v) (FOR VIRTEX)
-- Given the relevant info, returns the total Block RAM count.
----------------------------------------------------------------------------
FUNCTION find_total_blk_count_v (family         : INTEGER ;
				 max_slice_width: INTEGER ;
				 ram_width      : INTEGER ;   
				 ram_depth      : INTEGER ;
                                 offset         : INTEGER )
RETURN INTEGER IS
  CONSTANT slice_array 	: v_array	:= slice_width_v (family, max_slice_width, ram_width, ram_depth,offset) ;
  CONSTANT block_count	: v_array	:= slice_depth_v (ram_depth, offset) ;
  VARIABLE total_blocks	: INTEGER	:= 0 ;
BEGIN
  FOR i IN offset TO (v_index-1) LOOP
    total_blocks	:= total_blocks + (slice_array(i) * block_count(i)) ;
  END LOOP ;
  RETURN total_blocks ;
END find_total_blk_count_v ;

----------------------------------------------------------------------------
-- FUNCTION : find_start_slice_width(_v2) (FOR VIRTEX2)
-- Given memory width and depth, returns which primitive should you use
-- to start the algorithm.*    	    
----------------------------------------------------------------------------
FUNCTION find_start_slice_width_v2 (family         : INTEGER ;
				    ram_width      : INTEGER ;   
				    ram_depth      : INTEGER ;
                                    is_single_port : INTEGER ;
                                    offset         : INTEGER ;
                                    use_parity     : INTEGER  )
RETURN INTEGER IS
  VARIABLE start_width	: INTEGER	:= 0 ;
  VARIABLE best_width	: INTEGER 	:= 0 ;	
  VARIABLE total_blocks	: INTEGER	:= 0 ;
  VARIABLE best_blocks	: INTEGER	:= 99999 ;	--arbitrary large #
  VARIABLE v2_index_start : INTEGER := 0;
BEGIN
  IF (is_single_port = 1) THEN
    v2_index_start := 0;
  ELSE
    v2_index_start := 1;
  END IF;
  
  FOR i IN v2_index_start TO (v2_index-1) LOOP
    -- choose slice widths with or without parity
    IF (use_parity=1) THEN
      start_width:= v2_widths(i) ;
    ELSE
      start_width:=v2_widths_nop(i);
    END if;
    total_blocks:= find_total_blk_count_v2(family, start_width, ram_width, ram_depth, offset, use_parity) ;
    IF (total_blocks <= best_blocks) THEN
      best_blocks 	:= total_blocks ;
      best_width	:= start_width ;
    END IF ;
  END LOOP ;
  RETURN best_width ;
END find_start_slice_width_v2 ;

----------------------------------------------------------------------------
-- FUNCTION : find_start_slice_width(_v) (FOR VIRTEX)
-- Given memory width and depth, returns which primitive should you use
-- to start the algorithm.*    	    
----------------------------------------------------------------------------
FUNCTION find_start_slice_width_v (family         : INTEGER ;
				   ram_width      : INTEGER ;   
				   ram_depth      : INTEGER ;
                                   is_single_port : INTEGER ;
                                   offset         : INTEGER)
RETURN INTEGER IS
  VARIABLE start_width	: INTEGER	:= 0 ;
  VARIABLE best_width	: INTEGER 	:= 0 ;	
  VARIABLE total_blocks	: INTEGER	:= 0 ;
  VARIABLE best_blocks	: INTEGER	:= 99999 ;	--arbitrary large #
  VARIABLE v_index_start : INTEGER := 0;
BEGIN
  IF (is_single_port = 1) THEN
    v_index_start := 0         ;
  ELSE
    v_index_start := offset;
  END IF;
  
  FOR i IN v_index_start TO (v_index-1) LOOP
    start_width	:= v_widths(i) ;
    total_blocks:= find_total_blk_count_v(family, start_width, ram_width, ram_depth, offset) ;
    IF (total_blocks <= best_blocks) THEN
      best_blocks 	:= total_blocks ;
      best_width	:= start_width ;
    END IF ;
  END LOOP ;
  RETURN best_width ;
END find_start_slice_width_v ;

----------------------------------------------------------------------------
-- FUNCTION : find_min_blk_count(_v2) (FOR VIRTEX2)
-- Returns the minimum Block RAM count for a particular ram_width and 
-- ram_depth.		
----------------------------------------------------------------------------
FUNCTION find_min_blk_count_v2 (
			        ram_width: INTEGER ;   
			        ram_depth: INTEGER ;
                                offset   : INTEGER ;
                                use_parity: INTEGER )
RETURN INTEGER IS
  CONSTANT best_width : INTEGER := find_start_slice_width_v2(virtex2, ram_width, ram_depth,0,offset,use_parity);
  CONSTANT width_array : v2_array := slice_width_v2(virtex2,best_width,ram_width,ram_depth,offset,use_parity); 
  CONSTANT depth_array : v2_array := slice_depth_v2(ram_depth,offset);
  VARIABLE total_blocks : INTEGER := 0;
BEGIN

  FOR i IN 0 TO (v2_index-1) LOOP
    total_blocks	:= total_blocks + (width_array(i) * depth_array(i)) ;
  END LOOP ;
  RETURN total_blocks ;

END find_min_blk_count_v2 ;

----------------------------------------------------------------------------
-- FUNCTION : find_min_blk_count(_v) (FOR VIRTEX)    	    
-- Returns the minimum Block RAM count for a particular ram_width and 
-- ram_depth.		
----------------------------------------------------------------------------
FUNCTION find_min_blk_count_v (
			       ram_width: INTEGER ;   
			       ram_depth: INTEGER ;
                               offset   : INTEGER  )
RETURN INTEGER IS
  CONSTANT best_width  : INTEGER := find_start_slice_width_v(virtex,ram_width,ram_depth,0, offset);
  CONSTANT width_array : v_array := slice_width_v(virtex,best_width,ram_width,ram_depth,offset); 
  CONSTANT depth_array : v_array := slice_depth_v(ram_depth,offset);
  VARIABLE total_blocks	: INTEGER := 0 ;
BEGIN
  FOR i IN 0 TO (v_index-1) LOOP
    total_blocks	:= total_blocks + (width_array(i) * depth_array(i)) ;
  END LOOP ;
  RETURN total_blocks ;
END find_min_blk_count_v ;

----------------------------------------------------------------------------
-- FUNCTION : find_result_delay
-- Returns the block memory cores' input to output delay.
----------------------------------------------------------------------------
FUNCTION find_result_delay(c_reg_inputs : INTEGER; c_pipe_stages : INTEGER)
RETURN INTEGER IS
  VARIABLE result_delay : INTEGER := 0;
BEGIN
  IF( (c_reg_inputs=0) AND (c_pipe_stages=0) ) THEN
    result_delay := 1;
  ELSIF ( (c_reg_inputs=1) AND (c_pipe_stages=0) ) THEN
    result_delay := 2;
  ELSIF ( (c_reg_inputs=0) AND (c_pipe_stages=1) ) THEN
    result_delay := 2;       
  ELSIF ( (c_reg_inputs=1) AND (c_pipe_stages=1) ) THEN
    result_delay := 3;
  END IF;
  RETURN result_delay;
END find_result_delay;

-------------------------Functions for GUI----------------------------------

----------------------------------------------------------------------------
-- FUNCTION: find_max_depth 
-- Returns the maximum depth of a memory given the width and family.
----------------------------------------------------------------------------
FUNCTION find_max_depth( family:STRING; width: INTEGER)
RETURN INTEGER IS
  VARIABLE max_depth : INTEGER := 0;
BEGIN
IF (family="virtex2") THEN

  IF (width > 0) THEN
  
    IF (width < 4) THEN 
      max_depth := 1024*1024;
    ELSIF (width <7) THEN
      max_depth := 1024*512;
    ELSIF (width<13) THEN
      max_depth := 1024*256;
    ELSIF (width <25) THEN
      max_depth := 1024*128;
    ELSIF (width<49) THEN
      max_depth := 1024*64;
    ELSIF (width <97) THEN
      max_depth := 1024*32;
    ELSIF (width<193) THEN
      max_depth := 1024*16;
    ELSE
      max_depth := 1024*8;
    END IF;
        
  END IF;   
ELSIF (family="virtex") THEN
  IF (width > 0) THEN
  
    IF (width < 4) THEN 
      max_depth := 1024*256;
    ELSIF (width <7) THEN
      max_depth := 1024*128;
    ELSIF (width<13) THEN
      max_depth := 1024*64;
    ELSIF (width <25) THEN
      max_depth := 1024*32;
    ELSIF (width<49) THEN
      max_depth := 1024*16;
    ELSIF (width<97) THEN
      max_depth := 1024*8;
    ELSE
      max_depth := 1024*4;
    END IF;
        
  END IF;
END IF;
  
  RETURN max_depth;
  
END find_max_depth;

---------------------------------------------------------------------------
-- FUNCTION : find_num_blk_used
-- Find the number of RAM blocks used to make a memory of size widtha x
-- deptha (port A) and widthb x depthb (port B)
---------------------------------------------------------------------------
FUNCTION find_num_blk_used (family: STRING; widtha: INTEGER; deptha: INTEGER; widthb: INTEGER;
depthb: INTEGER; has_limit_data_pitch: INTEGER; limit_data_pitch: INTEGER)
RETURN INTEGER IS
  VARIABLE blk_count :INTEGER := 0;
  VARIABLE use_parity:INTEGER := 0;
  VARIABLE offset    : INTEGER   := 0;
BEGIN

  
  offset := get_offset(widtha,widthb,has_limit_data_pitch,limit_data_pitch);
  
  IF family="virtex2" THEN
    use_parity:= get_use_parity(widtha, deptha, widthb, depthb);
    blk_count := find_min_blk_count_v2(widtha, deptha, offset, use_parity);
  ELSE--family is virtex
    blk_count := find_min_blk_count_v(widtha, deptha, offset);
  END IF;

  RETURN blk_count;
END find_num_blk_used;

---------------------------------------------------------------------------
-- FUNCTION find_portb_depth
-- Returns the portb depth size given the porta depth and width
---------------------------------------------------------------------------
FUNCTION find_portb_depth (widtha: INTEGER; deptha: INTEGER; widthb: INTEGER)
RETURN INTEGER IS
  VARIABLE depthb: INTEGER := 0;
BEGIN
  depthb := (widtha*deptha)/widthb;
  RETURN depthb;
END find_portb_depth;

-------------------------------------------------------------------------------
-- Function : find_valid_depth_v2 ( FOR VIRTEX2)
-- Returns an array of INTEGERS of type v2_array containing the valid depth for 
-- port B for Virtex-II
-------------------------------------------------------------------------------
FUNCTION find_valid_depthb_v2( widtha: INTEGER; deptha: INTEGER) 
RETURN v2_array IS
  VARIABLE depthb_array: v2_array := (0,0,0,0,0,0,0);
  VARIABLE powerof2    : INTEGER := 1;
  VARIABLE temp_width, temp_depth : INTEGER := 0;
  VARIABLE orig_mem, current_mem : INTEGER := 0;
BEGIN
  orig_mem := widtha * deptha;
  
  FOR i IN 0 TO v2_index-1 LOOP
    IF ((deptha MOD 2)/=0) THEN
      depthb_array(i) := 0;
    ELSE
      temp_depth := deptha / powerof2;
      IF (temp_depth > 0) THEN
        temp_width := (deptha*widtha)/temp_depth;
      ELSE
        temp_width := 0;
      END IF;
      
      current_mem := temp_width * temp_depth;

      IF ((temp_width = 0) OR (current_mem /= orig_mem) OR
          ((deptha/temp_depth)/=powerof2)) THEN
        depthb_array(i) := 0;
      ELSE
        depthb_array(i) := temp_depth;
      END IF;

      powerof2 := powerof2 * 2;
    END IF;
   END LOOP;  -- i IN 0 TO v2_index
    
  RETURN depthb_array;
  
END find_valid_depthb_v2;

-------------------------------------------------------------------------------
-- Function : find_valid_depth_v (FOR VIRTEX)
-- Returns an array of INTEGERS of type v2_array containing the valid depth for
--  port B for Virtex.
-------------------------------------------------------------------------------
FUNCTION find_valid_depthb_v( widtha: INTEGER; deptha: INTEGER) 
RETURN v2_array IS
  VARIABLE depthb_array: v2_array := (0,0,0,0,0,0,0);
  VARIABLE powerof2    : INTEGER := 1;
  VARIABLE temp_width, temp_depth : INTEGER := 0;
  VARIABLE orig_mem, current_mem : INTEGER := 0;
BEGIN
  orig_mem := widtha * deptha;
  
  FOR i IN 0 TO v2_index-1 LOOP
    IF ((i > 4) OR ((deptha MOD 2)/=0)) THEN
      depthb_array(i) := 0;
    ELSE
      temp_depth := deptha / powerof2;
      IF (temp_depth > 0) THEN
        temp_width := (deptha*widtha)/temp_depth;
      ELSE
        temp_width := 0;
      END IF;
      
      current_mem := temp_width * temp_depth;

      IF ((temp_width = 0) OR (current_mem /= orig_mem) OR
          ((deptha/temp_depth)/=powerof2)) THEN
        depthb_array(i) := 0;
      ELSE
        depthb_array(i) := temp_depth;
      END IF;

      powerof2 := powerof2 * 2;
    END IF;
   END LOOP;  -- i IN 0 TO v2_index
    
  RETURN depthb_array;
  
END find_valid_depthb_v;

-------------------------------------------------------------------------------
-- Function : find_valid_depth
-- Returns an array of type v2_array containing the valid depth for port b
-- for Virtex or Virtex-II
-------------------------------------------------------------------------------
FUNCTION find_valid_depthb( family: STRING; widtha: INTEGER; deptha: INTEGER) 
RETURN v2_array IS
  VARIABLE depthb_array: v2_array := (0,0,0,0,0,0,0);
BEGIN

  IF (family="virtex2") THEN
    depthb_array := find_valid_depthb_v2(widtha, deptha);
  ELSE
    depthb_array := find_valid_depthb_v(widtha, deptha);
  END IF;
    
  RETURN depthb_array;  
  
END find_valid_depthb;

-------------------------------------------------------------------------------
-- Function : find_valid_width_v2 (FOR VIRTEX-II)
-- Returns an array of type v2_array containing the valid width for port b
-- for Virtex-II
-------------------------------------------------------------------------------
FUNCTION find_valid_widthb_v2( widtha: INTEGER; deptha: INTEGER) 
RETURN v2_array IS
  VARIABLE widthb_array: v2_array := (0,0,0,0,0,0,0);
  VARIABLE powerof2    : INTEGER := 1;
  VARIABLE temp_width, temp_depth : INTEGER := 0;
  VARIABLE orig_mem, current_mem : INTEGER := 0;
BEGIN
  orig_mem := widtha * deptha;
  
  FOR i IN 0 TO v2_index-1 LOOP
    temp_width := widtha * powerof2;
    temp_depth := (deptha*widtha)/temp_width;
    current_mem := temp_width * temp_depth;
    IF (((temp_depth = 0) OR (current_mem /= orig_mem)) OR (temp_width>256) ) THEN
      widthb_array(i) := 0;
    ELSE
      widthb_array(i) := temp_width;
    END IF;
    powerof2 := powerof2 * 2;
 
  END LOOP;  -- i IN 0 TO v2_index
    
  RETURN widthb_array;
  
END find_valid_widthb_v2;

-------------------------------------------------------------------------------
-- Function : find_valid_width_v (FOR VIRTEX)
-- Returns an array of type v2_array containing the valid width for port b
-- for Virtex.
-------------------------------------------------------------------------------
FUNCTION find_valid_widthb_v( widtha: INTEGER; deptha: INTEGER) 
RETURN v2_array IS
  VARIABLE widthb_array: v2_array := (0,0,0,0,0,0,0);
  VARIABLE powerof2    : INTEGER := 1;
  VARIABLE temp_width, temp_depth : INTEGER := 0;
  VARIABLE orig_mem, current_mem : INTEGER := 0;
BEGIN
  orig_mem := widtha * deptha;
  
  FOR i IN 0 TO v2_index-1 LOOP
    IF ((i > 4) OR ((deptha MOD 2)/=0) ) THEN
      widthb_array(i) := 0;
    ELSE
      temp_width := widtha * powerof2;
      temp_depth := (deptha*widtha)/temp_width;
      current_mem := temp_width * temp_depth;
      IF (((temp_depth = 0) OR (current_mem /= orig_mem)) OR (temp_width >256) ) THEN
        widthb_array(i) := 0;
      ELSE
        widthb_array(i) := temp_width;
      END IF;

      powerof2 := powerof2 * 2;
    END IF;
   END LOOP;  -- i IN 0 TO v2_index
    
  RETURN widthb_array;
    
END find_valid_widthb_v;

-------------------------------------------------------------------------------
-- Function : find_valid_width
-- Returns an array of type v2_array containing the valid width for port b
-- for Virtex or Virtex-II
-------------------------------------------------------------------------------
FUNCTION find_valid_widthb( family: STRING; widtha: INTEGER; deptha: INTEGER) 
RETURN v2_array IS
  VARIABLE widthb_array: v2_array := (0,0,0,0,0,0,0);
BEGIN

  IF (family = "virtex2") THEN
    widthb_array := find_valid_widthb_v2(widtha, deptha);
  ELSE
    widthb_array := find_valid_widthb_v(widtha, deptha);
  END IF;
    
  RETURN widthb_array;
  
END find_valid_widthb;

-------------------------------------------------------------------------
-- FUNCTION : limit_data_pitch_isvalid
-- Returns a boolean that indicates whether the limit data pitch option
-- is applicable to the core.  All symmetric cores will support this 
-- option but only asymmetric cores with width A and width B ratio of
-- 1:1, 1:2, 1:4, 1:8 for Virtex and 1:1, 1:2, 1:4, 1:8, 1:16 for
-- Virtex-II will support the limit data pitch option.
--------------------------------------------------------------------------
FUNCTION limit_data_pitch_isvalid( family: STRING;
                                   widtha: INTEGER;
                                   widthb: INTEGER)
RETURN boolean IS
  VARIABLE valid : BOOLEAN := false;
            
BEGIN
  IF family="virtex2" THEN
    IF ((widthb/widtha) <= 16) THEN
      valid:=  true;
    END IF;
  ELSIF family="virtex" THEN
    IF ( (widthb/widtha) <= 8) THEN
      valid:=  true;
    END IF;
  END IF;

  RETURN valid;
  
END limit_data_pitch_isvalid;

END blkmemdp_pkg_v6_3;



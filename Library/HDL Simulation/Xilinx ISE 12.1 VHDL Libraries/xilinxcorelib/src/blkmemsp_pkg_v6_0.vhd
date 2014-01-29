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
----------------------------------------------------------------------------
-- $Header: /devl/xcs/repo/env/Databases/ip/src/com/xilinx/ip/blkmemsp_v6_0/simulation/blkmemsp_pkg_v6_0.vhd,v 1.13 2008/09/08 20:06:40 akennedy Exp $
----------------------------------------------------------------------------
-- Block Memory Compiler VII :  Constant and function package
----------------------------------------------------------------------------
--                                                                       
-- This File is owned and controlled by Xilinx and must be used solely   
-- for design, simulation, implementation and creation of design files   
-- limited to Xilinx devices or technologies. Use with non-Xilinx        
-- devices or technologies is expressly prohibited and immediately       
-- terminates your license.                                              
--                                                                       
-- Xilinx products are not intended for use in life support              
-- appliances, devices, or systems. Use in such applications is          
-- expressly prohibited.                                                 
--                                                                       
--
----------------------------------------------------------------------------
-- Filename:  blkmemsp_pkg_v6_0.vhd
--      
-- Description:  
--            Defines the functions and constants needed for memory
--            partitioning.
--
----------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE blkmemsp_pkg_v6_0 IS

----------------------------------------------------------------------------
-- CONSTANT and TYPE DECLARATION
----------------------------------------------------------------------------

--------------- Define the family dependent constants  ---------------------
CONSTANT virtex         : INTEGER       := 1 ;
CONSTANT virtex2        : INTEGER       := 2 ;
CONSTANT v_index 	: INTEGER	:= 6 ;	--# of different port widths
                                                -- includes special single
                                                -- port case
CONSTANT vsp_index      : INTEGER       := 6 ;
CONSTANT v2_index	: INTEGER	:= 7 ;  --# of different port widths
                                                -- includes special single
                                                -- port case
CONSTANT v2sp_index     : INTEGER       := 7 ;
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
CONSTANT v2_depths	: v2_array	:= (16384, 8192, 4096, 2048, 1024, 512, 256) ;


-- Define some constants needed in the sim parameters for the block memory V2

CONSTANT c_write_first : INTEGER        := 0;
CONSTANT c_read_first  : INTEGER        := 1;
CONSTANT c_no_change   : INTEGER        := 2;
CONSTANT write_first_bits : STRING        := "WRITE_FIRST";
CONSTANT read_first_bits  : STRING        := "READ_FIRST";
CONSTANT no_change_bits   : STRING        := "NO_CHANGE";

--------- Define constants for memory initalization functions --------------
CONSTANT v2max_init_lines       : INTEGER := 64;
CONSTANT v2max_init_parity      : INTEGER := 8;
CONSTANT v2max_init_width       : INTEGER := 256;
CONSTANT vmax_init_lines : INTEGER := 16;
CONSTANT vmax_init_width : INTEGER := 256;

--------------- Define default value for top level generics ----------------
CONSTANT DEFAULT_FAMILY		: STRING := "virtex2";
CONSTANT DEFAULT_DEPTH 		: INTEGER := 1024;
CONSTANT DEFAULT_WIDTH 		: INTEGER := 16;
CONSTANT DEFAULT_ADD_WIDTH 	: INTEGER := 10;
CONSTANT DEFAULT_HAS_DIN 	: INTEGER := 1;
CONSTANT DEFAULT_MEM_INIT 	: STRING := "mif_file_16_1";
--CONSTANT DEFAULT_MEM_INIT_ARRAY : MEM_ARRAY;
CONSTANT DEFAULT_WRITE_MODE 	: INTEGER := c_write_first;
CONSTANT DEFAULT_PIPE_STAGES 	: INTEGER := 0;
CONSTANT DEFAULT_LIMIT_PITCH 	: INTEGER := 18;
CONSTANT DEFAULT_HAS_LIMIT_PITCH : INTEGER := 0;
CONSTANT DEFAULT_HAS_WE 	: INTEGER := 1;
CONSTANT DEFAULT_HAS_EN 	: INTEGER := 0;
CONSTANT DEFAULT_HAS_SINIT	: INTEGER := 0;
CONSTANT DEFAULT_SINIT_VALUE 	: STRING := "0000000000000000000";
CONSTANT DEFAULT_HAS_DOUT 	: INTEGER := 1;
CONSTANT DEFAULT_REG_INPUTS 	: INTEGER := 0;
CONSTANT DEFAULT_EN_RLOCS 	: INTEGER := 0;
CONSTANT DEFAULT_HAS_ND 	: INTEGER := 0;
CONSTANT DEFAULT_HAS_RFD 	: INTEGER := 0;
CONSTANT DEFAULT_HAS_RDY 	: INTEGER := 0;
CONSTANT DEFAULT_HAS_DEFAULT    : INTEGER := 1;
CONSTANT DEFAULT_DEFAULT_DATA   : STRING  := "0000000000000000000";
CONSTANT DEFAULT_EN_IS_HIGH     : INTEGER := 1;
CONSTANT DEFAULT_CLK_IS_RISING  : INTEGER := 1;
CONSTANT DEFAULT_PRIMITIVE_TYPE : STRING := "4kx4";
CONSTANT DEFAULT_SINIT_IS_HIGH  : INTEGER := 1;
CONSTANT DEFAULT_USE_SINGLE_PRIMITIVE : INTEGER := 0;
CONSTANT DEFAULT_WE_IS_HIGH     : INTEGER := 1;
CONSTANT DEFAULT_BOTTOM_ADDR    : STRING := "1024";
CONSTANT DEFAULT_HIERARCHY      : STRING := "hierarchy1";
CONSTANT DEFAULT_MAKE_BMM       : INTEGER := 0;
CONSTANT DEFAULT_TOP_ADDR       : STRING := "0";
CONSTANT DEFAULT_DISABLE_WARNINGS : INTEGER := 1;
----------------------------------------------------------------------------
-- FUNCTION DECLARATION
----------------------------------------------------------------------------

FUNCTION get_offset(width:INTEGER;has_limit_data_pitch: INTEGER; limit_data_pitch:INTEGER)
RETURN INTEGER;

FUNCTION slice_width_v2 (family: INTEGER; slice_start: INTEGER; ram_width: INTEGER; ram_depth: INTEGER; offset: INTEGER)
RETURN v2_array ;

FUNCTION slice_width_v(family:INTEGER;slice_start: INTEGER;ram_width: INTEGER; ram_depth:INTEGER; offset: INTEGER)
 RETURN v_array;

FUNCTION slice_depth_v2 (family: INTEGER; ram_depth: INTEGER; offset: INTEGER)
RETURN v2_array ;

FUNCTION slice_depth_v (family: INTEGER; ram_depth: INTEGER; offset: INTEGER)
  RETURN v_array;

FUNCTION find_total_blk_count_v2 (family: INTEGER; max_slice_width: INTEGER; ram_width: INTEGER; ram_depth: INTEGER; offset: INTEGER)
RETURN INTEGER ;

FUNCTION find_total_blk_count_v (family: INTEGER; max_slice_width: INTEGER; ram_width: INTEGER; ram_depth: INTEGER; offset: INTEGER)
RETURN INTEGER ;

FUNCTION find_start_slice_width_v2 (family: INTEGER; ram_width: INTEGER ; ram_depth: INTEGER ; is_single_port : INTEGER; offset: INTEGER)
RETURN INTEGER ;

FUNCTION find_start_slice_width_v (family: INTEGER; ram_width: INTEGER ; ram_depth: INTEGER ; is_single_port : INTEGER; offset: INTEGER)
RETURN INTEGER ;

FUNCTION iterate_opt_slice_width_v2 (ram_width: INTEGER; ram_depth: INTEGER; index_start_slice: INTEGER; current_array: v2_array; offset: INTEGER)
RETURN v2_array;

FUNCTION iterate_opt_slice_width_v (ram_width: INTEGER; ram_depth: INTEGER; index_start_slice: INTEGER; current_array:v_array; offset: INTEGER)
RETURN v_array;

FUNCTION find_min_blk_count_v2 (family: INTEGER; ram_width: INTEGER ; ram_depth: INTEGER; offset: INTEGER)
RETURN INTEGER ;

FUNCTION find_min_blk_count_v (family: INTEGER; ram_width: INTEGER ; ram_depth: INTEGER; offset: INTEGER)
RETURN INTEGER ;

FUNCTION find_min_blk_count (family: INTEGER; ram_width: INTEGER ; ram_depth: INTEGER; offset: INTEGER)
RETURN INTEGER ;

FUNCTION find_result_delay(c_reg_inputs: INTEGER; c_pipe_stages: INTEGER)
RETURN INTEGER;

-------------------Functions for GUI----------------------------------------

FUNCTION find_max_depth(family: STRING; width: INTEGER)
RETURN INTEGER;

FUNCTION find_num_blk_used (family: STRING; width: INTEGER; depth: INTEGER; has_limit_data_pitch: INTEGER; limit_data_pitch: INTEGER)
RETURN INTEGER;

END blkmemsp_pkg_v6_0 ;

----------------------------------------------------------------------------
-- Definition of functions
----------------------------------------------------------------------------
--  1.  get_offset(width:INTEGER;has_limit_data_pitch:INTEGER;
--      limit_data_pitch:INTEGER)
--      Given width_a and width_b, returns the corresponding offset for the
--      block RAM implementation algorithm.
--
--  7.	slice_width_v2 (family: INTEGER; slice_start: INTEGER; ram_width: 
--	INTEGER; ram_depth: INTEGER; offset: INTEGER)
--	Returns an array containing number of Block RAMs needed to achieve
--      a width of ram_width. This array uses the least number of block
--      RAMs given index_start_slice. Note that this function calls find_
--      optimized_slice_width_v2().
--
--  8.	slice_width_v (family: INTEGER; slice_start: INTEGER; ram_width: 
--	INTEGER; ram_depth: INTEGER; offset: INTEGER)
--	Returns an array containing number of Block RAMs needed to achieve
--      a width of ram_width. This array uses the least number of block
--      RAMs given index_start_slice. Note that this function calls find_
--      optimized_slice_width_v().
--
--  9.	slice_depth_v2 (family: INTEGER; ram_depth: INTEGER; offset: INTEGER)
--	Returns an array containing number of Block RAMs needed to achieve
--	a depth of ram_depth.
--
-- 10.	slice_depth_v (family: INTEGER; ram_depth: INTEGER; offset: INTEGER)
--	Returns an array containing number of Block RAMs needed to achieve
--	a depth of ram_depth.
--
-- 11.  find_total_blk_count_v2 (family: INTEGER; max_slice_width: INTEGER;
--      ram_width: INTEGER; ram_depth: INTEGER; offset: INTEGER)
--      Given the relevant info, returns the total Block RAM count.
--
-- 12.  find_total_blk_count_v (family: INTEGER; max_slice_width: INTEGER;
--      ram_width: INTEGER; ram_depth: INTEGER; offset: INTEGER)
--      Given the relevant info, returns the total Block RAM count.
--
--
-- 14.	find_start_slice_width_v2 (family: INTEGER; ram_width: INTEGER ; 
--	ram_depth: INTEGER; is_single_port: INTEGER; offset: INTEGER)	
--	Given memory width and depth, returns which primitive should you use
--	to start the algorithm.
--
-- 15.	find_start_slice_width_v (family: INTEGER; ram_width: INTEGER ; 
--	ram_depth: INTEGER; is_single_port: INTEGER; offset: INTEGER)	
--	Given memory width and depth, returns which primitive should you use
--	to start the algorithm.
--
-- 16.  iterate_opt_slice_width_v2(ram_width: INTEGER; ram_depth: INTEGER;
--      index_start_slice: INTEGER; current_array: v2_array; offset: INTEGER)
--      Given memory width and depth, returns an array containing number of
--      Block RAMs needed to achieve a width of ram_width.  This array uses 
--      the least number of block RAMs given index_start_slice.  Note that 
--      this function calls slice_width_v2.
--
-- 17.  iterate_opt_slice_width_v(ram_width: INTEGER; ram_depth: INTEGER;
--      index_start_slice: INTEGER; current_array: v_array; offset: INTEGER)
--      Given memory width and depth, returns an array containing number of
--      Block RAMs needed to achieve a width of ram_width.  This array uses 
--      the least number of block RAMs given index_start_slice.  Note that 
--      this function calls slice_width_v.
--
-- 18.  find_min_blk_count_v2 (family: INTEGER; ram_width: INTEGER ; 
--      ram_depth: INTEGER; offset: INTEGER)
--	Returns the minimum Block RAM count for a particular ram_width 
--      and ram_depth.		
--
-- 19.  find_min_blk_count_v (family: INTEGER; ram_width: INTEGER ; 
--      ram_depth: INTEGER; offset: INTEGER)
--      Returns the minimum Block RAM count for a particular ram_width 
--      and ram_depth.		
--
-- 20.  find_min_blk_count (family: INTEGER; ram_width: INTEGER ; 
--      ram_depth: INTEGER; offset: INTEGER)
--	Returns the minimum Block RAM count for a particular ram_width 
--      and ram_depth.		
--
-- 28.  find_result_delay(c_reg_inputs: INTEGER; c_pipe_stages: INTEGER)
--      Returns the core's input to output delay.
--
-- 38.  find_max_depth(family: STRING; width: INTEGER)
--      Returns the max depth given the width and the family.
--
-- 39.  find_num_blk_used(family: STRING; width: INTEGER; depth: INTEGER; 
--      has_limit_data_pitch: INTEGER; limit_data_pitch: INTEGER)
--      Returns the number of blocks used to create the memory needed.
----------------------------------------------------------------------------


PACKAGE BODY blkmemsp_pkg_v6_0 IS

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

FUNCTION get_offset(width:INTEGER;has_limit_data_pitch:INTEGER; limit_data_pitch:INTEGER)
RETURN INTEGER IS
  VARIABLE offset: INTEGER := 0;
BEGIN  --get_offset
  IF (has_limit_data_pitch = 1) THEN
    IF ((limit_data_pitch = 16) OR (limit_data_pitch = 36)) THEN
      offset := 1;
    ELSIF ((limit_data_pitch = 8) OR (limit_data_pitch = 18)) THEN
      offset := 2;
    END IF;
  ELSE
    offset := 0;
  END IF; 
  RETURN offset;
END get_offset;

----------------------------------------------------------------------------
-- FUNCTION : slice_(the_)width_v2
-- Returns an optimized array containing number of Block RAMs needed to achieve
-- a width of ram_width.		   
----------------------------------------------------------------------------
FUNCTION slice_width_v2 ( family     : INTEGER ; 
			  slice_start: INTEGER ; 
			  ram_width  : INTEGER ; 
			  ram_depth  : INTEGER ;
                          offset     : INTEGER
                        )
RETURN v2_array IS
  --widths are{1,2,4,9,18,36,72} respectively
  VARIABLE slice_array 	: v2_array	:= (0,0,0,0,0,0,0) ;	
  VARIABLE remainder 	: INTEGER	:= 0 ;
  VARIABLE slice_width	: INTEGER	:= 0 ;
  VARIABLE i            : INTEGER       := offset ;
  VARIABLE finish       : INTEGER       := 0 ;
BEGIN

  remainder := ram_width;

  -- iterate through all the possible primitive widths
  -- and while the flag "finish" is invalid
  WHILE (i < v2_index) and (finish = 0) LOOP
    slice_width := v2_widths(i) ;
    
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
          slice_array := iterate_opt_slice_width_v2(remainder, ram_depth, i, slice_array,offset);
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
END slice_width_v2 ;


----------------------------------------------------------------------------
-- FUNCTION : slice_(the_)width_v
-- Returns an optimized array containing number of Block RAMs needed to achieve
-- a width of ram_width.		   
----------------------------------------------------------------------------
FUNCTION slice_width_v ( family     : INTEGER ; 
			 slice_start: INTEGER ; 
			 ram_width  : INTEGER ; 
			 ram_depth  : INTEGER ;
                         offset     : INTEGER
                        )
RETURN v_array IS
  --widths are{1,2,4,8,16,32} respectively
  VARIABLE slice_array 	: v_array	:= (0,0,0,0,0,0) ;	
  VARIABLE remainder 	: INTEGER	:= 0 ;
  VARIABLE slice_width	: INTEGER	:= 0 ;
  VARIABLE i            : INTEGER       := offset ;
  VARIABLE finish       : INTEGER       := 0 ;
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
-- FUNCTION : iterate_opt_slice_(the_)width_v2
-- Returns an array containing an optimized number of Block RAMs needed to
-- achieve width of ram_width.		   
----------------------------------------------------------------------------
FUNCTION iterate_opt_slice_width_v2( ram_width         : INTEGER ;
                                     ram_depth         : INTEGER ;
                                     index_start_slice : INTEGER ;
                                     current_array     : v2_array ;
                                     offset            : INTEGER
                                   )
RETURN v2_array IS
  CONSTANT depth_array : v2_array := slice_depth_v2(virtex2, ram_depth,offset) ;
  VARIABLE start_width      : INTEGER  := 0 ;
  VARIABLE best_width       : INTEGER  := 0 ;
  VARIABLE best_blocks      : INTEGER  := 99999 ; -- arbritary large number
  VARIABLE best_width_array : v2_array := (0,0,0,0,0,0,0) ;
  VARIABLE width_array      : v2_array := (0,0,0,0,0,0,0) ;
  VARIABLE total_blocks     : INTEGER  := 0 ; 
BEGIN

  -- start iterating from the last index used to the max index value
  FOR i IN index_start_slice TO (v2_index-1) LOOP
    start_width := v2_widths(i);
    -- find the optimized width_array associated with the start width
    width_array  := slice_width_v2(virtex2, start_width, ram_width, ram_depth,offset);

    -- calculate number of blocks used for this array
    total_blocks := 0;
    FOR j  IN 0 TO (v2_index-1) LOOP
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
-- FUNCTION : iterate_opt_slice_(the_)width_v2
-- Returns an array containing an optimized number of Block RAMs needed to
-- achieve width of ram_width.		   
----------------------------------------------------------------------------
FUNCTION iterate_opt_slice_width_v( ram_width         : INTEGER ;
                                    ram_depth         : INTEGER ;
                                    index_start_slice : INTEGER ;
                                    current_array     : v_array ;
                                    offset            : INTEGER
                                  )
RETURN v_array IS
  CONSTANT depth_array      : v_array := slice_depth_v(virtex, ram_depth, offset);
  VARIABLE start_width      : INTEGER := 0 ;
  VARIABLE best_width       : INTEGER := 0 ;
  VARIABLE best_blocks      : INTEGER := 99999 ; -- arbritary large number
  VARIABLE best_width_array : v_array := (0,0,0,0,0,0) ;
  VARIABLE width_array      : v_array := (0,0,0,0,0,0) ;
  VARIABLE total_blocks     : INTEGER := 0 ; 
BEGIN

  -- start iterating from the last index used to the max index value
  FOR i IN index_start_slice TO (v_index-1) LOOP
    start_width := v_widths(i);
    -- find the optimized width_array associated with the start width
    width_array  := slice_width_v(virtex, start_width, ram_width, ram_depth,offset);

    -- calculate number of blocks used for this array
    total_blocks := 0;
    FOR j  IN 0 TO (v_index-1) LOOP
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

END iterate_opt_slice_width_v;


----------------------------------------------------------------------------
-- FUNCTION : slice_(the_)depth_v2
-- Returns an array containing number of Block RAMs needed to achieve
-- a depth of ram_depth.                                           
----------------------------------------------------------------------------
FUNCTION slice_depth_v2 ( family    : INTEGER ; 
                          ram_depth : INTEGER ; 
                          offset    : INTEGER
                        )
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
-- FUNCTION : slice_(the_)depth_v
-- Returns an array containing number of Block RAMs needed to achieve
-- a depth of ram_depth.                                           
----------------------------------------------------------------------------
FUNCTION slice_depth_v ( family    : INTEGER ; 
                         ram_depth : INTEGER ; 
                         offset    : INTEGER
                       )
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
-- FUNCTION : find_total_blk_count(_v2)
-- Given the relevant info, returns the total Block RAM count.
----------------------------------------------------------------------------
FUNCTION find_total_blk_count_v2 ( family          : INTEGER ;
				   max_slice_width : INTEGER ;
				   ram_width       : INTEGER ;   
				   ram_depth       : INTEGER ;
                                   offset          : INTEGER
                                )
RETURN INTEGER IS
  CONSTANT slice_array 	: v2_array	:= slice_width_v2 (family, max_slice_width, ram_width, ram_depth,offset) ;
  CONSTANT block_count	: v2_array	:= slice_depth_v2 (family, ram_depth,offset) ;
  VARIABLE total_blocks	: INTEGER	:= 0 ;
BEGIN
  FOR i IN 0 TO (v2_index-1) LOOP
    total_blocks	:= total_blocks + (slice_array(i) * block_count(i)) ;
  END LOOP ;
  RETURN total_blocks ;
END find_total_blk_count_v2 ;


----------------------------------------------------------------------------
-- FUNCTION : find_total_blk_count(_v)
-- Given the relevant info, returns the total Block RAM count.
----------------------------------------------------------------------------
FUNCTION find_total_blk_count_v ( family          : INTEGER ;
				  max_slice_width : INTEGER ;
				  ram_width       : INTEGER ;   
				  ram_depth       : INTEGER ;
                                  offset          : INTEGER
                                )
RETURN INTEGER IS
  CONSTANT slice_array 	: v_array	:= slice_width_v (family, max_slice_width, ram_width, ram_depth,offset) ;
  CONSTANT block_count	: v_array	:= slice_depth_v (family, ram_depth,offset) ;
  VARIABLE total_blocks	: INTEGER	:= 0 ;
BEGIN
  FOR i IN 0 TO (v_index-1) LOOP
    total_blocks	:= total_blocks + (slice_array(i) * block_count(i)) ;
  END LOOP ;
  RETURN total_blocks ;
END find_total_blk_count_v ;

----------------------------------------------------------------------------
-- FUNCTION : find_start_slice_width(_v2)
-- Given memory width and depth, returns which primitive should you use
-- to start the algorithm.*    	    
----------------------------------------------------------------------------
FUNCTION find_start_slice_width_v2 ( family         : INTEGER ;
				     ram_width      : INTEGER ;   
				     ram_depth      : INTEGER ;
                                     is_single_port : INTEGER ;
                                     offset         : INTEGER
                                   )
RETURN INTEGER IS
  VARIABLE start_width	  : INTEGER := 0 ;
  VARIABLE best_width	  : INTEGER := 0 ;	
  VARIABLE total_blocks	  : INTEGER := 0 ;
  VARIABLE best_blocks	  : INTEGER := 99999 ;	--arbitrary large #
  VARIABLE v2_index_start : INTEGER := 0;
BEGIN
  IF (is_single_port = 1) THEN
    v2_index_start := 0;
  ELSE
    v2_index_start := 1;
  END IF;
  
  FOR i IN v2_index_start TO (v2_index-1) LOOP
    start_width	:= v2_widths(i) ;
    total_blocks:= find_total_blk_count_v2(family, start_width, ram_width, ram_depth,offset) ;
    IF (total_blocks <= best_blocks) THEN
      best_blocks 	:= total_blocks ;
      best_width	:= start_width ;
    END IF ;
  END LOOP ;
  RETURN best_width ;
END find_start_slice_width_v2 ;


----------------------------------------------------------------------------
-- FUNCTION : find_start_slice_width(_v)
-- Given memory width and depth, returns which primitive should you use
-- to start the algorithm.*    	    
----------------------------------------------------------------------------
FUNCTION find_start_slice_width_v ( family         : INTEGER ;
				    ram_width      : INTEGER ;   
				    ram_depth      : INTEGER ;
                                    is_single_port : INTEGER ;
                                    offset         : INTEGER
                                  )
RETURN INTEGER IS
  VARIABLE start_width	 : INTEGER := 0 ;
  VARIABLE best_width	 : INTEGER := 0 ;	
  VARIABLE total_blocks	 : INTEGER := 0 ;
  VARIABLE best_blocks	 : INTEGER := 99999 ;	--arbitrary large #
  VARIABLE v_index_start : INTEGER := 0;
BEGIN
  IF (is_single_port = 1) THEN
    v_index_start := 0;
  ELSE
    v_index_start := 1;
  END IF;
  
  FOR i IN v_index_start TO (v_index-1) LOOP
    start_width	:= v_widths(i) ;
    total_blocks:= find_total_blk_count_v(family, start_width, ram_width, ram_depth,offset) ;
    IF (total_blocks <= best_blocks) THEN
      best_blocks 	:= total_blocks ;
      best_width	:= start_width ;
    END IF ;
  END LOOP ;
  RETURN best_width ;
END find_start_slice_width_v ;


----------------------------------------------------------------------------
-- FUNCTION : find_min_blk_count(_v2)      	    
-- Returns the minimum Block RAM count for a particular ram_width and 
-- ram_depth.		
----------------------------------------------------------------------------
FUNCTION find_min_blk_count_v2 ( family    : INTEGER ;
			         ram_width : INTEGER ;   
			         ram_depth : INTEGER ;
                                 offset    : INTEGER
                               )
RETURN INTEGER IS
  CONSTANT best_width : INTEGER := find_start_slice_width_v2(virtex2, ram_width, ram_depth, 1, offset);
  CONSTANT width_array : v2_array := slice_width_v2(virtex2,best_width,ram_width,ram_depth,offset);
  CONSTANT depth_array : v2_array := slice_depth_v2(virtex2,ram_depth, offset);
  VARIABLE total_blocks : INTEGER := 0;
BEGIN

  FOR i IN 0 TO (v2_index-1) LOOP
    total_blocks	:= total_blocks + (width_array(i) * depth_array(i)) ;
  END LOOP ;
  RETURN total_blocks ;

END find_min_blk_count_v2 ;


----------------------------------------------------------------------------
-- FUNCTION : find_min_blk_count(_v2)      	    
-- Returns the minimum Block RAM count for a particular ram_width and 
-- ram_depth.		
----------------------------------------------------------------------------
FUNCTION find_min_blk_count_v ( family    : INTEGER ;
			        ram_width : INTEGER ;   
			        ram_depth : INTEGER ;
                                offset    : INTEGER
                              )
RETURN INTEGER IS
  CONSTANT best_width : INTEGER := find_start_slice_width_v(virtex,ram_width,ram_depth,1,offset);
  CONSTANT width_array : v_array := slice_width_v(virtex,best_width,ram_width,ram_depth,offset);
  CONSTANT depth_array : v_array := slice_depth_v(virtex,ram_depth,offset);
  VARIABLE total_blocks	: INTEGER := 0 ;
BEGIN
  FOR i IN 0 TO (v_index-1) LOOP
    total_blocks	:= total_blocks + (width_array(i) * depth_array(i)) ;
  END LOOP ;
  RETURN total_blocks ;
END find_min_blk_count_v ;


----------------------------------------------------------------------------
-- FUNCTION : find_min_blk_count(_v2)      	    
-- Returns the minimum Block RAM count for a particular ram_width and 
-- ram_depth.		
----------------------------------------------------------------------------
FUNCTION find_min_blk_count ( family    : INTEGER ;
			      ram_width : INTEGER ;   
			      ram_depth : INTEGER ;
                              offset    : INTEGER 
                            )
RETURN INTEGER IS
  VARIABLE blk_count : INTEGER := 0;
BEGIN
  IF (family=virtex) THEN
    blk_count:= find_min_blk_count_v(virtex, ram_width, ram_depth, offset);
  ELSE
    blk_count:= find_min_blk_count_v2(virtex2, ram_width, ram_depth, offset);
  END IF;
  
RETURN blk_count;
END find_min_blk_count ;

----------------------------------------------------------------------------
-- FUNCTION : find_result_delay
-- Returns the core's input to output delay.
----------------------------------------------------------------------------
FUNCTION find_result_delay( c_reg_inputs  : INTEGER ; 
                            c_pipe_stages : INTEGER
                          )
RETURN INTEGER IS
  VARIABLE result_delay : INTEGER := 0 ;
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

----------------------------------------------------------------------------
-- FUNCTION: find_max_depth 
-- Returns the maximum depth of a memory given the width and family.
----------------------------------------------------------------------------
FUNCTION find_max_depth( family : STRING ; 
                         width  : INTEGER
                       )
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
-- Find the number of RAM blocks used to make this memory
---------------------------------------------------------------------------
FUNCTION find_num_blk_used ( family               : STRING  ;
                             width                : INTEGER ;
                             depth                : INTEGER ; 
                             has_limit_data_pitch : INTEGER ; 
                             limit_data_pitch     : INTEGER
                           )
RETURN INTEGER IS
  VARIABLE blk_count :INTEGER := 0 ;
  VARIABLE offset    :INTEGER := 0 ;
BEGIN
  offset := get_offset(width,has_limit_data_pitch,limit_data_pitch);
  IF family="virtex2" THEN
    blk_count := find_min_blk_count_v2(virtex2,width,depth,offset);
  ELSE--family is virtex
    blk_count := find_min_blk_count_v(virtex,width,depth,offset);
  END IF;
  RETURN blk_count;
END find_num_blk_used;

END blkmemsp_pkg_v6_0;



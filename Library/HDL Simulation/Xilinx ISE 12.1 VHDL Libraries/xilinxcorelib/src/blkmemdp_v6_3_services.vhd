-----------------------------------------------------------------------------
-- $RCSfile: blkmemdp_v6_3_services.vhd,v $
----------------------------------------------------------------------------
-- Block Memory Compiler VII : Intelligent Function Package
----------------------------------------------------------------------------
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
----------------------------------------------------------------------------
-- Filename:  blkmemdp_v6_3_services.vhd
--      
-- Description:  
--            Defines the intelligent functions 
--
----------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE blkmemdp_v6_3_services IS

----------------------------------------------------------------------------
-- CONSTANT and TYPE DECLARATION
----------------------------------------------------------------------------

CONSTANT min_depth_limit    : INTEGER := 2;
CONSTANT min_width_limit    : INTEGER := 1;
CONSTANT max_depth_limit_v  : INTEGER := 262144;
CONSTANT max_depth_limit_v2 : INTEGER := 1048576;
CONSTANT max_width_limit    : INTEGER := 256;

--Output Types
TYPE PORT_A_RANGE IS ARRAY (1 DOWNTO 0) OF INTEGER;
TYPE PORT_B_RANGE IS ARRAY (5 DOWNTO 0) OF INTEGER;
----------------------------------------------------------------------------
-- FUNCTION DECLARATION
----------------------------------------------------------------------------
FUNCTION RuP2 (number: INTEGER)
RETURN INTEGER;

FUNCTION RdP2 (number: INTEGER)
RETURN INTEGER;

FUNCTION getDepthRangeForWidthV (width:INTEGER)
RETURN PORT_A_RANGE;

FUNCTION getDepthRangeForWidthV2 (width:INTEGER)
RETURN PORT_A_RANGE;

FUNCTION getWidthRangeForDepthV (depth: INTEGER)
RETURN PORT_A_RANGE;

FUNCTION getWidthRangeForDepthV2 (depth: INTEGER)
RETURN PORT_A_RANGE ;

FUNCTION getWidthOptionForBV (width_a: INTEGER; depth_a: INTEGER)
RETURN PORT_B_RANGE ;

FUNCTION getWidthOptionForBV2 (width_a: INTEGER; depth_a: INTEGER)
RETURN PORT_B_RANGE ;


END blkmemdp_v6_3_services ;

----------------------------------------------------------------------------
-- Definition of functions
----------------------------------------------------------------------------
--  1.  FUNCTION RuP2 (number:INTEGER)
--      Given an integer, rounds up the given integer to the nearest
--      power of two.  Then returns that new value.
--
--  2.  FUNCTION RdP2 (number:INTEGER)
--      Given an integer, rounds down that given integer to the nearest
--      power of two.  Then returns that new value.
--
--  3.  FUNCTION getDepthRangeForWidthV (width:INTEGER)
--      Given width for port A, returns a lower and upper limits of
--      range for the port A depth.  For Virtex and VirtexE.
--      Zeros returned when invalid width is given.
--
--  4.  FUNCTION getDepthRangeForWidthV2 (width:INTEGER)
--      Given width for port A, returns a lower and upper limits of
--      range for the port A depth.  For VirtexII and VirtexII Pro.
--      Zeros returned when invalid width is given.
--
--  5.  FUNCTION getWidthRangeForDepthV (depth: INTEGER)
--      Given depth for port A, returns a lower and upper limits of
--      range for the port A width.  For Virtex and VirtexE.
--      Zeros returned when invalid depth is given.
--
--  6.  FUNCTION getWidthRangeForDepthV2 (depth: INTEGER)
--      Given depth for port A, returns a lower and upper limits of
--      range for the port A width.  For VirtexII and VirtexII Pro.
--      Zeros returned when invalid depth is given.
--
--  7.  FUNCTION getWidthRangeForBV (widthA: INTEGER; depthA: INTEGER)
--      Given width and depth of port A, returns list of possible
--      width values for port B.  For Virtex and VirtexE.
--      Empty locations in the return array is filled with zeros.
--
--  8.  FUNCTION getWidthRangeForBV2 (widthA: INTEGER; depthA: INTEGER)
--      Given width and depth of port A, returns list of possible
--      width values for port B.  For VirtexII and VirtexII Pro.
--      Empty locations in the return array is filled with zeros.
-------------------------------------------------------------------------------

PACKAGE BODY blkmemdp_v6_3_services IS

-------------------------------------------------------------------------------
-- FUNCTION: RuP2:
-- Round up to the nearest power of 2
-------------------------------------------------------------------------------

FUNCTION RuP2 (number: INTEGER)
RETURN INTEGER IS
  VARIABLE p2 : INTEGER := 1;           -- power of 2

BEGIN
  WHILE p2 < number LOOP
    p2 := p2 * 2;
  END LOOP;
  RETURN p2;
END RuP2;

-------------------------------------------------------------------------------
-- FUNCTION: RdP2
-- Round down to the nearest power of 2
-------------------------------------------------------------------------------

FUNCTION RdP2 (number: INTEGER)
RETURN INTEGER IS
  VARIABLE p2 : INTEGER := 1;           -- power of 2

BEGIN
  WHILE (p2 <= number) LOOP
    p2 := p2 * 2;
  END LOOP;
  p2 := p2 / 2;
  RETURN p2;
END RdP2;


-------------------------------------------------------------------------------
-- FUNCTION: DPgetDepthRangeForWidthV
-- When provided with the width of port a, returns available depth range 
-- for port a. (Virtex)
-------------------------------------------------------------------------------

FUNCTION getDepthRangeForWidthV (width:INTEGER)
RETURN PORT_A_RANGE IS
  VARIABLE depth_range : PORT_A_RANGE := (0, 0);
  VARIABLE max_depth : INTEGER := 0;
 
BEGIN  --Get Max Depth

  ASSERT (width >= min_width_limit AND  width <= max_width_limit)
  REPORT "Unsupported Memory Width" SEVERITY ERROR;
  IF (width < min_width_limit OR  width > max_width_limit) THEN
    depth_range := (0, 0);
  ELSE
    max_depth := ((256 * 1024 * 3) / width);
    IF max_depth < max_depth_limit_v  THEN
      depth_range := (min_depth_limit, max_depth);
    ELSE
      depth_range := (min_depth_limit, max_depth_limit_v);
    END IF;  
  END IF;  
  RETURN depth_range;
END getDepthRangeForWidthV;

-------------------------------------------------------------------------------
-- FUNCTION: DPgetDepthRangeForWidthV2
-- When provided with the width of port a, returns available depth range 
-- for port a. (Virtex2)
-------------------------------------------------------------------------------

FUNCTION getDepthRangeForWidthV2 (width:INTEGER)
RETURN PORT_A_RANGE IS
  VARIABLE depth_range : PORT_A_RANGE := (0, 0);
  VARIABLE max_depth : INTEGER := 0;
 
BEGIN  --Get Max Depth
  
  ASSERT (width >= min_width_limit AND width <= max_width_limit)
  REPORT "Unsupported Memory Width" SEVERITY ERROR;
  IF (width < min_width_limit OR width > max_width_limit) THEN
    depth_range := (0, 0);
  ELSE
    max_depth := RdP2((1024 * 1024 * 3)/width);
    IF max_depth < max_depth_limit_v2 THEN
      depth_range := (min_depth_limit, max_depth);
    ELSE
      depth_range := (min_depth_limit, max_depth_limit_v2);
    END IF;
  END IF;
  RETURN depth_range;
END getDepthRangeForWidthV2;

-------------------------------------------------------------------------------
-- FUCNTION: DPgetWidthRangeForDepthV
-- When provided with the depth of port b, returns available width range
-- for port a. (Virtex)
-------------------------------------------------------------------------------

FUNCTION getWidthRangeForDepthV (depth : INTEGER)
RETURN PORT_A_RANGE IS
  VARIABLE width_range : PORT_A_RANGE := (0, 0);
  VARIABLE max_width : INTEGER := 0;
  
BEGIN  -- DPgetWidthRangeForDepthV

  ASSERT (depth >= min_depth_limit AND depth <= max_depth_limit_v)
  REPORT "Unsupported Memory Depth" SEVERITY ERROR;
  IF (depth < min_depth_limit OR depth > max_depth_limit_v) THEN
    width_range := (0, 0);
  ELSE
     max_width := (256 * 1024 * 3) / (RuP2(depth));
     IF  max_width > max_width_limit THEN
       width_range := (min_width_limit, max_width_limit);
     ELSE
       width_range := (min_width_limit, max_width);
     END IF;
  END IF;   
  RETURN width_range;
END getWidthRangeForDepthV;

-------------------------------------------------------------------------------
-- FUCNTION: DPgetWidthRangeForDepthV2
-- When provided with the depth of port b, returns available width range
-- for port a. (Virtex2)
-------------------------------------------------------------------------------

FUNCTION getWidthRangeForDepthV2 (depth : INTEGER)
RETURN PORT_A_RANGE IS
  VARIABLE width_range : PORT_A_RANGE := (0, 0);
  VARIABLE max_width : INTEGER := 0;
  
BEGIN  -- DPgetWidthRangeForDepthV2

  ASSERT (depth >= min_depth_limit AND depth <= max_depth_limit_v2)
  REPORT "Unsupported Memory Depth" SEVERITY ERROR;
  IF (depth < min_depth_limit OR depth > max_depth_limit_v2) THEN
    width_range := (0, 0);
  ELSE
     max_width := (1024 * 1024 * 3) / (RuP2(depth));
     IF max_width > max_width_limit THEN
       width_range := (min_width_limit, max_width_limit);
     ELSE
       width_range := (min_width_limit, max_width);
     END IF;
  END IF;   
  RETURN width_range;
END getWidthRangeForDepthV2;

-------------------------------------------------------------------------------
-- FUNCTION : DPgetWidthOptionForBV
-- When provided with the width and depth of the port A, returns the
-- possible widths for port b(virtex)
-------------------------------------------------------------------------------

FUNCTION getWidthOptionForBV (width_a : INTEGER;depth_a : INTEGER)
RETURN PORT_B_RANGE IS
  VARIABLE width_b_range : PORT_B_RANGE := (0,0,0,0,0,0);
  VARIABLE memory : INTEGER := width_a * depth_a;

BEGIN  -- DPgetWidthRangeForB

  ASSERT (width_a >= min_width_limit AND width_a <= max_width_limit) AND
         (depth_a >= min_depth_limit AND depth_a <= max_depth_limit_v)
  REPORT "Unsupported Memory Configuration" SEVERITY ERROR;
  IF (width_a < min_width_limit OR width_a > max_width_limit OR
      depth_a < min_depth_limit OR depth_a > max_depth_limit_v)  THEN
    width_b_range := (0, 0, 0, 0, 0, 0);
  ELSE
    FOR i IN 4 DOWNTO 0 LOOP
      IF (((width_a * (2**i)) < memory) AND ((width_a * (2**i)) <= max_width_limit)) THEN
        width_b_range(i) := width_a * (2**i);
      END IF;
    END LOOP;
  END IF;  
  RETURN width_b_range;
END getWidthOptionForBV;

-------------------------------------------------------------------------------
-- FUNCTION : DPgetWidthOptionForBV2
-- When provided with the width and depth of the port A, returns the
-- possible widths for port b(virtex2)
-------------------------------------------------------------------------------
FUNCTION getWidthOptionForBV2 (width_a : INTEGER;depth_a : INTEGER)
RETURN PORT_B_RANGE IS
  VARIABLE width_b_range : PORT_B_RANGE := (0,0,0,0,0,0);
  VARIABLE memory : INTEGER := width_a * depth_a;

BEGIN  -- DPgetWidthRangeForB

  ASSERT (width_a >= min_width_limit AND width_a <= max_width_limit) AND
         (depth_a >= min_depth_limit AND depth_a <= max_depth_limit_v2)
  REPORT "Unsupported Memory Configuration" SEVERITY ERROR;
  IF (width_a < min_width_limit OR width_a > max_width_limit OR
      depth_a < min_depth_limit OR depth_a > max_depth_limit_v2)  THEN
   width_b_range := (0, 0, 0, 0, 0, 0);
  ELSE
    FOR i IN 5 DOWNTO 0 LOOP
      IF (((width_a * (2**i)) < memory) AND ((width_a * (2**i)) <= max_width_limit)) THEN
        width_b_range(i) := width_a * (2**i);
      END IF;
    END LOOP;
  END IF;  
  RETURN width_b_range;
END getWidthOptionForBV2;

END blkmemdp_v6_3_services;

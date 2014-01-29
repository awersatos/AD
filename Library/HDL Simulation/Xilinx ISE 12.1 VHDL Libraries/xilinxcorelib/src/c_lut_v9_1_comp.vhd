-- $RCSfile: c_lut_v9_1_comp.vhd,v $ $Revision: 1.7 $ $Date: 2008/09/08 19:36:47 $
--------------------------------------------------------------------------------
--  Copyright(C) 2006 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2006 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 9.0
--  \   \        Filename: c_lut_v9_1_comp.vhd 
--  /   /        
-- /___/   /\    
-- \   \  /  \
--  \___\/\___\
-- 
-------------------------------------------------------------------------------
--
-- Description - This file contains the component declaration for
-- the c_lut_v9_1 core

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE c_lut_v9_1_comp IS

  -- c_family is required so that generatecore will work correctly
  
  COMPONENT c_lut_v9_1
    GENERIC (
      eqn            : STRING  := "I0*I1*I2*I3";  -- Function of the LUT as an equation
      c_init         : INTEGER := 0;  -- Function of the LUT as a decimal integer of the INIT string
      c_enable_rlocs : INTEGER := 0);
    PORT (
      i0 : IN  STD_LOGIC;
      i1 : IN  STD_LOGIC := '0';
      i2 : IN  STD_LOGIC := '0';
      i3 : IN  STD_LOGIC := '0';
      i4 : IN  STD_LOGIC := '0';
      i5 : IN  STD_LOGIC := '0';
      o  : OUT STD_LOGIC);
  END COMPONENT;
  -- The following tells XST that c_lut_v9_1 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type                        : STRING;
  ATTRIBUTE generator_default               : STRING;
  ATTRIBUTE box_type OF c_lut_v9_1          : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF c_lut_v9_1 : COMPONENT IS "generatecore com.xilinx.ip.c_lut_v9_1.c_lut_v9_1";
  -- xcc include

END PACKAGE c_lut_v9_1_comp;

-- $Header
--
--  Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Component statement for behavioral model
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE sdivider_v4_0_comp IS

  --core_if on component no_coregen_specials
  component sdivider_v4_0
    GENERIC (
      c_has_aclr : INTEGER :=  0;
      c_has_ce : INTEGER :=  0;
      c_has_sclr : INTEGER :=  0;
      c_sync_enable : INTEGER :=  0;
      divclk_sel : INTEGER :=  1;
      dividend_width : INTEGER :=  8;
      divisor_width : INTEGER :=  8;
      fractional_b : INTEGER :=  0;
      fractional_width : INTEGER :=  8;
      signed_b : INTEGER :=  0
      );
    PORT (
      Dividend : IN STD_LOGIC_VECTOR (Dividend_Width -1 DOWNTO 0) := (others => '0');
      Divisor : IN STD_LOGIC_VECTOR (Divisor_Width -1 DOWNTO 0) := (others => '0');
      Quot : OUT STD_LOGIC_VECTOR (Dividend_Width -1 DOWNTO 0);
      Remd : OUT STD_LOGIC_VECTOR (Fractional_Width -1 DOWNTO 0);
      clk : IN STD_LOGIC := '0';
      rfd : OUT STD_LOGIC;
      aclr : IN STD_LOGIC := '0';
      sclr : IN STD_LOGIC := '0';
      ce : IN STD_LOGIC := '0'         
      );
  end component;

  --core_if off
  -- The following tells XST that sdivider_v4_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF sdivider_v4_0 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF sdivider_v4_0 : COMPONENT IS
    "generatecore com.xilinx.ip.sdivider_v4_0.sdivider_v4_0";
  -- xcc include

END sdivider_v4_0_comp;

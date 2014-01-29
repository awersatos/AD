-- $Header
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

-------------------------------------------------------------------------------
-- Component statement for behavioral model
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

--LIBRARY baseblox_utils_v9_1;
--USE baseblox_utils_v9_1.prims_constants_v9_1.ALL;

PACKAGE sdivider_v5_0_comp IS

  --core_if on component sdivider_v5_0
  component sdivider_v5_0
    GENERIC (
      C_VERBOSITY         : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_USE_DSP48         : integer := 0;          -- 0 = no,    1 = yes
      C_OPTIMIZE_GOAL     : integer := 0;          -- 0 = area,  1 = speed.
      C_MODEL_TYPE        : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY     : string  := "virtex4";
      C_HAS_SCLR          : integer := 0;
      C_HAS_CE            : integer := 0;
      C_CE_OVERRIDES_SYNC : integer := 0;
      DIVCLK_SEL          : integer := 1;
      DIVIDEND_WIDTH      : integer := 8;
      DIVISOR_WIDTH       : integer := 8;
      FRACTIONAL_B        : integer := 0;
      FRACTIONAL_WIDTH    : integer := 8;
      SIGNED_B            : integer := 0
      );
    PORT (
      CLK      : in  std_logic                                       := '1';
      CE       : in  std_logic                                       := '1';
      SCLR     : in  std_logic                                       := '0';
      DIVIDEND : in  std_logic_vector (Dividend_Width -1 downto 0)   := (others => '0');
      DIVISOR  : in  std_logic_vector (Divisor_Width -1 downto 0)    := (others => '0');
      QUOT     : out std_logic_vector (Dividend_Width -1 downto 0);
      REMD     : out std_logic_vector (Fractional_Width -1 downto 0);
      RFD      : out std_logic
      );
  --core_if off
  END COMPONENT;
  -- The following tells XST that sdivider_v5_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF sdivider_v5_0 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF sdivider_v5_0 : COMPONENT IS
    "generatecore com.xilinx.ip.sdivider_v5_0.sdivider_v5_0";
  -- xcc include

END sdivider_v5_0_comp;

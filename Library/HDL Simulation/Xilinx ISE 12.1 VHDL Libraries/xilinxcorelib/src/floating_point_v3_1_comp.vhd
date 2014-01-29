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

PACKAGE floating_point_v3_1_comp IS

  --core_if on component floating_point_v3_1
  component floating_point_v3_1
    GENERIC (
      C_FAMILY                : string  := "virtex2";
      C_HAS_ADD               : integer := 0;
      C_HAS_SUBTRACT          : integer := 0;
      C_HAS_MULTIPLY          : integer := 0;
      C_HAS_DIVIDE            : integer := 0;
      C_HAS_SQRT              : integer := 0;
      C_HAS_COMPARE           : integer := 0;
      C_HAS_FIX_TO_FLT        : integer := 0;
      C_HAS_FLT_TO_FIX        : integer := 0;
      C_HAS_FLT_TO_FLT        : integer := 0;
      C_A_WIDTH               : integer := 32;
      C_A_FRACTION_WIDTH      : integer := 24;
      C_B_WIDTH               : integer := 32;
      C_B_FRACTION_WIDTH      : integer := 24;
      C_RESULT_WIDTH          : integer := 32;
      C_RESULT_FRACTION_WIDTH : integer := 24;
      C_COMPARE_OPERATION     : integer := 1;
      C_LATENCY               : integer := 1000;
      C_OPTIMIZATION          : integer := 1;
      C_MULT_USAGE            : integer := 2;
      C_RATE                  : integer := 1;
      C_HAS_ACLR              : integer := 0;
      C_HAS_CE                : integer := 0;
      C_HAS_SCLR              : integer := 0;
      C_HAS_A_NEGATE          : integer := 0;
      C_HAS_B_NEGATE          : integer := 0;
      C_HAS_A_ND              : integer := 0;
      C_HAS_A_RFD             : integer := 0;
      C_HAS_B_ND              : integer := 0;
      C_HAS_B_RFD             : integer := 0;
      C_HAS_OPERATION_ND      : integer := 0;
      C_HAS_OPERATION_RFD     : integer := 0;
      C_HAS_RDY               : integer := 0;
      C_HAS_CTS               : integer := 0;
      C_HAS_UNDERFLOW         : integer := 0;
      C_HAS_OVERFLOW          : integer := 0;
      C_HAS_INVALID_OP        : integer := 0;
      C_HAS_INEXACT           : integer := 0;
      C_HAS_DIVIDE_BY_ZERO    : integer := 0;
      C_HAS_STATUS            : integer := 0;
      C_HAS_EXCEPTION         : integer := 0;
      C_STATUS_EARLY          : integer := 0;
      C_SPEED                 : integer := 2
      );
    PORT (
      A              : in  std_logic_vector(C_A_WIDTH-1 downto 0);
      B              : in  std_logic_vector(C_B_WIDTH-1 downto 0)      := (others => '0');
      A_NEGATE       : in  std_logic                                   := '0';
      B_NEGATE       : in  std_logic                                   := '0';
      OPERATION      : in  std_logic_vector(6-1 downto 0)              := (others => '0');
      A_ND           : in  std_logic                                   := '1';
      A_RFD          : out std_logic;
      B_ND           : in  std_logic                                   := '1';
      B_RFD          : out std_logic;
      OPERATION_ND   : in  std_logic                                   := '1';
      OPERATION_RFD  : out std_logic;
      CLK            : in  std_logic;
      SCLR           : in  std_logic                                   := '0';
      ACLR           : in  std_logic                                   := '0';
      CE             : in  std_logic                                   := '1';
      RESULT         : out std_logic_vector(C_RESULT_WIDTH-1 downto 0);
      STATUS         : out std_logic_vector(5-1 downto 0);
      EXCEPTION      : out std_logic;
      UNDERFLOW      : out std_logic;
      OVERFLOW       : out std_logic;
      INVALID_OP     : out std_logic;
      INEXACT        : out std_logic;
      DIVIDE_BY_ZERO : out std_logic;
      RDY            : out std_logic;
      CTS            : in  std_logic                                   := '1'
      );
  --core_if off
  END COMPONENT;
  -- The following tells XST that floating_point_v3_1 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF floating_point_v3_1 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF floating_point_v3_1 : COMPONENT IS
    "generatecore com.xilinx.ip.floating_point_v3_1.floating_point_v3_1";
  -- xcc include

END floating_point_v3_1_comp;

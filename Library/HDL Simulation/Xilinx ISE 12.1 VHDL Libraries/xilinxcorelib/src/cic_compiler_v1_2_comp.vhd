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

LIBRARY XilinxCoreLib;
USE Xilinxcorelib.cic_compiler_v1_2_pkg.all;

PACKAGE cic_compiler_v1_2_comp IS

  --core_if on component cic_compiler_v1_2
  COMPONENT cic_compiler_v1_2
    GENERIC(
      C_COMPONENT_NAME  : string  := "cic_compiler_v1_2";
      C_FILTER_TYPE     : integer := 1;
      C_NUM_STAGES      : integer := 4;
      C_DIFF_DELAY      : integer := 1;
      C_RATE            : integer := 4;
      C_INPUT_WIDTH     : integer := 18;
      C_OUTPUT_WIDTH    : integer := 26;
      C_USE_DSP         : integer := 0;
      C_HAS_ROUNDING    : integer := 0;
      C_NUM_CHANNELS    : integer := 4;
      C_PIPE_SUBWORD_WIDTH       : integer := 0;
      C_RATE_TYPE       : integer := 0;
      C_MIN_RATE        : integer := 4;
      C_MAX_RATE        : integer := 4;
      C_SAMPLE_FREQ     : integer := 100;
      C_CLK_FREQ        : integer := 100;
      C_OVERCLOCK       : integer := 1;
      C_HAS_CE          : integer := 0;
      C_HAS_SCLR        : integer := 0;
      C_FAMILY          : string  := "virtex4";
      C_XDEVICEFAMILY   : string  := "virtex4";
      C_C1		: integer := 0;
      C_C2		: integer := 0;
      C_C3		: integer := 0;
      C_C4		: integer := 0;
      C_C5		: integer := 0;
      C_C6		: integer := 0;
      C_I1		: integer := 0;
      C_I2		: integer := 0;
      C_I3		: integer := 0;
      C_I4		: integer := 0;
      C_I5		: integer := 0;
      C_I6		: integer := 0;
      C_LATENCY	        : string  := "cycle_accurate"
      );
    PORT (
      DIN       : in std_logic_vector (C_INPUT_WIDTH-1 downto 0) := (others=>'0');
      ND        : in std_logic := '0';
      RATE      : in std_logic_vector (number_of_digits(C_MAX_RATE,2)-1 downto 0) := (others=>'0');
      RATE_WE   : in std_logic := '0';
      CE        : in std_logic := '0';
      SCLR      : in std_logic := '0';
      CLK       : in std_logic := '0';
      DOUT      : out std_logic_vector (C_OUTPUT_WIDTH-1 downto 0) := (others=>'0');
      RDY       : out std_logic := '0';
      RFD       : out std_logic  := '0';
      CHAN_SYNC : out std_logic  := '0';
      CHAN_OUT  : out std_logic_vector (get_max(1,number_of_digits(C_NUM_CHANNELS-1,2))-1 downto 0) := (others=>'0')
      );
  --core_if off
  END COMPONENT;
  -- The following tells XST that cic_compiler_v1_2 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF cic_compiler_v1_2 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF cic_compiler_v1_2 : COMPONENT IS
    "generatecore com.xilinx.ip.cic_compiler_v1_2.cic_compiler_v1_2";
  -- xcc include

END cic_compiler_v1_2_comp;


package body cic_compiler_v1_2_comp is

end cic_compiler_v1_2_comp;

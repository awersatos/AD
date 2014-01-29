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

LIBRARY xilinxcorelib;
USE xilinxcorelib.bip_usecase_utils_pkg_v1_0.ALL;

--LIBRARY baseblox_utils_v9_1;
--USE baseblox_utils_v9_1.prims_constants_v9_1.ALL;

PACKAGE xbip_dsp48_acc_v1_0_comp IS

  --core_if on component xbip_dsp48_acc_v1_0
  component xbip_dsp48_acc_v1_0
  GENERIC (
    --BaseIP modelling generics
    C_VERBOSITY       : integer := 0;  --0 = Errors 1 = +Warnings, 2 = +Notes and tips
    C_MODEL_TYPE      : integer := 0;   --0 = synth, 1 = RTL
    --BaseIP common generics
    C_XDEVICEFAMILY   : string  := "virtex4";
    C_LATENCY         : integer := -1;
    --DSP special inputs
    C_HAS_SUBTRACT    : integer := 1;   --see check generics for explanation
    C_USE_PCIN        : integer := 0;
    C_USE_CARRYCASCIN : integer := 0
    );
  PORT (
    CLK          : in  std_logic                                     := '1';
    CE           : in  std_logic                                     := '1';
    SCLR         : in  std_logic                                     := '0';
    CARRYIN      : in  std_logic                                     := '0';
    CARRYCASCIN  : in  std_logic                                     := '0';
    ACC_NLOAD    : in  std_logic                                     := '0';
    SUBTRACT     : in  std_logic                                     := '0';
    C            : in  std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0');
    PCIN         : in  std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
    CARRYOUT     : out std_logic                                     := '0';
    CARRYCASCOUT : out std_logic                                     := '0';
    PCOUT        : out std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
    P            : out std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0')
    );
  --core_if off
  END COMPONENT;
  -- The following tells XST that xbip_dsp48_acc_v1_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF xbip_dsp48_acc_v1_0 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF xbip_dsp48_acc_v1_0 : COMPONENT IS
    "generatecore com.xilinx.ip.xbip_dsp48_acc_v1_0.xbip_dsp48_acc_v1_0";
  -- xcc include

END xbip_dsp48_acc_v1_0_comp;

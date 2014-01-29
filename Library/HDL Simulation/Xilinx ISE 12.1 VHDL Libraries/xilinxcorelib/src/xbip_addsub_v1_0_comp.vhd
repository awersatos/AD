-- $Id: xbip_addsub_v1_0_comp.vhd,v 1.2 2008/09/10 09:46:10 akennedy Exp $
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
--  of this text at all times. (c) Copyright 2008 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Component statement for behavioral model
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE xbip_addsub_v1_0_comp IS

  --core_if on component xbip_addsub_v1_0
  component xbip_addsub_v1_0
    GENERIC (
      C_XDEVICEFAMILY     : string  := "no_family";
      C_LATENCY           : integer := -1;
      C_A_WIDTH           : integer := 16;
      C_B_WIDTH           : integer := 16;
      C_OUT_WIDTH         : integer := 16;
      C_CE_OVERRIDES_SCLR : integer := 0;
      C_VERBOSITY         : integer := 0;            -- 0 = Errors  1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE        : integer := 0;            -- 0 = synth,  1 = RTL
      C_DATA_TYPE         : integer := 0             -- 0 = signed, 1 = unsigned.
      );
    PORT (
      CLK    : in  std_logic                                := '1';
      CE     : in  std_logic                                := '1';
      SCLR   : in  std_logic                                := '0';
      ADDF    : in  std_logic                                := '0';
      BYPASS : in  std_logic                                := '0';
      C_IN   : in  std_logic                                := '0';
      A      : in  std_logic_vector(C_A_WIDTH-1 downto 0)   := (others => '0');
      B      : in  std_logic_vector(C_B_WIDTH-1 downto 0)   := (others => '0');
      Q      : out std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0')
      );
  --core_if off
  END COMPONENT;
  -- The following tells XST that xbip_addsub_v1_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF xbip_addsub_v1_0 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF xbip_addsub_v1_0 : COMPONENT IS "generatecore com.xilinx.ip.xbip_addsub_v1_0.xbip_addsub_v1_0";
  -- xcc include

END xbip_addsub_v1_0_comp;

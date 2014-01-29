-- $Header
--
--  Copyright(C) 2007 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2007 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Component statement for behavioral model
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

--LIBRARY baseblox_utils_v9_1;
--USE baseblox_utils_v9_1.prims_constants_v9_1.ALL;

PACKAGE tcc_dec_802_16e_basestation_v3_1_comp IS

  --core_if on component tcc_dec_802_16e_basestation_v3_1
  component tcc_dec_802_16e_basestation_v3_1
    GENERIC (
      c_family     : string  := "virtex4";
      GHARQL5      : integer := 1;
      Nsiso        : integer := 4;
      widthd       : integer := 6;
      widthe       : integer := 6
      );
    PORT (
      earlyterm     : in  std_logic_vector(1 downto 0);
      Ncode         : in  std_logic_vector(7 + 4*GHARQL5 downto 0);
      NumIter       : in  std_logic_vector(7 downto 0);
      ex_scale      : in  std_logic_vector(7 downto 0);
      Adata_in      : in  std_logic_vector(widthd - 1 downto 0);
      Bdata_in      : in  std_logic_vector(widthd - 1 downto 0);
      Y1data_in     : in  std_logic_vector(widthd - 1 downto 0);
      Y2data_in     : in  std_logic_vector(widthd - 1 downto 0);
      W1data_in     : in  std_logic_vector(widthd - 1 downto 0);
      W2data_in     : in  std_logic_vector(widthd - 1 downto 0);
      EX1data_in    : in  std_logic_vector(widthe - 1 downto 0);
      EX2data_in    : in  std_logic_vector(widthe - 1 downto 0);
      start_in      : in  std_logic;
      data_en       : in  std_logic;
      clk           : in  std_logic;
      reset         : in  std_logic;
      rdyforblk     : out std_logic_vector(1 downto 0);
      overflow      : out std_logic;
      Adata_out     : out std_logic_vector(widthd - 1 downto 0);
      Bdata_out     : out std_logic_vector(widthd - 1 downto 0);
      EX1data_out   : out std_logic_vector(widthe - 1 downto 0);
      EX2data_out   : out std_logic_vector(widthe - 1 downto 0);
      dataout_valid : out std_logic;
      start_out     : out std_logic
      );
  --core_if off
  END COMPONENT;
  -- The following tells XST that tcc_dec_802_16e_basestation_v3_1 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF tcc_dec_802_16e_basestation_v3_1 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF tcc_dec_802_16e_basestation_v3_1 : COMPONENT IS
    "generatecore com.xilinx.ip.tcc_dec_802_16e_basestation_v3_1.tcc_dec_802_16e_basestation_v3_1";
  -- xcc include

END tcc_dec_802_16e_basestation_v3_1_comp;

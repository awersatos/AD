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

-- library added to support constants
--library addr_gen_3gpp2_v2_0;
--use addr_gen_3gpp2_v2_0.addr_gen_3gpp2_ul_utils_pkg.all;
--use addr_gen_3gpp2_v2_0.addr_gen_3gpp2_pkg.all;

--LIBRARY baseblox_utils_v9_0;
--USE baseblox_utils_v9_0.prims_constants_v9_0.ALL;

PACKAGE addr_gen_3gpp2_v2_0_comp IS

  --core_if on component
  component addr_gen_3gpp2_v2_0
    GENERIC (
      c_elaboration_dir : STRING  := "./";
      c_component_name  : STRING  := "addr_gen_3gpp2_v2_0";
      c_family          : STRING  := "virtex4";
      c_interlaced      : INTEGER := 0;
      c_has_block_start : INTEGER := 1;
      c_has_block_end   : INTEGER := 1;
      c_has_ce          : INTEGER := 0;
      c_has_sclr        : INTEGER := 0;
      c_has_aclr        : INTEGER := 0;
      c_enable_rlocs    : INTEGER := 0
      );
    PORT (
      fd_in          : IN  STD_LOGIC;
      block_size_sel : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
      intl_addr      : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
      block_start    : OUT STD_LOGIC;
      block_end      : OUT STD_LOGIC;
      ce             : IN  STD_LOGIC;
      sclr           : IN  STD_LOGIC;
      aclr           : IN  STD_LOGIC;
      clk            : IN  STD_LOGIC
      );
  --core_if off
  END COMPONENT;
  -- The following tells XST that addr_gen_3gpp2_v2_0 is a black box which
  -- should be generated command given by the value of this attribute
  -- Note the fully qualified SIM (JAVA class) name that forms the
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF addr_gen_3gpp2_v2_0 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF addr_gen_3gpp2_v2_0 : COMPONENT IS
    "generatecore com.xilinx.ip.addr_gen_3gpp2_v2_0.addr_gen_3gpp2_v2_0";
  -- xcc include

END addr_gen_3gpp2_v2_0_comp;

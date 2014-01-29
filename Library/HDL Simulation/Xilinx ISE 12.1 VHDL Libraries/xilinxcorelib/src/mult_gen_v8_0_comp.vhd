-- $RCSfile: mult_gen_v8_0_comp.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:37:47 $
--------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE mult_gen_v8_0_comp IS

  COMPONENT mult_gen_v8_0
    GENERIC (
      c_family          : STRING  := "not_set";
      c_xdevicefamily   : STRING  := "not_set";
      c_a_width         : INTEGER := 18;
      c_b_width         : INTEGER := 18;
      c_out_width       : INTEGER := 36;
      c_has_q           : INTEGER := 1;
      c_has_o           : INTEGER := 0;
      c_reg_a_b_inputs  : INTEGER := 0;
      c_a_type          : INTEGER := 0;
      c_b_type          : INTEGER := 0;
      c_b_value         : STRING  := "00000001";
      c_has_aclr        : INTEGER := 0;
      c_has_sclr        : INTEGER := 0;
      c_has_ce          : INTEGER := 0;
      c_mem_type        : INTEGER := 0;
      c_mult_type       : INTEGER := 0;
      c_has_nd          : INTEGER := 0;
      c_has_rdy         : INTEGER := 0;
      c_has_rfd         : INTEGER := 0;
      c_pipeline        : INTEGER := 0;
      c_sync_enable     : INTEGER := 0;
      c_has_load_done   : INTEGER := 0;
      c_elaboration_dir : STRING  := "./";
      -- deprecated generics
      c_b_constant      : INTEGER := 0;
      c_has_loadb       : INTEGER := 0;
      c_has_a_signed    : INTEGER := 0;
      c_enable_rlocs    : INTEGER := 0;
      c_baat            : INTEGER := 0;
      c_has_swapb       : INTEGER := 0;
      c_output_hold     : INTEGER := 0;
      c_sqm_type        : INTEGER := 0;
      c_has_b           : INTEGER := 0;
      c_stack_adders    : INTEGER := 0;
      bram_addr_width   : INTEGER := 0;
      c_mem_init_prefix : STRING  := "mem";
      c_standalone      : INTEGER := 0;
      c_use_luts        : INTEGER := 0;
      c_v2_speed        : INTEGER := 0
      );
    PORT (
      clk       : IN  STD_LOGIC                              := '1';
      a         : IN  STD_LOGIC_VECTOR(c_a_width-1 DOWNTO 0) := (OTHERS => '0');
      b         : IN  STD_LOGIC_VECTOR(c_b_width-1 DOWNTO 0) := (OTHERS => '0');
      o         : OUT STD_LOGIC_VECTOR(c_out_width-1 DOWNTO 0);
      q         : OUT STD_LOGIC_VECTOR(c_out_width-1 DOWNTO 0);
      a_signed  : IN  STD_LOGIC                              := '0';
      loadb     : IN  STD_LOGIC                              := '0';
      load_done : OUT STD_LOGIC;
      swapb     : IN  STD_LOGIC                              := '0';
      ce        : IN  STD_LOGIC                              := '1';
      aclr      : IN  STD_LOGIC                              := '0';
      sclr      : IN  STD_LOGIC                              := '0';
      rfd       : OUT STD_LOGIC;
      nd        : IN  STD_LOGIC                              := '0';
      rdy       : OUT STD_LOGIC
      );
  END COMPONENT;

  -- The following tells XST that mult_gen_v8_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type                           : STRING;
  ATTRIBUTE generator_default                  : STRING;
  ATTRIBUTE box_type OF mult_gen_v8_0          : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF mult_gen_v8_0 : COMPONENT IS "generatecore com.xilinx.ip.mult_gen_v8_0.mult_gen_v8_0";
  -- xcc include

END mult_gen_v8_0_comp;

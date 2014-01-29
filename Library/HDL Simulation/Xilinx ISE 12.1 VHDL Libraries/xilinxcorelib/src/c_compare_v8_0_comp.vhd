-- $RCSfile: c_compare_v8_0_comp.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:50 $
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
--
-- Description - This file contains the component declaration for
--                               the C_COMPARE_V8_0 core

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

--LIBRARY XilinxCoreLib;
--USE XilinxCoreLib.prims_constants_v8_0.ALL;

PACKAGE c_compare_v8_0_comp IS


----- Component C_COMPARE_V8_0 -----
-- Short Description
--
-- (A)Synchronous Comparator
--

  COMPONENT c_compare_v8_0
    GENERIC (
      c_width         : INTEGER := 16;  -- input data width
      c_ainit_val     : STRING  := "0"; -- power-on value for output register
      c_data_type     : INTEGER := 0;   -- c_signed or c_unsigned
      c_b_constant    : INTEGER := 0;   -- specify if B is a constant to compare to
      c_b_value       : STRING  := "0000000000000000";  -- specify the constant B port value
      c_sync_enable   : INTEGER := 0;   -- 0=SYNC_OVERRIDES_CE, 1=CE_OVERRIDES_SYNC
      c_sync_priority : INTEGER := 1;   -- 0=SET_OVERRIDES_RESET, 1=RESET_OVERRIDES_SET
      c_pipe_stages   : INTEGER := 0;   -- pipelining
      c_has_a_eq_b    : INTEGER := 1;   -- async output generics a = b
      c_has_a_ne_b    : INTEGER := 0;   -- a /= b
      c_has_a_lt_b    : INTEGER := 0;   -- a < b
      c_has_a_gt_b    : INTEGER := 0;   -- a > b
      c_has_a_le_b    : INTEGER := 0;   -- a <= b
      c_has_a_ge_b    : INTEGER := 0;   -- a >= b
      c_has_qa_eq_b   : INTEGER := 0;   -- registered output generics a = b
      c_has_qa_ne_b   : INTEGER := 0;   -- a /= b
      c_has_qa_lt_b   : INTEGER := 0;   -- a < b
      c_has_qa_gt_b   : INTEGER := 0;   -- a > b
      c_has_qa_le_b   : INTEGER := 0;   -- a <= b
      c_has_qa_ge_b   : INTEGER := 0;   -- a >= b
      c_has_ce        : INTEGER := 0;
      c_has_aclr      : INTEGER := 0;
      c_has_aset      : INTEGER := 0;
      c_has_sclr      : INTEGER := 0;
      c_has_sset      : INTEGER := 0;
      c_enable_rlocs  : INTEGER := 0    -- redundant in the VHDL version
      ); 

    PORT (
      a       : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');  -- input value
      b       : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');  -- input value
      clk     : IN  STD_LOGIC                            := '0';  -- clock
      ce      : IN  STD_LOGIC                            := '1';  -- clock enable
      aclr    : IN  STD_LOGIC                            := '0';  -- asynch init.
      aset    : IN  STD_LOGIC                            := '0';  -- asynch set.
      sclr    : IN  STD_LOGIC                            := '0';  -- synch init.
      sset    : IN  STD_LOGIC                            := '0';  -- synch set.
      a_eq_b  : OUT STD_LOGIC;
      a_ne_b  : OUT STD_LOGIC;
      a_lt_b  : OUT STD_LOGIC;
      a_gt_b  : OUT STD_LOGIC;
      a_le_b  : OUT STD_LOGIC;
      a_ge_b  : OUT STD_LOGIC;
      qa_eq_b : OUT STD_LOGIC;
      qa_ne_b : OUT STD_LOGIC;
      qa_lt_b : OUT STD_LOGIC;
      qa_gt_b : OUT STD_LOGIC;
      qa_le_b : OUT STD_LOGIC;
      qa_ge_b : OUT STD_LOGIC
      ); 
  END COMPONENT;

  -- The following tells XST that c_compare_v8_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF c_compare_v8_0 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF c_compare_v8_0 : COMPONENT IS
    "generatecore com.xilinx.ip.c_compare_v8_0.c_compare_v8_0";
  -- xcc include

END c_compare_v8_0_comp;

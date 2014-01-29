-- $RCSfile: c_counter_binary_v9_1_comp.vhd,v $ $Revision: 1.7 $ $Date: 2008/09/08 19:36:45 $
-- Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you
-- a license to use this text/file solely for design, simulation,
-- implementation and creation of design files limited
-- to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information
-- "as is" solely for use in developing programs and
-- solutions for Xilinx devices. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for
-- obtaining any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
-- All rights reserved.

--
-- Filename - c_counter_binary_v9_1_comp.vhd
-- Author - Xilinx
-- Creation - 9 Dec 1998
--
-- Description - This file contains the component declaration for
--                               the c_counter_binary_v9_1 core

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

--LIBRARY Xilinxcorelib;
--USE Xilinxcorelib.prims_constants_v9_1.ALL;

PACKAGE c_counter_binary_v9_1_comp IS


----- Component c_counter_binary_v9_1 -----
-- Short Description
--
-- Synchronous binary counter
--

  COMPONENT c_counter_binary_v9_1
    GENERIC (
      c_width          : INTEGER := 16;  --c_out_type removed in v7 for cr 164865
      c_restrict_count : INTEGER := 0;
      c_count_to       : STRING  := "0";
      c_count_by       : STRING  := "1";
      c_count_mode     : INTEGER := 0;--c_up;
      c_thresh0_value  : STRING  := "0";
      c_thresh1_value  : STRING  := "0";
      c_thresh_early   : INTEGER := 0;
      c_ainit_val      : STRING  := "0";
      c_sinit_val      : STRING  := "0";
      c_load_enable    : INTEGER := 0;--c_override;
      c_sync_enable    : INTEGER := 0;--c_override;
      c_sync_priority  : INTEGER := 1;--c_clear;
      c_pipe_stages    : INTEGER := 0;
      c_has_thresh0    : INTEGER := 0;
      c_has_q_thresh0  : INTEGER := 0;
      c_has_thresh1    : INTEGER := 0;
      c_has_q_thresh1  : INTEGER := 0;
      c_has_ce         : INTEGER := 0;
      c_has_up         : INTEGER := 0;
      c_has_iv         : INTEGER := 0;
      c_has_l          : INTEGER := 0;
      c_has_load       : INTEGER := 0;
      c_load_low       : INTEGER := 0;
      c_has_aclr       : INTEGER := 0;
      c_has_aset       : INTEGER := 0;
      c_has_ainit      : INTEGER := 0;
      c_has_sclr       : INTEGER := 0;
      c_has_sset       : INTEGER := 0;
      c_has_sinit      : INTEGER := 0;
      c_enable_rlocs   : INTEGER := 0
      ); 

    PORT (
      clk       : IN  STD_LOGIC                            := '0';  -- optional clock
      up        : IN  STD_LOGIC                            := '1';  -- controls direction of count - '1' = up.
      ce        : IN  STD_LOGIC                            := '1';  -- optional clock enable
      load      : IN  STD_LOGIC                            := '0';  -- optional synch load trigger
      l         : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');  -- optional synch load value
      iv        : IN  STD_LOGIC_VECTOR(c_width-1 DOWNTO 0) := (OTHERS => '0');  -- optional increment value
      aclr      : IN  STD_LOGIC                            := '0';  -- asynch init.
      aset      : IN  STD_LOGIC                            := '0';  -- optional asynch set to '1'
      ainit     : IN  STD_LOGIC                            := '0';  -- optional asynch reset to init_val
      sclr      : IN  STD_LOGIC                            := '0';  -- synch init.
      sset      : IN  STD_LOGIC                            := '0';  -- optional synch set to '1'
      sinit     : IN  STD_LOGIC                            := '0';  -- optional synch reset to init_val
      thresh0   : OUT STD_LOGIC                            := '1';
      q_thresh0 : OUT STD_LOGIC                            := '1';
      thresh1   : OUT STD_LOGIC                            := '1';
      q_thresh1 : OUT STD_LOGIC                            := '1';
      q         : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0)  -- output value
      );
  END COMPONENT;

  -- The following tells XST that c_counter_binary_v9_1 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF c_counter_binary_v9_1 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF c_counter_binary_v9_1 : COMPONENT IS
    "generatecore com.xilinx.ip.c_counter_binary_v9_1.c_counter_binary_v9_1";
  -- xcc include

END c_counter_binary_v9_1_comp;

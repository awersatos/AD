-- $RCSfile: c_gate_bit_v9_1_comp.vhd,v $ $Revision: 1.7 $ $Date: 2008/09/08 19:36:46 $
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
-- Filename - c_gate_bit_v9_1_comp.vhd
-- Author - Xilinx
-- Creation - 3 Mar 1999
--
-- Description - This file contains the component declaration for
--                               the c_gate_bit_v9_1 core

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE c_gate_bit_v9_1_comp IS


----- Component c_gate_bit_v9_1 -----
-- Short Description
--
-- (A)Synchronous Wide Gate
--

  COMPONENT c_gate_bit_v9_1
    GENERIC(
      c_gate_type      : INTEGER := 0; --c_and;
      c_inputs         : INTEGER := 2;
      c_input_inv_mask : STRING  := "0";
      c_pipe_stages    : INTEGER := 0;
      c_ainit_val      : STRING  := "0";
      c_sinit_val      : STRING  := "0";
      c_sync_priority  : INTEGER := 1; --c_clear;
      c_sync_enable    : INTEGER := 0; --c_override;
      c_has_o          : INTEGER := 0;
      c_has_q          : INTEGER := 1;
      c_has_ce         : INTEGER := 0;
      c_has_aclr       : INTEGER := 0;
      c_has_aset       : INTEGER := 0;
      c_has_ainit      : INTEGER := 0;
      c_has_sclr       : INTEGER := 0;
      c_has_sset       : INTEGER := 0;
      c_has_sinit      : INTEGER := 0;
      c_enable_rlocs   : INTEGER := 0
      );

    PORT (
      i     : IN  STD_LOGIC_VECTOR(c_inputs-1 DOWNTO 0) := (OTHERS => '0');  -- input vector
      clk   : IN  STD_LOGIC                             := '0';  -- clock
      ce    : IN  STD_LOGIC                             := '1';  -- clock enable
      aclr  : IN  STD_LOGIC                             := '0';  -- asynch clr.
      aset  : IN  STD_LOGIC                             := '0';  -- asynch set.
      ainit : IN  STD_LOGIC                             := '0';  -- asynch init.
      sclr  : IN  STD_LOGIC                             := '0';  -- synch clr.
      sset  : IN  STD_LOGIC                             := '0';  -- synch set.           
      sinit : IN  STD_LOGIC                             := '0';  -- synch init.
      t     : IN  STD_LOGIC                             := '0';  -- tri-state input for buft
      en    : IN  STD_LOGIC                             := '0';  -- enable input for bufe
      o     : OUT STD_LOGIC;            -- asynch output
      q     : OUT STD_LOGIC
      );           -- registered output value
  END COMPONENT;
  -- The following tells XST that c_twos_comp_v9_1 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core 

  --xcc exclude
  ATTRIBUTE box_type                           : STRING;
  ATTRIBUTE GENERATOR_DEFAULT                  : STRING;

  ATTRIBUTE box_type OF c_gate_bit_v9_1          : COMPONENT IS "black_box"; 
  ATTRIBUTE GENERATOR_DEFAULT OF c_gate_bit_v9_1 : COMPONENT IS
    "generatecore com.xilinx.ip.c_gate_bit_v9_1.c_gate_bit_v9_1"; 
  --xcc include

END c_gate_bit_v9_1_comp;

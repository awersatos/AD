-- $RCSfile: c_gate_bit_v9_0_xst.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:36:46 $
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
-- Filename - c_gate_bit_v9_0.vhd
-- Author - Xilinx
-- Creation - 7 Jan 1999
--
-- Description - This file contains the behavior for the 
--                               the c_gate_bit_v9_0 core

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v9_0.ALL;
USE Xilinxcorelib.c_gate_bit_v9_0_comp.ALL;

-- (A)synchronous multi-input gate
--

ENTITY c_gate_bit_v9_0_xst IS
  GENERIC(
    c_gate_type      : INTEGER := c_and;
    c_inputs         : INTEGER := 2;
    c_input_inv_mask : STRING  := "0";
    c_pipe_stages    : INTEGER := 1;
    c_ainit_val      : STRING  := "0";
    c_sinit_val      : STRING  := "0";
    c_sync_priority  : INTEGER := c_clear;
    c_sync_enable    : INTEGER := c_override;
    c_has_o          : INTEGER := 0;
    c_has_q          : INTEGER := 1;
    c_has_ce         : INTEGER := 0;
    c_has_aclr       : INTEGER := 0;
    c_has_aset       : INTEGER := 0;
    c_has_ainit      : INTEGER := 0;
    c_has_sclr       : INTEGER := 0;
    c_has_sset       : INTEGER := 0;
    c_has_sinit      : INTEGER := 0;
    c_family         : STRING  := "virtex2";
    c_enable_rlocs   : INTEGER := 0
    );

  PORT (
    i     : IN  STD_LOGIC_VECTOR(c_inputs-1 DOWNTO 0) := (OTHERS => '0');  -- input vector
    clk   : IN  STD_LOGIC                             := '0';  -- clock
    ce    : IN  STD_LOGIC                             := '1';  -- clock enable
    aclr  : IN  STD_LOGIC                             := '0';  -- asynch init.
    aset  : IN  STD_LOGIC                             := '0';  -- asynch set.
    ainit : IN  STD_LOGIC                             := '0';  -- asynch init.
    sclr  : IN  STD_LOGIC                             := '0';  -- synch init.
    sset  : IN  STD_LOGIC                             := '0';  -- synch set.             
    sinit : IN  STD_LOGIC                             := '0';  -- synch init.
    o     : OUT STD_LOGIC;              -- asynch output
    q     : OUT STD_LOGIC;              -- registered output value
    t     : IN  STD_LOGIC                             := '0';  -- tri-state input for buft
    en    : IN  STD_LOGIC                             := '0'  -- enable input for bufe
    );          
END c_gate_bit_v9_0_xst;


ARCHITECTURE behavioral OF c_gate_bit_v9_0_xst IS

BEGIN
  
  i_behv : c_gate_bit_v9_0
    GENERIC MAP(
      c_gate_type      => c_gate_type,
      c_inputs         => c_inputs,
      c_input_inv_mask => c_input_inv_mask,
      c_pipe_stages    => c_pipe_stages,
      c_ainit_val      => c_ainit_val,
      c_sinit_val      => c_sinit_val,
      c_sync_priority  => c_sync_priority,
      c_sync_enable    => c_sync_enable,
      c_has_o          => c_has_o,
      c_has_q          => c_has_q,
      c_has_ce         => c_has_ce,
      c_has_aclr       => c_has_aclr,
      c_has_aset       => c_has_aset,
      c_has_ainit      => c_has_ainit,
      c_has_sclr       => c_has_sclr,
      c_has_sset       => c_has_sset,
      c_has_sinit      => c_has_sinit,
      c_enable_rlocs   => c_enable_rlocs
      )
    PORT MAP (
      i     => i,
      clk   => clk,
      ce    => ce,
      aclr  => aclr,
      aset  => aset,
      ainit => ainit,
      sclr  => sclr,
      sset  => sset,
      sinit => sinit,
      o     => o,
      q     => q,
      t     => t,
      en    => en
      );
  
END behavioral;


-- $RCSfile: c_addsub_v9_0_xst.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:36:41 $
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
-- of this text at all times. (c) Copyright 1995-2003 Xilinx, Inc.
-- All rights reserved.

--
-- Filename - c_addsub_v9_0.vhd
-- Author - Xilinx
-- Creation - 27 Oct 1998
--
-- Description - This file contains the behavior for
--                               the c_addsub_v9_0 core

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library XilinxCoreLib;
use XilinxCoreLib.prims_constants_v9_0.all;
use XilinxCoreLib.c_addsub_v9_0_comp.all;

-- (A)Synchronous Adder/Subtractor
--

ENTITY c_addsub_v9_0_xst IS
  GENERIC (
    c_family              : STRING;
    c_a_width             : INTEGER;
    c_b_width             : INTEGER;
    c_out_width           : INTEGER;
    c_low_bit             : INTEGER;
    c_high_bit            : INTEGER;
    c_add_mode            : INTEGER;
    c_a_type              : INTEGER;
    c_b_type              : INTEGER;
    c_b_constant          : INTEGER;
    c_b_value             : STRING ; 
    c_ainit_val           : STRING ; 
    c_sinit_val           : STRING ; 
    c_bypass_enable       : INTEGER;
    c_bypass_low          : INTEGER;
    c_sync_enable         : INTEGER;
    c_sync_priority       : INTEGER;
    c_pipe_stages         : INTEGER;
    c_latency             : INTEGER;
    c_has_s               : INTEGER;
    c_has_q               : INTEGER;
    c_has_c_in            : INTEGER;
    c_has_c_out           : INTEGER;
    c_has_q_c_out         : INTEGER;
    c_has_b_in            : INTEGER;
    c_has_b_out           : INTEGER;
    c_has_q_b_out         : INTEGER;
    c_has_ovfl            : INTEGER;
    c_has_q_ovfl          : INTEGER;
    c_has_ce              : INTEGER;
    c_has_add             : INTEGER;
    c_has_bypass          : INTEGER;
    c_has_a_signed        : INTEGER;
    c_has_b_signed        : INTEGER;
    c_has_aclr            : INTEGER;
    c_has_aset            : INTEGER;
    c_has_ainit           : INTEGER;
    c_has_sclr            : INTEGER;
    c_has_sset            : INTEGER;
    c_has_sinit           : INTEGER;
    c_enable_rlocs        : INTEGER;
    c_has_bypass_with_cin : INTEGER
    ); 

  PORT (
    a        : IN  STD_LOGIC_VECTOR(c_a_width-1 DOWNTO 0) := (OTHERS => '0');  -- input value
    b        : IN  STD_LOGIC_VECTOR(c_b_width-1 DOWNTO 0) := (OTHERS => '0');  -- input value
    clk      : IN  STD_LOGIC                              := '0';  -- clock
    add      : IN  STD_LOGIC                              := '1';  -- valid when addsub mode selected. 1 = add, 0 = subtract
    c_in     : IN  STD_LOGIC                              := '0';  -- carry in
    b_in     : IN  STD_LOGIC                              := '1';  -- borrow in
    ce       : IN  STD_LOGIC                              := '1';  -- clock enable
    bypass   : IN  STD_LOGIC                              := '0';  -- sync load of b into reg
    aclr     : IN  STD_LOGIC                              := '0';  -- asynch init.
    aset     : IN  STD_LOGIC                              := '0';  -- asynch set.
    ainit    : IN  STD_LOGIC                              := '0';  -- asynch init.
    sclr     : IN  STD_LOGIC                              := '0';  -- synch init.
    sset     : IN  STD_LOGIC                              := '0';  -- synch set.
    sinit    : IN  STD_LOGIC                              := '0';  -- synch init.
    a_signed : IN  STD_LOGIC                              := '0';  -- '0' = unsigned, '1' = signed.
    b_signed : IN  STD_LOGIC                              := '0';  -- '0' = unsigned, '1' = signed.
    ovfl     : OUT STD_LOGIC;
    c_out    : OUT STD_LOGIC;
    b_out    : OUT STD_LOGIC;           -- borrow out
    q_ovfl   : OUT STD_LOGIC;
    q_c_out  : OUT STD_LOGIC;
    q_b_out  : OUT STD_LOGIC;
    s        : OUT STD_LOGIC_VECTOR(c_high_bit DOWNTO c_low_bit);  -- asynch output value
    q        : OUT STD_LOGIC_VECTOR(c_high_bit DOWNTO c_low_bit)  -- synch output value
    );
END c_addsub_v9_0_xst;

architecture behavioral of c_addsub_v9_0_xst is

begin

  i_behv : c_addsub_v9_0
    GENERIC MAP(
      c_a_width             => c_a_width,
      c_b_width             => c_b_width,
      c_out_width           => c_out_width,
      c_low_bit             => c_low_bit,
      c_high_bit            => c_high_bit,
      c_add_mode            => c_add_mode,
      c_a_type              => c_a_type,
      c_b_type              => c_b_type,
      c_b_constant          => c_b_constant,
      c_b_value             => c_b_value,
      c_ainit_val           => c_ainit_val,
      c_sinit_val           => c_sinit_val,
      c_bypass_enable       => c_bypass_enable,
      c_bypass_low          => c_bypass_low,
      c_sync_enable         => c_sync_enable,
      c_sync_priority       => c_sync_priority,
      c_pipe_stages         => c_pipe_stages,
      c_latency             => c_latency,
      c_has_s               => c_has_s,
      c_has_q               => c_has_q,
      c_has_c_in            => c_has_c_in,
      c_has_c_out           => c_has_c_out,
      c_has_q_c_out         => c_has_q_c_out,
      c_has_b_in            => c_has_b_in,
      c_has_b_out           => c_has_b_out,
      c_has_q_b_out         => c_has_q_b_out,
      c_has_ovfl            => c_has_ovfl,
      c_has_q_ovfl          => c_has_q_ovfl,
      c_has_ce              => c_has_ce,
      c_has_add             => c_has_add,
      c_has_bypass          => c_has_bypass,
      c_has_a_signed        => c_has_a_signed,
      c_has_b_signed        => c_has_b_signed,
      c_has_aclr            => c_has_aclr,
      c_has_aset            => c_has_aset,
      c_has_ainit           => c_has_ainit,
      c_has_sclr            => c_has_sclr,
      c_has_sset            => c_has_sset,
      c_has_sinit           => c_has_sinit,
      c_enable_rlocs        => c_enable_rlocs,
      c_has_bypass_with_cin => c_has_bypass_with_cin
      )
    PORT MAP(
      a        => a,
      b        => b,
      clk      => clk,
      add      => add,
      c_in     => c_in,
      b_in     => b_in,
      ce       => ce,
      bypass   => bypass,
      aclr     => aclr,
      aset     => aset,
      ainit    => ainit,
      sclr     => sclr,
      sset     => sset,
      sinit    => sinit,
      a_signed => a_signed,
      b_signed => b_signed,
      ovfl     => ovfl,
      c_out    => c_out,
      b_out    => b_out,
      q_ovfl   => q_ovfl,
      q_c_out  => q_c_out,
      q_b_out  => q_b_out,
      s        => s,
      q        => q
      );
  
end behavioral;





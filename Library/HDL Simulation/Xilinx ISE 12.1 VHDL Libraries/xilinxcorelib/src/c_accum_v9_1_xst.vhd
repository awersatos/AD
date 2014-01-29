-- $RCSfile: c_accum_v9_1_xst.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:36:41 $
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
-- Filename - c_accum_v9_1.vhd
-- Author - Xilinx
-- Creation - 24 Mar 1999
--
-- Description - This file contains the behavior for
--				 the c_accum_v9_1 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v9_1.all;
Use XilinxCoreLib.c_accum_v9_1_comp.all;



-- (A)Synchronous Accumulator
--

ENTITY c_accum_v9_1_xst IS
  GENERIC (
    c_use_dsp48           : INTEGER := 0;
    c_family              : STRING  := "Virtex2";
    c_b_width             : INTEGER := 16;
    c_out_width           : INTEGER := 16;
    c_low_bit             : INTEGER := 0;
    c_high_bit            : INTEGER := 15;
    c_add_mode            : INTEGER := c_add;
    c_b_type              : INTEGER := c_unsigned;
    c_b_constant          : INTEGER := 0;
    c_b_value             : STRING  := "0000000000000000";                        
    c_scale               : INTEGER := 0;
    c_saturate            : INTEGER := 0;
    c_ainit_val           : STRING  := "0000000000000000";                        
    c_sinit_val           : STRING  := "0000000000000000";                        
    c_bypass_enable       : INTEGER := c_no_override;
    c_bypass_low          : INTEGER := 0;
    c_sync_enable         : INTEGER := c_override;
    c_sync_priority       : INTEGER := c_clear;
    c_pipe_stages         : INTEGER := 0;
    c_has_s               : INTEGER := 0;
    c_has_c_in            : INTEGER := 1;
    c_has_c_out           : INTEGER := 0;
    c_has_q_c_out         : INTEGER := 0;
    c_has_b_in            : INTEGER := 0;
    c_has_b_out           : INTEGER := 0;
    c_has_q_b_out         : INTEGER := 0;
    c_has_ovfl            : INTEGER := 0;
    c_has_q_ovfl          : INTEGER := 0;
    c_has_ce              : INTEGER := 0;
    c_has_add             : INTEGER := 0;
    c_has_bypass          : INTEGER := 0;
    c_has_b_signed        : INTEGER := 0;
    c_has_aclr            : INTEGER := 0;
    c_has_aset            : INTEGER := 0;
    c_has_ainit           : INTEGER := 0;
    c_has_sclr            : INTEGER := 0;
    c_has_sset            : INTEGER := 0;
    c_has_sinit           : INTEGER := 0;
    c_has_bypass_with_cin : INTEGER := 0;
    c_enable_rlocs        : INTEGER := 1;
    c_use_infered_rtl     : INTEGER := 0
    ); 

  PORT (
    b        : IN  STD_LOGIC_VECTOR(c_b_width-1 DOWNTO 0) := (OTHERS => '0');  -- input value
    clk      : IN  STD_LOGIC                              := '0';  -- clock
    add      : IN  STD_LOGIC                              := '1';
    ovfl     : OUT STD_LOGIC;
    q_ovfl   : OUT STD_LOGIC;
    c_in     : IN  STD_LOGIC                              := '0';  -- carry in
    c_out    : OUT STD_LOGIC;
    q_c_out  : OUT STD_LOGIC;
    b_in     : IN  STD_LOGIC                              := '0';  -- borrow in
    b_out    : OUT STD_LOGIC;
    q_b_out  : OUT STD_LOGIC;
    ce       : IN  STD_LOGIC                              := '1';  -- clock enable
    b_signed : IN  STD_LOGIC                              := '0';
    bypass   : IN  STD_LOGIC                              := '0';  -- sync load of b into reg
    aclr     : IN  STD_LOGIC                              := '0';  -- asynch init.
    aset     : IN  STD_LOGIC                              := '0';  -- asynch set.
    ainit    : IN  STD_LOGIC                              := '0';  -- asynch init.
    sclr     : IN  STD_LOGIC                              := '0';  -- synch init.
    sset     : IN  STD_LOGIC                              := '0';  -- synch set.
    sinit    : IN  STD_LOGIC                              := '0';  -- synch init.
    s        : OUT STD_LOGIC_VECTOR(c_high_bit DOWNTO c_low_bit);
    q        : OUT STD_LOGIC_VECTOR(c_high_bit DOWNTO c_low_bit)  -- synch output value
    );
END c_accum_v9_1_xst;

architecture behavioral of c_accum_v9_1_xst is
		
    
begin
  i_behv : c_accum_v9_1
    GENERIC MAP(
      c_b_width             => c_b_width,
      c_out_width           => c_out_width,
      c_low_bit             => c_low_bit,
      c_high_bit            => c_high_bit,
      c_add_mode            => c_add_mode,
      c_b_type              => c_b_type,
      c_b_constant          => c_b_constant,
      c_b_value             => c_b_value,
      c_scale               => c_scale,
      c_saturate            => c_saturate,
      c_ainit_val           => c_ainit_val,
      c_sinit_val           => c_sinit_val,
      c_bypass_enable       => c_bypass_enable,
      c_bypass_low          => c_bypass_low,
      c_sync_enable         => c_sync_enable,
      c_sync_priority       => c_sync_priority,
      c_pipe_stages         => c_pipe_stages,
      c_has_s               => c_has_s,
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
      c_has_b_signed        => c_has_b_signed,
      c_has_aclr            => c_has_aclr,
      c_has_aset            => c_has_aset,
      c_has_ainit           => c_has_ainit,
      c_has_sclr            => c_has_sclr,
      c_has_sset            => c_has_sset,
      c_has_sinit           => c_has_sinit,
      c_has_bypass_with_cin => c_has_bypass_with_cin,
      c_enable_rlocs        => c_enable_rlocs
      )
    PORT MAP(
      b        => b,
      clk      => clk,
      add      => add,
      ovfl     => ovfl,
      q_ovfl   => q_ovfl,
      c_in     => c_in,
      c_out    => c_out,
      q_c_out  => q_c_out,
      b_in     => b_in,
      b_out    => b_out,
      q_b_out  => q_b_out,
      ce       => ce,
      b_signed => b_signed,
      bypass   => bypass,
      aclr     => aclr,
      aset     => aset,
      ainit    => ainit,
      sclr     => sclr,
      sset     => sset,
      sinit    => sinit,
      s        => s,
      q        => q
      );

 
end behavioral;
	

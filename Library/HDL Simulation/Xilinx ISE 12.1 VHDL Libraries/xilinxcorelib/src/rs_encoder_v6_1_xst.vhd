--------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------
--
-- Behavorial simulation model for parallel Reed-Solomon encoder
-- This model is only for other cores that instantiate the RS Encoder. These
-- will instantiate the rs_encoder_v6_1_xst entity. This file is provided
-- for behavioral simulation of that entity. It is in fact a simple wrapper
-- for the rs_encoder_v6_1 behavioral model.
--
-- $RCSfile: rs_encoder_v6_1_xst.vhd,v $ $Revision: 1.7 $ $Date: 2008/09/09 15:24:49 $
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY xilinxcorelib;
USE xilinxcorelib.rs_encoder_v6_1_consts.ALL;
USE xilinxcorelib.rs_encoder_v6_1_comp.ALL;

ENTITY rs_encoder_v6_1_xst IS
  GENERIC (
    c_family          : STRING  := c_family_default;
    c_gen_poly_type   : INTEGER := c_gen_poly_type_default;
    c_gen_start       : INTEGER := c_gen_start_default;
    c_h               : INTEGER := c_h_default;
    c_has_ce          : INTEGER := c_ce_default;
    c_has_n_in        : INTEGER := c_n_in_default;
    c_has_nd          : INTEGER := c_nd_default;
    c_has_r_in        : INTEGER := c_r_in_default;
    c_has_rdy         : INTEGER := c_rdy_default;
    c_has_rfd         : INTEGER := c_rfd_default;
    c_has_rffd        : INTEGER := c_rffd_default;
    c_k               : INTEGER := c_k_default;
    c_mem_init_prefix : STRING  := c_mem_init_prefix_default;
    c_elaboration_dir : STRING  := c_elaboration_dir_default;
    c_memstyle        : INTEGER := c_memstyle_default;
    c_n               : INTEGER := c_n_default;
    c_num_channels    : INTEGER := c_num_channels_default;
    -- c_optimization is no longer used. Keep parameter for b/w compatibility.
    c_optimization    : INTEGER := c_optimization_default;
    c_polynomial      : INTEGER := c_polynomial_default;
    c_spec            : INTEGER := c_spec_default;
    c_symbol_width    : INTEGER := c_symbol_width_default;
    c_userpm          : INTEGER := c_userpm_default
  );
  PORT (
    data_in         : IN  STD_LOGIC_VECTOR(c_symbol_width - 1 DOWNTO 0);
    n_in            : IN  STD_LOGIC_VECTOR(c_symbol_width - 1 DOWNTO 0) := (OTHERS => '1');
    r_in            : IN  STD_LOGIC_VECTOR(integer_width(c_n-c_k) - 1 DOWNTO 0) := (OTHERS => '1');
    start           : IN  STD_LOGIC;
    bypass          : IN  STD_LOGIC := '0';
    nd              : IN  STD_LOGIC := '1';
    data_out        : OUT STD_LOGIC_VECTOR(c_symbol_width - 1 DOWNTO 0);
    info            : OUT STD_LOGIC;
    rdy             : OUT STD_LOGIC;
    rfd             : OUT STD_LOGIC;
    rffd            : OUT STD_LOGIC;
    ce              : IN  STD_LOGIC := '1';
    reset           : IN  STD_LOGIC := '0';
    clk             : IN  STD_LOGIC
  );
  END rs_encoder_v6_1_xst;

ARCHITECTURE behavioral OF rs_encoder_v6_1_xst IS
BEGIN

  -- Instantiate the true behavioral model top level
  enc: rs_encoder_v6_1
    GENERIC MAP (
      c_family           => c_family,
      c_gen_poly_type    => c_gen_poly_type,
      c_h                => c_h,
      c_has_ce           => c_has_ce,
      c_has_n_in         => c_has_n_in,
      c_has_nd           => c_has_nd,
      c_has_r_in         => c_has_r_in,
      c_has_rdy          => c_has_rdy,
      c_has_rfd          => c_has_rfd,
      c_has_rffd         => c_has_rffd,
      c_k                => c_k,
      c_mem_init_prefix  => c_mem_init_prefix,
      c_elaboration_dir  => c_elaboration_dir,
      c_memstyle         => c_memstyle,
      c_n                => c_n,
      c_num_channels     => c_num_channels,
      -- c_optimization is no longer used. Keep parameter for b/w compatibility.
      c_optimization     => c_optimization,
      c_spec             => c_spec,
      c_gen_start        => c_gen_start,
      c_polynomial       => c_polynomial,
      c_symbol_width     => c_symbol_width,
      -- c_userpm is no longer used. Keep parameter for b/w compatibility.
      c_userpm           => c_userpm
      )
    PORT MAP (
      data_in   => data_in,
      n_in      => n_in,
      r_in      => r_in,
      start     => start,
      bypass    => bypass,
      nd        => nd,
      data_out  => data_out,
      info      => info,
      rdy       => rdy,
      rfd       => rfd,
      rffd      => rffd,
      ce        => ce,
      reset     => reset,
      clk       => clk
      );
      
END behavioral;


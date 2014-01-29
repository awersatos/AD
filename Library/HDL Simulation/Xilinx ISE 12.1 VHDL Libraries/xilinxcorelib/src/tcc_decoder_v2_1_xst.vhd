-- $Id: tcc_decoder_v2_1_xst.vhd,v 1.7 2008/09/09 15:26:28 akennedy Exp $
--
--  Copyright(C) 2006 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2006 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Wrapper for behavioral model
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

library xilinxcorelib;
use xilinxcorelib.tcc_decoder_toplevel_pkg.ALL;
use xilinxcorelib.tcc_decoder_v2_1_comp.ALL;

-- (A)synchronous multi-input gate
--
--core_if on entity xst
  entity tcc_decoder_v2_1_xst is
    GENERIC (
      c_elaboration_dir  : STRING  := "./";
      c_family           : STRING  := "virtex2";
      c_component_name   : STRING  := "tcc_decoder_v2_1";
      c_input_int_bits   : INTEGER := 2;
      c_input_frac_bits  : INTEGER := 3;
      c_metric_int_bits  : INTEGER := 6;
      c_metric_frac_bits : INTEGER := 3;
      c_window_size      : INTEGER := 32;
      c_max_block_size   : INTEGER := 12288;               -- Includes all tail bits
      c_external_ram     : INTEGER := 0;
      c_algorithm_type   : INTEGER := 2;                   -- maxscale
      c_enable_rlocs     : INTEGER := 0;
      c_has_ce           : INTEGER := 0;
      c_has_nd           : INTEGER := 0;
      c_has_it_rdy       : INTEGER := 0;
      c_has_rdy          : INTEGER := 1;
      c_has_rfd          : INTEGER := 1;
      c_has_rffd         : INTEGER := 1;
      c_has_sclr         : INTEGER := 0;
      c_has_aclr         : INTEGER := 0
      );
    PORT (
      block_size_sel : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);                                                                -- (CONST_PKG_block_size_sel_width-1 DOWNTO 0);
      clk            : IN  STD_LOGIC;
      d_in           : IN  STD_LOGIC_VECTOR(5*(c_input_int_bits+c_input_frac_bits)-1 DOWNTO 0);
      fd_in          : IN  STD_LOGIC;
      iterations     : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);                                                                -- (CONST_PKG_max_iteration_counter_bits-1 DOWNTO 0);
      aclr           : IN  STD_LOGIC ;
      ce             : IN  STD_LOGIC ;
      nd             : IN  STD_LOGIC ;
      rd_d_in        : IN  STD_LOGIC_VECTOR(5*(c_input_int_bits+c_input_frac_bits)-1 DOWNTO 0);
      sclr           : IN  STD_LOGIC;
      d_out          : OUT STD_LOGIC;
      p_addr         : OUT STD_LOGIC_VECTOR(TOPLEVEL_PKG_bits_needed_to_represent(c_max_block_size-1)-1 DOWNTO 0);
      s_addr         : OUT STD_LOGIC_VECTOR(TOPLEVEL_PKG_bits_needed_to_represent(c_max_block_size-1)-1 DOWNTO 0);
      it_rdy         : OUT STD_LOGIC;
      rdy            : OUT STD_LOGIC;
      rfd            : OUT STD_LOGIC;
      rffd           : OUT STD_LOGIC;
      we             : OUT STD_LOGIC;
      wr_d_out       : OUT STD_LOGIC_VECTOR(5*(c_input_int_bits+c_input_frac_bits)-1 DOWNTO 0)
      );
--core_if off
END tcc_decoder_v2_1_xst;


ARCHITECTURE behavioral OF tcc_decoder_v2_1_xst IS

BEGIN
  --core_if on instance i_behv no_coregen_specials
  i_behv : tcc_decoder_v2_1
    GENERIC MAP (
      c_elaboration_dir  => c_elaboration_dir,
      c_component_name   => c_component_name,
      c_input_int_bits   => c_input_int_bits,
      c_input_frac_bits  => c_input_frac_bits,
      c_metric_int_bits  => c_metric_int_bits,
      c_metric_frac_bits => c_metric_frac_bits,
      c_window_size      => c_window_size,
      c_max_block_size   => c_max_block_size,
      c_external_ram     => c_external_ram,
      c_algorithm_type   => c_algorithm_type,
      c_enable_rlocs     => c_enable_rlocs,
      c_has_ce           => c_has_ce,
      c_has_nd           => c_has_nd,
      c_has_it_rdy       => c_has_it_rdy,
      c_has_rdy          => c_has_rdy,
      c_has_rfd          => c_has_rfd,
      c_has_rffd         => c_has_rffd,
      c_has_sclr         => c_has_sclr,
      c_has_aclr         => c_has_aclr
      )
    PORT MAP (
      block_size_sel => block_size_sel,
      clk            => clk,
      d_in           => d_in,
      fd_in          => fd_in,
      iterations     => iterations,
      aclr           => aclr,
      ce             => ce,
      nd             => nd,
      rd_d_in        => rd_d_in,
      sclr           => sclr,
      d_out          => d_out,
      p_addr         => p_addr,
      s_addr         => s_addr,
      it_rdy         => it_rdy,
      rdy            => rdy,
      rfd            => rfd,
      rffd           => rffd,
      we             => we,
      wr_d_out       => wr_d_out
      );

  --core_if off

END behavioral;


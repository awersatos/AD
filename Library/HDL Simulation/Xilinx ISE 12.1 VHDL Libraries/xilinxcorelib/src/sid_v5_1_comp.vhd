-- $RCSfile: sid_v5_1_comp.vhd,v $
--
--  Copyright(C) 2008 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2008 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Component statement for behavioral model
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;










LIBRARY xilinxcorelib;
USE xilinxcorelib.sid_v5_1_comp_pkg.ALL;

PACKAGE sid_v5_1_comp IS

  --core_if on component no_coregen_specials
  component sid_v5_1
    GENERIC (
      c_xdevicefamily : STRING := "simulation/sid_v5_1_comp";  -- specifies target Xilinx FPGA family
      c_family : STRING := "virtex2";
      c_architecture : INTEGER :=  0;
      c_mem_init_prefix : STRING :=  "sid1";
      c_elaboration_dir : STRING  := "./";
      c_type : INTEGER :=  40;
      c_mode : INTEGER :=  0;
      c_symbol_width : INTEGER :=  1;
      c_row_type : INTEGER :=  0;
      c_row_constant : INTEGER :=  16;
      c_has_row : INTEGER :=  0;
      c_has_row_valid : INTEGER :=  0;
      c_min_num_rows : INTEGER :=  2;
      c_row_width : INTEGER :=  4;
      c_num_selectable_rows : INTEGER :=  4;
      c_row_select_file : STRING :=  "null.mif";
      c_has_row_sel : INTEGER :=  0;
      c_has_row_sel_valid : INTEGER :=  0;
      c_use_row_permute_file : INTEGER :=  0;
      c_row_permute_file : STRING :=  "null.mif";
      c_col_type : INTEGER :=  0;
      c_col_constant : INTEGER :=  16;
      c_has_col : INTEGER :=  0;
      c_has_col_valid : INTEGER :=  0;
      c_min_num_cols : INTEGER :=  2;
      c_col_width : INTEGER :=  4;
      c_num_selectable_cols : INTEGER :=  4;
      c_col_select_file : STRING :=  "null.mif";
      c_has_col_sel : INTEGER :=  0;
      c_has_col_sel_valid : INTEGER :=  0;
      c_use_col_permute_file : INTEGER :=  0;
      c_col_permute_file : STRING :=  "null.mif";
      c_block_size_type : INTEGER :=  0;
      c_block_size_constant : INTEGER :=  256;
      c_has_block_size : INTEGER :=  0;
      c_block_size_width : INTEGER :=  8;
      c_has_block_size_valid : INTEGER :=  0;
--obsolete       c_seed : INTEGER :=  0;
--obsolete       c_use_spreads : INTEGER :=  0;
--obsolete       c_spread1 : INTEGER :=  1;
--obsolete       c_spread2 : INTEGER :=  1;
--obsolete       c_add_symmetry_constraint : INTEGER :=  0;
--obsolete       c_use_k : INTEGER :=  0;
--obsolete       c_k : INTEGER :=  2;
--obsolete       c_relative_prime : INTEGER :=  1;
      c_num_branches : INTEGER :=  16;
      c_branch_length_type : INTEGER :=  0;
      c_branch_length_constant : INTEGER :=  1;
      c_branch_length_file : STRING :=  "null.mif";
      c_num_configurations : INTEGER :=  1;
--obsolete       c_n1 : INTEGER :=  3;
--obsolete       c_n2 : INTEGER :=  1;
      c_external_ram : INTEGER :=  0;
      c_ext_addr_width : INTEGER :=  901;
      c_memstyle : INTEGER :=  0;
      c_pipe_level : INTEGER :=  0;
      c_throughput_mode : INTEGER :=  0;
      c_enable_rlocs : INTEGER :=  0;
      c_has_ce : INTEGER :=  0;
      c_has_nd : INTEGER :=  1;
      c_has_sclr : INTEGER :=  0;
      c_has_aclr : INTEGER :=  0;
      c_has_rdy : INTEGER :=  0;
      c_has_rfd : INTEGER :=  0;
      c_has_rffd : INTEGER :=  0;
      c_has_block_start : INTEGER :=  0;
      c_has_block_end : INTEGER :=  0;
      c_has_fdo : INTEGER :=  0;
      c_has_ndo : INTEGER :=  0
      );
    PORT (
      clk : IN STD_LOGIC;
      fd : IN STD_LOGIC;
      nd : IN STD_LOGIC := '1';
      din : IN STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);
      ce : IN STD_LOGIC := '1';
      sclr : IN STD_LOGIC := '0';
      aclr : IN STD_LOGIC := '0';
      row : IN STD_LOGIC_VECTOR(c_row_width-1 DOWNTO 0) := (OTHERS=>'0');
      row_sel : IN STD_LOGIC_VECTOR((bits_needed_to_represent(c_num_selectable_rows-1) -1)	DOWNTO 0) := (OTHERS=>'0');
      col : IN STD_LOGIC_VECTOR((c_col_width - 1) DOWNTO 0) := (OTHERS=>'0');
      col_sel : IN STD_LOGIC_VECTOR((bits_needed_to_represent(c_num_selectable_cols-1) -1) DOWNTO 0) := (OTHERS=>'0');
      block_size : IN STD_LOGIC_VECTOR((c_block_size_width-1) DOWNTO 0) := (OTHERS=>'0');
      config_sel : IN STD_LOGIC_VECTOR(select_integer(bits_needed_to_represent(c_num_configurations-1),1, c_num_configurations <= 1) -1 DOWNTO 0) := (OTHERS=>'0');
      new_config : IN STD_LOGIC := '0';
      rd_data : IN STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0) := (OTHERS=>'0');
--obsolete       np : IN STD_LOGIC := '0';
--obsolete       p0 : IN STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS=>'0');
--obsolete       p1 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS=>'0');
--obsolete       p2 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS=>'0');
--obsolete       p3 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS=>'0');
      dout : OUT STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);
      rd_en : OUT STD_LOGIC;
      wr_en : OUT STD_LOGIC;
      rd_addr : OUT STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0);
      wr_addr : OUT STD_LOGIC_VECTOR(c_ext_addr_width-1 DOWNTO 0);
      wr_data : OUT STD_LOGIC_VECTOR(c_symbol_width-1 DOWNTO 0);
      rfd : OUT STD_LOGIC;
      rdy : OUT STD_LOGIC;
      rffd : OUT STD_LOGIC;
      row_valid : OUT STD_LOGIC;
      col_valid : OUT STD_LOGIC;
      row_sel_valid : OUT STD_LOGIC;
      col_sel_valid : OUT STD_LOGIC;
      block_size_valid : OUT STD_LOGIC;
      block_start : OUT STD_LOGIC;
      block_end : OUT STD_LOGIC;
      fdo : OUT STD_LOGIC;
      ndo : OUT STD_LOGIC
      );
  --core_if off
  END COMPONENT;
  -- The following tells XST that sid_v5_1 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF sid_v5_1 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF sid_v5_1 : COMPONENT IS
    "generatecore com.xilinx.ip.sid_v5_1.sid_v5_1";
  -- xcc include

END sid_v5_1_comp;

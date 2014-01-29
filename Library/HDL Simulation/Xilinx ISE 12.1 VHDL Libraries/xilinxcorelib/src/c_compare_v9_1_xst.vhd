-- $RCSfile: c_compare_v9_1_xst.vhd,v $ $Revision: 1.7 $ $Date: 2008/09/08 19:36:44 $
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
----------------------------------------------------------------------------------
-- Filename - c_compare_v9_1.vhd
-- Author - Xilinx
-- Creation - 29 Dec 1998
--
-- Description - This file contains the behavior for
--                               the c_compare_v9_1 core

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v9_1.ALL;
USE XilinxCoreLib.c_compare_v9_1_comp.ALL;

-- (A)Synchronous Comparator
--

--core_if on entity xst
  entity c_compare_v9_1_xst is
    GENERIC (
      c_family : STRING :=  "virtex2";
      c_width : INTEGER :=  16;
      c_ainit_val : STRING :=  "0";
      c_data_type : INTEGER :=  0;
      c_b_constant : INTEGER :=  0;
      c_b_value : STRING :=  "0000000000000000";
      c_sync_enable : INTEGER :=  0;
      c_sync_priority : INTEGER :=  1;
      c_pipe_stages : INTEGER :=  0;
      c_has_a_eq_b : INTEGER :=  1;
      c_has_a_ne_b : INTEGER :=  0;
      c_has_a_lt_b : INTEGER :=  0;
      c_has_a_gt_b : INTEGER :=  0;
      c_has_a_le_b : INTEGER :=  0;
      c_has_a_ge_b : INTEGER :=  0;
      c_has_qa_eq_b : INTEGER :=  0;
      c_has_qa_ne_b : INTEGER :=  0;
      c_has_qa_lt_b : INTEGER :=  0;
      c_has_qa_gt_b : INTEGER :=  0;
      c_has_qa_le_b : INTEGER :=  0;
      c_has_qa_ge_b : INTEGER :=  0;
      c_has_ce : INTEGER :=  0;
      c_has_aclr : INTEGER :=  0;
      c_has_aset : INTEGER :=  0;
      c_has_sclr : INTEGER :=  0;
      c_has_sset : INTEGER :=  0;
      c_enable_rlocs : INTEGER :=  0;
      c_carry_chain_eq_ne : INTEGER :=  0;
      c_infered_rtl_const_compare : INTEGER :=  0;
      c_dense_lut_packing : INTEGER :=  0
      );
    PORT (
      a : IN STD_LOGIC_VECTOR(c_width-1 DOWNTO 0):= (OTHERS => '0');
      b : IN STD_LOGIC_VECTOR(c_width-1 DOWNTO 0):= (OTHERS => '0');
      clk : IN STD_LOGIC:= '0';
      ce : IN STD_LOGIC:= '1';
      aclr : IN STD_LOGIC:= '0';
      aset : IN STD_LOGIC:= '0';
      sclr : IN STD_LOGIC:= '0';
      sset : IN STD_LOGIC:= '0';
      a_eq_b : OUT STD_LOGIC;
      a_ne_b : OUT STD_LOGIC;
      a_lt_b : OUT STD_LOGIC;
      a_gt_b : OUT STD_LOGIC;
      a_le_b : OUT STD_LOGIC;
      a_ge_b : OUT STD_LOGIC;
      qa_eq_b : OUT STD_LOGIC;
      qa_ne_b : OUT STD_LOGIC;
      qa_lt_b : OUT STD_LOGIC;
      qa_gt_b : OUT STD_LOGIC;
      qa_le_b : OUT STD_LOGIC;
      qa_ge_b : OUT STD_LOGIC
      );
--core_if off
END c_compare_v9_1_xst;

ARCHITECTURE behavioral OF c_compare_v9_1_xst IS

BEGIN
  
  --core_if on instance i_behv no_coregen_specials
  i_behv : c_compare_v9_1
    GENERIC MAP(
      c_width => c_width,
      c_ainit_val => c_ainit_val,
      c_data_type => c_data_type,
      c_b_constant => c_b_constant,
      c_b_value => c_b_value,
      c_sync_enable => c_sync_enable,
      c_sync_priority => c_sync_priority,
      c_pipe_stages => c_pipe_stages,
      c_has_a_eq_b => c_has_a_eq_b,
      c_has_a_ne_b => c_has_a_ne_b,
      c_has_a_lt_b => c_has_a_lt_b,
      c_has_a_gt_b => c_has_a_gt_b,
      c_has_a_le_b => c_has_a_le_b,
      c_has_a_ge_b => c_has_a_ge_b,
      c_has_qa_eq_b => c_has_qa_eq_b,
      c_has_qa_ne_b => c_has_qa_ne_b,
      c_has_qa_lt_b => c_has_qa_lt_b,
      c_has_qa_gt_b => c_has_qa_gt_b,
      c_has_qa_le_b => c_has_qa_le_b,
      c_has_qa_ge_b => c_has_qa_ge_b,
      c_has_ce => c_has_ce,
      c_has_aclr => c_has_aclr,
      c_has_aset => c_has_aset,
      c_has_sclr => c_has_sclr,
      c_has_sset => c_has_sset,
      c_enable_rlocs => c_enable_rlocs,
      c_carry_chain_eq_ne => c_carry_chain_eq_ne,
      c_infered_rtl_const_compare => c_infered_rtl_const_compare
      )
    PORT MAP(
      a => a,
      b => b,
      clk => clk,
      ce => ce,
      aclr => aclr,
      aset => aset,
      sclr => sclr,
      sset => sset,
      a_eq_b => a_eq_b,
      a_ne_b => a_ne_b,
      a_lt_b => a_lt_b,
      a_gt_b => a_gt_b,
      a_le_b => a_le_b,
      a_ge_b => a_ge_b,
      qa_eq_b => qa_eq_b,
      qa_ne_b => qa_ne_b,
      qa_lt_b => qa_lt_b,
      qa_gt_b => qa_gt_b,
      qa_le_b => qa_le_b,
      qa_ge_b => qa_ge_b
      );

  --core_if off


END behavioral;



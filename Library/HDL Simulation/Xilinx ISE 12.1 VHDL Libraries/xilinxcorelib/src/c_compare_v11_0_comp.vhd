-- $RCSfile: c_compare_v11_0_comp.vhd,v $ $Revision: 1.3 $ $Date: 2009/09/08 15:11:18 $
--------------------------------------------------------------------------------
--  (c) Copyright 1995-2005 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES. 
--------------------------------------------------------------------------------
--
-- Description - This file contains the component declaration for
--                               the c_compare_v11_0 core

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

--LIBRARY XilinxCoreLib;
--USE XilinxCoreLib.bip_utils_pkg_v2_0.ALL;

PACKAGE c_compare_v11_0_comp IS


----- Component c_compare_v11_0 -----
-- Short Description
--
-- (A)Synchronous Comparator
--

  --core_if on component no_coregen_specials
  component c_compare_v11_0
    GENERIC (
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
  END COMPONENT;

  -- The following tells XST that c_compare_v11_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF c_compare_v11_0 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF c_compare_v11_0 : COMPONENT IS
    "generatecore com.xilinx.ip.c_compare_v11_0.c_compare_v11_0";
  -- xcc include

END c_compare_v11_0_comp;

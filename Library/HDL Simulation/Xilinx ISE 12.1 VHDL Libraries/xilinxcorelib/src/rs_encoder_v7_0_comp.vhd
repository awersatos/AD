--------------------------------------------------------------------------------
--  (c) Copyright 1995-2009 Xilinx, Inc. All rights reserved.
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
-- $RCSfile: rs_encoder_v7_0_comp.vhd,v $ $Revision: 1.3 $ $Date: 2009/09/08 16:10:54 $
--
--------------------------------------------------------------------------------
--
-- Top level component statement for core.
--

LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;

LIBRARY xilinxcorelib;
USE xilinxcorelib.rs_encoder_v7_0_consts.ALL;

PACKAGE rs_encoder_v7_0_comp IS

--------------------------------------------------------------------------------
COMPONENT rs_encoder_v7_0
  GENERIC (
    c_family          : STRING;
    c_xdevicefamily   : STRING;
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
    c_has_sclr        : INTEGER := c_sclr_default;
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
    r_in            : IN  STD_LOGIC_VECTOR(integer_width(c_n-c_k) - 1 DOWNTO 0) := (OTHERS => '0');
    start           : IN  STD_LOGIC;
    bypass          : IN  STD_LOGIC := '0';
    nd              : IN  STD_LOGIC := '1';
    sclr            : IN  STD_LOGIC := '0';
    data_out        : OUT STD_LOGIC_VECTOR(c_symbol_width - 1 DOWNTO 0);
    info            : OUT STD_LOGIC;
    rdy             : OUT STD_LOGIC;
    rfd             : OUT STD_LOGIC;
    rffd            : OUT STD_LOGIC;
    ce              : IN  STD_LOGIC := '1';
    clk             : IN  STD_LOGIC
  );
END COMPONENT; -- rs_encoder_v7_0

-- The following tells XST that rs_encoder_v7_0 is a black box which  
-- should be generated by the command given by the value of this attribute
-- Note the fully qualified SIM (JAVA class) name that forms the 
-- basis of the core.
ATTRIBUTE box_type : string; 
ATTRIBUTE box_type OF rs_encoder_v7_0 : COMPONENT IS "black_box"; 
ATTRIBUTE GENERATOR_DEFAULT : string; 
ATTRIBUTE GENERATOR_DEFAULT OF rs_encoder_v7_0 : COMPONENT IS 
          "generatecore com.xilinx.ip.rs_encoder_v7_0.rs_encoder_v7_0";

END rs_encoder_v7_0_comp;
          

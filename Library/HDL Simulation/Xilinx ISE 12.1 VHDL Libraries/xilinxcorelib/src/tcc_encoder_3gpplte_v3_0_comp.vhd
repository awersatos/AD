-- $RCSfile: tcc_encoder_3gpplte_v3_0_comp.vhd,v $
--
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

-------------------------------------------------------------------------------
-- Component statement for behavioral model
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

-- LIBRARY basebollox_utils_v9_0;
-- USE baseblox_utils_v9_0.prims_constants_v9_0.ALL;

PACKAGE tcc_encoder_3gpplte_v3_0_comp IS

  CONSTANT BLOCK_SIZE_PORT_WIDTH         : INTEGER := 13;

  --core_if on component no_coregen_specials
  component tcc_encoder_3gpplte_v3_0
  GENERIC (
    c_elaboration_dir :     string  := "./";
    c_component_name  :     string  := "tcc_encoder_3gpplte_v3_0_comp"; --CR469085 : Added new generic.
    c_has_nd          :     integer := 0;
    c_has_rfd_in      :     integer := 0;
    c_max_blocks      :     integer := 0;
    c_has_ce          :     integer := 0;
    c_has_sclr        :     integer := 0;
    c_family          :     string  := "virtex4"
    );
  port(
    clk               : in  std_logic := '0';
    ce                : in  std_logic := '0';
    sclr              : in  std_logic := '0';
    fd_in             : in  std_logic := '0';
    block_size        : in  std_logic_vector(BLOCK_SIZE_PORT_WIDTH-1 downto 0) := (others=>'0');
    data_in           : in  std_logic := '0';
    nd                : in  std_logic := '0';
    rfd_in            : in  std_logic := '0';
    rfd               : out std_logic;
    rffd              : out std_logic;
    rsc1_systematic   : out std_logic;
    rsc1_parity0      : out std_logic;
    rsc2_parity0      : out std_logic;
    rdy               : out std_logic;
    block_start       : out std_logic;
    block_end         : out std_logic
  );
  --core_if off
  END COMPONENT;
  -- The following tells XST that tcc_encoder_3gpplte_v3_0 is a black box which
  -- should be generated command given by the value of this attribute
  -- Note the fully qualified SIM (JAVA class) name that forms the
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF tcc_encoder_3gpplte_v3_0 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF tcc_encoder_3gpplte_v3_0 : COMPONENT IS
    "generatecore com.xilinx.ip.tcc_encoder_3gpplte_v3_0.tcc_encoder_3gpplte_v3_0";
  -- xcc include

END tcc_encoder_3gpplte_v3_0_comp;

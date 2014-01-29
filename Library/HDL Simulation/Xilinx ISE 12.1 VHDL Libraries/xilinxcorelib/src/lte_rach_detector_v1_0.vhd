-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 1.0
--  \   \        Filename: $RCSfile: lte_rach_detector_v1_0.vhd,v $
--  /   /        Date Last Modified: $Date: 2009/11/27 14:05:30 $
-- /___/   /\    Date Created: 2009
-- \   \  /  \
--  \___\/\___\
--
-- Device  : All
-- Library : example_v1_0
-- Purpose : Behavioral model
-------------------------------------------------------------------------------
--  (c) Copyright 2009 Xilinx, Inc. All rights reserved.
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
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

--core_if on entity lte_rach_detector_v1_0
  entity lte_rach_detector_v1_0 is
    generic (
      c_xdevicefamily     : STRING  := "virtex5";
      c_family            : STRING  := "virtex5";
      c_elaboration_dir   : STRING  := "./";
      c_has_ce            : INTEGER := 0;
      c_antenna_width     : INTEGER := 8;
      c_output_width : INTEGER := 20;
      c_number_antenna    : INTEGER := 2;
      c_number_freq_mux   : INTEGER := 1;
      c_in_ram_depth      : INTEGER := 1024;
      c_has_double_buffer : integer := 0;
      c_fft_arch          : integer := 2;
      c_number_roots      : INTEGER := 16;
      c_bandwidth         : integer := 6;
      c_clk_rate          : INTEGER := 300;   -- in MHZ	
      c_has_format4       : INTEGER := 0
      );
    port (
      clk           : IN  STD_LOGIC;
      ce             : IN  STD_LOGIC;
      sclr           : IN  STD_LOGIC;
      antfrms_wdata  : IN  STD_LOGIC_VECTOR(c_number_antenna*c_antenna_width*2-1 DOWNTO 0);
      antfrms_wstart : IN  STD_LOGIC;
      antfrms_wend   : IN  STD_LOGIC;
      antfrms_wvalid : IN  STD_LOGIC;
      antfrms_wready : OUT STD_LOGIC;
      rachout_wvalid : OUT STD_LOGIC;
      rachout_wready : IN  STD_LOGIC;
      rachout_wstart : OUT STD_LOGIC;
      rachout_wend   : OUT STD_LOGIC;
      rachout_wdata  : OUT STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0);
      sreg_awaddr    : IN  STD_LOGIC_VECTOR(8 DOWNTO 0);
      sreg_awvalid   : IN  STD_LOGIC;
      sreg_awready   : OUT STD_LOGIC;
      sreg_wdata     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
      sreg_wvalid    : IN  STD_LOGIC;
      sreg_wready    : OUT STD_LOGIC;
      sreg_bvalid    : OUT STD_LOGIC;
      sreg_bready    : IN  STD_LOGIC;
      sreg_bresp     : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      sreg_araddr    : IN  STD_LOGIC_VECTOR(8 DOWNTO 0);
      sreg_arvalid   : IN  STD_LOGIC;
      sreg_arready   : OUT STD_LOGIC;
      sreg_rdata     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      sreg_rresp     : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      sreg_rvalid    : OUT STD_LOGIC;
      sreg_rready    : IN  STD_LOGIC;
      rach_fulln     : OUT STD_LOGIC;
      rach_failn     : OUT STD_LOGIC
      );
--core_if off
end lte_rach_detector_v1_0;


architecture behavioral of lte_rach_detector_v1_0 is

begin
  
end behavioral;


-- $RCSfile $ $Date: 2009/09/08 15:40:37 $ $Revision: 1.3 $
--
-- ? Copyright 2009 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information of Xilinx, Inc. 
-- and is protected under U.S. and international copyright and other 
-- intellectual property laws.
-- 
-- DISCLAIMER
-- 
-- This disclaimer is not a license and does not grant any rights to the 
-- materials distributed herewith. Except as otherwise provided in a valid 
-- license issued to you by Xilinx, and to the maximum extent permitted by 
-- applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH 
-- ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, 
-- EXPRESS, IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES 
-- OF MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR 
-- PURPOSE; and (2) Xilinx shall not be liable (whether in contract or tort, 
-- including negligence, or under any other theory of liability) for any 
-- loss or damage of any kind or nature related to, arising under or in 
-- connection with these materials, including for any direct, or any indirect, 
-- special, incidental, or consequential loss or damage (including loss of data, 
-- profits, goodwill, or any type of loss or damage suffered as a result of 
-- any action brought by a third party) even if such damage or loss was 
-- reasonably foreseeable or Xilinx had been advised of the possibility 
-- of the same.
-- 
-- CRITICAL APPLICATIONS
-- 
-- Xilinx products are not designed or intended to be fail-safe, or for use 
-- in any application requiring fail-safe performance, such as life-support 
-- or safety devices or systems, Class III medical devices, nuclear facilities, 
-- applications related to the deployment of airbags, or any other applications 
-- that could lead to death, personal injury, or severe property or environmental 
-- damage (individually and collectively, "Critical Applications"). Customer 
-- assumes the sole risk and liability of any use of Xilinx products in Critical 
-- Applications, subject only to applicable laws and regulations governing 
-- limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES.
-- 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Component statement for wrapper of behavioural model
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package lte_ul_channel_decoder_v2_0_xst_comp is

----------------------------------------------------------
-- Insert component declaration of top level xst file here
----------------------------------------------------------
  --core_if on component lte_ul_channel_decoder_v2_0_xst
component lte_ul_channel_decoder_v2_0_xst is
generic (
   -- LTE_UL_Channel_Decoder General Generics
   c_family             : string := "virtex5";
   c_xdevicefamily      : string := "virtex5";
   c_elaboration_dir    : string  := "./";
   c_component_name     : string  := "LTE_UL_Channel_Decoder_v2_0";
   c_num_dec_blocks     : integer := 1;   -- Number of CQI Decoder Blocks
   c_main_buf_depth     : integer := 18432;   -- Depth of main input buffer
   ----- Turbo Decoder core specific Generics ------
   c_num_pu             : integer := 4;   -- 2,4,8 processing units
   c_algorithm_type     : integer := 1;   -- 0=max, 1=maxscale, 2=max*
   c_num_dsp            : integer := 0;   -- number of dsp blocks available
   c_opt_goal           : integer := 0   -- 0=balanced, 1=speed
   );
port (
   ACLK : in std_logic;
   ARESET : in std_logic;
   
   ------------------------------------------------------------------------------
   -- PUSCH Control Input Interface
   SREG_WDATA   : in std_logic_vector(31 downto 0);
   SREG_WVALID  : in std_logic;
   SREG_WREADY  : out std_logic;
   SREG_AWADDR  : in std_logic_vector(5 downto 0);
   SREG_AWVALID : in std_logic;
   SREG_AWREADY : out std_logic;
   
   ------------------------------------------------------------------------------
   -- PUSCH Data Input Interface
   SSCHTB_WDATA   : in std_logic_vector(47 downto 0);
   SSCHTB_WSTART  : in std_logic;
   SSCHTB_WEND    : in std_logic;
   SSCHTB_WVALID  : in std_logic;
   SSCHTB_WREADY  : out std_logic;
   
   ------------------------------------------------------------------------------
   -- PUSCH Data Input Interface
   SCCHTB_WSTART  : in std_logic;
   SCCHTB_WEND    : in std_logic;
   SCCHTB_WDATA   : in std_logic_vector(15 downto 0);
   SCCHTB_WVALID  : in std_logic;
   SCCHTB_WREADY  : out std_logic;

   ------------------------------------------------------------------------------
   -- PUSCH Status Output Interface
   SREG_RDATA   : out std_logic_vector(31 downto 0);
   SREG_RVALID  : out std_logic;
   SREG_RREADY  : in std_logic;
   SREG_ARADDR  : in std_logic_vector(5 downto 0);
   SREG_ARVALID : in std_logic;
   SREG_ARREADY : out std_logic;
   
   ------------------------------------------------------------------------------
   -- PUSCH Data Output Interface
   MSCHTB_WDATA   : out std_logic;
   MSCHTB_WSTART  : out std_logic;
   MSCHTB_WEND    : out std_logic;
   MSCHTB_WVALID  : out std_logic;
   MSCHTB_WREADY  : in std_logic;
   
   ------------------------------------------------------------------------------
   -- PUSCH HARQData Input Interface
   SHARQ_WDATA   : in std_logic_vector(31 downto 0);
   SHARQ_WSTART  : in std_logic;
   SHARQ_WEND    : in std_logic;
   SHARQ_WVALID  : in std_logic;
   SHARQ_WREADY  : out std_logic;
   
   ------------------------------------------------------------------------------
   -- PUSCH HARQData Output Interface
   MHARQ_WDATA   : out std_logic_vector(31 downto 0);
   MHARQ_WSTART  : out std_logic;
   MHARQ_WEND    : out std_logic;
   MHARQ_WVALID  : out std_logic;
   MHARQ_WREADY  : in std_logic;

   PUSCH_STATUS   : out std_logic; 
   CQI_STATUS     : out std_logic; 
   RI_STATUS      : out std_logic; 
   ACK_STATUS     : out std_logic; 
   PUCCH_STATUS   : out std_logic; 
   SCH_FULLN      : out std_logic; 
   CCH_FULLN      : out std_logic
   
);

  --core_if off
  END COMPONENT;


end lte_ul_channel_decoder_v2_0_xst_comp;


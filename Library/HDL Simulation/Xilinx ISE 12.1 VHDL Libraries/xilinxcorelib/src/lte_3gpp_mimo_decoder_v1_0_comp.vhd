-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 1.0
--  \   \        Filename: $RCSfile: lte_3gpp_mimo_decoder_v1_0_comp.vhd,v $
--  /   /        Date Last Modified: $Date: 2009/12/02 13:25:12 $
-- /___/   /\    Date Created: 2009
-- \   \  /  \
--  \___\/\___\
--
-- Device  : All
-- Library : example_v1_0
-- Purpose : Component statement for behavioral model
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
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package lte_3gpp_mimo_decoder_v1_0_comp is

  --core_if on component lte_3gpp_mimo_decoder_v1_0
  component lte_3gpp_mimo_decoder_v1_0
    generic (
      c_elaboration_dir :   string  := "./";
      c_xdevicefamily :     string  := "virtex6";
      Ntmax           :     integer := 2;
      Wmatrix         :     integer := 1;
      widthx          :     integer := 16
      );
    port (
      Singular_thresh : in  std_logic_vector(3 downto 0);
      H_SIZE          : in  std_logic_vector(2 downto 0);
      H_SIZE_LOAD     : in  std_logic;
      SIGMA_DATA      : in  std_logic_vector(widthx - 1 downto 0);
      SIGMA_LOAD      : in  std_logic;
      Y_I_DATA        : in  std_logic_vector(widthx - 1 downto 0);
      Y_Q_DATA        : in  std_logic_vector(widthx - 1 downto 0);
      Y_VALID         : in  std_logic;
      Y_START         : in  std_logic;
      Hx1_I_DATA      : in  std_logic_vector(widthx - 1 downto 0);
      Hx1_Q_DATA      : in  std_logic_vector(widthx - 1 downto 0);
      Hx2_I_DATA      : in  std_logic_vector(widthx - 1 downto 0);
      Hx2_Q_DATA      : in  std_logic_vector(widthx - 1 downto 0);
      Hx_VALID        : in  std_logic;
      Hx_START        : in  std_logic;
      Xest_READY      : in  std_logic;
      Wx_READY        : in  std_logic := '1';
      RESET           : in  std_logic;
      CE              : in  std_logic;
      CLK             : in  std_logic;
      H_SIZE_READY    : out std_logic;
      SIGMA_READY     : out std_logic;
      Y_READY         : out std_logic;
      Hx_READY        : out std_logic;
      Singular_flag   : out std_logic;
      Xest_overflow   : out std_logic;
      Xest_SIZE       : out std_logic_vector(1 downto 0);
      Xest_I_DATA     : out std_logic_vector(widthx + 8 downto 0);
      Xest_Q_DATA     : out std_logic_vector(widthx + 8 downto 0);
      Xest_VALID      : out std_logic;
      Xest_START      : out std_logic;
      W_overflow      : out std_logic := '0';
      W_SIZE          : out std_logic_vector(2 downto 0) := (others => '0');
      Wx1_I_DATA      : out std_logic_vector(widthx + 8 downto 0) := (others => '0');
      Wx1_Q_DATA      : out std_logic_vector(widthx + 8 downto 0) := (others => '0');
      Wx2_I_DATA      : out std_logic_vector(widthx + 8 downto 0) := (others => '0');
      Wx2_Q_DATA      : out std_logic_vector(widthx + 8 downto 0) := (others => '0');
      Wx_VALID        : out std_logic := '0';
      Wx_START        : out std_logic := '0'
      );
  --core_if off
  end component;
  -- the following tells xst that lte_3gpp_mimo_decoder_v1_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF lte_3gpp_mimo_decoder_v1_0 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF lte_3gpp_mimo_decoder_v1_0 : COMPONENT IS
    "generatecore com.xilinx.ip.lte_3gpp_mimo_decoder_v1_0.lte_3gpp_mimo_decoder_v1_0";
  -- xcc include

END lte_3gpp_mimo_decoder_v1_0_comp;

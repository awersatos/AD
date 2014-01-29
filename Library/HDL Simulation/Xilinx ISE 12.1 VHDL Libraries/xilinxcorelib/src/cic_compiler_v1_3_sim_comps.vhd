-------------------------------------------------------------------------------
-- $Id: cic_compiler_v1_3_sim_comps.vhd,v 1.3 2009/12/04 11:46:36 akennedy Exp $
-------------------------------------------------------------------------------
-- Copyright (c) 2006 - 2008 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES
-------------------------------------------------------------------------------
-- Description:
-- Component declaration file
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.cic_compiler_v1_3_pkg.all;
use Xilinxcorelib.bip_utils_pkg_v2_0.get_max;

package cic_compiler_v1_3_sim_comps is

  component cic_compiler_v1_3_interpolate_bhv
    generic (
      C_NUM_STAGES : integer := 4;
      C_DIFF_DELAY : integer := 1;
      C_RATE : integer := 4;
      C_INPUT_WIDTH : integer := 18;
      C_OUTPUT_WIDTH : integer := 26;
      C_USE_DSP : integer := 0;
      C_HAS_ROUNDING : integer := 0;
      C_NUM_CHANNELS  : integer := 1;
      -- C_PIPE_SUBWORD_WIDTH  : integer := 0;
      C_RATE_TYPE : integer := 0;
      C_MIN_RATE : integer := 4;
      C_MAX_RATE : integer := 4;
      C_SAMPLE_FREQ : integer := 100;
      C_CLK_FREQ : integer := 100;
      -- C_OVERCLOCK : integer := 1;
      C_HAS_CE : integer := 0;
      C_HAS_SCLR : integer := 0;
      C_HAS_ND          : integer := 1;
      C_USE_STREAMING_INTERFACE : integer:= 0;
      C_FAMILY : string := "virtex4";
      C_COMB_WIDTHS : stage_array := (others => 0);
      C_INT_WIDTHS : stage_array := (others => 0)--;
      -- C_LATENCY : string := "zero_latency"
      );
    port ( 
      DIN : in  std_logic_vector (C_INPUT_WIDTH-1 downto 0);
      ND : in  std_logic;
      RATE : in std_logic_vector (number_of_digits(C_MAX_RATE,2)-1 downto 0);
      RATE_WE : in std_logic;
      CE : in  std_logic;
      SCLR : in  std_logic;
      CLK : in  std_logic;
      DOUT : out  std_logic_vector (C_OUTPUT_WIDTH-1 downto 0);
      RDY : out  std_logic;
      RFD : out std_logic;
      CHAN_SYNC : out std_logic;
      CHAN_OUT : out std_logic_vector (get_max(1,number_of_digits(C_NUM_CHANNELS-1,2))-1 downto 0)
     );
  end component;

  component cic_compiler_v1_3_decimate_bhv
    generic (
      C_NUM_STAGES : integer := 4;
      C_DIFF_DELAY : integer := 1;
      C_RATE : integer := 4;
      C_INPUT_WIDTH : integer := 18;
      C_OUTPUT_WIDTH : integer := 26;
      C_USE_DSP  : integer := 0;
      C_HAS_ROUNDING : integer := 0;
      C_NUM_CHANNELS  : integer := 1;
      -- C_PIPE_SUBWORD_WIDTH  : integer := 0;
      C_RATE_TYPE : integer := 0;
      C_MIN_RATE : integer := 4;
      C_MAX_RATE : integer := 4;
      C_SAMPLE_FREQ : integer := 100;
      C_CLK_FREQ : integer := 100;
      -- C_OVERCLOCK : integer := 1;
      C_HAS_CE : integer := 0;
      C_HAS_SCLR : integer := 0;
      C_HAS_ND          : integer := 1;
      C_USE_STREAMING_INTERFACE : integer:= 0;
      C_FAMILY : string := "virtex4";
      C_COMB_WIDTHS : stage_array := (others => 0);
      C_INT_WIDTHS : stage_array := (others => 0)--;
      -- C_LATENCY : string := "zero_latency"
      );
    port ( 
      DIN : in  std_logic_vector (C_INPUT_WIDTH-1 downto 0);
      ND : in  std_logic;
      RATE : in std_logic_vector (number_of_digits(C_MAX_RATE,2)-1 downto 0);
      RATE_WE : in std_logic;
      CE : in  std_logic;
      SCLR : in  std_logic;
      CLK : in  std_logic;
      DOUT : out  std_logic_vector (C_OUTPUT_WIDTH-1 downto 0);
      RDY : out  std_logic;
      RFD : out std_logic;
      CHAN_SYNC : out std_logic;
      CHAN_OUT : out std_logic_vector (get_max(1,number_of_digits(C_NUM_CHANNELS-1,2))-1 downto 0)
      );
  end component;

end cic_compiler_v1_3_sim_comps;


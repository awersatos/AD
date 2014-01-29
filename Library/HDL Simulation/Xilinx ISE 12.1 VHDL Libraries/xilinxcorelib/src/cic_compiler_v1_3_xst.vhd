-------------------------------------------------------------------------------
-- $Id: cic_compiler_v1_3_xst.vhd,v 1.3 2009/12/04 11:46:36 akennedy Exp $
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
-- Wrapper for behavioral model
-------------------------------------------------------------------------------
  
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE Xilinxcorelib.cic_compiler_v1_3_comp.ALL;
USE Xilinxcorelib.cic_compiler_v1_3_pkg.all;
use Xilinxcorelib.bip_utils_pkg_v2_0.get_max;

-- (A)synchronous multi-input gate
--
--core_if on entity cic_compiler_v1_3_xst
ENTITY cic_compiler_v1_3_xst IS
  GENERIC(
      C_COMPONENT_NAME  : string := "cic_compiler_v1_3";
      C_FILTER_TYPE     : integer := 1;
      C_NUM_STAGES      : integer := 3;
      C_DIFF_DELAY      : integer := 1;
      C_RATE            : integer := 4;
      C_INPUT_WIDTH     : integer := 18;
      C_OUTPUT_WIDTH    : integer := 22;
      C_USE_DSP         : integer := 0;
      C_HAS_ROUNDING    : integer := 0;
      C_NUM_CHANNELS    : integer := 1;
      C_RATE_TYPE       : integer := 0;
      C_MIN_RATE        : integer := 4;
      C_MAX_RATE        : integer := 4;
      C_SAMPLE_FREQ     : integer := 1;
      C_CLK_FREQ        : integer := 4;
      C_HAS_CE          : integer := 0;
      C_HAS_SCLR        : integer := 0;
      C_HAS_ND          : integer := 1;
      C_USE_STREAMING_INTERFACE : integer:= 0;
      C_FAMILY          : string  := "virtex4";
      C_XDEVICEFAMILY   : string  := "virtex4";
      C_C1    : integer := 19;
      C_C2    : integer := 20;
      C_C3    : integer := 20;
      C_C4    : integer := 0;
      C_C5    : integer := 0;
      C_C6    : integer := 0;
      C_I1    : integer := 20;
      C_I2    : integer := 21;
      C_I3    : integer := 22;
      C_I4    : integer := 0;
      C_I5    : integer := 0;
      C_I6    : integer := 0
      -- C_LATENCY	        : string  := "cycle_accurate"
    );
  PORT (
      DIN       : in std_logic_vector (C_INPUT_WIDTH-1 downto 0) := (others=>'0');
      ND        : in std_logic := '0';
      RATE      : in std_logic_vector (number_of_digits(C_MAX_RATE,2)-1 downto 0) := (others=>'0');
      RATE_WE   : in std_logic := '0';
      CE        : in std_logic := '0';
      SCLR      : in std_logic := '0';
      CLK       : in std_logic := '0';
      DOUT      : out std_logic_vector (C_OUTPUT_WIDTH-1 downto 0) := (others=>'0');
      RDY       : out std_logic := '0';
      RFD       : out std_logic  := '0';
      CHAN_SYNC : out std_logic  := '0';
      CHAN_OUT  : out std_logic_vector (get_max(1,number_of_digits(C_NUM_CHANNELS-1,2))-1 downto 0) := (others=>'0')
    );          
--core_if off
END cic_compiler_v1_3_xst;


ARCHITECTURE behavioral OF cic_compiler_v1_3_xst IS

BEGIN
  --core_if on instance i_behv cic_compiler_v1_3
  i_behv : cic_compiler_v1_3
    GENERIC MAP(
      C_COMPONENT_NAME  => C_COMPONENT_NAME,
      C_FILTER_TYPE     => C_FILTER_TYPE,
      C_NUM_STAGES      => C_NUM_STAGES,
      C_DIFF_DELAY      => C_DIFF_DELAY,
      C_RATE            => C_RATE,
      C_INPUT_WIDTH     => C_INPUT_WIDTH,
      C_OUTPUT_WIDTH    => C_OUTPUT_WIDTH,
      C_USE_DSP         => C_USE_DSP,
      C_HAS_ROUNDING    => C_HAS_ROUNDING,
      C_NUM_CHANNELS    => C_NUM_CHANNELS,
      C_RATE_TYPE       => C_RATE_TYPE,
      C_MIN_RATE        => C_MIN_RATE,
      C_MAX_RATE        => C_MAX_RATE,
      C_SAMPLE_FREQ     => C_SAMPLE_FREQ,
      C_CLK_FREQ        => C_CLK_FREQ,
      -- C_OVERCLOCK 	=> C_OVERCLOCK,
      C_HAS_CE          => C_HAS_CE,
      C_HAS_SCLR        => C_HAS_SCLR,
      C_HAS_ND => C_HAS_ND,
      C_USE_STREAMING_INTERFACE => C_USE_STREAMING_INTERFACE,
      C_FAMILY          => C_FAMILY,
      C_XDEVICEFAMILY   => C_XDEVICEFAMILY,
      C_C1		=> C_C1,
      C_C2		=> C_C2,
      C_C3		=> C_C3,
      C_C4		=> C_C4,
      C_C5		=> C_C5,
      C_C6		=> C_C6,
      C_I1		=> C_I1,
      C_I2		=> C_I2,
      C_I3		=> C_I3,
      C_I4		=> C_I4,
      C_I5		=> C_I5,
      C_I6		=> C_I6--,
      -- C_LATENCY 	=> C_LATENCY
      )
    PORT MAP (
      DIN       => din,
      ND        => nd,
      RATE      => rate,
      RATE_WE   => rate_we,
      CE        => ce,
      SCLR      => sclr,
      CLK       => clk,
      DOUT      => dout,
      RDY       => rdy,
      RFD       => rfd,
      CHAN_SYNC => chan_sync,
      CHAN_OUT  => chan_out
      );
  --core_if off
  
END behavioral;


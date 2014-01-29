--
--  Copyright(C) 2007 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2007 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Component declaration file
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.cic_compiler_v1_2_pkg.all;

package cic_compiler_v1_2_sim_comps is

  component cic_compiler_v1_2_interpolate_bhv
    generic (
      C_NUM_STAGES : integer := 4;
      C_DIFF_DELAY : integer := 1;
      C_RATE : integer := 4;
      C_INPUT_WIDTH : integer := 18;
      C_OUTPUT_WIDTH : integer := 26;
      C_USE_DSP : integer := 0;
      C_HAS_ROUNDING : integer := 0;
      C_NUM_CHANNELS  : integer := 1;
      C_PIPE_SUBWORD_WIDTH  : integer := 0;
      C_RATE_TYPE : integer := 0;
      C_MIN_RATE : integer := 4;
      C_MAX_RATE : integer := 4;
      C_SAMPLE_FREQ : integer := 100;
      C_CLK_FREQ : integer := 100;
      C_OVERCLOCK : integer := 1;
      C_HAS_CE : integer := 0;
      C_HAS_SCLR : integer := 0;
      C_FAMILY : string := "virtex4";
      C_COMB_WIDTHS : stage_array := (others => 0);
      C_INT_WIDTHS : stage_array := (others => 0);
      C_LATENCY : string := "zero_latency"
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

  component cic_compiler_v1_2_decimate_bhv
    generic (
      C_NUM_STAGES : integer := 4;
      C_DIFF_DELAY : integer := 1;
      C_RATE : integer := 4;
      C_INPUT_WIDTH : integer := 18;
      C_OUTPUT_WIDTH : integer := 26;
      C_USE_DSP  : integer := 0;
      C_HAS_ROUNDING : integer := 0;
      C_NUM_CHANNELS  : integer := 1;
      C_PIPE_SUBWORD_WIDTH  : integer := 0;
      C_RATE_TYPE : integer := 0;
      C_MIN_RATE : integer := 4;
      C_MAX_RATE : integer := 4;
      C_SAMPLE_FREQ : integer := 100;
      C_CLK_FREQ : integer := 100;
      C_OVERCLOCK : integer := 1;
      C_HAS_CE : integer := 0;
      C_HAS_SCLR : integer := 0;
      C_FAMILY : string := "virtex4";
      C_COMB_WIDTHS : stage_array := (others => 0);
      C_INT_WIDTHS : stage_array := (others => 0);
      C_LATENCY : string := "zero_latency"
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

end cic_compiler_v1_2_sim_comps;


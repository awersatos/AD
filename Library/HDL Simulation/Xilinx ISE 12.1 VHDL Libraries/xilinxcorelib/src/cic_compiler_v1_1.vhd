--
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
--
-------------------------------------------------------------------------------
-- Behavioural Model
-------------------------------------------------------------------------------
  
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

library xilinxcorelib;
use xilinxcorelib.cic_compiler_v1_1_pkg.all;
use xilinxcorelib.cic_compiler_v1_1_sim_comps.all;

-- (A)synchronous multi-input gate
--
--core_if on entity cic_compiler_v1_1
ENTITY cic_compiler_v1_1 IS
  GENERIC(
      C_COMPONENT_NAME  : string  := "cic_compiler_v1_1";
      C_FILTER_TYPE     : integer := 1;
      C_NUM_STAGES      : integer := 4;
      C_DIFF_DELAY      : integer := 1;
      C_RATE            : integer := 4;
      C_INPUT_WIDTH     : integer := 18;
      C_OUTPUT_WIDTH    : integer := 26;
      C_USE_DSP         : integer := 0;
      C_HAS_ROUNDING    : integer := 0;
      C_NUM_CHANNELS    : integer := 4;
      C_PIPE_SUBWORD_WIDTH       : integer := 0;
      C_RATE_TYPE       : integer := 0;
      C_MIN_RATE        : integer := 4;
      C_MAX_RATE        : integer := 4;
      C_SAMPLE_FREQ     : integer := 100;
      C_CLK_FREQ        : integer := 100;
      C_OVERCLOCK       : integer := 1;
      C_HAS_CE          : integer := 0;
      C_HAS_SCLR        : integer := 0;
      C_FAMILY          : string  := "virtex4";
      C_XDEVICEFAMILY   : string  := "virtex4";
      C_C1		: integer := 0;
      C_C2		: integer := 0;
      C_C3		: integer := 0;
      C_C4		: integer := 0;
      C_C5		: integer := 0;
      C_C6		: integer := 0;
      C_I1		: integer := 0;
      C_I2		: integer := 0;
      C_I3		: integer := 0;
      C_I4		: integer := 0;
      C_I5		: integer := 0;
      C_I6		: integer := 0;
      C_LATENCY	        : string  := "cycle_accurate"
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
END cic_compiler_v1_1;


ARCHITECTURE behavioral OF cic_compiler_v1_1 IS

    -- signals section
    signal i_ce : std_logic := '1';
    signal i_sclr : std_logic := '0';

  begin
  
    has_ce : if (C_HAS_CE=1) generate i_ce <= ce; end generate;
    has_no_ce : if (C_HAS_CE=0) generate i_ce <= '1'; end generate;
  
    has_sclr : if (C_HAS_SCLR=1) generate i_sclr <= sclr; end generate;
    has_no_sclr : if (C_HAS_SCLR=0) generate i_sclr <= '0'; end generate;
        
    decimator : if C_FILTER_TYPE = 1 generate
      decimation_filter : cic_compiler_v1_1_decimate_bhv
        generic map ( 
          C_NUM_STAGES => C_NUM_STAGES,
          C_DIFF_DELAY => C_DIFF_DELAY,
          C_RATE => C_RATE,
          C_INPUT_WIDTH => C_INPUT_WIDTH,
          C_OUTPUT_WIDTH => C_OUTPUT_WIDTH,
          C_USE_DSP => C_USE_DSP,
	  C_HAS_ROUNDING => C_HAS_ROUNDING,
          C_NUM_CHANNELS => C_NUM_CHANNELS,
	  C_PIPE_SUBWORD_WIDTH => C_PIPE_SUBWORD_WIDTH,
          C_RATE_TYPE => C_RATE_TYPE,
          C_MIN_RATE => C_MIN_RATE,
          C_MAX_RATE => C_MAX_RATE,
          C_SAMPLE_FREQ => C_SAMPLE_FREQ,
          C_CLK_FREQ => C_CLK_FREQ,
	  C_OVERCLOCK => C_OVERCLOCK,
          C_HAS_CE => C_HAS_CE,
          C_HAS_SCLR => C_HAS_SCLR,
          C_FAMILY => C_XDEVICEFAMILY,
	  C_COMB_WIDTHS	=> (C_C1,C_C2,C_C3,C_C4,C_C5,C_C6),
	  C_INT_WIDTHS	=> (C_I1,C_I2,C_I3,C_I4,C_I5,C_I6),
	  C_LATENCY => C_LATENCY
          )
        port map ( 
          DIN => din,
          ND => nd,
          RATE => rate,
          RATE_WE => rate_we,
          CE => i_ce,
          SCLR => i_sclr,
          CLK => clk,
          DOUT => dout,
          RDY => rdy,
          RFD => rfd,
          CHAN_SYNC => chan_sync,
          CHAN_OUT => chan_out
          );
    end generate;
  
    interpolator : if C_FILTER_TYPE = 0 generate
      interpolation_filter : cic_compiler_v1_1_interpolate_bhv
        generic map ( 
          C_NUM_STAGES => C_NUM_STAGES,
          C_DIFF_DELAY => C_DIFF_DELAY,
          C_RATE => C_RATE,
          C_INPUT_WIDTH => C_INPUT_WIDTH,
          C_OUTPUT_WIDTH => C_OUTPUT_WIDTH,
          C_USE_DSP => C_USE_DSP,
	  C_HAS_ROUNDING => C_HAS_ROUNDING,
          C_NUM_CHANNELS => C_NUM_CHANNELS,
	  C_PIPE_SUBWORD_WIDTH => C_PIPE_SUBWORD_WIDTH,
          C_RATE_TYPE => C_RATE_TYPE,
          C_MIN_RATE => C_MIN_RATE,
          C_MAX_RATE => C_MAX_RATE,
          C_SAMPLE_FREQ => C_SAMPLE_FREQ,
          C_CLK_FREQ => C_CLK_FREQ,
	  C_OVERCLOCK => C_OVERCLOCK,
          C_HAS_CE => C_HAS_CE,
          C_HAS_SCLR => C_HAS_SCLR,
          C_FAMILY => C_XDEVICEFAMILY,
	  C_COMB_WIDTHS	=> (C_C1,C_C2,C_C3,C_C4,C_C5,C_C6),
	  C_INT_WIDTHS	=> (C_I1,C_I2,C_I3,C_I4,C_I5,C_I6),
	  C_LATENCY => C_LATENCY
          )
        port map ( 
          DIN => din,
          ND => nd,
          RATE => rate,
          RATE_WE => rate_we,
          CE => i_ce,
          SCLR => i_sclr,
          CLK => clk,
          DOUT => dout,
          RDY => rdy,
          RFD => rfd,
          CHAN_SYNC => chan_sync,
          CHAN_OUT => chan_out
          );
    end generate;

END behavioral;


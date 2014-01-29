-- $Id: xfft_v6_0_comp.vhd,v 1.2 2008/09/10 09:51:13 akennedy Exp $
--
--  Copyright(C) 2008 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2008 Xilinx, Inc.
--  All rights reserved.
------------------------------------------------------------------------------
-- Component statement for behavioral model
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package xfft_v6_0_comp is

  --core_if on component xfft_v6_0
  component xfft_v6_0
    generic (
      C_FAMILY             : string  := "virtex4";
      C_XDEVICEFAMILY      : string  := "virtex4";
      C_ELABORATION_DIR    : string  := "./";
      C_CHANNELS           : integer := 1;  -- Number of channels: 1-12 (ignored unless C_ARCH=4)
      C_NFFT_MAX           : integer := 10;  -- log2(maximum point size): 3-16
      C_ARCH               : integer := 1;  -- Architecture: 1=radix4, 2=radix2, 3=pipelined, 4=single output
      C_HAS_NFFT           : integer := 0;  -- Run-time configurable point size: 0=no, 1=yes
      C_USE_FLT_PT         : integer := 0;  -- Build a pseudo floating point single-precision FFT      
      C_INPUT_WIDTH        : integer := 16;  -- Input data width: 8-24 bits
      C_TWIDDLE_WIDTH      : integer := 16;  -- Twiddle factor width: 8-24 bits
      C_OUTPUT_WIDTH       : integer := 16;  -- Output data width: must be C_INPUT_WIDTH+C_NFFT_MAX+1 if C_HAS_SCALING=0, C_INPUT_WIDTH otherwise
      C_HAS_SCALING        : integer := 1;  -- Data is scaled after the butterfly: 0=no, 1=yes
      C_HAS_BFP            : integer := 0;  -- Type of scaling if C_HAS_SCALING=1: 0=set by SCALE_SCH input, 1=block floating point
      C_HAS_ROUNDING       : integer := 0;  -- Type of data rounding: 0=truncation, 1=unbiased rounding
      C_HAS_CE             : integer := 0;  -- Clock enable input present: 0=no, 1=yes
      C_HAS_SCLR           : integer := 0;  -- Synchronous clear input present: 0=no, 1=yes
      C_HAS_OVFLO          : integer := 0;  -- Overflow output present: 0=no, 1=yes (ignored unless C_HAS_SCALING=1 and C_HAS_BFP=0)
      C_HAS_NATURAL_INPUT  : integer := 1;  -- Input ordering: 0=bit/digit reversed order input, 1=natural order input      
      C_HAS_NATURAL_OUTPUT : integer := 0;  -- Output ordering: 0=bit/digit reversed order output, 1=natural order output
      C_HAS_CYCLIC_PREFIX  : integer := 0;  -- Optional cyclic prefix insertion: 0=no, 1=yes
      C_DATA_MEM_TYPE      : integer := 1;  -- Type of data memory: 0=distributed memory, 1=BRAM (ignored if C_ARCH=3)
      C_TWIDDLE_MEM_TYPE   : integer := 1;  -- Type of twiddle factor memory: 0=distributed memory, 1=BRAM (ignored if C_ARCH=3)
      C_BRAM_STAGES        : integer := 0;  -- Number of pipeline stages using BRAM for data and twiddle memories (C_ARCH=3 only)
      C_REORDER_MEM_TYPE   : integer := 1;  -- Type of reorder buffer memory: 0=distributed memory, 1=BRAM (C_ARCH=3 only)
      C_USE_HYBRID_RAM     : integer := 0;  -- Implement data memories using a hybrid BRAM/DistRAM structure if possible      
      C_OPTIMIZE_GOAL      : integer := 0;  -- Optimization goal: 0=minimum slices, 1=maximum clock frequency
      C_FAST_CMPY          : integer := 0;  -- Optimize complex multiplier for speed using DSP48s: 0=no, 1=yes
      C_OPTIMIZE           : integer := 0;  -- Optimize butterfly arithmetic for speed using DSP48s: 0=no, 1=yes
      C_FAST_SINCOS        : integer := 0;  -- Deprecated, ignored
      C_HAS_BYPASS         : integer := 1;  -- Deprecated, ignored
      C_ENABLE_RLOCS       : integer := 0   -- Deprecated, ignored
      );

    port (
      -- Ports differ significantly for single channel (C_CHANNELS = 1) and multichannel (C_CHANNELS > 1).
      -- This includes differently named ports for the first channel for single and multichannel.
      -- The reason for this is partly backward compatibility and partly user convenience and intuitive behaviour:
      -- single channel (backward compatible) has always had non-numbered ports (e.g. XN_RE not XN0_RE)
      -- so we want to retain that convention for single channel versions here;
      -- but for multichannel where ports for channels 1-11 are numbered 1-11, it is most intuitive for the ports
      -- for channel 0 to be numbered 0, rather than have no number.

      -- The SCALE_SCH input's width is determined as follows:
      -- arch 1 and 3 : width = C_NFFT_MAX rounded up to next even number
      -- arch 2 and 4 : width = C_NFFT_MAX * 2
      -- To avoid using a function to calculate this (which causes problems with
      -- package names or internal tools flows) we use a complex expression:
      -- (C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH MOD 2))
      --      |               |               |
      --   width for      adjust width     this evaluates to 0 when arch=2,4
      --   arch=2,4       for arch=1,3      and to 1 when arch=1,3

      -- Inputs independent of number of channels
      CLK       : in std_logic                               := '1';  -- Clock
      CE        : in std_logic                               := '1';  -- Clock enable (present if C_HAS_CE=1)
      SCLR      : in std_logic                               := '0';  -- Synchronous clear (present if C_HAS_SCLR=1)
      NFFT      : in std_logic_vector(4 downto 0)            := (others => '0');  -- log2(new point size) (present if C_HAS_NFFT=1)
      NFFT_WE   : in std_logic                               := '0';  -- Write enable for NFFT input (present if C_HAS_NFFT=1)
      START     : in std_logic                               := '0';  -- Start data loading and the FFT transform
      UNLOAD    : in std_logic                               := '0';  -- Start data unloading (present if C_HAS_NATURAL_OUTPUT=1)
      CP_LEN    : in std_logic_vector(C_NFFT_MAX-1 downto 0) := (others => '0');
      CP_LEN_WE : in std_logic                               := '0';

      -- Inputs for single channel (C_CHANNELS = 1)
      XN_RE        : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Input data, real part
      XN_IM        : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Input data, imaginary part
      FWD_INV      : in std_logic                                                                     := '0';  -- Transform direction: 0=inverse, 1=forward
      FWD_INV_WE   : in std_logic                                                                     := '0';  -- Write enable for FWD_INV input
      SCALE_SCH    : in std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH mod 2))-1 downto 0) := (others => '0');  -- Scaling schedule
      SCALE_SCH_WE : in std_logic                                                                     := '0';  -- Write enable for SCALE_SCH

      -- Inputs for multichannel (C_CHANNELS > 1)
      XN0_RE         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 0 input data, real part
      XN0_IM         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 0 input data, imaginary part
      XN1_RE         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 1 input data, real part
      XN1_IM         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 1 input data, imaginary part
      XN2_RE         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 2 input data, real part
      XN2_IM         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 2 input data, imaginary part
      XN3_RE         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 3 input data, real part
      XN3_IM         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 3 input data, imaginary part
      XN4_RE         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 4 input data, real part
      XN4_IM         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 4 input data, imaginary part
      XN5_RE         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 5 input data, real part
      XN5_IM         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 5 input data, imaginary part
      XN6_RE         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 6 input data, real part
      XN6_IM         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 6 input data, imaginary part
      XN7_RE         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 7 input data, real part
      XN7_IM         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 7 input data, imaginary part
      XN8_RE         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 8 input data, real part
      XN8_IM         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 8 input data, imaginary part
      XN9_RE         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 9 input data, real part
      XN9_IM         : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 9 input data, imaginary part
      XN10_RE        : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 10 input data, real part
      XN10_IM        : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 10 input data, imaginary part
      XN11_RE        : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 11 input data, real part
      XN11_IM        : in std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 11 input data, imaginary part
      FWD_INV0       : in std_logic                                                                     := '1';  -- Channel 0 transform direction: 0=inverse, 1=forward
      FWD_INV0_WE    : in std_logic                                                                     := '0';  -- Channel 0 write enable for FWD_INV
      FWD_INV1       : in std_logic                                                                     := '1';  -- Channel 1 transform direction: 0=inverse, 1=forward
      FWD_INV1_WE    : in std_logic                                                                     := '0';  -- Channel 1 write enable for FWD_INV
      FWD_INV2       : in std_logic                                                                     := '1';  -- Channel 2 transform direction: 0=inverse, 1=forward
      FWD_INV2_WE    : in std_logic                                                                     := '0';  -- Channel 2 write enable for FWD_INV
      FWD_INV3       : in std_logic                                                                     := '1';  -- Channel 3 transform direction: 0=inverse, 1=forward
      FWD_INV3_WE    : in std_logic                                                                     := '0';  -- Channel 3 write enable for FWD_INV
      FWD_INV4       : in std_logic                                                                     := '1';  -- Channel 4 transform direction: 0=inverse, 1=forward
      FWD_INV4_WE    : in std_logic                                                                     := '0';  -- Channel 4 write enable for FWD_INV
      FWD_INV5       : in std_logic                                                                     := '1';  -- Channel 5 transform direction: 0=inverse, 1=forward
      FWD_INV5_WE    : in std_logic                                                                     := '0';  -- Channel 5 write enable for FWD_INV
      FWD_INV6       : in std_logic                                                                     := '1';  -- Channel 6 transform direction: 0=inverse, 1=forward
      FWD_INV6_WE    : in std_logic                                                                     := '0';  -- Channel 6 write enable for FWD_INV
      FWD_INV7       : in std_logic                                                                     := '1';  -- Channel 7 transform direction: 0=inverse, 1=forward
      FWD_INV7_WE    : in std_logic                                                                     := '0';  -- Channel 7 write enable for FWD_INV
      FWD_INV8       : in std_logic                                                                     := '1';  -- Channel 8 transform direction: 0=inverse, 1=forward
      FWD_INV8_WE    : in std_logic                                                                     := '0';  -- Channel 8 write enable for FWD_INV
      FWD_INV9       : in std_logic                                                                     := '1';  -- Channel 9 transform direction: 0=inverse, 1=forward
      FWD_INV9_WE    : in std_logic                                                                     := '0';  -- Channel 9 write enable for FWD_INV
      FWD_INV10      : in std_logic                                                                     := '1';  -- Channel 10 transform direction: 0=inverse, 1=forward
      FWD_INV10_WE   : in std_logic                                                                     := '0';  -- Channel 10 write enable for FWD_INV
      FWD_INV11      : in std_logic                                                                     := '1';  -- Channel 11 transform direction: 0=inverse, 1=forward
      FWD_INV11_WE   : in std_logic                                                                     := '0';  -- Channel 11 write enable for FWD_INV
      SCALE_SCH0     : in std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH mod 2))-1 downto 0) := (others => '0');  -- Channel 0 scaling schedule
      SCALE_SCH0_WE  : in std_logic                                                                     := '0';  -- Channel 0 write enable for SCALE_SCH
      SCALE_SCH1     : in std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH mod 2))-1 downto 0) := (others => '0');  -- Channel 1 scaling schedule
      SCALE_SCH1_WE  : in std_logic                                                                     := '0';  -- Channel 1 write enable for SCALE_SCH
      SCALE_SCH2     : in std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH mod 2))-1 downto 0) := (others => '0');  -- Channel 2 scaling schedule
      SCALE_SCH2_WE  : in std_logic                                                                     := '0';  -- Channel 2 write enable for SCALE_SCH
      SCALE_SCH3     : in std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH mod 2))-1 downto 0) := (others => '0');  -- Channel 3 scaling schedule
      SCALE_SCH3_WE  : in std_logic                                                                     := '0';  -- Channel 3 write enable for SCALE_SCH
      SCALE_SCH4     : in std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH mod 2))-1 downto 0) := (others => '0');  -- Channel 4 scaling schedule
      SCALE_SCH4_WE  : in std_logic                                                                     := '0';  -- Channel 4 write enable for SCALE_SCH
      SCALE_SCH5     : in std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH mod 2))-1 downto 0) := (others => '0');  -- Channel 5 scaling schedule
      SCALE_SCH5_WE  : in std_logic                                                                     := '0';  -- Channel 5 write enable for SCALE_SCH
      SCALE_SCH6     : in std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH mod 2))-1 downto 0) := (others => '0');  -- Channel 6 scaling schedule
      SCALE_SCH6_WE  : in std_logic                                                                     := '0';  -- Channel 6 write enable for SCALE_SCH
      SCALE_SCH7     : in std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH mod 2))-1 downto 0) := (others => '0');  -- Channel 7 scaling schedule
      SCALE_SCH7_WE  : in std_logic                                                                     := '0';  -- Channel 7 write enable for SCALE_SCH
      SCALE_SCH8     : in std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH mod 2))-1 downto 0) := (others => '0');  -- Channel 8 scaling schedule
      SCALE_SCH8_WE  : in std_logic                                                                     := '0';  -- Channel 8 write enable for SCALE_SCH
      SCALE_SCH9     : in std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH mod 2))-1 downto 0) := (others => '0');  -- Channel 9 scaling schedule
      SCALE_SCH9_WE  : in std_logic                                                                     := '0';  -- Channel 9 write enable for SCALE_SCH
      SCALE_SCH10    : in std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH mod 2))-1 downto 0) := (others => '0');  -- Channel 10 scaling schedule
      SCALE_SCH10_WE : in std_logic                                                                     := '0';  -- Channel 10 write enable for SCALE_SCH
      SCALE_SCH11    : in std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH mod 2))-1 downto 0) := (others => '0');  -- Channel 11 scaling schedule
      SCALE_SCH11_WE : in std_logic                                                                     := '0';  -- Channel 11 write enable for SCALE_SCH

      -- Outputs independent of number of channels
      RFD      : out std_logic;         -- Ready for data: XN_INDEX is valid
      XN_INDEX : out std_logic_vector(C_NFFT_MAX-1 downto 0);  -- Input data sample number (precedes input data by 3 clock cycles)
      BUSY     : out std_logic;         -- Transform is in progress
      EDONE    : out std_logic;  -- Early indication of end of transform, 1 clock cycle before DONE
      DONE     : out std_logic;  -- Indicates the end of the transform, so data can be unloaded
      DV       : out std_logic;  -- Data valid: XK_RE, XK_IM and XK_INDEX are valid
      XK_INDEX : out std_logic_vector(C_NFFT_MAX-1 downto 0);  -- Output data sample number
      CPV      : out std_logic;         -- Cyclic prefix valid
      RFS      : out std_logic;  -- Ready for start: applies to streaming architecture (only) when C_HAS_CYCLIC_PREFIX=1

      -- Outputs for single channel (C_CHANNELS = 1)
      XK_RE   : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Output data, real part
      XK_IM   : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Output data, imaginary part
      BLK_EXP : out std_logic_vector(4 downto 0);  -- Block exponent
      OVFLO   : out std_logic;          -- Overflow occurred

      -- Outputs for multichannel (C_CHANNELS > 1)
      XK0_RE    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 0 output data, real part
      XK0_IM    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 0 output data, imaginary part
      XK1_RE    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 1 output data, real part
      XK1_IM    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 1 output data, imaginary part
      XK2_RE    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 2 output data, real part
      XK2_IM    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 2 output data, imaginary part
      XK3_RE    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 3 output data, real part
      XK3_IM    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 3 output data, imaginary part
      XK4_RE    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 4 output data, real part
      XK4_IM    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 4 output data, imaginary part
      XK5_RE    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 5 output data, real part
      XK5_IM    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 5 output data, imaginary part
      XK6_RE    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 6 output data, real part
      XK6_IM    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 6 output data, imaginary part
      XK7_RE    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 7 output data, real part
      XK7_IM    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 7 output data, imaginary part
      XK8_RE    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 8 output data, real part
      XK8_IM    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 8 output data, imaginary part
      XK9_RE    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 9 output data, real part
      XK9_IM    : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 9 output data, imaginary part
      XK10_RE   : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 10 output data, real part
      XK10_IM   : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 10 output data, imaginary part
      XK11_RE   : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 11 output data, real part
      XK11_IM   : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);  -- Channel 11 output data, imaginary part
      BLK_EXP0  : out std_logic_vector(4 downto 0);  -- Channel 0 block exponent
      BLK_EXP1  : out std_logic_vector(4 downto 0);  -- Channel 1 block exponent
      BLK_EXP2  : out std_logic_vector(4 downto 0);  -- Channel 2 block exponent
      BLK_EXP3  : out std_logic_vector(4 downto 0);  -- Channel 3 block exponent
      BLK_EXP4  : out std_logic_vector(4 downto 0);  -- Channel 4 block exponent
      BLK_EXP5  : out std_logic_vector(4 downto 0);  -- Channel 5 block exponent
      BLK_EXP6  : out std_logic_vector(4 downto 0);  -- Channel 6 block exponent
      BLK_EXP7  : out std_logic_vector(4 downto 0);  -- Channel 7 block exponent
      BLK_EXP8  : out std_logic_vector(4 downto 0);  -- Channel 8 block exponent
      BLK_EXP9  : out std_logic_vector(4 downto 0);  -- Channel 9 block exponent
      BLK_EXP10 : out std_logic_vector(4 downto 0);  -- Channel 10 block exponent
      BLK_EXP11 : out std_logic_vector(4 downto 0);  -- Channel 11 block exponent
      OVFLO0    : out std_logic;        -- Channel 0 overflow occurred
      OVFLO1    : out std_logic;        -- Channel 1 overflow occurred
      OVFLO2    : out std_logic;        -- Channel 2 overflow occurred
      OVFLO3    : out std_logic;        -- Channel 3 overflow occurred
      OVFLO4    : out std_logic;        -- Channel 4 overflow occurred
      OVFLO5    : out std_logic;        -- Channel 5 overflow occurred
      OVFLO6    : out std_logic;        -- Channel 6 overflow occurred
      OVFLO7    : out std_logic;        -- Channel 7 overflow occurred
      OVFLO8    : out std_logic;        -- Channel 8 overflow occurred
      OVFLO9    : out std_logic;        -- Channel 9 overflow occurred
      OVFLO10   : out std_logic;        -- Channel 10 overflow occurred
      OVFLO11   : out std_logic         -- Channel 11 overflow occurred
      );
  --core_if off
  end component;
  -- The following tells XST that xfft_v6_0 is a black box which
  -- should be generated command given by the value of this attribute
  -- Note the fully qualified SIM (JAVA class) name that forms the
  -- basis of the core

  -- xcc exclude
  attribute box_type                       : string;
  attribute generator_default              : string;
  attribute box_type of xfft_v6_0          : component is "black_box";
  attribute generator_default of xfft_v6_0 : component is "generatecore com.xilinx.ip.xfft_v6_0.xfft_v6_0";
  -- xcc include

end xfft_v6_0_comp;

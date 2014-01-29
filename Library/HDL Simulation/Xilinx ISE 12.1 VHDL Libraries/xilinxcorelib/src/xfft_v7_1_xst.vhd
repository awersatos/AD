-- $RCSfile: xfft_v7_1_xst.vhd,v $ $Revision: 1.1.2.1 $ $Date: 2010/03/09 12:16:02 $
--
--  (c) Copyright 1995-2010 Xilinx, Inc. All rights reserved.
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
------------------------------------------------------------------------------
-- Wrapper for behavioral model
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library XilinxCoreLib;
use Xilinxcorelib.xfft_v7_1_comp.all;

--core_if on entity xfft_v7_1_xst
  entity xfft_v7_1_xst is
    generic (
      C_XDEVICEFAMILY      : string  := "no_family";
      C_CHANNELS           : integer := 1;            -- Number of channels: 1-12 (ignored unless C_ARCH=4)
      C_NFFT_MAX           : integer := 10;           -- log2(maximum point size): 3-16
      C_ARCH               : integer := 1;            -- Architecture: 1=radix4, 2=radix2, 3=pipelined, 4=single output
      C_HAS_NFFT           : integer := 0;            -- Run-time configurable point size: 0=no, 1=yes
      C_USE_FLT_PT         : integer := 0;            -- Build a pseudo floating point single-precision FFT
      C_INPUT_WIDTH        : integer := 16;           -- Input data width: 8-34 bits
      C_TWIDDLE_WIDTH      : integer := 16;           -- Twiddle factor width: 8-34 bits
      C_OUTPUT_WIDTH       : integer := 16;           -- Output data width: must be C_INPUT_WIDTH+C_NFFT_MAX+1 if C_HAS_SCALING=0, C_INPUT_WIDTH otherwise
      C_HAS_SCALING        : integer := 1;            -- Data is scaled after the butterfly: 0=no, 1=yes
      C_HAS_BFP            : integer := 0;            -- Type of scaling if C_HAS_SCALING=1: 0=set by SCALE_SCH input, 1=block floating point
      C_HAS_ROUNDING       : integer := 0;            -- Type of data rounding: 0=truncation, 1=unbiased rounding
      C_HAS_CE             : integer := 0;            -- Clock enable input present: 0=no, 1=yes
      C_HAS_SCLR           : integer := 0;            -- Synchronous clear input present: 0=no, 1=yes
      C_HAS_OVFLO          : integer := 0;            -- Overflow output present: 0=no, 1=yes (ignored unless C_HAS_SCALING=1 and C_HAS_BFP=0)
      C_HAS_NATURAL_INPUT  : integer := 1;            -- Input ordering: 0=bit/digit reversed order input, 1=natural order input
      C_HAS_NATURAL_OUTPUT : integer := 0;            -- Output ordering: 0=bit/digit reversed order output, 1=natural order output
      C_HAS_CYCLIC_PREFIX  : integer := 0;            -- Optional cyclic prefix insertion: 0=no, 1=yes
      C_DATA_MEM_TYPE      : integer := 1;            -- Type of data memory: 0=distributed memory, 1=BRAM (ignored if C_ARCH=3)
      C_TWIDDLE_MEM_TYPE   : integer := 1;            -- Type of twiddle factor memory: 0=distributed memory, 1=BRAM (ignored if C_ARCH=3)
      C_BRAM_STAGES        : integer := 0;            -- Number of pipeline stages using BRAM for data and twiddle memories (C_ARCH=3 only)
      C_REORDER_MEM_TYPE   : integer := 1;            -- Type of reorder buffer memory: 0=distributed memory, 1=BRAM (C_ARCH=3 only)
      C_USE_HYBRID_RAM     : integer := 0;            -- Implement data memories using a hybrid BRAM/DistRAM structure if possible
      C_OPTIMIZE_GOAL      : integer := 0;            -- Optimization goal: 0=minimum slices, 1=maximum clock frequency
      C_CMPY_TYPE          : integer := 0;            -- 0=Use LUTs, 1=Use Mults/DSPs (3-mult structure), 2=Use Mults/DSPs (4-mult structure)
      C_BFLY_TYPE          : integer := 0;            -- Optimize butterfly arithmetic for speed using DSP48s: 0=no, 1=yes
      C_XN_DATA_OFFSET     : integer := 0             -- 0=no offset between XN_INDEX and applying XN_RE/IM data, 1=apply XN_RE/IM 3 cycles after relevant XN_INDEX
      );
    port (
      CLK            : in  std_logic                                                                     := '1';              -- Clock
      CE             : in  std_logic                                                                     := '1';              -- Clock enable (present if C_HAS_CE=1)
      SCLR           : in  std_logic                                                                     := '0';              -- Synchronous clear (present if C_HAS_SCLR=1)
      NFFT           : in  std_logic_vector(4 downto 0)                                                  := (others => '0');  -- log2(new point size) (present if C_HAS_NFFT=1)
      NFFT_WE        : in  std_logic                                                                     := '0';              -- Write enable for NFFT input (present if C_HAS_NFFT=1)
      START          : in  std_logic                                                                     := '0';              -- Start data loading and the FFT transform
      UNLOAD         : in  std_logic                                                                     := '0';              -- Start data unloading (present if C_HAS_NATURAL_OUTPUT=1)
      CP_LEN         : in  std_logic_vector(C_NFFT_MAX-1 downto 0)                                       := (others => '0');
      CP_LEN_WE      : in  std_logic                                                                     := '0';
      XN_RE          : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Input data, real part
      XN_IM          : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Input data, imaginary part
      FWD_INV        : in  std_logic                                                                     := '0';              -- Transform direction: 0=inverse, 1=forward
      FWD_INV_WE     : in  std_logic                                                                     := '0';              -- Write enable for FWD_INV input
      SCALE_SCH      : in  std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH MOD 2))-1 downto 0) := (others => '0');  -- Scaling schedule
      SCALE_SCH_WE   : in  std_logic                                                                     := '0';              -- Write enable for SCALE_SCH
      XN0_RE         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 0 input data, real part
      XN0_IM         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 0 input data, imaginary part
      XN1_RE         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 1 input data, real part
      XN1_IM         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 1 input data, imaginary part
      XN2_RE         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 2 input data, real part
      XN2_IM         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 2 input data, imaginary part
      XN3_RE         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 3 input data, real part
      XN3_IM         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 3 input data, imaginary part
      XN4_RE         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 4 input data, real part
      XN4_IM         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 4 input data, imaginary part
      XN5_RE         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 5 input data, real part
      XN5_IM         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 5 input data, imaginary part
      XN6_RE         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 6 input data, real part
      XN6_IM         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 6 input data, imaginary part
      XN7_RE         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 7 input data, real part
      XN7_IM         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 7 input data, imaginary part
      XN8_RE         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 8 input data, real part
      XN8_IM         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 8 input data, imaginary part
      XN9_RE         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 9 input data, real part
      XN9_IM         : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 9 input data, imaginary part
      XN10_RE        : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 10 input data, real part
      XN10_IM        : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 10 input data, imaginary part
      XN11_RE        : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 11 input data, real part
      XN11_IM        : in  std_logic_vector(C_INPUT_WIDTH-1 downto 0)                                    := (others => '0');  -- Channel 11 input data, imaginary part
      FWD_INV0       : in  std_logic                                                                     := '1';              -- Channel 0 transform direction: 0=inverse, 1=forward
      FWD_INV0_WE    : in  std_logic                                                                     := '0';              -- Channel 0 write enable for FWD_INV
      FWD_INV1       : in  std_logic                                                                     := '1';              -- Channel 1 transform direction: 0=inverse, 1=forward
      FWD_INV1_WE    : in  std_logic                                                                     := '0';              -- Channel 1 write enable for FWD_INV
      FWD_INV2       : in  std_logic                                                                     := '1';              -- Channel 2 transform direction: 0=inverse, 1=forward
      FWD_INV2_WE    : in  std_logic                                                                     := '0';              -- Channel 2 write enable for FWD_INV
      FWD_INV3       : in  std_logic                                                                     := '1';              -- Channel 3 transform direction: 0=inverse, 1=forward
      FWD_INV3_WE    : in  std_logic                                                                     := '0';              -- Channel 3 write enable for FWD_INV
      FWD_INV4       : in  std_logic                                                                     := '1';              -- Channel 4 transform direction: 0=inverse, 1=forward
      FWD_INV4_WE    : in  std_logic                                                                     := '0';              -- Channel 4 write enable for FWD_INV
      FWD_INV5       : in  std_logic                                                                     := '1';              -- Channel 5 transform direction: 0=inverse, 1=forward
      FWD_INV5_WE    : in  std_logic                                                                     := '0';              -- Channel 5 write enable for FWD_INV
      FWD_INV6       : in  std_logic                                                                     := '1';              -- Channel 6 transform direction: 0=inverse, 1=forward
      FWD_INV6_WE    : in  std_logic                                                                     := '0';              -- Channel 6 write enable for FWD_INV
      FWD_INV7       : in  std_logic                                                                     := '1';              -- Channel 7 transform direction: 0=inverse, 1=forward
      FWD_INV7_WE    : in  std_logic                                                                     := '0';              -- Channel 7 write enable for FWD_INV
      FWD_INV8       : in  std_logic                                                                     := '1';              -- Channel 8 transform direction: 0=inverse, 1=forward
      FWD_INV8_WE    : in  std_logic                                                                     := '0';              -- Channel 8 write enable for FWD_INV
      FWD_INV9       : in  std_logic                                                                     := '1';              -- Channel 9 transform direction: 0=inverse, 1=forward
      FWD_INV9_WE    : in  std_logic                                                                     := '0';              -- Channel 9 write enable for FWD_INV
      FWD_INV10      : in  std_logic                                                                     := '1';              -- Channel 10 transform direction: 0=inverse, 1=forward
      FWD_INV10_WE   : in  std_logic                                                                     := '0';              -- Channel 10 write enable for FWD_INV
      FWD_INV11      : in  std_logic                                                                     := '1';              -- Channel 11 transform direction: 0=inverse, 1=forward
      FWD_INV11_WE   : in  std_logic                                                                     := '0';              -- Channel 11 write enable for FWD_INV
      SCALE_SCH0     : in  std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH MOD 2))-1 downto 0) := (others => '0');  -- Channel 0 scaling schedule
      SCALE_SCH0_WE  : in  std_logic                                                                     := '0';              -- Channel 0 write enable for SCALE_SCH
      SCALE_SCH1     : in  std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH MOD 2))-1 downto 0) := (others => '0');  -- Channel 1 scaling schedule
      SCALE_SCH1_WE  : in  std_logic                                                                     := '0';              -- Channel 1 write enable for SCALE_SCH
      SCALE_SCH2     : in  std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH MOD 2))-1 downto 0) := (others => '0');  -- Channel 2 scaling schedule
      SCALE_SCH2_WE  : in  std_logic                                                                     := '0';              -- Channel 2 write enable for SCALE_SCH
      SCALE_SCH3     : in  std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH MOD 2))-1 downto 0) := (others => '0');  -- Channel 3 scaling schedule
      SCALE_SCH3_WE  : in  std_logic                                                                     := '0';              -- Channel 3 write enable for SCALE_SCH
      SCALE_SCH4     : in  std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH MOD 2))-1 downto 0) := (others => '0');  -- Channel 4 scaling schedule
      SCALE_SCH4_WE  : in  std_logic                                                                     := '0';              -- Channel 4 write enable for SCALE_SCH
      SCALE_SCH5     : in  std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH MOD 2))-1 downto 0) := (others => '0');  -- Channel 5 scaling schedule
      SCALE_SCH5_WE  : in  std_logic                                                                     := '0';              -- Channel 5 write enable for SCALE_SCH
      SCALE_SCH6     : in  std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH MOD 2))-1 downto 0) := (others => '0');  -- Channel 6 scaling schedule
      SCALE_SCH6_WE  : in  std_logic                                                                     := '0';              -- Channel 6 write enable for SCALE_SCH
      SCALE_SCH7     : in  std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH MOD 2))-1 downto 0) := (others => '0');  -- Channel 7 scaling schedule
      SCALE_SCH7_WE  : in  std_logic                                                                     := '0';              -- Channel 7 write enable for SCALE_SCH
      SCALE_SCH8     : in  std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH MOD 2))-1 downto 0) := (others => '0');  -- Channel 8 scaling schedule
      SCALE_SCH8_WE  : in  std_logic                                                                     := '0';              -- Channel 8 write enable for SCALE_SCH
      SCALE_SCH9     : in  std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH MOD 2))-1 downto 0) := (others => '0');  -- Channel 9 scaling schedule
      SCALE_SCH9_WE  : in  std_logic                                                                     := '0';              -- Channel 9 write enable for SCALE_SCH
      SCALE_SCH10    : in  std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH MOD 2))-1 downto 0) := (others => '0');  -- Channel 10 scaling schedule
      SCALE_SCH10_WE : in  std_logic                                                                     := '0';              -- Channel 10 write enable for SCALE_SCH
      SCALE_SCH11    : in  std_logic_vector((C_NFFT_MAX*2)-((C_NFFT_MAX/2*2)*(C_ARCH MOD 2))-1 downto 0) := (others => '0');  -- Channel 11 scaling schedule
      SCALE_SCH11_WE : in  std_logic                                                                     := '0';              -- Channel 11 write enable for SCALE_SCH
      RFD            : out std_logic;                                                                                         -- Ready for data: XN_INDEX is valid
      XN_INDEX       : out std_logic_vector(C_NFFT_MAX-1 downto 0);                                                           -- Input data sample number (precedes input data by 3 clock cycles)
      BUSY           : out std_logic;                                                                                         -- Transform is in progress
      EDONE          : out std_logic;                                                                                         -- Early indication of end of transform, 1 clock cycle before DONE
      DONE           : out std_logic;                                                                                         -- Indicates the end of the transform, so data can be unloaded
      DV             : out std_logic;                                                                                         -- Data valid: XK_RE, XK_IM and XK_INDEX are valid
      XK_INDEX       : out std_logic_vector(C_NFFT_MAX-1 downto 0);                                                           -- Output data sample number
      CPV            : out std_logic;                                                                                         -- Cyclic prefix valid
      RFS            : out std_logic;                                                                                         -- Ready for start: applies to streaming architecture (only) when C_HAS_CYCLIC_PREFIX=1
      XK_RE          : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Output data, real part
      XK_IM          : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Output data, imaginary part
      BLK_EXP        : out std_logic_vector(4 downto 0);                                                                      -- Block exponent
      OVFLO          : out std_logic;                                                                                         -- Overflow occurred
      XK0_RE         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 0 output data, real part
      XK0_IM         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 0 output data, imaginary part
      XK1_RE         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 1 output data, real part
      XK1_IM         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 1 output data, imaginary part
      XK2_RE         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 2 output data, real part
      XK2_IM         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 2 output data, imaginary part
      XK3_RE         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 3 output data, real part
      XK3_IM         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 3 output data, imaginary part
      XK4_RE         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 4 output data, real part
      XK4_IM         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 4 output data, imaginary part
      XK5_RE         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 5 output data, real part
      XK5_IM         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 5 output data, imaginary part
      XK6_RE         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 6 output data, real part
      XK6_IM         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 6 output data, imaginary part
      XK7_RE         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 7 output data, real part
      XK7_IM         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 7 output data, imaginary part
      XK8_RE         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 8 output data, real part
      XK8_IM         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 8 output data, imaginary part
      XK9_RE         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 9 output data, real part
      XK9_IM         : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 9 output data, imaginary part
      XK10_RE        : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 10 output data, real part
      XK10_IM        : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 10 output data, imaginary part
      XK11_RE        : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 11 output data, real part
      XK11_IM        : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);                                                       -- Channel 11 output data, imaginary part
      BLK_EXP0       : out std_logic_vector(4 downto 0);                                                                      -- Channel 0 block exponent
      BLK_EXP1       : out std_logic_vector(4 downto 0);                                                                      -- Channel 1 block exponent
      BLK_EXP2       : out std_logic_vector(4 downto 0);                                                                      -- Channel 2 block exponent
      BLK_EXP3       : out std_logic_vector(4 downto 0);                                                                      -- Channel 3 block exponent
      BLK_EXP4       : out std_logic_vector(4 downto 0);                                                                      -- Channel 4 block exponent
      BLK_EXP5       : out std_logic_vector(4 downto 0);                                                                      -- Channel 5 block exponent
      BLK_EXP6       : out std_logic_vector(4 downto 0);                                                                      -- Channel 6 block exponent
      BLK_EXP7       : out std_logic_vector(4 downto 0);                                                                      -- Channel 7 block exponent
      BLK_EXP8       : out std_logic_vector(4 downto 0);                                                                      -- Channel 8 block exponent
      BLK_EXP9       : out std_logic_vector(4 downto 0);                                                                      -- Channel 9 block exponent
      BLK_EXP10      : out std_logic_vector(4 downto 0);                                                                      -- Channel 10 block exponent
      BLK_EXP11      : out std_logic_vector(4 downto 0);                                                                      -- Channel 11 block exponent
      OVFLO0         : out std_logic;                                                                                         -- Channel 0 overflow occurred
      OVFLO1         : out std_logic;                                                                                         -- Channel 1 overflow occurred
      OVFLO2         : out std_logic;                                                                                         -- Channel 2 overflow occurred
      OVFLO3         : out std_logic;                                                                                         -- Channel 3 overflow occurred
      OVFLO4         : out std_logic;                                                                                         -- Channel 4 overflow occurred
      OVFLO5         : out std_logic;                                                                                         -- Channel 5 overflow occurred
      OVFLO6         : out std_logic;                                                                                         -- Channel 6 overflow occurred
      OVFLO7         : out std_logic;                                                                                         -- Channel 7 overflow occurred
      OVFLO8         : out std_logic;                                                                                         -- Channel 8 overflow occurred
      OVFLO9         : out std_logic;                                                                                         -- Channel 9 overflow occurred
      OVFLO10        : out std_logic;                                                                                         -- Channel 10 overflow occurred
      OVFLO11        : out std_logic                                                                                          -- Channel 11 overflow occurred
      );
--core_if off
end xfft_v7_1_xst;


architecture behavioral of xfft_v7_1_xst is

begin
  --core_if on instance i_behv xfft_v7_1
  i_behv : xfft_v7_1
    generic map (
      C_XDEVICEFAMILY      => C_XDEVICEFAMILY,
      C_CHANNELS           => C_CHANNELS,
      C_NFFT_MAX           => C_NFFT_MAX,
      C_ARCH               => C_ARCH,
      C_HAS_NFFT           => C_HAS_NFFT,
      C_USE_FLT_PT         => C_USE_FLT_PT,
      C_INPUT_WIDTH        => C_INPUT_WIDTH,
      C_TWIDDLE_WIDTH      => C_TWIDDLE_WIDTH,
      C_OUTPUT_WIDTH       => C_OUTPUT_WIDTH,
      C_HAS_SCALING        => C_HAS_SCALING,
      C_HAS_BFP            => C_HAS_BFP,
      C_HAS_ROUNDING       => C_HAS_ROUNDING,
      C_HAS_CE             => C_HAS_CE,
      C_HAS_SCLR           => C_HAS_SCLR,
      C_HAS_OVFLO          => C_HAS_OVFLO,
      C_HAS_NATURAL_INPUT  => C_HAS_NATURAL_INPUT,
      C_HAS_NATURAL_OUTPUT => C_HAS_NATURAL_OUTPUT,
      C_HAS_CYCLIC_PREFIX  => C_HAS_CYCLIC_PREFIX,
      C_DATA_MEM_TYPE      => C_DATA_MEM_TYPE,
      C_TWIDDLE_MEM_TYPE   => C_TWIDDLE_MEM_TYPE,
      C_BRAM_STAGES        => C_BRAM_STAGES,
      C_REORDER_MEM_TYPE   => C_REORDER_MEM_TYPE,
      C_USE_HYBRID_RAM     => C_USE_HYBRID_RAM,
      C_OPTIMIZE_GOAL      => C_OPTIMIZE_GOAL,
      C_CMPY_TYPE          => C_CMPY_TYPE,
      C_BFLY_TYPE          => C_BFLY_TYPE,
      C_XN_DATA_OFFSET     => C_XN_DATA_OFFSET
      )
    port map (
      CLK            => CLK,
      CE             => CE,
      SCLR           => SCLR,
      NFFT           => NFFT,
      NFFT_WE        => NFFT_WE,
      START          => START,
      UNLOAD         => UNLOAD,
      CP_LEN         => CP_LEN,
      CP_LEN_WE      => CP_LEN_WE,
      XN_RE          => XN_RE,
      XN_IM          => XN_IM,
      FWD_INV        => FWD_INV,
      FWD_INV_WE     => FWD_INV_WE,
      SCALE_SCH      => SCALE_SCH,
      SCALE_SCH_WE   => SCALE_SCH_WE,
      XN0_RE         => XN0_RE,
      XN0_IM         => XN0_IM,
      XN1_RE         => XN1_RE,
      XN1_IM         => XN1_IM,
      XN2_RE         => XN2_RE,
      XN2_IM         => XN2_IM,
      XN3_RE         => XN3_RE,
      XN3_IM         => XN3_IM,
      XN4_RE         => XN4_RE,
      XN4_IM         => XN4_IM,
      XN5_RE         => XN5_RE,
      XN5_IM         => XN5_IM,
      XN6_RE         => XN6_RE,
      XN6_IM         => XN6_IM,
      XN7_RE         => XN7_RE,
      XN7_IM         => XN7_IM,
      XN8_RE         => XN8_RE,
      XN8_IM         => XN8_IM,
      XN9_RE         => XN9_RE,
      XN9_IM         => XN9_IM,
      XN10_RE        => XN10_RE,
      XN10_IM        => XN10_IM,
      XN11_RE        => XN11_RE,
      XN11_IM        => XN11_IM,
      FWD_INV0       => FWD_INV0,
      FWD_INV0_WE    => FWD_INV0_WE,
      FWD_INV1       => FWD_INV1,
      FWD_INV1_WE    => FWD_INV1_WE,
      FWD_INV2       => FWD_INV2,
      FWD_INV2_WE    => FWD_INV2_WE,
      FWD_INV3       => FWD_INV3,
      FWD_INV3_WE    => FWD_INV3_WE,
      FWD_INV4       => FWD_INV4,
      FWD_INV4_WE    => FWD_INV4_WE,
      FWD_INV5       => FWD_INV5,
      FWD_INV5_WE    => FWD_INV5_WE,
      FWD_INV6       => FWD_INV6,
      FWD_INV6_WE    => FWD_INV6_WE,
      FWD_INV7       => FWD_INV7,
      FWD_INV7_WE    => FWD_INV7_WE,
      FWD_INV8       => FWD_INV8,
      FWD_INV8_WE    => FWD_INV8_WE,
      FWD_INV9       => FWD_INV9,
      FWD_INV9_WE    => FWD_INV9_WE,
      FWD_INV10      => FWD_INV10,
      FWD_INV10_WE   => FWD_INV10_WE,
      FWD_INV11      => FWD_INV11,
      FWD_INV11_WE   => FWD_INV11_WE,
      SCALE_SCH0     => SCALE_SCH0,
      SCALE_SCH0_WE  => SCALE_SCH0_WE,
      SCALE_SCH1     => SCALE_SCH1,
      SCALE_SCH1_WE  => SCALE_SCH1_WE,
      SCALE_SCH2     => SCALE_SCH2,
      SCALE_SCH2_WE  => SCALE_SCH2_WE,
      SCALE_SCH3     => SCALE_SCH3,
      SCALE_SCH3_WE  => SCALE_SCH3_WE,
      SCALE_SCH4     => SCALE_SCH4,
      SCALE_SCH4_WE  => SCALE_SCH4_WE,
      SCALE_SCH5     => SCALE_SCH5,
      SCALE_SCH5_WE  => SCALE_SCH5_WE,
      SCALE_SCH6     => SCALE_SCH6,
      SCALE_SCH6_WE  => SCALE_SCH6_WE,
      SCALE_SCH7     => SCALE_SCH7,
      SCALE_SCH7_WE  => SCALE_SCH7_WE,
      SCALE_SCH8     => SCALE_SCH8,
      SCALE_SCH8_WE  => SCALE_SCH8_WE,
      SCALE_SCH9     => SCALE_SCH9,
      SCALE_SCH9_WE  => SCALE_SCH9_WE,
      SCALE_SCH10    => SCALE_SCH10,
      SCALE_SCH10_WE => SCALE_SCH10_WE,
      SCALE_SCH11    => SCALE_SCH11,
      SCALE_SCH11_WE => SCALE_SCH11_WE,
      RFD            => RFD,
      XN_INDEX       => XN_INDEX,
      BUSY           => BUSY,
      EDONE          => EDONE,
      DONE           => DONE,
      DV             => DV,
      XK_INDEX       => XK_INDEX,
      CPV            => CPV,
      RFS            => RFS,
      XK_RE          => XK_RE,
      XK_IM          => XK_IM,
      BLK_EXP        => BLK_EXP,
      OVFLO          => OVFLO,
      XK0_RE         => XK0_RE,
      XK0_IM         => XK0_IM,
      XK1_RE         => XK1_RE,
      XK1_IM         => XK1_IM,
      XK2_RE         => XK2_RE,
      XK2_IM         => XK2_IM,
      XK3_RE         => XK3_RE,
      XK3_IM         => XK3_IM,
      XK4_RE         => XK4_RE,
      XK4_IM         => XK4_IM,
      XK5_RE         => XK5_RE,
      XK5_IM         => XK5_IM,
      XK6_RE         => XK6_RE,
      XK6_IM         => XK6_IM,
      XK7_RE         => XK7_RE,
      XK7_IM         => XK7_IM,
      XK8_RE         => XK8_RE,
      XK8_IM         => XK8_IM,
      XK9_RE         => XK9_RE,
      XK9_IM         => XK9_IM,
      XK10_RE        => XK10_RE,
      XK10_IM        => XK10_IM,
      XK11_RE        => XK11_RE,
      XK11_IM        => XK11_IM,
      BLK_EXP0       => BLK_EXP0,
      BLK_EXP1       => BLK_EXP1,
      BLK_EXP2       => BLK_EXP2,
      BLK_EXP3       => BLK_EXP3,
      BLK_EXP4       => BLK_EXP4,
      BLK_EXP5       => BLK_EXP5,
      BLK_EXP6       => BLK_EXP6,
      BLK_EXP7       => BLK_EXP7,
      BLK_EXP8       => BLK_EXP8,
      BLK_EXP9       => BLK_EXP9,
      BLK_EXP10      => BLK_EXP10,
      BLK_EXP11      => BLK_EXP11,
      OVFLO0         => OVFLO0,
      OVFLO1         => OVFLO1,
      OVFLO2         => OVFLO2,
      OVFLO3         => OVFLO3,
      OVFLO4         => OVFLO4,
      OVFLO5         => OVFLO5,
      OVFLO6         => OVFLO6,
      OVFLO7         => OVFLO7,
      OVFLO8         => OVFLO8,
      OVFLO9         => OVFLO9,
      OVFLO10        => OVFLO10,
      OVFLO11        => OVFLO11
      );

  --core_if off

end behavioral;


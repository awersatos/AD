-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 4.0
--  \   \        Filename: $RCSfile: dds_compiler_v4_0_multadd_wrapper.vhd,v $
--  /   /        Date Last Modified: $Date: 2009/12/04 11:46:31 $
-- /___/   /\    Date Created: 2006
-- \   \  /  \
--  \___\/\___\
--
-- Device  : All
-- Library : dds_compiler_v4_0
-- Purpose : Wrapper for multiplier-adder
-------------------------------------------------------------------------------
--
--  (c) Copyright 2006-2009 Xilinx, Inc. All rights reserved.
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
-- Design Notes
-- This file wraps the multadd usecases as used in the EFF of the DDS.
-- The wrapper would not be needed if Spartan3 was supported by the multadd
-- usecase cores, but these were designed for DSP48-enabled families.
-- Therefore, this wrapper uses the usecases where appropriate and calls
-- mult and adder separately for S3 families.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;

library xilinxcorelib;
use xilinxcorelib.xbip_pipe_v2_0_xst_comp.all;

library xilinxcorelib;
use xilinxcorelib.bip_dsp48_multadd_pkg_v2_0.all;
use xilinxcorelib.xbip_dsp48_multadd_v2_0_comp.all;

library xilinxcorelib;
use xilinxcorelib.mult_gen_v11_0_xst_comp.all;

entity dds_compiler_v4_0_multadd_wrapper is
  generic(
    --BaseIP modelling generics
    C_VERBOSITY       : integer := 0;  --0 = Errors 1 = +Warnings, 2 = +Notes and tips
    C_MODEL_TYPE      : integer := 0;   --0 = synth, 1 = RTL
    --BaseIP common generics
    C_XDEVICEFAMILY   : string  := "virtex4";
    C_LATENCY         : integer := -1
    );
  port (
    CLK          : in  std_logic                                                      := '1';
    CE           : in  std_logic                                                      := '1';
    SCLR         : in  std_logic                                                      := '0';
    SUBTRACT     : in  std_logic                                                      := '0';
    A            : in  std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
    B            : in  std_logic_vector(ci_dsp48_b_width-1 downto 0)                  := (others => '0');
    C            : in  std_logic_vector(ci_dsp48_c_width-1 downto 0)                  := (others => '0');
    P            : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                  := (others => '0')
    );
end dds_compiler_v4_0_multadd_wrapper;

architecture synth of dds_compiler_v4_0_multadd_wrapper is

begin  -- synth

  --If DSP48s are present, use BaseIP
  I_V4_V5_SP3ADSP: if has_dsp(C_XDEVICEFAMILY) generate

    I_USECASE : xbip_dsp48_multadd_v2_0
      generic map (
        --BaseIP common generics
        C_VERBOSITY     => C_VERBOSITY,
        C_XDEVICEFAMILY => C_XDEVICEFAMILY,
        C_LATENCY       => C_LATENCY,
        C_MODEL_TYPE    => C_MODEL_TYPE
        )
      port map (
        clk      => CLK,
        ce       => CE,
        sclr     => SCLR,
        subtract => SUBTRACT,
        A        => A,
        B        => B,
        C        => C,
        P        => P
        );
  end generate i_v4_v5_sp3adsp;

  --If DSP48s are not available, BaseIP DSP48 usecase can't be used, so mimic
  --the function using a multiplier and an adder.
  I_S3: if not(has_dsp(C_XDEVICEFAMILY)) generate
    -- purpose: converts baseIP usecase latency parameter into stages for mult and add
    constant ci_sp3_multadd_latency : t_dsp48_multadd_latency := fn_dsp48_multadd_latency(
      P_LATENCY => C_LATENCY,
      p_xdevicefamily => C_XDEVICEFAMILY
      );
    signal c_del   : std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0');
    signal product : std_logic_vector(ci_dsp48_b_width*2-1 downto 0) := (others => '0');
    signal sum     : std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
  begin
    I_MULT : mult_gen_v11_0_xst
      generic map (
        -- BaseIP modelling generics
        C_VERBOSITY         => C_VERBOSITY,
        C_MODEL_TYPE        => C_MODEL_TYPE,
        C_OPTIMIZE_GOAL     => 0,
        -- BaseIP common generics
        C_XDEVICEFAMILY     => C_XDEVICEFAMILY,
        C_HAS_CE            => 0,  -- Changed in behavioural model to avoid warnings (as zero latency)
        C_HAS_SCLR          => 0,  -- Changed in behavioural model to avoid warnings (as zero latency)
        C_LATENCY           => ci_sp3_multadd_latency.pipe(1) + ci_sp3_multadd_latency.pipe(2)+ ci_sp3_multadd_latency.pipe(3),
        -- Application-specific generics
        C_A_WIDTH           => ci_dsp48_b_width,
        C_A_TYPE            => 0,
        C_B_WIDTH           => ci_dsp48_b_width,
        C_B_TYPE            => 0,
        C_OUT_HIGH          => ci_dsp48_b_width*2-1,
        C_OUT_LOW           => 0,
        C_CE_OVERRIDES_SCLR => 0,
        C_HAS_ZERO_DETECT   => 0,
        C_ROUND_OUTPUT      => 0,
        C_ROUND_PT          => 0
        )
      port map(
        CLK         => CLK,
        A           => A,
        B           => B,
        CE          => CE,
        SCLR        => SCLR,
        P           => product
        );

    --Mimic the C port latency.
    I_C_PORT : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY => ci_sp3_multadd_latency.pipe(3),
        C_HAS_CE  => 1,
        C_WIDTH   => ci_dsp48_c_width
        )
      port map(
        CLK => CLK,
        CE  => CE,
        D   => C,
        Q   => c_del
        );

    --Simpler to use addsub rather than adder or subtractor as this mimics the
    --DSP48 closer. There's no additional hardware since everything will fit in a LUT.

    sum <= c_del + product when SUBTRACT = '0' else
           c_del - product;

     I_P_PORT : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY => ci_sp3_multadd_latency.pipe(4),
        C_HAS_CE  => 1,
        C_WIDTH   => ci_dsp48_p_width
        )
      port map(
        CLK => CLK,
        CE  => CE,
        D   => sum,
        Q   => P
        );

  end generate I_S3;
end synth;

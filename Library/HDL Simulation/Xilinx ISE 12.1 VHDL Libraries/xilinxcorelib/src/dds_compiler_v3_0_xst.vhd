-- $Id: dds_compiler_v3_0_xst.vhd,v 1.3 2009/09/08 15:24:25 akennedy Exp $
--
--  Copyright(C) 2006 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2006 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Wrapper for behavioral model
-------------------------------------------------------------------------------
  
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;
use xilinxcorelib.xcc_utils_v2_0.all;
use xilinxcorelib.dds_compiler_v3_0_comp.all;

--core_if on entity dds_compiler_v3_0_xst
  entity dds_compiler_v3_0_xst is
    generic (
      C_FAMILY                : string  := "virtex4";
      C_XDEVICEFAMILY         : string  := "virtex4";
      C_ACCUMULATOR_LATENCY   : integer := 1;          -- ONE_CYCLE;
      C_ACCUMULATOR_WIDTH     : integer := 16;
      C_CHANNELS              : integer := 1;
      C_DATA_WIDTH            : integer := 16;
      C_ENABLE_RLOCS          : integer := 0;
      C_HAS_CE                : integer := 0;
      C_HAS_CHANNEL_INDEX     : integer := 0;
      C_HAS_RDY               : integer := 1;
      C_HAS_RFD               : integer := 0;
      C_HAS_SCLR              : integer := 0;
      C_LATENCY               : integer := 2;
      C_MEM_TYPE              : integer := 0;          -- DIST_ROM;
      C_NEGATIVE_COSINE       : integer := 0;
      C_NEGATIVE_SINE         : integer := 0;
      C_NOISE_SHAPING         : integer := 0;
      C_OUTPUTS_REQUIRED      : integer := 2;          -- SINE_AND_COSINE;
      C_OUTPUT_WIDTH          : integer := 16;
      C_PHASE_ANGLE_WIDTH     : integer := 12;
      C_PHASE_INCREMENT       : integer := 1;          -- REG;
      C_PHASE_INCREMENT_VALUE : string  := "0";
      C_PHASE_OFFSET          : integer := 2;          -- CONST;
      C_PHASE_OFFSET_VALUE    : string  := "0";
      C_PIPELINED             : integer := 0;
      C_OPTIMISE_GOAL         : integer := 0;
      C_USE_DSP48             : integer := 0;
      C_POR_MODE              : integer := 0
      );
    port (
      addr       : in  std_logic_vector(sel_lines_reqd(C_CHANNELS)-1 downto 0) := (others => '0');
      reg_select : in  std_logic                                               := '0';
      ce         : in  std_logic                                               := '0';
      clk        : in  std_logic                                               := '0';
      sclr       : in  std_logic                                               := '0';
      we         : in  std_logic                                               := '0';
      data       : in  std_logic_vector(C_DATA_WIDTH-1 downto 0)               := (others => '0');
      rdy        : out std_logic                                               := '0';
      rfd        : out std_logic                                               := '0';
      channel    : out std_logic_vector(sel_lines_reqd(C_CHANNELS)-1 downto 0) := (others => '0');
      cosine     : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0)             := (others => '0');
      sine       : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0)             := (others => '0');
      phase_out  : out std_logic_vector(C_ACCUMULATOR_WIDTH-1 downto 0)        := (others => '0')
      );
--core_if off
END dds_compiler_v3_0_xst;


ARCHITECTURE behavioral OF dds_compiler_v3_0_xst IS

BEGIN
  --core_if on instance i_behv dds_compiler_v3_0
  i_behv : dds_compiler_v3_0
    generic map (
      C_FAMILY                => C_FAMILY,
      C_XDEVICEFAMILY         => C_XDEVICEFAMILY,
      C_ACCUMULATOR_LATENCY   => C_ACCUMULATOR_LATENCY,
      C_ACCUMULATOR_WIDTH     => C_ACCUMULATOR_WIDTH,
      C_CHANNELS              => C_CHANNELS,
      C_DATA_WIDTH            => C_DATA_WIDTH,
      C_ENABLE_RLOCS          => C_ENABLE_RLOCS,
      C_HAS_CE                => C_HAS_CE,
      C_HAS_CHANNEL_INDEX     => C_HAS_CHANNEL_INDEX,
      C_HAS_RDY               => C_HAS_RDY,
      C_HAS_RFD               => C_HAS_RFD,
      C_HAS_SCLR              => C_HAS_SCLR,
      C_LATENCY               => C_LATENCY,
      C_MEM_TYPE              => C_MEM_TYPE,
      C_NEGATIVE_COSINE       => C_NEGATIVE_COSINE,
      C_NEGATIVE_SINE         => C_NEGATIVE_SINE,
      C_NOISE_SHAPING         => C_NOISE_SHAPING,
      C_OUTPUTS_REQUIRED      => C_OUTPUTS_REQUIRED,
      C_OUTPUT_WIDTH          => C_OUTPUT_WIDTH,
      C_PHASE_ANGLE_WIDTH     => C_PHASE_ANGLE_WIDTH,
      C_PHASE_INCREMENT       => C_PHASE_INCREMENT,
      C_PHASE_INCREMENT_VALUE => C_PHASE_INCREMENT_VALUE,
      C_PHASE_OFFSET          => C_PHASE_OFFSET,
      C_PHASE_OFFSET_VALUE    => C_PHASE_OFFSET_VALUE,
      C_PIPELINED             => C_PIPELINED,
      C_OPTIMISE_GOAL         => C_OPTIMISE_GOAL,
      C_USE_DSP48             => C_USE_DSP48,
      C_POR_MODE              => C_POR_MODE
      )
    port map (
      addr       => addr,
      reg_select => reg_select,
      ce         => ce,
      clk        => clk,
      sclr       => sclr,
      we         => we,
      data       => data,
      rdy        => rdy,
      rfd        => rfd,
      channel    => channel,
      cosine     => cosine,
      sine       => sine,
      phase_out  => phase_out
      );

  --core_if off
  
END behavioral;


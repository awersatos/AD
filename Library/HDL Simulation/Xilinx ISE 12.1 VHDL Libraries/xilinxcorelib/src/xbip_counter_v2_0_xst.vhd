-- $Id: xbip_counter_v2_0_xst.vhd,v 1.3 2009/09/08 16:46:30 akennedy Exp $
--
--  (c) Copyright 1995-2008 Xilinx, Inc. All rights reserved.
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
-- Wrapper for behavioral model
-------------------------------------------------------------------------------
  
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
--USE XilinxCoreLib.bip_utils_pkg_v2_0.ALL;
USE Xilinxcorelib.xbip_counter_v2_0_comp.ALL;

-- (A)synchronous multi-input gate
--
--core_if on entity xbip_counter_v2_0_xst
  entity xbip_counter_v2_0_xst is
    GENERIC (
      C_XDEVICEFAMILY     : string  := "virtex2";
      C_VERBOSITY         : integer := 0;
      C_USE_DSP48         : integer := 0;
      C_HAS_CE            : integer := 0;
      C_HAS_SCLR          : integer := 0;
      C_LATENCY           : integer := 1;
      C_FB_LATENCY        : integer := 1;
      C_WIDTH             : integer := 16;
      C_RESTRICT_COUNT    : integer := 0;
      C_COUNT_TO          : string  := "0";
      C_COUNT_BY          : string  := "0";
      C_COUNT_MODE        : integer := 0;          -- 0=up, 1=down, 2=updown
      C_THRESH0_VALUE     : string  := "0";
      C_CE_OVERRIDES_SCLR : integer := 0;          -- 0=override;
      C_HAS_THRESH0       : integer := 0;
      C_HAS_LOAD          : integer := 0;
      C_LOAD_LOW          : integer := 0
      );
    PORT (
      CLK     : in  std_logic                            := '0';              -- optional clock
      CE      : in  std_logic                            := '1';              -- optional clock enable
      SCLR    : in  std_logic                            := '0';              -- synch init.
      UP      : in  std_logic                            := '1';              -- controls direction of count - '1' = up.
      LOAD    : in  std_logic                            := '0';              -- optional synch load trigger
      L       : in  std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');  -- optional synch load value
      THRESH0 : out std_logic                            := '1';
      Q       : out std_logic_vector(C_WIDTH-1 downto 0)                      -- output value
      );
--core_if off
END xbip_counter_v2_0_xst;


ARCHITECTURE behavioral OF xbip_counter_v2_0_xst IS

BEGIN
  --core_if on instance i_behv xbip_counter_v2_0
  i_behv : xbip_counter_v2_0
    GENERIC MAP (
      C_XDEVICEFAMILY     => C_XDEVICEFAMILY,
      C_VERBOSITY         => C_VERBOSITY,
      C_USE_DSP48         => C_USE_DSP48,
      C_HAS_CE            => C_HAS_CE,
      C_HAS_SCLR          => C_HAS_SCLR,
      C_LATENCY           => C_LATENCY,
      C_FB_LATENCY        => C_FB_LATENCY,
      C_WIDTH             => C_WIDTH,
      C_RESTRICT_COUNT    => C_RESTRICT_COUNT,
      C_COUNT_TO          => C_COUNT_TO,
      C_COUNT_BY          => C_COUNT_BY,
      C_COUNT_MODE        => C_COUNT_MODE,
      C_THRESH0_VALUE     => C_THRESH0_VALUE,
      C_CE_OVERRIDES_SCLR => C_CE_OVERRIDES_SCLR,
      C_HAS_THRESH0       => C_HAS_THRESH0,
      C_HAS_LOAD          => C_HAS_LOAD,
      C_LOAD_LOW          => C_LOAD_LOW
      )
    PORT MAP (
      CLK     => CLK,
      CE      => CE,
      SCLR    => SCLR,
      UP      => UP,
      LOAD    => LOAD,
      L       => L,
      THRESH0 => THRESH0,
      Q       => Q
      );

  --core_if off
  
END behavioral;


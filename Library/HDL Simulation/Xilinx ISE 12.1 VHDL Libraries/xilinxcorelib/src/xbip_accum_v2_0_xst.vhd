-- $Id: xbip_accum_v2_0_xst.vhd,v 1.3 2009/09/08 16:38:07 akennedy Exp $
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
USE Xilinxcorelib.xbip_accum_v2_0_comp.ALL;

-- (A)synchronous multi-input gate
--
--core_if on entity xbip_accum_v2_0_xst
  entity xbip_accum_v2_0_xst is
    GENERIC (
      C_XDEVICEFAMILY       : STRING  := "no_family";
      C_USE_DSP48           : INTEGER := 0;
      C_VERBOSITY           : integer := 0;
      C_LATENCY             : integer := 0;
      C_BYPASS_LOW          : integer := 0;
      C_B_WIDTH             : INTEGER := 16;
      C_OUT_WIDTH           : INTEGER := 16;
      C_CE_OVERRIDES_SCLR   : INTEGER := 0; --0=SYNC over CE, 1 = CE over SYNC
      C_DATA_TYPE           : INTEGER := 1; --0=signed, 1=unsigned;
      C_HAS_BYPASS          : INTEGER := 1; --0=no_bypass, 1=bypass;
      C_ADD_MODE            : INTEGER := 0 --0=add, 1=sub, 2=addsub;
      );
    PORT (
      B        : in  std_logic_vector(C_B_WIDTH-1 downto 0) := (others => '0');  -- input value
      CLK      : in  std_logic                              := '0';  -- clock
      ADDF     : in  std_logic                              := '1';
      C_IN     : in  std_logic                              := '0';  -- carry in
      CE       : in  std_logic                              := '1';  -- clock enable
      BYPASS   : in  std_logic                              := '0';  -- sync load of b into reg
      SCLR     : in  std_logic                              := '0';  -- synch init.
      Q        : out std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0')  -- synch output value
      );
--core_if off
END xbip_accum_v2_0_xst;


ARCHITECTURE behavioral OF xbip_accum_v2_0_xst IS

BEGIN
  --core_if on instance i_behv xbip_accum_v2_0
  i_behv : xbip_accum_v2_0
    generic map (
      C_XDEVICEFAMILY     => C_XDEVICEFAMILY,
      C_USE_DSP48         => C_USE_DSP48,
      C_VERBOSITY         => C_VERBOSITY,
      C_LATENCY           => C_LATENCY,
      C_BYPASS_LOW        => C_BYPASS_LOW,
      C_B_WIDTH           => C_B_WIDTH,
      C_OUT_WIDTH         => C_OUT_WIDTH,
      C_CE_OVERRIDES_SCLR => C_CE_OVERRIDES_SCLR,
      C_DATA_TYPE         => C_DATA_TYPE,
      C_HAS_BYPASS        => C_HAS_BYPASS,
      C_ADD_MODE          => C_ADD_MODE
      )
    port map (
      B      => B,
      CLK    => CLK,
      ADDF   => ADDF,
      C_IN   => C_IN,
      CE     => CE,
      BYPASS => BYPASS,
      SCLR   => SCLR,
      Q      => Q
      );

  --core_if off
  
END behavioral;


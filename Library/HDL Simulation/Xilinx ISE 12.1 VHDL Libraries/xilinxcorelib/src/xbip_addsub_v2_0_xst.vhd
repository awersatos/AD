-- $Id: xbip_addsub_v2_0_xst.vhd,v 1.3 2009/09/08 16:38:07 akennedy Exp $
--
--  (c) Copyright 2008 Xilinx, Inc. All rights reserved.
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
USE Xilinxcorelib.xbip_addsub_v2_0_comp.ALL;

--core_if on entity xbip_addsub_v2_0_xst
  entity xbip_addsub_v2_0_xst is
    GENERIC (
      C_XDEVICEFAMILY     : string  := "no_family";
      C_LATENCY           : integer := -1;
      C_A_WIDTH           : integer := 16;
      C_B_WIDTH           : integer := 16;
      C_OUT_WIDTH         : integer := 16;
      C_BYPASS_LOW        : integer := 0;
      C_CE_OVERRIDES_SCLR : integer := 0;
      C_VERBOSITY         : integer := 0;            -- 0 = Errors  1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE        : integer := 0;            -- 0 = synth,  1 = RTL
      C_DATA_TYPE         : integer := 0             -- 0 = signed, 1 = unsigned.
      );
    PORT (
      CLK    : in  std_logic                                := '1';
      CE     : in  std_logic                                := '1';
      SCLR   : in  std_logic                                := '0';
      ADDF    : in  std_logic                                := '0';
      BYPASS : in  std_logic                                := '0';
      C_IN   : in  std_logic                                := '0';
      A      : in  std_logic_vector(C_A_WIDTH-1 downto 0)   := (others => '0');
      B      : in  std_logic_vector(C_B_WIDTH-1 downto 0)   := (others => '0');
      Q      : out std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0')
      );
--core_if off
END xbip_addsub_v2_0_xst;


ARCHITECTURE behavioral OF xbip_addsub_v2_0_xst IS

BEGIN
  --core_if on instance i_behv xbip_addsub_v2_0
  i_behv : xbip_addsub_v2_0
    GENERIC MAP (
      C_XDEVICEFAMILY     => C_XDEVICEFAMILY,
      C_LATENCY           => C_LATENCY,
      C_A_WIDTH           => C_A_WIDTH,
      C_B_WIDTH           => C_B_WIDTH,
      C_OUT_WIDTH         => C_OUT_WIDTH,
      C_BYPASS_LOW        => C_BYPASS_LOW,
      C_CE_OVERRIDES_SCLR => C_CE_OVERRIDES_SCLR,
      C_VERBOSITY         => C_VERBOSITY,
      C_MODEL_TYPE        => C_MODEL_TYPE,
      C_DATA_TYPE         => C_DATA_TYPE
      )
    PORT MAP (
      CLK    => CLK,
      CE     => CE,
      SCLR   => SCLR,
      ADDF    => ADDF,
      BYPASS => BYPASS,
      C_IN   => C_IN,
      A      => A,
      B      => B,
      Q      => Q
      );

  --core_if off
  
END behavioral;


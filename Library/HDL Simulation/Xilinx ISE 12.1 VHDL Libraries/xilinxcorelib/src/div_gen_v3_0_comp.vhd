-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 3.0
--  \   \        Filename: $RCSfile: div_gen_v3_0_comp.vhd,v $
--  /   /        Date Last Modified: $Date: 2009/12/04 11:46:49 $
-- /___/   /\    Date Created: 2007
-- \   \  /  \
--  \___\/\___\
--
-- Device  : All
-- Library : div_gen_v3_0
-- Purpose : Component statement for behavioral model
-------------------------------------------------------------------------------
--  (c) Copyright 1995-2009 Xilinx, Inc. All rights reserved.
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

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE div_gen_v3_0_comp IS

  --core_if on component div_gen_v3_0
  component div_gen_v3_0
    GENERIC (
      C_VERBOSITY         : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE        : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY     : string  := "virtex4";
      C_HAS_SCLR          : integer := 0;
      C_HAS_CE            : integer := 0;
      C_CE_OVERRIDES_SCLR : integer := 0;
      C_LATENCY           : integer := 1;
      ALGORITHM_TYPE      : integer := 1;          -- 0=auto, 1=sdiv, 2=repmult
      DIVISOR_WIDTH       : integer := 16;
      DIVIDEND_WIDTH      : integer := 16;
      SIGNED_B            : integer := 0;          -- 0=unsigned, 1=signed
      DIVCLK_SEL          : integer := 1;          -- divisions per clock cycle
      FRACTIONAL_B        : integer := 0;
      FRACTIONAL_WIDTH    : integer := 16;
      C_HAS_DIV_BY_ZERO   : integer := 0
      );
    PORT (
      CLK            : in  std_logic                                     := '1';
      CE             : in  std_logic                                     := '1';
      SCLR           : in  std_logic                                     := '0';
      ND             : in  std_logic                                     := '0';
      RDY            : out std_logic                                     := '0';
      RFD            : out std_logic                                     := '0';
      DIVIDEND       : in  std_logic_vector(DIVIDEND_WIDTH-1 downto 0)   := (others => '0');
      DIVISOR        : in  std_logic_vector(DIVISOR_WIDTH-1 downto 0)    := (others => '0');
      QUOTIENT       : out std_logic_vector(DIVIDEND_WIDTH-1 downto 0)   := (others => '0');
      FRACTIONAL     : out std_logic_vector(FRACTIONAL_WIDTH-1+boolean'pos(FRACTIONAL_WIDTH = 0) downto 0) := (others => '0');
      DIVIDE_BY_ZERO : out std_logic                                     := '0'
      );
  --core_if off
  END COMPONENT;
  -- The following tells XST that div_gen_v3_0 is a black box which
  -- should be generated command given by the value of this attribute
  -- Note the fully qualified SIM (JAVA class) name that forms the
  -- basis of the core

  -- xcc exclude
  ATTRIBUTE box_type : STRING;
  ATTRIBUTE generator_default : STRING;
  ATTRIBUTE box_type OF div_gen_v3_0 : COMPONENT IS "black_box";
  ATTRIBUTE generator_default OF div_gen_v3_0 : COMPONENT IS
    "generatecore com.xilinx.ip.div_gen_v3_0.div_gen_v3_0";
  -- xcc include

END div_gen_v3_0_comp;

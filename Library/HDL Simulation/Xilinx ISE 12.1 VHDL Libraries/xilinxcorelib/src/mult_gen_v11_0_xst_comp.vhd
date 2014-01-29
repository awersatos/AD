-- $RCSfile: mult_gen_v11_0_xst_comp.vhd,v $ $Revision: 1.3 $ $Date: 2009/09/08 15:51:09 $
--------------------------------------------------------------------------------
-- (c) Copyright 2006 - 2009 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES. 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package mult_gen_v11_0_xst_comp is

  component mult_gen_v11_0_xst is
    generic (
      C_VERBOSITY         : integer := 0;
      C_MODEL_TYPE        : integer := 0;
      C_XDEVICEFAMILY     : string  := "virtex4";
      C_A_WIDTH           : integer := 18;
      C_A_TYPE            : integer := 0;
      C_B_WIDTH           : integer := 18;
      C_B_TYPE            : integer := 0;
      C_OUT_HIGH          : integer := 35;
      C_OUT_LOW           : integer := 0;
      C_MULT_TYPE         : integer := 1;
      C_OPTIMIZE_GOAL     : integer := 1;
      C_HAS_CE            : integer := 0;
      C_HAS_SCLR          : integer := 0;
      C_CE_OVERRIDES_SCLR : integer := 1;
      C_LATENCY           : integer := -1;
      C_CCM_IMP           : integer := 0;
      C_B_VALUE           : string  := "111111111111111111";
      C_HAS_ZERO_DETECT   : integer := 0;
      C_ROUND_OUTPUT      : integer := 0;
      C_ROUND_PT          : integer := 0);
    port (
      CLK         : in  std_logic                                       := '1';
      A           : in  std_logic_vector(C_A_WIDTH-1 downto 0)          := (others => '0');
      B           : in  std_logic_vector(C_B_WIDTH-1 downto 0)          := (others => '0');
      CE          : in  std_logic                                       := '1';
      SCLR        : in  std_logic                                       := '0';
      ZERO_DETECT : out std_logic_vector(1 downto 0)                    := (others => '0');
      P           : out std_logic_vector(C_OUT_HIGH-C_OUT_LOW downto 0) := (others => '0');
      PCASC       : out std_logic_vector(47 downto 0)                   := (others => '0')); 
  end component;

end mult_gen_v11_0_xst_comp;

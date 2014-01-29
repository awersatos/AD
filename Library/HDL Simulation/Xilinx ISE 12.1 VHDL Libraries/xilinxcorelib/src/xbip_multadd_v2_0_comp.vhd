-- $RCSfile: xbip_multadd_v2_0_comp.vhd,v $ $Date: 2009/12/04 11:46:44 $ $Revision: 1.4 $
--
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
-- Component statement for behavioral model
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- I would like to use the utils to define the width of PCIN and PCOUT, but when I leave the definitions in below I get failures
-- in xbld libs.   It says it can't find xilinxcorelib!
library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;

package xbip_multadd_v2_0_comp is

  --core_if on component xbip_multadd_v2_0
  component xbip_multadd_v2_0
    generic (
      C_VERBOSITY         : integer := 0;
      C_XDEVICEFAMILY     : string  := "";
      C_A_WIDTH           : integer := 20;
      C_B_WIDTH           : integer := 20;
      C_C_WIDTH           : integer := 32;
      C_A_TYPE            : integer := 0;   -- 0:signed, 1:unsigned
      C_B_TYPE            : integer := 0;   -- 0:signed, 1:unsigned
      C_C_TYPE            : integer := 0;   -- 0:signed, 1:unsigned
      C_CE_OVERRIDES_SCLR : integer := 0;
      C_AB_LATENCY        : integer := -1;
      C_C_LATENCY         : integer := -1;
      C_OUT_HIGH          : integer := 32;
      C_OUT_LOW           : integer := 0;
      C_USE_PCIN          : integer := 0
      );
    port (
      CLK      : in  std_logic                                     := '0';
      CE       : in  std_logic                                     := '0';
      SCLR     : in  std_logic                                     := '0';
      A        : in  std_logic_vector(C_A_WIDTH-1 downto 0)        := (others => '0');
      B        : in  std_logic_vector(C_B_WIDTH-1 downto 0)        := (others => '0');
      C        : in  std_logic_vector(C_C_WIDTH-1 downto 0)        := (others => '0');
      PCIN     : in  std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0');
      SUBTRACT : in  std_logic                                     := '0';
      P        : out std_logic_vector(C_OUT_HIGH downto C_OUT_LOW) := (others => '0');
      PCOUT    : out std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0')
      );
  --core_if off
  end component;
  -- The following tells XST that xbip_multadd_v2_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  attribute box_type                               : string;
  attribute generator_default                      : string;
  attribute box_type of xbip_multadd_v2_0          : component is "black_box";
  attribute generator_default of xbip_multadd_v2_0 : component is "generatecore com.xilinx.ip.xbip_multadd_v2_0.xbip_multadd_v2_0";
  -- xcc include

end xbip_multadd_v2_0_comp;

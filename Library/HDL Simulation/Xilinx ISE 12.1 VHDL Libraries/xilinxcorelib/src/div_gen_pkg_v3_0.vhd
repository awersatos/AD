-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 3.0
--  \   \        Filename: $RCSfile: div_gen_pkg_v3_0.vhd,v $
--  /   /        Date Last Modified: $Date: 2009/12/04 11:46:49 $
-- /___/   /\    Date Created: 2007
-- \   \  /  \
--  \___\/\___\
--
-- Device  : All
-- Library : div_gen_v3_0
-- Purpose : Package for behavioral model
-------------------------------------------------------------------------------
--  (c) Copyright 2007, 2009 Xilinx, Inc. All rights reserved.
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
library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;

library xilinxcorelib;
use xilinxcorelib.div_gen_hdl_pkg_v3_0.all;

package div_gen_pkg_v3_0 is

  function fn_div_gen_v3_0_check_generics (
    P_VERBOSITY         : integer;
    P_MODEL_TYPE        : integer;
    P_XDEVICEFAMILY     : string;
    P_HAS_SCLR          : integer;
    P_HAS_CE            : integer;
    P_CE_OVERRIDES_SCLR : integer;
    P_LATENCY           : integer;
    P_ALGORITHM_TYPE    : integer;
    P_DIVISOR_WIDTH     : integer;
    P_DIVIDEND_WIDTH    : integer;
    P_SIGNED_B          : integer;
    P_DIVCLK_SEL        : integer;
    P_FRACTIONAL_B      : integer;
    P_FRACTIONAL_WIDTH  : integer;
    P_HAS_DIV_BY_ZERO   : integer
    )
    return integer;


end package div_gen_pkg_v3_0;

package body div_gen_pkg_v3_0 is

  function fn_div_gen_v3_0_check_generics (
    P_VERBOSITY         : integer;
    P_MODEL_TYPE        : integer;
    P_XDEVICEFAMILY     : string;
    P_HAS_SCLR          : integer;
    P_HAS_CE            : integer;
    P_CE_OVERRIDES_SCLR : integer;
    P_LATENCY           : integer;
    P_ALGORITHM_TYPE    : integer;
    P_DIVISOR_WIDTH     : integer;
    P_DIVIDEND_WIDTH    : integer;
    P_SIGNED_B          : integer;
    P_DIVCLK_SEL        : integer;
    P_FRACTIONAL_B      : integer;
    P_FRACTIONAL_WIDTH  : integer;
    P_HAS_DIV_BY_ZERO   : integer
    )
    return integer is
  begin

    assert P_VERBOSITY = 0 or P_VERBOSITY = 1 or P_VERBOSITY = 2
      report "ERROR: div_gen_v2_0: C_VERBOSITY is out of range 0 to 2."
      severity error;

    assert P_MODEL_TYPE = 0 or P_MODEL_TYPE = 1 or P_MODEL_TYPE = 2
      report "ERROR: div_gen_v2_0: C_MODEL_TYPE must be 0, 1 or 2"
      severity error;

    assert P_HAS_SCLR = 0 or P_HAS_SCLR = 1
      report "ERROR: div_gen_v2_0: C_HAS_SCLR must be 0 or 1"
      severity error;

    assert P_HAS_CE = 0 or P_HAS_CE = 1
      report "ERROR: div_gen_v2_0: C_HAS_CE must be 0 or 1"
      severity error;

    assert P_CE_OVERRIDES_SCLR = 0 or P_CE_OVERRIDES_SCLR = 1
      report "ERROR: div_gen_v2_0: C_CE_OVERRIDES_SCLR must be 0 or 1"
      severity error;

    --no checks on C_LATENCY here. Handled by subcores.

    assert P_ALGORITHM_TYPE = 1 or P_ALGORITHM_TYPE = 3 
      report "ERROR: div_gen_v2_0: ALGORITHM_TYPE must be 1 or 3"
      severity error;

    --no checks here on operand width. Handled by subcores.

    assert P_SIGNED_B = 0 or P_SIGNED_B = 1 
      report "ERROR: div_gen_v2_0: FRACTIONAL_B must be 0 or 1"
      severity error;

    assert P_DIVCLK_SEL = 1 or P_DIVCLK_SEL = 2 or P_DIVCLK_SEL = 4 or P_DIVCLK_SEL = 8
      report "ERROR: div_gen_v2_0: DIVCLK_SEL must be 1,2,4 or 8."
      severity error;

    assert P_FRACTIONAL_B = 0 or P_FRACTIONAL_B = 1
      report "ERROR: div_gen_v2_0: FRACTIONAL_B is out of range 0 to 1."
      severity error;

    --no check on fractional width - delegated to div algo cores.
    
    assert P_HAS_DIV_BY_ZERO = 0 or (P_HAS_DIV_BY_ZERO = 1 and P_ALGORITHM_TYPE = 3)
      report "ERROR: div_gen_v2_0: C_HAS_DIV_BY_ZERO is out of range 0 to 1"
      severity error;
    return 0;
  end fn_div_gen_v3_0_check_generics;
 
end package body div_gen_pkg_v3_0;
 

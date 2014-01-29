-- $Header
--
--  Copyright(C) 2007 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 2007 Xilinx, Inc.
--  All rights reserved.

library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all;

library xilinxcorelib;
use xilinxcorelib.div_gen_hdl_pkg_v2_0.all;

package div_gen_pkg_v2_0 is
  
  function fn_div_gen_v2_0_check_generics (
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


end package div_gen_pkg_v2_0;

package body div_gen_pkg_v2_0 is

  function fn_div_gen_v2_0_check_generics (
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
  end fn_div_gen_v2_0_check_generics;
 
end package body div_gen_pkg_v2_0;
 

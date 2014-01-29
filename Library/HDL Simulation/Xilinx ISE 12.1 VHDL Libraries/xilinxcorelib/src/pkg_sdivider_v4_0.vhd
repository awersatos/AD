-- $Header
--
--  Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
--  All rights reserved.
--  


  library ieee;
  use ieee.std_logic_1164.all;

package pkg_sdivider_v4_0 IS
  function check_generics(
    p_has_aclr         : integer;
    p_has_ce           : integer;
    p_has_sclr         : integer;
    p_sync_enable      : integer;
    p_divclk_sel       : integer;
    p_dividend_width   : integer;
    p_divisor_width    : integer;
    p_fractional_b     : integer;
    p_fractional_width : integer;
    p_signed_b         : integer
    )
    return integer;
end pkg_sdivider_v4_0;

-------------------------------------------------------------------------------
-- end of declaration, start of body
-------------------------------------------------------------------------------

package body pkg_sdivider_v4_0 is
  --Example function
  function check_generics(
    p_has_aclr         : integer;
    p_has_ce           : integer;
    p_has_sclr         : integer;
    p_sync_enable      : integer;
    p_divclk_sel       : integer;
    p_dividend_width   : integer;
    p_divisor_width    : integer;
    p_fractional_b     : integer;
    p_fractional_width : integer;
    p_signed_b         : integer
    )
    return integer is
  begin
--    assert rlocs = 0 report "Location constraints are not supported" severity warning;
    assert (not(p_fractional_b = 0 and p_fractional_width /= p_divisor_width))
      report "error: fractional width must equal divisor width for integer remainder dividers"
      severity error;

    assert (p_divclk_sel = 1) or (p_divclk_sel = 2) or (p_divclk_sel = 4) or (p_divclk_sel = 8) 
      report "Invalid value for divclk_sel"
      severity failure;

    assert (p_sync_enable = 0) or (p_sync_enable = 1)
      report "ERROR: Illegal c_sync_enable. Expected 0 or 1, got "&INTEGER'IMAGE(p_sync_enable)
      severity failure;

    assert (p_has_ce = 0) or (p_has_ce = 1)
      report "ERROR: Illegal c_has_ce. Expected 0 or 1, got "&INTEGER'IMAGE(p_has_ce)
      severity failure;

    assert (p_has_sclr = 0) or (p_has_sclr = 1)
      report "ERROR: Illegal c_has_sclr. Expected 0 or 1, got "&INTEGER'IMAGE(p_has_sclr)
      severity failure;

    assert (p_has_aclr = 0) or (p_has_aclr = 1)
      report "ERROR: Illegal c_has_aclr. Expected 0 or 1, got "&INTEGER'IMAGE(p_has_aclr)
      severity failure;

    return 0;
  end check_generics;
end pkg_sdivider_v4_0;

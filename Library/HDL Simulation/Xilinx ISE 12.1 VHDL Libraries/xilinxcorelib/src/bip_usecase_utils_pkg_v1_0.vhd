-- $Id: bip_usecase_utils_pkg_v1_0.vhd,v 1.3 2008/09/10 09:50:51 akennedy Exp $
-------------------------------------------------------------------------------
--  Copyright(C) 2008 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 2008 Xilinx, Inc.
--  All rights reserved.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all;

package bip_usecase_utils_pkg_v1_0 is

  constant ci_dsp48_a_width : integer := 18;
  constant ci_dsp48_b_width : integer := 18;
  constant ci_dsp48_c_width : integer := 48;
  constant ci_dsp48_p_width : integer := 48;

  constant ci_dsp48a_d_width : integer := 18;

  constant ci_dsp48e_a_width     : integer := 30;
  constant ci_dsp48e_amult_width : integer := 25;

  function fn_dsp48_a_width (
    p_xdevicefamily : string)
    return integer;

  function fn_dsp48_amult_width (
    p_xdevicefamily : string)
    return integer;

  function fn_dsp48_amultcin_width (
    p_xdevicefamily : string;
    p_use_acin      : integer)
    return integer;

  function fn_dsp48_d_width (
    p_xdevicefamily : string)
    return integer;

  function fn_dsp48_concat_width (
    p_xdevicefamily : string)
    return integer;

  function fn_dsp48_preadd_width (
    p_xdevicefamily : string)
    return integer;

  function fn_dsp48_add3_x_width (
    p_xdevicefamily : string)
    return integer;

end bip_usecase_utils_pkg_v1_0;

package body bip_usecase_utils_pkg_v1_0 is

  function fn_dsp48_a_width (
    p_xdevicefamily : string)
    return integer is
  begin
    if has_dsp48e(p_xdevicefamily) then
      return ci_dsp48e_a_width;
    else
      return ci_dsp48_a_width;
    end if;
  end function fn_dsp48_a_width;

  function fn_dsp48_amult_width (
    p_xdevicefamily : string)
    return integer is
  begin
    if has_dsp48e(p_xdevicefamily) then
      return ci_dsp48e_amult_width;
    else
      return ci_dsp48_a_width;
    end if;
  end function fn_dsp48_amult_width;

  function fn_dsp48_amultcin_width (
    p_xdevicefamily : string;
    p_use_acin      : integer)
    return integer is
  begin
    if (has_dsp48e(p_xdevicefamily) and (p_use_acin = 1)) then
      return ci_dsp48e_a_width;
    elsif (has_dsp48e(p_xdevicefamily) and (p_use_acin = 0)) then
      return ci_dsp48e_amult_width;
    else
      return ci_dsp48_a_width;
    end if;
  end function fn_dsp48_amultcin_width;
  
  function fn_dsp48_d_width (
    p_xdevicefamily : string)
    return integer is
  begin
    if has_dsp48a(p_xdevicefamily) then
      return ci_dsp48a_d_width;
    else
      return 0;
    end if;
  end function fn_dsp48_d_width;

  function fn_dsp48_concat_width (
    p_xdevicefamily : string)
    return integer is
  begin
    if has_dsp48a(p_xdevicefamily) then
      return ci_dsp48_p_width;
    else
      return fn_dsp48_a_width(p_xdevicefamily)+ci_dsp48_b_width;
    end if;
  end function fn_dsp48_concat_width;

  function fn_dsp48_preadd_width (
    p_xdevicefamily : string)
    return integer is
  begin
    if has_dsp48a(p_xdevicefamily) or has_dsp48(p_xdevicefamily) then
      return ci_dsp48_b_width;
    else
      return fn_dsp48_amult_width(p_xdevicefamily);
    end if;
  end fn_dsp48_preadd_width;

  function fn_dsp48_add3_x_width (
    p_xdevicefamily : string)
    return integer is
    variable ret : integer := 0;
  begin
    if has_dsp48a(p_xdevicefamily) then
      ret :=  ci_dsp48a_d_width;
    elsif has_dsp48(p_xdevicefamily) or has_dsp48e(p_xdevicefamily) then
      ret := fn_dsp48_a_width(p_xdevicefamily) + ci_dsp48_b_width;
    else
      assert false
        report "ERROR: fn_dsp48_add3_x_width: unknown xdevicefamily"
        severity error;
    end if;
    return ret;
  end fn_dsp48_add3_x_width;

end bip_usecase_utils_pkg_v1_0;



-- $Id: bip_usecase_utils_pkg_v2_0.vhd,v 1.4 2009/12/04 11:46:20 akennedy Exp $
-------------------------------------------------------------------------------
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
library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;

package bip_usecase_utils_pkg_v2_0 is

  constant ci_dsp48_a_width : integer := 18;
  constant ci_dsp48_b_width : integer := 18;
  constant ci_dsp48_c_width : integer := 48;
  constant ci_dsp48_p_width : integer := 48;

  constant ci_dsp48a_d_width  : integer := 18;
  constant ci_dsp48e1_d_width : integer := 25;

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

end bip_usecase_utils_pkg_v2_0;

package body bip_usecase_utils_pkg_v2_0 is

  function fn_dsp48_a_width (
    p_xdevicefamily : string)
    return integer is
  begin
    if supports_dsp48e(p_xdevicefamily) > 0 then
      return ci_dsp48e_a_width;
    else
      return ci_dsp48_a_width;
    end if;
  end function fn_dsp48_a_width;

  function fn_dsp48_amult_width (
    p_xdevicefamily : string)
    return integer is
  begin
    if supports_dsp48e(p_xdevicefamily) > 0 then
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
    if (supports_dsp48e(p_xdevicefamily) > 0 and (p_use_acin = 1)) then
      return ci_dsp48e_a_width;
    elsif (supports_dsp48e(p_xdevicefamily) > 0 and (p_use_acin = 0)) then
      return ci_dsp48e_amult_width;
    else
      return ci_dsp48_a_width;
    end if;
  end function fn_dsp48_amultcin_width;
  
  function fn_dsp48_d_width (
    p_xdevicefamily : string)
    return integer is
  begin
    if supports_dsp48a(p_xdevicefamily) > 0 then
      return ci_dsp48a_d_width;
    elsif supports_dsp48e1(p_xdevicefamily) > 0 then
      return ci_dsp48e1_d_width;
    else
      return 0;
    end if;
  end function fn_dsp48_d_width;

  function fn_dsp48_concat_width (
    p_xdevicefamily : string)
    return integer is
  begin
    if supports_dsp48a(p_xdevicefamily) > 0 then
      return ci_dsp48_p_width;
    else
      return fn_dsp48_a_width(p_xdevicefamily)+ci_dsp48_b_width;
    end if;
  end function fn_dsp48_concat_width;

  function fn_dsp48_preadd_width (
    p_xdevicefamily : string)
    return integer is
  begin
    if supports_dsp48a(p_xdevicefamily)>0 or has_dsp48(p_xdevicefamily) then
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
    if supports_dsp48a(p_xdevicefamily) > 0 then
--      ret :=  ci_dsp48a_d_width;
      assert false
        report "ERROR: This usecase does not support 3 input add as D + B + C, only PCIN + A:B + C"
        severity error;
    else
      ret := fn_dsp48_concat_width(p_xdevicefamily);
    end if;
    return ret;
  end fn_dsp48_add3_x_width;

end bip_usecase_utils_pkg_v2_0;



-- $Id: xbip_accum_v1_0_pkg.vhd,v 1.2 2008/09/10 09:45:17 akennedy Exp $
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


-------------------------------------------------------------------------------
-- Naming conventions
-- C_  = generic constant
-- ci_ = internal constant (derived from generics, or just an implementation constant)
-- p_  = function parameter (ensures that the value passed is used rather than
-- some global variable)
-- v_  = variable
-- fn_ = function prefix.
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all;

package xbip_accum_v1_0_pkg is

  constant c_bip_accum_v1_0_max_pipe_stages : integer := 32;
  type t_xbip_accum_v1_0_pipe is array (0 to c_bip_accum_v1_0_max_pipe_stages) of integer;
  
  type t_xbip_accum_v1_0_latency is record
    used : integer;
    pipe : t_xbip_accum_v1_0_pipe;
  end record;

  type t_xbip_accum_v1_0_resources is record
    dsp48    : integer;
    bram18k  : integer;
    luts     : integer;
    ffs      : integer;
  end record;
  
  function fn_xbip_accum_v1_0_get_resources(
    p_xdevicefamily     : string;
    p_implementation    : integer;
    p_verbosity         : integer;
    p_latency           : integer;
    p_bypass_low        : integer;
    p_b_width           : integer;
    p_out_width         : integer;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_data_type         : integer
    )
    return t_xbip_accum_v1_0_resources;
  
  function fn_xbip_accum_v1_0_latency(
    p_xdevicefamily     : string;
    p_implementation    : integer;
    p_verbosity         : integer;
    p_latency           : integer;
    p_bypass_low        : integer;
    p_b_width           : integer;
    p_out_width         : integer;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_data_type         : integer
    )
    return t_xbip_accum_v1_0_latency;
  
  function fn_xbip_accum_v1_0_check_generics(
    p_xdevicefamily     : string;
    p_implementation    : integer;
    p_verbosity         : integer;
    p_latency           : integer;
    p_bypass_low        : integer;
    p_b_width           : integer;
    p_out_width         : integer;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_data_type         : integer
    )
    return integer;
  
  
end package xbip_accum_v1_0_pkg;

package body xbip_accum_v1_0_pkg is

  function fn_xbip_accum_v1_0_check_generics(
    p_xdevicefamily     : string;
    p_implementation    : integer;
    p_verbosity         : integer;
    p_latency           : integer;
    p_bypass_low        : integer;
    p_b_width           : integer;
    p_out_width         : integer;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_data_type         : integer
    )
    return integer is

    constant error_string :  string := "ERROR: xbip_accum_v1_0: ";
    constant warn_string :  string := "WARNING: xbip_accum_v1_0: ";
    variable min_width : integer := 1;
  begin
    if p_verbosity /= 0 and p_verbosity /= 1 and p_verbosity /= 2 then
      report warn_string & "C_VERBOSITY valid range is 0 to 2.  Setting to 2.  Current value is " & integer'image(p_verbosity) severity warning;
    end if;

    assert p_implementation = 1
      report error_string & "C_IMPLEMENTATION should be set to 1 for xbip_accum_v1_0.  Current value is " & integer'image(p_implementation) severity error;

    assert p_xdevicefamily /= "NO_FAMILY" 
      report error_string & "C_XDEVICEFAMILY has not been correctly set (perhaps by CORE Generator)" severity error;

    if not(has_dsp48(p_xdevicefamily)or has_DSP48e(p_xdevicefamily) or has_dsp48a(p_xdevicefamily)) then
      assert false
        report error_string & "Invalid value for C_XDEVICEDFAMILY; must be VIRTEX4, VIRTEX5, or SPARTAN3ADSP for DSP48 implementation.  Current value is " & p_xdevicefamily severity error;
    end if;

    assert p_latency = 1 or p_latency = -1 or p_latency = 2
      report error_string & "C_LATENCY valid values of -1, 1 and 2 for the DSP48 implementation.  Current value is " & integer'image(p_latency) severity error;

    assert p_bypass_low = 0 or p_bypass_low = 1 
      report error_string & "C_BYPASS_LOW valid values of 0 and 1 for the DSP48 implementation.  Current value is " & integer'image(p_latency) severity error;

    assert p_data_type = c_signed or p_data_type = c_unsigned
      report error_string & "C_DATA_TYPE valid values are 0(signed) and 1(unsigned).  Current value is " & integer'image(p_data_type) severity error;

    if p_data_type = c_signed then
      min_width := 2;
    end if;

    assert p_b_width >= min_width AND p_b_width <= ci_dsp48_c_width-p_data_type 
      report error_string & "Invalid value for C_B_WIDTH; must be in the range " & integer'image(min_width) & ".." & integer'image(ci_dsp48_c_width-p_data_type) & ".  Current value is " & integer'image(p_b_width) severity error;

    assert p_out_width >= p_b_width  AND p_out_width <= ci_dsp48_p_width
        report error_string & "Invalid value for C_OUT_WIDTH; must be in the range " & integer'image(p_b_width) & ".." & integer'image(ci_dsp48_c_width) & ".  Current value is " & integer'image(p_out_width) severity error;
 

    assert p_ce_overrides_sclr = 0 or p_ce_overrides_sclr = 1
      report error_string & "C_SCLR_OVERRIDES_SSET valid range is 0 to 1.  Current value is " & integer'image(p_ce_overrides_sclr) severity error;
 
    return 0;
  end function fn_xbip_accum_v1_0_check_generics;


  
  function fn_xbip_accum_v1_0_get_resources(
    p_xdevicefamily     : string;
    p_implementation    : integer;
    p_verbosity         : integer;
    p_latency           : integer;
    p_bypass_low        : integer;
    p_b_width           : integer;
    p_out_width         : integer;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_data_type         : integer
    )
    return t_xbip_accum_v1_0_resources is
    variable ret_val : t_xbip_accum_v1_0_resources;
  begin
    ret_val.bram18k := 0;
    ret_val.luts := 0;
    ret_val.dsp48 := 0;
    ret_val.ffs := 0;
--    ret_val := (0,0,0,0); this doesn't work with Rabassa

    ret_val.dsp48 := 1;               --simple for now!

    if p_verbosity >= 2 then
      assert false
        report "Note: xbip_accum_v1_0 DSP48 count = "&integer'image(ret_val.DSP48)
        severity note;
      assert false
        report "Note: xbip_accum_v1_0 BRAM18K count = "&integer'image(ret_val.bram18k)
        severity note;
      assert false
        report "Note: xbip_accum_v1_0 LUT count = "&integer'image(ret_val.luts)
        severity note;
      assert false
        report "Note: xbip_accum_v1_0 FF count = "&integer'image(ret_val.ffs)
        severity note;
    end if;
 
    return ret_val;
  end function fn_xbip_accum_v1_0_get_resources;
  
  function fn_xbip_accum_v1_0_latency(
    p_xdevicefamily     : string;
    p_implementation    : integer;
    p_verbosity         : integer;
    p_latency           : integer;
    p_bypass_low        : integer;
    p_b_width           : integer;
    p_out_width         : integer;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_data_type         : integer
    )
    return t_xbip_accum_v1_0_latency is
    variable v_latency_left  : integer;
    variable ret_val : t_xbip_accum_v1_0_latency;
    variable v_lat_req : integer;
  begin
    if(p_latency = -1) then
      v_latency_left := 2;
    else
      v_latency_left := p_latency;
    end if;
    ret_val.used := 0;
    for i in 0 to c_bip_accum_v1_0_max_pipe_stages loop
      ret_val.pipe(i) := 0;
    end loop;  -- i
    --dsp48
    if v_latency_left /= 0 then
      ret_val.pipe(4) := 1;
      v_latency_left := v_latency_left -1;
      ret_val.used := ret_val.used + 1;
    end if;
    if v_latency_left /= 0 then
      ret_val.pipe(3) := 1;
      v_latency_left := v_latency_left -1;
      ret_val.used := ret_val.used + 1;
    end if;
    if v_latency_left > 0  then
      assert false
        report "ERROR: xbip_accum_v1_0: Excessive latency for DSP48-based case."
        severity error;
    end if;
    return ret_val;
  end function fn_xbip_accum_v1_0_latency;

end package body xbip_accum_v1_0_pkg;


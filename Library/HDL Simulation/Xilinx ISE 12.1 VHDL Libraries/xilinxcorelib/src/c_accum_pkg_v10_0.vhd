---------------------------------------------------------------------------
-- $Id: c_accum_pkg_v10_0.vhd,v 1.2 2008/09/09 20:22:52 akennedy Exp $
---------------------------------------------------------------------------
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
--  of this text at all times. (c) Copyright 1995-2008 Xilinx, Inc.
--  All rights reserved.
--
---------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all;

library xilinxcorelib;
use xilinxcorelib.xbip_accum_v1_0_pkg.all;

package c_accum_pkg_v10_0 is

  constant c_accum_v10_0_max_pipe_stages : integer := 32;
  type t_accum_v10_0_pipe is array (0 to c_accum_v10_0_max_pipe_stages) of integer;
  
  type t_c_accum_v10_0_latency is record
    used : integer;
    pipe : t_accum_v10_0_pipe;
  end record;

  type t_c_accum_v10_0_resources is record
    dsp48    : integer;
    bram18k  : integer;
    luts     : integer;
    ffs      : integer;
  end record;
 
  function fn_c_accum_v10_0_latency(
    C_XDEVICEFAMILY : string;
    C_IMPLEMENTATION : integer; 
    C_VERBOSITY : integer; 
    C_B_WIDTH : integer; 
    C_OUT_WIDTH : integer; 
    C_B_TYPE : integer;
    C_CE_OVERRIDES_SCLR : integer; 
    C_ADD_MODE : integer;  
    C_HAS_C_IN : integer; 
    C_HAS_CE : integer;
    C_HAS_BYPASS : integer; 
    C_HAS_SCLR : integer; 
    C_LATENCY : integer; 
    C_SCALE : integer; 
    C_BYPASS_LOW : integer;
    C_SCLR_OVERRIDES_SSET : integer; 
    C_HAS_SSET : integer; 
    C_HAS_SINIT : integer;
    C_AINIT_VAL : string;
    C_SINIT_VAL : string
    ) return t_c_accum_v10_0_latency;

  function fn_c_accum_v10_0_resources(
    C_XDEVICEFAMILY : string;
    C_IMPLEMENTATION : integer; 
    C_VERBOSITY : integer; 
    C_B_WIDTH : integer; 
    C_OUT_WIDTH : integer; 
    C_B_TYPE : integer;
    C_CE_OVERRIDES_SCLR : integer; 
    C_ADD_MODE : integer;  
    C_HAS_C_IN : integer; 
    C_HAS_CE : integer;
    C_HAS_BYPASS : integer; 
    C_HAS_SCLR : integer; 
    C_LATENCY : integer; 
    C_SCALE : integer; 
    C_BYPASS_LOW : integer;
    C_SCLR_OVERRIDES_SSET : integer; 
    C_HAS_SSET : integer; 
    C_HAS_SINIT : integer;
    C_AINIT_VAL : string;
    C_SINIT_VAL : string
    ) return t_c_accum_v10_0_resources;

  function fn_c_accum_v10_0_check_generics(
    C_XDEVICEFAMILY : string;
    C_IMPLEMENTATION : integer; 
    C_VERBOSITY : integer; 
    C_B_WIDTH : integer; 
    C_OUT_WIDTH : integer; 
    C_B_TYPE : integer;
    C_CE_OVERRIDES_SCLR : integer; 
    C_ADD_MODE : integer;  
    C_HAS_C_IN : integer; 
    C_HAS_CE : integer;
    C_HAS_BYPASS : integer; 
    C_HAS_SCLR : integer; 
    C_LATENCY : integer; 
    C_SCALE : integer; 
    C_BYPASS_LOW : integer;
    C_SCLR_OVERRIDES_SSET : integer; 
    C_HAS_SSET : integer; 
    C_HAS_SINIT : integer;
    C_AINIT_VAL : string;
    C_SINIT_VAL : string
    ) return integer;


  function fn_borrow_ports(
    has_port : integer; 
    add_mode : integer; 
    data_type : integer
    ) return integer;

  function fn_carry_ports(
    has_port : integer; 
    add_mode : integer; 
    data_type : integer
    ) return integer;

  function fn_add_port(
    add_mode : integer
    ) return integer;

end package c_accum_pkg_v10_0;

package body c_accum_pkg_v10_0 is

  function fn_c_accum_v10_0_latency(
    C_XDEVICEFAMILY : string;
    C_IMPLEMENTATION : integer; 
    C_VERBOSITY : integer; 
    C_B_WIDTH : integer; 
    C_OUT_WIDTH : integer; 
    C_B_TYPE : integer;
    C_CE_OVERRIDES_SCLR : integer; 
    C_ADD_MODE : integer;  
    C_HAS_C_IN : integer; 
    C_HAS_CE : integer;
    C_HAS_BYPASS : integer; 
    C_HAS_SCLR : integer; 
    C_LATENCY : integer; 
    C_SCALE : integer; 
    C_BYPASS_LOW : integer;
    C_SCLR_OVERRIDES_SSET : integer; 
    C_HAS_SSET : integer; 
    C_HAS_SINIT : integer;
    C_AINIT_VAL : string;
    C_SINIT_VAL : string
    ) return t_c_accum_v10_0_latency is
    variable ret_val : t_c_accum_v10_0_latency;
    variable xbip_accum_lat : t_xbip_accum_v1_0_latency;
  begin
    if C_LATENCY = -1 then
      xbip_accum_lat := fn_xbip_accum_v1_0_latency(
        p_xdevicefamily  => C_XDEVICEFAMILY,
        p_implementation => C_IMPLEMENTATION,
        p_verbosity => C_VERBOSITY,
        p_latency => C_LATENCY,
        p_bypass_low => C_BYPASS_LOW,
        p_b_width => C_B_WIDTH,
        p_out_width => C_OUT_WIDTH,
        p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR,
        p_data_type => C_B_TYPE
        );
      ret_val.used := xbip_accum_lat.used;
    else
      ret_val.used := c_latency;
    end if;
    return ret_val;
  end fn_c_accum_v10_0_latency;

  function fn_c_accum_v10_0_resources(
    C_XDEVICEFAMILY : string;
    C_IMPLEMENTATION : integer; 
    C_VERBOSITY : integer; 
    C_B_WIDTH : integer; 
    C_OUT_WIDTH : integer; 
    C_B_TYPE : integer;
    C_CE_OVERRIDES_SCLR : integer; 
    C_ADD_MODE : integer;  
    C_HAS_C_IN : integer; 
    C_HAS_CE : integer;
    C_HAS_BYPASS : integer; 
    C_HAS_SCLR : integer; 
    C_LATENCY : integer; 
    C_SCALE : integer; 
    C_BYPASS_LOW : integer;
    C_SCLR_OVERRIDES_SSET : integer; 
    C_HAS_SSET : integer; 
    C_HAS_SINIT : integer;
    C_AINIT_VAL : string;
    C_SINIT_VAL : string
    ) return t_c_accum_v10_0_resources is
    variable ret_val : t_c_accum_v10_0_resources;
    variable xbip_accum_res : t_xbip_accum_v1_0_resources;
  begin
    if C_IMPLEMENTATION = 1 then
      xbip_accum_res := fn_xbip_accum_v1_0_get_resources(
        p_xdevicefamily  => C_XDEVICEFAMILY,
        p_implementation => C_IMPLEMENTATION,
        p_verbosity => C_VERBOSITY,
        p_latency => C_LATENCY,
        p_bypass_low => C_BYPASS_LOW,
        p_b_width => C_B_WIDTH,
        p_out_width => C_OUT_WIDTH,
        p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR,
        p_data_type => C_B_TYPE
        );
      ret_val.dsp48 := xbip_accum_res.dsp48;
      ret_val.bram18k := xbip_accum_res.bram18k;
      ret_val.luts := xbip_accum_res.luts;
      ret_val.ffs := xbip_accum_res.ffs;
    else
      ret_val.dsp48 := 0;
      ret_val.bram18k := 0;
      ret_val.luts := C_OUT_WIDTH;
      ret_val.ffs := C_OUT_WIDTH;
    end if;
    return ret_val;
  end fn_c_accum_v10_0_resources;

  function fn_c_accum_v10_0_check_generics(
    C_XDEVICEFAMILY : string;
    C_IMPLEMENTATION : integer; 
    C_VERBOSITY : integer; 
    C_B_WIDTH : integer; 
    C_OUT_WIDTH : integer; 
    C_B_TYPE : integer;
    C_CE_OVERRIDES_SCLR : integer; 
    C_ADD_MODE : integer;  
    C_HAS_C_IN : integer; 
    C_HAS_CE : integer;
    C_HAS_BYPASS : integer; 
    C_HAS_SCLR : integer; 
    C_LATENCY : integer; 
    C_SCALE : integer; 
    C_BYPASS_LOW : integer;
    C_SCLR_OVERRIDES_SSET : integer; 
    C_HAS_SSET : integer; 
    C_HAS_SINIT : integer;
    C_AINIT_VAL : string;
    C_SINIT_VAL : string
    ) return integer is
    
    constant error_string :  string := "ERROR: c_accum_v10_0: ";
    constant warn_string :  string := "WARNING: c_accum_v10_0: ";
  begin

    if C_VERBOSITY /= 0 and C_VERBOSITY /= 1 and C_VERBOSITY /= 2 then
      report warn_string & "C_VERBOSITY valid range is 0 to 2.  Setting to 2.  Current value is " & integer'image(C_VERBOSITY) severity warning;
    end if;

    assert C_IMPLEMENTATION = 0 or C_IMPLEMENTATION = 1  
      report error_string & "C_IMPLEMENTATION valid range is 0 to 1.  Current value is " & integer'image(C_IMPLEMENTATION) severity error;

    assert C_XDEVICEFAMILY /= "NO_FAMILY" 
      report error_string & "C_XDEVICEFAMILY has not been correctly set (perhaps by CORE Generator)" severity error;

    assert C_B_TYPE = 0 or C_B_TYPE = 1  
      report error_string & "C_B_TYPE valid range is 0 to 1.  Current value is " & integer'image(C_B_TYPE) severity error;

    assert C_CE_OVERRIDES_SCLR = 0 or C_CE_OVERRIDES_SCLR = 1  
      report error_string & "C_CE_OVERRIDES_SCLR valid range is 0 to 1.  Current value is " & integer'image(C_CE_OVERRIDES_SCLR) severity error;

    assert C_ADD_MODE = 0 or C_ADD_MODE = 1 or C_ADD_MODE = 2
      report error_string & "C_ADD_MODE valid range is 0 to 2.  Current value is " & integer'image(C_ADD_MODE) severity error;

    assert C_HAS_C_IN = 0 or C_HAS_C_IN = 1
      report error_string & "C_HAS_C_IN valid range is 0 to 1.  Current value is " & integer'image(C_HAS_C_IN) severity error;

    assert C_HAS_CE = 0 or C_HAS_CE = 1
      report error_string & "C_HAS_CE valid range is 0 to 1.  Current value is " & integer'image(C_HAS_CE) severity error;

    assert C_HAS_BYPASS = 0 or C_HAS_BYPASS = 1
      report error_string & "C_HAS_BYPASS valid range is 0 to 1.  Current value is " & integer'image(C_HAS_BYPASS) severity error;

    assert C_HAS_SCLR = 0 or C_HAS_SCLR = 1
      report error_string & "C_HAS_SCLR valid range is 0 to 1.  Current value is " & integer'image(C_HAS_SCLR) severity error;

    assert C_BYPASS_LOW = 0 or C_BYPASS_LOW = 1
      report error_string & "C_BYPASS_LOW valid range is 0 to 1.  Current value is " & integer'image(C_BYPASS_LOW) severity error;

    if C_IMPLEMENTATION = 0 then
      assert C_B_WIDTH > 0 AND C_B_WIDTH <= 256 
        report error_string & "Invalid value for C_B_WIDTH; must be in the range 1..256.  Current value is " & integer'image(C_B_WIDTH) severity error;
      assert C_OUT_WIDTH >= C_B_WIDTH  AND C_OUT_WIDTH <= 258 
        report error_string & "Invalid value for C_OUT_WIDTH; must be in the range C_B_WIDTH..258.  Current value is " & integer'image(C_OUT_WIDTH) severity error;
      assert C_LATENCY = 1 or C_LATENCY = -1
        report error_string & "C_LATENCY valid values of -1 and 1 for the fabric implementation.  Current value is " & integer'image(C_LATENCY) severity error;
      assert C_SCALE < C_OUT_WIDTH
        report error_string & "C_SCALE must be less than C_OUT_WIDTH" severity error;
      assert C_SCALE >= 0 AND C_SCALE <= 8
        report error_string & "C_SCALE valid range is 0 to 8.  Current value is " & integer'image(C_SCALE) severity error;
      assert C_SCLR_OVERRIDES_SSET = 0 or C_SCLR_OVERRIDES_SSET = 1
        report error_string & "C_SCLR_OVERRIDES_SSET valid range is 0 to 1.  Current value is " & integer'image(C_SCLR_OVERRIDES_SSET) severity error;
      assert C_HAS_SSET = 0 or C_HAS_SSET = 1
        report error_string & "C_HAS_SSET valid range is 0 to 1.  Current value is " & integer'image(C_HAS_SSET) severity error;
      assert C_HAS_SINIT = 0 or C_HAS_SINIT = 1
        report error_string & "C_HAS_SINIT valid range is 0 to 1.  Current value is " & integer'image(C_HAS_SINIT) severity error;
    else
      if not(has_dsp48(C_XDEVICEFAMILY)or has_DSP48e(C_XDEVICEFAMILY) or has_dsp48a(C_XDEVICEFAMILY)) then
        assert false
          report error_string & "Invalid value for C_XDEVICEDFAMILY; must be VIRTEX4, VIRTEX5, or SPARTAN3ADSP for DSP48 implementation.  Current value is " & C_XDEVICEFAMILY severity error;
      end if;

      assert C_B_WIDTH > 0 AND C_B_WIDTH <= ci_dsp48_c_width-C_B_TYPE 
        report error_string & "Invalid value for C_B_WIDTH; must be in the range 1.." & integer'image(C_B_WIDTH-C_B_TYPE) & ".  Current value is " & integer'image(C_B_WIDTH) severity error;
      assert C_OUT_WIDTH >= C_B_WIDTH  AND C_OUT_WIDTH <= ci_dsp48_p_width 
        report error_string & "Invalid value for C_OUT_WIDTH; must be in the range C_B_WIDTH..48.  Current value is " & integer'image(C_OUT_WIDTH) severity error;
      assert C_LATENCY = 1 or C_LATENCY = -1 or C_LATENCY = 2
        report error_string & "C_LATENCY valid values of -1, 1 and 2 for the DSP48 implementation.  Current value is " & integer'image(C_LATENCY) severity error;

      if C_VERBOSITY = 1 then
        assert C_SCALE = 0 
          report warn_string & "C_SCALE is not supported in the DSP48 implementation; it will be set to 0.  Current value is " & integer'image(C_SCALE) severity warning;
--        assert C_BYPASS_LOW = 0 
--          report warn_string & "C_BYPASS_LOW is not supported in the DSP48 implementation; it will be set to 0 (active High bypass).  Current value is " & integer'image(C_BYPASS_LOW) severity warning;
        assert C_HAS_SSET = 0 
          report warn_string & "C_HAS_SSET is not supported in the DSP48 implementation; it will be set to 0 (no SSET port).  Current value is " & integer'image(C_HAS_SSET) severity warning;
        assert C_HAS_SINIT = 0 
          report warn_string & "C_HAS_SINIT is not supported in the DSP48 implementation; it will be set to 0 (no SINIT port).  Current value is " & integer'image(C_HAS_SINIT) severity warning;
      end if;
    end if;
    return 0;
  end function fn_c_accum_v10_0_check_generics;

  function fn_borrow_ports(
    has_port : integer; 
    add_mode : integer; 
    data_type: integer
    ) return integer is
  begin
    if add_mode=1 and data_type=1 then
      return has_port;
    else
      return 0;
    end if;
  end fn_borrow_ports;

  function fn_carry_ports(
    has_port : integer; 
    add_mode : integer; 
    data_type : integer
    ) return integer is
  begin
    if add_mode=1 or data_type=0 then
      return 0;
    else
      return has_port;
    end if;
  end fn_carry_ports;

  function fn_add_port(
    add_mode : integer
    ) return integer is
  begin
    if add_mode=2 then
      return 1;
    else
      return 0;
    end if;
  end fn_add_port;


end package body c_accum_pkg_v10_0;

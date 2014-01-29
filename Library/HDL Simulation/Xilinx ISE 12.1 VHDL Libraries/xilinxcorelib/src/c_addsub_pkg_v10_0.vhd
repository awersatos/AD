---------------------------------------------------------------------------
-- $Id: c_addsub_pkg_v10_0.vhd,v 1.2 2008/09/09 20:22:57 akennedy Exp $
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

package c_addsub_pkg_v10_0 is

  constant c_addsub_v10_0_max_pipe_stages : integer := 256;
  type t_addsub_v10_0_pipe is array (0 to c_addsub_v10_0_max_pipe_stages) of integer;
  type t_c_addsub_v10_0_latency is record
    used : integer;
    pipe : t_addsub_v10_0_pipe;
  end record;

  
  constant ci_vx4_cc_limit     : integer := 12;
  constant ci_vx5_cc_limit     : integer := 20;
  constant ci_sp3adsp_cc_limit : integer := 8;
  constant ci_other_cc_limit   : integer := 10;

  function fn_c_addsub_v10_0_latency(
    C_VERBOSITY           : integer;
    C_XDEVICEFAMILY       : string;
    C_IMPLEMENTATION      : integer;
    C_A_WIDTH             : integer;
    C_B_WIDTH             : integer;
    C_OUT_WIDTH           : integer;
    C_CE_OVERRIDES_SCLR   : integer;  -- replaces c_sync_enable
    C_A_TYPE              : integer;  -- 0=signed, 1=unsigned;
    C_B_TYPE              : integer;
    C_LATENCY             : integer;
    C_ADD_MODE            : integer;  -- 0=add, 1=sub, 2=addsub;
    C_B_CONSTANT          : integer;
    C_B_VALUE             : string;
    C_AINIT_VAL           : string;
    C_SINIT_VAL           : string;
    C_CE_OVERRIDES_BYPASS : integer;  -- replaces c_bypass_enable
    C_BYPASS_LOW          : integer;
    C_SCLR_OVERRIDES_SSET : integer;  -- replaces c_sync_priority
    C_HAS_C_IN            : integer;
    C_HAS_C_OUT           : integer;  -- may be registered in step with c_latency
--     c_has_ovfl            : integer := 0;            -- may be registered in step with c_latency
    C_HAS_CE              : integer;
    C_HAS_BYPASS          : integer;
    C_HAS_SCLR            : integer;
    C_HAS_SSET            : integer;
    C_HAS_SINIT           : integer 
    ) return t_c_addsub_v10_0_latency;

  type t_c_addsub_v10_0_resources is record
    dsp48    : integer;
    bram18k  : integer;
    luts     : integer;
    ffs      : integer;
  end record;

  function fn_c_addsub_v10_0_resources(
    C_VERBOSITY           : integer;
    C_XDEVICEFAMILY       : string;
    C_IMPLEMENTATION      : integer;
    C_A_WIDTH             : integer;
    C_B_WIDTH             : integer;
    C_OUT_WIDTH           : integer;
    C_CE_OVERRIDES_SCLR   : integer;  -- replaces c_sync_enable
    C_A_TYPE              : integer;  -- 0=signed, 1=unsigned;
    C_B_TYPE              : integer;
    C_LATENCY             : integer;
    C_ADD_MODE            : integer;  -- 0=add, 1=sub, 2=addsub;
    C_B_CONSTANT          : integer;
    C_B_VALUE             : string;
    C_AINIT_VAL           : string;
    C_SINIT_VAL           : string;
    C_CE_OVERRIDES_BYPASS : integer;  -- replaces c_bypass_enable
    C_BYPASS_LOW          : integer;
    C_SCLR_OVERRIDES_SSET : integer;  -- replaces c_sync_priority
    C_HAS_C_IN            : integer;
    C_HAS_C_OUT           : integer;  -- may be registered in step with c_latency
--     c_has_ovfl            : integer := 0;            -- may be registered in step with c_latency
    C_HAS_CE              : integer;
    C_HAS_BYPASS          : integer;
    C_HAS_SCLR            : integer;
    C_HAS_SSET            : integer;
    C_HAS_SINIT           : integer 
    ) return t_c_addsub_v10_0_resources;

  function fn_c_addsub_v10_0_check_generics(
    C_VERBOSITY           : integer;
    C_XDEVICEFAMILY       : string;
    C_IMPLEMENTATION      : integer;
    C_A_WIDTH             : integer;
    C_B_WIDTH             : integer;
    C_OUT_WIDTH           : integer;
    C_CE_OVERRIDES_SCLR   : integer;  -- replaces c_sync_enable
    C_A_TYPE              : integer;  -- 0=signed, 1=unsigned;
    C_B_TYPE              : integer;
    C_LATENCY             : integer;
    C_ADD_MODE            : integer;  -- 0=add, 1=sub, 2=addsub;
    C_B_CONSTANT          : integer;
    C_B_VALUE             : string;
    C_AINIT_VAL           : string;
    C_SINIT_VAL           : string;
    C_CE_OVERRIDES_BYPASS : integer;  -- replaces c_bypass_enable
    C_BYPASS_LOW          : integer;
	C_BORROW_LOW          : integer;
    C_SCLR_OVERRIDES_SSET : integer;  -- replaces c_sync_priority
    C_HAS_C_IN            : integer;
    C_HAS_C_OUT           : integer;  -- may be registered in step with c_latency
--     c_has_ovfl            : integer := 0;            -- may be registered in step with c_latency
    C_HAS_CE              : integer;
    C_HAS_BYPASS          : integer;
    C_HAS_SCLR            : integer;
    C_HAS_SSET            : integer;
    C_HAS_SINIT           : integer 
    ) return integer;


  function fn_borrow_ports(
    has_port : integer; 
    add_mode : integer; 
    a_type : integer;
	b_type  : integer
    ) return integer;

  function fn_carry_ports(
    has_port : integer; 
    add_mode : integer; 
    a_type : integer;
	b_type  : integer
    ) return integer;

  function fn_add_port(
    add_mode : integer
    ) return integer;

  function fn_max(
    p_left  :integer; 
	p_right : integer
    ) return integer;

  function fn_get_natural_width(
  c_a_type  : integer; 
  c_b_type  : integer;
  c_add_mode  : integer;
  c_a_width  : integer; 
  c_b_width: integer
  ) return integer;

 
end package c_addsub_pkg_v10_0;

package body c_addsub_pkg_v10_0 is

  function fn_c_addsub_v10_0_latency(
    C_VERBOSITY           : integer;
    C_XDEVICEFAMILY       : string;
    C_IMPLEMENTATION      : integer;
    C_A_WIDTH             : integer;
    C_B_WIDTH             : integer;
    C_OUT_WIDTH           : integer;
    C_CE_OVERRIDES_SCLR   : integer;  -- replaces c_sync_enable
    C_A_TYPE              : integer;  -- 0=signed, 1=unsigned;
    C_B_TYPE              : integer;
    C_LATENCY             : integer;
    C_ADD_MODE            : integer;  -- 0=add, 1=sub, 2=addsub;
    C_B_CONSTANT          : integer;
    C_B_VALUE             : string;
    C_AINIT_VAL           : string;
    C_SINIT_VAL           : string;
    C_CE_OVERRIDES_BYPASS : integer;  -- replaces c_bypass_enable
    C_BYPASS_LOW          : integer;
    C_SCLR_OVERRIDES_SSET : integer;  -- replaces c_sync_priority
    C_HAS_C_IN            : integer;
    C_HAS_C_OUT           : integer;  -- may be registered in step with c_latency
--     c_has_ovfl            : integer := 0;            -- may be registered in step with c_latency
    C_HAS_CE              : integer;
    C_HAS_BYPASS          : integer;
    C_HAS_SCLR            : integer;
    C_HAS_SSET            : integer;
    C_HAS_SINIT           : integer 
    ) return t_c_addsub_v10_0_latency is

    variable ret_val : t_c_addsub_v10_0_latency;
    variable v_latency_left : integer;
    variable v_lat_req : integer;
  begin
    
    v_latency_left := c_latency;
    ret_val.used := 0;
      for i in 0 to c_addsub_v10_0_max_pipe_stages loop
        ret_val.pipe(i) := 0;
      end loop;  -- i
    if c_implementation = 0 then
      --fabric
      if c_latency = -1 then
        if has_dsp48(c_xdevicefamily) then
          v_lat_req := (c_out_width-1)/ci_vx4_cc_limit + 1;
        elsif has_dsp48e(c_xdevicefamily) then
          v_lat_req := (c_out_width-1)/ci_vx5_cc_limit + 1;
        elsif has_dsp48a(c_xdevicefamily) then
          v_lat_req := (c_out_width-1)/ci_sp3adsp_cc_limit + 1;
        else
          v_lat_req := (c_out_width-1)/ci_other_cc_limit + 1;
        end if;
      else
        v_lat_req := c_latency;
      end if;
      ret_val.used := v_lat_req;
      for k in 1 to v_lat_req loop
        ret_val.pipe(k) := 1;
      end loop;  -- k
    else
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
          report "ERROR: c_addsub_v10_0: Excessive latency for DSP48-based case."
          severity error;
      end if;
      
    end if;
    return ret_val;
  end function fn_c_addsub_v10_0_latency;

  --Add when have xbip_addsub_v1_0_latency....
--	function fn_c_addsub_v10_0_latency(
--    C_VERBOSITY           : integer;
--    C_XDEVICEFAMILY       : string;
--    C_IMPLEMENTATION      : integer;
--    C_A_WIDTH             : integer;
--    C_B_WIDTH             : integer;
--    C_OUT_WIDTH           : integer;
--    C_CE_OVERRIDES_SCLR   : integer;  -- replaces c_sync_enable
--    C_A_TYPE              : integer;  -- 0=signed, 1=unsigned;
--    C_B_TYPE              : integer;
--    C_LATENCY             : integer;
--    C_ADD_MODE            : integer;  -- 0=add, 1=sub, 2=addsub;
--    C_B_CONSTANT          : integer;
--    C_B_VALUE             : string;
--    C_AINIT_VAL           : string;
--    C_SINIT_VAL           : string;
--    C_CE_OVERRIDES_BYPASS : integer;  -- replaces c_bypass_enable
--    C_BYPASS_LOW          : integer;
--    C_SCLR_OVERRIDES_SSET : integer;  -- replaces c_sync_priority
--    C_HAS_C_IN            : integer;
--    C_HAS_C_OUT           : integer;  -- may be registered in step with c_latency
--     c_has_ovfl            : integer := 0;            -- may be registered in step with c_latency
--    C_HAS_CE              : integer;
--    C_HAS_BYPASS          : integer;
--    C_HAS_SCLR            : integer;
--    C_HAS_SSET            : integer;
--    C_HAS_SINIT           : integer 
--    ) return t_c_addsub_v10_0_latency is
--    variable ret_val : t_c_addsub_v10_0_latency;
--    variable xbip_addsub_lat : t_xbip_addsub_v1_0_latency;  --not added to xbip at this time
--  begin
--    if C_LATENCY = -1 then
--      xbip_addsub_lat := fn_xbip_addsub_v1_0_latency(
--        p_xdevicefamily  => C_XDEVICEFAMILY,
--        p_implementation => C_IMPLEMENTATION,
--        p_verbosity => C_VERBOSITY,
--        p_latency => C_LATENCY,
--        p_bypass_low => C_BYPASS_LOW,
--		p_a_width => C_A_WIDTH,
--		p_b_width => C_B_WIDTH,
--        p_out_width => C_OUT_WIDTH,
--        p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR,
--        p_A_type => C_A_TYPE,
--		p_B_type => C_B_TYPE
--       );
--      ret_val.used := xbip_accum_lat.used;
--    else
--      ret_val.used := c_latency;
--    end if;
--    return ret_val;
--  end fn_c_addsub_v10_0_latency;

--Add when include xbip_addsub_v1_0_resources...
--    function fn_c_addsub_v10_0_resources(
--    C_VERBOSITY           : integer;
--    C_XDEVICEFAMILY       : string;
--    C_IMPLEMENTATION      : integer;
--    C_A_WIDTH             : integer;
--    C_B_WIDTH             : integer;
--    C_OUT_WIDTH           : integer;
--    C_CE_OVERRIDES_SCLR   : integer;  -- replaces c_sync_enable
--    C_A_TYPE              : integer;  -- 0=signed, 1=unsigned;
--    C_B_TYPE              : integer;
--    C_LATENCY             : integer;
--    C_ADD_MODE            : integer;  -- 0=add, 1=sub, 2=addsub;
--    C_B_CONSTANT          : integer;
--    C_B_VALUE             : string;
--    C_AINIT_VAL           : string;
--    C_SINIT_VAL           : string;
--    C_CE_OVERRIDES_BYPASS : integer;  -- replaces c_bypass_enable
--    C_BYPASS_LOW          : integer;
--    C_SCLR_OVERRIDES_SSET : integer;  -- replaces c_sync_priority
--    C_HAS_C_IN            : integer;
--    C_HAS_C_OUT           : integer;  -- may be registered in step with c_latency
--     c_has_ovfl            : integer := 0;            -- may be registered in step with c_latency
--    C_HAS_CE              : integer;
--    C_HAS_BYPASS          : integer;
--    C_HAS_SCLR            : integer;
--    C_HAS_SSET            : integer;
--    C_HAS_SINIT           : integer 
--    ) return t_c_addsub_v10_0_resources is
--    variable ret_val : t_c_addsub_v10_0_resources;
--    variable xbip_addsub_res : t_xbip_addsub_v1_0_resources;
--  begin
--    if C_IMPLEMENTATION = 1 then
--      xbip_addsub_res := fn_xbip_addsub_v1_0_get_resources(
--        p_xdevicefamily  => C_XDEVICEFAMILY,
--        p_implementation => C_IMPLEMENTATION,
--        p_verbosity => C_VERBOSITY,
--        p_latency => C_LATENCY,
--        p_bypass_low => C_BYPASS_LOW,
--		p_a_width => C_A_WIDTH,
--		p_b_width => C_B_WIDTH,
--        p_out_width => C_OUT_WIDTH,
--        p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR,
--        p_A_type => C_A_TYPE,
--		p_B_type => C_B_TYPE
--        );
--      ret_val.dsp48 := xbip_accum_res.dsp48;
--      ret_val.bram18k := xbip_accum_res.bram18k;
--      ret_val.luts := xbip_accum_res.luts;
--      ret_val.ffs := xbip_accum_res.ffs;
--    else
--      ret_val.dsp48 := 0;
--      ret_val.bram18k := 0;
--      ret_val.luts := C_OUT_WIDTH;
--      ret_val.ffs := C_OUT_WIDTH;
--    end if;
--    return ret_val;
--  end fn_c_addsub_v10_0_resources;

  function fn_c_addsub_v10_0_resources(
    C_VERBOSITY           : integer;
    C_XDEVICEFAMILY       : string;
    C_IMPLEMENTATION      : integer;
    C_A_WIDTH             : integer;
    C_B_WIDTH             : integer;
    C_OUT_WIDTH           : integer;
    C_CE_OVERRIDES_SCLR   : integer;  -- replaces c_sync_enable
    C_A_TYPE              : integer;  -- 0=signed, 1=unsigned;
    C_B_TYPE              : integer;
    C_LATENCY             : integer;
    C_ADD_MODE            : integer;  -- 0=add, 1=sub, 2=addsub;
    C_B_CONSTANT          : integer;
    C_B_VALUE             : string;
    C_AINIT_VAL           : string;
    C_SINIT_VAL           : string;
    C_CE_OVERRIDES_BYPASS : integer;  -- replaces c_bypass_enable
    C_BYPASS_LOW          : integer;
    C_SCLR_OVERRIDES_SSET : integer;  -- replaces c_sync_priority
    C_HAS_C_IN            : integer;
    C_HAS_C_OUT           : integer;  -- may be registered in step with c_latency
--     c_has_ovfl            : integer := 0;            -- may be registered in step with c_latency
    C_HAS_CE              : integer;
    C_HAS_BYPASS          : integer;
    C_HAS_SCLR            : integer;
    C_HAS_SSET            : integer;
    C_HAS_SINIT           : integer 
    ) return t_c_addsub_v10_0_resources is
    variable ret_val : t_c_addsub_v10_0_resources;
    variable v_addsub_pipe : t_c_addsub_v10_0_latency;
    variable v_latency : integer;
  begin
    v_addsub_pipe := fn_c_addsub_v10_0_latency(
      c_verbosity           => c_verbosity,
      c_xdevicefamily       => c_xdevicefamily,
      c_implementation      => c_implementation,
      c_a_width             => c_a_width,
      c_b_width             => c_b_width,
      c_out_width           => c_out_width,
      c_ce_overrides_sclr   => c_ce_overrides_sclr,
      c_a_type              => c_a_type,
      c_b_type              => c_b_type,
      c_latency             => c_latency,
      c_add_mode            => c_add_mode,
      c_b_constant          => c_b_constant,
      c_b_value             => c_b_value,
      c_ainit_val           => c_ainit_val,
      c_sinit_val           => c_sinit_val,
      c_ce_overrides_bypass => c_ce_overrides_bypass,
      c_bypass_low          => c_bypass_low,
      c_sclr_overrides_sset => c_sclr_overrides_sset,
      c_has_c_in            => c_has_c_in,
      c_has_c_out           => c_has_c_out,
      c_has_ce              => c_has_ce,
      c_has_bypass          => c_has_bypass,
      c_has_sclr            => c_has_sclr,
      c_has_sset            => c_has_sset,
      c_has_sinit           => c_has_sinit
      );
    v_latency := v_addsub_pipe.used;
    
    if c_implementation = 0 then
      --legacy - very rough estimates!
      ret_val.dsp48   := 0;
      ret_val.bram18k := 0;
      ret_val.luts    := c_out_width * (v_latency+1 ) / 2;  --diagonal structure
      ret_val.ffs     := c_out_width * v_latency;
    else
      ret_val.dsp48   := 1;
      ret_val.bram18k := 0;
      ret_val.luts    := 0;
      ret_val.ffs     := 0;
    end if;
    return ret_val;
  end function fn_c_addsub_v10_0_resources;

    function fn_c_addsub_v10_0_check_generics(
    C_VERBOSITY           : integer;
    C_XDEVICEFAMILY       : string;
    C_IMPLEMENTATION      : integer;
    C_A_WIDTH             : integer;
    C_B_WIDTH             : integer;
    C_OUT_WIDTH           : integer;
    C_CE_OVERRIDES_SCLR   : integer;  -- replaces c_sync_enable
    C_A_TYPE              : integer;  -- 0=signed, 1=unsigned;
    C_B_TYPE              : integer;
    C_LATENCY             : integer;
    C_ADD_MODE            : integer;  -- 0=add, 1=sub, 2=addsub;
    C_B_CONSTANT          : integer;
    C_B_VALUE             : string;
    C_AINIT_VAL           : string;
    C_SINIT_VAL           : string;
    C_CE_OVERRIDES_BYPASS : integer;  -- replaces c_bypass_enable
    C_BYPASS_LOW          : integer;
	C_BORROW_LOW          : integer;
    C_SCLR_OVERRIDES_SSET : integer;  -- replaces c_sync_priority
    C_HAS_C_IN            : integer;
    C_HAS_C_OUT           : integer;  -- may be registered in step with c_latency
--     c_has_ovfl            : integer := 0;            -- may be registered in step with c_latency
    C_HAS_CE              : integer;
    C_HAS_BYPASS          : integer;
    C_HAS_SCLR            : integer;
    C_HAS_SSET            : integer;
    C_HAS_SINIT           : integer 
    ) return integer is
    
    
    constant error_string :  string := "ERROR: c_addsub_v10_0: ";
    constant warn_string :  string := "WARNING: c_addsub_v10_0: ";
  begin

    if C_VERBOSITY /= 0 and C_VERBOSITY /= 1 and C_VERBOSITY /= 2 then
      report warn_string & "C_VERBOSITY valid range is 0 to 2.  Setting to 2.  Current value is " & integer'image(C_VERBOSITY) severity warning;
    end if;

    assert C_IMPLEMENTATION = 0 or C_IMPLEMENTATION = 1  
      report error_string & "C_IMPLEMENTATION valid range is 0 to 1.  Current value is " & integer'image(C_IMPLEMENTATION) severity error;

    assert C_XDEVICEFAMILY /= "NO_FAMILY" 
      report error_string & "C_XDEVICEFAMILY has not been correctly set (perhaps by CORE Generator)" severity error;

    assert C_A_TYPE = 0 or C_A_TYPE = 1  
      report error_string & "C_A_TYPE valid range is 0 to 1.  Current value is " & integer'image(C_A_TYPE) severity error;

	assert C_B_TYPE = 0 or C_B_TYPE = 1  
      report error_string & "C_B_TYPE valid range is 0 to 1.  Current value is " & integer'image(C_B_TYPE) severity error;

    assert C_CE_OVERRIDES_SCLR = 0 or C_CE_OVERRIDES_SCLR = 1  
      report error_string & "C_CE_OVERRIDES_SCLR valid range is 0 to 1.  Current value is " & integer'image(C_CE_OVERRIDES_SCLR) severity error;

    assert C_ADD_MODE = 0 or C_ADD_MODE = 1 or C_ADD_MODE = 2
      report error_string & "C_ADD_MODE valid range is 0 to 2.  Current value is " & integer'image(C_ADD_MODE) severity error;

    assert C_HAS_C_IN = 0 or C_HAS_C_IN = 1
      report error_string & "C_HAS_C_IN valid range is 0 to 1.  Current value is " & integer'image(C_HAS_C_IN) severity error;

	assert C_BORROW_LOW = 0 or C_BORROW_LOW = 1
      report error_string & "C_BORROW_LOW valid range is 0 to 1.  Current value is " & integer'image(C_BORROW_LOW) severity error;

    if C_A_TYPE=0 and C_B_TYPE=0 then
      assert C_HAS_C_OUT = 0 
        report error_string & "Carry Out (Borrow Out) is only available for unsigned data.  Current value is " & integer'image(C_HAS_C_OUT) severity error;
    end if;

    assert C_HAS_CE = 0 or C_HAS_CE = 1
      report error_string & "C_HAS_CE valid range is 0 to 1.  Current value is " & integer'image(C_HAS_CE) severity error;

    assert C_HAS_BYPASS = 0 or C_HAS_BYPASS = 1
      report error_string & "C_HAS_BYPASS valid range is 0 to 1.  Current value is " & integer'image(C_HAS_BYPASS) severity error;

    assert C_HAS_SCLR = 0 or C_HAS_SCLR = 1
      report error_string & "C_HAS_SCLR valid range is 0 to 1.  Current value is " & integer'image(C_HAS_SCLR) severity error;

	ASSERT c_a_width >= 2 OR (c_a_type = 1)
      REPORT "ERROR - addsub: c_a_width must be at least 2 bits if it is to be a signed type"
      SEVERITY FAILURE;
    ASSERT c_b_width >= 2 OR (c_b_type = 1)
      REPORT "ERROR - addsub: c_b_width must be at least 2 bits if it is to be a signed type"
      SEVERITY FAILURE;
    ASSERT c_out_width <= fn_get_natural_width(c_a_type, c_b_type, c_add_mode, c_a_width, c_b_width)
      REPORT "ERROR - addsub: c_out_width too large (or too small)- see data sheet for allowable values"
      SEVERITY FAILURE; 
	  	--should be equal to for the correct output but sysgen wants bc for input width = output width so returning ERROR trap to the way it was
	ASSERT c_out_width = fn_get_natural_width(c_a_type, c_b_type, c_add_mode, c_a_width, c_b_width)
      REPORT "WARNING - addsub: c_out_width may be larger than necessary or too small to accommodate bit growth - see data sheet for allowable values (System generator pads inputs to allow smaller c_out_widths than would otherwise be acceptable)"
      SEVERITY WARNING; 

    if C_IMPLEMENTATION = 0 then
      assert C_A_WIDTH > 0 AND C_A_WIDTH <= 256 
        report error_string & "Invalid value for C_A_WIDTH; must be in the range 1..256.  Current value is " & integer'image(C_A_WIDTH) severity error;
	  assert C_B_WIDTH > 0 AND C_B_WIDTH <= 256 
        report error_string & "Invalid value for C_B_WIDTH; must be in the range 1..256.  Current value is " & integer'image(C_B_WIDTH) severity error;
      assert C_OUT_WIDTH >= C_A_WIDTH and C_OUT_WIDTH >= C_B_WIDTH  AND C_OUT_WIDTH <= 258 
        report error_string & "Invalid value for C_OUT_WIDTH; must be in the range: larger of (C_A_WIDTH, C_B_WIDTH)..258.  Current value is " & integer'image(C_OUT_WIDTH) severity error;
 --      Check LATENCY CHECKS
      assert C_LATENCY > -2 AND C_LATENCY <= C_OUT_WIDTH
        report error_string & "C_LATENCY valid values between -1 and output width for the fabric implementation.  Current value is " & integer'image(C_LATENCY) severity error;
      assert C_BORROW_LOW = 1 
	  report error_string & "C_BORROW_LOW must be 1 for fabric  Current value is " & integer'image(C_BORROW_LOW) severity error;

      assert C_B_CONSTANT = 0 or C_B_CONSTANT = 1
        report error_string & "C_B_CONSTANT valid range is 0 to 1.  Current value is " & integer'image(C_B_CONSTANT) severity error;
	  --add check for C_B_VALUE		
--	  assert C_B_VALUE 
--       report error_string & "C_B_VALUE must be equal to C_B_WIDTH.  Current value is " & integer'image(C_B_VALUE) severity error;
      assert C_BYPASS_LOW = 0 or C_BYPASS_LOW = 1
        report error_string & "C_BYPASS_LOW valid range is 0 to 1.  Current value is " & integer'image(C_BYPASS_LOW) severity error;
      assert C_CE_OVERRIDES_BYPASS = 0 or C_CE_OVERRIDES_BYPASS = 1
        report error_string & "C_CE_OVERRIDES_BYPASS valid range is 0 to 1.  Current value is " & integer'image(C_CE_OVERRIDES_BYPASS) severity error;
	  assert C_SCLR_OVERRIDES_SSET = 0 or C_SCLR_OVERRIDES_SSET = 1
        report error_string & "C_SCLR_OVERRIDES_SSET valid range is 0 to 1.  Current value is " & integer'image(C_SCLR_OVERRIDES_SSET) severity error;
      assert C_HAS_SSET = 0 or C_HAS_SSET = 1
        report error_string & "C_HAS_SSET valid range is 0 to 1.  Current value is " & integer'image(C_HAS_SSET) severity error;
      assert C_HAS_SINIT = 0 or C_HAS_SINIT = 1
        report error_string & "C_HAS_SINIT valid range is 0 to 1.  Current value is " & integer'image(C_HAS_SINIT) severity error;

    IF c_has_c_out = 1  THEN
      ASSERT c_a_type = 1 AND c_b_type = 1
	  REPORT "ERROR - addsub: Carry out is only permitted when both inputs are unsigned"
        SEVERITY FAILURE;
    END IF;

   IF c_out_width >= fn_get_natural_width(c_a_type, c_b_type, c_add_mode, c_a_width, c_b_width) THEN -- output has enough bits to cope with all cases
--      ASSERT p_has_ovfl = 0 AND p_has_q_ovfl = 0
--       REPORT "ERROR - addsub: The core has sufficient bit-growth to render overflow redundant"
--        SEVERITY FAILURE;
--      ASSERT p_has_c_out = 0 AND p_has_q_c_out = 0
--        REPORT "ERROR - addsub: The core has sufficient bit-growth to render carry-out redundant"
--        SEVERITY FAILURE;
--      ASSERT p_has_b_out = 0 AND p_has_q_b_out = 0
      ASSERT c_has_c_out = 0 
        REPORT "ERROR - addsub: The core has sufficient bit-growth to render borrow-out redundant"
        SEVERITY FAILURE;
    END IF;

    -- Warning for nonintuitive behaviour
    --
    -- it's not clear what the Right Thing to do is with c_b_value
    -- when it's narrower than c_b_width; but I go on the basis
    -- that "1" probably means one and not minus one, and therefore
    -- zero-extend and not sign-extend.

	--take out until figure out how to add a binary number of certain width to tpr
--    IF c_b_constant = 1 THEN
-- --     IF c_b_type = 0 THEN
--        ASSERT (c_b_value'LENGTH = c_b_width)
--          REPORT "ERROR - addsub: c_b_value is not equal to c_b_width"
--          SEVERITY FAILURE;
----      END IF;
--    END IF;

    -- FIXME pipelining-specific generics need to be considered

      IF c_has_sset = 1 OR c_has_sinit = 1 THEN
        ASSERT FALSE
          REPORT "WARNING - addsub: In the interests of efficiency, sset and sinit are ignored for pipelined modules"
          SEVERITY WARNING;
      END IF;

    else
      if not(has_dsp48(C_XDEVICEFAMILY)or has_DSP48e(C_XDEVICEFAMILY) or has_dsp48a(C_XDEVICEFAMILY)) then
        assert false
          report error_string & "Invalid value for C_XDEVICEDFAMILY; must be VIRTEX4, VIRTEX5, or SPARTAN3ADSP for DSP48 implementation.  Current value is " & C_XDEVICEFAMILY severity error;
      end if;
      assert C_A_WIDTH > 0 AND C_A_WIDTH <= 48-C_A_TYPE -- Allow bit growth for correct answer in unsigned case.  The A input feeds into the C input of the DSP48 usecase so the width will always be 48 
        report error_string & "Invalid value for C_A_WIDTH; must be in the range 1.." & integer'image(48-C_A_TYPE) & ".  Current value is " & integer'image(C_A_WIDTH) severity error;

      assert C_B_WIDTH > 0 AND C_B_WIDTH <= (fn_dsp48_concat_width(C_XDEVICEFAMILY)-C_B_TYPE)  --The B input feeds the concatenated A:B input of the DSP48 usecase 
        report error_string & "Invalid value for C_B_WIDTH; must be in the range 1.." & integer'image(fn_dsp48_concat_width(C_XDEVICEFAMILY)-C_B_TYPE) & ".  Current value is " & integer'image(C_B_WIDTH) severity error;

		IF c_a_type = 1 AND c_b_type = 1 THEN
      assert C_OUT_WIDTH >= C_A_WIDTH AND C_OUT_WIDTH >= C_B_WIDTH AND C_OUT_WIDTH <= 47 
        report error_string & "Invalid value for C_OUT_WIDTH; must be in the  range: larger of (C_A_WIDTH, C_B_WIDTH)..47 with unsigned inputs to fit into a single dsp48.  Current value is " & integer'image(C_OUT_WIDTH) severity error;
        else
      assert C_OUT_WIDTH >= C_A_WIDTH AND C_OUT_WIDTH >= C_B_WIDTH AND C_OUT_WIDTH <= 48 
        report error_string & "Invalid value for C_OUT_WIDTH; must be in the  range: larger of (C_A_WIDTH, C_B_WIDTH)..48.  Current value is " & integer'image(C_OUT_WIDTH) severity error;
		END IF;
 
      assert C_LATENCY = 0 or C_LATENCY = 1 or C_LATENCY = -1 or C_LATENCY = 2
        report error_string & "C_LATENCY valid values of -1, 0, 1 and 2 for the DSP48 implementation.  Current value is " & integer'image(C_LATENCY) severity error;

      if C_VERBOSITY = 1 then 
        assert C_BYPASS_LOW = 0 
          report warn_string & "C_BYPASS_LOW is not supported in the DSP48 implementation; it will be set to 0 (active High bypass).  Current value is " & integer'image(C_BYPASS_LOW) severity warning;
        assert C_HAS_SSET = 0 
          report warn_string & "C_HAS_SSET is not supported in the DSP48 implementation; it will be set to 0 (no SSET port).  Current value is " & integer'image(C_HAS_SSET) severity warning;
        assert C_HAS_SINIT = 0 
          report warn_string & "C_HAS_SINIT is not supported in the DSP48 implementation; it will be set to 0 (no SINIT port).  Current value is " & integer'image(C_HAS_SINIT) severity warning;
		  assert C_BORROW_LOW = 1 and C_IMPLEMENTATION = 1 and C_ADD_MODE /= 0
		  report warn_string & "Extra logic will be added to invert the sense of the carryin signal when subtracting in DSP48.  Current value is " & integer'image(C_BORROW_LOW) severity warning;

      end if;
    end if;
    return 0;
  end function fn_c_addsub_v10_0_check_generics;

  function fn_borrow_ports(
    has_port : integer; 
    add_mode : integer; 
    a_type: integer;
    b_type : integer
  ) return integer is
  begin
    if add_mode=1 and a_type=1 and b_type=1 then
      return has_port;
    else
      return 0;
    end if;
  end fn_borrow_ports;

  function fn_carry_ports(
    has_port : integer; 
    add_mode : integer; 
    a_type : integer;
    b_type : integer
  ) return integer is
  begin
    if add_mode=1 or a_type=0 or b_type=0 then
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

    -- purpose: used in natural output width calculation below
  function fn_max(
  p_left : integer;
  p_right : integer
  ) return integer is
  begin
    if p_left > p_right then
      return p_left;
    else
      return p_right;
    end if;
  end fn_max;

  -- purpose: calculates the natural output width which is just the right
  -- size to be able to cope with all possible inputs.
  -- Usually this is max(c_a_width,c_b_width) + 1 but a few cases will produce
  -- 2 bits of growth
  function fn_get_natural_width(
  c_a_type : integer;
  c_b_type : integer; 
  c_add_mode : integer; 
  c_a_width : integer; 
  c_b_width : integer
  ) return integer is 
    variable ret_val : integer;
  begin
    -- the valid output widths are somewhat confusing...
    -- for signed +/- signed, 1 bit natural growth regardless of c_add_mode
    -- for unsigned +/- unsigned, 1 bit growth except for adder/subtractors, which produce 2 extra bits.
    -- for unsigned +/- signed or signed +/- unsigned, things get messier.
    -- if the unsigned input is wider-than-or-equal-to the signed input, there are 2 extra bits
    --   eg: 8-bit signed + 8-bit unsigned = (-128..127) + (0..255) = (-128..382) which needs 10 bits to represent fully.
    -- if the signed input is wider than the unsigned input, there is 1 bit growth.
    -- note that for mixed signed/unsigned, c_add_mode has no effect on the growth.
    if (c_a_type = 1 and c_b_type = 1) then
      -- both inputs unsigned  Fabric follows a Q + 1 growth when add_mode =2
      if (c_add_mode =2) then
        ret_val := fn_max(c_a_width,c_b_width) + 1;  --was 2..but no reason?
      else -- pure adder or subtractor
        ret_val := fn_max(c_a_width,c_b_width) + 1;
      end if;
    elsif (c_a_type = 0 and c_b_type = 0) then
      -- both inputs signed
      ret_val := fn_max(c_a_width,c_b_width) + 1;
    else -- mix of signed & unsigned
      if (c_a_type = 1 and c_a_width >= c_b_width) or
         (c_b_type = 1 and c_b_width >= c_a_width) then
        -- unsigned input is wider or equal
        ret_val := fn_max(c_a_width, c_b_width) + 2;
      else
        -- signed input is wider
        ret_val := fn_max(c_a_width, c_b_width) + 1;
      end if;
    end if;
    return ret_val;
  end fn_get_natural_width;
    
end package body c_addsub_pkg_v10_0;

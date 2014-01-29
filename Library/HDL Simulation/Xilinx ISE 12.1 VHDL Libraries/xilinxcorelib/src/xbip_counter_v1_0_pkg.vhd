-- $Id: xbip_counter_v1_0_pkg.vhd,v 1.2 2008/09/10 09:46:12 akennedy Exp $
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

package xbip_counter_v1_0_pkg is

  type t_xbip_counter_v1_0_fb_latency is record
    used        : integer;
    gate_pipes  : integer;
    gate_op     : integer;
    gate_excess : integer;
  end record;

  type t_xbip_counter_v1_0_thresh_latency is record
    gate_pipes  : integer;
    gate_op     : integer;
  end record;

  constant c_bip_counter_v1_0_max_pipe_stages : integer := 32;
  type t_xbip_counter_v1_0_pipe is array (0 to c_bip_counter_v1_0_max_pipe_stages) of integer;
  
  type t_xbip_counter_v1_0_latency is record
    used : integer;
    pipe : t_xbip_counter_v1_0_pipe;
  end record;

  type t_xbip_counter_v1_0_resources is record
    dsp48    : integer;
    bram18k  : integer;
    luts     : integer;
    ffs      : integer;
  end record;
  
  function fn_xbip_counter_v1_0_check_generics(
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_use_dsp48         : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return integer;

  function fn_xbip_counter_v1_0_get_resources(
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_use_dsp48         : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return t_xbip_counter_v1_0_resources;
  
  function fn_xbip_counter_v1_0_latency(
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_use_dsp48         : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return t_xbip_counter_v1_0_latency;
  
  function fn_xbip_counter_v1_0_get_fb_latency (
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_use_dsp48         : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return t_xbip_counter_v1_0_fb_latency;

  function fn_xbip_counter_v1_0_get_thresh_latency (
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_use_dsp48         : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return t_xbip_counter_v1_0_thresh_latency;

  constant ci_vx4_cc_limit     : integer := 12;
  constant ci_vx5_cc_limit     : integer := 20;
  constant ci_sp3adsp_cc_limit : integer := 8;
  constant ci_other_cc_limit   : integer := 10;
  
end package xbip_counter_v1_0_pkg;

package body xbip_counter_v1_0_pkg is

  function fn_xbip_counter_v1_0_check_generics(
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_use_dsp48         : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return integer is
  begin
    --simple range checks first
    if p_use_dsp48 <0 or p_use_dsp48 > 1 then
      assert false
        report "ERROR: xbip_counter_v1_0: C_USE_DSP48 must be 0 or 1."
        severity error;
    end if;
    if p_restrict_count <0 or p_restrict_count > 1 then
      assert false
        report "ERROR: xbip_counter_v1_0: C_RESTRICT_COUNT must be 0 or 1."
        severity error;
    end if;
    if p_has_thresh0 <0 or p_has_thresh0 > 1 then
      assert false
        report "ERROR: xbip_counter_v1_0: C_HAS_THRESH0 must be 0 or 1."
        severity error;
    end if;
    if p_has_load <0 or p_has_load > 1 then
      assert false
        report "ERROR: xbip_counter_v1_0: C_HAS_LOAD must be 0 or 1."
        severity error;
    end if;
    if p_load_low <0 or p_load_low > 1 then
      assert false
        report "ERROR: xbip_counter_v1_0: C_LOAD_LOW must be 0 or 1."
        severity error;
    end if;
    if p_ce_overrides_sclr <0 or p_ce_overrides_sclr > 1 then
      assert false
        report "ERROR: xbip_counter_v1_0: C_CE_OVERRIDES_SCLR must be 0 or 1."
        severity error;
    end if;
    if p_latency < -1 or p_latency = 0 or p_latency > 32 then
      assert false
        report "ERROR: xbip_counter_v1_0: C_LATENCY must be -1 or in the range 1 to 32"
        severity error;
    end if;
    if p_fb_latency < -1 or p_fb_latency > 4 then
      assert false
        report "ERROR: xbip_counter_v1_0: C_FB_LATENCY must be -1 or in the range 0 to 4"
        severity error;
    end if;
    if p_width < 1 or p_width > 256 then
      assert false
        report "ERROR: xbip_counter_v1_0: C_WIDTH must be in the range 1 to 256"
        severity error;
    end if;
    if p_count_mode < 0 or p_count_mode > 2 then
      assert false
        report "ERROR: xbip_counter_v1_0: C_COUNT_MODE must be 0 (add), 1(sub) or 2(add/sub)"
        severity error;
    end if;

    --combination checks
    if p_count_mode = 2 and p_has_thresh0 = 1 then
      assert false
        report "ERROR: Threshold detection is not allowed for up/down counters due to the latency."
        severity error;
    end if;

    if p_count_mode = 2 and p_restrict_count = 1 then
      assert false
        report "ERROR: Restricted counting is not allowed for up/down counters due to the latency in the terminal count detection."
        severity error;
    end if;

    --WARNINGS
    if p_verbosity > 0 then
      if (p_load_low = 0 and p_use_dsp48 = 0) or (p_load_low = 1 and p_use_dsp48 = 1 and has_dsp48a(p_xdevicefamily)) then
        assert false
          report "WARNING: xbip_counter_v1_0: C_LOAD_LOAD and C_USE_DSP48 values are non-optimal."
          severity warning;
      end if;
    end if;
    return 0;
  end fn_xbip_counter_v1_0_check_generics;
  
  function fn_xbip_counter_v1_0_get_resources(
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_use_dsp48         : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return t_xbip_counter_v1_0_resources is
    variable ret_val : t_xbip_counter_v1_0_resources;
    variable v_lat : integer;
    variable v_fb_lat_array : t_xbip_counter_v1_0_fb_latency;
    variable v_fb_lat : integer;
    variable v_lut_size : integer;
    variable v_fam : T_DEVICE_FAMILY := fn_check_family(p_xdevicefamily);
    constant ci_num_segs_array : t_xbip_counter_v1_0_latency := fn_xbip_counter_v1_0_latency(
      p_xdevicefamily     => p_xdevicefamily,
      p_verbosity         => p_verbosity,
      p_use_dsp48         => p_use_dsp48,
      p_latency           => p_latency,
      p_fb_latency        => p_fb_latency,
      p_width             => p_width,
      p_restrict_count    => p_restrict_count,
      p_count_to          => p_count_to,
      p_count_by          => p_count_by,
      p_count_mode        => p_count_mode,
      p_thresh0_value     => p_thresh0_value,
      p_ce_overrides_sclr => p_ce_overrides_sclr,
      p_has_thresh0       => p_has_thresh0,
      p_has_load          => p_has_load,
      p_load_low          => p_load_low
      );
    constant ci_num_segs : integer := ci_num_segs_array.used;
    variable ci_seg_width : integer := 0;
    variable temp : integer := 0;
  begin
    temp := p_width -1;
    ci_seg_width := temp/ci_num_segs +1;
    ret_val.dsp48 := 0;
    ret_val.bram18k := 0;
    ret_val.luts := 0;
    ret_val.ffs := 0;

    v_lat := ci_num_segs;               -- it's a diagonal structure.

    v_fb_lat_array := fn_xbip_counter_v1_0_get_fb_latency(
      p_xdevicefamily     => p_xdevicefamily,
      p_verbosity         => p_verbosity,
      p_use_dsp48         => p_use_dsp48,
      p_latency           => v_lat,
      p_fb_latency        => p_fb_latency,
      p_width             => p_width,
      p_restrict_count    => p_restrict_count,
      p_count_to          => p_count_to,
      p_count_by          => p_count_by,
      p_count_mode        => p_count_mode,
      p_thresh0_value     => p_thresh0_value,
      p_ce_overrides_sclr => p_ce_overrides_sclr,
      p_has_thresh0       => p_has_thresh0,
      p_has_load          => p_has_load,
      p_load_low          => p_load_low
      );
    v_fb_lat := v_fb_lat_array.used;

    if p_use_dsp48 = 1 then
      ret_val.dsp48 := 1;               --simple for now!
      if v_lat = 3 and has_dsp48a(p_xdevicefamily) and p_width > 36 then
        ret_val.ffs := ret_val.ffs + p_width -36;
      end if;
      --ignore logic for extension of opmode. It's only one or two lut/ffs.
    else
      --logic in pipelined fabric count.
      --each stage has carry in and carryout except the first and last
      
      --second implementation:
--      ret_val.luts := (p_width + v_lat*2 - 2);
--      ret_val.ffs  := p_width * v_lat + (v_lat*2 -2) ;       -- so far.

      ret_val.luts := (p_width + v_lat*2 - 2);  --luts in counters
      ret_val.ffs  := (p_width + v_lat - 1);    --each segment counter is a bit
--wider to accommodate cout, apart from the last stage.

      --Q pipe
      if ci_num_segs > 1 then
        ret_val.ffs  := ret_val.ffs + (ci_num_segs-1)*ci_seg_width;
      end if;
      if ci_num_segs > 2 then
        ret_val.luts := ret_val.luts + (ci_num_segs-2)*ci_seg_width;  --SRLs
      end if;

      --load value pipe
      if p_has_load = 1 then
        if ci_num_segs > 1 then
          ret_val.ffs  := ret_val.ffs + p_width - ci_seg_width;
        end if;
        if ci_num_segs > 2 then
          ret_val.luts := ret_val.luts + p_width-2*ci_seg_width;  --SRLs
        end if;

        --load pipe
        ret_val.ffs := ret_val.ffs + v_lat-1;
      end if;

      --up pipe
      if p_count_mode = 2 then
        ret_val.ffs := ret_val.ffs + v_lat-1;
      end if;
      --tc pipe
      if p_restrict_count = 1 then
        ret_val.ffs := ret_val.ffs + v_lat-1;
      end if;
    end if;

    v_lut_size := fn_get_lut_size(v_fam);

    ---------------------------------------------------------------------------
    -- Terminal count logic. This is a simplification based on
    -- the idea that the gate bit is implemented using gates only. With less than
    -- optimal latency it can use the carry chain too.
    ---------------------------------------------------------------------------
    if p_restrict_count = 1 then
      if p_width <= v_lut_size then
        ret_val.luts := ret_val.luts + 1;  
        if v_fb_lat = 1 then
          ret_val.ffs := ret_val.ffs + 1;
        end if;
      elsif p_width <= v_lut_size*v_lut_size then
        ret_val.luts := ret_val.luts + 1;  
        ret_val.luts := ret_val.luts + (p_width-1)/v_lut_size + 1;
        if v_fb_lat > 1 then
          ret_val.ffs := ret_val.ffs + 1 + ((p_width-1)/v_lut_size + 1);
        end if;
      elsif p_width <= v_lut_size*v_lut_size*v_lut_size then
        ret_val.luts := ret_val.luts + 1; 
        ret_val.luts := ret_val.luts + ((p_width-1)/v_lut_size)/v_lut_size + 1;
        ret_val.luts := ret_val.luts + (p_width-1)/v_lut_size + 1;
        if v_fb_lat > 2 then
          ret_val.ffs := ret_val.ffs + 1 + (((p_width-1)/v_lut_size)/v_lut_size + 1) + ((p_width-1)/v_lut_size + 1);
        end if;
      else
        ret_val.luts := ret_val.luts + 1;  
        ret_val.luts := ret_val.luts + (((p_width-1)/v_lut_size)/v_lut_size)/v_lut_size + 1;
        ret_val.luts := ret_val.luts + ((p_width-1)/v_lut_size)/v_lut_size + 1;
        ret_val.luts := ret_val.luts + (p_width-1)/v_lut_size + 1;
        if v_fb_lat > 2 then
          ret_val.ffs := ret_val.ffs + 1 +
                         ((((p_width-1)/v_lut_size)/v_lut_size)/v_lut_size + 1) +
                         (((p_width-1)/v_lut_size)/v_lut_size + 1) +
                         ((p_width-1)/v_lut_size + 1);
        end if;
      end if;
    end if;

    ---------------------------------------------------------------------------
    -- Threshold logic (uses gate bit too). This is a simplification based on
    -- the idea that the gate bit is implemented using gates only. With less than
    -- optimal latency it can use the carry chain too.
    ---------------------------------------------------------------------------
    if p_has_thresh0 = 1 then
      if p_width <= v_lut_size then
        ret_val.luts := ret_val.luts + 1;  
        if v_fb_lat = 1 then
          ret_val.ffs := ret_val.ffs + 1;
        end if;
      elsif p_width <= v_lut_size*v_lut_size then
        ret_val.luts := ret_val.luts + 1;  
        ret_val.luts := ret_val.luts + (p_width-1)/v_lut_size + 1;
        if v_fb_lat > 1 then
          ret_val.ffs := ret_val.ffs + 1 + ((p_width-1)/v_lut_size + 1);
        end if;
      elsif p_width <= v_lut_size*v_lut_size*v_lut_size then
        ret_val.luts := ret_val.luts + 1;  
        ret_val.luts := ret_val.luts + ((p_width-1)/v_lut_size)/v_lut_size + 1;
        ret_val.luts := ret_val.luts + (p_width-1)/v_lut_size + 1;
        if v_fb_lat > 2 then
          ret_val.ffs := ret_val.ffs + 1 + (((p_width-1)/v_lut_size)/v_lut_size + 1) + ((p_width-1)/v_lut_size + 1);
        end if;
      else
        ret_val.luts := ret_val.luts + 1;  
        ret_val.luts := ret_val.luts + (((p_width-1)/v_lut_size)/v_lut_size)/v_lut_size + 1;
        ret_val.luts := ret_val.luts + ((p_width-1)/v_lut_size)/v_lut_size + 1;
        ret_val.luts := ret_val.luts + (p_width-1)/v_lut_size + 1;
        if v_fb_lat > 2 then
          ret_val.ffs := ret_val.ffs + 1 +
                         ((((p_width-1)/v_lut_size)/v_lut_size)/v_lut_size + 1) +
                         (((p_width-1)/v_lut_size)/v_lut_size + 1) +
                         ((p_width-1)/v_lut_size + 1);
        end if;
      end if;
    end if;

    if p_verbosity >= 2 then
      assert false
        report "Note: xbip_counter_v1_0 DSP48 count = "&integer'image(ret_val.DSP48)
        severity note;
      assert false
        report "Note: xbip_counter_v1_0 BRAM18K count = "&integer'image(ret_val.bram18k)
        severity note;
      assert false
        report "Note: xbip_counter_v1_0 LUT count = "&integer'image(ret_val.luts)
        severity note;
      assert false
        report "Note: xbip_counter_v1_0 FF count = "&integer'image(ret_val.ffs)
        severity note;
    end if;
 
    return ret_val;
  end function fn_xbip_counter_v1_0_get_resources;
  
  function fn_xbip_counter_v1_0_latency(
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_use_dsp48         : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return t_xbip_counter_v1_0_latency is
    variable v_latency_left  : integer;
    variable ret_val : t_xbip_counter_v1_0_latency;
    variable v_lat_req : integer;
  begin
    v_latency_left := p_latency;
    ret_val.used := 0;
      for i in 0 to c_bip_counter_v1_0_max_pipe_stages loop
        ret_val.pipe(i) := 0;
      end loop;  -- i
    if p_use_dsp48 = 0 then
      --fabric
      if p_latency = -1 then
        if has_dsp48(p_xdevicefamily) then
          v_lat_req := (p_width-1)/ci_vx4_cc_limit + 1;
        elsif has_dsp48e(p_xdevicefamily) then
          v_lat_req := (p_width-1)/ci_vx5_cc_limit + 1;
        elsif has_dsp48a(p_xdevicefamily) then
          v_lat_req := (p_width-1)/ci_sp3adsp_cc_limit + 1;
        else
          v_lat_req := (p_width-1)/ci_other_cc_limit + 1;
        end if;
      else
        v_lat_req := p_latency;
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
      if p_restrict_count = 1 and p_has_load = 1 then
        if v_latency_left /= 0 then
          ret_val.pipe(2) := 1;
          v_latency_left := v_latency_left -1;
          ret_val.used := ret_val.used + 1;
        end if;
      end if;
      if v_latency_left > 0  then
        assert false
          report "ERROR: xbip_counter_v1_0: Excessive latency for DSP48-based case."
          severity error;
      end if;
      
    end if;
    return ret_val;
  end function fn_xbip_counter_v1_0_latency;

  
  function fn_xbip_counter_v1_0_get_fb_latency (
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_use_dsp48         : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return t_xbip_counter_v1_0_fb_latency is
    variable ret_val : t_xbip_counter_v1_0_fb_latency;
    variable v_countto_val : std_logic_vector(1 to p_width) := (others => '0');
    variable v_countby_val : std_logic_vector(1 to p_width) := (others => '0');
    variable v_detect_val  : std_logic_vector(1 to p_width) := (others => '0');
    variable v_req_lat     : integer := 0;
    variable v_loop_count  : integer := 0;
    variable v_det_width : integer := 0;
    constant ci_latency_alloc : t_xbip_counter_v1_0_latency := fn_xbip_counter_v1_0_latency(
      p_xdevicefamily     => p_xdevicefamily,
      p_verbosity         => p_verbosity ,
      p_use_dsp48         => p_use_dsp48, 
      p_latency           => p_latency,
      p_fb_latency        => p_fb_latency,
      p_width             => p_width,
      p_restrict_count    => p_restrict_count,
      p_count_to          => p_count_to ,
      p_count_by          => p_count_by ,
      p_count_mode        => p_count_mode ,
      p_thresh0_value     => p_thresh0_value,
      p_ce_overrides_sclr => p_ce_overrides_sclr, 
      p_has_thresh0       => p_has_thresh0,
      p_has_load          => p_has_load,
      p_load_low          => p_load_low
      );
    variable stages_req : integer;
    variable v_latency_left : integer;
  begin
    ret_val.used        := 0;
    ret_val.gate_pipes  := 0;
    ret_val.gate_op     := 0;
    ret_val.gate_excess := 0;

    if p_restrict_count = 0 then
      return ret_val;
    end if;
    
    if has_lut4(p_xdevicefamily) then
      if p_width <= 4 then
        stages_req := 0;
      elsif p_width <= 16 then
        stages_req := 1;
      elsif p_width <= 64 then
        stages_req := 2;
      else
        stages_req := 3;
      end if;
    end if;
    if has_lut6(p_xdevicefamily) then
      if p_width <= 6 then
        stages_req := 0;
      elsif p_width <= 36 then
        stages_req := 1;
      elsif p_width <= 216 then
        stages_req := 2;
      else
        stages_req := 3;
      end if;
    end if;

    v_latency_left := p_fb_latency;
    if v_latency_left /= 0 then
      v_latency_left  := v_latency_left -1;
      ret_val.gate_op := 1;
      ret_val.used    := ret_val.used + 1;
    end if;
    for i in 1 to 4 loop                -- >max number of gate pipestages
      if v_latency_left /= 0 and ret_val.gate_pipes < stages_req then
        v_latency_left     := v_latency_left -1;
        ret_val.gate_pipes := ret_val.gate_pipes + 1;
        ret_val.used       := ret_val.used + 1;
      end if;
    end loop;  -- i
    if v_latency_left > 0 then
      ret_val.used        := ret_val.used + v_latency_left;
      ret_val.gate_excess := v_latency_left;
      v_latency_left      := 0;
    end if;

    return ret_val;
  end fn_xbip_counter_v1_0_get_fb_latency;

  function fn_xbip_counter_v1_0_get_thresh_latency (
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_use_dsp48         : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return t_xbip_counter_v1_0_thresh_latency is
    variable ret_val : t_xbip_counter_v1_0_thresh_latency;
    constant ci_latency_fb_alloc : t_xbip_counter_v1_0_fb_latency := fn_xbip_counter_v1_0_get_fb_latency(
      p_xdevicefamily     => p_xdevicefamily,
      p_verbosity         => p_verbosity ,
      p_use_dsp48         => p_use_dsp48, 
      p_latency           => p_latency,
      p_fb_latency        => p_fb_latency,
      p_width             => p_width,
      p_restrict_count    => p_restrict_count,
      p_count_to          => p_count_to ,
      p_count_by          => p_count_by ,
      p_count_mode        => p_count_mode ,
      p_thresh0_value     => p_thresh0_value,
      p_ce_overrides_sclr => p_ce_overrides_sclr, 
      p_has_thresh0       => p_has_thresh0,
      p_has_load          => p_has_load,
      p_load_low          => p_load_low
      );
    variable det_value      : std_logic_vector(p_width-1 downto 0) := (others => '0');
    variable det_value_zero : std_logic_vector(p_width-1 downto 0) := (others => '0');
    variable v_thresh_slv   : std_logic_vector(p_width-1 downto 0) := str_to_bound_slv_0(p_thresh0_value, p_width);
    variable v_count_by_slv : std_logic_vector(p_width-1 downto 0) := str_to_bound_slv_0(p_count_by, p_width);
  begin
    ret_val.gate_pipes := ci_latency_fb_alloc.gate_pipes;
    ret_val.gate_op    := ci_latency_fb_alloc.gate_op;
--    ret_val.gate_pipes  := 0;
--    ret_val.gate_op     := 1;
--
--    if has_lut4(p_xdevicefamily) then
--      if p_width <= 4 then
--        stages_req := 0;
--      elsif p_width <= 16 then
--        stages_req := 1;
--      elsif p_width <= 64 then
--        stages_req := 2;
--      else
--        stages_req := 3;
--      end if;
--    end if;
--    if has_lut6(p_xdevicefamily) then
--      if p_width <= 6 then
--        stages_req := 0;
--      elsif p_width <= 36 then
--        stages_req := 1;
--      elsif p_width <= 216 then
--        stages_req := 2;
--      else
--        stages_req := 3;
--      end if;
--    end if;
--
--    ret_val.gate_pipes := stages_req;

    --Now check that value versus terminal count etc
    det_value := v_thresh_slv;
    for i in 1 to ret_val.gate_pipes + ret_val.gate_op loop
      if p_count_mode = 0 then        --up
        det_value := det_value - v_count_by_slv;
      else
        det_value := det_value + v_count_by_slv;
      end if;
    end loop;  -- i
    --if det_value has opposite sign to count_by, it will never trigger
    if (det_value(det_value'LEFT) = v_count_by_slv(v_count_by_slv'LEFT)) or (det_value /= det_value_zero) then        --up
      null;                           --no problem.
    else
      if p_verbosity > 0 then
        assert false
          report "WARNING: xbip_counter_v1_0: Threshold detection pipelining results in a value which will never occur."
          severity warning;
      end if;
    end if;
    
    return ret_val;
  end fn_xbip_counter_v1_0_get_thresh_latency;

  
end package body xbip_counter_v1_0_pkg;


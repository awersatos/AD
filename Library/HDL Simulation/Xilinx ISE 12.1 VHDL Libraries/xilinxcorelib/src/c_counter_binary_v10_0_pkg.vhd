-- $ID: $
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
use xilinxcorelib.xbip_counter_v1_0_pkg.all;

package c_counter_binary_v10_0_pkg is

  constant c_counter_binary_v10_0_max_pipe_stages : integer := 32;
  type t_counter_binary_v10_0_pipe is array (0 to c_counter_binary_v10_0_max_pipe_stages) of integer;
  
  type t_c_counter_binary_v10_0_latency is record
    used : integer;
    pipe : t_counter_binary_v10_0_pipe;
  end record;

  type t_c_counter_binary_v10_0_resources is record
    dsp48    : integer;
    bram18k  : integer;
    luts     : integer;
    ffs      : integer;
  end record;
  
  type t_counter_binary_v10_0_field_limits is record
                                           min : integer;
                                           max : integer;
                                         end record;
  
  function fn_counter_binary_v10_0_get_width_limits (
    p_xdevicefamily  : string;
    p_implementation : integer
    )
    return t_counter_binary_v10_0_field_limits;
  
  function fn_counter_binary_v10_0_get_latency_limits (
    p_xdevicefamily  : string;
    p_implementation : integer;
    p_latency        : integer;
    p_fast_op        : integer;
    p_fast_ip        : integer
    )
    return t_counter_binary_v10_0_field_limits;
  
  function fn_counter_binary_v10_0_check_generics (
    p_implementation      : integer := 0;
    p_verbosity           : integer := 0;
    p_xdevicefamily       : string  := "virtex2";
    p_width               : integer := 16;
    p_has_ce              : integer := 0;
    p_has_sclr            : integer := 0;
    p_restrict_count      : integer := 0;
    p_count_to            : string  := "0";
    p_count_by            : string  := "0";
    p_count_mode          : integer := 0;  -- 0=up, 1=down, 2=updown
    p_thresh0_value       : string  := "0";
    p_ce_overrides_sync   : integer := 0;  -- 0=override;
    p_has_thresh0         : integer := 0;
    p_has_load            : integer := 0;
    p_load_low            : integer := 0;
    p_latency             : integer := 0;
    p_fb_latency          : integer := 0;
    p_ainit_val           : string  := "0";
    p_sinit_val           : string  := "0";
    p_sclr_overrides_sset : integer := 1;  -- 0=set, 1=clear;
    p_has_sset            : integer := 0;
    p_has_sinit           : integer := 0
    ) return integer;

  function fn_c_counter_binary_v10_0_latency(
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_implementation    : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sync : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return t_c_counter_binary_v10_0_latency;
  
  function fn_c_counter_binary_v10_0_fb_latency (
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_implementation    : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sync : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return t_c_counter_binary_v10_0_latency;

  function fn_c_counter_binary_v10_0_resources(
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_implementation    : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sync : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return t_c_counter_binary_v10_0_resources;

  function fn_c_counter_binary_v10_0_use_baseblox (
    p_implementation : integer;
    p_latency        : integer;
    p_fb_latency     : integer;
    p_width          : integer)
    return boolean;
    
  component c_counter_binary_v10_0_legacy
    generic (
      c_family         : string  := "no_family";
      c_width          : integer := 16;
      c_restrict_count : integer := 0;
      c_count_to       : string  := "0";
      c_count_by       : string  := "1";
      c_count_mode     : integer := 0;  --c_up;
      c_thresh0_value  : string  := "0";
      c_thresh1_value  : string  := "0";
      c_thresh_early   : integer := 0;
      c_ainit_val      : string  := "0";
      c_sinit_val      : string  := "0";
      c_load_enable    : integer := 0;  --c_override;
      c_sync_enable    : integer := 0;  --c_override;
      c_sync_priority  : integer := 1;  --c_clear;
      c_pipe_stages    : integer := 0;
      c_has_thresh0    : integer := 0;
      c_has_q_thresh0  : integer := 0;
      c_has_thresh1    : integer := 0;
      c_has_q_thresh1  : integer := 0;
      c_has_ce         : integer := 0;
      c_has_up         : integer := 0;
      c_has_iv         : integer := 0;
      c_has_l          : integer := 0;
      c_has_load       : integer := 0;
      c_load_low       : integer := 0;
      c_has_aclr       : integer := 0;
      c_has_aset       : integer := 0;
      c_has_ainit      : integer := 0;
      c_has_sclr       : integer := 0;
      c_has_sset       : integer := 0;
      c_has_sinit      : integer := 0;
      c_enable_rlocs   : integer := 0
      );
    port (
      clk       : in  std_logic                            := '0';  -- Optional clock
      up        : in  std_logic                            := '1';  -- Controls direction of count - '1' = up.
      ce        : in  std_logic                            := '1';  -- Optional Clock enable
      load      : in  std_logic                            := '0';  -- Optional Synch load trigger
      l         : in  std_logic_vector(c_width-1 downto 0) := (others => '0');  -- Optional Synch load value
      iv        : in  std_logic_vector(c_width-1 downto 0) := (others => '0');  -- Optional Increment value
      aclr      : in  std_logic                            := '0';  -- Asynch init.
      aset      : in  std_logic                            := '0';  -- optional asynch set to '1'
      ainit     : in  std_logic                            := '0';  -- optional asynch reset to init_val
      sclr      : in  std_logic                            := '0';  -- Synch init.
      sset      : in  std_logic                            := '0';  -- optional synch set to '1'
      sinit     : in  std_logic                            := '0';  -- Optional synch reset to init_val
      thresh0   : out std_logic                            := '1';
      q_thresh0 : out std_logic                            := '1';
      thresh1   : out std_logic                            := '1';
      q_thresh1 : out std_logic                            := '1';
      q         : out std_logic_vector(c_width-1 downto 0)  -- Output value
      );

  end component;
  

end package c_counter_binary_v10_0_pkg;

package body c_counter_binary_v10_0_pkg is

  function fn_counter_binary_v10_0_get_width_limits (
    p_xdevicefamily  : string;
    p_implementation : integer
    )
    return t_counter_binary_v10_0_field_limits is
    variable ret_val : t_counter_binary_v10_0_field_limits;
  begin
    if p_implementation = 0 then
      ret_val.max := 256;
      ret_val.min := 1;
    else
      if has_dsp48(p_xdevicefamily) then
        ret_val.max := 35;
        ret_val.min := 1;
      else
        ret_val.max := 48;
        ret_val.min := 1;
      end if;
    end if;
    return ret_val;
  end fn_counter_binary_v10_0_get_width_limits;
  
  function fn_counter_binary_v10_0_get_latency_limits (
    p_xdevicefamily  : string;
    p_implementation : integer;
    p_latency        : integer;
    p_fast_op        : integer;
    p_fast_ip        : integer
    )
    return t_counter_binary_v10_0_field_limits is
    variable ret_val : t_counter_binary_v10_0_field_limits;
  begin
    return ret_val;
  end fn_counter_binary_v10_0_get_latency_limits;

  function fn_counter_binary_v10_0_check_generics (
    p_implementation      : integer := 0;
    p_verbosity           : integer := 0;
    p_xdevicefamily       : string  := "virtex2";
    p_width               : integer := 16;
    p_has_ce              : integer := 0;
    p_has_sclr            : integer := 0;
    p_restrict_count      : integer := 0;
    p_count_to            : string  := "0";
    p_count_by            : string  := "0";
    p_count_mode          : integer := 0;  -- 0=up, 1=down, 2=updown
    p_thresh0_value       : string  := "0";
    p_ce_overrides_sync   : integer := 0;  -- 0=override;
    p_has_thresh0         : integer := 0;
    p_has_load            : integer := 0;
    p_load_low            : integer := 0;
    p_latency             : integer := 0;
    p_fb_latency          : integer := 0;
    p_ainit_val           : string  := "0";
    p_sinit_val           : string  := "0";
    p_sclr_overrides_sset : integer := 1;  -- 0=set, 1=clear;
    p_has_sset            : integer := 0;
    p_has_sinit           : integer := 0
    ) return integer is
  variable v_dsp48_check_gens    : integer := 0;
  variable v_baseblox_check_gens : integer := 0;
  variable v_depth_limits        : t_counter_binary_v10_0_field_limits;
  variable v_width_limits        : t_counter_binary_v10_0_field_limits;
  constant ci_family             : string := c_xdevicefamily_to_c_family(p_xdevicefamily);
  
  begin
    ---------------------------------------------------------------------------
    -- Common Checks
    ---------------------------------------------------------------------------
    --C_HAS_CE
    if p_has_ce < 0 or p_has_ce >1 then
      assert false
        report "ERROR: c_counter_binary_v10_0: C_HAS_CE must be 0 or 1"
        severity error;
      return 1;
    end if;

    --C_CE_OVERRIDES_SYNC
    if p_ce_overrides_sync < 0 or p_ce_overrides_sync >1 then
      assert false
        report "ERROR: c_counter_binary_v10_0: C_CE_OVERRIDES_SYNC must be 0 or 1"
        severity error;
      return 1;
    end if;
    
    --C_HAS_SCLR
    if p_has_sclr < 0 or p_has_sclr >1 then
      assert false
        report "ERROR: c_counter_binary_v10_0: C_HAS_SCLR must be 0 or 1"
        severity error;
      return 1;
    end if;

    --C_WIDTH
    v_width_limits := fn_counter_binary_v10_0_get_width_limits(
      p_xdevicefamily  => p_xdevicefamily,
      p_implementation => p_implementation
      );
    if p_width < v_width_limits.min or p_width > v_width_limits.max then
      assert false
        report "ERROR: c_counter_binary_v10_0: width out of limits. Width = "&integer'image(p_width)
        severity error;
      return 1;
    end if;

    ---------------------------------------------------------------------------
    -- DSP48 checks
    ---------------------------------------------------------------------------
    if p_implementation = 1 then

      --C_XDEVICEFAMILY
       if not(has_dsp48(p_xdevicefamily)or has_DSP48e(p_xdevicefamily) or has_dsp48a(p_xdevicefamily)) then
         assert false
           report "ERROR: c_counter_binary_v10_0: Chosen family is not supported for C_IMPLEMENTATION = 1"
           severity error;
         return 1;
       end if;

    end if;

    if p_implementation = 1 or p_latency /= 1 or p_fb_latency /= 0 then
      
       --C_WIDTH
       --Checked by xbip_counter_v1_0

       --C_HAS_SSET
       if p_has_sset /= 0 then
         assert false
           report "ERROR: c_counter_binary_v10_0: C_HAS_SSET = 1 is not supported for C_IMPLEMENTATION = 1 or C_LATENCY /=0 or C_FB_LATENCY /= 0"
           severity error;
         return 1;
       end if;
      
       --C_HAS_SINIT
       if p_has_sinit /= 0 then
         assert false
           report "ERROR: c_counter_binary_v10_0: C_HAS_SINIT = 1 is not supported for C_IMPLEMENTATION = 1 or C_LATENCY /=0 or C_FB_LATENCY /= 0"
           severity error;
         return 1;
       end if;

    else
      --   Let v9.1 handle it's own problems. The GUI will be inherited, so should
      --   already have equivalent checks.
      null;
    end if;
    return 0;
  end function fn_counter_binary_v10_0_check_generics;


  function fn_c_counter_binary_v10_0_latency(
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_implementation    : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sync : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return t_c_counter_binary_v10_0_latency is
    variable ret_val : t_c_counter_binary_v10_0_latency;
    variable xbip_counter_lat : t_xbip_counter_v1_0_latency;
  begin
    if p_latency = -1 then
      xbip_counter_lat := fn_xbip_counter_v1_0_latency(
        p_xdevicefamily     => p_xdevicefamily    ,
        p_verbosity         => p_verbosity        ,
        p_use_dsp48         => p_implementation   ,
        p_latency           => p_latency          ,
        p_fb_latency        => p_fb_latency       ,
        p_width             => p_width            ,
        p_restrict_count    => p_restrict_count   ,
        p_count_to          => p_count_to         ,
        p_count_by          => p_count_by         ,
        p_count_mode        => p_count_mode       ,
        p_thresh0_value     => p_thresh0_value    ,
        p_ce_overrides_sclr => p_ce_overrides_sync,
        p_has_thresh0       => p_has_thresh0      ,
        p_has_load          => p_has_load         ,
        p_load_low          => p_load_low         
        );
      ret_val.used := xbip_counter_lat.used;
    else
      ret_val.used := p_latency;
    end if;
    return ret_val;
    
  end function fn_c_counter_binary_v10_0_latency;
  
  function fn_c_counter_binary_v10_0_fb_latency (
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_implementation    : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sync : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return t_c_counter_binary_v10_0_latency is
    variable ret_val : t_c_counter_binary_v10_0_latency;
    variable xbip_counter_fb_lat : t_xbip_counter_v1_0_fb_latency;
  begin
    if p_fb_latency = -1 then
      xbip_counter_fb_lat := fn_xbip_counter_v1_0_get_fb_latency(
        p_width             => p_width,
        p_xdevicefamily     => p_xdevicefamily,
        p_fb_latency        => p_fb_latency,
        p_verbosity         => p_verbosity,
        p_use_dsp48         => p_implementation,
        p_latency           => p_latency,
        p_restrict_count    => p_restrict_count,
        p_count_to          => p_count_to,
        p_count_by          => p_count_by,
        p_count_mode        => p_count_mode,
        p_thresh0_value     => p_thresh0_value,
        p_ce_overrides_sclr => p_ce_overrides_sync,
        p_has_thresh0       => p_has_thresh0,
        p_has_load          => p_has_load,
        p_load_low          => p_load_low
        );
      ret_val.used := xbip_counter_fb_lat.used;
    else
      ret_val.used := p_fb_latency;
    end if;
    return ret_val;
    
  end function fn_c_counter_binary_v10_0_fb_latency;

  function fn_c_counter_binary_v10_0_resources(
    p_xdevicefamily     : string;
    p_verbosity         : integer;
    p_implementation    : integer;
    p_latency           : integer;
    p_fb_latency        : integer;
    p_width             : integer;
    p_restrict_count    : integer;
    p_count_to          : string;
    p_count_by          : string;
    p_count_mode        : integer;      -- 0=up, 1=down, 2=updown
    p_thresh0_value     : string;
    p_ce_overrides_sync : integer;      -- 0=override;
    p_has_thresh0       : integer;
    p_has_load          : integer;
    p_load_low          : integer
    )
    return t_c_counter_binary_v10_0_resources is
    variable ret_val : t_c_counter_binary_v10_0_resources;
    variable xbip_counter_resources : t_xbip_counter_v1_0_resources;
  begin
    if p_implementation = 0 and p_latency = 1 and p_fb_latency = 0 then
      --legacy - very rough estimates!
      ret_val.dsp48   := 0;
      ret_val.bram18k := 0;
      ret_val.luts    := p_width + (p_width * (p_restrict_count + p_has_thresh0)/4);
      ret_val.ffs     := p_width + p_has_thresh0;
    else
      xbip_counter_resources := fn_xbip_counter_v1_0_get_resources(
        p_xdevicefamily     => p_xdevicefamily,
        p_verbosity         => p_verbosity,
        p_use_dsp48         => p_implementation,
        p_latency           => p_latency,
        p_fb_latency        => p_fb_latency,
        p_width             => p_width,
        p_restrict_count    => p_restrict_count,
        p_count_to          => p_count_to,
        p_count_by          => p_count_by,
        p_count_mode        => p_count_mode,
        p_thresh0_value     => p_thresh0_value,
        p_ce_overrides_sclr => p_ce_overrides_sync,
        p_has_thresh0       => p_has_thresh0,
        p_has_load          => p_has_load,
        p_load_low          => p_load_low
        );
      ret_val.dsp48   := xbip_counter_resources.dsp48;
      ret_val.bram18k := xbip_counter_resources.bram18k;
      ret_val.luts    := xbip_counter_resources.luts;
      ret_val.ffs     := xbip_counter_resources.ffs;
    end if;
    return ret_val;
  end function fn_c_counter_binary_v10_0_resources;

  function fn_c_counter_binary_v10_0_use_baseblox (
    p_implementation : integer;
    p_latency        : integer;
    p_fb_latency     : integer;
    p_width          : integer)
    return boolean is
  begin
    if (p_implementation = 0 and p_latency = 1 and p_fb_latency = 0 and p_width > 1) then
      return true;
    end if;
    return false;
  end function fn_c_counter_binary_v10_0_use_baseblox;
    

  
end package body c_counter_binary_v10_0_pkg;
  

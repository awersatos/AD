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
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all;

--library xilinxcorelib;
--use xilinxcorelib.mult_gen_pkg.all;

--library xilinxcorelib;
--use xilinxcorelib.floating_point_pkg_v3_1.all;
--use xilinxcorelib.floating_point_consts_v3_1.all;

library xilinxcorelib;
use xilinxcorelib.hrdiv_hdl_pkg_v1_0.all;

-------------------------------------------------------------------------------
-- Designer note!!
-- This file is for the top level component declaration and any types and functions
-- which calling cores may require. Internal functions, types and component declarations
-- should be in the hrdiv_hdl_pkg_v1_0 file.
-------------------------------------------------------------------------------

package hrdiv_pkg_v1_0 is

  --core_if on component xbip_hrdiv
  component xbip_hrdiv
    GENERIC (
      C_VERBOSITY         : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE        : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY     : string  := "virtex4";
      C_LATENCY           : integer := 1;
      C_HAS_SCLR          : integer := 0;
      C_HAS_CE            : integer := 0;
      C_CE_OVERRIDES_SCLR : integer := 0;
      C_FORMAT            : integer := 0;
      C_NUMER_WIDTH       : integer := 16;
      C_DENOM_WIDTH       : integer := 16;
      C_FRACT_WIDTH       : integer := 0;
      C_HAS_DIV_BY_ZERO   : integer := 0
      );
    PORT (
      CLK            : in  std_logic                                  := '1';
      CE             : in  std_logic                                  := '1';
      SCLR           : in  std_logic                                  := '0';
      ND             : in  std_logic                                  := '0';
      RFD            : out std_logic                                  := '0';
      RDY            : out std_logic                                  := '0';
      NUMER          : in  std_logic_vector(C_NUMER_WIDTH-1 downto 0) := (others => '0');
      DENOM          : in  std_logic_vector(C_DENOM_WIDTH-1 downto 0) := (others => '0');
      QUOT           : out std_logic_vector(C_NUMER_WIDTH-1 downto 0) := (others => '0');
      FRACT          : out std_logic_vector(C_FRACT_WIDTH-1 downto 0) := (others => '0');
      DIVIDE_BY_ZERO : out std_logic                                  := '0'
      );
    
  --core_if off
  end component;
  
  constant ci_max_latency    : integer := 10;
  type t_hrdiv_pipe is array (0 to ci_max_latency) of integer;
  type t_hrdiv_latency is record
    used           : integer;
    numer          : integer;
    prenumer       : integer;
    shift          : integer;
    prenorm        : integer;
    iter_first     : integer;
    nd_bypass      : integer;
    denom          : integer;
    fixed_to_float : integer;
    estimator      : integer;
    est_bal        : integer;
    prescaler      : integer;
    iter_last      : integer;
    quot_coll      : integer;
    min_latency    : integer;
  end record;
  
  function fn_hrdiv_check_generics (
    P_VERBOSITY         : integer;  --0 = Errors only, 1 = +Warnings, 2 = +Notes and tips
    P_MODEL_TYPE        : integer;  --0 = synth, 1 = RTL
    P_XDEVICEFAMILY     : string ;
    P_LATENCY           : integer;
    P_HAS_SCLR          : integer;
    P_HAS_CE            : integer;
    P_CE_OVERRIDES_SCLR : integer;
    P_FORMAT            : integer;       
    P_NUMER_WIDTH       : integer;       
    P_DENOM_WIDTH       : integer;       
    P_FRACT_WIDTH       : integer;
    P_HAS_DIV_BY_ZERO   : integer
    )
  return integer;

  constant ci_max_num_prescale_stages : integer := 4;  -- for 64 bits
  type t_prescale_lat_array is array (0 to ci_max_num_prescale_stages) of integer;
  type t_prescale_lat_all is record
                      a   : t_prescale_lat_array;
                      hp  : t_prescale_lat_array;
                      p   : t_prescale_lat_array;
                      sub : t_prescale_lat_array;
                      add : t_prescale_lat_array;
                      used : integer;
                    end record;

  function fn_num_prescale_stages (
    p_denom_width : integer)
    return integer;

  --Allocate prescaler latency
  function fn_prescaler_alloc (
    p_xdevicefamily : string;
    p_latency       : integer;
    p_denom_width   : integer;
    p_num_stages    : integer)
    return t_prescale_lat_all;
  
  function fn_local_fix2fltdelay (
    p_width : integer)
    return integer;
  
  function fn_hrdiv_latency (
    P_VERBOSITY     : integer;
    P_LATENCY       : integer;
    P_XDEVICEFAMILY : string;
    P_FORMAT        : integer;
    P_NUMER_WIDTH   : integer;
    P_DENOM_WIDTH   : integer;
    P_FRACT_WIDTH   : integer
    )
    return t_hrdiv_latency;

end package hrdiv_pkg_v1_0;

package body hrdiv_pkg_v1_0 is

  -- purpose: finds max of two inputs
  function fn_hrdiv_check_generics (
    P_VERBOSITY         : integer;  --0 = Errors only, 1 = +Warnings, 2 = +Notes and tips
    P_MODEL_TYPE        : integer;  --0 = synth, 1 = RTL
    P_XDEVICEFAMILY     : string ;
    P_LATENCY           : integer;
    P_HAS_SCLR          : integer;
    P_HAS_CE            : integer;
    P_CE_OVERRIDES_SCLR : integer;
    P_FORMAT            : integer;       
    P_NUMER_WIDTH       : integer;       
    P_DENOM_WIDTH       : integer;       
    P_FRACT_WIDTH       : integer;
    P_HAS_DIV_BY_ZERO   : integer
    )
  return integer is
    constant ci_result_width        : integer := fn_get_result_width(P_NUMER_WIDTH,P_FRACT_WIDTH,ci_guard_width);
    constant ci_num_iterations      : integer := fn_get_num_iterations(ci_result_width,ci_splice_width,ci_overlap);
    constant ci_min_hrdiv_latency   : integer := (ci_num_iterations +1);
    constant ci_max_hrdiv_latency : integer := fn_hrdiv_latency(
      P_VERBOSITY     => P_VERBOSITY,
      P_LATENCY       => -1,
      P_XDEVICEFAMILY => P_XDEVICEFAMILY,
      P_FORMAT        => P_FORMAT,
      P_NUMER_WIDTH   => P_NUMER_WIDTH,
      P_DENOM_WIDTH   => P_DENOM_WIDTH,
      P_FRACT_WIDTH   => P_FRACT_WIDTH
      ).used;
  begin
    ---------------------------------------------------------------------------
    -- Unstoppable checks first!
    ---------------------------------------------------------------------------
    --P_MODEL_TYPE
    assert P_MODEL_TYPE = 0 or P_MODEL_TYPE = 1 or P_MODEL_TYPE = 2
      report "ERROR: xilinxcorelib: C_MODEL_TYPE must be 0,1 or 2"
      severity ERROR;

    --P_XDEVICEFAMILY
    assert has_dsp48(P_XDEVICEFAMILY) or has_dsp48a(P_XDEVICEFAMILY) or has_dsp48e(P_XDEVICEFAMILY) 
      report "ERROR: xilinxcorelib: This algorithm only supports Virtex4, Virtex5 and Spartan3adsp"
      severity error;
    
    --P_LATENCY
    assert P_LATENCY = -1 or (P_LATENCY >= ci_min_hrdiv_latency AND P_LATENCY <= ci_max_hrdiv_latency)
      report "ERROR: xilinxcorelib: C_LATENCY must be -1 or in the range "&INTEGER'IMAGE(ci_min_hrdiv_latency)&" to "&INTEGER'IMAGE(ci_max_hrdiv_latency)
      severity ERROR;
    
    --P_FORMAT
    assert P_FORMAT = ci_fixed_operands or P_FORMAT = ci_float_operands
      report "ERROR: xilinxcorelib: C_FORMAT must be 0 or 1"
      severity ERROR;
    
    assert P_FORMAT = ci_fixed_operands
      report "ERROR: xilinxcorelib: C_FORMAT must be 0. Sorry Richard, float is not yet supported."
      severity ERROR;
    
    --P_NUMER_WIDTH
    assert P_NUMER_WIDTH > 1 and P_NUMER_WIDTH <= 54
      report "ERROR: xilinxcorelib: C_NUMER_WIDTH must be in the range 2 to 54"
      severity ERROR;
    
    --P_DENOM_WIDTH
    assert P_DENOM_WIDTH > 1 and P_DENOM_WIDTH <= 54
      report "ERROR: xilinxcorelib: C_DENOM_WIDTH must be in the range 2 to 54"
      severity ERROR;
    
    --P_FRACT_WIDTH
    assert P_FRACT_WIDTH >= 0 and P_FRACT_WIDTH <= 54
      report "ERROR: xilinxcorelib: C_FRACT_WIDTH must be in the range 0 to 54"
      severity ERROR;

    --P_NUMER_WIDTH + P_FRACT_WIDTH
    assert P_NUMER_WIDTH + P_FRACT_WIDTH <= fn_op_width_limit(P_XDEVICEFAMILY) 
      report "ERROR: xilinxcorelib: C_NUMER_WIDTH + C_FRACT_WIDTH must be in the range 0 to "&INTEGER'IMAGE(fn_op_width_limit(P_XDEVICEFAMILY))
      severity ERROR;

    --P_HAS_DIV_BY_ZERO
    assert P_HAS_DIV_BY_ZERO = 0 or P_HAS_DIV_BY_ZERO = 1
      report "ERROR: xilinxcorelib: C_CE_OVERRIDES_SCLR must be 0 or 1"
      severity error;
    
     --P_CE_OVERRIDES_SCLR
    assert P_CE_OVERRIDES_SCLR = 0 or P_CE_OVERRIDES_SCLR = 1
      report "ERROR: xilinxcorelib: C_CE_OVERRIDES_SCLR must be 0 or 1"
      severity error;
    
   --P_HAS_SCLR
    assert P_HAS_SCLR = 0 or P_HAS_SCLR = 1
      report "ERROR: xilinxcorelib: C_HAS_SCLR must be 0 or 1"
      severity error;
    
    --P_HAS_CE
    assert P_HAS_CE = 0 or P_HAS_CE = 1
      report "ERROR: xilinxcorelib: C_HAS_CE must be 0 or 1"
      severity error;

    
    ---------------------------------------------------------------------------
    -- Warnings
    ---------------------------------------------------------------------------
    if P_VERBOSITY >= 1 then
      assert false report "xilinxcorelib_warnings start here" severity note;
      assert false report "xilinxcorelib_warnings end here" severity note;
    end if;
    ---------------------------------------------------------------------------
    -- Notes and Tips
    ---------------------------------------------------------------------------
    if P_VERBOSITY >= 2 then
      assert false report "xilinxcorelib notes start here" severity note;
      assert false report "xilinxcorelib notes end here" severity note;
    end if;
    return 0;                           --stops modelsim moaning about return values
  end;

  
  function fn_num_prescale_stages (
    p_denom_width : integer)
    return integer is
  begin  -- fn_num_stages
    return (p_denom_width-2) / (ci_dsp48_b_width-1)+1;  -- it just is!
  end fn_num_prescale_stages;

  --Allocate prescaler latency
  function fn_prescaler_alloc (
    p_xdevicefamily : string;
    p_latency       : integer;
    p_denom_width   : integer;
    p_num_stages    : integer)
    return t_prescale_lat_all is
    variable ret_val : t_prescale_lat_all;
    variable v_latency_left : integer;
    variable v_max_poss : integer;
  begin  -- fn_prescaler_alloc
    for i in 0 to ci_max_num_prescale_stages loop
      ret_val.a(i)  := 0;
      ret_val.hp(i) := 16;              --hand placed latency
      ret_val.p(i)  := 0;
      ret_val.sub(i):= 0;
    end loop;  -- i
    ret_val.add(1) := 0;
    ret_val.add(2) := 0;
    ret_val.used := 0;

    v_latency_left := p_latency;
    v_max_poss := p_num_stages + 2;

    --output registers first, if divisor > 48 bits
    if p_denom_width > 48 then
      if v_latency_left /= 0 then
        ret_val.add(2)  := ret_val.add(2)+1;
        ret_val.p(1)   := ret_val.p(1)+1;
        ret_val.p(0)   := ret_val.p(0)+1;
        v_latency_left := v_latency_left - 1;
        ret_val.used   := ret_val.used +1;
      end if;
    end if;

    if has_dsp48a(p_xdevicefamily) then

      --1
      if p_num_stages > 3 then
        if v_latency_left /= 0 then
          ret_val.hp(3)  := ret_val.hp(3)+8;
          ret_val.p(2)   := ret_val.p(2)+1;
          ret_val.p(1)   := ret_val.p(1)+1;
          ret_val.p(0)   := ret_val.p(0)+1;
          v_latency_left := v_latency_left - 1;
          ret_val.used   := ret_val.used +1;
        end if;
      end if;
      --2
      if p_num_stages > 2 then
        if v_latency_left /= 0 then
          ret_val.hp(3)  := ret_val.hp(3)+2;
          ret_val.hp(2)  := ret_val.hp(2)+8;
          ret_val.p(1)   := ret_val.p(1)+1;
          ret_val.p(0)   := ret_val.p(0)+1;
          ret_val.sub(3) := ret_val.sub(3)+1;
          v_latency_left := v_latency_left - 1;
          ret_val.used   := ret_val.used +1;
        end if;
      end if;
      --3
      if p_num_stages > 1 then
        if v_latency_left /= 0 then
          ret_val.a(3)   := ret_val.a(3)+1;
          ret_val.hp(2)  := ret_val.hp(2)+2;
          ret_val.hp(1)  := ret_val.hp(1)+8;
          ret_val.p(0)   := ret_val.p(0)+1;
          ret_val.sub(2) := ret_val.sub(2)+1;
          v_latency_left := v_latency_left - 1;
          ret_val.used   := ret_val.used +1;
        end if;
      end if;
      --4
      if p_num_stages > 0 then          --obviously there's >0, but this keeps
                                        --the code symmetry
        if v_latency_left /= 0 then
          ret_val.a(3)   := ret_val.a(3)+1;
          ret_val.a(2)   := ret_val.a(2)+1;
          ret_val.hp(1)  := ret_val.hp(1)+2;
          ret_val.hp(0)  := ret_val.hp(0)+8;
          ret_val.sub(1) := ret_val.sub(1)+1;
          v_latency_left := v_latency_left - 1;
          ret_val.used   := ret_val.used +1;
        end if;
      end if;
      --5
      if p_num_stages > 0 then          --obviously there's >0, but this keeps
                                        --the code symmetry
        if v_latency_left /= 0 then
          ret_val.a(3)   := ret_val.a(3)+1;
          ret_val.a(2)   := ret_val.a(2)+1;
          ret_val.a(1)   := ret_val.a(1)+1;
          ret_val.hp(0)  := ret_val.hp(0)+2;
          ret_val.sub(0) := ret_val.sub(0)+1;
          v_latency_left := v_latency_left - 1;
          ret_val.used   := ret_val.used +1;
        end if;
      end if;
      --6
      if p_num_stages > 0 then          --obviously there's >0, but this keeps
                                        --the code symmetry
        if v_latency_left /= 0 then
          ret_val.a(3)   := ret_val.a(3)+1;
          ret_val.a(2)   := ret_val.a(2)+1;
          ret_val.hp(1)  := ret_val.hp(1)+1;
          ret_val.hp(0)  := ret_val.hp(0)+4;
          ret_val.sub(1) := ret_val.sub(1)+1;
          v_latency_left := v_latency_left - 1;
          ret_val.used   := ret_val.used +1;
        end if;
      end if;
      --7
      if p_num_stages > 1 then          --obviously there's >0, but this keeps
                                        --the code symmetry
        if v_latency_left /= 0 then
          ret_val.a(3)   := ret_val.a(3)+1;
          ret_val.hp(2)  := ret_val.hp(2)+1;
          ret_val.hp(1)  := ret_val.hp(1)+4;
          ret_val.p(0)   := ret_val.p(0)+1;
          ret_val.sub(2) := ret_val.sub(2)+1;
          v_latency_left := v_latency_left - 1;
          ret_val.used   := ret_val.used +1;
        end if;
      end if;
      
      --8
      if p_num_stages > 2 then          --obviously there's >0, but this keeps
                                        --the code symmetry
        if v_latency_left /= 0 then
          ret_val.hp(3)  := ret_val.hp(3)+1;
          ret_val.hp(2)  := ret_val.hp(2)+4;
          ret_val.p(1)   := ret_val.p(1)+1;
          ret_val.p(0)   := ret_val.p(0)+1;
          ret_val.sub(3) := ret_val.sub(3)+1;
          v_latency_left := v_latency_left - 1;
          ret_val.used   := ret_val.used +1;
        end if;
      end if;
      
      --9
      if p_num_stages > 3 then          --obviously there's >0, but this keeps
                                        --the code symmetry
        if v_latency_left /= 0 then
          ret_val.hp(3)  := ret_val.hp(3)+4;
          ret_val.p(2)   := ret_val.p(2)+1;
          ret_val.p(1)   := ret_val.p(1)+1;
          ret_val.p(0)   := ret_val.p(0)+1;
          v_latency_left := v_latency_left - 1;
          ret_val.used   := ret_val.used +1;
        end if;
      end if;

    else                                --virtex4, virtex5, and fabric
      
      --preg of top stage
      --1
      if p_num_stages > 3 then
        if v_latency_left /= 0 then
          ret_val.hp(3)  := ret_val.hp(3)+8;
          ret_val.p(2)   := ret_val.p(2)+1;
          ret_val.p(1)   := ret_val.p(1)+1;
          ret_val.p(0)   := ret_val.p(0)+1;
          v_latency_left := v_latency_left - 1;
          ret_val.used   := ret_val.used +1;
        end if;
      end if;

      --preg of lowest stage
      --2
      if v_latency_left /= 0 then
        ret_val.hp(3)  := ret_val.hp(3)+1;
        ret_val.hp(2)  := ret_val.hp(2)+2;
        ret_val.hp(1)  := ret_val.hp(1)+4;
        ret_val.hp(0)  := ret_val.hp(0)+8;
        ret_val.sub(2) := ret_val.sub(2)+1;
        v_latency_left := v_latency_left - 1;
        ret_val.used   := ret_val.used +1;
      end if;

      --areg of lowest stage
      --3
      if v_latency_left /= 0 then
        ret_val.a(3)   := ret_val.a(3)+1;
        ret_val.a(2)   := ret_val.a(2)+1;
        ret_val.hp(1)  := ret_val.hp(1)+1;
        ret_val.hp(0)  := ret_val.hp(0)+2;
        ret_val.sub(0) := ret_val.sub(0)+1;
        v_latency_left := v_latency_left - 1;
        ret_val.used   := ret_val.used +1;
      end if;

      --m of top stage
      --4
      if p_num_stages >= 3 then
        if v_latency_left /= 0 then
          ret_val.hp(3)  := ret_val.hp(3)+4;
          ret_val.hp(2)  := ret_val.hp(2)+8;
          ret_val.p(1)   := ret_val.p(1)+1;
          ret_val.p(0)   := ret_val.p(0)+1;
          v_latency_left := v_latency_left - 1;
          ret_val.used   := ret_val.used +1;
        end if;
      end if;

      --a1 of top stage
      --5
      if p_num_stages >= 2 then
        if v_latency_left /= 0 then
          ret_val.hp(3)  := ret_val.hp(3)+2;
          ret_val.hp(2)  := ret_val.hp(2)+4;
          ret_val.hp(1)  := ret_val.hp(1)+8;
          ret_val.p(0)   := ret_val.p(0)+1;
          ret_val.sub(3) := ret_val.sub(3)+1;
          v_latency_left := v_latency_left - 1;
          ret_val.used   := ret_val.used +1;
        end if;
      end if;

      --mreg of lowest stage
      --6
      if v_latency_left /= 0 then
        ret_val.a(3)   := ret_val.a(3)+1;
        ret_val.hp(2)  := ret_val.hp(2)+1;
        ret_val.hp(1)  := ret_val.hp(1)+2;
        ret_val.hp(0)  := ret_val.hp(0)+4;
        ret_val.sub(1) := ret_val.sub(1)+1;
        v_latency_left := v_latency_left - 1;
        ret_val.used   := ret_val.used +1;
      end if;

    end if;

    --second register in addsub for partial product.
    if p_denom_width > 48 then
      if v_latency_left /= 0 then
        ret_val.add(1)  := ret_val.add(1)+1;
        ret_val.p(1)   := ret_val.p(1)+1;
        ret_val.p(0)   := ret_val.p(0)+1;
        v_latency_left := v_latency_left - 1;
        ret_val.used   := ret_val.used +1;
      end if;
    end if;

    if v_latency_left > 0 then
      assert false
        report "ERROR: excessive latency for prescaler"
        severity error;
    end if;
    return ret_val;
  end fn_prescaler_alloc;

  function fn_local_fix2fltdelay (
    p_width : integer)
    return integer is
  begin  -- fn
    if p_width <= 8 then
      return 5;
    elsif p_width <= 32 then
      return 6;
    end if;
    return 7;
  end fn_local_fix2fltdelay;
  -----------------------------------------------------------------------------
  -- Latency allocation. Not easy!
  -- Latency is allocated to one of three regions: preprocessing, iteration
  -- and postprocessing. Once allocated to a region, a second phase allocates
  -- latency more specifically.
  -----------------------------------------------------------------------------
  function fn_hrdiv_latency (
    P_VERBOSITY     : integer;
    P_LATENCY       : integer;
    P_XDEVICEFAMILY : string;
    P_FORMAT        : integer;
    P_NUMER_WIDTH   : integer;
    P_DENOM_WIDTH   : integer;
    P_FRACT_WIDTH   : integer
    )
    return t_hrdiv_latency is
    constant ci_extra_bits : integer := log2roundup(P_DENOM_WIDTH)+1;  --1 for the sign, X for the exponent

    constant ci_fulldenom_width     : integer := fn_fulldenom_width(
      p_format      => P_FORMAT,
      p_denom_width => P_DENOM_WIDTH);
    
    constant ci_scaledenom_width    : integer := ci_fulldenom_width + ci_dsp48_b_width;  -- includes "01" head
    
    constant ci_splices_required    : integer := fn_get_splices_required(
      p_scaledenom_width => ci_scaledenom_width,
      p_splice_width     => ci_splice_width);

    constant ci_normnumer_width : integer := fn_normnumer_width(
      p_format      => P_FORMAT,
      p_denom_width => P_DENOM_WIDTH,
      p_numer_width => P_NUMER_WIDTH);

    constant ci_denom_alignment     : integer := fn_get_denom_alignment(
      p_splices_required => ci_splices_required,
      p_splice_width     => ci_splice_width,
      p_scaledenom_width => ci_scaledenom_width);
    
    constant ci_tailorednumer_width : integer := fn_get_tailorednumer_width(
      p_numer_width => P_NUMER_WIDTH,
      p_normnumer_width => ci_normnumer_width,
      p_fract_width => P_FRACT_WIDTH,
      p_guard_width => ci_guard_width);
    
    constant ci_result_width        : integer := fn_get_result_width(P_NUMER_WIDTH,P_FRACT_WIDTH,ci_guard_width);
    constant ci_num_iterations      : integer := fn_get_num_iterations(ci_result_width,ci_splice_width,ci_overlap);

    variable ret_val     : t_hrdiv_latency;
    variable max_latency : t_hrdiv_latency;
    variable v_latency_left : integer;
    variable v_loop_count : integer := 0;
    variable v_denom_loop_limit : integer := 0;
    constant ci_loop_limit : integer := 60;  --bigger than possible, less than 64 (at which point xst complains).
  begin
    
    --initialise all latency stages to 0.
    ret_val.used           := 0;
    --numer delays
    ret_val.numer          := 0;
    ret_val.prenumer       := 0;
    ret_val.shift          := 0;
    ret_val.prenorm        := 0;
    ret_val.nd_bypass      := 0;
    ret_val.iter_first     := 0;
    --denom delays
    ret_val.denom          := 0;
    ret_val.fixed_to_float := 0;
    ret_val.estimator      := 0;
    ret_val.prescaler      := 0;
    ret_val.iter_last      := 0;
    ret_val.quot_coll      := 0;
    ret_val.min_latency    := ci_num_iterations + 1;

    max_latency.fixed_to_float := fn_local_fix2fltdelay(
      p_width => P_DENOM_WIDTH
      );
--    max_latency.fixed_to_float := flt_pt_delay(
--      family                => c_xdevicefamily_to_c_family(P_XDEVICEFAMILY),
--      op_code               => FLT_PT_FIX_TO_FLT_OP_CODE_SLV,
--      a_width               => P_DENOM_WIDTH,
--      a_fraction_width      => 0,
--      b_width               => 0,
--      b_fraction_width      => 0,
--      result_width          => P_DENOM_WIDTH+ci_extra_bits,
--      result_fraction_width => P_DENOM_WIDTH,
--      optimization          => 1,--2-P_OPTIMIZE_GOAL,  --area =2, speed =1
--      mult_usage            => 0,
--      rate                  => 1,
--      has_fix_to_flt        => 1
--      );
    max_latency.estimator  := fn_alloc_est_lat(
      p_latency => -1
      ).used;
    max_latency.prenorm    := fn_alloc_prenorm_lat(
      P_VERBOSITY     => 0,
      P_XDEVICEFAMILY => p_xdevicefamily,
      P_LATENCY       => -1,
      p_shift_width   => log2roundup(p_denom_width)
      ).used;
    max_latency.prescaler := fn_prescaler_alloc(
      p_xdevicefamily => p_xdevicefamily,
      p_latency       => -1,
      p_denom_width   => fn_fulldenom_width(P_FORMAT, P_DENOM_WIDTH),
      p_num_stages    => fn_num_prescale_stages(p_denom_width)
      ).used;
    max_latency.iter_first := ci_max_carousel_latency-1;
    max_latency.iter_last  := 1;
    if P_FORMAT = ci_fixed_operands then
      max_latency.denom := max_latency.fixed_to_float + max_latency.estimator + max_latency.prescaler;
    else
      max_latency.denom := max_latency.estimator + max_latency.prescaler;
    end if;

    max_latency.quot_coll  := fn_alloc_quot_coll_lat(
      p_latency       => -1,
      p_xdevicefamily => p_xdevicefamily,
      p_verbosity     => p_verbosity,
      p_quot_width    => p_numer_width,
      p_fract_width   => p_fract_width,
      p_guard_width   => ci_guard_width,
      p_alignment_width => ci_denom_alignment
      ).used;
--    assert false report "Quot_coll max latency = "&integer'image(max_latency.Quot_coll) severity note;
    max_latency.prenumer       := 0;
    max_latency.shift          := 0;
    
    v_latency_left := p_latency;
    assert P_VERBOSITY < 2 report "Starting latency = "&integer'image(p_latency) severity note;

    --iterative section (last).
    if v_latency_left < 0 or v_latency_left >= ci_num_iterations then
      if ret_val.iter_last < max_latency.iter_last then
        v_latency_left     := v_latency_left - ci_num_iterations;
        ret_val.used       := ret_val.used + ci_num_iterations;
        ret_val.iter_last  := ret_val.iter_last +1;
      end if; 
    else
      assert false
        report "ERROR: hrdiv_pkg_v1_0: insufficient latency allocated to hrdiv (iterative section)"
        severity error;
    end if;

    ---------------------------------------------------------------------------
    -- While loop conditions:
    -- first clause is 'there is still latency to allocate'
    -- second clause is 'latency is saturated' (C_LATENCY = -1)
    -- third clause is 'excess latency, but cannot be allocated'
    -- The last clause is caught by timeout. It can occur if the latency
    -- specified is awkward for the equation
    -- LATENCY = (iterative unit latency * number of iterations) + linear latency
    -- where linear latency is the latency before or after the iterative unit.
    -- This can occur if the remaining latency is too little to be allocated to
    -- the iterative unit, but cannot be absorbed by linear latency either. 
    ---------------------------------------------------------------------------
    while (v_latency_left /= 0 or        --See note above!
           ((ret_val.quot_coll /= max_latency.quot_coll) and (ret_val.iter_last /= max_latency.iter_last) and (ret_val.denom /= max_latency.denom))  --
           --See note above!
           )
      and v_loop_count < ci_loop_limit loop  --see note above!

      --First must come first because of BRAM in estimator.
      --first section.
      if v_latency_left /= 0 then
        if ret_val.denom < max_latency.denom then
          v_latency_left := v_latency_left-1;
          ret_val.denom  := ret_val.denom +1;
          ret_val.used   := ret_val.used +1;
          ret_val.numer  := ret_val.numer +1;
        end if;
      end if;

      --iterative section (first).
      if (v_latency_left < 0 or v_latency_left >= ci_num_iterations) and ret_val.denom < max_latency.denom then
        if ret_val.iter_first < max_latency.iter_first then
          v_latency_left     := v_latency_left - ci_num_iterations;
          ret_val.used       := ret_val.used + ci_num_iterations;
          ret_val.iter_first := ret_val.iter_first +1;
          ret_val.denom      := ret_val.denom + 1;
        end if;
      end if;

      --last section (must not have more latency than iterative section)
      if v_latency_left /= 0 then
        if ret_val.quot_coll < max_latency.quot_coll and ret_val.quot_coll < (ret_val.iter_last+ret_val.iter_first)then
          v_latency_left    := v_latency_left-1;
          ret_val.quot_coll := ret_val.quot_coll +1;
          ret_val.used      := ret_val.used +1;
        end if;
      end if;
      v_loop_count := v_loop_count+1;

    end loop;

    assert P_VERBOSITY < 2 report "ci_num_iterations := "&integer'image(ci_num_iterations) severity note;
    assert P_VERBOSITY < 2 report "used := "&integer'image(ret_val.used) severity note;
    assert P_VERBOSITY < 2 report "iter_first := "&integer'image(ret_val.iter_first) severity note;
    assert P_VERBOSITY < 2 report "iter_last := "&integer'image(ret_val.iter_last) severity note;
    assert P_VERBOSITY < 2 report "denom := "&integer'image(ret_val.denom) severity note;
    assert P_VERBOSITY < 2 report "numer := "&integer'image(ret_val.numer) severity note;
    assert P_VERBOSITY < 2 report "quot_coll := "&integer'image(ret_val.quot_coll) severity note;

   
    --second phase - split region allocation into blocks
    --denom

    --ensure that the prescaler has as much latency as the first part of the iterative
    --engine otherwise the estimate will have to be delayed before going to the
    --prescaler
    ret_val.prescaler := ret_val.prescaler+ ret_val.iter_first;
    ret_val.denom := ret_val.denom - ret_val.iter_first;

    assert ret_val.denom >= 0
      report "ERROR: hrdiv_pkg_v1_0. Latency imbalance. Iterfirst > denom allocation."
      severity error;

    --It is necessary to use a temp variable here to be sympathetic to TCL. In
    --TCL, messing with loop limits inside a loop has a different effect to VHDL.
    --Interpreted vs compiled!
    v_denom_loop_limit := ret_val.denom;
    for k in 1 to v_denom_loop_limit loop
      --Estimator must come first because it has a BRAM.
      if ret_val.denom > 0 and ret_val.estimator < max_latency.estimator then
        ret_val.denom := ret_val.denom -1;
        ret_val.estimator := ret_val.estimator+1;
      end if;
      if p_format = ci_fixed_operands then
        if ret_val.denom > 0 and ret_val.fixed_to_float < max_latency.fixed_to_float then
          ret_val.denom := ret_val.denom -1;
          ret_val.fixed_to_float := ret_val.fixed_to_float+1;
        end if;
      end if;
      if ret_val.denom > 0 and ret_val.prescaler < max_latency.prescaler then
        ret_val.denom := ret_val.denom -1;
        ret_val.prescaler := ret_val.prescaler+1;
      end if;
    end loop;  -- k
    assert ret_val.denom = 0
      report "ERROR: hrdiv_pkg_v1_0: denom latency is not all allocated."
      severity error;

    --Until now the numer path prior to the iterative unit has been lumped on
    --the numer delay (as for float). For the fixed case, allocate as much
    --as possible to the prenormalizer.
    ret_val.nd_bypass := ret_val.numer;
    
    if P_FORMAT = ci_fixed_operands then
      --first, balance numer delay to fixed_to_float (because shift output
      --crosses over)
      ret_val.prenumer := ret_val.fixed_to_float;  --prenumer must be at least this.
      ret_val.numer    := ret_val.numer - ret_val.prenumer;
      if ret_val.numer >= max_latency.prenorm then
        ret_val.numer := ret_val.numer - max_latency.prenorm;
        ret_val.prenorm := max_latency.prenorm;
        --allocate remainder to shift balance.
        ret_val.shift := ret_val.numer;
        ret_val.prenumer := ret_val.prenumer + ret_val.shift;  --prenumer = fix_to_flt + shift
        ret_val.numer := 0;
      else
        ret_val.prenorm := ret_val.numer;
        ret_val.numer := 0;
      end if;
    end if;
    ret_val.est_bal := ret_val.prescaler - ret_val.iter_first;
    
    
    -- checks latency returns all balance.
    assert ret_val.prenumer + ret_val.prenorm + ret_val.iter_first = ret_val.fixed_to_float + ret_val.estimator + ret_val.prescaler
      report "ERROR : hrdiv_pkg_v1_0: Latency balancing mismatch: numer /= denom"
      severity error;
    assert ret_val.prenumer = ret_val.fixed_to_float + ret_val.shift
      report "ERROR: hrdiv_pkg_v1_0: Latency unbalanced: prenumer /= fix_to_flt + shift"
      severity error;
    assert ret_val.est_bal + ret_val.iter_first = ret_val.prescaler
      report "ERROR: hrdiv_pkg_v1_0: Latency imbalance: est_bal + iter_first /= prescaler"
      severity error;
    assert (ret_val.prenumer + ret_val.prenorm + (ret_val.iter_first + ret_val.iter_last)*ci_num_iterations + ret_val.quot_coll = P_LATENCY)
      or (P_LATENCY = -1)
      report "ERROR: hrdiv_pkg_v1_0: Latency imbalance: total latency /= latency required"
      severity error;

    return ret_val;
  end function fn_hrdiv_latency;

end package body hrdiv_pkg_v1_0;

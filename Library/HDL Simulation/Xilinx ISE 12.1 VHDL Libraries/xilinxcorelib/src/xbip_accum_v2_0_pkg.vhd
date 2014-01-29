-- $Id: xbip_accum_v2_0_pkg.vhd,v 1.3 2009/09/08 16:38:07 akennedy Exp $
--
--  (c) Copyright 2007 Xilinx, Inc. All rights reserved.
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
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;

package xbip_accum_v2_0_pkg is

  constant c_bip_accum_v2_0_max_pipe_stages : integer := 32;
  constant ci_vx4_cc_limit     : integer := 12;
  constant ci_vx5_cc_limit     : integer := 20;
  constant ci_sp3adsp_cc_limit : integer := 8;
  constant ci_other_cc_limit   : integer := 10;
  
  type t_xbip_accum_v2_0_pipe is array (0 to c_bip_accum_v2_0_max_pipe_stages) of integer;
  
  type t_xbip_accum_v2_0_latency is record
    used : integer;
    pipe : t_xbip_accum_v2_0_pipe;
  end record;

  type t_xbip_accum_v2_0_resources is record
    dsp48    : integer;
    bram18k  : integer;
    luts     : integer;
    ffs      : integer;
  end record;
  
  function fn_xbip_accum_v2_0_get_resources(
    p_xdevicefamily     : string;
    p_use_dsp48    : integer;
    p_verbosity         : integer;
    p_latency           : integer;
    p_bypass_low        : integer;
    p_b_width           : integer;
    p_out_width         : integer;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_data_type         : integer;
    p_has_bypass        : integer;
    p_add_mode          : integer
    )
    return t_xbip_accum_v2_0_resources;
  
  function fn_xbip_accum_v2_0_latency(
    p_xdevicefamily     : string;
    p_use_dsp48    : integer;
    p_verbosity         : integer;
    p_latency           : integer;
    p_bypass_low        : integer;
    p_b_width           : integer;
    p_out_width         : integer;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_data_type         : integer;
    p_has_bypass        : integer;
    p_add_mode          : integer
    )
    return t_xbip_accum_v2_0_latency;
  
  function fn_xbip_accum_v2_0_check_generics(
    p_xdevicefamily     : string;
    p_use_dsp48    : integer;
    p_verbosity         : integer;
    p_latency           : integer;
    p_bypass_low        : integer;
    p_b_width           : integer;
    p_out_width         : integer;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_data_type         : integer;
    p_has_bypass        : integer;
    p_add_mode          : integer
    )
    return integer;

  component fabric_piped_accum 
    generic (
      C_XDEVICEFAMILY : string  := "virtex2";
      C_VERBOSITY     : integer := 0;
      C_LATENCY       : integer := 1;
      C_B_WIDTH       : integer := 16;
      C_OUT_WIDTH     : integer := 16;
      C_B_TYPE        : integer := 1;
      C_HAS_BYPASS    : integer := 1;
      C_ADD_MODE      : integer := 0
      );
    port (
      B       : in  std_logic_vector(C_B_WIDTH-1 downto 0) := (others => '0');  -- input value
      CLK     : in  std_logic                              := '0';              -- optional clock
      ADDF    : in  std_logic                              := '1';
      C_IN    : in  std_logic                              := '0';              -- carry in
      CE      : in  std_logic                              := '1';              -- clock enable
      BYPASSF : in  std_logic                              := '1';              -- sync load of b into reg
      SCLR    : in  std_logic                              := '0';              -- synch init.
      Q       : out std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0') -- output value
      );
  end component;
 
  
end package xbip_accum_v2_0_pkg;

package body xbip_accum_v2_0_pkg is

  function fn_xbip_accum_v2_0_check_generics(
    p_xdevicefamily     : string;
    p_use_dsp48    : integer;
    p_verbosity         : integer;
    p_latency           : integer;
    p_bypass_low        : integer;
    p_b_width           : integer;
    p_out_width         : integer;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_data_type         : integer;
    p_has_bypass        : integer;
    p_add_mode          : integer
    )
    return integer is

    constant error_string :  string := "ERROR: xbip_accum_v2_0: ";
    constant warn_string :  string := "WARNING: xbip_accum_v2_0: ";
    variable min_width : integer := 1;
  begin
    if p_verbosity /= 0 and p_verbosity /= 1 and p_verbosity /= 2 then
      report warn_string & "C_VERBOSITY valid range is 0 to 2.  Setting to 2.  Current value is " & integer'image(p_verbosity) severity warning;
    end if;

    assert p_bypass_low = 0 or p_bypass_low = 1 
      report error_string & "C_BYPASS_LOW valid values of 0 and 1 for the DSP48 implementation.  Current value is " & integer'image(p_latency) severity error;

    assert p_data_type = c_signed or p_data_type = c_unsigned
      report error_string & "C_DATA_TYPE valid values are 0(signed) and 1(unsigned).  Current value is " & integer'image(p_data_type) severity error;

    assert p_ce_overrides_sclr = 0 or p_ce_overrides_sclr = 1
      report error_string & "C_SCLR_OVERRIDES_SSET valid range is 0 to 1.  Current value is " & integer'image(p_ce_overrides_sclr) severity error;

    assert p_use_dsp48 = 0 or p_use_dsp48 = 1  
      report error_string & "C_USE_DSP48 valid range is 0 to 1.  Current value is " & integer'image(p_use_dsp48) severity error;


    if p_use_dsp48 = 1 then

      assert p_xdevicefamily /= "NO_FAMILY" 
        report error_string & "C_XDEVICEFAMILY has not been correctly set (perhaps by CORE Generator)" severity error;

      if not(supports_dsp48(p_xdevicefamily)>0 or supports_dsp48e(p_xdevicefamily)>0 or supports_dsp48a(p_xdevicefamily)>0) then
        assert false
          report error_string & "Invalid value for C_XDEVICEDFAMILY; must be VIRTEX4, VIRTEX5, VIRTEX6, SPARTAN3ADSP or SPARTAN6 for DSP48 implementation.  Current value is " & p_xdevicefamily severity error;
      end if;

      assert p_latency = 1 or p_latency = -1 or p_latency = 2
        report error_string & "C_LATENCY valid values of -1, 1 and 2 for the DSP48 implementation.  Current value is " & integer'image(p_latency) severity error;

      if p_data_type = c_signed then
        min_width := 2;
      end if;

      assert p_b_width >= min_width AND p_b_width <= ci_dsp48_c_width-p_data_type 
        report error_string & "Invalid value for C_B_WIDTH; must be in the range " & integer'image(min_width) & ".." & integer'image(ci_dsp48_c_width-p_data_type) & ".  Current value is " & integer'image(p_b_width) severity error;
  
      assert p_out_width >= p_b_width  AND p_out_width <= ci_dsp48_p_width
          report error_string & "Invalid value for C_OUT_WIDTH; must be in the range " & integer'image(p_b_width) & ".." & integer'image(ci_dsp48_c_width) & ".  Current value is " & integer'image(p_out_width) severity error;
    else
      assert p_b_width > 0 AND p_b_width <= 256 
        report error_string & "Invalid value for C_B_WIDTH; must be in the range 1..256.  Current value is " & integer'image(p_b_width) severity error;
      assert p_out_width >= p_b_width  AND p_out_width <= 258 
        report error_string & "Invalid value for C_OUT_WIDTH; must be in the range C_B_WIDTH..258.  Current value is " & integer'image(p_out_width) severity error;
      assert p_latency < p_out_width 
        report error_string & "C_LATENCY must be less than C_OUT_WIDTH for the fabric implementation.  Current value is " & integer'image(p_latency) & "and C_OUT_WIDTH is " & integer'image(p_out_width) severity error;
      assert p_latency < 33 
        report error_string & "C_LATENCY must be less than 33 for the fabric implementation.  Current value is " & integer'image(p_latency) severity error;
    end if; 

    return 0;
  end function fn_xbip_accum_v2_0_check_generics;


  
  function fn_xbip_accum_v2_0_get_resources(
    p_xdevicefamily     : string;
    p_use_dsp48         : integer;
    p_verbosity         : integer;
    p_latency           : integer;
    p_bypass_low        : integer;
    p_b_width           : integer;
    p_out_width         : integer;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_data_type         : integer;
    p_has_bypass        : integer;
    p_add_mode          : integer
    )
    return t_xbip_accum_v2_0_resources is
    variable ret_val : t_xbip_accum_v2_0_resources;
    constant c_has_bypass : integer := 1;
    constant c_accum_mode : integer := 2;

    constant ci_pipe_all : t_xbip_accum_v2_0_latency := fn_xbip_accum_v2_0_latency(
      p_xdevicefamily     => p_xdevicefamily,
      p_use_dsp48         => p_use_dsp48,
      p_verbosity         => p_verbosity,
      p_latency           => p_latency,
      p_bypass_low        => p_bypass_low,
      p_b_width           => p_b_width,
      p_out_width         => p_out_width,
      p_ce_overrides_sclr => p_ce_overrides_sclr,
      p_data_type         => p_data_type,
      p_has_bypass        => p_has_bypass,
      p_add_mode          => p_add_mode
      );                                  
    
    constant ci_num_segs_prelim  : integer := ci_pipe_all.used;  --p_latency
    constant ci_seg_width : integer := (p_out_width-1)/ci_num_segs_prelim +1; 
    constant ci_num_segs : integer :=(p_out_width-1)/ci_seg_width +1;
    constant remaining_latency : integer := p_latency-ci_num_segs;

  begin
    ret_val.bram18k := 0;
    ret_val.luts := 0;
    ret_val.dsp48 := 0;
    ret_val.ffs := 0;
--    ret_val := (0,0,0,0); this doesn't work with Rabassa

    if(p_use_dsp48 = 1) then
      ret_val.dsp48 := 1;               --simple for now!
    else 

      --logic in pipelined fabric accum.
      --each stage has carry in and carryout except the first and last
      
      ret_val.luts := (p_out_width + ci_num_segs*2 - 2);  --luts in counters
      ret_val.ffs  := (p_out_width + ci_num_segs - 1);    --each segment counter is a bit wider to accommodate cout, apart from the last stage.

      --Q pipe
      if ci_num_segs > 1 then
        ret_val.ffs  := ret_val.ffs + (ci_num_segs-1)*ci_seg_width;
      end if;
      if ci_num_segs > 2 then
        ret_val.luts := ret_val.luts + (ci_num_segs-2)*ci_seg_width;  --SRLs
      end if;

      -- extra latency
      if remaining_latency > 0 then
        if remaining_latency < 5 then -- all ff's being used
          ret_val.ffs  := ret_val.ffs + remaining_latency*p_out_width;
	else
          ret_val.ffs  := ret_val.ffs + p_out_width;
          ret_val.luts  := ret_val.luts + p_out_width;
        end if;
      end if;

      --load value pipe
      if c_has_bypass = 1 then
        if ci_num_segs > 1 then
          ret_val.ffs  := ret_val.ffs + p_out_width - ci_seg_width;
        end if;
        if ci_num_segs > 2 then
          ret_val.luts := ret_val.luts + p_out_width-2*ci_seg_width;  --SRLs
        end if;

        --load pipe
        ret_val.ffs := ret_val.ffs + ci_num_segs-1;
      end if;

      --up pipe
      if c_accum_mode = 2 then
        ret_val.ffs := ret_val.ffs + ci_num_segs-1;
      end if;
    end if; 

    if p_verbosity >= 2 then
      assert false
        report "Note: xbip_accum_v2_0 DSP48 count = "&integer'image(ret_val.DSP48)
        severity note;
      assert false
        report "Note: xbip_accum_v2_0 BRAM18K count = "&integer'image(ret_val.bram18k)
        severity note;
      assert false
        report "Note: xbip_accum_v2_0 LUT count = "&integer'image(ret_val.luts)
        severity note;
      assert false
        report "Note: xbip_accum_v2_0 FF count = "&integer'image(ret_val.ffs)
        severity note;
    end if;
 
    return ret_val;
  end function fn_xbip_accum_v2_0_get_resources;
  
  function fn_xbip_accum_v2_0_latency(
    p_xdevicefamily     : string;
    p_use_dsp48    : integer;
    p_verbosity         : integer;
    p_latency           : integer;
    p_bypass_low        : integer;
    p_b_width           : integer;
    p_out_width         : integer;
    p_ce_overrides_sclr : integer;      -- 0=override;
    p_data_type         : integer;
    p_has_bypass        : integer;
    p_add_mode          : integer
    )
    return t_xbip_accum_v2_0_latency is
    variable v_latency_left  : integer;
    variable ret_val : t_xbip_accum_v2_0_latency;
    variable v_lat_req : integer;
  begin
    v_latency_left := p_latency;
    ret_val.used := 0;
      for i in 0 to c_bip_accum_v2_0_max_pipe_stages loop
        ret_val.pipe(i) := 0;
      end loop;  -- i
    if p_use_dsp48 = 0 then
      --fabric
      if p_latency = -1 then
        if supports_dsp48(p_xdevicefamily)>0 then
          v_lat_req := (p_out_width-1)/ci_vx4_cc_limit + 1;
        elsif supports_dsp48e(p_xdevicefamily)>0 then
          v_lat_req := (p_out_width-1)/ci_vx5_cc_limit + 1;
        elsif supports_dsp48a(p_xdevicefamily)>0 then
          v_lat_req := (p_out_width-1)/ci_sp3adsp_cc_limit + 1;
        else
          v_lat_req := (p_out_width-1)/ci_other_cc_limit + 1;
        end if;
      else
        v_lat_req := p_latency;
      end if;
      ret_val.used := v_lat_req;
      for k in 1 to v_lat_req loop
        ret_val.pipe(k) := 1;
      end loop;  -- k
    else
      --dsp48 :  single dsp48 implementation only
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
          report "ERROR: xbip_accum_v2_0: Excessive latency for DSP48-based case."
          severity error;
      end if;
      
    end if;
    return ret_val;
  end function fn_xbip_accum_v2_0_latency;

end package body xbip_accum_v2_0_pkg;


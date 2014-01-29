--------------------------------------------------------------------------
-- $RCSfile: c_accum_pkg_v11_0.vhd,v $  $Revision: 1.4 $  $Date: 2009/12/04 11:46:40 $
---------------------------------------------------------------------------
--  (c) Copyright 1995-2009 Xilinx, Inc. All rights reserved.
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
--
---------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;

library xilinxcorelib;
use xilinxcorelib.xbip_accum_v2_0_pkg.all;

package c_accum_pkg_v11_0 is

  constant c_accum_v11_0_max_pipe_stages : integer := 32;
  type t_accum_v11_0_pipe is array (0 to c_accum_v11_0_max_pipe_stages) of integer;

  type t_c_accum_v11_0_latency is record
                                    used : integer;
                                    pipe : t_accum_v11_0_pipe;
                                  end record;

  type t_c_accum_v11_0_resources is record
                                      dsp48   : integer;
                                      bram18k : integer;
                                      luts    : integer;
                                      ffs     : integer;
                                    end record;

  function fn_c_accum_v11_0_latency(
    C_XDEVICEFAMILY       : string;
    C_IMPLEMENTATION      : integer;
    C_VERBOSITY           : integer;
    C_B_WIDTH             : integer;
    C_OUT_WIDTH           : integer;
    C_B_TYPE              : integer;
    C_CE_OVERRIDES_SCLR   : integer;
    C_ADD_MODE            : integer;
    C_HAS_C_IN            : integer;
    C_HAS_CE              : integer;
    C_HAS_BYPASS          : integer;
    C_HAS_SCLR            : integer;
    C_LATENCY             : integer;
    C_SCALE               : integer;
    C_BYPASS_LOW          : integer;
    C_SCLR_OVERRIDES_SSET : integer;
    C_HAS_SSET            : integer;
    C_HAS_SINIT           : integer;
    C_AINIT_VAL           : string;
    C_SINIT_VAL           : string
    ) return t_c_accum_v11_0_latency;

  function fn_c_accum_v11_0_resources(
    C_XDEVICEFAMILY       : string;
    C_IMPLEMENTATION      : integer;
    C_VERBOSITY           : integer;
    C_B_WIDTH             : integer;
    C_OUT_WIDTH           : integer;
    C_B_TYPE              : integer;
    C_CE_OVERRIDES_SCLR   : integer;
    C_ADD_MODE            : integer;
    C_HAS_C_IN            : integer;
    C_HAS_CE              : integer;
    C_HAS_BYPASS          : integer;
    C_HAS_SCLR            : integer;
    C_LATENCY             : integer;
    C_SCALE               : integer;
    C_BYPASS_LOW          : integer;
    C_SCLR_OVERRIDES_SSET : integer;
    C_HAS_SSET            : integer;
    C_HAS_SINIT           : integer;
    C_AINIT_VAL           : string;
    C_SINIT_VAL           : string
    ) return t_c_accum_v11_0_resources;

  function fn_c_accum_v11_0_check_generics(
    C_XDEVICEFAMILY       : string;
    C_IMPLEMENTATION      : integer;
    C_VERBOSITY           : integer;
    C_B_WIDTH             : integer;
    C_OUT_WIDTH           : integer;
    C_B_TYPE              : integer;
    C_CE_OVERRIDES_SCLR   : integer;
    C_ADD_MODE            : integer;
    C_HAS_C_IN            : integer;
    C_HAS_CE              : integer;
    C_HAS_BYPASS          : integer;
    C_HAS_SCLR            : integer;
    C_LATENCY             : integer;
    C_SCALE               : integer;
    C_BYPASS_LOW          : integer;
    C_SCLR_OVERRIDES_SSET : integer;
    C_HAS_SSET            : integer;
    C_HAS_SINIT           : integer;
    C_AINIT_VAL           : string;
    C_SINIT_VAL           : string
    ) return integer;

  function fn_borrow_ports(
    has_port  : integer;
    add_mode  : integer;
    data_type : integer
    ) return integer;

  function fn_carry_ports(
    has_port  : integer;
    add_mode  : integer;
    data_type : integer
    ) return integer;

  function fn_add_port(
    add_mode : integer
    ) return integer;

  function fn_use_baseblox(
    p_implementation : integer;
    p_latency        : integer
    ) return boolean;

  function get_POR_value(
    c_out_width  : integer;
    c_has_aclr   : integer;
    c_has_aset   : integer;
    c_has_ainit  : integer;
    c_has_sclr   : integer;
    c_has_sset   : integer;
    c_has_sinit  : integer;
    ci_ainit_val : std_logic_vector;
    ci_sinit_val : std_logic_vector;
    ci_b_value   : std_logic_vector
    ) return std_logic_vector;

  function fn_part_dsp48_needed(
    part_dsp48_bits : integer
    ) return integer;

  function get_flipflop_value(
    c_has_aclr  : integer;
    c_has_aset  : integer;
    c_has_ainit : integer;
    c_has_sclr  : integer;
    c_has_sset  : integer;
    c_has_sinit : integer
    ) return std_logic;

  function fn_c_accum_v11_0_legacy_check_generics(
    c_verbosity           : integer;
    c_use_dsp48           : integer;
    c_family              : string;
    c_b_width             : integer;
    c_out_width           : integer;
    c_low_bit             : integer;
    c_high_bit            : integer;
    c_add_mode            : integer;
    c_b_type              : integer;
    c_b_constant          : integer;
    c_b_value             : string;
    c_scale               : integer;
    c_saturate            : integer;
    c_ainit_val           : string;
    c_sinit_val           : string;
    c_bypass_enable       : integer;
    c_bypass_low          : integer;
    c_sync_enable         : integer;
    c_sync_priority       : integer;
    c_pipe_stages         : integer;
    c_has_s               : integer;
    c_has_c_in            : integer;
    c_has_c_out           : integer;
    c_has_q_c_out         : integer;
    c_has_b_in            : integer;
    c_has_b_out           : integer;
    c_has_q_b_out         : integer;
    c_has_ovfl            : integer;
    c_has_q_ovfl          : integer;
    c_has_ce              : integer;
    c_has_add             : integer;
    c_has_bypass          : integer;
    c_has_b_signed        : integer;
    c_has_aclr            : integer;
    c_has_aset            : integer;
    c_has_ainit           : integer;
    c_has_sclr            : integer;
    c_has_sset            : integer;
    c_has_sinit           : integer;
    c_has_bypass_with_cin : integer;
    enum_c_add_mode       : T_ADD_MODE;
    enum_c_b_type         : T_NUMBER_FORMAT;
    c_enable_rlocs        : integer
    ) return integer;



end package c_accum_pkg_v11_0;

package body c_accum_pkg_v11_0 is

  function fn_c_accum_v11_0_latency(
    C_XDEVICEFAMILY         : string;
    C_IMPLEMENTATION        : integer;
    C_VERBOSITY             : integer;
    C_B_WIDTH               : integer;
    C_OUT_WIDTH             : integer;
    C_B_TYPE                : integer;
    C_CE_OVERRIDES_SCLR     : integer;
    C_ADD_MODE              : integer;
    C_HAS_C_IN              : integer;
    C_HAS_CE                : integer;
    C_HAS_BYPASS            : integer;
    C_HAS_SCLR              : integer;
    C_LATENCY               : integer;
    C_SCALE                 : integer;
    C_BYPASS_LOW            : integer;
    C_SCLR_OVERRIDES_SSET   : integer;
    C_HAS_SSET              : integer;
    C_HAS_SINIT             : integer;
    C_AINIT_VAL             : string;
    C_SINIT_VAL             : string
    ) return t_c_accum_v11_0_latency is
    variable ret_val        : t_c_accum_v11_0_latency;
    variable xbip_accum_lat : t_xbip_accum_v2_0_latency;
  begin
    if C_LATENCY = -1 then
      xbip_accum_lat := fn_xbip_accum_v2_0_latency(
        p_xdevicefamily     => C_XDEVICEFAMILY,
        p_use_dsp48         => C_IMPLEMENTATION,
        p_verbosity         => C_VERBOSITY,
        p_latency           => C_LATENCY,
        p_bypass_low        => C_BYPASS_LOW,
        p_b_width           => C_B_WIDTH,
        p_out_width         => C_OUT_WIDTH,
        p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR,
        p_data_type         => C_B_TYPE,
        p_has_bypass        => C_HAS_BYPASS,
        p_add_mode          => C_ADD_MODE
        );
      ret_val.used   := xbip_accum_lat.used;
    else
      ret_val.used   := c_latency;
    end if;
    return ret_val;
  end fn_c_accum_v11_0_latency;

  function fn_c_accum_v11_0_resources(
    C_XDEVICEFAMILY         : string;
    C_IMPLEMENTATION        : integer;
    C_VERBOSITY             : integer;
    C_B_WIDTH               : integer;
    C_OUT_WIDTH             : integer;
    C_B_TYPE                : integer;
    C_CE_OVERRIDES_SCLR     : integer;
    C_ADD_MODE              : integer;
    C_HAS_C_IN              : integer;
    C_HAS_CE                : integer;
    C_HAS_BYPASS            : integer;
    C_HAS_SCLR              : integer;
    C_LATENCY               : integer;
    C_SCALE                 : integer;
    C_BYPASS_LOW            : integer;
    C_SCLR_OVERRIDES_SSET   : integer;
    C_HAS_SSET              : integer;
    C_HAS_SINIT             : integer;
    C_AINIT_VAL             : string;
    C_SINIT_VAL             : string
    ) return t_c_accum_v11_0_resources is
    variable ret_val        : t_c_accum_v11_0_resources;
    variable xbip_accum_res : t_xbip_accum_v2_0_resources;
  begin
    xbip_accum_res  := fn_xbip_accum_v2_0_get_resources(
      p_xdevicefamily     => C_XDEVICEFAMILY,
      p_use_dsp48         => C_IMPLEMENTATION,
      p_verbosity         => C_VERBOSITY,
      p_latency           => C_LATENCY,
      p_bypass_low        => C_BYPASS_LOW,
      p_b_width           => C_B_WIDTH,
      p_out_width         => C_OUT_WIDTH,
      p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR,
      p_data_type         => C_B_TYPE,
      p_has_bypass        => C_HAS_BYPASS,
      p_add_mode          => C_ADD_MODE
      );
    ret_val.dsp48   := xbip_accum_res.dsp48;
    ret_val.bram18k := xbip_accum_res.bram18k;
    ret_val.luts    := xbip_accum_res.luts;
    ret_val.ffs     := xbip_accum_res.ffs;
    return ret_val;
  end fn_c_accum_v11_0_resources;

  function fn_c_accum_v11_0_check_generics(
    C_XDEVICEFAMILY       : string;
    C_IMPLEMENTATION      : integer;
    C_VERBOSITY           : integer;
    C_B_WIDTH             : integer;
    C_OUT_WIDTH           : integer;
    C_B_TYPE              : integer;
    C_CE_OVERRIDES_SCLR   : integer;
    C_ADD_MODE            : integer;
    C_HAS_C_IN            : integer;
    C_HAS_CE              : integer;
    C_HAS_BYPASS          : integer;
    C_HAS_SCLR            : integer;
    C_LATENCY             : integer;
    C_SCALE               : integer;
    C_BYPASS_LOW          : integer;
    C_SCLR_OVERRIDES_SSET : integer;
    C_HAS_SSET            : integer;
    C_HAS_SINIT           : integer;
    C_AINIT_VAL           : string;
    C_SINIT_VAL           : string
    ) return integer is

    constant error_string : string := "ERROR : c_accum_v11_0 : ";
    constant warn_string  : string := "WARNING : c_accum_v11_0 : ";
  begin

    if C_VERBOSITY /= 0 and C_VERBOSITY /= 1 and C_VERBOSITY /= 2 then
      report warn_string & "C_VERBOSITY valid range is 0 to 2. Setting to 2. Current value is " & integer'image(C_VERBOSITY) severity warning;
    end if;

    assert C_IMPLEMENTATION = 0 or C_IMPLEMENTATION = 1
      report error_string & "C_IMPLEMENTATION valid range is 0 to 1. Current value is " & integer'image(C_IMPLEMENTATION) severity error;

    assert C_XDEVICEFAMILY /= "no_family"
      report error_string & "C_XDEVICEFAMILY has not been correctly set (perhaps by CORE Generator)" severity error;

    assert C_B_TYPE = 0 or C_B_TYPE = 1
      report error_string & "C_B_TYPE valid range is 0 to 1. Current value is " & integer'image(C_B_TYPE) severity error;

    assert C_CE_OVERRIDES_SCLR = 0 or C_CE_OVERRIDES_SCLR = 1
      report error_string & "C_CE_OVERRIDES_SCLR valid range is 0 to 1. Current value is " & integer'image(C_CE_OVERRIDES_SCLR) severity error;

    assert C_ADD_MODE = 0 or C_ADD_MODE = 1 or C_ADD_MODE = 2
      report error_string & "C_ADD_MODE valid range is 0 to 2. Current value is " & integer'image(C_ADD_MODE) severity error;

    assert C_HAS_C_IN = 0 or C_HAS_C_IN = 1
      report error_string & "C_HAS_C_IN valid range is 0 to 1. Current value is " & integer'image(C_HAS_C_IN) severity error;

    assert C_HAS_CE = 0 or C_HAS_CE = 1
      report error_string & "C_HAS_CE valid range is 0 to 1. Current value is " & integer'image(C_HAS_CE) severity error;

    assert C_HAS_BYPASS = 0 or C_HAS_BYPASS = 1
      report error_string & "C_HAS_BYPASS valid range is 0 to 1. Current value is " & integer'image(C_HAS_BYPASS) severity error;

    assert C_HAS_SCLR = 0 or C_HAS_SCLR = 1
      report error_string & "C_HAS_SCLR valid range is 0 to 1. Current value is " & integer'image(C_HAS_SCLR) severity error;

    assert C_BYPASS_LOW = 0 or C_BYPASS_LOW = 1
      report error_string & "C_BYPASS_LOW valid range is 0 to 1. Current value is " & integer'image(C_BYPASS_LOW) severity error;

    if C_IMPLEMENTATION = 0 and C_LATENCY = 1 then
      -- let Legacy model check its own generics
    else
      if C_IMPLEMENTATION = 0 then
        -- pipelined fabric
        assert C_B_WIDTH > 0 and C_B_WIDTH              <= 256
                                              report error_string & "Invalid value for C_B_WIDTH; must be in the range 1..256. Current value is " & integer'image(C_B_WIDTH) severity error;
        assert C_OUT_WIDTH >= C_B_WIDTH and C_OUT_WIDTH <= 258
                                                            report error_string & "Invalid value for C_OUT_WIDTH; must be in the range C_B_WIDTH..258. Current value is " & integer'image(C_OUT_WIDTH) severity error;
        assert C_LATENCY < C_OUT_WIDTH
          report error_string & "C_LATENCY must be less than C_OUT_WIDTH for the fabric implementation. Current value is " & integer'image(C_LATENCY) & "and C_OUT_WIDTH is " & integer'image(C_OUT_WIDTH) severity error;
        assert C_LATENCY <= c_accum_v11_0_max_pipe_stages
          report error_string & "C_LATENCY must be less than " & integer'image(c_accum_v11_0_max_pipe_stages) & " for the fabric implementation. Current value is " & integer'image(C_LATENCY) severity error;
        if C_VERBOSITY > 0 then
          assert C_SCALE = 0
            report warn_string & "C_SCALE is not supported in the Pipelined Fabric implementation; it will be set to 0. Current value is " & integer'image(C_SCALE) severity warning;
          assert C_HAS_SSET = 0
            report warn_string & "C_HAS_SSET is not supported in the Pipelined Fabric implementation; it will be set to 0 (no SSET port). Current value is " & integer'image(C_HAS_SSET) severity warning;
          assert C_HAS_SINIT = 0
            report warn_string & "C_HAS_SINIT is not supported in the Pipelined Fabric implementation; it will be set to 0 (no SINIT port). Current value is " & integer'image(C_HAS_SINIT) severity warning;
        end if;
      else
        -- dsp48 implementation
        if not(supports_dsp48(C_XDEVICEFAMILY) > 0 or supports_dsp48e(C_XDEVICEFAMILY) > 0 or supports_dsp48a(C_XDEVICEFAMILY) > 0 ) then
          assert false
            report error_string & "Invalid value for C_XDEVICEDFAMILY; must be VIRTEX4, VIRTEX5, VIRTEX6, SPARTAN3ADSP or SPARTAN6 for DSP48 implementation. Current value is " & C_XDEVICEFAMILY severity error;
        end if;

        assert C_B_WIDTH > 0 and C_B_WIDTH              <= ci_dsp48_c_width-C_B_TYPE
                                              report error_string & "Invalid value for C_B_WIDTH; must be in the range 1.." & integer'image(C_B_WIDTH-C_B_TYPE) & ". Current value is " & integer'image(C_B_WIDTH) severity error;
        assert C_OUT_WIDTH >= C_B_WIDTH and C_OUT_WIDTH <= ci_dsp48_p_width
                                                            report error_string & "Invalid value for C_OUT_WIDTH; must be in the range C_B_WIDTH..48. Current value is " & integer'image(C_OUT_WIDTH) severity error;
        assert C_LATENCY = 1 or C_LATENCY = -1 or C_LATENCY = 2
          report error_string & "C_LATENCY valid values of -1, 1 and 2 for the DSP48 implementation. Current value is " & integer'image(C_LATENCY) severity error;

        if C_VERBOSITY > 0 then
          assert C_SCALE = 0
            report warn_string & "C_SCALE is not supported in the DSP48 implementation; it will be set to 0. Current value is " & integer'image(C_SCALE) severity warning;
          assert C_HAS_SSET = 0
            report warn_string & "C_HAS_SSET is not supported in the DSP48 implementation; it will be set to 0 (no SSET port). Current value is " & integer'image(C_HAS_SSET) severity warning;
          assert C_HAS_SINIT = 0
            report warn_string & "C_HAS_SINIT is not supported in the DSP48 implementation; it will be set to 0 (no SINIT port). Current value is " & integer'image(C_HAS_SINIT) severity warning;
        end if;
      end if;
    end if;
    return 0;
  end function fn_c_accum_v11_0_check_generics;

  function fn_borrow_ports(
    has_port  : integer;
    add_mode  : integer;
    data_type : integer
    ) return integer is
  begin
    if add_mode = 1 and data_type = 1 then
      return has_port;
    else
      return 0;
    end if;
  end fn_borrow_ports;

  function fn_carry_ports(
    has_port  : integer;
    add_mode  : integer;
    data_type : integer
    ) return integer is
  begin
    if add_mode = 1 or data_type = 0 then
      return 0;
    else
      return has_port;
    end if;
  end fn_carry_ports;

  function fn_add_port(
    add_mode : integer
    ) return integer is
  begin
    if add_mode = 2 then
      return 1;
    else
      return 0;
    end if;
  end fn_add_port;


  function fn_use_baseblox(
    p_implementation : integer;
    p_latency        : integer
    ) return boolean is
  begin
    if (p_implementation = 0 and p_latency = 1) then
      return true;
    else
      return false;
    end if;
  end fn_use_baseblox;

  -- Calculates the power-on-reset value for the accumulator.
  -- this value depends on the pins present (aclr,aset,ainit,sclr,sset,sinit).
  -- If none are present, defaults to c_ainit_val.
  function get_POR_value(
    c_out_width      : integer;
    c_has_aclr       : integer;
    c_has_aset       : integer;
    c_has_ainit      : integer;
    c_has_sclr       : integer;
    c_has_sset       : integer;
    c_has_sinit      : integer;
    ci_ainit_val     : std_logic_vector;
    ci_sinit_val     : std_logic_vector;
    ci_b_value       : std_logic_vector
    ) return std_logic_vector is
    variable ret_val : std_logic_vector(c_out_width - 1 downto 0);
  begin
    ret_val   := ci_ainit_val;          -- default for no pins
    if c_has_aclr = 1 then
      ret_val := (others => '0');
    elsif c_has_aset = 1 then
      ret_val := (others => '1');
    elsif c_has_ainit = 1 then
      ret_val := ci_ainit_val;
    elsif c_has_sclr = 1 then
      ret_val := (others => '0');
    elsif c_has_sset = 1 then
      ret_val := (others => '1');
    elsif c_has_sinit = 1 then
      ret_val := ci_sinit_val;
    end if;
    return ret_val;
  end;

  function fn_part_dsp48_needed(
    part_dsp48_bits : integer
    ) return integer is
  begin
    if part_dsp48_bits = 0 then
      return 0;
    else
      return 1;
    end if;
  end function fn_part_dsp48_needed;

  -- Calculates the power-on-reset value for the q_c_out, q_b_out and q_ovfl
  -- output flipflops.
  function get_flipflop_value(
    c_has_aclr       : integer;
    c_has_aset       : integer;
    c_has_ainit      : integer;
    c_has_sclr       : integer;
    c_has_sset       : integer;
    c_has_sinit      : integer
    ) return std_logic is
    variable ret_val : std_logic;
  begin
    ret_val   := '0';
    if c_has_aclr = 1 then
      ret_val := '0';
    elsif c_has_aset = 1 then
      ret_val := '1';
    elsif c_has_ainit = 1 then
      ret_val := '0';
    elsif c_has_sclr = 1 then
      ret_val := '0';
    elsif c_has_sset = 1 then
      ret_val := '1';
    elsif c_has_sinit = 1 then
      ret_val := '0';
    end if;
    return ret_val;
  end;

  -- Purpose: ensure that the generics supplied do not demand a nonsensical or unsupported case
  function fn_c_accum_v11_0_legacy_check_generics(
    c_verbosity           : integer;
    c_use_dsp48           : integer;
    c_family              : string;
    c_b_width             : integer;
    c_out_width           : integer;
    c_low_bit             : integer;
    c_high_bit            : integer;
    c_add_mode            : integer;
    c_b_type              : integer;
    c_b_constant          : integer;
    c_b_value             : string;
    c_scale               : integer;
    c_saturate            : integer;
    c_ainit_val           : string;
    c_sinit_val           : string;
    c_bypass_enable       : integer;
    c_bypass_low          : integer;
    c_sync_enable         : integer;
    c_sync_priority       : integer;
    c_pipe_stages         : integer;
    c_has_s               : integer;
    c_has_c_in            : integer;
    c_has_c_out           : integer;
    c_has_q_c_out         : integer;
    c_has_b_in            : integer;
    c_has_b_out           : integer;
    c_has_q_b_out         : integer;
    c_has_ovfl            : integer;
    c_has_q_ovfl          : integer;
    c_has_ce              : integer;
    c_has_add             : integer;
    c_has_bypass          : integer;
    c_has_b_signed        : integer;
    c_has_aclr            : integer;
    c_has_aset            : integer;
    c_has_ainit           : integer;
    c_has_sclr            : integer;
    c_has_sset            : integer;
    c_has_sinit           : integer;
    c_has_bypass_with_cin : integer;
    enum_c_add_mode       : T_ADD_MODE;
    enum_c_b_type         : T_NUMBER_FORMAT;
    c_enable_rlocs        : integer
    ) return integer is

    constant error_string : string := "ERROR : c_accum_v11_0_legacy : ";
    constant warn_string  : string := "WARNING : c_accum_v11_0_legacy : ";
  begin
    -- bounds checking
    assert c_b_width > 0 and c_b_width     <= 256
                                          report error_string & " Invalid value for c_b_width; must be in the range 1..256"
                                          severity failure;
    assert c_out_width > 0 and c_out_width <= 258
                                              report error_string & " Invalid value for c_out_width; must be in the range 1..258"
                                              severity failure;
    assert c_low_bit = 0
      report error_string & " Invalid value for c_low_bit; c_low_bit must equal 0"
      severity failure;
    assert c_high_bit = c_out_width - 1
      report error_string & " Invalid value for c_high_bit; c_high_bit must equal c_out_width - 1"
      severity failure;
    assert c_has_add = 0 or c_has_add = 1
      report error_string & " Invalid value in generic c_has_add (must be 0 or 1)"
      severity failure;
    assert c_b_constant = 0 or c_b_constant = 1
      report error_string & " Invalid value in generic c_b_constant (must be 0 or 1)"
      severity failure;
    assert c_scale < c_out_width
      report error_string & " c_scale must be less than c_out_width"
      severity failure;
    assert c_scale >= 0 and c_scale        <= 8
                                       report error_string & " Invalid value in generic c_scale (must be in range 0..8)"
                                       severity failure;
    assert c_saturate = 0
      report error_string & " Saturation has been deprecated as of baseblox_v8_0"
      severity failure;
    assert c_bypass_low = 0 or c_bypass_low = 1
      report error_string & " Invalid value in generic c_bypass_low (must be 0 or 1)"
      severity failure;
    assert c_has_s = 0 or c_has_s = 1
      report error_string & " Invalid value in generic c_has_s (must be 0 or 1)"
      severity failure;
    assert c_has_c_in = 0 or c_has_c_in = 1
      report error_string & " Invalid value in generic c_has_c_in (must be 0 or 1)"
      severity failure;
    assert c_has_c_out = 0 or c_has_c_out = 1
      report error_string & " Invalid value in generic c_has_c_out (must be 0 or 1)"
      severity failure;
    assert c_has_q_c_out = 0 or c_has_q_c_out = 1
      report error_string & " Invalid value in generic c_has_q_c_out (must be 0 or 1)"
      severity failure;
    assert c_has_b_in = 0 or c_has_b_in = 1
      report error_string & " Invalid value in generic c_has_b_in (must be 0 or 1)"
      severity failure;
    assert c_has_b_out = 0 or c_has_b_out = 1
      report error_string & " Invalid value in generic c_has_b_out (must be 0 or 1)"
      severity failure;
    assert c_has_q_b_out = 0 or c_has_q_b_out = 1
      report error_string & " Invalid value in generic c_has_q_b_out (must be 0 or 1)"
      severity failure;
    assert c_has_ovfl = 0 or c_has_ovfl = 1
      report error_string & " Invalid value in generic c_has_ovfl (must be 0 or 1)"
      severity failure;
    assert c_has_q_ovfl = 0 or c_has_q_ovfl = 1
      report error_string & " Invalid value in generic c_has_q_ovfl (must be 0 or 1)"
      severity failure;
    assert c_has_ce = 0 or c_has_ce = 1
      report error_string & " Invalid value in generic c_has_ce (must be 0 or 1)"
      severity failure;
    assert c_has_bypass = 0 or c_has_bypass = 1
      report error_string & " Invalid value in generic c_has_bypass (must be 0 or 1)"
      severity failure;
    assert enum_c_b_type /= NUM_PIN
      report error_string & " Use of the B_SIGNED pin is deprecated as of baseblox_v8_0"
      severity failure;
    assert c_has_b_signed = 0
      report error_string & " c_has_b_signed deprecated as of baseblox_v8_0"
      severity failure;
    assert c_has_aclr = 0 or c_has_aclr = 1
      report error_string & " Invalid value in generic c_has_aclr (must be 0 or 1)"
      severity failure;
    assert c_has_aset = 0 or c_has_aset = 1
      report error_string & " Invalid value in generic c_has_aset (must be 0 or 1)"
      severity failure;
    assert c_has_ainit = 0 or c_has_ainit = 1
      report error_string & " Invalid value in generic c_has_ainit (must be 0 or 1)"
      severity failure;
    assert c_has_sclr = 0 or c_has_sclr = 1
      report error_string & " Invalid value in generic c_has_sclr (must be 0 or 1)"
      severity failure;
    assert c_has_sset = 0 or c_has_sset = 1
      report error_string & " Invalid value in generic c_has_sset (must be 0 or 1)"
      severity failure;
    assert c_has_sinit = 0 or c_has_sinit = 1
      report error_string & " Invalid value in generic c_has_sinit (must be 0 or 1)"
      severity failure;
    assert c_has_bypass_with_cin = 0
      report error_string & " c_has_sinit deprecated as of baseblox_v8_0"
      severity failure;
    if c_verbosity > 0 then
      assert c_enable_rlocs = 0
        report warn_string & " RLOCS no longer supported, will ignore user request"
        severity warning;
    end if;

    -- Less straightforward checks
    assert (c_use_dsp48 = 0) or (c_has_aclr = 0)
      report error_string & " DSP48 must be used with synchronous clr"
      severity failure;
    assert (c_use_dsp48 = 0) or (c_has_aset = 0)
      report error_string & " DSP48 must be used with synchronous set"
      severity failure;
    assert (c_use_dsp48 = 0) or (c_has_ainit = 0)
      report error_string & " DSP48 must be used with synchronous init"
      severity failure;
    assert (c_use_dsp48 = 0) or (c_has_s = 0)
      report error_string & " DSP48 must be used with synchronous output"
      severity failure;
    assert (c_use_dsp48 = 0) or (c_scale = 0)
      report error_string & " Scaling is not possble using DSP48"
      severity failure;
    assert (c_use_dsp48 = 0) or (c_out_width < 48) or (c_family = "virtex5")
      report error_string & "ERROR DSP48 cannot form wide accumulator for family virtex4"
      severity failure;
    assert (c_has_add = 1) = (enum_c_add_mode = MODE_ADDSUB)
      report error_string & " Add pin is required if and only if c_add_mode = c_add_sub"
      severity failure;
    assert c_b_width <= c_out_width
                        report error_string & " Port B cannot be wider than output"
                        severity failure;
    assert enum_c_b_type = NUM_SIGNED or (c_has_ovfl = 0 and c_has_q_ovfl = 0)
      report error_string & " Overflow outputs are only supported     when the accumulator output is signed"
      severity failure;
    assert enum_c_b_type = NUM_UNSIGNED or (c_has_c_out = 0 and c_has_q_c_out = 0
                                            and c_has_b_out = 0 and c_has_q_b_out = 0)
      report error_string & " Carry/borrow outputs are only supported when the accumulator output is unsigned"
      severity failure;
    assert c_has_c_in = 0 or enum_c_add_mode /= MODE_SUB
      report error_string & " c_in (carry in) is prohibited for subtractor-based accumulators; perhaps you wanted b_in?"
      severity failure;
    assert (c_has_c_out = 0 and c_has_q_c_out = 0) or enum_c_add_mode /= MODE_SUB
      report error_string & " Carry out (c_out or q_c_out) is prohibited for subtractor-based accumulators; perhaps you wanted borrow out (b_out or q_b_out)?"
      severity failure;
    assert c_has_b_in = 0 or enum_c_add_mode = MODE_SUB
      report error_string & " b_in (borrow in) is prohibited unless c_add_mode = c_sub; perhaps you wanted c_in?"
      severity failure;
    assert (c_has_b_out = 0 and c_has_q_b_out = 0) or enum_c_add_mode = MODE_SUB
      report error_string & " Borrow out (b_out or q_b_out) is prohibited unless c_add_mode = c_sub; perhaps you wanted carry out (c_out or q_c_out)?"
      severity failure;
    if c_verbosity > 0 then
      if c_scale /= 0 and c_b_width < c_out_width then
        -- The adder at the centre has bit growth, so carry out/borrow out/overflow are
        -- all a bit pointless. Warn the user about this.
        -- deal with overflow
        assert c_has_ovfl = 0 AND c_has_q_ovfl = 0
          report warn_string & " Overflow will never occur in this accumulator"
          severity warning;
        -- deal with carry and borrow out
        if enum_c_add_mode = MODE_ADD then
          assert c_has_c_out = 0 AND c_has_q_c_out = 0
            report warn_string & " Carry out will never be active for this accumulator"
            severity warning;
        elsif enum_c_add_mode = MODE_SUB then
          assert c_has_b_out = 0 AND c_has_q_b_out = 0
            report warn_string & " Borrow out outputs are redundant; they will always equal the MSB of the output"
            severity warning;
        elsif enum_c_add_mode = MODE_ADDSUB then
          -- slightly more complex; since the ADD pin is another bit of input to the ADDSUB
          if c_b_width < c_out_width - 1 then
            assert c_has_c_out = 0 AND c_has_q_c_out = 0
              report warn_string & " c_out is redundant; in ADD mode, it will always be 0, and in SUB mode, it will always equal the MSB of the output"
              severity warning;
          end if;
        end if;
      end if;
    end if;
    assert c_pipe_stages = 1 OR c_pipe_stages = 0 -- since the default value seems to be 0
      report error_string & " Pipelining not implemented."
      severity failure;
    assert c_has_ainit = 0 OR (c_has_aclr = 0 AND c_has_aset = 0)
      report error_string & " ainit is mutually exclusive with aclr or aset"
      severity failure;
    assert c_has_sinit = 0 OR (c_has_sclr = 0 AND c_has_sset = 0)
      report error_string & " sinit is mutually exclusive with sclr or sset"
      severity failure;
    return 0;
  end fn_c_accum_v11_0_legacy_check_generics;

end package body c_accum_pkg_v11_0;

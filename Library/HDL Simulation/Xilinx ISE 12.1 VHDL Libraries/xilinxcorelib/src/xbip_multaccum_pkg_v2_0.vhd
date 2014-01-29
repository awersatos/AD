---------------------------------------------------------------------------
-- $Id: xbip_multaccum_pkg_v2_0.vhd,v 1.4 2009/12/04 11:46:45 akennedy Exp $
---------------------------------------------------------------------------
--
--  (c) Copyright 2009 Xilinx, Inc. All rights reserved.
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
library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;

library xilinxcorelib;
use xilinxcorelib.xbip_accum_v2_0_pkg.all;

library xilinxcorelib;
use xilinxcorelib.mult_gen_pkg_v11_0.all;

package xbip_multaccum_pkg_v2_0 is

  type t_xbip_multaccum_v2_0_latency is record
                                          total_latency : integer;
                                          mult_latency  : integer;
                                          accum_latency : integer;
                                        end record;

  type t_xbip_multaccum_v2_0_resources is record
                                            dsp48   : integer;
                                            bram18k : integer;
                                            luts    : integer;
                                            ffs     : integer;
                                          end record;

  function fn_check_generics_xbip_multaccum_v2_0(
    C_VERBOSITY         : integer;
    C_XDEVICEFAMILY     : string;
    C_USE_DSP48         : integer;
    C_LATENCY           : integer;
    C_ACCUM_WIDTH       : integer;
    C_A_WIDTH           : integer;
    C_B_WIDTH           : integer;
    C_A_TYPE            : integer;
    C_B_TYPE            : integer;
    C_OUT_WIDTH         : integer;
    C_ROUND_TYPE        : integer;
    C_HAS_BYPASS        : integer;
    C_BYPASS_LOW        : integer;
    C_ACCUM_MODE        : integer;
    C_CE_OVERRIDES_SCLR : integer
    ) return integer;

  function fn_xbip_multaccum_v2_0_latency(
    P_VERBOSITY         : integer;
    P_XDEVICEFAMILY     : string;
    P_USE_DSP48         : integer;
    P_LATENCY           : integer;
    P_ACCUM_WIDTH       : integer;
    P_A_WIDTH           : integer;
    P_B_WIDTH           : integer;
    P_A_TYPE            : integer;
    P_B_TYPE            : integer;
    P_OUT_WIDTH         : integer;
    P_ROUND_TYPE        : integer;
    P_HAS_BYPASS        : integer;
    P_BYPASS_LOW        : integer;
    P_ACCUM_MODE        : integer;
    P_CE_OVERRIDES_SCLR : integer
    ) return t_xbip_multaccum_v2_0_latency;

  function fn_xbip_multaccum_v2_0_resources(
    P_VERBOSITY         : integer;
    P_XDEVICEFAMILY     : string;
    P_USE_DSP48         : integer;
    P_LATENCY           : integer;
    P_ACCUM_WIDTH       : integer;
    P_A_WIDTH           : integer;
    P_B_WIDTH           : integer;
    P_A_TYPE            : integer;
    P_B_TYPE            : integer;
    P_OUT_WIDTH         : integer;
    P_ROUND_TYPE        : integer;
    P_HAS_BYPASS        : integer;
    P_BYPASS_LOW        : integer;
    P_ACCUM_MODE        : integer;
    P_CE_OVERRIDES_SCLR : integer
    ) return t_xbip_multaccum_v2_0_resources;

  function fn_multaccum_dsp_latency(
    P_VERBOSITY     : integer;
    P_XDEVICEFAMILY : string;
    P_LATENCY       : integer;
    P_ACCUM_WIDTH   : integer;
    P_A_WIDTH       : integer;
    P_B_WIDTH       : integer;
    P_OUT_WIDTH     : integer;
    P_ROUND_TYPE    : integer;
    P_HAS_BYPASS    : integer;
    P_ACCUM_MODE    : integer
    ) return t_xbip_multaccum_v2_0_latency;

  function multacc_support(
    p_xdevicefamily : string;
    p_use_dsp48     : integer
    ) return integer;

  function fn_mac_config_v2_0(
    p_xdevicefamily : string;
    p_latency       : integer;
    p_a_width       : integer;
    p_b_width       : integer;
    p_accum_width   : integer;
    p_has_bypass    : integer
    ) return integer;

  function calc_accum_width(
    C_A_WIDTH           : integer;
    C_A_TYPE            : integer;
    C_B_WIDTH           : integer;
    C_B_TYPE            : integer;
    C_NUM_OF_MAC_CYCLES : integer
    ) return integer;

  function fn_multaccum_switch_to_dsp(
    p_accum_width : integer
    ) return integer;

end package xbip_multaccum_pkg_v2_0;

package body xbip_multaccum_pkg_v2_0 is

  -- Checks the validity of the generics
  function fn_check_generics_xbip_multaccum_v2_0(
    C_VERBOSITY         : integer;
    C_XDEVICEFAMILY     : string;
    C_USE_DSP48         : integer;
    C_LATENCY           : integer;
    C_ACCUM_WIDTH       : integer;
    C_A_WIDTH           : integer;
    C_B_WIDTH           : integer;
    C_A_TYPE            : integer;
    C_B_TYPE            : integer;
    C_OUT_WIDTH         : integer;
    C_ROUND_TYPE        : integer;
    C_HAS_BYPASS        : integer;
    C_BYPASS_LOW        : integer;
    C_ACCUM_MODE        : integer;
    C_CE_OVERRIDES_SCLR : integer
    ) return integer is

    constant error_string    : string  := "ERROR : xbip_multaccum_v2_0 : ";
    constant warn_string     : string  := "WARNING : xbip_multaccum_v2_0 : ";
    constant min_accum_width : integer := C_A_WIDTH + C_B_WIDTH + C_A_TYPE + C_B_TYPE;
  begin

    if C_VERBOSITY /= 0 and C_VERBOSITY /= 1 and C_VERBOSITY /= 2 then
      report warn_string & "C_VERBOSITY valid range is 0 to 2. Setting to 2. Current value is " & integer'image(C_VERBOSITY) severity warning;
    end if;

    assert C_USE_DSP48 = 1
      report error_string & "C_USE_DSP48 valid range 1. Current value is " & integer'image(C_USE_DSP48) severity error;

    assert C_XDEVICEFAMILY /= "NO_FAMILY"
      report error_string & "C_XDEVICEFAMILY has not been correctly set (perhaps by CORE Generator)" severity error;

    assert C_A_TYPE = 0 or C_A_TYPE = 1
      report error_string & "C_A_TYPE valid range is 0 to 1. Current value is " & integer'image(C_A_TYPE) severity error;

    assert C_B_TYPE = 0 or C_B_TYPE = 1
      report error_string & "C_B_TYPE valid range is 0 to 1. Current value is " & integer'image(C_B_TYPE) severity error;

    assert C_CE_OVERRIDES_SCLR = 0 or C_CE_OVERRIDES_SCLR = 1
      report error_string & "C_CE_OVERRIDES_SCLR valid range is 0 to 1. Current value is " & integer'image(C_CE_OVERRIDES_SCLR) severity error;

    assert C_ACCUM_MODE = 0 or C_ACCUM_MODE = 1 or C_ACCUM_MODE = 2
      report error_string & "C_ACCUM_MODE valid range is 0 to 2. Current value is " & integer'image(C_ACCUM_MODE) severity error;

    assert C_HAS_BYPASS = 0 or C_HAS_BYPASS = 1
      report error_string & "C_HAS_BYPASS valid range is 0 to 1. Current value is " & integer'image(C_HAS_BYPASS) severity error;

    assert C_LATENCY = 1 or C_LATENCY = -1
      report error_string & "C_LATENCY valid values of -1 and 1. Current value is " & integer'image(C_LATENCY) severity error;

    assert C_BYPASS_LOW = 0 or C_BYPASS_LOW = 1
      report error_string & "C_BYPASS_LOW valid range is 0 to 1. Current value is " & integer'image(C_BYPASS_LOW) severity error;

    assert C_ROUND_TYPE = 0
      report error_string & "C_ROUND_TYPE valid range 0. Only truncation is available. Current value is " & integer'image(C_ROUND_TYPE) severity error;


    assert C_A_WIDTH > 0 and C_B_WIDTH <= 32
                                          report error_string & "Invalid value for C_A_WIDTH; must be in the range 1..32. Current value is " & integer'image(C_A_WIDTH) severity error;

    assert C_B_WIDTH > 0 and C_B_WIDTH <= 32
                                          report error_string & "Invalid value for C_B_WIDTH; must be in the range 1..32. Current value is " & integer'image(C_B_WIDTH) severity error;

    assert C_ACCUM_WIDTH >= min_accum_width and C_ACCUM_WIDTH <= 80
                                                                 report error_string & "Invalid value for C_ACCUM_WIDTH; must be in the range " & integer'image(min_accum_width) & "..80. Current value is " & integer'image(C_ACCUM_WIDTH) severity error;

    assert C_OUT_WIDTH >= 2 and C_OUT_WIDTH <= C_ACCUM_WIDTH
                                               report error_string & "Invalid value for C_OUT_WIDTH; must be in the range 2.." & integer'image(C_ACCUM_WIDTH) & ". Current value is " & integer'image(C_OUT_WIDTH) severity error;

    return 0;
  end function fn_check_generics_xbip_multaccum_v2_0;

  -- Calculates the resources (DSP48, LUTs, FFs, BRAM18ks) utilized in the core
  function fn_xbip_multaccum_v2_0_resources(
    P_VERBOSITY         : integer;
    P_XDEVICEFAMILY     : string;
    P_USE_DSP48         : integer;
    P_LATENCY           : integer;
    P_ACCUM_WIDTH       : integer;
    P_A_WIDTH           : integer;
    P_B_WIDTH           : integer;
    P_A_TYPE            : integer;
    P_B_TYPE            : integer;
    P_OUT_WIDTH         : integer;
    P_ROUND_TYPE        : integer;
    P_HAS_BYPASS        : integer;
    P_BYPASS_LOW        : integer;
    P_ACCUM_MODE        : integer;
    P_CE_OVERRIDES_SCLR : integer
    ) return t_xbip_multaccum_v2_0_resources is

    variable return_val    : t_xbip_multaccum_v2_0_resources;
    constant r_a_width     : integer := P_A_WIDTH + P_A_TYPE;
    constant r_b_width     : integer := P_B_WIDTH + P_B_TYPE;
    constant r_accum_width : integer := P_ACCUM_WIDTH + P_A_TYPE + P_B_TYPE;

    constant macc_latencies : t_xbip_multaccum_v2_0_latency := fn_xbip_multaccum_v2_0_latency(
      P_VERBOSITY         => P_VERBOSITY,
      P_XDEVICEFAMILY     => P_XDEVICEFAMILY,
      P_USE_DSP48         => P_USE_DSP48,
      P_LATENCY           => P_LATENCY,
      P_ACCUM_WIDTH       => P_ACCUM_WIDTH,
      P_A_WIDTH           => P_A_WIDTH,
      P_B_WIDTH           => P_B_WIDTH,
      P_A_TYPE            => P_A_TYPE,
      P_B_TYPE            => P_B_TYPE,
      P_OUT_WIDTH         => P_OUT_WIDTH,
      P_ROUND_TYPE        => P_ROUND_TYPE,
      P_HAS_BYPASS        => P_HAS_BYPASS,
      P_BYPASS_LOW        => P_BYPASS_LOW,
      P_ACCUM_MODE        => P_ACCUM_MODE,
      P_CE_OVERRIDES_SCLR => P_CE_OVERRIDES_SCLR
      );

    constant mult_latency     : integer := macc_latencies.mult_latency;
    constant accum_latency    : integer := macc_latencies.accum_latency;
    constant use_dsp_on_accum : integer := fn_multaccum_switch_to_dsp(
      p_accum_width => r_accum_width
      );


--    constant mult_resources : r_mult_resources := mult_gen_v11_0_gui_resources(
--      family          => p_xdevicefamily,
--      c_a_width       => r_a_width,
--      c_a_type        => 0,
--      c_b_width       => r_b_width,
--      c_b_type        => 0,
--      c_mult_type     => EMBEDDED_MULT,
--      c_optimize_goal => CORE_SPEED,
--      c_latency       => mult_latency,
--      c_ccm_imp       => 0,
--      c_b_value       => "000");

--    constant accum_resources : t_xbip_accum_v2_0_resources := fn_xbip_accum_v2_0_get_resources(
--      p_xdevicefamily     => p_XDEVICEFAMILY,
--      p_use_dsp48         => use_dsp_on_accum,
--      p_verbosity         => p_VERBOSITY,
--      p_latency           => accum_latency,
--      p_bypass_low        => p_BYPASS_LOW,
--      p_b_width           => p_B_WIDTH,
--      p_out_width         => p_OUT_WIDTH,
--      p_ce_overrides_sclr => p_CE_OVERRIDES_SCLR,
--      p_data_type         => p_B_TYPE,
--      p_has_bypass        => p_has_bypass,
--      p_add_mode          => 2
--      );

    variable mult_resources : r_mult_resources;
    variable accum_resources : t_xbip_accum_v2_0_resources;

    constant macc_config : integer := fn_mac_config_v2_0(
      p_xdevicefamily => p_xdevicefamily,
      p_latency       => p_latency,
      p_a_width       => r_a_width,
      p_b_width       => r_b_width,
      p_accum_width   => r_accum_width,
      p_has_bypass    => P_HAS_BYPASS
      );

  begin
    if macc_config = 1 then
      return_val.dsp48   := 1;
      return_val.bram18k := 0;
      return_val.luts    := 0;
      return_val.ffs     := 0;
    elsif macc_config = 2 then
      return_val.dsp48   := 2;
      return_val.bram18k := 0;
      return_val.luts    := 0;
      return_val.ffs     := 48;
    else                                -- macc_config=3
      mult_resources := mult_gen_v11_0_gui_resources(
        family          => p_xdevicefamily,
        c_a_width       => r_a_width,
        c_a_type        => 0,
        c_b_width       => r_b_width,
        c_b_type        => 0,
        c_mult_type     => EMBEDDED_MULT,
        c_optimize_goal => CORE_SPEED,
        c_latency       => mult_latency,
        c_ccm_imp       => 0,
        c_b_value       => "000");
      accum_resources := fn_xbip_accum_v2_0_get_resources(
        p_xdevicefamily     => p_XDEVICEFAMILY,
        p_use_dsp48         => use_dsp_on_accum,
        p_verbosity         => p_VERBOSITY,
        p_latency           => accum_latency,
        p_bypass_low        => p_BYPASS_LOW,
        p_b_width           => p_B_WIDTH,
        p_out_width         => p_OUT_WIDTH,
        p_ce_overrides_sclr => p_CE_OVERRIDES_SCLR,
        p_data_type         => p_B_TYPE,
        p_has_bypass        => p_has_bypass,
        p_add_mode          => 2
        );
      return_val.dsp48   := accum_resources.dsp48 + mult_resources.DSPs;
      return_val.bram18k := 0;
      return_val.luts    := accum_resources.luts + mult_resources.luts;
      return_val.ffs     := accum_resources.ffs;  --  + mult_resources.luts;    
    end if;
    return return_val;
  end fn_xbip_multaccum_v2_0_resources;

  -- Calculates the latency of the core and returns 3 values: total latency, mult latency and accum latency.
  -- See the multaccum latency calculation below for details. 
  function fn_xbip_multaccum_v2_0_latency(
    P_VERBOSITY         : integer;
    P_XDEVICEFAMILY     : string;
    P_USE_DSP48         : integer;
    P_LATENCY           : integer;
    P_ACCUM_WIDTH       : integer;
    P_A_WIDTH           : integer;
    P_B_WIDTH           : integer;
    P_A_TYPE            : integer;
    P_B_TYPE            : integer;
    P_OUT_WIDTH         : integer;
    P_ROUND_TYPE        : integer;
    P_HAS_BYPASS        : integer;
    P_BYPASS_LOW        : integer;
    P_ACCUM_MODE        : integer;
    P_CE_OVERRIDES_SCLR : integer
    ) return t_xbip_multaccum_v2_0_latency is

    variable return_val    : t_xbip_multaccum_v2_0_latency;
    constant r_a_width     : integer := P_A_WIDTH + P_A_TYPE;
    constant r_b_width     : integer := P_B_WIDTH + P_B_TYPE;
    constant r_accum_width : integer := P_ACCUM_WIDTH + P_A_TYPE + P_B_TYPE;
  begin
    return_val                       := fn_multaccum_dsp_latency(
      p_verbosity     => p_verbosity,
      p_xdevicefamily => p_xdevicefamily,
      p_latency       => p_latency,
      p_accum_width   => r_accum_width,
      p_a_width       => r_a_width,
      p_b_width       => r_b_width,
      p_out_width     => p_out_width,
      p_round_type    => p_round_type,
      p_accum_mode    => p_accum_mode,
      p_has_bypass    => p_has_bypass
      );
    return return_val;
  end fn_xbip_multaccum_v2_0_latency;

  -- Calculates latency for multaccum_dsp entity
  function fn_multaccum_dsp_latency(
    P_VERBOSITY     : integer;
    P_XDEVICEFAMILY : string;
    P_LATENCY       : integer;
    P_ACCUM_WIDTH   : integer;
    P_A_WIDTH       : integer;
    P_B_WIDTH       : integer;
    P_OUT_WIDTH     : integer;
    P_ROUND_TYPE    : integer;
    P_HAS_BYPASS    : integer;
    P_ACCUM_MODE    : integer
    ) return t_xbip_multaccum_v2_0_latency is

    variable return_val  : t_xbip_multaccum_v2_0_latency;
    constant macc_config : integer := fn_mac_config_v2_0(
      p_xdevicefamily => p_xdevicefamily,
      p_latency       => p_latency,
      p_a_width       => p_a_width,
      p_b_width       => p_b_width,
      p_accum_width   => p_accum_width,
      p_has_bypass    => p_has_bypass
      );
    constant mult_lat    : integer := mult_gen_v11_0_calc_fully_pipelined_latency_internal (
      family          => p_xdevicefamily,
      a_width         => p_a_width,
      a_type          => 0,
      b_width         => p_b_width,
      b_type          => 0,
      mult_type       => EMBEDDED_MULT,
      opt_goal        => CORE_SPEED,
      ccm_imp         => 0,
      b_value         => "000",
      standalone      => 1
      );
    variable accum_lat   : integer := 0;
  begin
    return_val.total_latency       := 0;
    return_val.mult_latency        := 0;
    return_val.accum_latency       := 0;

    if (P_LATENCY = 1) then
      -- With a latency of 1, the only delay is the accum reg.
      return_val.total_latency   := 1;
      return_val.mult_latency    := 0;
      return_val.accum_latency   := 1;
    elsif (P_LATENCY = -1) then
      -- With latency = -1 then the configuration must be determined to know the latencies
      if (macc_config = 1) then
        -- This respresents a single DSP48 for all families; the DSP48 has input regs (A/B reg), mult reg (M reg) and accum reg (P reg)
        return_val.total_latency := 3;
        return_val.mult_latency  := 0;
        return_val.accum_latency := 0;
      elsif (macc_config = 2) then
        -- this represents the MACC extend mode of V5-like families; 2 DSP48 implementations (1 for mult-acc, 1 for extended accum)
        return_val.total_latency := 4;
        return_val.mult_latency  := 0;
        return_val.accum_latency := 0;
      else                              -- if (macc_config = 2) then
        -- this represents a seperate multiplier and accumulator being used; the mult will be implemented using DSP48s (multgen)
        if (p_accum_width <= ci_dsp48_p_width) then
          -- The accum will be created using a single DSP48
          -- and use an input reg and a accumreg
          accum_lat              := 2;
        else
          -- The accum will be created using fabric and calls the xbip_accum. An input reg and accum reg are used.
          accum_lat              := 2;
        end if;
        return_val.mult_latency  := mult_lat;
        return_val.accum_latency := accum_lat;
        return_val.total_latency := mult_lat + accum_lat;
      end if;
    else
      -- this would be for user selected latencies other than above
      -- not yet supported 
    end if;
    return return_val;

  end function fn_multaccum_dsp_latency;


  -- Function to determine the configuration of the multaccum
  -- Return of 1: single dsp48 all families,
  --           2: macc extend mode of V5 (dsp48e*)
  --           3: call to multgen and xbip_accum
  function fn_mac_config_v2_0(
    p_xdevicefamily                            : string;
    p_latency                                  : integer;
    p_a_width                                  : integer;
    p_b_width                                  : integer;
    p_accum_width                              : integer;
    p_has_bypass                               : integer
    ) return integer is
    variable return_val                        : integer := 0;
    variable max_val                           : integer := 0;
    variable min_val                           : integer := 0;
  begin
    if ((supports_dsp48(p_xdevicefamily) = 1) or (supports_dsp48a(p_xdevicefamily) > 0)) then
      if (p_a_width  <= ci_dsp48_a_width) and (p_b_width <= ci_dsp48_b_width) and (p_accum_width <= ci_dsp48_p_width) then
        return_val                                       := 1;
      else
        return_val                                       := 3;
      end if;
    elsif (supports_dsp48e(p_xdevicefamily) > 0) then
      max_val                                            := p_a_width;
      min_val                                            := p_b_width;
      if (p_b_width > p_a_width) then
        max_val                                          := p_b_width;
        min_val                                          := p_a_width;
      end if;
      if (max_val    <= ci_dsp48e_amult_width) and (min_val <= ci_dsp48_b_width) and (p_accum_width <= ci_dsp48_p_width) then
        return_val                                       := 1;
      elsif (max_val <= ci_dsp48e_amult_width) and (min_val <= ci_dsp48_b_width) and (p_accum_width <= 2*ci_dsp48_p_width) and (p_has_bypass = 0) then
        -- mac extend mode cannot support bypass mode
        return_val                                       := 2;
      else
        return_val                                       := 3;
      end if;
      -- If latency is specified to be 1 when a config of 2 (return_val = 2); we must change this to return_val=3;  Cannot have a macc-extend mode with latency=1
      if (return_val = 2) and (p_latency = 1) then
        return_val                                       := 3;
      end if;
    else
      return_val                                         := 0;
      assert false report "xbip_multaccum_v2_0 : No DSP48 support for this configuration" severity error;
    end if;
    return return_val;
  end fn_mac_config_v2_0;

  -- Function to determine if the there is support for a DSP48 implementation of the mac
  function multacc_support(
    p_xdevicefamily : string;
    p_use_dsp48     : integer
    ) return integer is
  begin
    if ((supports_dsp48(p_xdevicefamily) > 0) or (supports_dsp48e(p_xdevicefamily) > 0) or (supports_dsp48a(p_xdevicefamily) > 0)) then
      return p_use_dsp48;
    else
      return 0;
    end if;
  end multacc_support;

  function calc_accum_width(
    C_A_WIDTH : integer;
    C_A_TYPE : integer;
    C_B_WIDTH : integer;
    C_B_TYPE : integer;
    C_NUM_OF_MAC_CYCLES : integer
    ) return integer is
  begin
    return log2roundup(C_NUM_OF_MAC_CYCLES)+C_A_WIDTH+C_A_TYPE+C_B_WIDTH+C_B_TYPE;
  end calc_accum_width;

  function fn_multaccum_switch_to_dsp(
    p_accum_width : integer
    ) return integer is
  begin
    if p_accum_width > ci_dsp48_p_width then
      return 0;
    else
      return 1;
    end if;
  end fn_multaccum_switch_to_dsp;


end package body xbip_multaccum_pkg_v2_0;

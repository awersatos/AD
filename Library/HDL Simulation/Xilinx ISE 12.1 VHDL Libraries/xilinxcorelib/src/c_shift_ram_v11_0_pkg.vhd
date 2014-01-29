-- $RCSfile: c_shift_ram_v11_0_pkg.vhd,v $ $Revision: 1.4 $ $Date: 2009/12/04 11:46:42 $
--  (c) Copyright 2007, 2009 Xilinx, Inc. All rights reserved.
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
use ieee.numeric_std.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;

package c_shift_ram_v11_0_pkg is


  -----------------------------------------------------------------------------
  -- Independent Types (not based on generics or generic-derived constants)
  -----------------------------------------------------------------------------

  -- Enumerated type to describe which type of primitive we are trying to initialise
  type T_PRIM is (SRL16, SRL32, REG);


  -----------------------------------------------------------------------------
  -- Function declarations
  -----------------------------------------------------------------------------

  function fn_c_shift_ram_v11_0_check_generics(c_verbosity, c_width, c_depth, c_has_a, c_addr_width, c_opt_goal, c_shift_type, c_reg_last_bit, c_generate_mif                 : integer;
                                               c_has_ainit, c_has_aclr, c_has_aset, c_has_sinit, c_has_sclr, c_has_sset, c_has_ce, c_sync_priority, c_sync_enable, c_read_mif : integer;
                                               srl_depth                                                                                                                      : integer;
                                               c_default_data, c_family                                                                                                       : string) return integer;
  function fn_count_rams(c_depth, c_reg_last_bit, c_shift_type, srl_depth                                                                                                     : integer) return integer;
  function fn_gen_last_reg_addr(c_depth, c_reg_last_bit, srl_depth, srl_addr_width                                                                                            : integer) return std_logic_vector;
  function fn_get_real_depth(depth, shift_type, reg_last_bit, srl_depth                                                                                                       : integer) return integer;
  function fn_get_fixed_depth(depth, c_reg_last_bit, c_has_aclr, c_has_aset, c_has_ainit, c_has_sclr, c_has_sset, c_has_sinit                                                 : integer) return integer;
  function fn_check_reg_ctrls(c_has_sclr, c_has_sset, c_has_sinit, c_has_aclr, c_has_aset, c_has_ainit, c_reg_last_bit                                                        : integer) return integer;
  function fn_get_srl_depth (family                                                                                                                                           : string) return integer;
  function fn_get_srl_addr_width(family                                                                                                                                       : string) return integer;
  function get_chain_depth(depth, srl_depth                                                                                                                                   : integer) return integer;
  function fn_get_depth_from_mode(inferred_sr_depth, real_depth, shift_type                                                                                                   : integer) return integer;
  function fn_get_srl_prim(family                                                                                                                                             : string) return T_PRIM;
  function check_mixed_reg_ctrls(c_has_aclr, c_has_aset, c_has_sclr, c_has_sset, c_has_ainit, c_has_sinit, c_reg_last_bit                                                     : integer) return boolean;
  function use_keep (shift_type, opt_goal                                                                                                                                     : integer; mixed_reg_ctrls : boolean) return string;
  function fn_get_pipe_ff_pos(fam                                                                                                                                             : string) return integer;
  function fn_get_addr (family                                                                                                                                                : string; ctrls_used : integer; last_srl_addr : std_logic_vector; last_srl_addr_minus_one : std_logic_vector; srl_addr_width : integer) return std_logic_vector;
  function get_addr_space(depth                                                                                                                                               : integer) return integer;
  function use_output_register (reg_last_bit, shift_type, opt_goal, depth, ff_controls_used, srl_depth                                                                        : integer) return boolean;

end package c_shift_ram_v11_0_pkg;

-------------------------------------------------------------------------------

package body c_shift_ram_v11_0_pkg is


  -- purpose: verifies that the supplied generics are legal for the core
  function fn_c_shift_ram_v11_0_check_generics(c_verbosity, c_width, c_depth, c_has_a, c_addr_width, c_opt_goal, c_shift_type, c_reg_last_bit, c_generate_mif                 : integer;
                                               c_has_ainit, c_has_aclr, c_has_aset, c_has_sinit, c_has_sclr, c_has_sset, c_has_ce, c_sync_priority, c_sync_enable, c_read_mif : integer;
                                               srl_depth                                                                                                                      : integer;
                                               c_default_data, c_family                                                                                                       : string)
    return integer is

    constant error_string :  string := "ERROR: c_shift_ram_v11_0_legacy : ";
    constant warn_string :  string := "WARNING: c_shift_ram_v11_0_legacy : ";
    constant note_string :  string := "NOTE: c_shift_ram_v11_0_legacy : ";
 
  begin

    -- No need to check family support; XCD limits what families can be used
    --WLM ASSERT c_family = "spartan3" OR c_family = "virtex4" OR c_family = "virtex5" OR c_family = "spartan6" or c_family = "virtex6"
    --WLM REPORT "ERROR: c_shift_ram_v11_0_legacy: Valid c_family values are (case-sensitive): spartan3, spartan6, virtex4, virtex5, virtex6"
    --WLM SEVERITY error;

    -- Ensure generic values are sensible
    assert c_shift_type = 0 or c_shift_type = 1
      report error_string & "Invalid c_shift_type value found - must be c_fixed(0), c_variable_lossless(1)"
      severity failure;
    assert c_opt_goal = c_area or c_opt_goal = c_speed report error_string & "Invalid c_opt_goal value found - must be 0 or 1" severity failure;
    assert c_has_a = 0 or c_has_a = 1 report error_string & "Invalid c_has_a value found - must be 0 or 1" severity failure;
    assert c_has_ce = 0 or c_has_ce = 1 report error_string & "Invalid c_has_ce value found - must be 0 or 1" severity failure;
    assert c_reg_last_bit = 0 or c_reg_last_bit = 1 report error_string & "Invalid c_reg_last_bit value found - must be 0 or 1" severity failure;
    assert c_sync_priority = 0 or c_sync_priority = 1 report error_string & "Invalid c_sync_priority value found - must be 0 or 1" severity failure;
    assert c_sync_enable = 0 or c_sync_enable = 1 report error_string & "Invalid c_sync_enable value found - must be 0 or 1" severity failure;
    assert c_has_aclr = 0 or c_has_aclr = 1 report error_string & "Invalid c_has_aclr value found - must be 0 or 1" severity failure;
    assert c_has_aset = 0 or c_has_aset = 1 report error_string & "Invalid c_has_aset value found - must be 0 or 1" severity failure;
    assert c_has_ainit = 0 or c_has_ainit = 1 report error_string & "Invalid c_has_ainit value found - must be 0 or 1" severity failure;
    assert c_has_sclr = 0 or c_has_sclr = 1 report error_string & "Invalid c_has_sclr value found - must be 0 or 1" severity failure;
    assert c_has_sset = 0 or c_has_sset = 1 report error_string & "Invalid c_has_sset value found - must be 0 or 1" severity failure;
    assert c_has_sinit = 0 or c_has_sinit = 1 report error_string & "Invalid c_has_sinit value found - must be 0 or 1" severity failure;
    assert c_read_mif = 0 or c_read_mif = 1 report error_string & "Invalid c_read_mif value found - must be 0 or 1" severity failure;
    assert c_generate_mif = 0 report warn_string & "Writing of .mif files is not supported in this core version" severity warning;

    assert c_width > 0 and c_width < 257 report error_string & "Invalid width value - the valid range is 1 to 256 inclusive" severity failure;

    if c_reg_last_bit = 0 then
      if c_verbosity > 0 then
        assert c_has_ainit = 0 and c_has_aclr = 0 and c_has_aset = 0 report warn_string & "Asynchronous controls not available without registered output" severity warning;
        assert c_has_sinit = 0 and c_has_sclr = 0 and c_has_sset = 0 report warn_string & "Synchronous controls not available without registered output" severity warning;
      end if;
    else                                -- c_reg_last_bit /= 0
      assert c_has_ainit = 0 or (c_has_aclr = 0 and c_has_aset = 0)
        report error_string & "ASET and/or ACLR cannot exist in conjunction with AINIT"
        severity failure;
      assert c_has_sinit = 0 or (c_has_sclr = 0 and c_has_sset = 0)
        report error_string & "SSET and/or SCLR cannot exist in conjunction with SINIT"
        severity failure;
    end if;

    if c_verbosity > 0 then
      assert not((c_has_ainit /= 0 or c_has_aclr /= 0 or c_has_aset /= 0) and (c_has_sinit /= 0 or c_has_sclr /= 0 or c_has_sset /= 0) and c_reg_last_bit /= 0)
        report warn_string & "Including both asynchronous (aclr, aset or ainit) AND synchronous controls " &
        "(sclr, sset or sinit) will add a layer of logic and impact performance"
        severity warning;
    end if;

    if c_verbosity > 1 then
      assert not(c_opt_goal = c_speed and not(c_shift_type = c_fixed)) report note_string & "Optimising for speed" severity note;
      assert not(c_opt_goal = c_speed and (c_has_aclr /= 0 or c_has_aset /= 0 or c_has_ainit /= 0 or c_has_sclr /= 0 or c_has_sset /= 0 or c_has_sinit /= 0) and c_reg_last_bit /= 0 and c_shift_type = c_variable_lossless)
        report note_string & "Register controls will only be implemented on the output register and not on pipeline registers" severity note;
      assert not(c_opt_goal = c_speed and c_has_ce /= 0 and c_shift_type = c_variable_lossless) report note_string & "CE controls will be implemented on all pipeline registers in addition to the output register, if selected" severity note;

      assert not(c_opt_goal = c_area and not(c_shift_type = c_fixed)) report note_string & "Optimising for area" severity note;
    end if;

    if c_shift_type = c_fixed then
      if c_verbosity > 0 then
        assert c_has_a = 0 report warn_string & "Address bus not required for fixed-length shift register" severity warning;
      end if;
      if c_depth /= 0 and not(c_depth = 1 and c_reg_last_bit = 1) then
        if c_reg_last_bit /= 0 then
          assert c_depth > 1 and c_depth < 1090 report error_string & "Invalid RAM depth value for registered output - the valid range is 2 to 1089 inclusive" severity failure;
        else
          assert c_depth > 0 and c_depth < 1089 report error_string & "Invalid RAM depth value - the valid range is 1 to 1088 inclusive" severity failure;
        end if;
      end if;
    end if;

    if c_shift_type = c_variable_lossless then
      assert c_has_a /= 0 report error_string & "Variable-length register must have an address bus input" severity failure;

      assert c_addr_width > 0 report error_string & "c_addr_width must be at least 1 bit wide" severity failure;

      -- V9.1 UPDATE
      -- Just use warnings rather than errors for these depths - this provides backwards-compatability for users who previously just set the address width
      -- to be 4 for all depths <= 16
      if c_depth                      <= 2 then
        if c_verbosity > 0 then
          assert c_addr_width = 1 report warn_string & "Address bus should be 1 for this memory depth - only bits (0 downto 0) will be used" severity warning;
        end if;
      elsif c_depth > 2 and c_depth   <= 4 then
        if c_verbosity > 0 then
          assert c_addr_width = 2 report warn_string & "Address bus should be 2 for this memory depth - only bits (1 downto 0) will be used" severity warning;
        end if;
      elsif c_depth > 4 and c_depth   <= 8 then
        if c_verbosity > 0 then
          assert c_addr_width = 3 report warn_string & "Address bus should be 3 for this memory depth - only bits (2 downto 0) will be used" severity warning;
        end if;
      elsif c_depth > 8 and c_depth   <= 16 then
        if c_verbosity > 0 then
          assert c_addr_width = 4 report warn_string & "Address bus should be 4 for this memory depth - only bits (3 downto 0) will be used" severity warning;
        end if;
      elsif c_depth > 16 and c_depth  <= 32 then
        assert c_addr_width = 5 report error_string & "Address bus width should be 5 for this memory depth" severity failure;
      elsif c_depth > 32 and c_depth  <= 64 then
        assert c_addr_width = 6 report error_string & "Address bus width should be 6 for this memory depth" severity failure;
      elsif c_depth > 64 and c_depth  <= 128 then
        assert c_addr_width = 7 report error_string & "Address bus width should be 7 for this memory depth" severity failure;
      elsif c_depth > 128 and c_depth <= 256 then
        assert c_addr_width = 8 report error_string & "Address bus width should be 8 for this memory depth" severity failure;
      elsif c_depth > 256 and c_depth <= 512 then
        assert c_addr_width = 9 report error_string & "Address bus width should be 9 for this memory depth" severity failure;
      elsif c_depth > 512 and c_depth <= 1024 then
        assert c_addr_width = 10 report error_string & "Address bus width should be 10 for this memory depth" severity failure;
      end if;

      case c_reg_last_bit is
        when 0            =>
          if c_shift_type = c_variable_lossless then
            case c_opt_goal is
              when 0      => assert c_depth > 0 and c_depth < 1025
                               report error_string & "Invalid depth value for variable-length RAM - minimum is 1, maximum is 1024" severity failure;  -- area, no reg
              when 1      => assert c_depth > 0 and c_depth < 1025
                               report error_string & "Invalid depth value for variable-length RAM - minimum is 1, maximum is 1024" severity failure;  -- speed, no reg
                             if c_verbosity > 1 then
                               if c_depth > srl_depth and c_depth < (8*srl_depth)+1 then
                                 assert false
                                   report note_string & "The minimum shift register delay will be 2 cycles with no registered output" severity note;
                               end if;
                               if c_depth > 8*srl_depth and c_depth < 1027 then
                                 assert false
                                   report note_string & "Implementing pipelining inside the multiplexer - the minimum shift register delay will be 3 cycles" severity note;
                               end if;
                             end if;
              when others => null;

            end case;
          end if;
        when 1            =>
          if c_shift_type = c_variable_lossless then
            case c_opt_goal is
              when 0      => assert c_depth > 1 and c_depth < 1026
                               report error_string & "Invalid depth value for variable-length RAM - minimum delay selectable is 2, maximum is 1025 due to output register" severity failure;  -- area, reg
              when 1      => assert c_depth > 1 and c_depth < 1026
                               report error_string & "Invalid depth value for variable-length RAM - minimum delay selectable is 2, maximum is 1025 due to output register" severity failure;  -- speed, reg
                             if c_verbosity > 1 then
                               if c_depth > srl_depth and c_depth < (8*srl_depth)+1 then
                                 assert false
                                   report note_string & "The minimum shift register delay will be 3 cycles with a registered output" severity note;
                               end if;
                               if c_depth > (8*srl_depth) and c_depth < 1026 then
                                 assert false
                                   report note_string & "Implementing pipelining inside the multiplexer - the minimum shift register delay will be 4 cycles with a registered output" severity note;
                               end if;
                             end if;
              when others => null;
            end case;
          end if;
        when others       => null;
      end case;
    end if;
    if c_verbosity > 1 then
      report note_string & "completed check generics" severity note;
    end if;
    return 0;
  end fn_c_shift_ram_v11_0_check_generics;


  function fn_count_rams(c_depth, c_reg_last_bit, c_shift_type, srl_depth : integer) return integer is
    variable temp_depth                                                   : integer := c_depth;
    variable count_rams                                                   : integer := 0;
  begin  -- FUNCTION fn_count_rams
    if c_shift_type /= 0 then
      -- The value returned by the function is the total number of SRL16s or SRL32s used in the lossless shift RAM
      while temp_depth > srl_depth-1 loop
        temp_depth                                                                  := temp_depth - srl_depth;
        count_rams                                                                  := count_rams + 1;
      end loop;
      if temp_depth > 0 then
        return count_rams + 1;
      else
        return count_rams;
      end if;
    else
      return count_rams;
    end if;
  end function fn_count_rams;

                                        -- purpose: Calculates the address vector for the final RAM in the chain
  function fn_gen_last_reg_addr(c_depth, c_reg_last_bit, srl_depth, srl_addr_width : integer) return std_logic_vector is
    variable temp_depth                                                            : integer := c_depth;
  begin  -- FUNCTION gen_last_reg_addr
    if temp_depth = 0 or temp_depth = 1 then
      return std_logic_vector(To_unsigned(0, srl_addr_width));
    elsif temp_depth < (srl_depth+1) then
      if c_reg_last_bit = 0 then
        return std_logic_vector(To_unsigned(temp_depth - 1, srl_addr_width));
      else
        return std_logic_vector(To_unsigned(temp_depth - 2, srl_addr_width));
      end if;
    else
      while temp_depth > srl_depth loop
        temp_depth                                                                           := temp_depth - (srl_depth+1);
      end loop;
      if temp_depth > 0 then
        if c_reg_last_bit = 0 then
          return std_logic_vector(To_unsigned(temp_depth - 1, srl_addr_width));
        else
          if temp_depth = 1 then
                                        -- case where we can use a double output register
            return std_logic_vector(To_unsigned(srl_depth-1, srl_addr_width));
          else
            return std_logic_vector(To_unsigned(temp_depth - 2, srl_addr_width));
          end if;
        end if;
      else
        return std_logic_vector(To_unsigned(srl_depth-1, srl_addr_width));
      end if;
    end if;
  end function fn_gen_last_reg_addr;

  -- purpose: Calculates the implementation depth of the shift RAM for the
  -- various modes (i.e. the number of delays stages in the hardware generated)
  function fn_get_real_depth(depth, shift_type, reg_last_bit, srl_depth : integer) return integer is
  begin  -- FUNCTION fn_get_real_depth         
    case shift_type is
      when 0      =>
        if depth = 0 or depth = 1 then
          return srl_depth+1;           -- fix to stop negative range
        elsif depth mod srl_depth /= 0 then
          return ((depth/srl_depth)*srl_depth) + srl_depth;
        else                            -- depth mod srl_depth = 0
          return depth;
        end if;
      when 1 | 2  =>
        if depth mod srl_depth /= 0 then
          return ((depth/srl_depth)*srl_depth)+srl_depth;
        else
          return depth;
        end if;
      when others =>
        return depth;                   -- never reached                     
    end case;
  end function fn_get_real_depth;

  -- purpose: If the fixed-length shift RAM is to be optimised for area, we use
  -- inferred RTL - if register controls other than CE are present, we need to
  -- use another FF and reduce the length of the shift reg XST infers by 1 cycle
  function fn_get_fixed_depth(depth, c_reg_last_bit,
                              c_has_aclr, c_has_aset, c_has_ainit,
                              c_has_sclr, c_has_sset, c_has_sinit : integer) return integer is
  begin  -- FUNCTION fn_get_fixed_depth
    if depth > 1 then
      if c_reg_last_bit /= 0 then
        if c_has_aclr = 0 and c_has_aset = 0 and c_has_ainit = 0 and c_has_sclr = 0 and c_has_sset = 0 and c_has_sinit = 0 then
          return depth;
        else
          return depth-1;
        end if;
      else                              -- no o/p FF, so just return depth
        return depth;
      end if;
    else
      return depth;                     -- changed from '16' to 'depth' to try and fix CR419959
    end if;
  end function fn_get_fixed_depth;

                                        -- purpose: returns false if no controls are used on o/p FFs, true if they are
  function fn_check_reg_ctrls(c_has_sclr, c_has_sset, c_has_sinit, c_has_aclr, c_has_aset, c_has_ainit, c_reg_last_bit : integer) return integer is
    variable ret                                                                                                       : integer := 0;
  begin  -- FUNCTION check_reg_ctrls
    if c_reg_last_bit /= 0 and c_has_sclr /= 0 then
      ret                                                                                                                        := ret+1;
    elsif c_reg_last_bit /= 0 and c_has_sset /= 0 then
      ret                                                                                                                        := ret+1;
    elsif c_reg_last_bit /= 0 and c_has_sinit /= 0 then
      ret                                                                                                                        := ret+1;
    elsif c_reg_last_bit /= 0 and c_has_aclr /= 0 then
      ret                                                                                                                        := ret+1;
    elsif c_reg_last_bit /= 0 and c_has_aset /= 0 then
      ret                                                                                                                        := ret+1;
    elsif c_reg_last_bit /= 0 and c_has_ainit /= 0 then
      ret                                                                                                                        := ret+1;
    end if;
    return ret;
  end function fn_check_reg_ctrls;


  function fn_get_srl_depth (family : string) return integer is
  begin
    if supports_SRLC32E(family) = 1 then
      return 32;
    else
      return 16;
    end if;
  end function fn_get_srl_depth;

  function fn_get_srl_addr_width(family : string) return integer is
  begin
    if supports_SRLC32E(family) = 1 then
      return 5;
    else
      return 4;
    end if;
  end function fn_get_srl_addr_width;

  function get_chain_depth(depth, srl_depth : integer) return integer is
  begin
    if depth > srl_depth then
      return depth-srl_depth;
    else
      return depth;
    end if;
  end function get_chain_depth;

  function fn_get_depth_from_mode(inferred_sr_depth, real_depth, shift_type : integer) return integer is
  begin  -- FUNCTION fn_get_depth_from_mode
    if shift_type = 0 then
      return inferred_sr_depth;
    else
      return real_depth;
    end if;
  end function fn_get_depth_from_mode;

                                        -- Determines which primitive we have to use, based on the device family we're synthesising for
  function fn_get_srl_prim(family : string) return T_PRIM is
  begin  -- FUNCTION fn_get_srl_prim(family : T_DEVICE_FAMILY)
    if supports_SRLC32E(family) = 1 then
      return SRL32;
    else
      return SRL16;
    end if;
  end function fn_get_srl_prim;

                                        -- function to determine if we are using a mix of sync and async register controls
                                        -- returns TRUE if last bit is registered and there are sync AND async register
                                        -- controls present, otherwise returns FALSE
                                        -- note that sinit is mutually-exclusive with sclr and sset and will be
                                        -- trapped by fn_c_shift_ram_v11_0_check_generics; it's the same for ainit and aclr etc.
  function check_mixed_reg_ctrls(c_has_aclr, c_has_aset, c_has_sclr, c_has_sset, c_has_ainit, c_has_sinit, c_reg_last_bit : integer) return boolean is
    variable sync                                                                                                         : integer := 0;
    variable async                                                                                                        : integer := 0;
  begin  -- FUNCTION check_mixed_reg_ctrls
    if c_reg_last_bit /= 0 and c_has_sclr /= 0 then
      sync                                                                                                                          := sync + 1;
    end if;
    if c_reg_last_bit /= 0 and c_has_sset /= 0 then
      sync                                                                                                                          := sync + 1;
    end if;
    if c_reg_last_bit /= 0 and c_has_sinit /= 0 then
      sync                                                                                                                          := sync + 1;
    end if;
    if c_reg_last_bit /= 0 and c_has_aclr /= 0 then
      async                                                                                                                         := async + 1;
    end if;
    if c_reg_last_bit /= 0 and c_has_aset /= 0 then
      async                                                                                                                         := async + 1;
    end if;
    if c_reg_last_bit /= 0 and c_has_ainit /= 0 then
      async                                                                                                                         := async + 1;
    end if;
    if async > 0 and sync > 0 then
      return true;
    else
      return false;
    end if;
  end function check_mixed_reg_ctrls;

                                        -- Determines what the address for the final SRL should be based on if
                                        -- controls are used on the output flipflop
  function fn_get_addr (family                  : string;
                        ctrls_used              : integer;
                        last_srl_addr           : std_logic_vector;
                        last_srl_addr_minus_one : std_logic_vector;
                        srl_addr_width          : integer) return std_logic_vector is
  begin  -- FUNCTION fn_get_addr
    if ctrls_used > 0 then
      if ctrls_used = 1 and supports_SRLC32E(family) = 1 then
                                        -- we can put a single register control on the output FF and pack
                                        -- it into the same slice as the SRLC32E
        return last_srl_addr;
      else
        return last_srl_addr_minus_one;
      end if;
    else
      return last_srl_addr;
    end if;
  end function fn_get_addr;

                                        -- Selects whether or not to apply KEEP attribute should be applied based on
                                        -- shift type, opt goal and presence of mixed register controls
  function use_keep (shift_type, opt_goal : integer; mixed_reg_ctrls : boolean) return string is
  begin  -- FUNCTION use_keep
    if shift_type = 1 and opt_goal = 0 and mixed_reg_ctrls then
                                        -- only choose to force the mux structure to be kept iff there are multiple
                                        -- types of control on the output register, otherwise let XST do all the optimisation
      return "true";
    else
      return "false";
    end if;
  end function use_keep;

                                        -- purpose: works out, based on the target family, at which point a FF should be inserted to speed up the circuit
                                        -- This is based on how deep we can build a shift register in a CLB using the
                                        -- dedicated fast connections (MC15/MC31)
  function fn_get_pipe_ff_pos(fam : string) return integer is
  begin  -- FUNCTION fn_get_pipe_ff_pos
    if supports_SRLC32E(fam) = 1 then
                                        -- For V5, there are 4x SRLC32Es per slice - no inter-slice connection in a CLB
      return 128;
    else
                                        -- Only SLICEMs have SRLs.  2x SLICEM, 2x SLICEL per CLB
      return 64;
    end if;
  end function fn_get_pipe_ff_pos;

  -- purpose: works out what the complete address space that can be addressed
  -- by the specified c_addr_width generic value IS
  -- e.g. if the depth specified is 192 and c_addr_width = 8, then
  -- get_addr_space() returns 256 (2**8)
  function get_addr_space(depth : integer) return integer is
    variable rnd_up_depth       : integer := 0;
    variable i                  : integer := 0;
  begin  -- FUNCTION get_addr_space
    while rnd_up_depth < depth loop
      rnd_up_depth                        := 2**i;
      i                                   := i+1;
    end loop;
    return rnd_up_depth;
  end function get_addr_space;

  -- purpose: Works out if we need to use the c_reg_fd output register or not
  function use_output_register (reg_last_bit, shift_type, opt_goal, depth, ff_controls_used, srl_depth : integer) return boolean is
    variable use_reg                                                                                   : boolean := false;
  begin  -- FUNCTION use_output_register
    if reg_last_bit /= 0 then
      case shift_type is
        when C_FIXED             =>
          if depth > 1 and ff_controls_used /= 0 then
            use_reg                                                                                              := true;
          end if;
          if depth                                              <= 1 THEN
            use_reg                                                                                              := true;
          END IF;
        WHEN C_VARIABLE_LOSSLESS =>
          IF opt_goal = C_AREA OR (opt_goal = C_SPEED AND depth <= srl_depth) THEN
            use_reg                                                                                              := true;
          END IF;
        WHEN C_VARIABLE_LOSSY    =>
          use_reg := true;
        WHEN OTHERS => NULL;
      END CASE;
    END IF;
    RETURN use_reg;
  END FUNCTION use_output_register;
  
end package body c_shift_ram_v11_0_pkg;

-- $Id: bip_utils_pkg_v1_0.vhd,v 1.3 2008/09/10 09:50:51 akennedy Exp $
-------------------------------------------------------------------------------
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
--  of this text at all times. (c) Copyright 2008 Xilinx, Inc.
--  All rights reserved.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
--USE ieee.std_logic_textio.ALL;          -- allows writing of std_logic_vector

library std;
use std.standard.all;
use std.textio.all;

package bip_utils_pkg_v1_0 is

  constant simulating : integer := 0
                                   -- synthesis translate off
                                   + 1
                                   -- synthesis translate on
;
  -----------------------------------------------------------------------------
  -- Start of code lifted from prims_constants
  -----------------------------------------------------------------------------
  -- c_sync_priority constants
  constant c_set   : integer := 0;
  constant c_clear : integer := 1;

  -- c_sync_enable constants
  constant c_override    : integer := 0;
  constant c_no_override : integer := 1;

  -- bus datatype constants
  constant c_signed   : integer := 0;
  constant c_unsigned : integer := 1;
  constant c_pin      : integer := 2;

  --T_REG_TYPE
  constant c_reg_undefined : integer := 0;  -- to match java code
  constant c_reg_fd        : integer := 1;  -- a flipflop
  constant c_reg_ld        : integer := 2;  -- a latch

  -- constants for the addsub
  constant c_add     : integer := 0;
  constant c_sub     : integer := 1;
  constant c_add_sub : integer := 2;

  -- constants for c_gate_bit
  constant c_and  : integer := 0;
  constant c_nand : integer := 1;
  constant c_or   : integer := 2;
  constant c_nor  : integer := 3;
  constant c_xor  : integer := 4;
  constant c_xnor : integer := 5;
  constant c_inv  : integer := 6;
  constant c_buf  : integer := 7;

  -- These must match the c_add, c_sub and c_add_sub values respectively!
  constant c_up     : integer := 0;
  constant c_down   : integer := 1;
  constant c_updown : integer := 2;

  -- constants for c_dist_mem*
  constant c_rom    : integer := 0;
  constant c_sp_ram : integer := 1;
  constant c_dp_ram : integer := 2;
  constant c_srl16  : integer := 3;

  -- constants for memory configurations
  constant c_single_port : integer := 0;
  constant c_dual_port   : integer := 1;

  -- constants for bux mux implementations
  constant c_lut_based  : integer := 0;
  constant c_buft_based : integer := 1;

  -- constant for shift ram shift modes
  constant c_fixed             : integer := 0;
  constant c_variable_lossless : integer := 1;
  constant c_variable_lossy    : integer := 2;

  -- constants for shift FD
  constant c_lsb_to_msb    : integer := 0;
  constant c_msb_to_lsb    : integer := 1;
  constant c_bidirectional : integer := 2;

  -- constants for shift FD fill modes
  constant c_zeros : integer := 0;
  constant c_ones  : integer := 1;
  constant c_lsb   : integer := 2;
  constant c_msb   : integer := 3;
  constant c_wrap  : integer := 4;
  constant c_sdin  : integer := 5;

  -- constants for shift ram optimisation
  constant c_area  : integer := 0;
  constant c_speed : integer := 1;

  -----------------------------------------------------------------------------
  -- Start of code lifted from prims_utils
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- original prims_utils functions
  -----------------------------------------------------------------------------

  function bv_to_slv(bitsin           : bit_vector) return std_logic_vector;
  function str_to_slv(bitsin          : string) return std_logic_vector;
  function str_to_slv_0(bitsin        : string; nbits : integer) return std_logic_vector;
  function str_to_slv_1(bitsin        : string; nbits : integer) return std_logic_vector;
  function str_to_bound_slv(bitsin    : string; nbits : integer; pad : std_logic) return std_logic_vector;
  function str_to_bound_slv_0 (bitsin : string; nbits : integer) return std_logic_vector;
  function str_to_bv(bitsin           : string) return bit_vector;
  function b_to_sl(bitin              : bit) return std_logic;
  function char_to_sl(bitin           : character) return std_logic;
  function slv_to_bv(bitsin           : std_logic_vector) return bit_vector;
  function slv_to_str(bitsin          : std_logic_vector) return string;
  function sl_to_b(bitin              : std_logic) return bit;
  function sl_to_char(bitin           : std_logic) return character;
  function int_to_str(int_value       : integer) return string;
  function all_Xs (i                  : integer) return std_logic_vector;
  function sl_to_str(sl               : std_logic) return string;
  function padded_slv_to_str (slv     : std_logic_vector; width : integer) return string;

  -----------------------------------------------------------------------------
  -- functions imported from iputils_conv
  -----------------------------------------------------------------------------

  function rat(value                    : std_logic) return std_logic;
  function slv_to_int(vect              : std_logic_vector) return integer;
  function two_comp(vect                : std_logic_vector) return std_logic_vector;
  function int_to_slv(value, bitwidth   : integer) return std_logic_vector;
  function slv_to_posint(vect           : std_logic_vector) return integer;
  function int_to_string(val            : integer) return string;  -- duplicate of int_to_str..
  function bool_to_str (val             : boolean) return string;
  function number_of_digits (data_value : integer; radix : integer) return integer;
  function conv_int_to_new_radix(number : integer; target_str_len : integer; target_radix : integer) return string;
  function int_to_hex(value, bitwidth   : integer) return string;
  function bin_to_hex_string(bin        : string) return string;
  function hexstr_to_slv(arg1           : string; size : integer) return std_logic_vector;

  -----------------------------------------------------------------------------
  -- functions imported from iputils_math
  -----------------------------------------------------------------------------

  function addr_width_for_depth (depth         : integer) return integer;
  function binary_width_of_integer (data_value : integer) return integer;
  function log2roundup (data_value             : integer) return integer;
  function get_min (a                          : integer; b : integer) return integer;
  function get_max (a                          : integer; b : integer) return integer;
  function div4roundup (data_value             : integer) return integer;
  function divroundup (data_value              : integer; divisor : integer) return integer;
  function divrounddown (data_value            : integer; divisor : integer) return integer;
  function roundup_to_multiple(data_value      : integer; multipleof : integer) return integer;
  function rand_int_base (seed                 : integer; maxval : integer; iterations : integer; feedback_val : integer) return integer;
  function rand_int (seed                      : integer; maxval : integer) return integer;
  function rand_slv_bits (seed                 : integer; width : integer) return std_logic_vector;
  function rand_slv (seed                      : integer; width : integer; maxval : integer) return std_logic_vector;

  -----------------------------------------------------------------------------
  -- functions imported from iputils_misc
  -----------------------------------------------------------------------------

  function index_in_str(stringtosearch   : string; stringsize : integer; char : string; instnum : integer) return integer;
  function lcase(instring                : string) return string;
  function ucase(instring                : string) return string;
  function case_sensitive_compare(a, b   : string) return boolean;
  function case_insensitive_compare(a, b : string) return boolean;

  -----------------------------------------------------------------------------
  -- functions imported from iputils_family
  -----------------------------------------------------------------------------

  function derived (child, ancestor   : string) return boolean;
  function equalIgnoreCase(str1, str2 : string) return boolean;

  -----------------------------------------------------------------------------
  -- new family-related functions as of 17th Feb 2006
  -----------------------------------------------------------------------------
  function valid_family (family                       : string) return boolean;
  function c_xdevicefamily_to_c_family (xdevicefamily : string) return string;
  function has_dsp (family                            : string) return boolean;
  function has_dsp48 (family                          : string) return boolean;
  function has_dsp48e (family                         : string) return boolean;
  function has_dsp48a (family                         : string) return boolean;
  function has_mult18x18 (family                      : string) return boolean;
  function has_mult18x18s (family                     : string) return boolean;
  function has_mult18x18sio (family                   : string) return boolean;
  function has_SRLC16E (family                        : string) return boolean;
  function has_SRLC32E (family                        : string) return boolean;
  function has_LUT4 (family                           : string) return boolean;
  function has_LUT6 (family                           : string) return boolean;

  -----------------------------------------------------------------------------
  -- New Routines
  -----------------------------------------------------------------------------
  function str_to_bound_str (           -- G.Old 30/5/06
    instring  : string;                 -- unknown direction
    outlength : integer;                -- return string length
    pad       : string)                 -- fill pattern character
    return string;

  -----------------------------------------------------------------------------
  -- File I/O routines that work with XST *and* ModelSim
  -- Currently don't go through XCC though...
  -----------------------------------------------------------------------------

  -- xcc exclude
  impure function read_meminit_file(filename  : in string; depth, width, lines : in positive) return std_logic_vector;
  impure function write_meminit_file(filename : in string; depth, width : in positive; memvect : in std_logic_vector) return boolean;
  -- xcc include
  
  -----------------------------------------------------------------------------
  -- Simulation functions moved from ul_utils
  -----------------------------------------------------------------------------

  function anyX(vect     : std_logic_vector) return boolean;
  function any0(vect     : std_logic_vector) return boolean;
  function setallX(width : integer) return std_logic_vector;
  function setall0(width : integer) return std_logic_vector;

  -----------------------------------------------------------------------------
  -- other stuff
  -----------------------------------------------------------------------------

  type log2array is array (0 to 128) of integer;
  constant log2 : log2array := (0   => 0, 1 => 0,
                                2   => 1,
                                3   => 2, 4 => 2,
                                5   => 3, 6 => 3, 7 => 3, 8 => 3,
                                9   => 4, 10 => 4, 11 => 4, 12 => 4, 13 => 4, 14 => 4, 15 => 4, 16 => 4,
                                17  => 5, 18 => 5, 19 => 5, 20 => 5, 21 => 5, 22 => 5, 23 => 5, 24 => 5, 25 => 5, 26 => 5, 27 => 5, 28 => 5, 29 => 5, 30 => 5, 31 => 5, 32 => 5,
                                33  => 6, 34 => 6, 35 => 6, 36 => 6, 37 => 6, 38 => 6, 39 => 6, 40 => 6, 41 => 6, 42 => 6, 43 => 6, 44 => 6, 45 => 6, 46 => 6, 47 => 6, 48 => 6,
                                49  => 6, 50 => 6, 51 => 6, 52 => 6, 53 => 6, 54 => 6, 55 => 6, 56 => 6, 57 => 6, 58 => 6, 59 => 6, 60 => 6, 61 => 6, 62 => 6, 63 => 6, 64 => 6,
                                65  => 7, 66 => 7, 67 => 7, 68 => 7, 69 => 7, 70 => 7, 71 => 7, 72 => 7, 73 => 7, 74 => 7, 75 => 7, 76 => 7, 77 => 7, 78 => 7, 79 => 7, 80 => 7,
                                81  => 7, 82 => 7, 83 => 7, 84 => 7, 85 => 7, 86 => 7, 87 => 7, 88 => 7, 89 => 7, 90 => 7, 91 => 7, 92 => 7, 93 => 7, 94 => 7, 95 => 7, 96 => 7,
                                97  => 7, 98 => 7, 99 => 7, 100 => 7, 101 => 7, 102 => 7, 103 => 7, 104 => 7, 105 => 7, 106 => 7, 107 => 7, 108 => 7, 109 => 7, 110 => 7, 111 => 7, 112 => 7,
                                113 => 7, 114 => 7, 115 => 7, 116 => 7, 117 => 7, 118 => 7, 119 => 7, 120 => 7, 121 => 7, 122 => 7, 123 => 7, 124 => 7, 125 => 7, 126 => 7, 127 => 7, 128 => 7);  
 

  -----------------------------------------------------------------------------
  -- Start of code lifted from pkg_baseblox.
  -----------------------------------------------------------------------------
  type T_REGTYPE is (REGTYPE_FD, REGTYPE_LD);
  type T_SYNC_ENABLE is (SYNC_OVERRIDES_CE, CE_OVERRIDES_SYNC);
  type T_REG_PRIORITY is (RESET_OVERRIDES_SET, SET_OVERRIDES_RESET);
  type T_BYPASS_ENABLE is (BYPASS_OVERRIDES_CE, CE_OVERRIDES_BYPASS);
  type T_ADD_MODE is (MODE_ADD, MODE_SUB, MODE_ADDSUB);
  -- NUM_PIN is for pin-specified signed/unsigned numbers
  type T_NUMBER_FORMAT is (NUM_SIGNED, NUM_UNSIGNED, NUM_PIN);
  type T_DEVICE_FAMILY is (SPARTAN2, SPARTAN3, SPARTAN3E, SPARTAN3A, SPARTAN3ADSP, VIRTEX, VIRTEX2, VIRTEX4, VIRTEX5);

  function fn_select_sync_enable (sync_enable     : integer) return T_SYNC_ENABLE;
  function fn_select_bypass_enable (bypass_enable : integer) return T_BYPASS_ENABLE;
  function fn_select_sync_priority (sync_priority : integer) return T_REG_PRIORITY;
  function fn_select_reg_type (reg_type           : integer) return T_REGTYPE;
  function fn_select_add_mode (add_mode           : integer) return T_ADD_MODE;
  function fn_select_number_format (number_format : integer) return T_NUMBER_FORMAT;
  function fn_check_family(family                 : string) return T_DEVICE_FAMILY;
  function fn_syncs_in_d_lut (has_sclr, has_sset, has_sinit,
                              has_aclr, has_aset, has_ainit : integer  -- the legacy type
                              ) return integer;
  function fn_get_lut_size(device_family : T_DEVICE_FAMILY) return integer;
  function fn_get_por_value(c_has_aclr, c_has_aset, c_has_ainit, c_has_sclr, c_has_sset, c_has_sinit : integer;
                            ainit_val, sinit_val                                                     : std_logic_vector;
                            c_width                                                                  : integer) return std_logic_vector;

end bip_utils_pkg_v1_0;

package body bip_utils_pkg_v1_0 is

  -- purpose: converts a bit_vector to a std_logic_vector
  function bv_to_slv(bitsin : bit_vector) return std_logic_vector is
    variable ret : std_logic_vector(bitsin'range);
  begin
    for i in bitsin'range loop
      if bitsin(i) = '1' then
        ret(i) := '1';
      else
        ret(i) := '0';
      end if;
    end loop;

    return ret;
  end bv_to_slv;

  -- purpose: converts a string to a std_logic_vector
  function str_to_slv(bitsin : string) return std_logic_vector is
    variable ret : std_logic_vector(bitsin'range);
  begin
    for i in bitsin'range loop
      if bitsin(i) = '1' then
        ret(i) := '1';
      elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
        ret(i) := 'X';
      elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
        ret(i) := 'Z';
      elsif (bitsin(i) = '0') then
        ret(i) := '0';
      end if;
    end loop;

    return ret;
  end str_to_slv;

  -- purpose: converts a string to a std_logic_vector with padding of 0's
  function str_to_slv_0(bitsin : string; nbits : integer) return std_logic_vector is
    variable ret       : std_logic_vector(bitsin'range);
    -- String types range from 1 to len!!!
    variable ret0s     : std_logic_vector(1 to nbits) := (others => '0');
    variable retpadded : std_logic_vector(1 to nbits) := (others => '0');
    variable offset    : integer                      := 0;
  begin
    if(bitsin'length = 0) then          -- Make all '0's
      return ret0s;
    end if;
    if(bitsin'length < nbits) then      -- pad MSBs with '0's
      offset := nbits - bitsin'length;
      for i in bitsin'range loop
        if bitsin(i) = '1' then
          retpadded(i+offset) := '1';
        elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
          retpadded(i+offset) := 'X';
        elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
          retpadded(i+offset) := 'Z';
        elsif (bitsin(i) = '0') then
          retpadded(i+offset) := '0';
        end if;
      end loop;
      retpadded(1 to offset) := (others => '0');
      return retpadded;
    end if;
    for i in bitsin'range loop
      if bitsin(i) = '1' then
        ret(i) := '1';
      elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
        ret(i) := 'X';
      elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
        ret(i) := 'Z';
      elsif (bitsin(i) = '0') then
        ret(i) := '0';
      end if;
    end loop;

    return ret;
  end str_to_slv_0;

  -- purpose: converts a string to a std_logic_vector with padding of 1's
  function str_to_slv_1(bitsin : string; nbits : integer) return std_logic_vector is
    variable ret       : std_logic_vector(bitsin'range);
    -- String types range from 1 to len!!!
    variable ret1s     : std_logic_vector(1 to nbits) := (others => '1');
    variable retpadded : std_logic_vector(1 to nbits) := (others => '1');
    variable offset    : integer                      := 0;
  begin
    if(bitsin'length = 0) then          -- make all '1's
      return ret1s;
    end if;
    if(bitsin'length < nbits) then      -- pad MSBs with '1's
      offset := nbits - bitsin'length;
      for i in bitsin'range loop
        if bitsin(i) = '1' then
          retpadded(i+offset) := '1';
        elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
          retpadded(i+offset) := 'X';
        elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
          retpadded(i+offset) := 'Z';
        elsif (bitsin(i) = '0') then
          retpadded(i+offset) := '0';
        end if;
      end loop;
      retpadded(1 to offset) := (others => '1');
      return retpadded;
    end if;
    for i in bitsin'range loop
      if bitsin(i) = '1' then
        ret(i) := '1';
      elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
        ret(i) := 'X';
      elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
        ret(i) := 'Z';
      elsif (bitsin(i) = '0') then
        ret(i) := '0';
      end if;
    end loop;

    return ret;
  end str_to_slv_1;

  -- purpose: converts a string to a std_logic_vector of bound length
  -- truncating or padding with pad as necessary
  -- truncation and padding occurs at the LEFT
  -- eg "11", 4 => "0011"
  -- or "100000", 4 => "0000"
  function str_to_bound_slv (bitsin : string; nbits : integer; pad : std_logic)
    return std_logic_vector is
    variable ret          : std_logic_vector (1 to nbits);
    -- offset is the amount that bitsin needs to move to the right
    -- for its right end to be coincident with ret's.
    -- negative values of offset mean bitsin must move to the left
    -- and that bitsin will be truncated.
    constant offset       : integer                    := nbits - bitsin'length;  -- was variable
    constant bitsinlen    : integer                    := bitsin'length;  -- was variable
    constant bitsin_const : string(1 to bitsin'length) := bitsin;
    variable temp         : string(1 to bitsin'length);
  begin
    temp := bitsin;

    assert nbits >= 1
      report "ERROR - str_to_bound_slv: Cannot have zero or negative length array"
      severity failure;
    assert offset >= 0
      report "WARNING - str_to_bound_slv: Input string too long, will truncate it"
      severity warning;

    for i in 1 to nbits loop
      ret(i) := pad;
    end loop;
    if bitsin_const'length = 0 then  -- use instead of bitsin = "" to avoid XST warning
      return ret;
    end if;

    for i in 1 to nbits loop
--      assert false report "i ="&integer'IMAGE(i)&" offset="&integer'IMAGE(offset) severity note;
      if i <= offset then
        -- this cell of the vector will become padding
        ret(i) := pad;
      else
        -- the following IF effectively does ret(i) := temp(i - offset)
        case temp(i-offset) is
          when '1' =>
            ret(i) := '1';
          when '0' =>
            ret(i) := '0';
          when 'x' | 'X' =>
            ret(i) := 'X';
          when 'u' | 'U' =>
            ret(i) := 'U';
          when others =>
            assert false report "ERROR - str_to_bound_slv: Invalid character encountered (Only 1, X, U or 0 are recognised) "&bitsin_const(i-offset)
              severity warning;
        end case;
      end if;
    end loop;
    return ret;
  end str_to_bound_slv;

  -- purpose: same as above, but pad with '0' rather than user-defined pad.
  function str_to_bound_slv_0 (bitsin : string; nbits : integer) return std_logic_vector is
  begin
    return str_to_bound_slv(bitsin, nbits, '0');
  end str_to_bound_slv_0;

  -- purpose: converts a string to a bit_Vector
  function str_to_bv(bitsin : string) return bit_vector is
    variable ret : bit_vector(bitsin'range);
  begin
    for i in bitsin'range loop
      if bitsin(i) = '1' then
        ret(i) := '1';
      elsif (bitsin(i) = '0') then
        ret(i) := '0';
      else
        assert false
          report "Cannot translate STR_TO_BV with unknowns in STR"
          severity error;
      end if;
    end loop;

    return ret;
  end str_to_bv;

  -- purpose: converts a bit value to a std_logic value
  function b_to_sl(bitin : bit) return std_logic is
    variable ret : std_logic;
  begin
    if bitin = '1' then
      ret := '1';
    else
      ret := '0';
    end if;
    return ret;
  end b_to_sl;

  -- purpose: converts a character to a std_logic value
  function char_to_sl(bitin : character) return std_logic is
    variable ret : std_logic;
  begin
    if bitin = '1' then
      ret := '1';
    elsif bitin = 'X' or bitin = 'x' then
      ret := 'X';
    elsif bitin = 'Z' or bitin = 'z' then
      ret := 'Z';
    else
      ret := '0';
    end if;
    return ret;
  end char_to_sl;

  -- purpose: converts a std_logic_vector to a bit_vector
  function slv_to_bv(bitsin : std_logic_vector) return bit_vector is
    variable ret : bit_vector(bitsin'range);
  begin
    for i in bitsin'range loop
      if bitsin(i) = '1' then
        ret(i) := '1';
      elsif bitsin(i) = '0' then
        ret(i) := '0';
      else
        assert false
          report "Cannot translate SLV_TO_BV with unknowns in SLV"
          severity error;
      end if;
    end loop;

    return ret;
  end slv_to_bv;

  -- purpose: converts a std_logic_Vector to a string
  function slv_to_str(bitsin : std_logic_vector) return string is
    variable ret : string(1 to bitsin'length);
  begin
    if bitsin'length = 0 then
      return "";
    else
      if bitsin'ascending then
        for i in 0 to bitsin'length-1 loop
          if bitsin(bitsin'left+i) = '1' then
            ret(ret'left+i) := '1';
          elsif (bitsin(bitsin'left+i) = 'X') then
            ret(ret'left+i) := 'X';
          elsif (bitsin(bitsin'left+i) = 'Z') then
            ret(ret'left+i) := 'Z';
          elsif (bitsin(bitsin'left+i) = 'U') then
            ret(ret'left+i) := 'U';
          elsif (bitsin(bitsin'left+i) = '0') then
            ret(ret'left+i) := '0';
          end if;
        end loop;
      else                              -- bitsin'descending
        for i in 0 to bitsin'length-1 loop
          if bitsin(bitsin'left-i) = '1' then
            ret(ret'left+i) := '1';
          elsif (bitsin(bitsin'left-i) = 'X') then
            ret(ret'left+i) := 'X';
          elsif (bitsin(bitsin'left-i) = 'Z') then
            ret(ret'left+i) := 'Z';
          elsif (bitsin(bitsin'left-i) = 'U') then
            ret(ret'left+i) := 'U';
          elsif (bitsin(bitsin'left-i) = '0') then
            ret(ret'left+i) := '0';
          end if;
        end loop;
      end if;
    end if;
    return ret;
  end slv_to_str;

  -- purpose: converts a std_logic value to a bit value
  function sl_to_b(bitin : std_logic) return bit is
    variable ret : bit;
  begin
    if bitin = '1' then
      ret := '1';
    else
      ret := '0';
    end if;
    return ret;
  end sl_to_b;

  -- purpose: converts a std_logic value to a character
  function sl_to_char(bitin : std_logic) return character is
    variable ret : character;
  begin
    if bitin = '1' then
      ret := '1';
    elsif bitin = 'X' then
      ret := 'X';
    elsif bitin = 'Z' then
      ret := 'Z';
    elsif bitin = 'U' then
      ret := 'U';
    else
      ret := '0';
    end if;
    return ret;
  end sl_to_char;

  -- purpose: converts an integer to a string
  function int_to_str(int_value : integer) return string is
  begin
    return integer'image(int_value);
  end int_to_str;

  function all_Xs(i : integer) return std_logic_vector is
    variable stmp : std_logic_vector(i-1 downto 0) := (others => 'X');
  begin
    return stmp;
  end all_Xs;

  -- purpose: Converts std_logic 0 or 1 to equivalent STRING
  -- Added andreww 11/11/2004
  function sl_to_str(sl : std_logic) return string is
  begin  -- FUNCTION sl_to_str
    case sl is
      when '0' => return "0";
      when '1' => return "1";
      when others =>
        assert false
          report "WARNING: Unexpected STD_LOGIC value (not 0 or 1) detected - returning 0"
          severity warning;
        return "0";
    end case;
  end function sl_to_str;

  -- purpose: Converts std_logic_vectors to equivalent strings
  -- assumes the SLV is DOWNTO
  function padded_slv_to_str (slv : std_logic_vector; width : integer) return string is
    variable ret : string(1 to width);
  begin  -- FUNCTION padded_slv_to_str
    for i in 0 to width-1 loop
      if slv(i) = '1' then
        ret(width-i) := '1';
      elsif slv(i) = 'X' then
        ret(width-i) := 'X';
      elsif slv(i) = 'Z' then
        ret(width-i) := 'Z';
      elsif slv(i) = 'U' then
        ret(width-i) := 'U';
      elsif slv(i) = '0' then
        ret(width-i) := '0';
      end if;
    end loop;
    return ret;
  end function padded_slv_to_str;

  -----------------------------------------------------------------------------
  -- new functions imported from iputils_conv
  -----------------------------------------------------------------------------

  -- purpose: rationalises input SL value
  -- utility function for functions below
  function rat(value : std_logic) return std_logic is
  begin
    case value is
      when '0' | '1' => return value;
      when 'H'       => return '1';
      when 'L'       => return '0';
      when others    => return 'X';
    end case;
  end rat;

  -- purpose: returns two's complement of the input SLV
  function two_comp(vect : std_logic_vector) return std_logic_vector is
    variable local_vect : std_logic_vector(vect'high downto 0);
    variable toggle     : integer := 0;
  begin
    for i in 0 to vect'high loop
      if (toggle = 1) then
        if (vect(i) = '0') then
          local_vect(i) := '1';
        else
          local_vect(i) := '0';
        end if;
      else
        local_vect(i) := vect(i);
        if (vect(i) = '1') then
          toggle := 1;
        end if;
      end if;
    end loop;
    return local_vect;
  end two_comp;

  -- purpose: converts a std_logic_Vector to an integer
  function slv_to_int(vect : std_logic_vector) return integer is
    variable local_vect : std_logic_vector(vect'high downto 0);
    variable result     : integer := 0;
  begin
    if (rat(vect(vect'high)) = '1') then  -- negative number
      local_vect := two_comp(vect);
    else
      local_vect := vect;
    end if;

    for i in vect'high downto 0 loop
      result := result * 2;
      if (rat(local_vect(i)) = '1') then
        result := result + 1;
      end if;
    end loop;

    if (rat(vect(vect'high)) = '1') then
      result := -1 * result;
    end if;

    return result;
    
  end slv_to_int;

  -- purpose: converts an integer value to a std_logic_Vector
  function int_to_slv(value, bitwidth : integer) return std_logic_vector is
    variable running_value  : integer := value;
    variable running_result : std_logic_vector(bitwidth-1 downto 0);
  begin
    
    if (value < 0) then
      running_value := -1 * value;
    end if;

    for i in 0 to bitwidth-1 loop
      
      if running_value mod 2 = 0 then
        running_result(i) := '0';
      else
        running_result(i) := '1';
      end if;
      running_value := running_value/2;
    end loop;

    if (value < 0) then                 -- find the 2s complement
      return two_comp(running_result);
    else
      return running_result;
    end if;
  end int_to_slv;

  -- purpose: converts a std_logic_vector to a positive integer
  function slv_to_posint(vect : std_logic_vector) return integer is
    variable result : integer := 0;
  begin
    for i in vect'high downto vect'low loop
      result := result * 2;
      if (rat(vect(i)) = '1') then
        result := result + 1;
      end if;
    end loop;
    return result;
  end slv_to_posint;

  -- purpose: converts an Integer value to a string
  function int_to_string(val : integer) return string is
  begin
    return integer'image(val);
  end int_to_string;

  -- purpose: converts a Boolean value to a string
  function bool_to_str (val : boolean) return string is
  begin  -- FUNCTION bool_to_str
    if val then
      return "true";
    else
      return "false";
    end if;
  end function bool_to_str;

  -- purpose: Calculates the number of bits needed to represent the specified data_value
  -- based on the supplied radix
  function number_of_digits (data_value : integer; radix : integer) return integer is
    variable dwidth : integer := 0;
  begin
    while radix**dwidth-1 < data_value and data_value > 0 loop
      dwidth := dwidth + 1;
    end loop;
    return dwidth;
  end number_of_digits;

-- Purpose:
-- Converts an integer to a string of the specified radix (2 to 16)
-- Algorithm:
-- Based on the destination string size, or the input number, the function
-- determines the largest possible exponent to attempt.
-- It then loops downward, determining the coefficient for each exponent value
-- and subtracting the value from the remaining value.
-- Parameters:
-- number : the integer value to convert
-- target_str_len : the number of terms in the target string
-- target_radix : the desired radix of the output string
-- return : string formatted number in the desired radix (padded with 0's)
  function conv_int_to_new_radix(number : integer; target_str_len : integer; target_radix : integer) return string is
    variable return_string   : string(1 to target_str_len) := (others => '0');
    variable string_location : integer                     := 0;
    variable tmp_string_val  : integer                     := 0;
    variable new_number      : integer                     := number;
    variable hexdigits       : string(1 to 16)             := "0123456789ABCDEF";
    variable max_exp         : integer                     := 0;
  begin
    max_exp := number_of_digits(number, target_radix);
    if target_str_len < max_exp then
      max_exp := target_str_len;
    end if;

    new_number := number;

    for exp in max_exp-1 downto 0 loop
      string_location                := target_str_len-exp;
      tmp_string_val                 := new_number/(target_radix**exp);
      new_number                     := new_number - tmp_string_val*(target_radix**exp);
      return_string(string_location) := hexdigits(tmp_string_val+1);
    end loop;
    return return_string;
  end conv_int_to_new_radix;

--   purpose: Converts an integer to a hexidecimal string value
  function int_to_hex(value, bitwidth : integer) return string is
    variable hexdigits      : string(1 to 16) := "0123456789ABCDEF";
    variable running_value  : integer         := value;
    variable digit_value    : integer         := 0;
    variable digit_position : integer         := 1;
    variable results_string : string(1 to bitwidth/4);
  begin

    for i in bitwidth-1 downto 0 loop

      if (2**i) <= running_value then
        running_value := running_value - (2**i);
        digit_value   := digit_value + (2**(i mod 4));
      end if;

      if i mod 4 = 0 then
        results_string(digit_position) := hexdigits(1+digit_value);
        digit_value                    := 0;
        digit_position                 := digit_position + 1;
      end if;

    end loop;

    return results_string;

  end int_to_hex;

  -- purpose: Returns the ceiling value of the division by 4
  --  This version of this function is only for use by the
  --  bin_to_hex_string function.  Users should use
  --  div4roundup from iputils_math.
  function div4roundup_v2 (data_value : integer) return integer is
    variable div : integer;
  begin
    div := data_value/4;
    if ((data_value mod 4) /= 0) then
      div := div+1;
    end if;
    return div;
  end div4roundup_v2;

  -- purpose: This function converts a standard logic vector to a string.
  function bin_to_hex_string(bin : string) return string is
    variable hex_len : integer := div4roundup_v2(bin'high);
    variable bin_ext : string(1 to hex_len*4);
    variable hex     : string(1 to hex_len);
    variable sub_bin : string (1 to 4);
  begin

    -- extend binary string to a multiple of 4
    for j in 1 to hex_len*4 loop
      if (j <= hex_len*4-bin'high) then
        bin_ext(j) := '0';
      else
        bin_ext(j) := bin(j-(hex_len*4-bin'high));
      end if;
    end loop;

    for i in 0 to hex_len-1 loop
      sub_bin := bin_ext(i*4+1 to i*4+4);
      case sub_bin is
        when "0000" => hex(i+1) := '0';
        when "0001" => hex(i+1) := '1';
        when "0010" => hex(i+1) := '2';
        when "0011" => hex(i+1) := '3';
        when "0100" => hex(i+1) := '4';
        when "0101" => hex(i+1) := '5';
        when "0110" => hex(i+1) := '6';
        when "0111" => hex(i+1) := '7';
        when "1000" => hex(i+1) := '8';
        when "1001" => hex(i+1) := '9';
        when "1010" => hex(i+1) := 'a';
        when "1011" => hex(i+1) := 'b';
        when "1100" => hex(i+1) := 'c';
        when "1101" => hex(i+1) := 'd';
        when "1110" => hex(i+1) := 'e';
        when others => hex(i+1) := 'f';
      end case;
    end loop;

    return hex;

  end bin_to_hex_string;

--  purpose: This function converts a hex string to a std_logic_vector
  function hexstr_to_slv(arg1 : string; size : integer) return std_logic_vector is
    variable RESULT : std_logic_vector(size-1 downto 0) := (others => '0');
    variable BIN    : std_logic_vector(3 downto 0);
    variable INDEX  : integer                           := 0;
  begin
    for i in arg1'reverse_range loop
      case arg1(i) is
        when '0' => BIN := (others => '0');
        when '1' => BIN := (0 => '1', others => '0');
        when '2' => BIN := (1 => '1', others => '0');
        when '3' => BIN := (0 => '1', 1 => '1', others => '0');
        when '4' => BIN := (2 => '1', others => '0');
        when '5' => BIN := (0 => '1', 2 => '1', others => '0');
        when '6' => BIN := (1 => '1', 2 => '1', others => '0');
        when '7' => BIN := (3 => '0', others => '1');
        when '8' => BIN := (3 => '1', others => '0');
        when '9' => BIN := (0 => '1', 3 => '1', others => '0');
        when 'A' => BIN := (0 => '0', 2 => '0', others => '1');
        when 'a' => BIN := (0 => '0', 2 => '0', others => '1');
        when 'B' => BIN := (2 => '0', others => '1');
        when 'b' => BIN := (2 => '0', others => '1');
        when 'C' => BIN := (0 => '0', 1 => '0', others => '1');
        when 'c' => BIN := (0 => '0', 1 => '0', others => '1');
        when 'D' => BIN := (1 => '0', others => '1');
        when 'd' => BIN := (1 => '0', others => '1');
        when 'E' => BIN := (0 => '0', others => '1');
        when 'e' => BIN := (0 => '0', others => '1');
        when 'F' => BIN := (others => '1');
        when 'f' => BIN := (others => '1');
        when others =>
          --ASSERT false
          --  REPORT "NOT A HEX CHARACTER" SEVERITY error;
          for j in 0 to 3 loop
            BIN(j) := 'X';
          end loop;
      end case;
      for j in 0 to 3 loop
        if (INDEX*4)+j < size then
          RESULT((INDEX*4)+j) := BIN(j);
        end if;
      end loop;
      INDEX := INDEX + 1;
    end loop;
    return RESULT;
  end hexstr_to_slv;

  -----------------------------------------------------------------------------
  -- functions imported from iputils_math
  -----------------------------------------------------------------------------

  -- Purpose:
  --   Calculates the number of bits necessary for addressing a memory of 
  --    of the specified depth.
  --   Equivalently, calculates the minimum number of bits required to have
  --    the specified number of unique states.
  -- Example: A memory with depth 256 requires an 8-bit addr bus.
  -- Example: To represent 256 unique values/states requires 8 bits.
  -- Algorithm:
  --   roundup(log2(depth))
  -- Parameters:
  --   depth : memory depth or unique values or states
  -- Return:
  --   integer number of bits
  -- NOTES: By definition, log2(0) is undefined. However, this function will
  --   simply return a 0 for any input <= 0. 
  function addr_width_for_depth (depth : integer) return integer is
    variable bits : integer := 0;
  begin
    while 2**bits < depth and depth > 1 loop
      bits := bits + 1;
    end loop;
    return bits;
  end addr_width_for_depth;

  -- Purpose:
  --   Calculates the number of bits/registers needed to represent/store the
  --    specified maximum value
  -- Example:
  --   A max value of 0 does not require any bits for storage.
  --   A max value of 255 requires 8 bits to represent/store.
  --   A max value of 256 requires 9 bits to represent/store.
  -- Algorithm:
  --   roundup(log2(data_value+1))
  -- Parameters:
  --   data_value : input number
  -- Return : number of bits needed
  -- NOTES: By definition, log2(-1+1) is undefined. However, this function will
  --   simply return a 0 for any input < 0. 
  function binary_width_of_integer (data_value : integer) return integer is
    variable dwidth : integer := 0;
  begin
    while 2**dwidth-1 < data_value and data_value > 0 loop
      dwidth := dwidth + 1;
    end loop;
    return dwidth;
  end binary_width_of_integer;

  -- purpose: 
  function log2roundup (data_value : integer) return integer is
    variable width       : integer := 0;
    variable cnt         : integer := 1;
    constant lower_limit : integer := 1;
    constant upper_limit : integer := 8;
  begin
    if (data_value <= 1) then
      width := 0;
    else
      while (cnt < data_value) loop
        width := width + 1;
        cnt   := cnt *2;
      end loop;
    end if;
    return width;
  end log2roundup;

  -- purpose: Returns the min(a,b)                           
  function get_min (a : integer; b : integer) return integer is
    variable smallest : integer := 1;
  begin
    if (a < b) then
      smallest := a;
    else
      smallest := b;
    end if;
    return smallest;
  end get_min;

  -- purpose: Returns the max(a,b)                           
  function get_max (a : integer; b : integer) return integer is
    variable biggest : integer := 1;
  begin
    if (a > b) then
      biggest := a;
    else
      biggest := b;
    end if;
    return biggest;
  end get_max;

  -- purpose: Returns the ceiling value of the division by 4
  function div4roundup (data_value : integer) return integer is
    variable div : integer;
  begin
    div := data_value/4;
    if ((data_value mod 4) /= 0) then
      div := div+1;
    end if;
    return div;
  end div4roundup;

  -- purpose: Returns the ceiling value of the division
  -- Data_value - the quantity to be divided, dividend
  -- Divisor - the value to divide the data_value by
  function divroundup (data_value : integer; divisor : integer) return integer is
    variable div : integer;
  begin
    div := data_value/divisor;
    if ((data_value mod divisor) /= 0) then
      div := div+1;
    end if;
    return div;
  end divroundup;



  -- purpose: Returns the floor value of the division
  -- Data_value - the quantity to be divided, dividend
  -- Divisor - the value to divide the data_value by
  function divrounddown (data_value : integer; divisor : integer) return integer is
    variable div : integer;
  begin
    div := data_value/divisor;
    return div;
  end divrounddown;

  -- Purpose:
  --   Round up to the next nearest integer value which is divisible by the
  --    specified number.
  --   Round the number up to the next multiple of a number.
  -- Example:
  --   For the number 7, the nearest higher integer divisible by 2 is 8.
  --   For the number 4, the nearest higher integer divisible by 4 is 4.
  -- Algorithm:
  --   multipleof*roundup(data_value/multipleof)
  -- Parameters:
  --   data_value : number to be rounded
  --   multipleof : value of which the output should be a multiple
  -- Return : data_value rounded up to nearest multiple of "multipleof"
  function roundup_to_multiple(data_value : integer; multipleof : integer) return integer is
    variable retval : integer;
  begin
    retval := data_value/multipleof;
    if ((data_value mod multipleof) /= 0) then
      retval := retval+1;
    end if;
    retval := multipleof * retval;
    return retval;
  end roundup_to_multiple;

-- Purpose: To randomly generate an integer between 0 and maxval.
-- This function is the underlying function for all of the rand_ functions.
--
-- Inputs:
-- seed : Any integer value. Given the same seed, this function will
-- always generate the same output. It is recommended to always
-- use the output of this function as the seed for the next call.
-- maxval : The maximum value allowed. The randomly generated value will
-- not exceed this value.
-- iterations : To a point, more iterations increase "randomness" of
-- output value.
-- feedback_val : Feedback modifier.
--
-- Return:
-- pseudo-random integer from 0 to maxval.
--
-- Details:
-- This function is based on Linear Feedback.
-- Mathematically, the priniciple is the same as the linear feedback shift
-- register, where each iteration is a "clock cycle", and the taps are
-- the feedback_val.
-- The number of iterations and feedback_val can be any value, and will result
-- in a pseudo-random sequence.
-- However, iterations creates more "random" results when > 1.
-- Also, feedback_val is best when a large prime number (like 19).
  function rand_int_base (seed : integer; maxval : integer; iterations : integer; feedback_val : integer) return integer is
    variable ret_val : integer := 0;
  begin
    ret_val := seed;
    for i in 0 to iterations loop
      if ret_val >= maxval/2 then
        ret_val := ret_val * 2 + feedback_val;
      else
        ret_val := ret_val * 2;
      end if;

      while ret_val > maxval loop
        ret_val := ret_val - maxval;
      end loop;
    end loop;  -- i
    return ret_val;
  end rand_int_base;

-- Purpose: To randomly generate an integer between 0 and maxval.
--          (including 0 and maxval)
--
-- Inputs:
-- seed : Any integer value. Given the same seed, this function will
-- always generate the same output. It is recommended to always
-- use the output of this function as the seed for the next call.
-- maxval : The maximum value allowed. The randomly generated value will
-- not exceed this value.
--
-- Return:
-- pseudo-random integer from 0 to maxval.
--
-- Details:
-- This function is based on Linear Feedback.
  function rand_int (seed : integer; maxval : integer) return integer is
    variable ret_val : integer := 0;
  begin
    ret_val := rand_int_base(seed, maxval + 15000, 2, 19);
    while ret_val > maxval loop
      ret_val := ret_val - maxval;
    end loop;
    return ret_val;
  end rand_int;

-- Purpose: To randomly generate a std_logic_vector between 0 and 2^width-1. 
--          (including 0 and 2^width-1)
--
-- Inputs:
-- seed : Any integer value. Given the same seed, this function will
-- always generate the same output. It is recommended to always
-- use the output of this function as the seed for the next call.
-- width : The number of bits in the output. (2^width-1 is the maximum
-- random value from this function)
-- Return:
-- pseudo-random std_logic_vector from 0 to 2^width-1.
  function rand_slv_bits (seed : integer; width : integer) return std_logic_vector is
    variable ret_vect : std_logic_vector(width-1 downto 0) := (others => '0');
    variable rand_val : integer                            := seed;
  begin
    for i in 0 to width-1 loop
      rand_val := rand_int(rand_val, 19);
      if rand_val >= 10 then
        ret_vect(i) := '1';
      else
        ret_vect(i) := '0';
      end if;
    end loop;  -- i
    return ret_vect;
  end rand_slv_bits;


-- Purpose: To randomly generate a std_logic_vector between 0 and maxval.
--          (including 0 and maxval)
-- Inputs:
-- seed : Any integer value. Given the same seed, this function will
-- always generate the same output. It is recommended to always
-- use the output of this function as the seed for the next call.
-- width : The number of bits in the output.
-- maxval : The maximum value allowed. This may be less than or
-- equal to 2^width-1.
-- Return:
-- pseudo-random std_logic_vector from 0 to maxval.
  function rand_slv (seed : integer; width : integer; maxval : integer) return std_logic_vector is
    variable ret_vect : std_logic_vector(width-1 downto 0) := (others => '0');
    variable rand_val : integer                            := seed;
  begin
    --Generate a random integer using the seed
    rand_val := rand_int(rand_val, maxval);
    --Put it into a std_logic_vector of the correct size
    ret_vect := int_to_slv(rand_val, width);
    return ret_vect;
  end rand_slv;

  -----------------------------------------------------------------------------
  -- functions imported from iputils_misc
  -----------------------------------------------------------------------------

-- purpose: Returns the index of a specified instance of a specified character in another string
-- Example: What is the index of the third "l" in "Hello World"? =10
-- Inputs:
-- string of characters of any length
-- length of string (number of characters)
-- character to search for
-- number of instance to locate
-- Outputs:
-- integer index value 1 to stringsize, if char exists. Returns 0 if the char
-- was not found.
  function index_in_str(stringtosearch : string; stringsize : integer; char : string; instnum : integer) return integer is
    variable instfound    : integer := 0;
    variable foundatindex : integer := 0;
  begin
    for i in 1 to stringsize loop
      if stringtosearch(i) = char(1) then
        instfound := instfound + 1;
        if instfound = instnum then
          foundatindex := i;
        end if;
      end if;
    end loop;  -- i
    return foundatindex;
  end index_in_str;

--   purpose: Converts a string to all lowercase.
  function lcase(instring : string) return string is
    variable retstring : string (instring'low to instring'high);
  begin
    retstring := instring;    
    for i in instring'low to instring'high loop
      case instring(i) is
        when 'A'    => retstring(i) := 'a';
        when 'B'    => retstring(i) := 'b';
        when 'C'    => retstring(i) := 'c';
        when 'D'    => retstring(i) := 'd';
        when 'E'    => retstring(i) := 'e';
        when 'F'    => retstring(i) := 'f';
        when 'G'    => retstring(i) := 'g';
        when 'H'    => retstring(i) := 'h';
        when 'I'    => retstring(i) := 'i';
        when 'J'    => retstring(i) := 'j';
        when 'K'    => retstring(i) := 'k';
        when 'L'    => retstring(i) := 'l';
        when 'M'    => retstring(i) := 'm';
        when 'N'    => retstring(i) := 'n';
        when 'O'    => retstring(i) := 'o';
        when 'P'    => retstring(i) := 'p';
        when 'Q'    => retstring(i) := 'q';
        when 'R'    => retstring(i) := 'r';
        when 'S'    => retstring(i) := 's';
        when 'T'    => retstring(i) := 't';
        when 'U'    => retstring(i) := 'u';
        when 'V'    => retstring(i) := 'v';
        when 'W'    => retstring(i) := 'w';
        when 'X'    => retstring(i) := 'x';
        when 'Y'    => retstring(i) := 'y';
        when 'Z'    => retstring(i) := 'z';
        when others => retstring(i) := instring(i);
      end case;
    end loop;  -- i

    return retstring;

  end lcase;



--   purpose: Converts a string to all uppercase.
  function ucase(instring : string) return string is
    variable retstring : string (instring'low to instring'high);
  begin
    retstring := instring;    
    for i in instring'low to instring'high loop
      case instring(i) is
        when 'a'    => retstring(i) := 'A';
        when 'b'    => retstring(i) := 'B';
        when 'c'    => retstring(i) := 'C';
        when 'd'    => retstring(i) := 'D';
        when 'e'    => retstring(i) := 'E';
        when 'f'    => retstring(i) := 'F';
        when 'g'    => retstring(i) := 'G';
        when 'h'    => retstring(i) := 'H';
        when 'i'    => retstring(i) := 'I';
        when 'j'    => retstring(i) := 'J';
        when 'k'    => retstring(i) := 'K';
        when 'l'    => retstring(i) := 'L';
        when 'm'    => retstring(i) := 'M';
        when 'n'    => retstring(i) := 'N';
        when 'o'    => retstring(i) := 'O';
        when 'p'    => retstring(i) := 'P';
        when 'q'    => retstring(i) := 'Q';
        when 'r'    => retstring(i) := 'R';
        when 's'    => retstring(i) := 'S';
        when 't'    => retstring(i) := 'T';
        when 'u'    => retstring(i) := 'U';
        when 'v'    => retstring(i) := 'V';
        when 'w'    => retstring(i) := 'W';
        when 'x'    => retstring(i) := 'X';
        when 'y'    => retstring(i) := 'Y';
        when 'z'    => retstring(i) := 'Z';
        when others => retstring(i) := instring(i);
      end case;
    end loop;  -- i

    return retstring;

  end ucase;



--     purpose: Compares two strings for equality, case dependent
  function case_sensitive_compare(a, b : string) return boolean is
    variable retval : boolean := true;
  begin
    --If strings are not the same length can they not be considered equivalent
    if not(a'length = b'length) then
      retval := false;
    else
      --if strings are the same length
      --compare each character
      for i in a'low to a'high loop
        --if a character doesn't match, return false
        if a(i) /= b(i) then
          retval := false;
        end if;
      end loop;  -- i
    end if;
    return retval;
  end case_sensitive_compare;



--      purpose: Compares two strings for equality, ignoring case differences.
  function case_insensitive_compare(a, b : string) return boolean is
  begin
    return case_sensitive_compare(ucase(a), ucase(b));
  end case_insensitive_compare;

  -----------------------------------------------------------------------------
  -- functions imported from iputils_family
  -----------------------------------------------------------------------------

  -- Returns 'true' if architecture "child" is derived from, or equal to,
  -- the architecture "ancestor".
  function derived (child, ancestor : string) return boolean is
    ---------------------------------------------------------------------------
    -- 
    -- This list of constants needs to be updated when new device families are released!
    --
    -- Use "go_xilinx -x <release_build> -cust_rtf partgen" to show the list of
    -- supported devices for that build
    --
    -- If you are editing this function, please try to continue with the pattern
    -- already present for the definition of the constants and the if/elsif blocks
    --
    ---------------------------------------------------------------------------

    ---------------------------------------------------------------------------
    -- Any supported device
    ---------------------------------------------------------------------------
    constant any          : string  := "any";
    ---------------------------------------------------------------------------
    -- 4000 series
    ---------------------------------------------------------------------------
    constant x4k           : string := "x4k";
    constant x4ke          : string := "x4ke";
    constant x4kl          : string := "x4kl";
    constant x4kex         : string := "x4kex";
    constant x4kxl         : string := "x4kxl";
    constant x4kxv         : string := "x4kxv";
    constant x4kxla        : string := "x4kxla";
    ---------------------------------------------------------------------------
    -- Spartan series
    ---------------------------------------------------------------------------
    -- Spartan
    constant spartan       : string := "spartan";
    constant spartanxl     : string := "spartanxl";
    -- Spartan-2
    constant spartan2      : string := "spartan2";
    -- Spartan-2E
    constant spartan2e     : string := "spartan2e";
    constant aspartan2e    : string := "aspartan2e";
    -- Spartan-3
    constant spartan3      : string := "spartan3";
    constant aspartan3     : string := "aspartan3";
    -- Spartan-3E
    constant spartan3e     : string := "spartan3e";
    constant aspartan3e    : string := "aspartan3e";
    -- Spartan-3A(N)
    constant spartan3a     : string := "spartan3a";
    constant aspartan3a    : string := "aspartan3a";
    -- Spartan-3A-DSP
    constant spartan3adsp  : string := "spartan3adsp";
    constant aspartan3adsp : string := "aspartan3adsp";
    ---------------------------------------------------------------------------
    -- Virtex series
    ---------------------------------------------------------------------------
    -- Virtex
    constant virtex        : string := "virtex";
    constant qvirtex       : string := "qvirtex";
    constant qrvirtex      : string := "qrvirtex";
    -- Virtex-E
    constant virtexe       : string := "virtexe";
    constant qvirtexe      : string := "qvirtexe";
    -- Virtex-2
    constant virtex2       : string := "virtex2";
    constant qvirtex2      : string := "qvirtex2";
    constant qrvirtex2     : string := "qrvirtex2";
    -- Virtex-2-Pro
    constant virtex2p      : string := "virtex2p";
    -- Virtex-4
    constant virtex4       : string := "virtex4";
    constant avirtex4      : string := "avirtex4";
    constant qvirtex4      : string := "qvirtex4";
    constant qrvirtex4     : string := "qrvirtex4";
    -- Virtex-5
    constant virtex5       : string := "virtex5";
    constant qrvirtex5     : string := "qrvirtex5";
    ---------------------------------------------------------------------------
    variable is_derived   : boolean := false;
  begin
    ---------------------------------------------------------------------------
    -- 4000 series
    ---------------------------------------------------------------------------
    if equalIgnoreCase(child, x4k) then
      if (equalIgnoreCase(ancestor, x4k) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, x4kex) then
      if (equalIgnoreCase(ancestor, x4kex) or equalIgnoreCase(ancestor, x4K) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, x4kxl) then
      if (equalIgnoreCase(ancestor, x4kxl) or equalIgnoreCase(ancestor, x4kex) or equalIgnoreCase(ancestor, x4K) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, x4kxv) then
      if (equalIgnoreCase(ancestor, x4kxv) or equalIgnoreCase(ancestor, x4kxl) or equalIgnoreCase(ancestor, x4kex) or equalIgnoreCase(ancestor, x4K) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, x4kxla) then
      if (equalIgnoreCase(ancestor, x4kxla) or equalIgnoreCase(ancestor, x4kxv) or equalIgnoreCase(ancestor, x4kxl) or equalIgnoreCase(ancestor, x4kex) or equalIgnoreCase(ancestor, x4K) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, x4ke) then
      if (equalIgnoreCase(ancestor, x4ke) or equalIgnoreCase(ancestor, x4K) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, x4kl) then
      if (equalIgnoreCase(ancestor, x4kl) or equalIgnoreCase(ancestor, x4ke) or equalIgnoreCase(ancestor, x4K) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    ---------------------------------------------------------------------------
    -- Spartan series
    ---------------------------------------------------------------------------
    -- Spartan
    elsif equalIgnoreCase(child, spartan) then
      if (equalIgnoreCase(ancestor, spartan) or equalIgnoreCase(ancestor, x4k) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, spartanxl) then
      if (equalIgnoreCase(ancestor, spartanxl) or equalIgnoreCase(ancestor, spartan) or equalIgnoreCase(ancestor, x4k) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    -- Spartan-2
    elsif equalIgnoreCase(child, spartan2) then
      if (equalIgnoreCase(ancestor, spartan2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    -- Spartan-2E
    elsif equalIgnoreCase(child, spartan2e) then
      if (equalIgnoreCase(ancestor, spartan2e) or equalIgnoreCase(ancestor, spartan2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, aspartan2e) then
      if (equalIgnoreCase(ancestor, aspartan2e) or equalIgnoreCase(ancestor, spartan2e) or equalIgnoreCase(ancestor, spartan2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;      
    -- Spartan-3
    elsif equalIgnoreCase(child, spartan3) then
      if (equalIgnoreCase(ancestor, spartan3) or equalIgnoreCase(ancestor, virtex2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, aspartan3) then
      if (equalIgnoreCase(ancestor, aspartan3) or equalIgnoreCase(ancestor, spartan3) or equalIgnoreCase(ancestor, virtex2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    -- Spartan-3E
    elsif equalIgnoreCase(child, spartan3e) then
      if (equalIgnoreCase(ancestor, spartan3e) or equalIgnoreCase(ancestor, spartan3) or equalIgnoreCase(ancestor, virtex2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, aspartan3e) then
      if (equalIgnoreCase(ancestor, aspartan3e) or equalIgnoreCase(ancestor, spartan3) or equalIgnoreCase(ancestor, virtex2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    -- Spartan-3A(N)
    elsif equalIgnoreCase(child, spartan3a) then
      if (equalIgnoreCase(ancestor, spartan3a) or equalIgnoreCase(ancestor, spartan3) or equalIgnoreCase(ancestor, virtex2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, aspartan3a) then
      if (equalIgnoreCase(ancestor, aspartan3a) or equalIgnoreCase(ancestor, spartan3a) or equalIgnoreCase(ancestor, spartan3) or equalIgnoreCase(ancestor, virtex2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;      
    -- Spartan-3A-DSP
    elsif equalIgnoreCase(child, spartan3adsp) then
      if (equalIgnoreCase(ancestor, spartan3adsp) or equalIgnoreCase(ancestor, spartan3a) or equalIgnoreCase(ancestor, spartan3) or equalIgnoreCase(ancestor, virtex2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, aspartan3adsp) then
      if (equalIgnoreCase(ancestor, aspartan3adsp) or equalIgnoreCase(ancestor, spartan3adsp) or equalIgnoreCase(ancestor, spartan3a) or equalIgnoreCase(ancestor, spartan3) or equalIgnoreCase(ancestor, virtex2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;      
    ---------------------------------------------------------------------------
    -- Virtex series
    ---------------------------------------------------------------------------
    -- Virtex
    elsif equalIgnoreCase(child, virtex) then
      if (equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, qvirtex) then
      if (equalIgnoreCase(ancestor, qvirtex) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, qrvirtex) then
      if (equalIgnoreCase(ancestor, qrvirtex) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    -- Virtex-E
    elsif equalIgnoreCase(child, virtexe) then
      if (equalIgnoreCase(ancestor, virtexe) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, qvirtexe) then
      if (equalIgnoreCase(ancestor, qvirtexe) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    -- Virtex-2
    elsif equalIgnoreCase(child, virtex2) then
      if (equalIgnoreCase(ancestor, virtex2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, qvirtex2) then
      if (equalIgnoreCase(ancestor, qvirtex2) or equalIgnoreCase(ancestor, virtex2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, qrvirtex2) then
      if (equalIgnoreCase(ancestor, qrvirtex2) or equalIgnoreCase(ancestor, virtex2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    -- Virtex-2-Pro
    elsif equalIgnoreCase(child, virtex2p) then
      if (equalIgnoreCase(ancestor, virtex2p) or equalIgnoreCase(ancestor, virtex2) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    -- Virtex-4
    elsif equalIgnoreCase(child, virtex4) then
      if (equalIgnoreCase(ancestor, virtex4) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, avirtex4) then
      if (equalIgnoreCase(ancestor, avirtex4) or equalIgnoreCase(ancestor, virtex4) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, qvirtex4) then
      if (equalIgnoreCase(ancestor, qvirtex4) or equalIgnoreCase(ancestor, virtex4) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, qrvirtex4) then
      if (equalIgnoreCase(ancestor, qrvirtex4) or equalIgnoreCase(ancestor, virtex4) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    -- Virtex-5
    elsif equalIgnoreCase(child, virtex5) then
      if (equalIgnoreCase(ancestor, virtex5) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;
    elsif equalIgnoreCase(child, qrvirtex5) then
      if (equalIgnoreCase(ancestor, qrvirtex5) or equalIgnoreCase(ancestor, virtex5) or equalIgnoreCase(ancestor, virtex) or equalIgnoreCase(ancestor, any)) then
        is_derived := true;
      end if;      
    ---------------------------------------------------------------------------
    -- Any other family
    ---------------------------------------------------------------------------
    elsif equalIgnoreCase(child, any) then
      if equalIgnoreCase(ancestor, any) then
        is_derived := true;
      end if;
    end if;

    return is_derived;
  end derived;

  -- Returns true if case insensitive string comparison determines that
  -- str1 and str2 are equal
  function equalIgnoreCase(str1, str2 : string) return boolean is
    constant len1  : integer := str1'length;
    constant len2  : integer := str2'length;
    variable equal : boolean := true;
  begin
    if not (len1 = len2) then
      equal := false;
    else
      equal := case_insensitive_compare(str1, str2);
    end if;
    return equal;
  end equalIgnoreCase;

  -- purpose: checks if the family string passed in is one of the valid families in the
  -- constant list in the header of the 'derived' FUNCTION
  -- If you need to check for specific families, you need to call the derived FUNCTION
  -- as below but with only the family names required in place of "any"
  function valid_family (family : string) return boolean is
  begin  -- FUNCTION valid_family
    return derived(family, "any");
  end function valid_family;

  -- purpose: converts c_xdevicefamily to c_family to make generic checking quicker
  function c_xdevicefamily_to_c_family (xdevicefamily : string) return string is
  begin  -- FUNCTION c_xdevicefamily_to_c_family

    -- we need to perform the checking based on the latest Virtex and Spartan
    -- device being checked FIRST

    -- check Spartan-series devices
    if derived(xdevicefamily, "spartan3") then  -- Spartan-3(E)(L)(A)
      return "spartan3";
    end if;

    -- check Virtex-series devices
    if derived(xdevicefamily, "virtex5") then
      return "virtex5";
    elsif derived(xdevicefamily, "virtex4") then
      return "virtex4";
    elsif derived(xdevicefamily, "virtex2") then  -- includes Virtex-2P
      return "virtex2";
    elsif derived(xdevicefamily, "virtex") then
      return "virtex";
    end if;

    -- if none of the above conditionals have returned,
    -- return a sensible error string instead
    return "invalid_c_xdevicefamily";
    
  end function c_xdevicefamily_to_c_family;

  -----------------------------------------------------------------------------
  -- note that we have to use the string representations of the family names in
  -- these functions because the constants are declared locally in the 'derived'
  -- function.  We cannot declare them globally otherwise they clash with the
  -- enumerated device names in pkg_baseblox
  -----------------------------------------------------------------------------

  -- purpose: returns true if the device family passed in as the argument contains DSP48 or DSP48E primitives
  function has_dsp (family : string) return boolean is
  begin  -- FUNCTION has_dsp
    return derived(family, "virtex4") or derived(family, "virtex5") or derived(family, "spartan3adsp");
  end function has_dsp;

  -- purpose: returns true if the device family passed in as the argument contains DSP48 blocks
  function has_dsp48 (family : string) return boolean is
  begin  -- FUNCTION has_dsp48
    return derived(family, "virtex4");
  end function has_dsp48;

  -- purpose: returns true if the device family passed in as the argument contains DSP48E blocks
  function has_dsp48e (family : string) return boolean is
  begin  -- FUNCTION has_dsp48e
    return derived(family, "virtex5");
  end function has_dsp48e;

  -- purpose: returns true if the device family passed in as the argument contains DSP48A blocks
  function has_dsp48a (family : string) return boolean is
  begin  -- FUNCTION has_dsp48a
    return derived(family, "spartan3adsp");
  end function has_dsp48a;

  -- purpose: returns true if the device family passed in as the argument contains MULT18X18(S) blocks
  function has_mult18x18 (family : string) return boolean is
  begin  -- FUNCTION has_mult18
    return derived(family, "virtex2") or derived(family, "virtex2p") or derived(family, "spartan3");
  end function has_mult18x18;

  -- purpose: wrapper for has_mult18x18
  function has_mult18x18s (family : string) return boolean is
  begin  -- FUNCTION has_mult18x18s
    return has_mult18x18(family);
  end function has_mult18x18s;

  -- purpose: returns true if the device family passed in as the argument contains MULT18X18SIO blocks
  function has_mult18x18sio (family : string) return boolean is
  begin  -- FUNCTION has_mult18x18sio
    return derived(family, "spartan3e") or derived(family, "spartan3a");
  end function has_mult18x18sio;

  -- purpose: returns true if the device family passed in as the argument contains SRLC16(E) primitives
  -- Includes Virtex-5 as the SRL(C)16(E) can be used as a legacy mode or for power saving
  function has_SRLC16E (family : string) return boolean is
  begin  -- FUNCTION has_SRLC16E
    return derived(family, "virtex2") or derived(family, "virtex2p") or derived(family, "spartan3") or derived(family, "spartan3e") or derived(family, "spartan3a") or derived(family, "spartan3adsp") or derived(family, "virtex4") or derived(family, "virtex5");
  end function has_SRLC16E;

  -- purpose: returns true if the device family passed in as the argument contains SRLC32E primitives
  function has_SRLC32E (family : string) return boolean is
  begin  -- FUNCTION has_SRLC32E
    return derived(family, "virtex5");
  end function has_SRLC32E;

  -- purpose: returns true if the family in question has 4-input LUTs
  -- everything except Virtex-5....
  function has_lut4 (family : string) return boolean is
  begin  -- FUNCTION has_lut4
    return not(derived(family, "virtex5"));
  end function has_lut4;

  -- purpose: returns true if the family in question has 6-input LUTs
  function has_lut6 (family : string) return boolean is
  begin  -- FUNCTION has_lut6
    return derived(family, "virtex5");
  end function has_lut6;

  -----------------------------------------------------------------------------
  -- New Routines
  -----------------------------------------------------------------------------

  --This function gives a robust way of assigning a string to a string where
  --the lengths and directions may not match.
  function str_to_bound_str (           -- G.Old 30/5/06
    instring  : string;                 -- unknown direction
    outlength : integer;                -- return string length
    pad       : string)                 -- fill pattern character
    return string is
    variable ret       : string(1 to outlength);
    constant rectified : string(1 to instring'length) := instring;
    constant inlength  : integer                      := instring'length;
  begin  -- str_to_bound_str
    for i in ret'range loop
      ret(i) := pad(pad'right);  --in case some eejit makes pad > 1 character
    end loop;
    if outlength >= inlength then
      ret(ret'left+outlength-inlength to ret'right) := rectified;
    else
      ret := rectified(rectified'left+inlength-outlength to rectified'right);
    end if;
    return ret;
  end str_to_bound_str;


  -- xcc exclude
  -----------------------------------------------------------------------------
  -- File I/O routines
  -----------------------------------------------------------------------------

  -- Function to read a MIF file and place the data in a STD_LOGIC_VECTOR
  -- Takes parameters:
  --   filename : Name of the file from which to read data
  --   depth    : Depth of memory in words
  --   width    : Width of memory in bits
  --   lines    : Number of lines to be read from file
  --              If the file has fewer lines then only the available
  --              data is read. If lines > depth then the return vector
  --              is padded with '0's.
  impure function read_meminit_file(filename : in string; depth, width, lines : in positive) return std_logic_vector is
    file meminitfile     : text;
    variable mif_status  : file_open_status;
    variable bit         : integer;
    variable bitline     : line;
    variable bitchar     : character;
    variable bits_good   : boolean;
    variable offset      : integer                                  := 0;
    variable total_lines : integer;
    variable num_lines   : integer                                  := 0;
    variable mem_vector  : string(width downto 1);
    variable return_vect : std_logic_vector(width*lines-1 downto 0) := (others => '0');
  begin

    file_open(mif_status, meminitfile, filename, read_mode);  -- does not compile with XCC when using xbld
--    meminitfile := file_open(mif_status, filename, read_mode); -- works with XCC

    assert mif_status = open_ok report "Error: couldn't open MIF file " & filename severity failure;

    if mif_status = open_ok then
      
      if (lines > 0 and lines <= depth) then
        total_lines := lines;
      else
        total_lines := depth;
      end if;

      while (not(ENDFILE(meminitfile)) and (num_lines < total_lines)) loop
        READLINE(meminitfile, bitline);
        exit when endfile(meminitfile);  -- XST safety net
        READ(bitline, mem_vector, bits_good);
        assert bits_good report "Error: problem reading MIF file " & filename severity failure;
        for bit in 0 to width-1 loop
          bitchar := mem_vector(bit+1);
          if (bitchar = '1') then
            return_vect(offset+bit) := '1';
          else
            return_vect(offset+bit) := '0';
          end if;
        end loop;  -- FOR
        num_lines := num_lines+1;
        offset    := offset + width;
      end loop;  -- WHILE      
    end if;  -- mif_status

    -- close the file being read from
    file_close(meminitfile);

    return return_vect;
    
  end read_meminit_file;

  impure function write_meminit_file(filename : in string; depth, width : in positive; memvect : in std_logic_vector) return boolean is
    file meminitfile        : text;
    variable mif_status     : file_open_status;
    variable addrs          : integer;
    variable bit            : integer;
    variable bitline        : line;
    variable bitstring      : string(width downto 1);
    variable slv            : std_logic_vector(width downto 1);
    variable offset         : integer;
    variable contents       : std_logic_vector(1 to width);
    constant mem_bits       : integer := depth * width;
    constant vec_bits       : integer := memvect'length;
    variable padded_memvect : std_logic_vector(1 to mem_bits);
    variable check_ok       : boolean;
  begin

    assert false report "writing MIF " & filename severity note;

    -- created a padded out vector that has the same number of bits in it as is specified by mem_bits
    padded_memvect(1 to memvect'length) := memvect;

    if memvect'length < mem_bits then
      padded_memvect(memvect'length+1 to mem_bits) := (others => '0');
    end if;

    file_open(mif_status, meminitfile, filename, write_mode);  -- does not compile with XCC when using xbld
--    meminitfile := file_open(mif_status, filename, read_mode); -- works with XCC

    assert mif_status = open_ok
      report "Error: couldn't open memory initialization file."
      severity failure;
    
    if mif_status = open_ok then
      offset := 0;
      for addrs in 0 to depth-1 loop
        contents := padded_memvect(padded_memvect'high-offset-width+1 to padded_memvect'high-offset);
        write(bitline, slv_to_bv(slv));  -- convert the SLV to a BV to use std.textio.write function
        writeline(meminitfile, bitline);
        offset   := offset + width;
      end loop;  -- addrs      
    end if;  -- mif_status
    -- close the file we wrote to
    FILE_CLOSE(meminitfile);
    return true;                        -- XCC requires a return value    
  end write_meminit_file;
  -- xcc include
  
  -----------------------------------------------------------------------------
  -- Simulation functions moved from ul_utils
  -----------------------------------------------------------------------------

  function anyX(vect : std_logic_vector) return boolean is
  begin
    for i in vect'range loop
      if (rat(vect(i)) = 'X') then
        return true;
      end if;
    end loop;
    return false;
  end anyX;

  function any0(vect : std_logic_vector) return boolean is
  begin
    for i in vect'range loop
      if (rat(vect(i)) = '0') then
        return true;
      end if;
    end loop;
    return false;
  end any0;

  function setallX(width : integer) return std_logic_vector is
    variable vect : std_logic_vector(width-1 downto 0);
  begin
    for i in 0 to width-1 loop
      vect(i) := 'X';
    end loop;
    return vect;
  end setallX;

  function setall0(width : integer) return std_logic_vector is
    variable vect : std_logic_vector(width-1 downto 0);
  begin
    for i in 0 to width-1 loop
      vect(i) := '0';
    end loop;
    return vect;
  end setall0;

  -----------------------------------------------------------------------------
  -- Start of code lifted from pkg_baseblox
  -----------------------------------------------------------------------------
  function fn_select_sync_enable (
    sync_enable : integer               -- the legacy type
    )
    return T_SYNC_ENABLE is
  begin
    case sync_enable is
      when c_override =>
        return SYNC_OVERRIDES_CE;
      when c_no_override =>
        return CE_OVERRIDES_SYNC;
      when others =>
        assert false report "illegal value of sync_enable. Defaulting to sync_overrides_ce" severity warning;
        return SYNC_OVERRIDES_CE;
    end case;
  end;  --fn_select_sync_enable
  
  function fn_select_bypass_enable (
    bypass_enable : integer             -- the legacy type
    )
    return T_BYPASS_ENABLE is
  begin
    case bypass_enable is
      when c_override =>
        return BYPASS_OVERRIDES_CE;
      when c_no_override =>
        return CE_OVERRIDES_BYPASS;
      when others =>
        assert false report "illegal value of BYPASS_enable. Defaulting to BYPASS_overrides_ce" severity warning;
        return BYPASS_OVERRIDES_CE;
    end case;
  end;  --fn_select_BYPASS_enable
  
  function fn_select_sync_priority (
    sync_priority : integer             -- the legacy type
    )
    return T_REG_PRIORITY is
  begin
    case sync_priority is
      when c_set =>
        return SET_OVERRIDES_RESET;
      when c_clear =>
        return RESET_OVERRIDES_SET;
      when others =>
        assert false report "illegal value of sync_priority. Defaulting to reset overrides set" severity warning;
        return RESET_OVERRIDES_SET;
    end case;
  end;  --fn_select_sync_priority
  
  function fn_select_reg_type (
    reg_type : integer                  -- the legacy type
    )
    return T_REGTYPE is
  begin
    case reg_type is
      when c_reg_undefined =>
        assert false report "Undefined Register type. Must be FF or latch" severity warning;
        return REGTYPE_FD;
      when c_reg_fd =>
        return REGTYPE_FD;
      when c_reg_ld =>
        return REGTYPE_LD;
      when others =>
        assert false report "Unknown Register type. Must be FF or latch" severity warning;
        return REGTYPE_FD;
    end case;
  end;  --fn_select_reg_type

  function fn_select_add_mode(add_mode : integer) return T_ADD_MODE is
    variable ret_val : T_ADD_MODE;
  begin
    case add_mode is
      when c_add     => ret_val := MODE_ADD;
      when c_sub     => ret_val := MODE_SUB;
      when c_add_sub => ret_val := MODE_ADDSUB;
      when others =>
        assert false report "Invalid add mode value. Must be add, subtract, or add/subtract. Defaulting to add" severity warning;
        ret_val := MODE_ADD;
    end case;
    return ret_val;
  end;

  function fn_select_number_format(number_format : integer) return T_NUMBER_FORMAT is
    variable ret_val : T_NUMBER_FORMAT;
  begin
    case number_format is
      when c_signed   => ret_val := NUM_SIGNED;
      when c_unsigned => ret_val := NUM_UNSIGNED;
      when c_pin      => ret_val := NUM_PIN;
      when others =>
        assert false report "Invalid number format specified. Must be c_signed, c_unsigned or c_pin. Defaulting to c_signed" severity warning;
        ret_val := NUM_SIGNED;
    end case;
    return ret_val;
  end;

  -- purpose: Checks the family generic string for a valid device family name
  -- and defaults to virtex2 if it is not specified or misspelt
  -- We define an 8-character string and put the family string into it.
  -- This avoids the warning from XST that the string lengths in the IF statement
  -- comparisons are different lengths.  
  function fn_check_family(family : string) return T_DEVICE_FAMILY is
    variable fam : string(1 to 12) := "            ";
  begin  -- FUNCTION fn_check_family

    -- Have to assign character by character for VTFC support
    -- The original code was:
        --fam(1 to family'length) := family;
    for i in 1 to family'length loop
      fam(i) := family(i);
    end loop;  -- i
        
    if fam = "spartan2    " then
      return SPARTAN2;
    elsif fam = "spartan3    " then  -- spartan3e appears as spartan3 in CoreGen
      return SPARTAN3;
    elsif fam = "spartan3e   " then  -- add a separate entry for S3E to let us use c_xdevicefamily too
      return SPARTAN3E;
    elsif fam = "spartan3a   " then
      return SPARTAN3A;
    elsif fam = "spartan3adsp" then
      return SPARTAN3ADSP;
    elsif fam = "virtex      " then
      return VIRTEX;
    elsif fam = "virtex2     " then
      return VIRTEX2;
    elsif fam = "virtex2p    " then  -- some cores differentiate between V2 and V2P
      return VIRTEX2;
    elsif fam = "virtex4     " then
      return VIRTEX4;
    elsif fam = "virtex5     " then
      return VIRTEX5;
    else
      assert false report "WARNING: Invalid or misspelt device family generic caught in fn_check_family!" & CR & "Valid family names are: spartan2, spartan3, spartan3e, virtex, virtex2, virtex2p, virtex4 and virtex5" & CR & "Defaulting to Virtex-2" severity warning;
      return VIRTEX2;
    end if;
  end;

  --The following utility function calculates the number of synchronous
  --controls which must be gated into the logic for the d input of a register
  --This can be useful in optimising logic to the register.
  function fn_syncs_in_d_lut (
    has_sclr, has_sset, has_sinit, has_aclr, has_aset, has_ainit : integer  -- the legacy type
    )
    return integer is
  begin
    if has_aclr = 0 and has_aset = 0 and has_ainit = 0 then
      return 0;
    elsif has_sinit /= 0 then
      return 1;
    elsif has_sclr = 0 then
      if has_sset = 0 then
        return 0;
      else
        return 1;
      end if;
    else
      if has_sset = 0 then
        return 1;
      else
        return 2;
      end if;
    end if;
  end;  --fn_select_reg_type

-- purpose: Determines the LUT size used in the target architecture specified by device_family
  function fn_get_lut_size(device_family : T_DEVICE_FAMILY) return integer is
  begin  -- FUNCTION fn_get_lut_size
    case device_family is
      when VIRTEX4 | VIRTEX2 | SPARTAN3 | SPARTAN3E | SPARTAN3A | SPARTAN3ADSP | VIRTEX | SPARTAN2 => return 4;
      when VIRTEX5                                                                                 => return 6;
      when others =>
        assert false
          report "ERROR: Invalid device_family detected in fn_get_lut_size, so cannot determine LUT size - defaulting to four-input LUT and returning 4"
          severity warning;
        return 4;
    end case;
  end function fn_get_lut_size;


  -- purpose: Determines what the POR value should be from the register controls that are present
  function fn_get_por_value(c_has_aclr, c_has_aset, c_has_ainit, c_has_sclr, c_has_sset, c_has_sinit : integer;
                            ainit_val, sinit_val                                                     : std_logic_vector;
                            c_width                                                                  : integer) return std_logic_vector is
    variable ret : std_logic_vector(c_width downto 1);
  begin  -- FUNCTION fn_get_por_value
    -- define power-up value
    if c_has_aclr /= 0 then
      ret := (others => '0');
    elsif c_has_aset /= 0 then
      ret := (others => '1');
    elsif c_has_ainit /= 0 then
      ret := ainit_val;
    elsif (c_has_sclr /= 0) then
      ret := (others => '0');
    elsif (c_has_sset /= 0) then
      ret := (others => '1');
    elsif (c_has_sinit /= 0) then
      ret := sinit_val;
    else
      ret := ainit_val;
    end if;
    return ret;
  end function fn_get_por_value;
  
end bip_utils_pkg_v1_0;


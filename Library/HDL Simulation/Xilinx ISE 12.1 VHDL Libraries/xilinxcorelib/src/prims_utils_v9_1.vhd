-- $Id: prims_utils_v9_1.vhd,v 1.7 2008/09/08 19:36:39 akennedy Exp $
-------------------------------------------------------------------------------
--  Copyright(C) 1995-2007 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2007 Xilinx, Inc.
--  All rights reserved.
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
--USE ieee.std_logic_textio.ALL;          -- allows writing of std_logic_vector

LIBRARY std;
USE std.standard.ALL;
USE std.textio.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v9_1.ALL;

PACKAGE prims_utils_v9_1 IS

  -----------------------------------------------------------------------------
  -- original prims_utils functions
  -----------------------------------------------------------------------------
  
  FUNCTION bv_to_slv(bitsin           : BIT_VECTOR) RETURN STD_LOGIC_VECTOR;
  FUNCTION str_to_slv(bitsin          : STRING) RETURN STD_LOGIC_VECTOR;
  FUNCTION str_to_slv_0(bitsin        : STRING; nbits : INTEGER) RETURN STD_LOGIC_VECTOR;
  FUNCTION str_to_slv_1(bitsin        : STRING; nbits : INTEGER) RETURN STD_LOGIC_VECTOR;
  FUNCTION str_to_bound_slv(bitsin    : STRING; nbits : INTEGER; pad : STD_LOGIC) RETURN STD_LOGIC_VECTOR;
  FUNCTION str_to_bound_slv_0 (bitsin : STRING; nbits : INTEGER) RETURN STD_LOGIC_VECTOR;
  FUNCTION str_to_bv(bitsin           : STRING) RETURN BIT_VECTOR;
  FUNCTION b_to_sl(bitin              : BIT) RETURN STD_LOGIC;
  FUNCTION char_to_sl(bitin           : CHARACTER) RETURN STD_LOGIC;
  FUNCTION slv_to_bv(bitsin           : STD_LOGIC_VECTOR) RETURN BIT_VECTOR;
  FUNCTION slv_to_str(bitsin          : STD_LOGIC_VECTOR) RETURN STRING;
  FUNCTION sl_to_b(bitin              : STD_LOGIC) RETURN BIT;
  FUNCTION sl_to_char(bitin           : STD_LOGIC) RETURN CHARACTER;
  FUNCTION int_to_str(int_value       : INTEGER) RETURN STRING;
  FUNCTION all_Xs (i                  : INTEGER) RETURN STD_LOGIC_VECTOR;
  FUNCTION sl_to_str(sl               : STD_LOGIC) RETURN STRING;
  FUNCTION padded_slv_to_str (slv     : STD_LOGIC_VECTOR; width : INTEGER) RETURN STRING;

  -----------------------------------------------------------------------------
  -- functions imported from iputils_conv
  -----------------------------------------------------------------------------

  FUNCTION rat(value                    : STD_LOGIC) RETURN STD_LOGIC;
  FUNCTION slv_to_int(vect              : STD_LOGIC_VECTOR) RETURN INTEGER;
  FUNCTION two_comp(vect                : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR;
  FUNCTION int_to_slv(value, bitwidth   : INTEGER) RETURN STD_LOGIC_VECTOR;
  FUNCTION slv_to_posint(vect           : STD_LOGIC_VECTOR) RETURN INTEGER;
  FUNCTION int_to_string(val            : INTEGER) RETURN STRING;  -- duplicate of int_to_str..
  FUNCTION bool_to_str (val             : BOOLEAN) RETURN STRING;
  FUNCTION number_of_digits (data_value : INTEGER; radix : INTEGER) RETURN INTEGER;
  FUNCTION conv_int_to_new_radix(number : INTEGER; target_str_len : INTEGER; target_radix : INTEGER) RETURN STRING;
  FUNCTION int_to_hex(value, bitwidth   : INTEGER) RETURN STRING;
  FUNCTION bin_to_hex_string(bin        : STRING) RETURN STRING;
  FUNCTION hexstr_to_slv(arg1           : STRING; size : INTEGER) RETURN STD_LOGIC_VECTOR;

  -----------------------------------------------------------------------------
  -- functions imported from iputils_math
  -----------------------------------------------------------------------------

  FUNCTION addr_width_for_depth (depth         : INTEGER) RETURN INTEGER;
  FUNCTION binary_width_of_integer (data_value : INTEGER) RETURN INTEGER;
  FUNCTION log2roundup (data_value             : INTEGER) RETURN INTEGER;
  FUNCTION get_min (a                          : INTEGER; b : INTEGER) RETURN INTEGER;
  FUNCTION get_max (a                          : INTEGER; b : INTEGER) RETURN INTEGER;
  FUNCTION div4roundup (data_value             : INTEGER) RETURN INTEGER;
  FUNCTION divroundup (data_value              : INTEGER; divisor : INTEGER) RETURN INTEGER;
  FUNCTION divrounddown (data_value            : INTEGER; divisor : INTEGER) RETURN INTEGER;
  FUNCTION roundup_to_multiple(data_value      : INTEGER; multipleof : INTEGER) RETURN INTEGER;
  FUNCTION rand_int_base (seed                 : INTEGER; maxval : INTEGER; iterations : INTEGER; feedback_val : INTEGER) RETURN INTEGER;
  FUNCTION rand_int (seed                      : INTEGER; maxval : INTEGER) RETURN INTEGER;
  FUNCTION rand_slv_bits (seed                 : INTEGER; width : INTEGER) RETURN STD_LOGIC_VECTOR;
  FUNCTION rand_slv (seed                      : INTEGER; width : INTEGER; maxval : INTEGER) RETURN STD_LOGIC_VECTOR;

  -----------------------------------------------------------------------------
  -- functions imported from iputils_misc
  -----------------------------------------------------------------------------

  FUNCTION index_in_str(stringtosearch   : STRING; stringsize : INTEGER; char : STRING; instnum : INTEGER) RETURN INTEGER;
  FUNCTION lcase(instring                : STRING) RETURN STRING;
  FUNCTION ucase(instring                : STRING) RETURN STRING;
  FUNCTION case_sensitive_compare(a, b   : STRING) RETURN BOOLEAN;
  FUNCTION case_insensitive_compare(a, b : STRING) RETURN BOOLEAN;

  -----------------------------------------------------------------------------
  -- functions imported from iputils_family
  -----------------------------------------------------------------------------

  FUNCTION derived (child, ancestor   : STRING) RETURN BOOLEAN;
  FUNCTION equalIgnoreCase(str1, str2 : STRING) RETURN BOOLEAN;

  -----------------------------------------------------------------------------
  -- new family-related functions as of 17th Feb 2006
  -----------------------------------------------------------------------------
  FUNCTION valid_family (family                       : STRING) RETURN BOOLEAN;
  FUNCTION c_xdevicefamily_to_c_family (xdevicefamily : STRING) RETURN STRING;
  FUNCTION has_dsp (family                            : STRING) RETURN BOOLEAN;
  FUNCTION has_dsp48 (family                          : STRING) RETURN BOOLEAN;
  FUNCTION has_dsp48e (family                         : STRING) RETURN BOOLEAN;
  FUNCTION has_dsp48a (family                         : STRING) RETURN BOOLEAN;
  FUNCTION has_mult18x18 (family                      : STRING) RETURN BOOLEAN;
  FUNCTION has_mult18x18s (family                     : STRING) RETURN BOOLEAN;
  FUNCTION has_mult18x18sio (family                   : STRING) RETURN BOOLEAN;
  FUNCTION has_SRLC16E (family                        : STRING) RETURN BOOLEAN;
  FUNCTION has_SRLC32E (family                        : STRING) RETURN BOOLEAN;
  FUNCTION has_LUT4 (family                           : STRING) RETURN BOOLEAN;
  FUNCTION has_LUT6 (family                           : STRING) RETURN BOOLEAN;

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

  IMPURE FUNCTION read_meminit_file(filename  : IN STRING; depth, width, lines : IN POSITIVE) RETURN STD_LOGIC_VECTOR;
  IMPURE FUNCTION write_meminit_file(filename : IN STRING; depth, width : IN POSITIVE; memvect : IN STD_LOGIC_VECTOR) RETURN BOOLEAN;

  -----------------------------------------------------------------------------
  -- Simulation functions moved from ul_utils
  -----------------------------------------------------------------------------

  FUNCTION anyX(vect     : STD_LOGIC_VECTOR) RETURN BOOLEAN;
  FUNCTION any0(vect     : STD_LOGIC_VECTOR) RETURN BOOLEAN;
  FUNCTION setallX(width : INTEGER) RETURN STD_LOGIC_VECTOR;
  FUNCTION setall0(width : INTEGER) RETURN STD_LOGIC_VECTOR;

  -----------------------------------------------------------------------------
  -- other stuff
  -----------------------------------------------------------------------------

  TYPE log2array IS ARRAY (0 TO 128) OF INTEGER;
  CONSTANT log2 : log2array := (0, 0,
                                1,
                                2, 2,
                                3, 3, 3, 3,
                                4, 4, 4, 4, 4, 4, 4, 4,
                                5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
                                6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
                                6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
                                7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
                                7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
                                7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
                                7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7);  

  COMPONENT PIPELINE_V8_0
    GENERIC (C_AINIT_VAL     : STRING  := "";
             C_HAS_ACLR      : INTEGER := 0;
             C_HAS_AINIT     : INTEGER := 0;
             C_HAS_ASET      : INTEGER := 0;
             C_HAS_CE        : INTEGER := 0;
             C_HAS_SCLR      : INTEGER := 0;
             C_HAS_SINIT     : INTEGER := 0;
             C_HAS_SSET      : INTEGER := 0;
             C_PIPE_STAGES   : INTEGER := 1;
             C_SINIT_VAL     : STRING  := "";
             C_SYNC_ENABLE   : INTEGER := c_override;
             C_SYNC_PRIORITY : INTEGER := c_clear;
             C_WIDTH         : INTEGER := 16); 
    PORT (D     : IN  STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0);   -- Input value
          CLK   : IN  STD_LOGIC := '0';                       -- Clock
          CE    : IN  STD_LOGIC := '1';                       -- Clock Enable
          ACLR  : IN  STD_LOGIC := '0';                       -- Asynch clear.
          ASET  : IN  STD_LOGIC := '0';                       -- Asynch set.
          AINIT : IN  STD_LOGIC := '0';                       -- Asynch init.
          SCLR  : IN  STD_LOGIC := '0';                       -- Synch clear.
          SSET  : IN  STD_LOGIC := '0';                       -- Synch set.
          SINIT : IN  STD_LOGIC := '0';                       -- Synch init.
          Q     : OUT STD_LOGIC_VECTOR(C_WIDTH-1 DOWNTO 0));  -- Output value
  END COMPONENT;

END prims_utils_v9_1;

PACKAGE BODY prims_utils_v9_1 IS

  -- purpose: converts a bit_vector to a std_logic_vector
  FUNCTION bv_to_slv(bitsin : BIT_VECTOR) RETURN STD_LOGIC_VECTOR IS
    VARIABLE ret : STD_LOGIC_VECTOR(bitsin'range);
  BEGIN
    FOR i IN bitsin'range LOOP
      IF bitsin(i) = '1' THEN
        ret(i) := '1';
      ELSE
        ret(i) := '0';
      END IF;
    END LOOP;

    RETURN ret;
  END bv_to_slv;

  -- purpose: converts a string to a std_logic_vector
  FUNCTION str_to_slv(bitsin : STRING) RETURN STD_LOGIC_VECTOR IS
    VARIABLE ret : STD_LOGIC_VECTOR(bitsin'range);
  BEGIN
    FOR i IN bitsin'range LOOP
      IF bitsin(i) = '1' THEN
        ret(i) := '1';
      ELSIF (bitsin(i) = 'X' OR bitsin(i) = 'x') THEN
        ret(i) := 'X';
      ELSIF (bitsin(i) = 'Z' OR bitsin(i) = 'z') THEN
        ret(i) := 'Z';
      ELSIF (bitsin(i) = '0') THEN
        ret(i) := '0';
      END IF;
    END LOOP;

    RETURN ret;
  END str_to_slv;

  -- purpose: converts a string to a std_logic_vector with padding of 0's
  FUNCTION str_to_slv_0(bitsin : STRING; nbits : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE ret       : STD_LOGIC_VECTOR(bitsin'range);
    -- String types range from 1 to len!!!
    VARIABLE ret0s     : STD_LOGIC_VECTOR(1 TO nbits) := (OTHERS => '0');
    VARIABLE retpadded : STD_LOGIC_VECTOR(1 TO nbits) := (OTHERS => '0');
    VARIABLE offset    : INTEGER                      := 0;
  BEGIN
    IF(bitsin'length = 0) THEN          -- Make all '0's
      RETURN ret0s;
    END IF;
    IF(bitsin'length < nbits) THEN      -- pad MSBs with '0's
      offset := nbits - bitsin'length;
      FOR i IN bitsin'range LOOP
        IF bitsin(i) = '1' THEN
          retpadded(i+offset) := '1';
        ELSIF (bitsin(i) = 'X' OR bitsin(i) = 'x') THEN
          retpadded(i+offset) := 'X';
        ELSIF (bitsin(i) = 'Z' OR bitsin(i) = 'z') THEN
          retpadded(i+offset) := 'Z';
        ELSIF (bitsin(i) = '0') THEN
          retpadded(i+offset) := '0';
        END IF;
      END LOOP;
      retpadded(1 TO offset) := (OTHERS => '0');
      RETURN retpadded;
    END IF;
    FOR i IN bitsin'range LOOP
      IF bitsin(i) = '1' THEN
        ret(i) := '1';
      ELSIF (bitsin(i) = 'X' OR bitsin(i) = 'x') THEN
        ret(i) := 'X';
      ELSIF (bitsin(i) = 'Z' OR bitsin(i) = 'z') THEN
        ret(i) := 'Z';
      ELSIF (bitsin(i) = '0') THEN
        ret(i) := '0';
      END IF;
    END LOOP;

    RETURN ret;
  END str_to_slv_0;

  -- purpose: converts a string to a std_logic_vector with padding of 1's
  FUNCTION str_to_slv_1(bitsin : STRING; nbits : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE ret       : STD_LOGIC_VECTOR(bitsin'range);
    -- String types range from 1 to len!!!
    VARIABLE ret1s     : STD_LOGIC_VECTOR(1 TO nbits) := (OTHERS => '1');
    VARIABLE retpadded : STD_LOGIC_VECTOR(1 TO nbits) := (OTHERS => '1');
    VARIABLE offset    : INTEGER                      := 0;
  BEGIN
    IF(bitsin'length = 0) THEN          -- make all '1's
      RETURN ret1s;
    END IF;
    IF(bitsin'length < nbits) THEN      -- pad MSBs with '1's
      offset := nbits - bitsin'length;
      FOR i IN bitsin'range LOOP
        IF bitsin(i) = '1' THEN
          retpadded(i+offset) := '1';
        ELSIF (bitsin(i) = 'X' OR bitsin(i) = 'x') THEN
          retpadded(i+offset) := 'X';
        ELSIF (bitsin(i) = 'Z' OR bitsin(i) = 'z') THEN
          retpadded(i+offset) := 'Z';
        ELSIF (bitsin(i) = '0') THEN
          retpadded(i+offset) := '0';
        END IF;
      END LOOP;
      retpadded(1 TO offset) := (OTHERS => '1');
      RETURN retpadded;
    END IF;
    FOR i IN bitsin'range LOOP
      IF bitsin(i) = '1' THEN
        ret(i) := '1';
      ELSIF (bitsin(i) = 'X' OR bitsin(i) = 'x') THEN
        ret(i) := 'X';
      ELSIF (bitsin(i) = 'Z' OR bitsin(i) = 'z') THEN
        ret(i) := 'Z';
      ELSIF (bitsin(i) = '0') THEN
        ret(i) := '0';
      END IF;
    END LOOP;

    RETURN ret;
  END str_to_slv_1;

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
  FUNCTION str_to_bound_slv_0 (bitsin : STRING; nbits : INTEGER) RETURN STD_LOGIC_VECTOR IS
  BEGIN
    RETURN str_to_bound_slv(bitsin, nbits, '0');
  END str_to_bound_slv_0;

  -- purpose: converts a string to a bit_Vector
  FUNCTION str_to_bv(bitsin : STRING) RETURN BIT_VECTOR IS
    VARIABLE ret : BIT_VECTOR(bitsin'range);
  BEGIN
    FOR i IN bitsin'range LOOP
      IF bitsin(i) = '1' THEN
        ret(i) := '1';
      ELSIF (bitsin(i) = '0') THEN
        ret(i) := '0';
      ELSE
        ASSERT false
          REPORT "Cannot translate STR_TO_BV with unknowns in STR"
          SEVERITY error;
      END IF;
    END LOOP;

    RETURN ret;
  END str_to_bv;

  -- purpose: converts a bit value to a std_logic value
  FUNCTION b_to_sl(bitin : BIT) RETURN STD_LOGIC IS
    VARIABLE ret : STD_LOGIC;
  BEGIN
    IF bitin = '1' THEN
      ret := '1';
    ELSE
      ret := '0';
    END IF;
    RETURN ret;
  END b_to_sl;

  -- purpose: converts a character to a std_logic value
  FUNCTION char_to_sl(bitin : CHARACTER) RETURN STD_LOGIC IS
    VARIABLE ret : STD_LOGIC;
  BEGIN
    IF bitin = '1' THEN
      ret := '1';
    ELSIF bitin = 'X' OR bitin = 'x' THEN
      ret := 'X';
    ELSIF bitin = 'Z' OR bitin = 'z' THEN
      ret := 'Z';
    ELSE
      ret := '0';
    END IF;
    RETURN ret;
  END char_to_sl;

  -- purpose: converts a std_logic_vector to a bit_vector
  FUNCTION slv_to_bv(bitsin : STD_LOGIC_VECTOR) RETURN BIT_VECTOR IS
    VARIABLE ret : BIT_VECTOR(bitsin'range);
  BEGIN
    FOR i IN bitsin'range LOOP
      IF bitsin(i) = '1' THEN
        ret(i) := '1';
      ELSIF bitsin(i) = '0' THEN
        ret(i) := '0';
      ELSE
        ASSERT false
          REPORT "Cannot translate SLV_TO_BV with unknowns in SLV"
          SEVERITY error;
      END IF;
    END LOOP;

    RETURN ret;
  END slv_to_bv;

  -- purpose: converts a std_logic_Vector to a string
  FUNCTION slv_to_str(bitsin : STD_LOGIC_VECTOR) RETURN STRING IS
    VARIABLE ret : STRING(bitsin'range);
  BEGIN
    FOR i IN bitsin'range LOOP
      IF bitsin(i) = '1' THEN
        ret(i) := '1';
      ELSIF (bitsin(i) = 'X') THEN
        ret(i) := 'X';
      ELSIF (bitsin(i) = 'Z') THEN
        ret(i) := 'Z';
      ELSIF (bitsin(i) = 'U') THEN
        ret(i) := 'U';
      ELSIF (bitsin(i) = '0') THEN
        ret(i) := '0';
      END IF;
    END LOOP;

    RETURN ret;
  END slv_to_str;

  -- purpose: converts a std_logic value to a bit value
  FUNCTION sl_to_b(bitin : STD_LOGIC) RETURN BIT IS
    VARIABLE ret : BIT;
  BEGIN
    IF bitin = '1' THEN
      ret := '1';
    ELSE
      ret := '0';
    END IF;
    RETURN ret;
  END sl_to_b;

  -- purpose: converts a std_logic value to a character
  FUNCTION sl_to_char(bitin : STD_LOGIC) RETURN CHARACTER IS
    VARIABLE ret : CHARACTER;
  BEGIN
    IF bitin = '1' THEN
      ret := '1';
    ELSIF bitin = 'X' THEN
      ret := 'X';
    ELSIF bitin = 'Z' THEN
      ret := 'Z';
    ELSIF bitin = 'U' THEN
      ret := 'U';
    ELSE
      ret := '0';
    END IF;
    RETURN ret;
  END sl_to_char;

  -- purpose: converts an integer to a string
  FUNCTION int_to_str(int_value : INTEGER) RETURN STRING IS
  BEGIN
    RETURN INTEGER'image(int_value);
  END int_to_str;

  FUNCTION all_Xs(i : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE stmp : STD_LOGIC_VECTOR(i-1 DOWNTO 0) := (OTHERS => 'X');
  BEGIN
    RETURN stmp;
  END all_Xs;

  -- purpose: Converts std_logic 0 or 1 to equivalent STRING
  -- Added andreww 11/11/2004
  FUNCTION sl_to_str(sl : STD_LOGIC) RETURN STRING IS
  BEGIN  -- FUNCTION sl_to_str
    CASE sl IS
      WHEN '0'    => RETURN "0";
      WHEN '1'    => RETURN "1";
      WHEN OTHERS =>
        ASSERT false
          REPORT "WARNING: Unexpected STD_LOGIC value (not 0 or 1) detected - returning 0"
          SEVERITY warning;
        RETURN "0";
    END CASE;
  END FUNCTION sl_to_str;

  -- purpose: Converts std_logic_vectors to equivalent strings
  -- assumes the SLV is DOWNTO
  FUNCTION padded_slv_to_str (slv : STD_LOGIC_VECTOR; width : INTEGER) RETURN STRING IS
    VARIABLE ret : STRING(1 TO width);
  BEGIN  -- FUNCTION padded_slv_to_str
    FOR i IN 0 TO width-1 LOOP
      IF slv(i) = '1' THEN
        ret(width-i) := '1';
      ELSIF slv(i) = 'X' THEN
        ret(width-i) := 'X';
      ELSIF slv(i) = 'Z' THEN
        ret(width-i) := 'Z';
      ELSIF slv(i) = 'U' THEN
        ret(width-i) := 'U';
      ELSIF slv(i) = '0' THEN
        ret(width-i) := '0';
      END IF;
    END LOOP;
    RETURN ret;
  END FUNCTION padded_slv_to_str;

  -----------------------------------------------------------------------------
  -- new functions imported from iputils_conv
  -----------------------------------------------------------------------------

  -- purpose: rationalises input SL value
  -- utility function for functions below
  FUNCTION rat(value : STD_LOGIC) RETURN STD_LOGIC IS
  BEGIN
    CASE value IS
      WHEN '0' | '1' => RETURN value;
      WHEN 'H'       => RETURN '1';
      WHEN 'L'       => RETURN '0';
      WHEN OTHERS    => RETURN 'X';
    END CASE;
  END rat;

  -- purpose: returns two's complement of the input SLV
  FUNCTION two_comp(vect : STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
    VARIABLE local_vect : STD_LOGIC_VECTOR(vect'high DOWNTO 0);
    VARIABLE toggle     : INTEGER := 0;
  BEGIN
    FOR i IN 0 TO vect'high LOOP
      IF (toggle = 1) THEN
        IF (vect(i) = '0') THEN
          local_vect(i) := '1';
        ELSE
          local_vect(i) := '0';
        END IF;
      ELSE
        local_vect(i) := vect(i);
        IF (vect(i) = '1') THEN
          toggle := 1;
        END IF;
      END IF;
    END LOOP;
    RETURN local_vect;
  END two_comp;

  -- purpose: converts a std_logic_Vector to an integer
  FUNCTION slv_to_int(vect : STD_LOGIC_VECTOR) RETURN INTEGER IS
    VARIABLE local_vect : STD_LOGIC_VECTOR(vect'high DOWNTO 0);
    VARIABLE result     : INTEGER := 0;
  BEGIN
    IF (rat(vect(vect'high)) = '1') THEN  -- negative number
      local_vect := two_comp(vect);
    ELSE
      local_vect := vect;
    END IF;

    FOR i IN vect'high DOWNTO 0 LOOP
      result := result * 2;
      IF (rat(local_vect(i)) = '1') THEN
        result := result + 1;
      END IF;
    END LOOP;

    IF (rat(vect(vect'high)) = '1') THEN
      result := -1 * result;
    END IF;

    RETURN result;
    
  END slv_to_int;

  -- purpose: converts an integer value to a std_logic_Vector
  FUNCTION int_to_slv(value, bitwidth : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE running_value  : INTEGER := value;
    VARIABLE running_result : STD_LOGIC_VECTOR(bitwidth-1 DOWNTO 0);
  BEGIN
    
    IF (value < 0) THEN
      running_value := -1 * value;
    END IF;

    FOR i IN 0 TO bitwidth-1 LOOP
      
      IF running_value MOD 2 = 0 THEN
        running_result(i) := '0';
      ELSE
        running_result(i) := '1';
      END IF;
      running_value := running_value/2;
    END LOOP;

    IF (value < 0) THEN                 -- find the 2s complement
      RETURN two_comp(running_result);
    ELSE
      RETURN running_result;
    END IF;
  END int_to_slv;

  -- purpose: converts a std_logic_vector to a positive integer
  FUNCTION slv_to_posint(vect : STD_LOGIC_VECTOR) RETURN INTEGER IS
    VARIABLE result : INTEGER := 0;
  BEGIN
    FOR i IN vect'high DOWNTO vect'low LOOP
      result := result * 2;
      IF (rat(vect(i)) = '1') THEN
        result := result + 1;
      END IF;
    END LOOP;
    RETURN result;
  END slv_to_posint;

  -- purpose: converts an Integer value to a string
  FUNCTION int_to_string(val : INTEGER) RETURN STRING IS
  BEGIN
    RETURN INTEGER'image(val);
  END int_to_string;

  -- purpose: converts a Boolean value to a string
  FUNCTION bool_to_str (val : BOOLEAN) RETURN STRING IS
  BEGIN  -- FUNCTION bool_to_str
    IF val THEN
      RETURN "true";
    ELSE
      RETURN "false";
    END IF;
  END FUNCTION bool_to_str;

  -- purpose: Calculates the number of bits needed to represent the specified data_value
  -- based on the supplied radix
  FUNCTION number_of_digits (data_value : INTEGER; radix : INTEGER) RETURN INTEGER IS
    VARIABLE dwidth : INTEGER := 0;
  BEGIN
    WHILE radix**dwidth-1 < data_value AND data_value > 0 LOOP
      dwidth := dwidth + 1;
    END LOOP;
    RETURN dwidth;
  END number_of_digits;

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
  FUNCTION conv_int_to_new_radix(number : INTEGER; target_str_len : INTEGER; target_radix : INTEGER) RETURN STRING IS
    VARIABLE return_string   : STRING(1 TO target_str_len) := (OTHERS => '0');
    VARIABLE string_location : INTEGER                     := 0;
    VARIABLE tmp_string_val  : INTEGER                     := 0;
    VARIABLE new_number      : INTEGER                     := number;
    VARIABLE hexdigits       : STRING(1 TO 16)             := "0123456789ABCDEF";
    VARIABLE max_exp         : INTEGER                     := 0;
  BEGIN
    max_exp := number_of_digits(number, target_radix);
    IF target_str_len < max_exp THEN
      max_exp := target_str_len;
    END IF;

    new_number := number;

    FOR exp IN max_exp-1 DOWNTO 0 LOOP
      string_location                := target_str_len-exp;
      tmp_string_val                 := new_number/(target_radix**exp);
      new_number                     := new_number - tmp_string_val*(target_radix**exp);
      return_string(string_location) := hexdigits(tmp_string_val+1);
    END LOOP;
    RETURN return_string;
  END conv_int_to_new_radix;

--   purpose: Converts an integer to a hexidecimal string value
  FUNCTION int_to_hex(value, bitwidth : INTEGER) RETURN STRING IS
    VARIABLE hexdigits      : STRING(1 TO 16) := "0123456789ABCDEF";
    VARIABLE running_value  : INTEGER         := value;
    VARIABLE digit_value    : INTEGER         := 0;
    VARIABLE digit_position : INTEGER         := 1;
    VARIABLE results_string : STRING(1 TO bitwidth/4);
  BEGIN

    FOR i IN bitwidth-1 DOWNTO 0 LOOP

      IF (2**i) <= running_value THEN
        running_value := running_value - (2**i);
        digit_value   := digit_value + (2**(i MOD 4));
      END IF;

      IF i MOD 4 = 0 THEN
        results_string(digit_position) := hexdigits(1+digit_value);
        digit_value                    := 0;
        digit_position                 := digit_position + 1;
      END IF;

    END LOOP;

    RETURN results_string;

  END int_to_hex;

  -- purpose: Returns the ceiling value of the division by 4
  --  This version of this function is only for use by the
  --  bin_to_hex_string function.  Users should use
  --  div4roundup from iputils_math.
  FUNCTION div4roundup_v2 (data_value : INTEGER) RETURN INTEGER IS
    VARIABLE div : INTEGER;
  BEGIN
    div := data_value/4;
    IF ((data_value MOD 4) /= 0) THEN
      div := div+1;
    END IF;
    RETURN div;
  END div4roundup_v2;

  -- purpose: This function converts a standard logic vector to a string.
  FUNCTION bin_to_hex_string(bin : STRING) RETURN STRING IS
    VARIABLE hex_len : INTEGER := div4roundup_v2(bin'high);
    VARIABLE bin_ext : STRING(1 TO hex_len*4);
    VARIABLE hex     : STRING(1 TO hex_len);
    VARIABLE sub_bin : STRING (1 TO 4);
  BEGIN

    -- extend binary string to a multiple of 4
    FOR j IN 1 TO hex_len*4 LOOP
      IF (j <= hex_len*4-bin'high) THEN
        bin_ext(j) := '0';
      ELSE
        bin_ext(j) := bin(j-(hex_len*4-bin'high));
      END IF;
    END LOOP;

    FOR i IN 0 TO hex_len-1 LOOP
      sub_bin := bin_ext(i*4+1 TO i*4+4);
      CASE sub_bin IS
        WHEN "0000" => hex(i+1) := '0';
        WHEN "0001" => hex(i+1) := '1';
        WHEN "0010" => hex(i+1) := '2';
        WHEN "0011" => hex(i+1) := '3';
        WHEN "0100" => hex(i+1) := '4';
        WHEN "0101" => hex(i+1) := '5';
        WHEN "0110" => hex(i+1) := '6';
        WHEN "0111" => hex(i+1) := '7';
        WHEN "1000" => hex(i+1) := '8';
        WHEN "1001" => hex(i+1) := '9';
        WHEN "1010" => hex(i+1) := 'a';
        WHEN "1011" => hex(i+1) := 'b';
        WHEN "1100" => hex(i+1) := 'c';
        WHEN "1101" => hex(i+1) := 'd';
        WHEN "1110" => hex(i+1) := 'e';
        WHEN OTHERS => hex(i+1) := 'f';
      END CASE;
    END LOOP;

    RETURN hex;

  END bin_to_hex_string;

--  purpose: This function converts a hex string to a std_logic_vector
  FUNCTION hexstr_to_slv(arg1 : STRING; size : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE RESULT : STD_LOGIC_VECTOR(size-1 DOWNTO 0) := (OTHERS => '0');
    VARIABLE BIN    : STD_LOGIC_VECTOR(3 DOWNTO 0);
    VARIABLE INDEX  : INTEGER                           := 0;
  BEGIN
    FOR i IN arg1'reverse_range LOOP
      CASE arg1(i) IS
        WHEN '0'    => BIN := (OTHERS => '0');
        WHEN '1'    => BIN := (0 => '1', OTHERS => '0');
        WHEN '2'    => BIN := (1 => '1', OTHERS => '0');
        WHEN '3'    => BIN := (0 => '1', 1 => '1', OTHERS => '0');
        WHEN '4'    => BIN := (2 => '1', OTHERS => '0');
        WHEN '5'    => BIN := (0 => '1', 2 => '1', OTHERS => '0');
        WHEN '6'    => BIN := (1 => '1', 2 => '1', OTHERS => '0');
        WHEN '7'    => BIN := (3 => '0', OTHERS => '1');
        WHEN '8'    => BIN := (3 => '1', OTHERS => '0');
        WHEN '9'    => BIN := (0 => '1', 3 => '1', OTHERS => '0');
        WHEN 'A'    => BIN := (0 => '0', 2 => '0', OTHERS => '1');
        WHEN 'a'    => BIN := (0 => '0', 2 => '0', OTHERS => '1');
        WHEN 'B'    => BIN := (2 => '0', OTHERS => '1');
        WHEN 'b'    => BIN := (2 => '0', OTHERS => '1');
        WHEN 'C'    => BIN := (0 => '0', 1 => '0', OTHERS => '1');
        WHEN 'c'    => BIN := (0 => '0', 1 => '0', OTHERS => '1');
        WHEN 'D'    => BIN := (1 => '0', OTHERS => '1');
        WHEN 'd'    => BIN := (1 => '0', OTHERS => '1');
        WHEN 'E'    => BIN := (0 => '0', OTHERS => '1');
        WHEN 'e'    => BIN := (0 => '0', OTHERS => '1');
        WHEN 'F'    => BIN := (OTHERS => '1');
        WHEN 'f'    => BIN := (OTHERS => '1');
        WHEN OTHERS =>
          --ASSERT false
          --  REPORT "NOT A HEX CHARACTER" SEVERITY error;
          FOR j IN 0 TO 3 LOOP
            BIN(j) := 'X';
          END LOOP;
      END CASE;
      FOR j IN 0 TO 3 LOOP
        IF (INDEX*4)+j < size THEN
          RESULT((INDEX*4)+j) := BIN(j);
        END IF;
      END LOOP;
      INDEX := INDEX + 1;
    END LOOP;
    RETURN RESULT;
  END hexstr_to_slv;

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
  FUNCTION addr_width_for_depth (depth : INTEGER) RETURN INTEGER IS
    VARIABLE bits : INTEGER := 0;
  BEGIN
    WHILE 2**bits < depth AND depth > 1 LOOP
      bits := bits + 1;
    END LOOP;
    RETURN bits;
  END addr_width_for_depth;

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
  FUNCTION binary_width_of_integer (data_value : INTEGER) RETURN INTEGER IS
    VARIABLE dwidth : INTEGER := 0;
  BEGIN
    WHILE 2**dwidth-1 < data_value AND data_value > 0 LOOP
      dwidth := dwidth + 1;
    END LOOP;
    RETURN dwidth;
  END binary_width_of_integer;

  -- purpose: 
  FUNCTION log2roundup (data_value : INTEGER) RETURN INTEGER IS
    VARIABLE width       : INTEGER := 0;
    VARIABLE cnt         : INTEGER := 1;
    CONSTANT lower_limit : INTEGER := 1;
    CONSTANT upper_limit : INTEGER := 8;
  BEGIN
    IF (data_value <= 1) THEN
      width := 0;
    ELSE
      WHILE (cnt < data_value) LOOP
        width := width + 1;
        cnt   := cnt *2;
      END LOOP;
    END IF;
    RETURN width;
  END log2roundup;

  -- purpose: Returns the min(a,b)                           
  FUNCTION get_min (a : INTEGER; b : INTEGER) RETURN INTEGER IS
    VARIABLE smallest : INTEGER := 1;
  BEGIN
    IF (a < b) THEN
      smallest := a;
    ELSE
      smallest := b;
    END IF;
    RETURN smallest;
  END get_min;

  -- purpose: Returns the max(a,b)                           
  FUNCTION get_max (a : INTEGER; b : INTEGER) RETURN INTEGER IS
    VARIABLE biggest : INTEGER := 1;
  BEGIN
    IF (a > b) THEN
      biggest := a;
    ELSE
      biggest := b;
    END IF;
    RETURN biggest;
  END get_max;

  -- purpose: Returns the ceiling value of the division by 4
  FUNCTION div4roundup (data_value : INTEGER) RETURN INTEGER IS
    VARIABLE div : INTEGER;
  BEGIN
    div := data_value/4;
    IF ((data_value MOD 4) /= 0) THEN
      div := div+1;
    END IF;
    RETURN div;
  END div4roundup;

  -- purpose: Returns the ceiling value of the division
  -- Data_value - the quantity to be divided, dividend
  -- Divisor - the value to divide the data_value by
  FUNCTION divroundup (data_value : INTEGER; divisor : INTEGER) RETURN INTEGER IS
    VARIABLE div : INTEGER;
  BEGIN
    div := data_value/divisor;
    IF ((data_value MOD divisor) /= 0) THEN
      div := div+1;
    END IF;
    RETURN div;
  END divroundup;



  -- purpose: Returns the floor value of the division
  -- Data_value - the quantity to be divided, dividend
  -- Divisor - the value to divide the data_value by
  FUNCTION divrounddown (data_value : INTEGER; divisor : INTEGER) RETURN INTEGER IS
    VARIABLE div : INTEGER;
  BEGIN
    div := data_value/divisor;
    RETURN div;
  END divrounddown;

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
  FUNCTION roundup_to_multiple(data_value : INTEGER; multipleof : INTEGER) RETURN INTEGER IS
    VARIABLE retval : INTEGER;
  BEGIN
    retval := data_value/multipleof;
    IF ((data_value MOD multipleof) /= 0) THEN
      retval := retval+1;
    END IF;
    retval := multipleof * retval;
    RETURN retval;
  END roundup_to_multiple;

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
  FUNCTION rand_int_base (seed : INTEGER; maxval : INTEGER; iterations : INTEGER; feedback_val : INTEGER) RETURN INTEGER IS
    VARIABLE ret_val : INTEGER := 0;
  BEGIN
    ret_val := seed;
    FOR i IN 0 TO iterations LOOP
      IF ret_val >= maxval/2 THEN
        ret_val := ret_val * 2 + feedback_val;
      ELSE
        ret_val := ret_val * 2;
      END IF;

      WHILE ret_val > maxval LOOP
        ret_val := ret_val - maxval;
      END LOOP;
    END LOOP;  -- i
    RETURN ret_val;
  END rand_int_base;

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
  FUNCTION rand_int (seed : INTEGER; maxval : INTEGER) RETURN INTEGER IS
    VARIABLE ret_val : INTEGER := 0;
  BEGIN
    ret_val := rand_int_base(seed, maxval + 15000, 2, 19);
    WHILE ret_val > maxval LOOP
      ret_val := ret_val - maxval;
    END LOOP;
    RETURN ret_val;
  END rand_int;

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
  FUNCTION rand_slv_bits (seed : INTEGER; width : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE ret_vect : STD_LOGIC_VECTOR(width-1 DOWNTO 0) := (OTHERS => '0');
    VARIABLE rand_val : INTEGER                            := seed;
  BEGIN
    FOR i IN 0 TO width-1 LOOP
      rand_val := rand_int(rand_val, 19);
      IF rand_val >= 10 THEN
        ret_vect(i) := '1';
      ELSE
        ret_vect(i) := '0';
      END IF;
    END LOOP;  -- i
    RETURN ret_vect;
  END rand_slv_bits;


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
  FUNCTION rand_slv (seed : INTEGER; width : INTEGER; maxval : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE ret_vect : STD_LOGIC_VECTOR(width-1 DOWNTO 0) := (OTHERS => '0');
    VARIABLE rand_val : INTEGER                            := seed;
  BEGIN
    --Generate a random integer using the seed
    rand_val := rand_int(rand_val, maxval);
    --Put it into a std_logic_vector of the correct size
    ret_vect := int_to_slv(rand_val, width);
    RETURN ret_vect;
  END rand_slv;

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
  FUNCTION index_in_str(stringtosearch : STRING; stringsize : INTEGER; char : STRING; instnum : INTEGER) RETURN INTEGER IS
    VARIABLE instfound    : INTEGER := 0;
    VARIABLE foundatindex : INTEGER := 0;
  BEGIN
    FOR i IN 1 TO stringsize LOOP
      IF stringtosearch(i) = char(1) THEN
        instfound := instfound + 1;
        IF instfound = instnum THEN
          foundatindex := i;
        END IF;
      END IF;
    END LOOP;  -- i
    RETURN foundatindex;
  END index_in_str;

--   purpose: Converts a string to all lowercase.
  FUNCTION lcase(instring : STRING) RETURN STRING IS
    VARIABLE retstring : STRING (instring'low TO instring'high);
  BEGIN
    FOR i IN instring'low TO instring'high LOOP

      CASE instring(i) IS
        WHEN 'A'    => retstring(i) := 'a';
        WHEN 'B'    => retstring(i) := 'b';
        WHEN 'C'    => retstring(i) := 'c';
        WHEN 'D'    => retstring(i) := 'd';
        WHEN 'E'    => retstring(i) := 'e';
        WHEN 'F'    => retstring(i) := 'f';
        WHEN 'G'    => retstring(i) := 'g';
        WHEN 'H'    => retstring(i) := 'h';
        WHEN 'I'    => retstring(i) := 'i';
        WHEN 'J'    => retstring(i) := 'j';
        WHEN 'K'    => retstring(i) := 'k';
        WHEN 'L'    => retstring(i) := 'l';
        WHEN 'M'    => retstring(i) := 'm';
        WHEN 'N'    => retstring(i) := 'n';
        WHEN 'O'    => retstring(i) := 'o';
        WHEN 'P'    => retstring(i) := 'p';
        WHEN 'Q'    => retstring(i) := 'q';
        WHEN 'R'    => retstring(i) := 'r';
        WHEN 'S'    => retstring(i) := 's';
        WHEN 'T'    => retstring(i) := 't';
        WHEN 'U'    => retstring(i) := 'u';
        WHEN 'V'    => retstring(i) := 'v';
        WHEN 'W'    => retstring(i) := 'w';
        WHEN 'X'    => retstring(i) := 'x';
        WHEN 'Y'    => retstring(i) := 'y';
        WHEN 'Z'    => retstring(i) := 'z';
        WHEN OTHERS => retstring(i) := instring(i);
      END CASE;
    END LOOP;  -- i

    RETURN retstring;

  END lcase;



--   purpose: Converts a string to all uppercase.
  FUNCTION ucase(instring : STRING) RETURN STRING IS
    VARIABLE retstring : STRING (instring'low TO instring'high);
  BEGIN
    FOR i IN instring'low TO instring'high LOOP

      CASE instring(i) IS
        WHEN 'a'    => retstring(i) := 'A';
        WHEN 'b'    => retstring(i) := 'B';
        WHEN 'c'    => retstring(i) := 'C';
        WHEN 'd'    => retstring(i) := 'D';
        WHEN 'e'    => retstring(i) := 'E';
        WHEN 'f'    => retstring(i) := 'F';
        WHEN 'g'    => retstring(i) := 'G';
        WHEN 'h'    => retstring(i) := 'H';
        WHEN 'i'    => retstring(i) := 'I';
        WHEN 'j'    => retstring(i) := 'J';
        WHEN 'k'    => retstring(i) := 'K';
        WHEN 'l'    => retstring(i) := 'L';
        WHEN 'm'    => retstring(i) := 'M';
        WHEN 'n'    => retstring(i) := 'N';
        WHEN 'o'    => retstring(i) := 'O';
        WHEN 'p'    => retstring(i) := 'P';
        WHEN 'q'    => retstring(i) := 'Q';
        WHEN 'r'    => retstring(i) := 'R';
        WHEN 's'    => retstring(i) := 'S';
        WHEN 't'    => retstring(i) := 'T';
        WHEN 'u'    => retstring(i) := 'U';
        WHEN 'v'    => retstring(i) := 'V';
        WHEN 'w'    => retstring(i) := 'W';
        WHEN 'x'    => retstring(i) := 'X';
        WHEN 'y'    => retstring(i) := 'Y';
        WHEN 'z'    => retstring(i) := 'Z';
        WHEN OTHERS => retstring(i) := instring(i);
      END CASE;
    END LOOP;  -- i

    RETURN retstring;

  END ucase;



--     purpose: Compares two strings for equality, case dependent
  FUNCTION case_sensitive_compare(a, b : STRING) RETURN BOOLEAN IS
    VARIABLE retval : BOOLEAN := true;
  BEGIN
    --If strings are not the same length can they not be considered equivalent
    IF NOT(a'length = b'length) THEN
      retval := false;
    ELSE
      --if strings are the same length
      --compare each character
      FOR i IN a'low TO a'high LOOP
        --if a character doesn't match, return false
        IF a(i) /= b(i) THEN
          retval := false;
        END IF;
      END LOOP;  -- i
    END IF;
    RETURN retval;
  END case_sensitive_compare;



--      purpose: Compares two strings for equality, ignoring case differences.
  FUNCTION case_insensitive_compare(a, b : STRING) RETURN BOOLEAN IS
  BEGIN
    RETURN case_sensitive_compare(ucase(a), ucase(b));
  END case_insensitive_compare;

  -----------------------------------------------------------------------------
  -- functions imported from iputils_family
  -----------------------------------------------------------------------------

  -- True if architecture "child" is derived from, or equal to,
  -- the architecture "ancestor".
  -- ANY, X4K, SPARTAN, SPARTANXL
  -- ANY, X4K, X4KE, X4KL
  -- ANY, X4K, X4KEX, X4KXL, X4KXV, X4KXLA
  -- ANY, VIRTEX, SPARTAN2, SPARTAN2E
  -- ANY, VIRTEX, VIRTEXE
  -- ANY, VIRTEX, VIRTEX2, SPARTAN3, SPARTAN3E, ASPARTAN3E
  -- ANY, VIRTEX, VIRTEX2, SPARTAN3, SPARTAN3A, SPARTAN3ADSP
  -- ANY, VIRTEX, VIRTEX2, SPARTAN3, ASPARTAN3
  -- ANY, VIRTEX, VIRTEX2, VIRTEX2P
  -- ANY, VIRTEX, VIRTEX4, AVIRTEX4
  -- ANY, VIRTEX, VIRTEX5

  FUNCTION derived (child, ancestor : STRING) RETURN BOOLEAN IS
    -- this list of constants needs to be updated when new device families are released!
    CONSTANT any        : STRING  := "any";
    CONSTANT x4k        : STRING  := "x4k";
    CONSTANT x4ke       : STRING  := "x4ke";
    CONSTANT x4kl       : STRING  := "x4kl";
    CONSTANT x4kex      : STRING  := "x4kex";
    CONSTANT x4kxl      : STRING  := "x4kxl";
    CONSTANT x4kxv      : STRING  := "x4kxv";
    CONSTANT x4kxla     : STRING  := "x4kxla";
    CONSTANT spartan    : STRING  := "spartan";
    CONSTANT spartanxl  : STRING  := "spartanxl";
    CONSTANT spartan2   : STRING  := "spartan2";
    CONSTANT spartan2e  : STRING  := "spartan2e";
    CONSTANT virtex     : STRING  := "virtex";
    CONSTANT virtexe    : STRING  := "virtexe";
    CONSTANT virtex2    : STRING  := "virtex2";
    CONSTANT virtex2p   : STRING  := "virtex2p";
    CONSTANT spartan3   : STRING  := "spartan3";
    CONSTANT spartan3e  : STRING  := "spartan3e";
    CONSTANT spartan3a  : STRING  := "spartan3a";
    CONSTANT virtex4    : STRING  := "virtex4";
    CONSTANT avirtex4   : STRING  := "avirtex4";
    CONSTANT virtex5    : STRING  := "virtex5";
    CONSTANT qrvirtex   : STRING  := "qrvirtex";
    CONSTANT qrvirtex2  : STRING  := "qrvirtex2";
    CONSTANT qvirtex    : STRING  := "qvirtex";
    CONSTANT qvirtex2   : STRING  := "qvirtex2";
    CONSTANT qvirtexe   : STRING  := "qvirtexe";
    CONSTANT aspartan3  : STRING  := "aspartan3";
    CONSTANT aspartan3e : STRING  := "aspartan3e";
    CONSTANT spartan3adsp : STRING  := "spartan3adsp";
    VARIABLE is_derived : BOOLEAN := false;
  BEGIN
    IF equalIgnoreCase(child, virtex) THEN
      IF (equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, qvirtexe) THEN
      IF (equalIgnoreCase(ancestor, qvirtexe) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, qvirtex2) THEN
      IF (equalIgnoreCase(ancestor, qvirtex2) OR equalIgnoreCase(ancestor, virtex2) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, qvirtex) THEN
      IF (equalIgnoreCase(ancestor, qvirtex) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, qrvirtex2) THEN
      IF (equalIgnoreCase(ancestor, qrvirtex2) OR equalIgnoreCase(ancestor, virtex2) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, qrvirtex) THEN
      IF (equalIgnoreCase(ancestor, qrvirtex) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, virtex4) THEN
      IF (equalIgnoreCase(ancestor, virtex4) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, avirtex4) THEN
      IF (equalIgnoreCase(ancestor, avirtex4) OR equalIgnoreCase(ancestor, virtex4) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, virtex5) THEN
      IF (equalIgnoreCase(ancestor, virtex5) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, virtex2) THEN
      IF (equalIgnoreCase(ancestor, virtex2) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, virtex2p) THEN
      IF (equalIgnoreCase(ancestor, virtex2p) OR equalIgnoreCase(ancestor, virtex2) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, spartan3adsp) THEN
      IF (equalIgnoreCase(ancestor, spartan3adsp) OR equalIgnoreCase(ancestor, spartan3a) OR equalIgnoreCase(ancestor, spartan3) OR equalIgnoreCase(ancestor, virtex2) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;      
    ELSIF equalIgnoreCase(child, aspartan3) THEN
      IF (equalIgnoreCase(ancestor, aspartan3) OR equalIgnoreCase(ancestor, spartan3) OR equalIgnoreCase(ancestor, virtex2) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, spartan3a) THEN
      IF (equalIgnoreCase(ancestor, spartan3a) OR equalIgnoreCase(ancestor, spartan3) OR equalIgnoreCase(ancestor, virtex2) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, spartan3e) THEN
      IF (equalIgnoreCase(ancestor, spartan3e) OR equalIgnoreCase(ancestor, spartan3) OR equalIgnoreCase(ancestor, virtex2) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, spartan3) THEN
      IF (equalIgnoreCase(ancestor, spartan3) OR equalIgnoreCase(ancestor, virtex2) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, aspartan3e) THEN
      IF (equalIgnoreCase(ancestor, aspartan3e) OR equalIgnoreCase(ancestor, spartan3) OR equalIgnoreCase(ancestor, virtex2) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, virtexe) THEN
      IF (equalIgnoreCase(ancestor, virtexe) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, spartan2) THEN
      IF (equalIgnoreCase(ancestor, spartan2) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, spartan2e) THEN
      IF (equalIgnoreCase(ancestor, spartan2e) OR equalIgnoreCase(ancestor, spartan2) OR equalIgnoreCase(ancestor, virtex) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, x4k) THEN
      IF (equalIgnoreCase(ancestor, x4k) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, x4kex) THEN
      IF (equalIgnoreCase(ancestor, x4kex) OR equalIgnoreCase(ancestor, x4K) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, x4kxl) THEN
      IF (equalIgnoreCase(ancestor, x4kxl) OR equalIgnoreCase(ancestor, x4kex) OR equalIgnoreCase(ancestor, x4K) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, x4kxv) THEN
      IF (equalIgnoreCase(ancestor, x4kxv) OR equalIgnoreCase(ancestor, x4kxl) OR equalIgnoreCase(ancestor, x4kex) OR equalIgnoreCase(ancestor, x4K) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, x4kxla) THEN
      IF (equalIgnoreCase(ancestor, x4kxla) OR equalIgnoreCase(ancestor, x4kxv) OR equalIgnoreCase(ancestor, x4kxl) OR equalIgnoreCase(ancestor, x4kex) OR equalIgnoreCase(ancestor, x4K) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, x4ke) THEN
      IF (equalIgnoreCase(ancestor, x4ke) OR equalIgnoreCase(ancestor, x4K) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, x4kl) THEN
      IF (equalIgnoreCase(ancestor, x4kl) OR equalIgnoreCase(ancestor, x4ke) OR equalIgnoreCase(ancestor, x4K) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, spartan) THEN
      IF (equalIgnoreCase(ancestor, spartan) OR equalIgnoreCase(ancestor, x4k) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, spartanxl) THEN
      IF (equalIgnoreCase(ancestor, spartanxl) OR equalIgnoreCase(ancestor, spartan) OR equalIgnoreCase(ancestor, x4k) OR equalIgnoreCase(ancestor, any)) THEN
        is_derived := true;
      END IF;
    ELSIF equalIgnoreCase(child, any) THEN
      IF equalIgnoreCase(ancestor, any) THEN
        is_derived := true;
      END IF;
    END IF;

    RETURN is_derived;
  END derived;

  -- Returns true if case insensitive string comparison determines that
  -- str1 and str2 are equal
  FUNCTION equalIgnoreCase(str1, str2 : STRING) RETURN BOOLEAN IS
    CONSTANT len1  : INTEGER := str1'length;
    CONSTANT len2  : INTEGER := str2'length;
    VARIABLE equal : BOOLEAN := true;
  BEGIN
    IF NOT (len1 = len2) THEN
      equal := false;
    ELSE
      equal := case_insensitive_compare(str1, str2);
    END IF;
    RETURN equal;
  END equalIgnoreCase;

  -- purpose: checks if the family string passed in is one of the valid families in the
  -- constant list in the header of the 'derived' FUNCTION
  -- If you need to check for specific families, you need to call the derived FUNCTION
  -- as below but with only the family names required in place of "any"
  FUNCTION valid_family (family : STRING) RETURN BOOLEAN IS
  BEGIN  -- FUNCTION valid_family
    RETURN derived(family, "any");
  END FUNCTION valid_family;

  -- purpose: converts c_xdevicefamily to c_family to make generic checking quicker
  FUNCTION c_xdevicefamily_to_c_family (xdevicefamily : STRING) RETURN STRING IS
  BEGIN  -- FUNCTION c_xdevicefamily_to_c_family

    -- we need to perform the checking based on the latest Virtex and Spartan
    -- device being checked FIRST

    -- check Spartan-series devices
    IF derived(xdevicefamily, "spartan3") THEN   -- Spartan-3(E)(L)(A)
      RETURN "spartan3";
    END IF;

    -- check Virtex-series devices
    IF derived(xdevicefamily, "virtex5") THEN
      RETURN "virtex5";
    ELSIF derived(xdevicefamily, "virtex4") THEN
      RETURN "virtex4";
    ELSIF derived(xdevicefamily, "virtex2") THEN  -- includes Virtex-2P
      RETURN "virtex2";
    ELSIF derived(xdevicefamily, "virtex") THEN
      RETURN "virtex";
    END IF;

    -- if none of the above conditionals have returned,
    -- return a sensible error string instead
    RETURN "invalid_c_xdevicefamily";
    
  END FUNCTION c_xdevicefamily_to_c_family;

  -----------------------------------------------------------------------------
  -- note that we have to use the string representations of the family names in
  -- these functions because the constants are declared locally in the 'derived'
  -- function.  We cannot declare them globally otherwise they clash with the
  -- enumerated device names in pkg_baseblox
  -----------------------------------------------------------------------------

  -- purpose: returns true if the device family passed in as the argument contains DSP48 or DSP48E primitives
  FUNCTION has_dsp (family : STRING) RETURN BOOLEAN IS
  BEGIN  -- FUNCTION has_dsp
    RETURN derived(family, "virtex4") OR derived(family, "virtex5");
  END FUNCTION has_dsp;

  -- purpose: returns true if the device family passed in as the argument contains DSP48 blocks
  FUNCTION has_dsp48 (family : STRING) RETURN BOOLEAN IS
  BEGIN  -- FUNCTION has_dsp48
    RETURN derived(family, "virtex4");
  END FUNCTION has_dsp48;

  -- purpose: returns true if the device family passed in as the argument contains DSP48E blocks
  FUNCTION has_dsp48e (family : STRING) RETURN BOOLEAN IS
  BEGIN  -- FUNCTION has_dsp48e
    RETURN derived(family, "virtex5");
  END FUNCTION has_dsp48e;

  -- purpose: returns true if the device family passed in as the argument contains DSP48A blocks
  FUNCTION has_dsp48a (family : STRING) RETURN BOOLEAN IS
  BEGIN  -- FUNCTION has_dsp48a
    RETURN derived(family, "spartan3adsp");
  END FUNCTION has_dsp48a;
  
  -- purpose: returns true if the device family passed in as the argument contains MULT18X18(S) blocks
  FUNCTION has_mult18x18 (family : STRING) RETURN BOOLEAN IS
  BEGIN  -- FUNCTION has_mult18
    RETURN derived(family, "virtex2") OR derived(family, "virtex2p") OR derived(family, "spartan3");
  END FUNCTION has_mult18x18;

  -- purpose: wrapper for has_mult18x18
  FUNCTION has_mult18x18s (family : STRING) RETURN BOOLEAN IS
  BEGIN  -- FUNCTION has_mult18x18s
    RETURN has_mult18x18(family);
  END FUNCTION has_mult18x18s;

  -- purpose: returns true if the device family passed in as the argument contains MULT18X18SIO blocks
  FUNCTION has_mult18x18sio (family : STRING) RETURN BOOLEAN IS
  BEGIN  -- FUNCTION has_mult18x18sio
    RETURN derived(family, "spartan3e") OR derived(family, "spartan3a");
  END FUNCTION has_mult18x18sio;

  -- purpose: returns true if the device family passed in as the argument contains SRLC16(E) primitives
  -- Includes Virtex-5 as the SRL(C)16(E) can be used as a legacy mode or for power saving
  FUNCTION has_SRLC16E (family : STRING) RETURN BOOLEAN IS
  BEGIN  -- FUNCTION has_SRLC16E
    RETURN derived(family, "virtex2") OR derived(family, "virtex2p") OR derived(family, "spartan3") OR derived(family, "spartan3e") OR derived(family, "spartan3a") OR derived(family, "virtex4") OR derived(family, "virtex5");
  END FUNCTION has_SRLC16E;

  -- purpose: returns true if the device family passed in as the argument contains SRLC32E primitives
  FUNCTION has_SRLC32E (family : STRING) RETURN BOOLEAN IS
  BEGIN  -- FUNCTION has_SRLC32E
    RETURN derived(family, "virtex5");
  END FUNCTION has_SRLC32E;

  -- purpose: returns true if the family in question has 4-input LUTs
  -- everything except Virtex-5....
  FUNCTION has_lut4 (family : STRING) RETURN BOOLEAN IS
  BEGIN  -- FUNCTION has_lut4
    RETURN NOT(derived(family, "virtex5"));
  END FUNCTION has_lut4;

  -- purpose: returns true if the family in question has 6-input LUTs
  FUNCTION has_lut6 (family : STRING) RETURN BOOLEAN IS
  BEGIN  -- FUNCTION has_lut6
    RETURN derived(family, "virtex5");
  END FUNCTION has_lut6;

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
    variable ret : string(1 to outlength);
    constant rectified : string(1 to instring'LENGTH) := instring;
    constant inlength : integer := instring'LENGTH;
  begin  -- str_to_bound_str
    for i in ret'range loop
      ret(i) := pad(pad'RIGHT);      --in case some eejit makes pad > 1 character
    end loop;
    if outlength >= inlength then
      ret(ret'LEFT+outlength-inlength to ret'RIGHT) := rectified;
    else
      ret := rectified(rectified'LEFT+inlength-outlength to rectified'RIGHT);
    end if;
    return ret;
  end str_to_bound_str;


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
  IMPURE FUNCTION read_meminit_file(filename : IN STRING; depth, width, lines : IN POSITIVE) RETURN STD_LOGIC_VECTOR IS
    FILE meminitfile     : TEXT;
    VARIABLE mif_status  : FILE_OPEN_STATUS;
    VARIABLE BIT         : INTEGER;
    VARIABLE bitline     : LINE;
    VARIABLE bitchar     : CHARACTER;
    VARIABLE bits_good   : BOOLEAN;
    VARIABLE offset      : INTEGER                                  := 0;
    VARIABLE total_lines : INTEGER;
    VARIABLE num_lines   : INTEGER                                  := 0;
    VARIABLE mem_vector  : STRING(width DOWNTO 1);
    VARIABLE return_vect : STD_LOGIC_VECTOR(width*lines-1 DOWNTO 0) := (OTHERS => '0');
  BEGIN

    file_open(mif_status, meminitfile, filename, read_mode);  -- does not compile with XCC when using xbld
--    meminitfile := file_open(mif_status, filename, read_mode); -- works with XCC

    ASSERT mif_status = open_ok REPORT "Error: couldn't open MIF file " & filename SEVERITY failure;

    IF mif_status = open_ok THEN
      
      IF (lines > 0 AND lines <= depth) THEN
        total_lines := lines;
      ELSE
        total_lines := depth;
      END IF;

      WHILE (NOT(ENDFILE(meminitfile)) AND (num_lines < total_lines)) LOOP
        READLINE(meminitfile, bitline);
        EXIT WHEN endfile(meminitfile);  -- XST safety net
        READ(bitline, mem_vector, bits_good);
        ASSERT bits_good REPORT "Error: problem reading MIF file " & filename SEVERITY failure;
        FOR BIT IN 0 TO width-1 LOOP
          bitchar := mem_vector(BIT+1);
          IF (bitchar = '1') THEN
            return_vect(offset+BIT) := '1';
          ELSE
            return_vect(offset+BIT) := '0';
          END IF;
        END LOOP;  -- FOR
        num_lines := num_lines+1;
        offset    := offset + width;
      END LOOP;  -- WHILE      
    END IF;  -- mif_status

    -- close the file being read from
    file_close(meminitfile);

    RETURN return_vect;
    
  END read_meminit_file;

  IMPURE FUNCTION write_meminit_file(filename : IN STRING; depth , width : IN POSITIVE; memvect : IN STD_LOGIC_VECTOR) RETURN BOOLEAN IS
    FILE meminitfile        : TEXT;
    VARIABLE mif_status     : FILE_OPEN_STATUS;
    VARIABLE addrs          : INTEGER;
    VARIABLE BIT            : INTEGER;
    VARIABLE bitline        : LINE;
    VARIABLE bitstring      : STRING(width DOWNTO 1);
    VARIABLE slv            : STD_LOGIC_VECTOR(width DOWNTO 1);
    VARIABLE offset         : INTEGER;
    VARIABLE contents       : STD_LOGIC_VECTOR(1 TO width);
    CONSTANT mem_bits       : INTEGER := depth * width;
    CONSTANT vec_bits       : INTEGER := memvect'length;
    VARIABLE padded_memvect : STD_LOGIC_VECTOR(1 TO mem_bits);
    VARIABLE check_ok       : BOOLEAN;
  BEGIN

    ASSERT false REPORT "writing MIF " & filename SEVERITY note;

    -- created a padded out vector that has the same number of bits in it as is specified by mem_bits
    padded_memvect(1 TO memvect'length) := memvect;

    IF memvect'length < mem_bits THEN
      padded_memvect(memvect'length+1 TO mem_bits) := (OTHERS => '0');
    END IF;

    file_open(mif_status, meminitfile, filename, write_mode);  -- does not compile with XCC when using xbld
--    meminitfile := file_open(mif_status, filename, read_mode); -- works with XCC

    ASSERT mif_status = open_ok
      REPORT "Error: couldn't open memory initialization file."
      SEVERITY failure;
    
    IF mif_status = open_ok THEN
      offset := 0;
      FOR addrs IN 0 TO depth-1 LOOP
        contents := padded_memvect(padded_memvect'high-offset-width+1 TO padded_memvect'high-offset);
        write(bitline, slv_to_bv(slv));  -- convert the SLV to a BV to use std.textio.write function
        writeline(meminitfile, bitline);
        offset   := offset + width;
      END LOOP;  -- addrs      
    END IF;  -- mif_status
    -- close the file we wrote to
    FILE_CLOSE(meminitfile);
    RETURN true;                        -- XCC requires a return value    
  END write_meminit_file;

  -----------------------------------------------------------------------------
  -- Simulation functions moved from ul_utils
  -----------------------------------------------------------------------------

  FUNCTION anyX(vect : STD_LOGIC_VECTOR) RETURN BOOLEAN IS
  BEGIN
    FOR i IN vect'range LOOP
      IF (rat(vect(i)) = 'X') THEN
        RETURN true;
      END IF;
    END LOOP;
    RETURN false;
  END anyX;

  FUNCTION any0(vect : STD_LOGIC_VECTOR) RETURN BOOLEAN IS
  BEGIN
    FOR i IN vect'range LOOP
      IF (rat(vect(i)) = '0') THEN
        RETURN true;
      END IF;
    END LOOP;
    RETURN false;
  END any0;

  FUNCTION setallX(width : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE vect : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
  BEGIN
    FOR i IN 0 TO width-1 LOOP
      vect(i) := 'X';
    END LOOP;
    RETURN vect;
  END setallX;

  FUNCTION setall0(width : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE vect : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
  BEGIN
    FOR i IN 0 TO width-1 LOOP
      vect(i) := '0';
    END LOOP;
    RETURN vect;
  END setall0;
  
END prims_utils_v9_1;


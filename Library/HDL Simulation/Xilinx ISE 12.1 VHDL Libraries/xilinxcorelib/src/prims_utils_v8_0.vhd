-- $RCSfile: prims_utils_v8_0.vhd,v $ $Revision: 1.10 $ $Date: 2008/09/08 16:50:41 $
--------------------------------------------------------------------------------
--  Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------
--
-- Filename - prims_utils_v8_0.vhd
-- Author - Xilinx
-- Creation - 19 Aug 1999
--
-- Description - This file contains some helper functions for baseblocks components

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE  XilinxCoreLib.prims_constants_v8_0.ALL;

PACKAGE prims_utils_v8_0 IS

  FUNCTION bv_to_slv(bitsin  : BIT_VECTOR) RETURN STD_LOGIC_VECTOR;
  FUNCTION str_to_slv(bitsin : STRING) RETURN STD_LOGIC_VECTOR;

  -- convert a string to a std_logic_vector, padding to the left, with '0' or '1' respectively,
  -- so the return value has minimum length nbits.
  -- if the string has length > nbits, the output will also have length > nbits.
  FUNCTION str_to_slv_0(bitsin : STRING; nbits : INTEGER) RETURN STD_LOGIC_VECTOR;
  FUNCTION str_to_slv_1(bitsin : STRING; nbits : INTEGER) RETURN STD_LOGIC_VECTOR;

  -- purpose: convert a string to a std_logic_vector of length exactly nbits,
  -- padding with pad or truncating at the left as necessary.
  FUNCTION str_to_bound_slv(bitsin    : STRING; nbits : INTEGER; pad : STD_LOGIC) RETURN STD_LOGIC_VECTOR;
  -- as above, but pad is implicitly '0'
  FUNCTION str_to_bound_slv_0 (bitsin : STRING; nbits : INTEGER) RETURN STD_LOGIC_VECTOR;

  FUNCTION str_to_bv(bitsin  : STRING) RETURN BIT_VECTOR;
  FUNCTION b_to_sl(bitin     : BIT) RETURN STD_LOGIC;
  FUNCTION char_to_sl(bitin  : CHARACTER) RETURN STD_LOGIC;
  FUNCTION slv_to_bv(bitsin  : STD_LOGIC_VECTOR) RETURN BIT_VECTOR;
  FUNCTION slv_to_str(bitsin : STD_LOGIC_VECTOR) RETURN STRING;
  FUNCTION sl_to_b(bitin     : STD_LOGIC) RETURN BIT;
  FUNCTION sl_to_char(bitin  : STD_LOGIC) RETURN CHARACTER;

  FUNCTION int_to_str(int_value : INTEGER) RETURN STRING;

  FUNCTION all_Xs (i : INTEGER) RETURN STD_LOGIC_VECTOR;

  FUNCTION sl_to_str(sl : STD_LOGIC) RETURN STRING;
  FUNCTION padded_slv_to_str (slv : STD_LOGIC_VECTOR; width : INTEGER) RETURN STRING;

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

END prims_utils_v8_0;

LIBRARY IEEE;

PACKAGE BODY prims_utils_v8_0 IS


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

-- convert a string to a std_logic_vector of bound length
-- truncating or padding with pad as necessary
-- truncation and padding occurs at the LEFT
-- eg "11", 4 => "0011"
-- or "100000", 4 => "0000"
  FUNCTION str_to_bound_slv (bitsin : STRING; nbits : INTEGER; pad : STD_LOGIC)
    RETURN STD_LOGIC_VECTOR IS
    VARIABLE ret       : STD_LOGIC_VECTOR (1 TO nbits);
    -- offset is the amount that bitsin needs to move to the right
    -- for its right end to be coincident with ret's.
    -- negative values of offset mean bitsin must move to the left
    -- and that bitsin will be truncated.
    CONSTANT offset    : INTEGER := nbits - bitsin'length;  -- was variable
    CONSTANT bitsinlen : INTEGER := bitsin'length;  -- was VARIABLE
    CONSTANT bitsin_const : STRING := bitsin;
  BEGIN
    ASSERT nbits >= 1
      REPORT "ERROR - str_to_bound_slv: Cannot have zero or negative length array"
      SEVERITY failure;
    ASSERT offset >= 0
      REPORT "WARNING - str_to_bound_slv: Input string too long, will truncate it"
      SEVERITY warning;

    FOR i IN 1 TO nbits LOOP
      ret(i) := pad;
    END LOOP;
    IF bitsin'length = 0 THEN  -- use instead of bitsin = "" to avoid XST warning
      --ASSERT false REPORT "null string detected, tickLENGTH = " & INTEGER'image(bitsinlen) SEVERITY note;
      RETURN ret;
    END IF;

    FOR i IN 1 TO nbits LOOP
      IF i <= offset THEN
        -- this cell of the vector will become padding
        ret(i) := pad;
      ELSE
        -- the following IF effectively does ret(i) := bitsin(i - offset)
        IF bitsin(i - offset) = '1' THEN
          ret(i) := '1';
        ELSIF bitsin(i - offset) = 'X' OR bitsin(i - offset) = 'x' THEN
          ret(i) := 'X';
        ELSIF bitsin(i - offset) = 'U' OR bitsin(i - offset) = 'u' THEN
          ret(i) := 'U';
        ELSE                            --bitsin(i - offset) = '0' THEN
          ret(i) := '0';
          ASSERT bitsin_const(i - offset) = '0' REPORT "ERROR - str_to_bound_slv: Invalid character encountered (Only 1, X, U or 0 are recognised)"& bitsin_const(i - offset)
            SEVERITY warning;
        END IF;
      END IF;
    END LOOP;
    RETURN ret;
  END str_to_bound_slv;

-- same as above, but pad with '0' rather than user-defined pad.
  FUNCTION str_to_bound_slv_0 (bitsin : STRING; nbits : INTEGER) RETURN STD_LOGIC_VECTOR IS
  BEGIN
    RETURN str_to_bound_slv(bitsin, nbits, '0');
  END str_to_bound_slv_0;

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

  FUNCTION int_to_str(int_value : INTEGER) RETURN STRING IS
    VARIABLE digit        : INTEGER;
    VARIABLE value        : INTEGER;
    VARIABLE length       : INTEGER         := 0;
    VARIABLE posn         : INTEGER;
    VARIABLE start_length : INTEGER;
    CONSTANT str          : STRING(1 TO 10) := "0123456789";
    VARIABLE ret_value    : STRING(1 TO 11);
    
  BEGIN
    
    IF int_value < 0 THEN
      -- Largest possible negative number
      IF int_value < -2147483647 THEN
        RETURN ("less than VHDL minimum INTEGER value");
      ELSE
        value        := -1 * int_value;
        start_length := 1;
        ret_value(1) := '-';
      END IF;
    ELSE
      value        := int_value;
      start_length := 0;
    END IF;

    IF (value = 0) THEN
      RETURN "0";
    ELSIF (value < 10) THEN
      length := 1 + start_length;
    ELSIF (value < 100) THEN
      length := 2 + start_length;
    ELSIF (value < 1000) THEN
      length := 3 + start_length;
    ELSIF (value < 10000) THEN
      length := 4 + start_length;
    ELSIF (value < 100000) THEN
      length := 5 + start_length;
    ELSIF (value < 1000000) THEN
      length := 6 + start_length;
    ELSIF (value < 10000000) THEN
      length := 7 + start_length;
    ELSIF (value < 100000000) THEN
      length := 8 + start_length;
    ELSIF (value < 1000000000) THEN
      length := 9 + start_length;
    ELSE
      length := 10 + start_length;
    END IF;

    IF (length > 0) THEN  -- Required because Metamor bombs without it
      posn := length;

      WHILE (value /= 0) LOOP
        digit           := value MOD 10;
        ret_value(posn) := str(digit+1);
        value           := value/10;
        posn            := posn - 1;
      END LOOP;
    END IF;

    RETURN ret_value(1 TO length);
    
  END int_to_str;

  FUNCTION all_Xs(i : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE stmp : STD_LOGIC_VECTOR(i-1 DOWNTO 0);
  BEGIN
    FOR j IN 0 TO i-1 LOOP
      stmp(j) := 'X';
    END LOOP;

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
  
END prims_utils_v8_0;

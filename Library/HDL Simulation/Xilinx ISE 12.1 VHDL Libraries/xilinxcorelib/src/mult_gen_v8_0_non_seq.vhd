-- $RCSfile: mult_gen_v8_0_non_seq.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:37:47 $
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

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY std;
USE std.textio.ALL;

LIBRARY xilinxcorelib;
USE xilinxcorelib.prims_constants_v8_0.ALL;
USE xilinxcorelib.mult_gen_const_pkg_v8_0.ALL;
USE xilinxcorelib.mult_pkg_v8_0.ALL;
USE XilinxCoreLib.mult_gen_v8_0_services.ALL;

ENTITY mult_gen_v8_0_non_seq IS
  GENERIC (
    c_family          : STRING  := DEFAULT_FAMILY;
    c_a_width         : INTEGER := A_DEFAULT_WIDTH;
    c_b_width         : INTEGER := B_DEFAULT_WIDTH;
    c_out_width       : INTEGER := OUT_DEFAULT_WIDTH;
    c_has_q           : INTEGER := DEFAULT_HAS_Q;
    c_has_o           : INTEGER := 0;
    c_reg_a_b_inputs  : INTEGER := DEFAULT_REG_A_B_INPUTS;
    c_a_type          : INTEGER := DEFAULT_A_TYPE;
    c_b_type          : INTEGER := DEFAULT_B_TYPE;
    c_b_constant      : INTEGER := DEFAULT_CONSTANT_B;
    c_b_value         : STRING  := DEFAULT_CONSTANT_B_VAL;
    c_has_aclr        : INTEGER := DEFAULT_HAS_ACLR;
    c_has_sclr        : INTEGER := DEFAULT_HAS_SCLR;
    c_has_ce          : INTEGER := DEFAULT_HAS_CE;
    c_has_a_signed    : INTEGER := DEFAULT_HAS_A_SIGNED;
    c_enable_rlocs    : INTEGER := DEFAULT_ENABLE_RLOCS;
    c_has_loadb       : INTEGER := DEFAULT_HAS_LOADB;
    c_mem_type        : INTEGER := DEFAULT_MEM_TYPE;
    c_mult_type       : INTEGER := DEFAULT_MULT_TYPE;
    -- determines which kind of multiplier
    -- to instantiate:
    -- 0- LUT-based parallel
    -- 1- Virtex-II MULT18X18-based parallel
    -- 2- parallel CCM
    -- 3- static RCCM
    -- 4- dynamic RCCM
    -- 5- XtremeDSP Slice (DSP48) parallel multiplier
    -- 6- Hybrid MULT18X18 or DSP48 + fabric multiplier
    c_baat            : INTEGER := DEFAULT_BAAT;
    c_has_swapb       : INTEGER := DEFAULT_HAS_SWAPB;
    c_has_nd          : INTEGER := DEFAULT_HAS_ND;
    c_has_rdy         : INTEGER := DEFAULT_HAS_RDY;
    c_has_rfd         : INTEGER := DEFAULT_HAS_RFD;
    c_pipeline        : INTEGER := 0;
    c_predelay        : INTEGER := 0;
    c_sync_enable     : INTEGER := DEFAULT_SYNC_ENABLE;
    c_has_load_done   : INTEGER := DEFAULT_HAS_LOAD_DONE;
    c_output_hold     : INTEGER := DEFAULT_OUTPUT_HOLD;
    c_sqm_type        : INTEGER := 0;
    c_has_b           : INTEGER := 1;
    c_stack_adders    : INTEGER := 0;
    bram_addr_width   : INTEGER := 8;
    c_mem_init_prefix : STRING  := "mem";
    c_standalone      : INTEGER := 0;
    c_use_luts        : INTEGER := 1
    );
  PORT (
    clk       : IN  STD_LOGIC                                := '0';
    a         : IN  STD_LOGIC_VECTOR(c_a_width-1 DOWNTO 0)   := (OTHERS => '0');
    b         : IN  STD_LOGIC_VECTOR(c_b_width-1 DOWNTO 0)   := (OTHERS => '0');
    o         : OUT STD_LOGIC_VECTOR(c_out_width-1 DOWNTO 0) := (OTHERS => '0');
    q         : OUT STD_LOGIC_VECTOR(c_out_width-1 DOWNTO 0);
    a_signed  : IN  STD_LOGIC                                := '0';
    loadb     : IN  STD_LOGIC                                := '0';
    load_done : OUT STD_LOGIC;
    swapb     : IN  STD_LOGIC                                := '0';
    ce        : IN  STD_LOGIC                                := '0';
    aclr      : IN  STD_LOGIC                                := '0';
    sclr      : IN  STD_LOGIC                                := '0';
    rfd       : OUT STD_LOGIC;
    nd        : IN  STD_LOGIC                                := '1';
    rdy       : OUT STD_LOGIC
    );
END mult_gen_v8_0_non_seq;


ARCHITECTURE behavioral OF mult_gen_v8_0_non_seq IS

----------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------
 
  -- This function calculates the output width of the multiplier.
  -- For the unreloadable ccm this is caluculated by taking the maximum possible 
  -- a value and multiplying it by the constant. For the two input multipliers it
  -- is simply the a width plus the b width.
  FUNCTION find_ccm_out_width (bin : STD_LOGIC_VECTOR; non_ccm_width : INTEGER; a_width : INTEGER) RETURN INTEGER IS
    VARIABLE ccm_max_a_val             : STD_LOGIC_VECTOR(a_width-1 DOWNTO 0);
    VARIABLE max_result                : STD_LOGIC_VECTOR((a_width+bin'length)-1 DOWNTO 0);
    VARIABLE max_result_negated        : STD_LOGIC_VECTOR((a_width+bin'length)-1 DOWNTO 0);
    VARIABLE ccm_output_width          : INTEGER;
    VARIABLE ccm_negative_output_width : INTEGER;
    VARIABLE index                     : INTEGER;
    VARIABLE cin                       : STD_LOGIC;
    VARIABLE value                     : STD_LOGIC;
    VARIABLE b_in                      : STD_LOGIC_VECTOR((bin'length-1) DOWNTO 0) := bin;
    VARIABLE a_signed                  : INTEGER                                   := 0;
    VARIABLE a_negative                : INTEGER                                   := 0;
    VARIABLE b_negative                : INTEGER                                   := 0;
  BEGIN
    ccm_output_width          := 0;
    ccm_negative_output_width := 0;
    IF (c_mult_type = V2_PARALLEL AND anyX(bin)) THEN
      RETURN non_ccm_width;
    END IF;
    IF (c_a_type = c_signed AND NOT(c_baat < c_a_width)) THEN
      ccm_max_a_val            := (OTHERS => '0');
      ccm_max_a_val(a_width-1) := '1';
      a_negative               := 1;
    ELSE
      ccm_max_a_val := (OTHERS => '1');
      a_negative    := 0;
    END IF;
    max_result         := (OTHERS => '0');
    max_result_negated := (OTHERS => '0');
    IF (c_b_type = c_signed AND (bin(bin'length-1) = '1')) THEN
      b_in       := two_comp(bin);
      b_negative := 1;
    END IF;
    FOR i IN 0 TO (b_in'length-1) LOOP
      IF (b_in(i) = '1') THEN
        index := i;
        cin   := '0';
        FOR j IN 0 TO a_width-1 LOOP    -- add a to prod 
          value := max_result(index) XOR ccm_max_a_val(j) XOR cin;  -- sum
          cin   := (max_result(index) AND ccm_max_a_val(j)) OR (max_result(index) AND cin) OR
                   (ccm_max_a_val(j) AND cin);           -- carry
          max_result(index) := value;
          index             := index + 1;
        END LOOP;
        max_result(index) := max_result(index) XOR cin;  -- last carry 
      ELSE
        cin := '0';
      END IF;
    END LOOP;
    FOR i IN 0 TO (max_result'length-1) LOOP
      IF (max_result(i) = '1') THEN
        ccm_output_width := i+1;
      END IF;
    END LOOP;
    IF (a_negative = 1 AND b_negative = 1) THEN
      ccm_output_width := ccm_output_width + 1;
    ELSIF ((a_negative = 1 AND b_negative = 0) OR (a_negative = 0 AND b_negative = 1)) THEN
      max_result_negated := two_comp(max_result);
      FOR i IN 0 TO ccm_output_width-1 LOOP
        IF(max_result_negated(i) = '0') THEN
          ccm_negative_output_width := i + 2;
        END IF;
      END LOOP;
      ccm_output_width := ccm_negative_output_width;
    END IF;
    -- This is the code for calculating the multiplier output width.
    IF (c_mult_type /= PARALLEL AND c_mult_type /= V2_PARALLEL AND c_mult_type /= V4_PARALLEL AND c_mult_type /= HYBRID) AND (c_has_loadb = 0) THEN
      IF(bin'length = 1 AND c_b_type = c_unsigned AND bin(bin'high) = '1' AND c_a_type /= 2) THEN
        ccm_output_width := a_width;
      ELSIF(bin'length = 1 AND c_b_type = c_signed AND bin(bin'high) = '1') THEN
        ccm_output_width := a_width+1;
      ELSIF (c_has_a_signed = 1 AND c_b_type = c_unsigned) THEN
        ccm_output_width := ccm_output_width + 1;
      ELSE
        ccm_output_width := ccm_output_width;
      END IF;
      RETURN ccm_output_width;
    ELSE
      IF (c_mult_type = STATIC_RCCM OR c_mult_type = DYNAMIC_RCCM) AND (bin'length = 1) THEN
        IF (c_has_a_signed = 1) AND (c_b_type = c_unsigned) THEN
          RETURN non_ccm_width;
        ELSE
          RETURN non_ccm_width-1;
        END IF;
      ELSIF (c_mult_type = STATIC_RCCM OR c_mult_type = DYNAMIC_RCCM) AND (a_width = 1) THEN
        IF (c_has_a_signed = 1) AND (c_b_type = c_unsigned) THEN
          RETURN non_ccm_width;
        ELSE
          RETURN non_ccm_width-1;
        END IF;
      ELSE
        IF (c_has_a_signed = 1) AND (c_b_type = c_unsigned) THEN
          RETURN non_ccm_width + 1;
        ELSE
          RETURN non_ccm_width;
        END IF;
      END IF;
    END IF;
  END find_ccm_out_width;

  FUNCTION find_actual_a_width(a_width : INTEGER)
    RETURN INTEGER IS
  BEGIN
    IF (c_has_a_signed = 1) THEN
      RETURN a_width+1;
    ELSE
      RETURN a_width;
    END IF;
  END find_actual_a_width;

  FUNCTION find_b_width(ccm_b_width, non_ccm_b_width, mult_type : INTEGER)
    RETURN INTEGER IS
  BEGIN
    IF (mult_type < 2) THEN
      RETURN non_ccm_b_width;
    ELSE
      RETURN ccm_b_width;
    END IF;
  END find_b_width;

  -- Muliplier function that handles all signed/unsigned combinations and
  -- correctly handles when any of the input bits are an 'X'.
  FUNCTION mult(a, b : STD_LOGIC_VECTOR; a_sign : STD_LOGIC; sign, out_width : INTEGER)
    RETURN STD_LOGIC_VECTOR IS
    CONSTANT a_width                      : INTEGER                              := a'length;
    CONSTANT b_width                      : INTEGER                              := b'length;
    VARIABLE la                           : STD_LOGIC_VECTOR(a_width-1 DOWNTO 0) := a;
    VARIABLE lb                           : STD_LOGIC_VECTOR(b_width-1 DOWNTO 0) := b;
    VARIABLE lsigna                       : STD_LOGIC;
    CONSTANT ccm_out_width                : INTEGER                              := find_ccm_out_width(b, (a_width + b_width), a_width);
    VARIABLE product                      : STD_LOGIC_VECTOR((ccm_out_width-1) DOWNTO 0);
    VARIABLE negative                     : BOOLEAN;
    VARIABLE a_value, b_value, prod_value : INTEGER;
    VARIABLE index                        : INTEGER;
    VARIABLE cin, value                   : STD_LOGIC;
    CONSTANT diff                         : INTEGER                              := ccm_out_width - out_width;
    VARIABLE product_o                    : STD_LOGIC_VECTOR(out_width-1 DOWNTO 0);
    VARIABLE a_type                       : INTEGER;
  BEGIN
    IF (sign = c_signed) THEN
      lsigna := a_sign;
    ELSE
      lsigna := '0';
    END IF;
    IF (sign = c_signed AND c_a_type = c_signed) THEN
      a_type := c_signed;
    ELSE
      a_type := c_unsigned;
    END IF;
    IF ((all0(la) AND (c_has_a_signed = 0 OR lsigna /= 'X')) AND NOT(anyX(lb)))
      OR (all0(lb) AND (NOT(anyX(la)) AND (c_has_a_signed = 0 OR lsigna /= 'X' OR c_mult_type < 2 OR c_mult_type = 5 OR c_mult_type = 6))) THEN  -- and mult_type < 2) then
      product := (OTHERS => '0');
    ELSIF (anyX(la) OR anyX(lb) OR (c_has_a_signed = 1 AND sign = c_signed AND lsigna = 'X')) THEN
      product := (OTHERS => 'X');
    ELSE
      negative := false;
      IF (c_b_type = c_unsigned) THEN
        IF ((c_has_a_signed = 0 AND a_type = c_signed AND (la(a_width-1) = '1')) OR
            (c_has_a_signed = 1 AND lsigna = '1' AND (la(a_width-1) = '1'))) THEN
          negative := true;
        END IF;
      ELSIF (c_has_a_signed = 0 AND a_type = c_unsigned) OR
        (c_has_a_signed = 1 AND lsigna = '0') THEN
        IF (c_b_type = c_signed AND (lb(b_width-1) = '1')) THEN
          negative := true;
        END IF;
      ELSIF (c_b_type = c_signed AND (
        ((c_has_a_signed = 0 AND a_type = c_signed) OR
         (c_has_a_signed = 1 AND lsigna = '1')))) THEN
        IF ((la(a_width-1) = '0') AND (lb(b_width-1) = '1')) OR
          ((la(a_width-1) = '1') AND (lb(b_width-1) = '0')) THEN
          negative := true;
        END IF;
      END IF;
      IF (((c_has_a_signed = 0 AND a_type = c_signed AND (la(a_width-1) = '1')) OR
           (c_has_a_signed = 1 AND lsigna = '1' AND (la(a_width-1) = '1')))) THEN
        la := two_comp(la);
      END IF;
      IF ((c_b_type = c_signed AND (lb(b_width-1) = '1'))) THEN
        lb := two_comp(lb);
      END IF;
      product := (OTHERS => '0');
      FOR i IN 0 TO b_width -1 LOOP     -- b width
        IF (lb(i) = '1') THEN
          index := i;
          cin   := '0';
          FOR j IN 0 TO a_width-1 LOOP  -- add a to prod 
            IF index < ccm_out_width THEN
              value := product(index) XOR la(j) XOR cin;  -- sum
              cin   := (product(index) AND la(j)) OR (product(index) AND cin) OR
                       (la(j) AND cin);                   -- carry
              product(index) := value;
              index          := index + 1;
            END IF;
          END LOOP;
          IF index < ccm_out_width THEN
            product(index) := product(index) XOR cin;     -- last carry 
          END IF;
        ELSE
          cin := '0';
        END IF;
      END LOOP;
      IF (negative) THEN
        product := two_comp(product);
      END IF;
    END IF;
    IF (out_width < ccm_out_width) THEN
      FOR i IN 0 TO out_width-1 LOOP
        product_o(i) := product(i+diff);
      END LOOP;  -- n
    ELSIF (out_width > ccm_out_width) THEN
      product_o(ccm_out_width-1 DOWNTO 0) := product;
      FOR i IN ccm_out_width TO out_width-1 LOOP
        IF(b_width > 1 AND a_width > 1) THEN
          IF (((a_type = c_signed AND c_has_a_signed = 0) OR c_b_type = c_signed OR (c_has_a_signed = 1 AND lsigna = '1')) AND ccm_out_width /= 0) THEN
            product_o(i) := product(ccm_out_width-1);
          ELSIF (anyX(la) OR anyX(lb) OR (c_has_a_signed = 1 AND sign = c_signed AND lsigna = 'X')) THEN
            product_o(i) := 'X';
          ELSE product_o(i) := '0';
          END IF;
        ELSE
          IF negative AND (((a_type = c_signed AND c_has_a_signed = 0) OR c_b_type = c_signed OR (c_has_a_signed = 1 AND lsigna = '1')) AND ccm_out_width /= 0) THEN
            product_o(i) := '1';
          ELSIF (anyX(la) OR anyX(lb) OR (c_has_a_signed = 1 AND sign = c_signed AND lsigna = 'X')) THEN
            product_o(i) := 'X';
          ELSE product_o(i) := '0';
          END IF;
        END IF;
      END LOOP;
    ELSE product_o := product;
         RETURN product_o;
    END IF;
    RETURN product_o;
  END mult;

  -- These are small helper functions.
  FUNCTION max (a, b : INTEGER) RETURN INTEGER IS
    VARIABLE maximum_value : INTEGER := 0;
  BEGIN
    IF (a >= b) THEN
      maximum_value := a;
    ELSE
      maximum_value := b;
    END IF;
    RETURN maximum_value;
  END max;

  FUNCTION inc_if_sig (a_type, a_sign : INTEGER) RETURN INTEGER IS
    VARIABLE return_value : INTEGER := 0;
  BEGIN
    IF ((a_type = 0 OR a_sign = 1) AND c_b_type = 1) THEN return_value := 1;
    ELSE return_value                                                  := 0;
    END IF;
    RETURN return_value;
  END inc_if_sig;

  FUNCTION inc_if_no_sign (a_type, b_type : INTEGER) RETURN INTEGER IS
    VARIABLE return_value : INTEGER := 0;
  BEGIN
    IF ((a_type = c_unsigned AND b_type = c_unsigned)) THEN return_value := 1;
    ELSE return_value                                                    := 0;
    END IF;
    RETURN return_value;
  END inc_if_no_sign;

  FUNCTION inc_if_sign (a_type, b_type : INTEGER) RETURN INTEGER IS
    VARIABLE return_value : INTEGER := 0;
  BEGIN
    IF ((a_type = c_unsigned AND b_type = c_unsigned)) THEN return_value := 0;
    ELSE return_value                                                    := 1;
    END IF;
    RETURN return_value;
  END inc_if_sign;

  FUNCTION inc_baat (baat : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (baat > 1 OR c_mult_type /= CCM) THEN RETURN 1;
    ELSE RETURN 0;
    END IF;
  END inc_baat;

  FUNCTION inc_if_serial (mult_type, sqm_type : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (mult_type /= PARALLEL AND mult_type /= V2_PARALLEL AND sqm_type = 1) THEN RETURN 1;
    ELSE RETURN 0;
    END IF;
  END inc_if_serial;

  FUNCTION has_a_sign (has_a_signed, a_type, baat, a_width : INTEGER) RETURN INTEGER IS
  BEGIN
    IF ((has_a_signed = 1 OR a_type = c_signed) AND (baat < a_width)) THEN
      RETURN 1;
    ELSE
      RETURN has_a_signed;
    END IF;
  END has_a_sign;

  FUNCTION fix_mult_type (a : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (a = V4_PARALLEL OR a = HYBRID) THEN
      RETURN V2_PARALLEL;
    ELSE
      RETURN a;
    END IF;
  END fix_mult_type;

  --Sets the b value for a constant co-efficient multiplier.
  FUNCTION set_b_value RETURN STD_LOGIC_VECTOR IS
    VARIABLE b_tmp   : STD_LOGIC_VECTOR(c_b_width-1 DOWNTO 0);
    VARIABLE ret_val : STD_LOGIC_VECTOR((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, c_mult_type, c_has_loadb)-1) DOWNTO 0);
    VARIABLE msb     : INTEGER := 0;
  BEGIN
    IF (c_mult_type = CCM OR c_mult_type = STATIC_RCCM OR c_mult_type = DYNAMIC_RCCM) THEN
      b_tmp := str_to_slv(c_b_value, c_b_width);
      IF(c_b_type = c_signed AND c_has_loadb = 1 AND c_b_value(1) = '1') THEN
        FOR i IN c_b_width-1 DOWNTO 0 LOOP
          IF (b_tmp(i) = '1') THEN
            msb := i;
            EXIT;
          END IF;
        END LOOP;
        FOR i IN msb TO c_b_width-1 LOOP
          b_tmp(i) := '1';
        END LOOP;
        ret_val := b_tmp;
      ELSIF (c_has_loadb = 1) THEN
        ret_val := b_tmp;
      ELSE
        ret_val := str_to_slv(c_b_value, find_ccm_b_width(b_tmp, c_b_width, c_mult_type, c_has_loadb));
      END IF;
      RETURN ret_val;
    ELSE
      RETURN b_tmp;
    END IF;
  END set_b_value;

----------------------------------------------------------------------------
-- SIGNAL DECLARATION
----------------------------------------------------------------------------
  CONSTANT mult_type : INTEGER := fix_mult_type(c_mult_type);

  SIGNAL b_input : STD_LOGIC_VECTOR((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) DOWNTO 0) := set_b_value;
  SIGNAL bconst0 : STD_LOGIC_VECTOR((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) DOWNTO 0) := set_b_value;
  SIGNAL bconst1 : STD_LOGIC_VECTOR((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) DOWNTO 0) := set_b_value;

  CONSTANT out_size : INTEGER := find_ccm_out_width(set_b_value, c_baat+c_b_width, c_baat);

  SIGNAL full_out_size : INTEGER := find_ccm_out_width(set_b_value, c_a_width+c_b_width, c_a_width);

  CONSTANT ccm_b_width    : INTEGER := select_val(bitstorep_string(c_b_value, c_b_type), c_b_width, c_has_loadb /= 0);
  CONSTANT real_a_width   : INTEGER := (c_a_width-1) - ((c_a_width-1)*c_sqm_type) + 1;
  CONSTANT b_is_0         : BOOLEAN := b_input'length = 1 AND set_b_value(0) = '0' AND mult_type = CCM;
  CONSTANT rom_addr_width : INTEGER := get_rom_addr_width(c_mem_type, bram_addr_width);
  CONSTANT a_input_width  : INTEGER := calc_a_input_width(real_a_width, c_has_a_signed, rom_addr_width, c_baat, c_has_loadb);
  CONSTANT need_addsub    : BOOLEAN := c_has_loadb = 1 AND (c_a_type /= c_unsigned OR c_has_a_signed /= 0);
  CONSTANT ccm_num_pps    : INTEGER := calc_num_pps(a_input_width, rom_addr_width);

  CONSTANT shift_bits         : INTEGER := select_val(calc_shift_bits(c_b_value, c_b_constant, c_b_type), 0, mult_type /= CCM);
  CONSTANT actual_ccm_b_width : INTEGER := select_val((ccm_b_width - shift_bits), c_b_width, c_has_loadb /= 0);
  CONSTANT actual_b_width     : INTEGER := find_b_width(actual_ccm_b_width, c_b_width, mult_type);
  CONSTANT b_is_1             : BOOLEAN := actual_b_width = 1 AND set_b_value(b_input'length-1) = '1' AND mult_type = CCM AND c_b_type = c_unsigned;

  CONSTANT a_sig : INTEGER := has_a_sign(c_has_a_signed, c_a_type, c_baat, c_a_width);
  TYPE     multiplier_stages IS ARRAY (0 TO ((calc_latency(c_family, c_a_width, actual_b_width, c_b_type, a_sig, c_reg_a_b_inputs, c_mem_type, c_pipeline, c_mult_type, c_has_loadb, c_baat, c_b_value, c_a_type, c_has_swapb, c_sqm_type, c_has_aclr, c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, bram_addr_width)))) OF
    STD_LOGIC_VECTOR((c_out_width-1) DOWNTO 0);

  SIGNAL clk_i                   : STD_LOGIC;
  SIGNAL last_clk                : STD_LOGIC                                                                                                                                                                                                                                                                                                      := '0';
  SIGNAL ce_i                    : STD_LOGIC;
  SIGNAL aclr_i                  : STD_LOGIC;
  SIGNAL sclr_i                  : STD_LOGIC;
  SIGNAL nd_i                    : STD_LOGIC                                                                                                                                                                                                                                                                                                      := '0';
  SIGNAL nd_q                    : STD_LOGIC                                                                                                                                                                                                                                                                                                      := '0';
  SIGNAL loadb_i                 : STD_LOGIC;
  SIGNAL loadb_i_nop             : STD_LOGIC;
  SIGNAL load_done_i             : STD_LOGIC                                                                                                                                                                                                                                                                                                      := '1';
  SIGNAL swapb_i                 : STD_LOGIC;
  SIGNAL bank_sel                : STD_LOGIC                                                                                                                                                                                                                                                                                                      := '0';
  SIGNAL bank_sel_pre            : STD_LOGIC                                                                                                                                                                                                                                                                                                      := '0';
  SIGNAL loadb_count             : INTEGER                                                                                                                                                                                                                                                                                                        := -1;
  SIGNAL loadb_count_no_predelay : INTEGER                                                                                                                                                                                                                                                                                                        := -1;
  SIGNAL loadb_count_dly         : INTEGER                                                                                                                                                                                                                                                                                                        := -1;
  SIGNAL loadb_count_dly_int     : INTEGER                                                                                                                                                                                                                                                                                                        := -1;
  SIGNAL rfd_i                   : STD_LOGIC                                                                                                                                                                                                                                                                                                      := '1';
  SIGNAL rfd_f                   : STD_LOGIC                                                                                                                                                                                                                                                                                                      := '1';
  SIGNAL rfd_q                   : STD_LOGIC                                                                                                                                                                                                                                                                                                      := '1';
  SIGNAL rdy_i                   : STD_LOGIC                                                                                                                                                                                                                                                                                                      := '0';
  SIGNAL rdy_q                   : STD_LOGIC                                                                                                                                                                                                                                                                                                      := '0';
  SIGNAL asign_i                 : STD_LOGIC;
  SIGNAL asign_q                 : STD_LOGIC;
  SIGNAL sub_rdy                 : STD_LOGIC_VECTOR((calc_latency(c_family, c_a_width, actual_b_width, c_b_type, a_sig, c_reg_a_b_inputs, c_mem_type, c_pipeline, c_mult_type, c_has_loadb, c_baat, c_b_value, c_a_type, c_has_swapb, c_sqm_type, c_has_aclr, c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, bram_addr_width)) DOWNTO 0) := (OTHERS => '0');
  SIGNAL a_i                     : STD_LOGIC_VECTOR((real_a_width-1) DOWNTO 0);
  SIGNAL b_i                     : STD_LOGIC_VECTOR((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) DOWNTO 0)                                                                                                                                                                                           := (OTHERS => '0');
  SIGNAL reg_b                   : STD_LOGIC_VECTOR((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) DOWNTO 0)                                                                                                                                                                                           := (OTHERS => '0');
  SIGNAL reg_reg_b               : STD_LOGIC_VECTOR((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) DOWNTO 0)                                                                                                                                                                                           := (OTHERS => '0');
  SIGNAL reg_swapb               : STD_LOGIC;
  SIGNAL reg_reg_swapb           : STD_LOGIC;
  SIGNAL reg_loadb               : STD_LOGIC;
  SIGNAL reg_reg_loadb           : STD_LOGIC;
  SIGNAL dina_q                  : STD_LOGIC_VECTOR((real_a_width-1) DOWNTO 0)                                                                                                                                                                                                                                                                    := (OTHERS => '0');
  SIGNAL dinb_q                  : STD_LOGIC_VECTOR((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) DOWNTO 0)                                                                                                                                                                                           := (OTHERS => '0');
  SIGNAL load_b_value            : STD_LOGIC_VECTOR((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) DOWNTO 0);

  SIGNAL product_i   : STD_LOGIC_VECTOR((c_out_width-1) DOWNTO 0) := (OTHERS => '0');
  SIGNAL sub_product : multiplier_stages                          := (OTHERS => (OTHERS => '0'));
  SIGNAL q_i         : STD_LOGIC_VECTOR((c_out_width-1) DOWNTO 0) := (OTHERS => '0');
  SIGNAL o_i         : STD_LOGIC_VECTOR((c_out_width-1) DOWNTO 0) := (OTHERS => '0');
  SIGNAL cleared     : STD_LOGIC;

  CONSTANT no_of_cycles : INTEGER := find_no_of_cycles(c_a_width, c_baat, mult_type);

  SIGNAL   loading : INTEGER := 0;
  CONSTANT no_sign : INTEGER := inc_if_no_sign(c_a_type, c_b_type);

  SIGNAL not_loaded : INTEGER := 1;
  SIGNAL c_latency  : INTEGER := calc_latency(c_family, c_a_width, actual_b_width, c_b_type, a_sig, c_reg_a_b_inputs, c_mem_type, c_pipeline, c_mult_type, c_has_loadb, c_baat, c_b_value, c_a_type, c_has_swapb, c_sqm_type, c_has_aclr, c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, bram_addr_width);

  CONSTANT ccm_serial : INTEGER := inc_if_serial(mult_type, c_sqm_type);

  TYPE sub_mult IS ARRAY (0 TO calc_latency(c_family, c_a_width, actual_b_width, c_b_type, a_sig, 0, c_mem_type, c_pipeline, c_mult_type, c_has_loadb, c_baat, c_b_value, c_a_type, c_has_swapb, c_sqm_type, c_has_aclr, c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, bram_addr_width) - 1) OF STD_LOGIC_VECTOR (out_size-no_sign DOWNTO 0);

  SIGNAL nd_q_tmp : STD_LOGIC := '0';
  SIGNAL nd_q_p   : STD_LOGIC := '0';
  SIGNAL nd_q_c   : STD_LOGIC := '0';
  SIGNAL ready    : STD_LOGIC;
  SIGNAL ready_rl : STD_LOGIC := '0';

  SIGNAL a_in    : STD_LOGIC_VECTOR (real_a_width-1 DOWNTO 0)   := (OTHERS => '0');
  SIGNAL b_in    : STD_LOGIC_VECTOR (b_input'length-1 DOWNTO 0) := (OTHERS => '0');  --set_b_value; --(others => '0');
  SIGNAL a_sign  : STD_LOGIC;
  SIGNAL nd_i_rl : STD_LOGIC                                    := '0';

BEGIN

----------------------------------------------------------------------------
-- PROCESS DECLARATION
---------------------------------------------------------------------------- 

  -- Generate internal control signals using IP variables.
  generate_inputs : PROCESS (clk, a, aclr, sclr, ce, nd, rfd_i, b, swapb, loadb, a_signed, load_done_i, reg_b, reg_reg_b, reg_swapb, reg_reg_swapb, reg_loadb, reg_reg_loadb)
  BEGIN  -- process generate_inputs
    IF (c_reg_a_b_inputs = 1 OR c_has_q = 1 OR c_latency > 0 OR c_has_loadb = 1 OR c_baat < c_a_width) THEN
      clk_i <= clk;
    ELSE
      clk_i <= '0';
    END IF;
    a_i <= a;
    IF (c_predelay = 0 AND mult_type /= CCM) THEN
      b_i <= b;
    ELSIF (c_predelay = 0 AND mult_type = CCM) THEN
      b_i <= b((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) DOWNTO 0);
    ELSIF (c_predelay = 1) THEN
      b_i <= reg_b;
    ELSE
      b_i <= reg_reg_b;
    END IF;
    IF (c_has_aclr = 1) AND NOT(c_baat = c_a_width AND c_latency = 0 AND c_reg_a_b_inputs = 0 AND c_has_q = 0 AND (mult_type = PARALLEL OR mult_type = V2_PARALLEL OR mult_type = CCM)) THEN  -- Change 1910d.
      aclr_i <= aclr;
    ELSE
      aclr_i <= '0';
    END IF;
    IF (c_has_sclr = 1) AND NOT(c_baat = c_a_width AND c_latency = 0 AND c_reg_a_b_inputs = 0 AND c_has_q = 0 AND (mult_type = PARALLEL OR mult_type = V2_PARALLEL OR mult_type = CCM)) THEN
--         and not(mult_type = 3 and loadb_count /= -1) then
      sclr_i <= sclr;
    ELSE
      sclr_i <= '0';
    END IF;
    IF (c_has_ce = 1) AND NOT(c_baat = c_a_width AND c_has_q = 0 AND c_latency = 0 AND c_reg_a_b_inputs = 0 AND c_has_loadb = 0) THEN
      ce_i <= ce;
    ELSE
      ce_i <= '1';
    END IF;
    IF (c_has_nd = 1) THEN
      nd_i <= nd;
    ELSE
      nd_i <= '1';
    END IF;
    IF (c_has_loadb = 1 AND (mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM)) THEN
      loadb_i_nop <= loadb;
      IF (c_predelay = 0) THEN
        loadb_i <= loadb;
      ELSIF (c_predelay = 1) THEN
        loadb_i <= reg_loadb;
      ELSE
        loadb_i <= reg_reg_loadb;
      END IF;
    ELSE
      loadb_i <= '0';
    END IF;
    IF (c_has_swapb = 1 AND (mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM)) THEN
      IF (c_predelay = 0) THEN
        swapb_i <= swapb;
      ELSIF (c_predelay = 1) THEN
        swapb_i <= reg_swapb;
      ELSE
        swapb_i <= reg_reg_swapb;
      END IF;
    ELSE
      swapb_i <= '0';
    END IF;
    IF (c_has_a_signed = 1) THEN
      asign_i <= a_signed;
    ELSE
      asign_i <= '1';
    END IF;
  END PROCESS generate_inputs;

  -- Register Inputs => a, b, nd.  Generate 'Ready for Data'- rfd.
  -- For the non-sequential case rfd_i is always '1' unless there is a aclr,
  -- sclr or loadb. This signal is fed to the rfd output. 
  register_inputs : PROCESS (clk_i, aclr_i, sclr_i, swapb_i, rfd_f, ce_i, nd_q_tmp)
  BEGIN  -- process register_inputs
    IF (aclr_i'event AND aclr_i = '1') THEN
      dina_q <= (OTHERS => '0');
      dinb_q <= (OTHERS => '0');
      nd_q_p <= '0';
      nd_q_c <= '0';
      rfd_i  <= '0';
    ELSIF (sclr_i'event AND sclr_i = '1') THEN
      rfd_i <= '0';
    ELSIF (aclr_i'event AND aclr_i = '0' AND sclr_i = '0') THEN
      rfd_i <= '1';
    ELSIF (sclr_i'event AND sclr_i = '0' AND aclr_i = '0') THEN
      rfd_i <= '1';
    ELSIF (clk_i'event AND clk_i = '1' AND aclr_i = '0') THEN
      IF (sclr_i = '1' AND (ce_i = '1' OR c_sync_enable = 0)) THEN
        dina_q <= (OTHERS => '0');
        IF (mult_type /= STATIC_RCCM OR loadb_count = -1) THEN
          dinb_q <= (OTHERS => '0');
        END IF;
        nd_q_p <= '0';
        nd_q_c <= '0';
      ELSIF (ce_i = '1') THEN
        dina_q  <= a_i;
        dinb_q  <= b_input;
        asign_q <= asign_i;
        nd_q_p  <= nd_i;
        nd_q_c  <= nd_i;
      ELSE
        -- New data ignores the clock enable in the parm.
--            nd_q_p  <= nd_i;-- edited andreww 21st october - ND should only
--            ever be active if CE is asserted
      END IF;
    END IF;
    
  END PROCESS register_inputs;

  choosend : PROCESS(nd_q_c, nd_q_p)
  BEGIN
    IF mult_type < 2 THEN
      nd_q <= nd_q_p;
    ELSE
      nd_q <= nd_q_c;
    END IF;
  END PROCESS choosend;

  -- Cope with predelay from the sequential.
  prdelay : PROCESS(aclr_i, clk_i)
  BEGIN
    IF (aclr_i = '1') THEN
      reg_b         <= (OTHERS => '0');
      reg_reg_b     <= (OTHERS => '0');
      reg_swapb     <= '0';
      reg_reg_swapb <= '0';
      reg_loadb     <= '0';
      reg_reg_loadb <= '0';
    ELSIF clk_i'event AND clk_i = '1' THEN
      IF sclr_i = '1' THEN
        reg_b         <= (OTHERS => '0');
        reg_reg_b     <= (OTHERS => '0');
        reg_swapb     <= '0';
        reg_reg_swapb <= '0';
        reg_loadb     <= '0';
        reg_reg_loadb <= '0';
      ELSIF (ce_i = '1') THEN
        --reg_b <= b;
        reg_b         <= b((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) DOWNTO 0);
        reg_reg_b     <= reg_b;
        reg_swapb     <= swapb;
        reg_reg_swapb <= reg_swapb;
        reg_loadb     <= loadb;
        reg_reg_loadb <= reg_loadb;
      END IF;
    END IF;
  END PROCESS prdelay;

  -- Multiply operands A and B. 
  -- This produces the product_i signal which is input to the pipeline.
  multiply : PROCESS (clk_i, dina_q, dinb_q, a_i, b_input, asign_i, asign_q, aclr_i, nd_i)
  BEGIN  -- process multiply
    IF NOT(c_baat < c_a_width) THEN

      -- Get the a and b values to multiply together.
      IF (c_reg_a_b_inputs = 1) AND (mult_type = PARALLEL OR mult_type = V2_PARALLEL OR mult_type = CCM) THEN
        IF (c_has_nd = 1) AND ((c_has_q = 1 AND c_has_o = 0 AND mult_type = CCM) OR c_latency > 0) THEN  -- mult_type = 2 is Change 51101a.
          a_in   <= dina_q;
          b_in   <= dinb_q;
          a_sign <= asign_q;
        ELSIF (c_has_nd = 1) THEN
          IF aclr_i = '1' THEN
            a_in   <= (OTHERS => '0');
            b_in   <= (OTHERS => '0');
            a_sign <= '0';
          ELSIF clk_i'event AND clk_i = '1' THEN
            IF sclr_i = '1' AND (ce_i = '1' OR c_sync_enable = 0) THEN
              a_in   <= (OTHERS => '0');
              b_in   <= (OTHERS => '0');
              a_sign <= '0';
            ELSIF (nd_i = '1' AND ce_i = '1') THEN
              a_in   <= a_i;
              b_in   <= b_input;
              a_sign <= asign_i;
            END IF;
          END IF;
        ELSE                            -- no ND
          a_in   <= dina_q;
          b_in   <= dinb_q;
          a_sign <= asign_q;
        END IF;
      ELSIF ((mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM) AND c_reg_a_b_inputs = 1) THEN
        IF (c_has_nd = 1) THEN
          IF aclr_i = '1' THEN
            a_in   <= (OTHERS => '0');
            a_sign <= '0';
          ELSIF clk_i'event AND clk_i = '1' THEN
            IF sclr_i = '1' AND (ce_i = '1' OR c_sync_enable = 0) THEN
              a_in   <= (OTHERS => '0');
              a_sign <= '0';
            ELSIF (nd_i = '1' AND ce_i = '1') THEN  -- and (mult_type /= 3 or loadb_count = -1 or loadb = '1')) then
              a_in   <= a_i;
              a_sign <= asign_i;
            END IF;
          END IF;
        ELSE                            -- no ND
          a_in   <= dina_q;
          a_sign <= asign_q;
        END IF;
        -- The reloadable B constant is held by the b_input signal.
        IF (mult_type = STATIC_RCCM AND c_latency = 0 AND c_has_o = 1 AND c_has_nd = 1) THEN
          IF (clk_i'event AND clk_i = '1') THEN
            IF (sclr_i = '1' AND (ce_i = '1' OR c_sync_enable = 0)) THEN
              b_in <= (OTHERS => '0');
            ELSIF (load_done_i = '0' OR (nd_i = '1' AND (ce_i = '1' OR c_has_ce = 0))) THEN
              --         elsif (loadb_count /= -1 or (nd_i = '1' and (ce_i = '1' or c_has_ce = 0))) then
              b_in <= b_input;
            END IF;
          END IF;
        ELSIF mult_type = STATIC_RCCM THEN
          b_in <= dinb_q;               --b_input;
        ELSE
          b_in <= dinb_q;
        END IF;
      ELSE                              -- c_reg_a_b_inputs = 0.
        IF (mult_type = PARALLEL OR mult_type = V2_PARALLEL OR mult_type = CCM) OR c_latency = 0 THEN
          a_in   <= a_i;
          a_sign <= asign_i;
        ELSE
          IF aclr_i = '1' THEN
            a_in   <= (OTHERS => '0');
            a_sign <= '0';
          ELSIF clk_i'event AND clk_i = '1' THEN
            IF sclr_i = '1' AND (ce_i = '1' OR c_sync_enable = 0) THEN
              a_in   <= (OTHERS => '0');
              a_sign <= '0';
            ELSIF ce_i = '1' AND (nd_i = '1' OR c_has_nd = 0 OR
                                  (mult_type = DYNAMIC_RCCM AND c_latency = 1
                                   AND c_mem_type = C_DISTRIBUTED AND c_has_q = 0 AND c_has_swapb = 1)) THEN
              a_in   <= a_i;
              a_sign <= asign_i;
            END IF;
          END IF;
        END IF;
        IF (mult_type = STATIC_RCCM AND c_has_nd = 1) THEN
          IF ((clk_i'event AND clk_i = '1')
              OR (mult_type = STATIC_RCCM AND c_latency = 0 AND nd_i'event AND nd_i = '1')) THEN
            --if (sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0)) then
            --  b_in <= (others => '0');
            --elsif (load_done_i = '0' or (nd_i = '1' and (ce_i = '1' or c_has_ce = 0))) then
            IF (not_loaded = 1 OR load_done_i = '0' OR (nd_i = '1'
                                                        AND (ce_i = '1' OR c_has_ce = 0))) THEN
              b_in <= b_input;
            END IF;
          END IF;
        ELSE
          b_in <= b_input;
        END IF;
        --b_in   <= b_input;
      END IF;

    END IF;
  END PROCESS multiply;

  multiply2 : PROCESS(a_in, b_in, a_sign, loadb_count, loadb_count_dly_int)
  BEGIN
    IF (c_baat = c_a_width) THEN
      -- Calculate output of multiplier stage
      --if (c_has_loadb = 1 and c_has_swapb = 0) and (loadb_count /= -1 and (loadb_count /= 0 or loadb = '1') and not_loaded = 0) then
      --if (c_has_loadb = 1 and c_has_swapb = 0) and ((loadb_count /= -1 or loadb_count_dly_int /= -1) and not_loaded = 0) then
      --if (c_has_loadb = 1 and c_has_swapb = 0) and (loadb_count /= -1 and not_loaded = 0) then
      IF (c_has_loadb = 1 AND c_has_swapb = 0) AND c_latency = 0 AND
        (loadb_count /= -1 AND not_loaded = 0) THEN
        -- Loading.
        product_i <= (OTHERS => 'X');
      ELSIF (c_has_loadb = 1 AND c_has_swapb = 0) AND c_latency /= 0 AND
        ((loadb_count /= -1 OR loadb_count_dly_int /= -1) AND not_loaded = 0) THEN
        -- Loading.
        product_i <= (OTHERS => 'X');
      ELSE
        product_i <= mult(a_in, b_in, a_sign, 0, c_out_width);
      END IF;
    END IF;
  END PROCESS multiply2;

  -- For the reloadable ccm without a swapb pin we have to mask of the incoming
  -- new data with the load_done output.
  rdyrlgen : PROCESS(aclr_i, clk_i)
  BEGIN
    IF (aclr_i = '1') THEN
      ready_rl <= '0';
    ELSIF (clk_i'event AND clk_i = '1') THEN
      IF (sclr_i = '1' AND (ce_i = '1' OR c_sync_enable = 0)) THEN
        ready_rl <= '0';
      ELSIF ce_i = '1' THEN
        ready_rl <= nd_i AND load_done_i;
      END IF;
    END IF;
  END PROCESS rdyrlgen;

  -- Model the ready generation.
  rdygen : PROCESS(nd_i, nd_q, nd_q_c, ce_i, load_done_i, ready_rl)
  BEGIN
    IF c_baat = c_a_width THEN
      IF c_has_swapb = 0 AND c_has_loadb = 1 AND mult_type = STATIC_RCCM THEN  -- Reloadable ccm (stop during reload).
        IF c_reg_a_b_inputs = 0 THEN
          ready <= nd_i AND load_done_i;
        ELSE
          ready <= ready_rl;
        END IF;
      ELSIF mult_type = CCM OR mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM THEN          -- ccm and continue_during_reload rccm.
        IF c_reg_a_b_inputs = 0 THEN
          ready <= nd_i;
        ELSE
          ready <= nd_q;
        END IF;
      ELSE                              -- parm
        IF (c_latency+c_reg_a_b_inputs = 0) OR (c_latency = 1 AND c_reg_a_b_inputs = 0 AND c_has_q = 0) THEN
          ready <= nd_i AND ce_i;
        ELSIF (c_latency = 0 AND c_reg_a_b_inputs = 1 AND c_has_q = 0) THEN
          ready <= nd_q_c;
        ELSE
          ready <= nd_q AND ce_i;
        END IF;
      END IF;
    END IF;
  END PROCESS rdygen;

  -- The block memory doesn't have an aclr and so the reloadable can have an 
  -- undefined output just after an aclr. The cleared signal helps us model this.
  clrgen : PROCESS(aclr_i, clk_i)
  BEGIN
    IF (aclr_i = '0') THEN
      cleared <= '0';
    ELSIF (clk_i'event AND clk_i = '1' AND ce_i = '1') THEN
      cleared <= '1';
    END IF;
  END PROCESS clrgen;

  -- Model the pipeline. The product_i signal is input to position 0 in the pipeline.
  -- If there is some latency in the design the o and q outputs are taken from the 
  -- c_latency position in the pipeline. Otherwise they are taken from product_i.
  pipeline_output : PROCESS (clk_i, aclr_i, product_i, ce_i, nd_q, nd_i, swapb_i)
  BEGIN  -- process register_output
    IF (c_baat = c_a_width) THEN
      -- Load the pipeline
      --if (loadb_count /= -1 and c_has_swapb = 0) then
      --  sub_product(0) <= (others => 'X'); -- Undefined during the load.
      --elsif mult_type > 2 and c_latency > 0 and c_reg_a_b_inputs = 0 then
      IF (mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM) AND c_latency > 0 AND c_reg_a_b_inputs = 0 THEN
        sub_product(0) <= product_i;
      ELSIF c_reg_a_b_inputs = 1 THEN
        IF (c_has_q = 0) AND c_latency = 0 THEN
          sub_product(0) <= product_i;
        ELSE                     -- Some registers after the input stage.
          IF aclr_i = '1' AND ((mult_type = PARALLEL OR mult_type = V2_PARALLEL) OR c_mem_type = C_DISTRIBUTED OR b_is_1) THEN
            sub_product(0) <= (OTHERS => '0');
          ELSIF clk_i'event AND clk_i = '1' THEN
            IF sclr_i = '1' AND (ce_i = '1' OR c_sync_enable = 0) AND
              NOT(mult_type = STATIC_RCCM AND loadb_count /= -1) THEN
              sub_product(0) <= (OTHERS => '0');
            ELSIF ((mult_type = PARALLEL OR mult_type = V2_PARALLEL) AND c_latency = 0 AND ce_i = '1' AND c_has_q = 1) THEN
              sub_product(0) <= product_i;
            ELSIF ((nd_q = '1' OR (mult_type = STATIC_RCCM AND loadb_count /= -1))
                   OR c_has_swapb = 1 OR c_has_nd = 0
                   OR ((mult_type = PARALLEL OR mult_type = V2_PARALLEL) AND c_latency = 0 AND c_has_q = 0)) AND ce_i = '1' THEN 
              sub_product(0) <= product_i;
            END IF;
          END IF;
        END IF;
      ELSE                              -- c_reg_a_b_inputs = 0.
        IF c_latency = 0 AND c_has_q = 0 THEN
          sub_product(0) <= product_i;
        ELSIF c_has_nd = 0 THEN         -- c_has_nd = 0
          IF aclr_i = '1' AND ((mult_type = PARALLEL OR mult_type = V2_PARALLEL) OR c_mem_type = C_DISTRIBUTED OR b_is_1) THEN
            sub_product(0) <= (OTHERS => '0');
          ELSIF clk_i'event AND clk = '1' THEN
            IF sclr_i = '1' AND (ce_i = '1' OR c_sync_enable = 0)
              AND NOT(mult_type = STATIC_RCCM AND loadb_count /= -1) THEN
              sub_product(0) <= (OTHERS => '0');
            ELSIF ce_i = '1' THEN
              sub_product(0) <= product_i;
            END IF;
          END IF;
        ELSIF (c_has_nd = 1 AND (mult_type = PARALLEL OR mult_type = V2_PARALLEL) AND NOT(c_latency = 1 AND c_has_o = 1)) THEN
          IF aclr_i = '1' AND ((mult_type = PARALLEL OR mult_type = V2_PARALLEL) OR c_mem_type = C_DISTRIBUTED) THEN
            sub_product(0) <= (OTHERS => '0');
          ELSIF clk_i'event AND clk = '1' THEN
            IF sclr_i = '1' AND (ce_i = '1' OR c_sync_enable = 0)
              AND NOT(mult_type = STATIC_RCCM AND loadb_count /= -1) THEN
              sub_product(0) <= (OTHERS => '0');
            ELSIF ((ce_i = '1' AND c_latency = 0 AND c_has_q = 1 AND nd_i = '1')
                   OR (ce_i = '1' AND NOT(c_latency = 0 AND c_has_q = 1))) THEN
              sub_product(0) <= product_i;
            END IF;
          END IF;
        ELSE                            -- c_has_nd = 1.
          IF c_latency = 0 THEN
            IF aclr_i = '1' AND ((mult_type = PARALLEL OR mult_type = V2_PARALLEL) OR c_mem_type = C_DISTRIBUTED OR b_is_1) THEN
              sub_product(0) <= (OTHERS => '0');
            ELSIF clk_i'event AND clk = '1' THEN
              IF sclr_i = '1' AND (ce_i = '1' OR c_sync_enable = 0)
                AND NOT(mult_type = STATIC_RCCM AND loadb_count /= -1) THEN
                sub_product(0) <= (OTHERS => '0');
              ELSIF (nd_i = '1' OR (mult_type = STATIC_RCCM AND loadb_count /= -1)) AND ce_i = '1' THEN
                sub_product(0) <= product_i;
              ELSIF ce_i = '1' THEN
              END IF;
            END IF;
          ELSE                          -- c_latency > 0
            IF aclr_i = '1' AND ((mult_type = PARALLEL OR mult_type = V2_PARALLEL) OR c_mem_type = C_DISTRIBUTED) THEN
              sub_product(0) <= (OTHERS => '0');
            ELSIF clk_i'event AND clk = '1' THEN
              IF sclr_i = '1' AND (ce_i = '1' OR c_sync_enable = 0)
                AND NOT(mult_type = STATIC_RCCM AND loadb_count /= -1) THEN
                sub_product(0) <= (OTHERS => '0');
              ELSIF ce_i = '1' AND ((nd_i = '1' OR (mult_type = STATIC_RCCM AND loadb_count /= -1)) OR swapb_i = '1') THEN
                sub_product(0) <= product_i;
              ELSIF ce_i = '1' THEN
              END IF;
            END IF;
          END IF;
        END IF;
      END IF;
      -- Update the pipeline
      -- Clear it.
      IF ((aclr_i = '1')) THEN
        IF (c_mem_type = C_DP_BLOCK AND (mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM) AND (c_latency > 1 OR (mult_type = STATIC_RCCM AND c_mem_type = C_DP_BLOCK AND c_latency = 1))) THEN  --and (c_pipeline = 0 or c_latency < 4)) then -- Change 1910b/d and 2610a.
          IF (cleared = '0' AND clk_i'event AND clk_i = '1' AND ce_i = '1') THEN
            sub_product(c_latency) <= (OTHERS => '0');
          ELSIF (cleared = '0') THEN
            FOR n IN 0 TO c_latency LOOP
              sub_product(n) <= (OTHERS => 'X');
            END LOOP;
          END IF;
        ELSE
          FOR n IN 1 TO c_latency LOOP
            sub_product(n) <= (OTHERS => '0');
          END LOOP;
        END IF;
      ELSIF (clk_i'event AND clk_i = '1') THEN
        IF (sclr_i = '1' AND (ce_i = '1' OR c_sync_enable = 0))
          AND NOT(mult_type = STATIC_RCCM AND loadb_count /= -1 AND c_mem_type = C_DP_BLOCK) THEN
          IF (c_mem_type = C_DISTRIBUTED OR (mult_type = PARALLEL OR mult_type = V2_PARALLEL) OR c_sync_enable = 1 OR ce_i = '1') THEN
            IF ((mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM) AND c_mem_type = C_DP_BLOCK AND c_has_loadb = 1 AND c_has_swapb = 0 AND c_latency > 1 AND loadb_count /= -1) THEN
              FOR n IN c_latency-1 TO c_latency LOOP
                sub_product(n) <= (OTHERS => '0');
              END LOOP;
            ELSIF (mult_type = STATIC_RCCM AND loadb_count /= -1 AND c_mem_type = C_DISTRIBUTED AND c_latency > 3) THEN
              FOR n IN 1 TO c_latency LOOP
                sub_product(n) <= (OTHERS => '0');
              END LOOP;  -- n
            ELSIF (mult_type /= STATIC_RCCM OR loadb_count = -1) THEN
              FOR n IN 0 TO c_latency LOOP
                sub_product(n) <= (OTHERS => '0');
              END LOOP;  -- n
            ELSE
              FOR n IN 1 TO c_latency LOOP
                sub_product(n) <= (OTHERS => '0');
              END LOOP;
            END IF;
          ELSIF c_latency > 0 THEN
            IF ((mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM) AND c_mem_type = C_DP_BLOCK AND c_has_loadb = 1 AND c_has_swapb = 0 AND c_latency > 1 AND loadb_count /= -1) THEN
              FOR n IN 2 TO c_latency LOOP
                sub_product(n) <= (OTHERS => '0');
              END LOOP;
            ELSE
              FOR n IN 1 TO c_latency LOOP
                sub_product(n) <= (OTHERS => '0');
              END LOOP;  -- n
            END IF;
          END IF;
        ELSIF (ce_i = '1') THEN
          IF (c_reg_a_b_inputs = 1 OR c_has_nd = 0 OR ((mult_type = CCM OR mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM) OR ((mult_type = PARALLEL OR mult_type = V2_PARALLEL) AND c_latency = 1 AND c_has_o = 1)) OR c_pipeline = 0) AND c_latency > 0 THEN  -- Temp change 2410a.
            FOR n IN 1 TO c_latency LOOP
              sub_product(n) <= sub_product(n-1);
            END LOOP;  -- n
          ELSE
            -- Here the first pipeline stage gets the output of the multiplier when 
            -- clock enable is high but the result is only passed onto the second stage 
            -- when a high on new data is recieved.
            IF c_latency > 1 THEN
              FOR n IN 2 TO c_latency LOOP
                sub_product(n) <= sub_product(n-1);
              END LOOP;  -- n
            END IF;
            IF c_latency > 0 THEN
              FOR n IN 1 TO 1 LOOP
                IF nd_q = '1' THEN
                  sub_product(n) <= sub_product(0);
                END IF;
              END LOOP;
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS pipeline_output;

  -- Model the ready output pipeline.
  rdypipegen : PROCESS(ready, clk_i, aclr_i)
  BEGIN
    IF (c_baat = c_a_width) THEN
      IF (ready'event OR aclr_i'event) AND (aclr_i = '0' OR c_latency = 0) THEN
        sub_rdy(0) <= ready;
      ELSIF (aclr_i = '1') THEN
        FOR n IN 0 TO c_latency LOOP
          sub_rdy(n) <= '0';
        END LOOP;
      ELSIF clk_i'event AND clk_i = '1' THEN
        IF sclr_i = '1' AND (ce_i = '1' OR c_sync_enable = 0) THEN
          FOR n IN 1 TO c_latency LOOP
            sub_rdy(n) <= '0';
          END LOOP;
        ELSIF ce_i = '1' THEN
          FOR n IN 1 TO c_latency LOOP
            sub_rdy(n) <= sub_rdy(n-1);
          END LOOP;
        END IF;
      END IF;
    END IF;
  END PROCESS rdypipegen;

  -- Now drive the internal versions of the o and q outputs.
  register_output : PROCESS (sub_product, product_i, clk_i, aclr_i, sub_rdy, ready, sclr_i, ce_i)
  BEGIN  -- process register_output
    IF (c_baat = c_a_width) THEN
      IF (aclr_i = 'X' OR sclr_i = 'X' OR ce_i = 'X') THEN  -- or clk_i = 'X') then
        IF (c_latency > 0 OR c_reg_a_b_inputs = 1) THEN
          o_i <= (OTHERS => 'X');
        ELSE
          o_i <= product_i;
        END IF;
        q_i   <= (OTHERS => 'X');
        rdy_i <= 'X';
      ELSIF c_latency = 0 THEN
        o_i <= product_i;
        IF (c_mem_type = C_DISTRIBUTED OR (mult_type = PARALLEL OR mult_type = V2_PARALLEL)) THEN
          IF (aclr_i = '1') THEN
            q_i <= (OTHERS => '0');
          ELSE
            q_i <= sub_product(0);
          END IF;
        ELSE
          q_i <= sub_product(0);
        END IF;
        rdy_i <= ready;
      ELSE
        IF (c_mem_type = C_DP_BLOCK AND (mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM) AND c_latency > 2 AND (c_pipeline = 0 OR c_latency > 3)) THEN
          IF aclr_i = '1' THEN
            o_i <= (OTHERS => '0');
            q_i <= (OTHERS => '0');
          ELSE
            o_i <= sub_product(c_latency - 1);
            q_i <= sub_product(c_latency);
          END IF;
        ELSIF (c_mem_type = C_DP_BLOCK AND (mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM) AND (c_latency = 2 OR (c_pipeline = 1 AND c_latency > 1))) THEN
          o_i <= sub_product(c_latency - 1);
          IF aclr_i = '1' THEN
            q_i <= (OTHERS => '0');
          ELSIF sub_product'event OR aclr_i'event THEN
            q_i <= sub_product(c_latency);
          END IF;
        ELSE
          o_i <= sub_product(c_latency - 1);
          q_i <= sub_product(c_latency);
        END IF;
        IF (c_reg_a_b_inputs = 1 OR c_has_nd = 0 OR (mult_type = CCM OR mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM) OR c_pipeline = 0 OR c_latency < 1)
          OR (c_pipeline = 1 AND c_has_nd = 1 AND (mult_type = PARALLEL OR mult_type = V2_PARALLEL) AND c_latency = 1 AND c_reg_a_b_inputs = 0 AND c_has_q = 0) THEN
          rdy_i <= sub_rdy(c_latency);
        ELSE
          rdy_i <= sub_rdy(c_latency - 1);
        END IF;
      END IF;
      IF (aclr_i = 'X' OR sclr_i = 'X' OR ce_i = 'X') THEN  -- or clk_i = 'X') then
        rdy_q <= 'X';
        rfd_q <= 'X';
      ELSIF aclr_i = '1' THEN
        rdy_q <= '0';
        rfd_q <= '0';
      ELSIF clk_i'event AND clk_i = '1' THEN
        IF sclr_i = '1' AND (ce_i = '1' OR c_sync_enable = 0) THEN
          rdy_q <= '0';
          rfd_q <= '0';
        ELSIF ce_i = '1' THEN
          rdy_q <= rdy_i;
          rfd_q <= rfd_i;
        END IF;
      END IF;
    END IF;
  END PROCESS register_output;

  lastclkgen : PROCESS(clk_i)
  BEGIN
    IF (clk_i'event AND clk_i = '1') THEN
      last_clk <= '1';
    END IF;
  END PROCESS lastclkgen;

  -- loadb PROCESS
  -- If a reloadable multiplier is selected this process calculates the b input value. 
  PROCESS (aclr_i, clk_i, b, rfd_i, nd_i, nd_q)
    CONSTANT rom_addr_width : INTEGER :=
      get_rom_addr_width(c_mem_type, bram_addr_width);
    CONSTANT sig_bits    : INTEGER := select_val(c_baat, rom_addr_width, c_baat >= rom_addr_width);
    CONSTANT loadb_delay : INTEGER := 2**sig_bits - 1;
  BEGIN

    IF (mult_type = PARALLEL OR mult_type = V2_PARALLEL OR mult_type = CCM) THEN
      -- assign nothing
    ELSIF (c_has_loadb = 1) THEN
      IF c_has_aclr /= 0 AND aclr_i = '1' THEN
        IF loadb_count /= -1 THEN
          loadb_count <= -2;
        END IF;
      ELSIF (clk_i'event AND (clk_i = '1')) THEN
        IF (loadb_i = 'X') THEN
          loadb_count <= -3;
          IF (c_has_swapb /= 0 AND bank_sel = 'X') THEN
            bconst1 <= (OTHERS => 'X');
            bconst0 <= (OTHERS => 'X');
          ELSIF c_has_swapb /= 0 AND bank_sel = '0' THEN
            bconst1 <= (OTHERS => 'X');
          ELSE
            bconst0 <= (OTHERS => 'X');
          END IF;
        ELSIF (c_sync_enable = c_override AND c_has_sclr /= 0 AND sclr_i = '1') OR
          (c_has_sclr /= 0 AND sclr_i = '1' AND (c_has_ce = 0 OR ce_i = '1')) THEN
          IF loadb_count /= -1 THEN
            loadb_count <= -2;
          END IF;
        ELSIF c_has_ce = 0 OR ce_i = '1' THEN
          IF loadb_i = '1' THEN
            IF (c_reg_a_b_inputs = 1 OR c_has_a_signed = 1 OR c_a_type = c_signed) THEN
              loadb_count <= loadb_delay+1+c_reg_a_b_inputs;
            ELSE
              loadb_count <= loadb_delay;
            END IF;
            load_b_value <= b_i;
            not_loaded   <= 0;
          ELSE
            IF (c_has_o = 1 AND mult_type = STATIC_RCCM AND c_has_swapb = 0 AND loadb_count = 2
                AND loadb_delay > 2 AND c_has_nd = 1) THEN  -- and c_reg_a_b_inputs = 1 and c_latency = 0) then
              -- Load the constant early in this case.
              bconst0     <= load_b_value;
              loadb_count <= loadb_count-1;
            ELSIF loadb_count > 0 THEN
              loadb_count <= loadb_count-1;
            ELSIF loadb_count = 0 THEN
              -- Write opposite bank to the one we are currently reading
              IF c_has_swapb /= 0 AND bank_sel = '0' THEN
                bconst1 <= load_b_value;
              ELSE
                bconst0 <= load_b_value;
              END IF;  -- bank_sel
              --if (nd_i = '1' or (c_has_swapb = 1 or c_has_nd = 0 or c_reg_a_b_inputs = 1)) then
              loadb_count <= -1;
              --end if;
              not_loaded  <= 0;
            ELSIF loadb_count = -2 THEN
              -- Load has been interrupted by a clear. Load constant 
              -- with X's.
              IF c_has_swapb /= 0 AND bank_sel = '0' THEN
                bconst1 <= (OTHERS => 'X');
              ELSE
                bconst0 <= (OTHERS => 'X');
              END IF;  -- bank_sel
              not_loaded <= 0;
            END IF;  -- loadb_count
          END IF;  -- loadb
        END IF;  -- c_has_ce
      END IF;  -- aclr
    END IF;
  END PROCESS;

  PROCESS (aclr_i, clk_i, b, rfd_i, nd_i, nd_q)
    CONSTANT rom_addr_width : INTEGER :=
      get_rom_addr_width(c_mem_type, bram_addr_width);
    CONSTANT sig_bits       : INTEGER := select_val(c_baat, rom_addr_width, c_baat >= rom_addr_width);
    CONSTANT loadb_delay    : INTEGER := 2**sig_bits - 1;
    VARIABLE pre_delay_comp : INTEGER := 0;
  BEGIN
    IF (c_predelay = 0 OR c_predelay = 1 OR (c_predelay = 2 AND loadb_delay > 1)) THEN
      pre_delay_comp := c_predelay;
    ELSE
      pre_delay_comp := 1;
    END IF;

    IF (mult_type = PARALLEL OR mult_type = V2_PARALLEL OR mult_type = CCM) THEN
      load_done_i <= '1';
    ELSIF (c_has_loadb = 1) THEN
      IF c_has_aclr /= 0 AND aclr_i = '1' THEN
        load_done_i <= '1';
        rfd_f       <= '1';
        IF loadb_count /= -1 THEN
          loadb_count_no_predelay <= -2;
        END IF;
      ELSIF (clk_i'event AND (clk_i = '1')) THEN
        IF (loadb_i_nop = 'X') THEN
          load_done_i             <= 'X';
          rfd_f                   <= 'X';
          loadb_count_no_predelay <= -3;
        ELSIF (c_sync_enable = c_override AND c_has_sclr /= 0 AND sclr_i = '1') OR
          (c_has_sclr /= 0 AND sclr_i = '1' AND (c_has_ce = 0 OR ce_i = '1')) THEN
          load_done_i <= '1';
          rfd_f       <= '1';
          IF loadb_count /= -1 THEN
            loadb_count_no_predelay <= -2;
          END IF;
        ELSIF c_has_ce = 0 OR ce_i = '1' THEN
          IF loadb_i_nop = '1' THEN
            loadb_count_no_predelay <= loadb_delay;
            load_done_i             <= '0';
            IF (c_baat = c_a_width) OR (ccm_serial = 1 AND c_reg_a_b_inputs = 0) THEN
              IF(c_has_swapb = 0) THEN
                rfd_f <= '0';
              ELSE
                rfd_f <= '1';
              END IF;
            END IF;
          ELSE                          --if loadb = '0' then
            IF (loadb_count_no_predelay > 0) THEN
              loadb_count_no_predelay <= loadb_count_no_predelay-1;
            ELSIF (loadb_count_no_predelay = 0) THEN
              load_done_i <= '1';
              rfd_f       <= '1';
            ELSIF (loadb_count_no_predelay = -2) THEN
              load_done_i <= '1';
              rfd_f       <= '1';
            END IF;  -- loadb_count
          END IF;  -- loadb
        END IF;  -- c_has_ce
      END IF;  -- aclr
    END IF;
  END PROCESS;

  -- Loadb_count_dly is just loadb_count delayed by 1 clock cycle. This is necessary 
  -- to mask out the first result after a load in certain cases.
  PROCESS(aclr_i, clk_i)
  BEGIN
    IF aclr_i = '1' THEN
      loadb_count_dly     <= -1;
      loadb_count_dly_int <= -1;
    ELSIF clk_i'event AND clk_i = '1' AND ce_i = '1' THEN
      loadb_count_dly_int <= loadb_count;
      --if (nd_i = '1' or (c_has_swapb = 1 or c_has_nd = 0 or c_reg_a_b_inputs = 1)) then
      loadb_count_dly     <= loadb_count_dly_int;
      --end if;
    END IF;
  END PROCESS;

  PROCESS(loadb_count_dly, loadb_count_dly_int)
  BEGIN
    IF (loadb_count = -1 AND loadb_count_dly_int = 0) THEN
      nd_i_rl <= '1';
    ELSE
      nd_i_rl <= '0';
    END IF;
  END PROCESS;


  PROCESS (bconst0, bconst1, bank_sel, b, load_done_i, aclr_i, clk_i, rfd_i, nd_i, nd_q)
    VARIABLE b_tmp  : STD_LOGIC_VECTOR(c_b_width-1 DOWNTO 0) := (OTHERS => '0');
    VARIABLE b_tmp2 : STD_LOGIC_VECTOR(c_b_width-1 DOWNTO 0) := (OTHERS => '0');
    VARIABLE msb    : INTEGER                                := 0;
  BEGIN
    IF (mult_type = PARALLEL OR mult_type = V2_PARALLEL) THEN
      b_input <= b;
    ELSIF (mult_type = PARALLEL OR mult_type = V2_PARALLEL OR mult_type = CCM) OR (not_loaded = 1 AND loadb_i = '0') THEN
    ELSE
      --if (load_done_i = '1' or c_has_swapb = 1) then
      IF (loadb_count = -1 OR c_has_swapb = 1) THEN
        IF(bank_sel = '0' AND (mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM) AND not_loaded = 0) THEN
          IF (c_has_nd = 0) OR (c_has_swapb = 1 AND loadb_count < 0) THEN
            b_input <= bconst0;
          ELSIF (c_has_nd = 1 AND c_has_swapb = 0) THEN  -- and nd_i = '1') then
            b_input <= bconst0;
          END IF;
        ELSIF(bank_sel = '1' AND (mult_type = STATIC_RCCM OR mult_type = DYNAMIC_RCCM) AND not_loaded = 0 AND loadb_count < 0) THEN  -- Change 2910a.
          b_input <= bconst1;
        END IF;
      ELSE
        -- Loading.
        b_input <= (OTHERS => 'X');
      END IF;
    END IF;
  END PROCESS;

  -- If the multiplier has a swapb pin then this process is used to swap between the two
  -- banks of memory.
  PROCESS (aclr_i, clk_i)
  BEGIN
    IF (c_has_swapb = 0) THEN
      bank_sel <= '0';
    ELSIF c_has_swapb /= 0 THEN
      IF c_has_aclr /= 0 AND aclr_i = '1' THEN
        bank_sel     <= '0';
        bank_sel_pre <= '0';
      ELSIF (clk_i'event AND (clk_i = '1')) THEN
        IF (c_reg_a_b_inputs = 0 AND c_latency > 0 AND c_has_swapb = 1 AND (c_has_ce = 0 OR ce_i = '1')) THEN
          bank_sel <= bank_sel_pre;
        END IF;
        IF (c_sync_enable = c_override AND c_has_sclr /= 0 AND sclr_i = '1') OR
          (c_has_sclr /= 0 AND sclr_i = '1' AND (c_has_ce = 0 OR ce_i = '1')) THEN
          bank_sel     <= '0';
          bank_sel_pre <= '0';
        ELSIF c_has_ce = 0 OR ce_i = '1' THEN
          IF (c_reg_a_b_inputs = 1 OR c_latency = 0 OR c_baat < c_a_width) AND c_has_swapb = 1 AND swapb_i = '1' AND loadb_count < 0 THEN  -- Change 1910e.
            bank_sel <= NOT(bank_sel);
          ELSIF (c_reg_a_b_inputs = 0 AND c_latency > 0 AND c_baat = c_a_width) AND c_has_swapb = 1 AND swapb_i = '1' AND loadb_count < 0 THEN  --and (c_latency < 2 or c_has_nd = 0 or nd_i = '1') then -- Change 1910e.
            bank_sel_pre <= NOT(bank_sel_pre);
          END IF;
        END IF;  -- c_has_ce ...
      END IF;  -- aclr
    END IF;  -- c_has_swapb
  END PROCESS;

  -- Connect up the outputs.
  drive_output : PROCESS (o_i, rdy_q, rdy_i, q_i, rfd_i, load_done_i, clk_i, aclr_i)
  BEGIN
    IF (c_has_o = 1) THEN
      o <= o_i;
    ELSE
      o <= (OTHERS => 'X');
    END IF;
    IF (c_has_q = 1) THEN
      q <= q_i;
      IF (c_has_nd = 1) THEN
        IF ((c_has_rdy = 1) AND ((c_pipeline = 0 OR c_latency = 0) AND c_reg_a_b_inputs = 0 AND c_has_q = 0 AND c_has_o = 1)) OR (b_is_0) THEN
          rdy <= rdy_i;
        ELSIF (c_has_rdy = 1) AND ((c_pipeline = 1 AND c_latency /= 0) OR c_reg_a_b_inputs = 1 OR c_has_q = 1) THEN
          rdy <= rdy_q;
        END IF;
      ELSIF (c_has_nd = 0) THEN
        rdy <= '1';
      ELSE
        rdy <= 'X';
      END IF;
      IF (c_has_rfd = 1) THEN
        rfd <= rfd_i AND rfd_f;
      ELSE
        rfd <= 'X';
      END IF;
      IF (c_has_load_done = 1) THEN
        load_done <= load_done_i;
      ELSE
        load_done <= 'X';
      END IF;
    ELSE
      q <= (OTHERS => 'X');
      IF (c_has_rdy = 1) THEN
        IF (c_has_nd = 0) THEN
          rdy <= '1';
        ELSE
          rdy <= rdy_i;
        END IF;
      ELSE
        rdy <= 'X';
      END IF;
      IF (c_has_rfd = 1) THEN
        rfd <= rfd_i AND rfd_f;
      ELSE
        rfd <= 'X';
      END IF;
      IF (c_has_load_done = 1) THEN
        load_done <= load_done_i;
      ELSE
        load_done <= 'X';
      END IF;
    END IF;
  END PROCESS drive_output;
  

END behavioral;

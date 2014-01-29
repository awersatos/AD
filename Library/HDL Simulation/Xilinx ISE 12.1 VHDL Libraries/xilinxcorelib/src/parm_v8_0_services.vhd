-- $RCSfile: parm_v8_0_services.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:37:44 $
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

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v8_0.ALL;
USE XilinxCoreLib.mult_gen_const_pkg_v8_0.ALL;

PACKAGE parm_v8_0_services IS

  FUNCTION get_parm_v8_0_latency (family : STRING; mult_type, a_width, a_type, b_width,
  b_type, reg_a_b_inputs, pipeline,
  has_aclr, has_sclr, has_ce, sync_enable,
  has_a_signed, has_nd, has_q                           : INTEGER) RETURN INTEGER;

  FUNCTION log2d(x : INTEGER) RETURN INTEGER;

  FUNCTION check_18(has_a_signed, a_width, a_type : INTEGER) RETURN INTEGER;

  FUNCTION calc_num_pps(mult_type, a_width, a_type, b_width, b_type, has_a_signed : INTEGER) RETURN INTEGER;

  FUNCTION select_val_int(i0 : INTEGER; i1 : INTEGER; sel : INTEGER) RETURN INTEGER;

  FUNCTION select_val(i0 : INTEGER; i1 : INTEGER; sel : BOOLEAN) RETURN INTEGER;

  FUNCTION calc_mult18s_usage(mult_type, has_aclr, has_sclr, has_ce, sync_enable : INTEGER) RETURN INTEGER;

  FUNCTION use_hybrid (c_a_width, c_a_type, c_b_width, c_b_type, c_mult_type : INTEGER) RETURN INTEGER;
  
END parm_v8_0_services;

PACKAGE BODY parm_v8_0_services IS

  CONSTANT mult_in_unsigned : INTEGER := 17;
  CONSTANT mult_in          : INTEGER := 18;

-------------------------------------------------------------------------------
-- The purpose of the get_parm_v8_0_latency is to return an integer value,
-- which represents the number of clock cycles that the parallel multiplier
-- will take to produce a result from a given set of inputs.
-- All of the parameters being passed to this function are present in the
-- multiplier generic, and therefore should already be known to the ip developer
-------------------------------------------------------------------------------

  FUNCTION set_ce (c_has_ce : INTEGER; ignore_nd : BOOLEAN) RETURN INTEGER IS
  BEGIN
    IF(c_has_ce = 1) THEN
      RETURN 1;
    ELSE
      IF(ignore_nd) THEN
        RETURN 0;
      ELSE
        RETURN 1;
      END IF;
    END IF;
  END set_ce;

  -- purpose: swaps the input values around to ensure the largest operand is on port A
  FUNCTION swap_inputs(a, b, sel : INTEGER) RETURN INTEGER IS
  BEGIN  -- FUNCTION swap_inputs
    IF sel = 0 THEN
      -- want A port value
      IF a >= b THEN
        RETURN a;
      ELSE
        RETURN b;
      END IF;
    ELSIF sel = 1 THEN
      -- want B port value
      IF b <= a THEN
        RETURN b;
      ELSE
        RETURN a;
      END IF;
    ELSE
      RETURN 0;
    END IF;
  END FUNCTION swap_inputs;
  
  FUNCTION get_parm_v8_0_latency (family : STRING;
                                  mult_type,
                                  a_width,
                                  a_type,
                                  b_width,
                                  b_type,
                                  reg_a_b_inputs,
                                  pipeline,
                                  has_aclr,
                                  has_sclr,
                                  has_ce,
                                  sync_enable,
                                  has_a_signed,
                                  has_nd,
                                  has_q         : INTEGER) RETURN INTEGER IS
    VARIABLE latency   : INTEGER;
    CONSTANT num_pps   : INTEGER := calc_num_pps(mult_type, a_width, a_type, b_width, b_type, has_a_signed);
    CONSTANT ignore_nd : BOOLEAN := has_nd = 0 OR (has_nd /= 0 AND reg_a_b_inputs = 0 AND has_q = 0 AND (pipeline = 0 OR num_pps = 1));
    CONSTANT true_ce   : INTEGER := set_ce(has_ce, ignore_nd);
    CONSTANT mult18s   : INTEGER := calc_mult18s_usage(mult_type, has_aclr, has_sclr, true_ce, sync_enable);

    -- changed C_SIGNED to C_UNSIGNED below - a bug??? - want 1 returned if unsigned or controlled by pin
    CONSTANT true_c_a_type    : INTEGER := BOOLEAN'pos(a_type = C_UNSIGNED OR a_type = C_PIN);
    CONSTANT true_c_a_width   : INTEGER := swap_inputs(a_width+true_c_a_type, b_width+b_type, 0);
    CONSTANT true_c_b_width   : INTEGER := swap_inputs(a_width+true_c_a_type, b_width+b_type, 1);
    CONSTANT fab_mult_num_pps : INTEGER := calc_num_pps(0, true_c_b_width, 0, true_c_a_width-18, 1, 0);

    -- add an extra cycle of latency if we are using a MULT18X18S, but not if we have a MULT18X18SIO in S3E
    CONSTANT m18_hybrid : INTEGER := BOOLEAN'pos((family = "virtex2" OR family = "spartan3"));
    
  BEGIN

    IF reg_a_b_inputs = 0 THEN
      latency := 0;
    ELSE
      latency := 1;
    END IF;

    -- Add latency due to adder tree
    IF (mult_type = PARALLEL OR mult_type = V2_PARALLEL) THEN
      IF num_pps > 1 AND pipeline /= 0 THEN
        latency := latency + log2d(num_pps-1)+1 + mult18s;
      ELSIF (mult_type = V2_PARALLEL AND pipeline /= 0) THEN  -- mult18x18s used when pipelined always
        latency := latency + mult18s;
      END IF;
    END IF;

    IF mult_type = V4_PARALLEL AND pipeline /= 0 THEN
      -- No adder tree, just the cascading adders in the DSP48 block
      latency := latency + num_pps + 1;
    ELSIF mult_type = V4_PARALLEL AND pipeline = 0 THEN
      latency := latency;
    END IF;

    -- added for the hybrid DSP48 model
    IF mult_type = HYBRID AND pipeline /= 0 THEN
      IF a_width+a_type <= 18 AND b_width+b_type <= 18 THEN
        -- single RTL DSP48
--        latency := latency + num_pps;   -- max latency is 3
        latency := latency + 1;
      ELSIF a_width+true_c_a_type = 19 AND b_width+b_type <= 18 THEN
        -- optimised 19xN multiplier, N <= 18
        latency := latency + 1 + m18_hybrid;
      ELSIF ((a_width+a_type <= 35 AND b_width+b_type <= 18) OR (b_width+b_type <= 35 AND a_width+a_type <= 18)) AND NOT(true_c_a_width = 19 AND true_c_b_width <= 18) THEN
        -- modified hybrid
        latency := latency + log2d(fab_mult_num_pps-1) + 1 + 2;
      ELSE
        -- standard hybrid design
        latency := latency + (log2d(fab_mult_num_pps-1)+1) + 1 + 3;  -- input regs + deepest fabric mult pipe stages + mult output regs + (addsub+c port)
      END IF;
    ELSIF mult_type = 6 AND pipeline = 0 THEN
      latency := latency;
    END IF;

    RETURN latency;

  END get_parm_v8_0_latency;

  ----------------------------------------------------------------------------
  -- The following functions are intended purely for the usage of the parm_v8_0
  -- core, not for the usage of other cores, and therefore do not have to
  -- follow the intelligent function naming convention
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- This function, formally of the parm_pack package reports the 'logarithm'
  -- (base 2) of an integer - nb the value it returns is constrained to the
  -- integer value.
  -- e.g. log(4) = 2, log(6) = 2, log(8) = 3, log(10) = 3
  ----------------------------------------------------------------------------

  FUNCTION log2d(x : INTEGER) RETURN INTEGER IS
    VARIABLE y            : INTEGER;
    VARIABLE two_to_the_y : INTEGER;
  BEGIN
    y            := 0;
    two_to_the_y := 1;

    WHILE (two_to_the_y < x) LOOP
      y            := y+1;
      two_to_the_y := two_to_the_y * 2;
    END LOOP;

    IF two_to_the_y > x THEN
      y := y - 1;
    END IF;

    RETURN y;
  END log2d;

  -- The purpose of the check_18 function, is to ascertain whether or not the
  -- final mult18x18 primitive can be used, without having to sign extend the
  -- ports A or B, if this the case, then the multiplier can be built (possibly)
  -- with fewer block multiplier primitives.

  FUNCTION check_18(has_a_signed, a_width, a_type : INTEGER) RETURN INTEGER IS
    VARIABLE case_18                      : BOOLEAN := false;
    VARIABLE a_w, b_w, a_t, b_t, t_w, t_t : INTEGER;
  BEGIN
    a_w := a_width;
    a_t := a_type;
    IF(has_a_signed = 1) THEN
      a_w := a_w + 1;
    END IF;
    IF(a_t = C_PIN) THEN
      a_t := C_SIGNED;
    END IF;

    -- check that the data on the a port is signed, and that the width, when
    -- divided by 17 leaves a remainder of 1 (e.g. a_w = 18, or 35, etc.)
    -- If that is the case, then case_18 will be 1, if the data on the b port
    -- is signed, and the width is not greater than the a port; or if the
    -- data on the b port is unsigned, then the width on the b port must be
    -- less than the a port width.

    case_18 := ((a_t = C_SIGNED AND a_w REM mult_in_unsigned = 1));

    IF (case_18) THEN
      RETURN 1;
    END IF;

    RETURN 0;

  END check_18;

  FUNCTION calc_num_pps(mult_type, a_width, a_type, b_width, b_type, has_a_signed : INTEGER) RETURN INTEGER IS
    CONSTANT a_ext_width : INTEGER := select_val_int(a_width, a_width+1, has_a_signed);
    VARIABLE a_prods     : INTEGER := 0;
    VARIABLE b_prods     : INTEGER := 0;
    CONSTANT a_count     : INTEGER := (a_ext_width+1)/2;
    CONSTANT b_count     : INTEGER := (b_width+1)/2;
  BEGIN
    IF(mult_type = V2_PARALLEL OR mult_type = V4_PARALLEL OR mult_type = HYBRID) THEN

      a_prods := select_val_int((a_width-1)/mult_in_unsigned + 1, (a_width-1)/mult_in + 1, check_18(has_a_signed, a_width, a_type));

      b_prods := select_val_int((b_width-1)/mult_in_unsigned + 1, (b_width-1)/mult_in + 1, check_18(0, b_width, b_type));

      RETURN a_prods * b_prods;
      
    ELSIF (mult_type = PARALLEL) THEN
      -- larger width is always used as the a input port
      -- width within the multiplier
      IF(a_ext_width <= b_width) THEN
        RETURN a_count;
      ELSE
        RETURN b_count;
      END IF;
    END IF;
    RETURN 0;
  END calc_num_pps;

  FUNCTION select_val_int(i0 : INTEGER; i1 : INTEGER; sel : INTEGER) RETURN INTEGER IS
  BEGIN
    IF sel = 1 THEN
      RETURN i1;
    ELSE
      RETURN i0;
    END IF;  -- sel
  END select_val_int;

  FUNCTION select_val(i0 : INTEGER; i1 : INTEGER; sel : BOOLEAN) RETURN INTEGER IS
  BEGIN
    IF sel THEN
      RETURN i1;
    ELSE
      RETURN i0;
    END IF;  -- sel
  END select_val;

  -- calculate if mult18x18s can be used
  FUNCTION calc_mult18s_usage(mult_type, has_aclr, has_sclr, has_ce, sync_enable : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (mult_type = V2_PARALLEL AND (has_aclr = 0 AND NOT (sync_enable = 1 AND has_sclr = 1 AND has_ce = 1))) THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END calc_mult18s_usage;

  -- these values are based on characterisation data from a V4 -10 device!!!
  FUNCTION use_hybrid (c_a_width, c_a_type, c_b_width, c_b_type, c_mult_type : INTEGER) RETURN INTEGER IS
    CONSTANT true_a_type  : INTEGER := BOOLEAN'pos(c_a_type = C_UNSIGNED OR c_a_type = C_PIN);
    CONSTANT true_a_width : INTEGER := c_a_width+true_a_type;
    CONSTANT true_b_width : INTEGER := c_b_width+c_b_type;
  BEGIN
    IF (true_a_width <= 22 AND true_b_width <= 22) OR (true_a_width <= 25 AND true_b_width <= 18) THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END use_hybrid;
  
END parm_v8_0_services;

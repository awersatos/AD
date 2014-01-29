-- Copyright(C) 2002 by Xilinx, Inc. All rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc., is distributed
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
--
-------------------------------------------------------------------------------
-- parm_v6_0 Intelligent Functions Package
-------------------------------------------------------------------------------
-- The purpose of this package, is to make
-- 'intelligent' functions available to VHDL
-- and XCC developers, that used to be available
-- to JAVA developers alone.
-------------------------------------------------------------------------------

library XilinxCoreLib;
use xilinxcorelib.prims_constants_v6_0.all;
use xilinxcorelib.mult_const_pkg_v6_0.all;

package parm_v6_0_services is

   -- See below for a description of each function

   function get_parm_v6_0_latency (c_mult_type, c_a_width, c_a_type, c_b_width,
                                   c_b_type, c_reg_a_b_inputs, c_pipeline,
                                   c_has_aclr, c_has_sclr, c_has_ce, c_sync_enable,
                                   c_has_a_signed, c_has_nd, c_has_q : integer) return integer;
   
   function log2d(x : integer) return integer;

   function check_18(has_a_signed, a_width, a_type, b_width, b_type : integer) return integer;

   function calc_num_pps(c_mult_type, c_a_width, c_a_type,
                         c_b_width, c_b_type, c_has_a_signed : integer) return integer;

   function select_val_int(i0 : integer; i1 : integer; sel : integer) return integer;

   function select_val(i0 : integer; i1 : integer; sel : boolean) return integer;

   function calc_mult18s_usage(c_mult_type, c_has_aclr, c_has_sclr, c_has_ce,
							   c_sync_enable : integer) return integer;

end parm_v6_0_services;

package body parm_v6_0_services is

    constant mult_in_unsigned : integer := 17;
    constant mult_in : integer := 18;

--    constant PARALLEL : integer := 0;
--    constant V2_PARALLEL : integer := 1;

-------------------------------------------------------------------------------
-- The purpose of the get_parm_v6_0_latency is to return an integer value,
-- which represents the number of clock cycles that the parallel multiplier
-- will take to produce a result from a given set of inputs.
-- All of the parameters being passed to this function are present in the
-- multiplier generic, and therefore should already be known to the ip developer
-------------------------------------------------------------------------------

   FUNCTION set_ce ( c_has_ce : INTEGER;
                  ignore_nd : BOOLEAN)
   RETURN INTEGER IS
BEGIN
   IF(c_has_ce = 1) THEN
      return 1;
   ELSE
      IF(ignore_nd) THEN
         RETURN 0;
      ELSE
         RETURN 1;
      END IF;
   END IF;
END set_ce;

   
   function get_parm_v6_0_latency (c_mult_type,
                                   c_a_width,
                                   c_a_type,
                                   c_b_width,
                                   c_b_type,
                                   c_reg_a_b_inputs,
                                   c_pipeline,
                                   c_has_aclr,
                                   c_has_sclr,
                                   c_has_ce,
                                   c_sync_enable,
                                   c_has_a_signed,
                                   c_has_nd,
                                   c_has_q : integer) return integer is
      variable latency : integer;
      constant num_pps : integer := calc_num_pps(c_mult_type, c_a_width, c_a_type,
                                                 c_b_width, c_b_type, c_has_a_signed);
	  constant ignore_nd : BOOLEAN :=
         c_has_nd=0 OR (c_has_nd/=0 AND c_reg_a_b_inputs=0 AND c_has_q=0
	  and
           (c_pipeline=0 OR num_pps=1));
	  constant true_ce : integer := set_ce(c_has_ce, ignore_nd);
	  constant mult18s : integer := calc_mult18s_usage(c_mult_type, c_has_aclr, c_has_sclr, true_ce, c_sync_enable);
      
   begin

      if c_reg_a_b_inputs = 0 then
         latency := 0;
      else
         latency := 1;
      end if;

      -- Add latency due to adder tree
      if num_pps > 1 and c_pipeline /= 0 then
         latency := latency + log2d(num_pps-1)+1 + mult18s;
      elsif (c_mult_type = V2_PARALLEL and c_pipeline /= 0) then	-- mult18x18s used when pipelined always
		 latency := latency + mult18s;
      end if;

      return latency;

   end get_parm_v6_0_latency;

   ----------------------------------------------------------------------------
   -- The following functions are intended purely for the usage of the parm_v6_0
   -- core, not for the usage of other cores, and therefore do not have to
   -- follow the intelligent function naming convention
   ----------------------------------------------------------------------------

   ----------------------------------------------------------------------------
   -- This function, formally of the parm_pack package reports the 'logarithm'
   -- (base 2) of an integer - nb the value it returns is constrained to the
   -- integer value.
   -- e.g. log(4) = 2, log(6) = 2, log(8) = 3, log(10) = 3
   ----------------------------------------------------------------------------

   function log2d(x : integer) return integer is
      variable y            : integer;
      variable two_to_the_y : integer;
   begin
      y            := 0;
      two_to_the_y := 1;

      while (two_to_the_y < x) loop
         y            := y+1;
         two_to_the_y := two_to_the_y * 2;
      end loop;

      if two_to_the_y > x then
         y := y - 1;
      end if;

      return y;
   end log2d;

   -- The purpose of the check_18 function, is to ascertain whether or not the
   -- final mult18x18 primitive can be used, without having to sign extend the
   -- ports A or B, if this the case, then the multiplier can be built (possibly)
   -- with fewer block multiplier primitives.

   function check_18(has_a_signed, a_width, a_type, b_width, b_type : integer)
      return integer is
      variable case_18                      : boolean := false;
      variable a_w, b_w, a_t, b_t, t_w, t_t : integer;
   begin
      a_w := a_width;
      b_w := b_width;
      a_t := a_type;
      b_t := b_type;
      if(has_a_signed = 1) then
         a_w := a_w + 1;
      end if;
      if(a_t = c_pin) then
         a_t := c_signed;
      end if;

      if (a_w < b_w) then
         t_w := a_w;
         a_w := b_w;
         b_w := t_w;

         t_t := a_t;
         a_t := b_t;
         b_t := t_t;
      end if;

      -- check that the data on the a port is signed, and that the width, when
      -- divided by 17 leaves a remainder of 1 (e.g. a_w = 18, or 35, etc.)
      -- If that is the case, then case_18 will be 1, if the data on the b port
      -- is signed, and the width is not greater than the a port; or if the
      -- data on the b port is unsigned, then the width on the b port must be
      -- less than the a port width.

      case_18 :=
         (
            (a_t = c_signed and a_w rem mult_in_unsigned = 1) and
            (
               (b_type = c_signed and b_w <= a_w) or
               (b_type = c_unsigned and b_w < a_w)
               )
            ) ;

      if(case_18) then
         return 1;
      end if;
      return 0;

   end check_18;
   

   function calc_num_pps(c_mult_type, c_a_width, c_a_type, c_b_width, c_b_type, c_has_a_signed : integer) return integer is
      constant a_ext_width : integer := select_val_int(c_a_width, c_a_width +1, c_has_a_signed);

      variable a_prods : integer := 0;
      variable b_prods : integer := 0;

      constant a_count : integer := (a_ext_width+1)/2;
      constant b_count : integer := (c_b_width+1)/2;
   begin
      if(c_mult_type = V2_PARALLEL) then

         a_prods := select_val_int(
            (c_a_width-1)/mult_in_unsigned + 1,
            (c_a_width-1)/mult_in + 1,
            check_18(c_has_a_signed, c_a_width, c_a_type, c_b_width, c_b_type));

         b_prods := select_val_int(
            (c_b_width-1)/mult_in_unsigned + 1,
            (c_b_width-1)/mult_in + 1,
            check_18(c_has_a_signed, c_a_width, c_a_type, c_b_width, c_b_type));

         return a_prods * b_prods;
         
      elsif ( c_mult_type = PARALLEL) then
         -- larger width is always used as the a input port
         -- width within the multiplier
         if(a_ext_width <= c_b_width) then
            return a_count;
         else
            return b_count;
         end if;
      end if;
      return 0;
   end calc_num_pps;

   function select_val_int(i0 : integer; i1 : integer; sel : integer) return integer is
   begin
      if sel = 1 then
         return i1;
      else
         return i0;
      end if;  -- sel
   end select_val_int;

   function select_val(i0 : integer; i1 : integer; sel : boolean) return integer is
   begin
      if sel then
         return i1;
      else
         return i0;
      end if;  -- sel
   end select_val;
   
   -- calculate if mult18x18s can be used
   function calc_mult18s_usage(c_mult_type, c_has_aclr, c_has_sclr, c_has_ce,
							   c_sync_enable : integer) return integer is
   begin
      if (c_mult_type = V2_PARALLEL and (c_has_aclr = 0 and not (c_sync_enable = 1 and c_has_sclr = 1 and c_has_ce = 1))) then
      	 return 1;
	  else
		 return 0;
	  end if;
   end calc_mult18s_usage;

end parm_v6_0_services;

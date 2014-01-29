-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc., is distributed
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
--
-------------------------------------------------------------------------------
-- ccm_v7_0 Intelligent Functions Package
-------------------------------------------------------------------------------
-- The purpose of this package, is to make
-- 'intelligent' functions available to VHDL
-- and XCC developers, that used to be available
-- to JAVA developers alone.
-------------------------------------------------------------------------------

library XilinxCoreLib;
use XilinxCoreLib.parm_v7_0_services.all;
use XilinxCoreLib.prims_constants_v7_0.all;
use XilinxCoreLib.mult_const_pkg_v7_0.all;

package ccm_v7_0_services is

   -- See below for a description of each function

-------------------------------------------------------------------------------
-- This function is intended for external use
-------------------------------------------------------------------------------

   function get_ccm_v7_0_latency(c_a_width        : integer;
                                 c_has_a_signed   : integer;
                                 c_a_type         : integer;
                                 c_reg_a_b_inputs : integer;
                                 c_has_swapb      : integer;
                                 c_mem_type       : integer;
                                 bram_addr_width  : integer;
                                 c_pipeline       : integer;
                                 c_b_constant     : integer;
                                 c_b_type         : integer;
                                 c_b_value        : string;
                                 c_b_width        : integer) return integer;
-------------------------------------------------------------------------------
-- The following functions are intended for ccm internal use only
-------------------------------------------------------------------------------   

   function calc_latency_internal(c_a_width        : integer;
                                  c_has_a_signed   : integer;
                                  c_a_type         : integer;
                                  c_reg_a_b_inputs : integer;
                                  c_has_swapb      : integer;
                                  c_mem_type       : integer;
                                  bram_addr_width  : integer;
                                  c_pipeline       : integer;
                                  c_b_constant     : integer;
                                  c_b_type         : integer;
                                  c_b_value        : string;
                                  actual_b_width   : integer) return integer;

   function calc_ccm_op_latency(c_a_width        : integer;
                                c_has_a_signed   : integer;
                                c_a_type         : integer;
                                c_reg_a_b_inputs : integer;
                                c_has_swapb      : integer;
                                c_mem_type       : integer;
                                bram_addr_width  : integer;
                                c_pipeline       : integer;
                                c_b_constant     : integer;
                                c_b_type         : integer;
                                c_b_value        : string;
                                actual_b_width   : integer) return integer;

   function calc_mem_latency(c_has_swapb : integer;
                             c_mem_type  : integer;
                             c_pipeline  : integer;
                             num_adders  : integer) return integer;

   function calc_reqd_b_value(b_value      : string;
                              b_width      : integer;
                              b_type       : integer;
                              reqd_b_width : integer) return string;

   function bitstorep_string(a_value : string;
                             a_type  : integer) return natural;

   function calc_shift_bits(b_value    : string;
                            b_constant : integer) return integer;

   function get_rom_addr_width(mem_type, bram_addr_width : integer) return integer;

   function calc_a_input_width(operand_width, c_has_a_signed, rom_addr_width, c_b_constant : integer) return integer;

   function calc_num_pps(a_width, rom_addr_width : integer) return integer;


end ccm_v7_0_services;

package body ccm_v7_0_services is

--   constant new_line : string(1 to 1) := (1 => lf);  -- For assertion reports
--   constant debug    : boolean        := false;

-------------------------------------------------------------------------------
-- Inputs:
-- c_a_width : integer which denotes width of a port
-- c_has_a_signed : integer which denotes the presence of the pin which
--    controls signed/unsigned on the a port.
-- c_reg_a_b_inputs : integer which denotes the usage of registers on the A and
--    B ports
-- c_has_swapb : integer which denotes the presence of the SWAP_B port
-- c_mem_type : integer which denotes the type of memory used.
--   0 : Distributed Memory
--   1 : Block Memory
-- bram_addr_width : Block RAM address width (8 bits in Virtex, 9 bits in
--    Virtex II and it's derivatives)
-- c_pipeline : integer which denotes whether ccm is pipelined.
--   0 : No pipelining, 1 : Pipelined.
-- c_b_constant : Integer which is used to denote a ccm, or rccm
-- c_b_type : Integer which denotes Signed (0), or unsigned (1)
-- c_b_value : String which represents the b constant
-- c_b_width : Integer which denotes the width of the b port.
-------------------------------------------------------------------------------

   function get_ccm_v7_0_latency(c_a_width        : integer;
                                 c_has_a_signed   : integer;
                                 c_a_type         : integer;
                                 c_reg_a_b_inputs : integer;
                                 c_has_swapb      : integer;
                                 c_mem_type       : integer;
                                 bram_addr_width  : integer;
                                 c_pipeline       : integer;
                                 c_b_constant     : integer;
                                 c_b_type         : integer;
                                 c_b_value        : string;
                                 c_b_width        : integer) return integer is

      variable latency : integer;

      -- Don't use c_b_width parameter if b is a fixed value; just use minimum
      -- number of bits required
      constant reqd_b_width : integer := select_val_int(c_b_width, bitstorep_string(c_b_value, c_b_type), c_b_constant);

      constant reqd_b_value : string(1 to reqd_b_width) := calc_reqd_b_value(c_b_value, c_b_width, c_b_type, reqd_b_width);

      -- IF b is a power of 2 then don't multiply by full b value; just shift
      -- final result
      constant shift_bits     : integer := calc_shift_bits(reqd_b_value, c_b_constant);
      constant actual_b_width : integer := reqd_b_width - shift_bits;

      constant actual_b_value : string(1 to actual_b_width) := reqd_b_value(1 to actual_b_width);

   begin
      latency := calc_latency_internal(c_a_width, c_has_a_signed, c_a_type, c_reg_a_b_inputs,
                                       c_has_swapb, c_mem_type, bram_addr_width, c_pipeline,
                                       c_b_constant, c_b_type, actual_b_value, actual_b_width);
      return latency;
   end get_ccm_v7_0_latency;
-------------------------------------------------------------------------------
-- Internal functions, to be used by the ccm core alone.
-------------------------------------------------------------------------------   

   function calc_latency_internal(c_a_width        : integer;
                                  c_has_a_signed   : integer;
                                  c_a_type         : integer;
                                  c_reg_a_b_inputs : integer;
                                  c_has_swapb      : integer;
                                  c_mem_type       : integer;
                                  bram_addr_width  : integer;
                                  c_pipeline       : integer;
                                  c_b_constant     : integer;
                                  c_b_type         : integer;
                                  c_b_value        : string;
                                  actual_b_width   : integer) return integer is

      constant a_is_signed : boolean := c_a_type = c_signed or c_has_a_signed = 1;

      variable latency : integer;

      
   begin
      latency := 0;

      -- Account for registers in Load Engine
      if c_b_constant = 0 then
         if c_mem_type /= c_distributed then
            latency := latency + 1;
         end if;  -- c_mem_type

         if a_is_signed and c_pipeline /= 0 then
            latency := latency + 1;
         end if;  -- c_pipeline
      end if;  -- c_b_constant

      -- Add latency in ccm_operation
      latency := latency + calc_ccm_op_latency(c_a_width, c_has_a_signed, c_a_type, c_reg_a_b_inputs,
                                               c_has_swapb, c_mem_type, bram_addr_width, c_pipeline,
                                               c_b_constant, c_b_type, c_b_value, actual_b_width);

      
      return latency;

      
   end calc_latency_internal;

   function calc_ccm_op_latency(c_a_width        : integer;
                                c_has_a_signed   : integer;
                                c_a_type         : integer;
                                c_reg_a_b_inputs : integer;
                                c_has_swapb      : integer;
                                c_mem_type       : integer;
                                bram_addr_width  : integer;
                                c_pipeline       : integer;
                                c_b_constant     : integer;
                                c_b_type         : integer;
                                c_b_value        : string;
                                actual_b_width   : integer) return integer is

      constant rom_addr_width : integer := get_rom_addr_width(c_mem_type, bram_addr_width);
      
      constant a_input_width : integer := calc_a_input_width(c_a_width,
                                                             c_has_a_signed, rom_addr_width, c_b_constant);

      constant b_is_0 : boolean := c_b_constant /= 0 and actual_b_width = 1 and
                                   c_b_value(c_b_value'high) = '0';

      constant b_is_1 : boolean := c_b_constant /= 0 and c_b_type = c_unsigned and
                                   actual_b_width = 1 and c_b_value(c_b_value'high) = '1';

      constant number_of_pps : integer :=
         calc_num_pps(a_input_width, rom_addr_width);
      
      constant need_addsub : boolean :=
         c_b_constant = 0 and (c_a_type = c_signed or c_has_a_signed = 1);

      -- Single PP but need an addsub to negate result
      constant need_0_minus_pp : boolean := need_addsub and number_of_pps <= 1;

      constant num_adders : integer := select_val(number_of_pps-1, 1, need_0_minus_pp);

      variable latency : integer;
   begin
      if b_is_0 then
         return 0;
      else
         if c_reg_a_b_inputs = 0 then
            latency := 0;
         else
            latency := 1;
         end if;

         if not(b_is_1) then
            
            latency := latency +
                       calc_mem_latency(c_has_swapb, c_mem_type, c_pipeline, num_adders);

            -- Add latency due to adder tree
            if num_adders > 0 and c_pipeline /= 0 then
               latency := latency + log2d(num_adders);
            end if;  -- num_adders>0 ...
            
         end if;  -- NOT(b_is_1)

         return latency;
      end if;  -- b_is_0
   end calc_ccm_op_latency;

   function calc_mem_latency(c_has_swapb : integer;
                             c_mem_type  : integer;
                             c_pipeline  : integer;
                             num_adders  : integer) return integer is
      variable latency : integer;
   begin
      latency := 0;

      -- Add 1 for RAM output register. Block mem is always registered.
      -- Don't add 1 unless num_adders>0 because we are
      -- calculating 'o' latency which must be 1 less than q latency
      if (num_adders > 0 or c_has_swapb /= 0) and
         (c_pipeline /= 0 or c_mem_type /= c_distributed) then
         latency := latency + 1;
      end if;

      if num_adders > 0 then
         -- Mux is added to RAM output if c_has_swapb
         if c_has_swapb /= 0 and c_pipeline /= 0 then
            latency := latency + 1;
         end if;
         
      end if;  -- num_adders > 0

      return latency;
   end calc_mem_latency;

   function calc_reqd_b_value(b_value      : string;
                              b_width      : integer;
                              b_type       : integer;
                              reqd_b_width : integer) return string is

      constant b_lsb        : integer := b_value'high;
      variable b_bit        : integer;
      variable reqd_b_value : string(1 to reqd_b_width);
   begin
      
      for bit in 1 to reqd_b_width loop
         b_bit := bit + b_lsb - reqd_b_width;
         if b_bit > 0 then
            reqd_b_value(bit) := b_value(b_bit);
         else
            if b_type = c_signed then
               reqd_b_value(bit) := b_value(1);
            else
               reqd_b_value(bit) := '0';
            end if;  -- b_type
         end if;  -- b_bit
      end loop;

      return reqd_b_value;
      
   end calc_reqd_b_value;

   function bitstorep_string(a_value : string;
                             a_type  : integer) return natural is
      variable return_value : integer;
   begin
      return_value := a_value'length;

      --ASSERT FALSE
      --  REPORT "bitstorep_string function: a_value = " & a_value & new_line &
      --         " a_type = " & int_2_string(a_type) & new_line &
      --         " a_value'LENGTH = " & int_2_string(a_value'LENGTH) & new_line &
      --         " a_value'LOW = " & int_2_string(a_value'LOW) & new_line &
      --         " a_value'HIGH = " & int_2_string(a_value'HIGH) & new_line &
      --         new_line
      --  SEVERITY NOTE;

      if a_type = c_unsigned then

         -- a_value represents an unsigned number
         --    FOR i IN a_value'RANGE LOOP -- Doesn't work with XCC
         for i in a_value'low to a_value'high loop
            if a_value(i) = '1' then
               exit;                    -- EXIT when the msb is found
            elsif a_value(i) = '0' then
               return_value := return_value - 1;
            else
--                assert false
--                   report "ERROR: non 0 or 1 character passed to bitstorep_string function." &
--                   new_line & " STRING passed in was: " & a_value
--                   severity failure;
               null;
            end if;
         end loop;
         
      else

         -- a_value represents a signed number
         -- Look for ms '1' followed by a '0'
         -- FOR i IN a_value'RANGE LOOP -- Doesn't work with XCC
         for i in a_value'low to a_value'high loop
            if a_value(i) = '1' then
               
               if i < a_value'high then
                  if a_value(i+1) = '0' then
                     exit;              -- EXIT when the msb is found
                     else
                        return_value := return_value - 1;
                  end if;
               else
                  exit;                 -- EXIT when end of STRING reached
               end if;
               
            elsif a_value(i) = '0' then
               return_value := return_value - 1;
            else
--               assert false
--                   report "ERROR: non 0 or 1 character passed to bitstorep_string function." &
--                   new_line & " STRING passed in was: " & a_value
--                   severity failure;
               null;                  
            end if;
         end loop;
         
      end if;

      if return_value <= 0 then
         return 1;
      else
         return return_value;
      end if;

   end bitstorep_string;

   function calc_shift_bits(b_value    : string;
                            b_constant : integer) return integer is
      variable bit        : integer;
      variable shift_bits : integer;
   begin
      shift_bits := 0;

      if b_constant /= 0 then
         bit := b_value'high;

         while (bit >= b_value'low) loop
            if b_value(bit) = '0' then
               shift_bits := shift_bits + 1;
            else
               exit;
            end if;
            bit := bit - 1;
         end loop;
         
      end if;

      if shift_bits >= b_value'high then
         shift_bits := 0;               -- All zeroes value
      end if;

--       assert not(debug)
--          report "calc_shift_bits debug" & new_line &
--          "          shift_bits = " & int_2_string(shift_bits) & new_line
--          severity note;

      return shift_bits;
      
   end calc_shift_bits;

   function get_rom_addr_width(mem_type, bram_addr_width : integer) return integer is
   begin
      if mem_type = c_distributed then
         return 4;
      else
--          assert (bram_addr_width = 8 or bram_addr_width = 9)
--             report "ERROR: CCM - bram_addr_width must be set to 8 or 9." & new_line
--             severity error;
         
         if bram_addr_width = 9 then
            return 9;
         else
            return 8;
         end if;  -- bram_addr_width
         
      end if;
   end get_rom_addr_width;

   function calc_a_input_width(operand_width, c_has_a_signed, rom_addr_width,
                               c_b_constant : integer) return integer is
      variable effective_op_width : integer;
   begin
      if c_has_a_signed = 0 or c_b_constant = 0 then
         effective_op_width := operand_width;
      else
         -- Allow extra input for 'a_signed'
         effective_op_width := operand_width + 1;
      end if;


      if (effective_op_width mod rom_addr_width = 0) then
         return effective_op_width;
      else
         return effective_op_width + rom_addr_width -
            (effective_op_width mod rom_addr_width);
      end if;
   end calc_a_input_width;

   function calc_num_pps(a_width, rom_addr_width : integer) return integer is
   begin
      if (a_width mod rom_addr_width /= 0) then
         return (a_width / rom_addr_width) + 1;
      else
         return (a_width / rom_addr_width);
      end if;
   end calc_num_pps;

end ccm_v7_0_services;

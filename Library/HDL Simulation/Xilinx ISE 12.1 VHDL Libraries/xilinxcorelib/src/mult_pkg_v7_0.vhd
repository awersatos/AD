-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc., is distributed
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
--
library ieee;
use ieee.std_logic_1164.all;

library std;
use std.textio.all;

library xilinxcorelib;
use xilinxcorelib.prims_constants_v7_0.all;
--use xilinxcorelib.mult_const_pkg_behav_v7_0.all;
use XilinxCoreLib.mult_const_pkg_v7_0.all;

use XilinxCoreLib.mult_gen_v7_0_services.all;

package mult_pkg_v7_0 is

   function eval( condition : boolean )
      return integer;
   
   function anyX(vect : std_logic_vector)
      return boolean;
   
   function rat( value : std_logic )
      return std_logic;

   function all0(a : std_logic_vector)
      return boolean;

   function hex_to_std_logic_vector(hexstring : string)
      return std_logic_vector;

   function calc_latency(c_a_width        : integer;
                         c_b_width        : integer;
                         c_b_type         : integer;
                         c_has_a_signed   : integer;
                         c_reg_a_b_inputs : integer;
                         c_mem_type       : integer;
                         c_pipeline       : integer;
                         c_mult_type      : integer;
                         c_has_loadb      : integer;
                         c_baat           : integer;
                         c_b_value        : string;
                         c_a_type         : integer;
                         c_has_swapb      : integer;
                         c_sqm_type       : integer;
                         c_has_aclr       : integer;
                         c_has_sclr       : integer;
                         c_has_ce         : integer;
                         c_sync_enable    : integer;
                         c_has_nd         : integer;
                         c_has_q          : integer;
                         bram_addr_width  : integer
                         ) return integer ;

   function calc_num_adders(c_a_width        : integer;
                            c_b_width        : integer;
                            c_b_type         : integer;
                            c_has_a_signed   : integer;
                            c_reg_a_b_inputs : integer;
                            c_mem_type       : integer;
                            c_pipeline       : integer;
                            c_mult_type      : integer;
                            c_has_loadb      : integer;
                            c_baat           : integer;
                            c_b_value        : string;
                            c_a_type         : integer;
                            c_has_swapb      : integer;
                            c_sqm_type       : integer;
                            bram_addr_width  : integer
                            ) return integer ;

   function find_no_of_cycles(a_input_width, c_baat, c_mult_type : integer)  --c_sqm_type, c_latency, c_pipeline : integer)
      return integer;

   function "+"(a,b : std_logic_vector)
      return std_logic_vector;
   
   function two_comp(vect : std_logic_vector)
      return std_logic_vector;

   function add (a, b : std_logic_vector; a_sign, b_sign : integer)
      return std_logic_vector;

   function add2 (a, b : std_logic_vector; a_sign, b_sign : integer)
      return std_logic_vector;

   function calc_a_input_width(operand_width, c_has_a_signed,
                               rom_addr_width, baat, c_has_loadb : integer) return integer;

   function calc_num_pps(a_width, rom_addr_width : integer) return integer;

   function get_rom_addr_width(mem_type : integer) return integer;

   function log2d(x : integer) return integer;

   function str_to_slv(bitsin : string; nbits : integer)
      return std_logic_vector;
   
   function str_to_slv2(bitsin : string; nbits : integer)
      return std_logic_vector;

   function str_to_bv(bitsin : string; nbits : integer) return bit_vector;

   function extend( vector : std_logic_vector; bits : integer; sign : integer )
      return std_logic_vector;

   function find_ccm_b_width(bitsin : std_logic_vector; b_width, mult_type, has_load : integer)
      return integer;

   function bitstorep_bv(a_value    : bit_vector;
                         a_type     : integer;
                         a_positive : boolean) return natural;

   function check_18(has_a_signed, a_width, a_type, b_width, b_type : integer)
      return integer;

   function parm_calc_num_pps(
      c_mult_type    : integer;
      c_a_width      : integer;
      c_a_type       : integer;
      c_b_width      : integer;
      c_b_type       : integer;
      c_has_a_signed : integer
      ) return integer;


   function select_val(i0 : integer; i1 : integer; sel : boolean)
      return integer;

   function get_rom_addr_width(mem_type        : integer;
                               bram_addr_width : integer) return integer;

   function bitstorep_string(a_value : string;
                             a_type  : integer) return natural;

   function calc_shift_bits(b_value    : string;
                            b_constant : integer;
                            b_type     : integer) return integer;

   function calc_reqd_b_value(b_value      : string;
                              b_width      : integer;
                              b_type       : integer;
                              reqd_b_width : integer) return string;

end mult_pkg_v7_0;

package body mult_pkg_v7_0 is

   function calc_shift_bits(b_value    : string;
                            b_constant : integer;
                            b_type     : integer) return integer is
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

      if (b_type = c_signed) then
         shift_bits := 0;
      end if;

      return shift_bits;
      
   end calc_shift_bits;

   function all0(a : std_logic_vector)
      return boolean is
      variable z : std_logic_vector(a'length-1 downto 0) := (others => '0');
   begin
      return (a = z);
   end all0;

   function str_to_bv(bitsin : string; nbits : integer) return bit_vector is
      variable ret     : bit_vector(nbits-1 downto 0);
      variable bit_num : integer;
   begin
      ret := (others => '0');

      if (bitsin'length = 0) then       -- Make all '0's
         return ret;
      end if;

      bit_num := 0;

      --  FOR i IN bitsin'REVERSE_RANGE LOOP -- doesn't work with XCC
      for i in bitsin'high downto bitsin'low loop
         
         if bitsin(i) = '1' then
            ret(bit_num) := '1';
         elsif bitsin(i) = '0' then
            ret(bit_num) := '0';
         else
         end if;

         bit_num := bit_num + 1;

         if bit_num >= nbits then
            exit;  -- Ignore ms characters in STRING if STRING is longer than BV
         end if;
      end loop;

      return ret;
      
   end str_to_bv;

   function bitstorep_bv(a_value    : bit_vector;
                         a_type     : integer;
                         a_positive : boolean) return natural is
      variable return_value : integer;
   begin
      return_value := a_value'length;

      if a_type = c_unsigned then

         -- a_value represents an unsigned number
         for i in a_value'high downto a_value'low loop
            if a_value(i) = '1' then
               exit;                    -- EXIT when the msb is found
            elsif a_value(i) = '0' then
               return_value := return_value - 1;
            end if;
         end loop;
         
      else

         -- a_value represents a signed number
         
         if a_positive then
            -- Look for ms '1' then add 1 for a leading 0
            for i in a_value'high downto a_value'low loop
               if a_value(i) = '1' then
                  return_value := return_value + 1;
                  exit;
               else
                  return_value := return_value - 1;
               end if;
            end loop;
         else
            -- Look for ms '1' followed by a '0'
            for i in a_value'high downto a_value'low loop
               if a_value(i) = '1' then
                  
                  if i > a_value'low then
                     if a_value(i-1) = '0' then
                        exit;           -- EXIT when the msb is found
                        else
                           return_value := return_value - 1;
                     end if;
                  else
                     exit;              -- EXIT when end of STRING reached
                  end if;
                  
               else
                  return_value := return_value - 1;
               end if;
            end loop;
            
         end if;  -- a_positive
         
      end if;

      --IF a_type=c_unsigned AND return_value <= 0 THEN
      if return_value <= 0 then
         return 1;
      elsif a_type /= c_unsigned and return_value <= 2 then
         return 2;  -- always need at least 2 bits to represent signed numbers
      else
         return return_value;
      end if;

   end bitstorep_bv;

-- Converts hex string to a standard logic vector.
   function hex_to_std_logic_vector(hexstring : string)
      return std_logic_vector is
      constant length : integer := hexstring'length;
      variable bitval : std_logic_vector((length*4)-1 downto 0);
      variable posn   : integer := bitval'left;
      variable ch     : character;
   begin
      for i in 1 to length loop
         ch := hexstring(i);
         case ch is
            when '0'       => bitval(posn downto posn-3) := "0000";
            when '1'       => bitval(posn downto posn-3) := "0001";
            when '2'       => bitval(posn downto posn-3) := "0010";
            when '3'       => bitval(posn downto posn-3) := "0011";
            when '4'       => bitval(posn downto posn-3) := "0100";
            when '5'       => bitval(posn downto posn-3) := "0101";
            when '6'       => bitval(posn downto posn-3) := "0110";
            when '7'       => bitval(posn downto posn-3) := "0111";
            when '8'       => bitval(posn downto posn-3) := "1000";
            when '9'       => bitval(posn downto posn-3) := "1001";
            when 'A' | 'a' => bitval(posn downto posn-3) := "1010";
            when 'B' | 'b' => bitval(posn downto posn-3) := "1011";
            when 'C' | 'c' => bitval(posn downto posn-3) := "1100";
            when 'D' | 'd' => bitval(posn downto posn-3) := "1101";
            when 'E' | 'e' => bitval(posn downto posn-3) := "1110";
            when 'F' | 'f' => bitval(posn downto posn-3) := "1111";
            when others    => assert false
                              report "Invalid hex value in MIF file" severity error;
                           bitval(posn downto posn-3) := "XXXX";
         end case;
         posn := posn - 4;
      end loop;
      return bitval;
   end hex_to_std_logic_vector;

   function select_val(i0 : integer; i1 : integer; sel : boolean) return integer is
   begin
      if sel then
         return i1;
      else
         return i0;
      end if;  -- sel
   end select_val;
   
   function calc_num_adders(c_a_width        : integer;
                            c_b_width        : integer;
                            c_b_type         : integer;
                            c_has_a_signed   : integer;
                            c_reg_a_b_inputs : integer;
                            c_mem_type       : integer;
                            c_pipeline       : integer;
                            c_mult_type      : integer;
                            c_has_loadb      : integer;
                            c_baat           : integer;
                            c_b_value        : string;
                            c_a_type         : integer;
                            c_has_swapb      : integer;
                            c_sqm_type       : integer;
                            bram_addr_width  : integer
                            ) return integer is

      constant real_a_width   : integer := (c_a_width-1) - ((c_a_width-1)*c_sqm_type) + 1;
      constant rom_addr_width : integer := get_rom_addr_width(c_mem_type, bram_addr_width);

      constant a_input_width : integer :=
         calc_a_input_width(real_a_width, c_has_a_signed, rom_addr_width, c_baat, c_has_loadb);

      constant b_is_0 : boolean := c_b_width = 1 and c_b_value(c_b_value'high) = '0';

      constant b_is_1 : boolean := c_b_type = c_unsigned and
                                   c_b_width = 1 and c_b_value(c_b_value'high) = '1';

      constant need_addsub : boolean := c_has_loadb = 1 and (c_a_type /= c_unsigned or c_has_a_signed /= 0);

      --CONSTANT a_is_signed : BOOLEAN := c_a_type/=c_unsigned OR c_has_a_signed/=0;

      variable num_adders      : integer;
      variable latency         : integer := 0;
      variable need_0_minus_pp : boolean;
      variable num_pps         : integer;

   begin
      
      num_pps         := calc_num_pps(a_input_width, rom_addr_width);  ---1;
      need_0_minus_pp := need_addsub and num_pps <= 1;
      num_adders      := select_val(num_pps-1, 1, need_0_minus_pp);
      return num_adders;
   end calc_num_adders;

   function calc_latency(c_a_width        : integer;
                         c_b_width        : integer;
                         c_b_type         : integer;
                         c_has_a_signed   : integer;
                         c_reg_a_b_inputs : integer;
                         c_mem_type       : integer;
                         c_pipeline       : integer;
                         c_mult_type      : integer;
                         c_has_loadb      : integer;
                         c_baat           : integer;
                         c_b_value        : string;
                         c_a_type         : integer;
                         c_has_swapb      : integer;
                         c_sqm_type       : integer;
                         c_has_aclr       : integer;
                         c_has_sclr       : integer;
                         c_has_ce         : integer;
                         c_sync_enable    : integer;
                         c_has_nd         : integer;
                         c_has_q          : integer;
                         bram_addr_width  : integer
                         ) return integer is

      constant real_a_width   : integer := (c_a_width-1) - ((c_a_width-1)*c_sqm_type) + 1;
      constant rom_addr_width : integer := get_rom_addr_width(c_mem_type, bram_addr_width);

      constant a_input_width : integer :=
         calc_a_input_width(real_a_width, c_has_a_signed, rom_addr_width, c_baat, c_has_loadb);

      constant b_is_0 : boolean := c_b_width = 1 and c_b_value(c_b_value'high) = '0';

      constant b_is_1 : boolean := c_b_type = c_unsigned and
                                   c_b_width = 1 and c_b_value(c_b_value'high) = '1';

      constant need_addsub : boolean := c_has_loadb = 1 and (c_a_type /= c_unsigned or c_has_a_signed /= 0);

      --CONSTANT a_is_signed : BOOLEAN := c_a_type/=c_unsigned OR c_has_a_signed/=0;

      variable num_adders      : integer;
      variable latency         : integer := 0;
      variable need_0_minus_pp : boolean;
      variable num_pps         : integer;

    begin
      -- If the multiplier is a parallel LUT based, or MULT_18x18 based
      -- multiplier then the latency is...
      
--       if (c_mult_type = 0) or (c_mult_type = 1) then
--          if (c_baat = c_a_width) then
--             num_adders := parm_calc_num_pps(c_mult_type, c_a_width, c_a_type,
--                                             c_b_width, c_b_type, c_has_a_signed);
--          elsif (c_has_a_signed = 1) or (c_a_type = 0) then
--             num_adders := parm_calc_num_pps(c_mult_type, c_baat, c_a_type,
--                                             c_b_width, c_b_type, 1);
--          else
--             num_adders := parm_calc_num_pps(c_mult_type, c_baat, c_a_type,
--                                             c_b_width, c_b_type, 0);
--          end if;
--       else
--          -- Then the multiplier must be a ccm, or sequential multiplier
--          num_pps         := calc_num_pps(a_input_width, rom_addr_width);  ---1;
--          need_0_minus_pp := need_addsub and num_pps <= 1;
--          num_adders      := select_val(num_pps-1, 1, need_0_minus_pp);
--          --num_adders := calc_num_pps(a_input_width, rom_addr_width) - 1;
--       end if;

--       --if (c_baat < c_a_width) then
--       --    latency := 1 ;
--       --end if ;

--       if ((c_baat < c_a_width) and not(c_sqm_type = 1 and c_mult_type > 1)) then  -- and c_pipeline = 0)) then --or (c_baat < c_sqm_type) then
--          latency := 1;                  --latency + 1 ;
--       end if;

--       if (c_baat < c_a_width and c_pipeline = 1) then
--          latency := latency + 1;
--       end if;

--       --if (c_pipeline = 0 and c_mem_type /= c_distributed and (c_baat < c_a_width or c_baat < c_sqm_type) and num_adders = 1) then
--       --        latency := latency + 1 ;
--       --end if ;

--       if (c_mult_type > 1) then
--          if (b_is_0 and c_has_loadb = 0 and c_baat = c_a_width) then
--             latency := 0;
--          elsif (b_is_0 and c_has_loadb = 0 and c_baat < c_a_width) then
--             latency := latency;
--          else
--             if (c_pipeline = 0 and c_mem_type /= c_distributed and c_mult_type > 1 and (c_baat < c_a_width) and num_pps = 1) then
--                latency := latency + 1;
--             end if;
--             if (c_has_loadb = 1 and c_mem_type /= c_distributed) then
--                latency := latency + 1;
--             end if;
--             if (c_has_loadb = 1 and (c_a_type = c_signed or c_has_a_signed = 1) and c_pipeline = 1) then
--                latency := latency + 1;
--             end if;

--             if (not(b_is_1) or c_has_loadb = 1) then
--                if (num_adders > 0 or c_has_swapb /= 0) and
--                   (c_pipeline /= 0 or c_mem_type /= c_distributed) then
--                   latency := latency + 1;
--                end if;

--                if num_adders > 0 then
--                   -- Mux is added to RAM output if c_has_swapb
--                   if c_has_swapb /= 0 and c_pipeline /= 0 then
--                      latency := latency + 1;
--                   end if;

--                   -- Add latency due to adder tree
--                   if c_pipeline /= 0 then
--                      latency := latency + log2d(num_adders);
--                   end if;
--                end if;
--             end if;
--          end if;

--       elsif (c_mult_type = 0) or (c_mult_type = 1) then
--          -- Add latency due to adder tree
--          if num_adders > 1 and c_pipeline /= 0 then
--             latency := latency + log2d(num_adders-1) +1;  --was +1
--          end if;
--       end if;
--       if (latency < 0) then  --or (c_b_width = 1) then --or (c_mult_type > 1 and (b_is_0 or b_is_1)) then
--          return 0;
--       else
--          return latency;
--       end if;

        return get_mult_gen_v7_0_registers(c_a_width, c_b_width, c_b_type, c_has_a_signed, c_reg_a_b_inputs, c_mem_type, c_pipeline, c_mult_type, c_has_loadb, c_baat, c_b_value, c_a_type, c_has_swapb, c_sqm_type, c_has_aclr, c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, bram_addr_width) - c_reg_a_b_inputs;
      
    end calc_latency;

   function find_no_of_cycles(a_input_width, c_baat, c_mult_type : integer)  --c_sqm_type, c_latency, c_pipeline : integer)

      return integer is
      variable l : integer := 1;
   begin
      if c_baat < a_input_width then
         l := l + (a_input_width / c_baat);
         if (a_input_width rem c_baat) /= 0 then
            l := l + 1;
         end if;
      else
         l := 4;
      end if;
      --if (c_sqm_type = 1 and (c_pipeline = 0 or c_latency = 0)) then
      --        l := l - 1 ;
      --end if ;
      return l;
   end find_no_of_cycles;

-- Addition function that correctly handles when inputs are 'X'.
   function add (a, b : std_logic_vector; a_sign, b_sign : integer)
      return std_logic_vector is
      constant a_width   : integer := a'length;
      constant b_width   : integer := b'length;
      constant max_width : integer := eval(a_width >= b_width)*a_width
                                     + eval(b_width > a_width)*b_width;
      variable sa     : std_logic_vector(max_width-1 downto 0);  --:=
      --extend(a, max_width+1, a_sign);
      variable sb     : std_logic_vector(max_width-1 downto 0);  --:=
      --extend(b, max_width+1, b_sign);
      variable retval : std_logic_vector(max_width-1 downto 0);
      variable carry  : std_logic := '0';
   begin  -- plus
      --if (anyX(sa) or anyX(sb)) then
      --  retval := (others => 'X');
      --if (all0(sa)) then
      --  retval := sb;
      --elsif (all0(sb)) then
      --  retval := sa;
      --else
      if (b_sign = 0) then
         sa := extend(a, max_width, 0);
      else
         sa := extend(a, max_width, a_sign);
      end if;
      sb := extend(b, max_width, b_sign);

      for i in 0 to max_width-1 loop
         if (sa(i) = 'X' or sb(i) = 'X') then
            retval(i) := 'X';
            carry     := 'X';
         elsif (carry = 'X') then
            retval(i) := 'X';
            carry     := '0';
         else
            retval(i) := sa(i) xor sb(i) xor carry;
            carry     := (sa(i) and sb(i)) or
                     (sa(i) and carry) or
                     (sb(i) and carry);
         end if;
      end loop;  -- i
      --end if;    
      return retval;
   end add;

   function add2 (a, b : std_logic_vector; a_sign, b_sign : integer)
      return std_logic_vector is
      constant a_width   : integer := a'length;
      constant b_width   : integer := b'length;
      constant max_width : integer := eval(a_width >= b_width)*a_width
                                     + eval(b_width > a_width)*b_width;
      variable sa     : std_logic_vector(max_width downto 0);  --:=
      --extend(a, max_width+1, a_sign);
      variable sb     : std_logic_vector(max_width downto 0);  --:=
      --extend(b, max_width+1, b_sign);
      variable retval : std_logic_vector(max_width downto 0);
      variable carry  : std_logic := '0';
   begin  -- plus
      if (b_sign = 0) then
         sa := extend(a, max_width, 0);
      else
         sa := extend(a, max_width+1, a_sign);
      end if;
      sb := extend(b, max_width+1, b_sign);

      for i in 0 to max_width loop
         if (sa(i) = 'X' or sb(i) = 'X') then
            retval(i) := 'X';
            carry     := 'X';
         elsif (carry = 'X') then
            retval(i) := 'X';
            carry     := '0';
         else
            retval(i) := sa(i) xor sb(i) xor carry;
            carry     := (sa(i) and sb(i)) or
                     (sa(i) and carry) or
                     (sb(i) and carry);
         end if;
      end loop;  -- i
      --end if;    
      return retval;
   end add2;

-- Addition function that correctly handles when inputs are 'X'.
   function "+"(a,b : std_logic_vector)
      return std_logic_vector is
      constant a_width   : integer := a'length;
      constant b_width   : integer := b'length;
      constant max_width : integer := eval(a_width >= b_width)*a_width
                                     + eval(b_width > a_width)*b_width;
      variable sa : std_logic_vector(max_width-1 downto 0) :=
         extend(a, max_width, 0);
      variable sb : std_logic_vector(max_width-1 downto 0) :=
         extend(b, max_width, 0);
      variable retval : std_logic_vector(max_width-1 downto 0);
      variable carry  : std_logic := '0';
   begin  -- plus
      if (anyX(sa) or anyX(sb)) then
         retval := (others => 'X');
      elsif (all0(sa)) then
         retval := sb;
      elsif (all0(sb)) then
         retval := sa;
      else
         for i in 0 to max_width-1 loop
            retval(i) := sa(i) xor sb(i) xor carry;
            carry     := (sa(i) and sb(i)) or
                     (sa(i) and carry) or
                     (sb(i) and carry);
         end loop;  -- i
      end if;
      return retval;
   end "+";

   function calc_a_input_width(operand_width, c_has_a_signed,
                               rom_addr_width, baat, c_has_loadb : integer) return integer is
      variable effective_op_width : integer;
      variable a_input_width      : integer;
   begin
      if (baat < operand_width) then
         a_input_width := baat;
      else
         a_input_width := operand_width;
      end if;
      --if (baat < operand_width) then
      --  return baat ;
      --end if ;
      if (c_has_a_signed = 0 or c_has_loadb = 1) then
         effective_op_width := a_input_width;
      else
         -- Allow extra input for 'a_signed'
         effective_op_width := a_input_width + 1;
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
   function check_18(has_a_signed, a_width, a_type, b_width, b_type : integer)
      return integer is
      variable case_18                      : boolean := false;
      variable a_w, b_w, a_t, b_t, t_w, t_t : integer;
      constant mult_in                      : integer := 18;
      constant mult_in_unsigned             : integer := 17;
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

      case_18 :=
         (
            (a_t = c_signed and a_w rem mult_in_unsigned = 1) and
            (
               (b_type = c_signed and b_w <= a_w) or
               (b_type = c_unsigned and b_width < a_w)
               )
            ) ;

      if(case_18) then
         return 1;
      end if;
      return 0;
   end check_18;

   function parm_calc_num_pps(
      c_mult_type    : integer;
      c_a_width      : integer;
      c_a_type       : integer;
      c_b_width      : integer;
      c_b_type       : integer;
      c_has_a_signed : integer
      ) return integer is
      constant mult18 : integer := check_18(c_has_a_signed, c_a_width, c_a_type, c_b_width, c_b_type);
      constant a_ext_width : integer := select_val(c_a_width, c_a_width +1, (c_has_a_signed = 1));
      constant a_prods     : integer := (a_ext_width-1)/(17 + mult18) + 1;  -- number of products involving a !!! a_signed
      constant b_prods     : integer := (c_b_width-1)/(17 + mult18) + 1;  -- number of products involving b

      constant a_count : integer := (a_ext_width+1)/2;
      constant b_count : integer := (c_b_width+1)/2;
   begin
      if(c_mult_type = 1) then
--          if(check_18(c_has_a_signed, c_a_width, c_a_type, c_b_width, c_b_type) = 1) then
--             return 1;
--          else
            return a_prods * b_prods;
         --end if;
      elsif ( c_mult_type = 0) then
         -- larger width is always used as the a input port
         -- width within the multiplier
         if(a_ext_width <= c_b_width) then
            return a_count;
         else
            return b_count;
         end if;
      end if;
      return 0;
   end parm_calc_num_pps;


   function get_rom_addr_width(mem_type : integer) return integer is
   begin
      if mem_type = c_distributed then
         return 4;
      else
         return 8;
      end if;
   end get_rom_addr_width;

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

   function str_to_slv(bitsin : string; nbits : integer) return std_logic_vector is

      -- STRING types RANGE from 1 to len!!!
      variable ret     : std_logic_vector(nbits-1 downto 0);
      variable bit_num : integer;
   begin
      
      ret := (others => '0');

      if (bitsin = "") then             -- Make all '0's
         return ret;
      end if;

      bit_num := 0;

      for i in bitsin'reverse_range loop
         
         if bitsin(i) = '1' then
            ret(bit_num) := '1';
         elsif bitsin(i) = '0' then
            ret(bit_num) := '0';
         elsif (bitsin(i) = 'U' or bitsin(i) = 'u') then
            ret(bit_num) := 'U';
         elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
            ret(bit_num) := 'X';
         elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
            ret(bit_num) := 'Z';
         elsif (bitsin(i) = 'W' or bitsin(i) = 'w') then
            ret(bit_num) := 'W';
         elsif (bitsin(i) = 'L' or bitsin(i) = 'l') then
            ret(bit_num) := 'L';
         elsif (bitsin(i) = 'H' or bitsin(i) = 'h') then
            ret(bit_num) := 'H';
         elsif (bitsin(i) = '-') then
            ret(bit_num) := '-';
         else
            assert false
               report "ERROR: invalid character passed to str_to_slv function." &
               " STRING passed in was: " & bitsin
               severity failure;
         end if;

         bit_num := bit_num + 1;

         if bit_num >= nbits then
            exit;  -- Ignore ms characters in STRING if STRING is longer than BV
         end if;
      end loop;

      return ret;
      
   end str_to_slv;

   function str_to_slv2(bitsin : string; nbits : integer) return std_logic_vector is

      -- STRING types RANGE from 1 to len!!!
      variable ret     : std_logic_vector(nbits-1 downto 0);
      variable bit_num : integer;
   begin
      
      ret := (others => '0');

      if (bitsin = "") then             -- Make all '0's
         return ret;
      end if;

      bit_num := 0;

      for i in bitsin'reverse_range loop
         
         if bitsin(i) = '1' then
            ret(bit_num) := '1';
         elsif bitsin(i) = '0' then
            ret(bit_num) := '0';
         elsif (bitsin(i) = 'U' or bitsin(i) = 'u') then
            ret(bit_num) := 'U';
         elsif (bitsin(i) = 'X' or bitsin(i) = 'x') then
            ret(bit_num) := 'X';
         elsif (bitsin(i) = 'Z' or bitsin(i) = 'z') then
            ret(bit_num) := 'Z';
         elsif (bitsin(i) = 'W' or bitsin(i) = 'w') then
            ret(bit_num) := 'W';
         elsif (bitsin(i) = 'L' or bitsin(i) = 'l') then
            ret(bit_num) := 'L';
         elsif (bitsin(i) = 'H' or bitsin(i) = 'h') then
            ret(bit_num) := 'H';
         elsif (bitsin(i) = '-') then
            ret(bit_num) := '-';
         else
            assert false
               report "ERROR: invalid character passed to str_to_slv function." &
               " STRING passed in was: " & bitsin
               severity failure;
         end if;

         bit_num := bit_num + 1;

         if bit_num >= nbits then
            exit;  -- Ignore ms characters in STRING if STRING is longer than BV
         end if;
      end loop;

      return ret;
      
   end str_to_slv2;


   function find_ccm_b_width(bitsin : std_logic_vector; b_width, mult_type, has_load : integer) return integer is
      variable b_in : std_logic_vector(bitsin'length-1 downto 0) := bitsin;
      variable ret  : integer                                    := 1;
      -- STRING types RANGE from 1 to len!!!
   begin
      
      if (mult_type > 1) and (has_load = 0) and not(anyX(bitsin)) then
         for i in 0 to (bitsin'length-1) loop
            if b_in(i) = '1' then ret := i+1;
            end if;
         end loop;
      else
         ret := b_width;
      end if;

      return ret;
   end find_ccm_b_width;


   function extend( vector : std_logic_vector; bits : integer; sign : integer )
      return std_logic_vector is

      constant return_width : integer := bits;  -- greatest2( bits, vector'LENGTH );
      variable return_value : std_logic_vector(return_width-1 downto 0);

   begin

      for i in 0 to return_width-1 loop
         if i <= vector'length-1 then
            return_value(i) := vector(i);
         elsif (sign = 0) then
            return_value(i) := vector(vector'high);
         elsif (sign = 1) then
            return_value(i) := '0';
         end if;
      end loop;

      return return_value;

   end extend;

   function get_rom_addr_width(mem_type        : integer;
                               bram_addr_width : integer) return integer is
   begin
      if mem_type = c_distributed then
         return 4;
      else
         --ASSERT (bram_addr_width=8 OR bram_addr_width=9)
         --  REPORT "ERROR: CCM - bram_addr_width must be set to 8 or 9." & new_line
         --  SEVERITY ERROR;
         
         if bram_addr_width = 9 then
            return 9;
         else
            return 8;
         end if;  -- bram_addr_width
         
      end if;
   end get_rom_addr_width;

   function bitstorep_string(a_value : string;
                             a_type  : integer) return natural is
      variable return_value : integer;
   begin
      return_value := a_value'length;

      if a_type = c_unsigned then

         -- a_value represents an unsigned number
         for i in a_value'range loop
            if a_value(i) = '1' then
               exit;                    -- EXIT when the msb is found
            elsif a_value(i) = '0' then
               return_value := return_value - 1;
            else
            end if;
         end loop;
         
      else

         -- a_value represents a signed number
         -- Look for ms '1' followed by a '0'
         for i in a_value'range loop
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
            end if;
         end loop;
         
      end if;

      if return_value <= 0 then
         return 1;
      else
         return return_value;
      end if;

   end bitstorep_string;

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

   function eval( condition : boolean )
      return integer is

   begin

      if condition = true then
         return 1;
      else
         return 0;
      end if;

   end eval;

   function anyX(vect : std_logic_vector)

      return boolean is

   begin

      for i in vect'range loop
         if (rat(vect(i)) = 'X') then
            return true;
         end if;
      end loop;

      return false;

   end anyX;

   function rat( value : std_logic )
      return std_logic is

   begin

      case value is
         when '0' | '1' => return value;
         when 'H'       => return '1';
         when 'L'       => return '0';
         when others    => return 'X';
      end case;

   end rat;

   function two_comp(vect : std_logic_vector)
      return std_logic_vector is

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


end mult_pkg_v7_0;


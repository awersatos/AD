-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc., is distributed
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
--
----------------------------------------------------------------------------
-- MULTIPLY COMPILER  :  VHDL Behavioral Model 
----------------------------------------------------------------------------
--
--
----------------------------------------------------------------------------
-- Filename:  mult_gen_v7_0_non_seq.vhd
--                                   
-- Description:  
--      This is the VHDL behavioral description of a Multiply Compiler
--      Core.  It simulates the the behavior of non-sequential cores including each
--      of the following sub-cores:
--                                  0- lut based parallel
--                                  1- Virtex II parallel
--                                  2- parallel CCM
--                                  3- static RCCM
--                                  4- dynamic RCCM
----------------------------------------------------------------------------
-- Structure:
--    mult_gen_v7_0.vhd calls mult_gen_non_seq.vhd for non sequential cores.
--    mult_gen_v7_0.vhd calls mult_gen_seq.vhd for sequential cores.
--    mult_gen_v7_0_seq.vhd calls this model for it's internal multiplier.
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library std;
use std.textio.all;

library xilinxcorelib;
use xilinxcorelib.prims_constants_v7_0.all;
use XilinxCoreLib.mult_const_pkg_v7_0.all;
use xilinxcorelib.mult_pkg_v7_0.all;

use XilinxCoreLib.mult_gen_v7_0_services.all;

----------------------------------------------------------------------------
-- PORT DECLARATION
----------------------------------------------------------------------------

entity mult_gen_v7_0_non_seq is
   generic (
      c_a_width         : integer := A_DEFAULT_WIDTH;
      -- vector width of operand A
      c_b_width         : integer := B_DEFAULT_WIDTH;
      -- vector width of operand B
      c_out_width       : integer := OUT_DEFAULT_WIDTH;
      -- vector width of the output
      c_has_q           : integer := DEFAULT_HAS_Q;
      -- generate a registered output- dout 
      c_has_o           : integer := DEFAULT_HAS_0;
      -- generate a non-registered output
      -- NOTE: core can produce both a
      -- registered and a non-registered
      -- output.
      c_reg_a_b_inputs  : integer := DEFAULT_REG_A_B_INPUTS;
      -- inputs A and B are registered
      c_a_type          : integer := DEFAULT_A_TYPE;
      -- determines whether the operand A
      -- is signed, unsigned
      c_b_type          : integer := DEFAULT_B_TYPE;
      -- determines whether the operand B
      -- is signed, unsigned
      c_b_constant      : integer := DEFAULT_CONSTANT_B;
      -- operand B is a constant
      c_b_value         : string  := DEFAULT_CONSTANT_B_VAL;
      -- value of operand B when constant
      c_has_aclr        : integer := DEFAULT_HAS_ACLR;
      -- generate an asynchronous clear
      c_has_sclr        : integer := DEFAULT_HAS_SCLR;
      -- generate a synchronous clear
      c_has_ce          : integer := DEFAULT_HAS_CE;
      -- generate a clock enable
      c_has_a_signed    : integer := DEFAULT_HAS_A_SIGNED;
      -- generate a signal to control the
      -- sign of operand A
      c_enable_rlocs    : integer := DEFAULT_ENABLE_RLOCS;
      -- enable relative placement
      c_has_loadb       : integer := DEFAULT_HAS_LOADB;
      -- generate a signal to control the
      -- loading of constant operand B
      c_mem_type        : integer := DEFAULT_MEM_TYPE;
      -- defines whether the multiplier
      -- implementation uses single port
      -- block mem, dual port block mem,
      -- distributed mem
      c_mult_type       : integer := DEFAULT_MULT_TYPE;
      -- determines which kind of multiplier
      -- to instantiate:
      -- 0- lut based parallel
      -- 1- Virtex II parallel
      -- 2- parallel CCM
      -- 3- static RCCM
      -- 4- dynamic RCCM
      c_baat            : integer := DEFAULT_BAAT;
      -- Number of "Bits At A Time" A sequential multiplier 
      -- uses this to indicate how large a slice of the 
      -- A input is processed on each clock cycle. For this 
      -- model (non-sequential) it should be set to C_A_WIDTH.
      c_has_swapb       : integer := DEFAULT_HAS_SWAPB;
      -- generate a multiplier busy signal
      c_has_nd          : integer := DEFAULT_HAS_ND;
      -- generate a new data signal
      c_has_rdy         : integer := DEFAULT_HAS_RDY;
      -- generate a output ready signal
      c_has_rfd         : integer := DEFAULT_HAS_RFD;
      -- generate a ready for data signal
      c_pipeline        : integer := 0; 
      -- 0 = minimum pipelining, 1 = maximum pipelining.
      c_predelay        : integer := 0;
      -- The sequential multiplier set this for a realoadable multiplier.
      c_sync_enable     : integer := DEFAULT_SYNC_ENABLE;
      -- 0 = SCLR overrides CE, 1 = CE overrides SCLR.
      c_has_load_done   : integer := DEFAULT_HAS_LOAD_DONE;
      -- signal is generated in GUI whenever core has a load_done pin.
      c_output_hold     : integer := DEFAULT_OUTPUT_HOLD;
      -- Sequential multiplier has an output hold register. (not used in this model)
      c_sqm_type        : integer := 0;
      -- 0 = parallel input, 1 = serial input
      c_has_b           : integer := 1;
      -- generate a b input port (not used in behavioural model)
      c_stack_adders    : integer := 0;
      -- Placement (not used in behavioural model)
      bram_addr_width   : integer := 8;
      -- Block RAM address width. 8 in virtex, 9 in virtex2
      c_mem_init_prefix : string  := "mem";
      -- Prefix for the memory initialisation file. (not used in behavioural model)
      c_standalone      : integer := 0;
      -- Core is a standalone core. (not used in behavioural model)
      c_use_luts        : integer := 1
      -- 1 if using LUT based parallel multiplier, 0 if 
      -- using the virtex2 multiplier blocks. (Ignored by behavioural model)
      );
   port (
      clk : in  std_logic := '0';  -- clk must be present for all non-
                                   -- combinatorial implementation
                                   -- (i.e. if c_has_pipeline = 1)
      
      a   : in  std_logic_vector(((c_a_width-1)-((c_a_width-1)*c_sqm_type)) downto 0)
         := (others => '0');
      -- operand A
      b   : in  std_logic_vector(c_b_width-1 downto 0) := (others => '0');
      -- operand B
      o   : out std_logic_vector(c_out_width-1 downto 0) := (others => '0');
      -- non-registered output
      q   : out std_logic_vector(c_out_width-1 downto 0);
      -- registered output
      a_signed : in  std_logic := '0';
                                        -- determines the sign of operand A
                                        -- dynamically. (1 = signed) 
      loadb    : in  std_logic := '0';
                                        -- load operand B is used to reload
                                        -- the coefficient mem, active high-
                                        -- used when B is a constant that is
                                        -- reloadable.
      load_done : out std_logic;
                                        -- indicates that the mult. has
                                        -- finished reloading the new operand
                                        -- B into memory.
      swapb     : in  std_logic := '0';
                                        -- causes the multiplier to use the
                                        -- latest loaded B value.
      ce        : in  std_logic := '0';
                                        -- clock enable
      aclr      : in  std_logic := '0';
                                        -- asynchronous clear
      sclr      : in  std_logic := '0'; -- synchronous clear
      rfd       : out std_logic;        -- ready for data- signals that the
                                        -- multiplier can accept and process
                                        -- new operands
      nd        : in  std_logic         := '1'; 
                                        -- New Data signal. A high indicates that 
                                        -- the A port or B port has new data.
      rdy       : out std_logic         -- output ready- indicates that the
                                        -- output is valid.
      );
end mult_gen_v7_0_non_seq;


architecture behavioral of mult_gen_v7_0_non_seq is

----------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------

   -- This function calculates the output width of the multiplier.
   -- For the unreloadable ccm this is caluculated by taking the maximum possible 
   -- a value and multiplying it by the constant. For the two input multipliers it
   -- is simply the a width plus the b width.
   function find_ccm_out_width (bin : std_logic_vector; non_ccm_width : integer; a_width : integer) return integer is
      variable ccm_max_a_val             : std_logic_vector(a_width-1 downto 0);
      variable max_result                : std_logic_vector((a_width+bin'length)-1 downto 0);
      variable max_result_negated        : std_logic_vector((a_width+bin'length)-1 downto 0);
      variable ccm_output_width          : integer;
      variable ccm_negative_output_width : integer;
      variable index                     : integer;
      variable cin                       : std_logic;
      variable value                     : std_logic;
      variable b_in                      : std_logic_vector((bin'length-1) downto 0) := bin;
      variable a_signed                  : integer                                   := 0;
      variable a_negative                : integer                                   := 0;
      variable b_negative                : integer                                   := 0;
   begin
      ccm_output_width          := 0;
      ccm_negative_output_width := 0;
      if (c_mult_type = 2 and anyX(bin)) then
         return non_ccm_width;
      end if;
      if (c_a_type = c_signed and not(c_baat < c_a_width)) then
         ccm_max_a_val            := (others => '0');
         ccm_max_a_val(a_width-1) := '1';
         a_negative               := 1;
      else
         ccm_max_a_val := (others => '1');
         a_negative    := 0;
      end if;
      max_result         := (others => '0');
      max_result_negated := (others => '0');
      if (c_b_type = c_signed and (bin(bin'length-1) = '1')) then
         b_in       := two_comp(bin);
         b_negative := 1;
      end if;
      for i in 0 to (b_in'length-1) loop
         if (b_in(i) = '1') then
            index := i;
            cin   := '0';
            for j in 0 to a_width-1 loop   -- add a to prod 
               value := max_result(index) xor ccm_max_a_val(j) xor cin;  -- sum
               cin   := (max_result(index) and ccm_max_a_val(j)) or (max_result(index) and cin) or
                        (ccm_max_a_val(j) and cin);            -- carry
               max_result(index) := value;
               index             := index + 1;
            end loop;
            max_result(index) := max_result(index) xor cin;  -- last carry 
         else
            cin := '0';
         end if;
      end loop;
      for i in 0 to (max_result'length-1) loop
         if (max_result(i) = '1') then
            ccm_output_width := i+1;
         end if;
      end loop;
      if (a_negative = 1 and b_negative = 1) then
         ccm_output_width := ccm_output_width + 1;
      elsif ((a_negative = 1 and b_negative = 0) or (a_negative = 0 and b_negative = 1)) then
         max_result_negated := two_comp(max_result);
         for i in 0 to ccm_output_width-1 loop
            if(max_result_negated(i) = '0') then
               ccm_negative_output_width := i + 2;
            end if;
         end loop;
         ccm_output_width := ccm_negative_output_width;
      end if;
      -- This is the code for calculating the multiplier output width.
      if (c_mult_type > 1 and c_mult_type /= 5) and (c_has_loadb = 0) then
         if(bin'length = 1 and c_b_type = c_unsigned and bin(bin'high) = '1' and c_a_type /= 2) then
            ccm_output_width := a_width;
         elsif(bin'length = 1 and c_b_type = c_signed and bin(bin'high) = '1') then
            ccm_output_width := a_width+1;
         elsif (c_has_a_signed = 1 and c_b_type = c_unsigned) then
            ccm_output_width := ccm_output_width + 1;
         else
            ccm_output_width := ccm_output_width;
         end if;
         return ccm_output_width;
      else
         if (c_mult_type > 2 and c_mult_type /= 5) and (bin'length = 1) then
            if (c_has_a_signed = 1) and (c_b_type = c_unsigned) then
              return non_ccm_width;
            else
              return non_ccm_width-1;
            end if;
         elsif (c_mult_type > 2 and c_mult_type /= 5) and (a_width = 1) then
            if (c_has_a_signed = 1) and (c_b_type = c_unsigned) then
              return non_ccm_width;
            else
              return non_ccm_width-1;
            end if;
         else
           if (c_has_a_signed = 1) and (c_b_type = c_unsigned) then
              return non_ccm_width + 1;
           else
              return non_ccm_width;
           end if;
         end if;
      end if;
   end find_ccm_out_width;

   function find_actual_a_width(a_width : integer)
      return integer is
   begin
      if (c_has_a_signed = 1) then
         return a_width+1;
      else
         return a_width;
      end if;
   end find_actual_a_width;

   function find_b_width(ccm_b_width, non_ccm_b_width, mult_type : integer)
      return integer is
   begin
      if (mult_type < 2) then
         return non_ccm_b_width;
      else
         return ccm_b_width;
      end if;
   end find_b_width;

   -- Muliplier function that handles all signed/unsigned combinations and
   -- correctly handles when any of the input bits are an 'X'.
   function mult(a, b : std_logic_vector; a_sign : std_logic; sign, out_width : integer)
      return std_logic_vector is
      constant a_width                      : integer                              := a'length;
      constant b_width                      : integer                              := b'length;
      variable la                           : std_logic_vector(a_width-1 downto 0) := a;
      variable lb                           : std_logic_vector(b_width-1 downto 0) := b;
      variable lsigna                       : std_logic;
      constant ccm_out_width                : integer                              := find_ccm_out_width(b, (a_width + b_width), a_width);
      variable product                      : std_logic_vector((ccm_out_width-1) downto 0);
      variable negative                     : boolean;
      variable a_value, b_value, prod_value : integer;
      variable index                        : integer;
      variable cin, value                   : std_logic;
      constant diff                         : integer                              := ccm_out_width - out_width;
      variable product_o                    : std_logic_vector(out_width-1 downto 0);
      variable a_type                       : integer;
   begin
      if (sign = c_signed) then
         lsigna := a_sign;
      else
         lsigna := '0';
      end if;
      if (sign = c_signed and c_a_type = c_signed) then
         a_type := c_signed;
      else
         a_type := c_unsigned;
      end if;
      if ((all0(la) and (c_has_a_signed = 0 or lsigna /= 'X')) and not(anyX(lb))) 
        or (all0(lb) and (not(anyX(la)) and (c_has_a_signed = 0 or lsigna /= 'X' or c_mult_type < 2 or c_mult_type = 5))) then -- and mult_type < 2) then
         product := (others => '0');
      elsif (anyX(la) or anyX(lb) or (c_has_a_signed = 1 and sign = c_signed and lsigna = 'X')) then
         product := (others => 'X');
      else
         negative := false;
         if (c_b_type = c_unsigned) then
            if ((c_has_a_signed = 0 and a_type = c_signed and (la(a_width-1) = '1')) or
                (c_has_a_signed = 1 and lsigna = '1' and (la(a_width-1) = '1'))) then
               negative := true;
            end if;
         elsif (c_has_a_signed = 0 and a_type = c_unsigned) or
            (c_has_a_signed = 1 and lsigna = '0') then
            if (c_b_type = c_signed and (lb(b_width-1) = '1')) then
               negative := true;
            end if;
         elsif (c_b_type = c_signed and (
            ((c_has_a_signed = 0 and a_type = c_signed) or
             (c_has_a_signed = 1 and lsigna = '1')))) then
            if ((la(a_width-1) = '0') and (lb(b_width-1) = '1')) or
               ((la(a_width-1) = '1') and (lb(b_width-1) = '0')) then
               negative := true;
            end if;
         end if;
         if (((c_has_a_signed = 0 and a_type = c_signed and (la(a_width-1) = '1')) or
              (c_has_a_signed = 1 and lsigna = '1' and (la(a_width-1) = '1')))) then
            la := two_comp(la);
         end if;
         if ((c_b_type = c_signed and (lb(b_width-1) = '1'))) then
            lb := two_comp(lb);
         end if;
         product := (others => '0');
         for i in 0 to b_width -1 loop  -- b width
            if (lb(i) = '1') then
               index := i;
               cin   := '0';
               for j in 0 to a_width-1 loop  -- add a to prod 
                  if index < ccm_out_width then
                     value := product(index) xor la(j) xor cin;  -- sum
                     cin   := (product(index) and la(j)) or (product(index) and cin) or
                            (la(j) and cin);                     -- carry
                     product(index) := value;
                     index          := index + 1;
                  end if;
               end loop;
               if index < ccm_out_width then
                  product(index) := product(index) xor cin;      -- last carry 
               end if;
            else
               cin := '0';
            end if;
         end loop;
         if (negative) then
            product := two_comp(product);
         end if;
      end if;
      if (out_width < ccm_out_width) then
         for i in 0 to out_width-1 loop
            product_o(i) := product(i+diff);
         end loop;  -- n
      elsif (out_width > ccm_out_width) then
         product_o(ccm_out_width-1 downto 0) := product;
         for i in ccm_out_width to out_width-1 loop
            if(b_width > 1 and a_width > 1) then
               if (((a_type = c_signed and c_has_a_signed = 0) or c_b_type = c_signed or (c_has_a_signed = 1 and lsigna = '1')) and ccm_out_width /= 0) then
                  product_o(i) := product(ccm_out_width-1);
               elsif (anyX(la) or anyX(lb) or (c_has_a_signed = 1 and sign = c_signed and lsigna = 'X')) then
                  product_o(i) := 'X';
               else product_o(i) := '0';
               end if;
            else
               if negative and (((a_type = c_signed and c_has_a_signed = 0) or c_b_type = c_signed or (c_has_a_signed = 1 and lsigna = '1')) and ccm_out_width /= 0) then
                  product_o(i) := '1';
               elsif (anyX(la) or anyX(lb) or (c_has_a_signed = 1 and sign = c_signed and lsigna = 'X')) then
                  product_o(i) := 'X';
               else product_o(i) := '0';
               end if;
            end if;
         end loop;
      else product_o := product;
           return product_o;
      end if;
      return product_o;
   end mult;

   -- These are small helper functions.
   function max (a, b : integer) return integer is
      variable maximum_value : integer := 0;
   begin
      if (a >= b) then
         maximum_value := a;
      else
         maximum_value := b;
      end if;
      return maximum_value;
   end max;

   function inc_if_sig (a_type, a_sign : integer) return integer is
      variable return_value : integer := 0;
   begin
      if ((a_type = 0 or a_sign = 1) and c_b_type = 1) then return_value := 1;
      else return_value                                                  := 0;
      end if;
      return return_value;
   end inc_if_sig;

   function inc_if_no_sign (a_type, b_type : integer) return integer is
      variable return_value : integer := 0;
   begin
      if ((a_type = c_unsigned and b_type = c_unsigned)) then return_value := 1;
      else return_value                                                    := 0;
      end if;
      return return_value;
   end inc_if_no_sign;

   function inc_if_sign (a_type, b_type : integer) return integer is
      variable return_value : integer := 0;
   begin
      if ((a_type = c_unsigned and b_type = c_unsigned)) then return_value := 0;
      else return_value                                                    := 1;
      end if;
      return return_value;
   end inc_if_sign;

   function inc_baat (baat : integer) return integer is
   begin
      if (baat > 1 or c_mult_type /= 2) then return 1;
      else return 0;
      end if;
   end inc_baat;

   function inc_if_serial (mult_type, sqm_type : integer) return integer is
   begin
      if (mult_type > 1 and sqm_type = 1) then return 1;
      else return 0;
      end if;
   end inc_if_serial;

   function has_a_sign (has_a_signed, a_type, baat, a_width : integer) return integer is
   begin
      if ((has_a_signed = 1 or a_type = c_signed) and (baat < a_width)) then
         return 1;
      else
         return has_a_signed;
      end if;
   end has_a_sign;

   function fix_mult_type (a : integer) return integer is
   begin
      if (a = 5) then
         return 1;
      else
         return a;
      end if;
   end fix_mult_type;

   --Sets the b value for a constant co-efficient multiplier.
   function set_b_value return std_logic_vector is
      variable b_tmp   : std_logic_vector(c_b_width-1 downto 0);
      variable ret_val : std_logic_vector((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, c_mult_type, c_has_loadb)-1) downto 0);
      variable msb     : integer := 0;
   begin
      if (c_mult_type > 1 and c_mult_type /= 5) then
         b_tmp := str_to_slv(c_b_value, c_b_width);
         if(c_b_type = c_signed and c_has_loadb = 1 and c_b_value(1) = '1') then
            for i in c_b_width-1 downto 0 loop
               if (b_tmp(i) = '1') then
                  msb := i;
                  exit;
               end if;
            end loop;
            for i in msb to c_b_width-1 loop
               b_tmp(i) := '1';
            end loop;
            ret_val := b_tmp;
         elsif (c_has_loadb = 1) then
            ret_val := b_tmp;
         else
            ret_val := str_to_slv(c_b_value, find_ccm_b_width(b_tmp, c_b_width, c_mult_type, c_has_loadb));
         end if;
         return ret_val;
      else
         return b_tmp;
      end if;
   end set_b_value;

----------------------------------------------------------------------------
-- SIGNAL DECLARATION
----------------------------------------------------------------------------
   constant mult_type : integer := fix_mult_type(c_mult_type);
   
   signal b_input : std_logic_vector((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) downto 0) := set_b_value;
   signal bconst0 : std_logic_vector((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) downto 0) := set_b_value;
   signal bconst1 : std_logic_vector((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) downto 0) := set_b_value;

   constant out_size : integer := find_ccm_out_width(set_b_value, c_baat+c_b_width, c_baat);

   signal full_out_size : integer := find_ccm_out_width(set_b_value, c_a_width+c_b_width, c_a_width);

   constant ccm_b_width    : integer := select_val(bitstorep_string(c_b_value, c_b_type), c_b_width, c_has_loadb /= 0);
   constant real_a_width   : integer := (c_a_width-1) - ((c_a_width-1)*c_sqm_type) + 1;
   constant b_is_0         : boolean := b_input'length = 1 and set_b_value(0) = '0' and mult_type = 2;
   constant rom_addr_width : integer := get_rom_addr_width(c_mem_type, bram_addr_width);
   constant a_input_width  : integer := calc_a_input_width(real_a_width, c_has_a_signed, rom_addr_width, c_baat, c_has_loadb);
   constant need_addsub    : boolean := c_has_loadb = 1 and (c_a_type /= c_unsigned or c_has_a_signed /= 0);
   constant ccm_num_pps    : integer := calc_num_pps(a_input_width, rom_addr_width);

   constant shift_bits         : integer := select_val(calc_shift_bits(c_b_value, c_b_constant, c_b_type), 0, mult_type /= 2);
   constant actual_ccm_b_width : integer := select_val((ccm_b_width - shift_bits), c_b_width, c_has_loadb /= 0);
   constant actual_b_width     : integer := find_b_width(actual_ccm_b_width, c_b_width, mult_type);
   constant b_is_1             : boolean := actual_b_width = 1 and set_b_value(b_input'length-1) = '1' and mult_type = 2 and c_b_type = c_unsigned;

   constant a_sig : integer := has_a_sign(c_has_a_signed, c_a_type, c_baat, c_a_width);
    type     multiplier_stages is array (0 to ((calc_latency(c_a_width, actual_b_width, c_b_type, a_sig, c_reg_a_b_inputs, c_mem_type, c_pipeline, c_mult_type, c_has_loadb, c_baat, c_b_value, c_a_type, c_has_swapb, c_sqm_type, c_has_aclr, c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, bram_addr_width)))) of
       std_logic_vector((c_out_width-1) downto 0);

   signal clk_i          : std_logic;
   signal last_clk       : std_logic                                                                                                                                                                                                                        := '0';
   signal ce_i           : std_logic;
   signal aclr_i         : std_logic;
   signal sclr_i         : std_logic;
   signal nd_i           : std_logic                                                                                                                                                                                                                        := '0';
   signal nd_q           : std_logic                                                                                                                                                                                                                        := '0';
   signal loadb_i        : std_logic;
   signal loadb_i_nop    : std_logic;
   signal load_done_i    : std_logic                                                                                                                                                                                                                        := '1';
   signal swapb_i        : std_logic;
   signal bank_sel       : std_logic                                                                                                                                                                                                                        := '0';
   signal bank_sel_pre   : std_logic := '0';
   signal loadb_count    : integer := -1;
   signal loadb_count_no_predelay : integer := -1;
   signal loadb_count_dly : integer := -1;
   signal loadb_count_dly_int : integer := -1;
   signal rfd_i          : std_logic                                                                                                                                                                                                                        := '1';
   signal rfd_f          : std_logic                                                                                                                                                                                                                        := '1';
   signal rfd_q          : std_logic                                                                                                                                                                                                                        := '1';
   signal rdy_i          : std_logic                                                                                                                                                                                                                        := '0';
   signal rdy_q          : std_logic                                                                                                                                                                                                                        := '0';
   signal asign_i        : std_logic;
   signal asign_q        : std_logic;
   signal sub_rdy        : std_logic_vector((calc_latency(c_a_width, actual_b_width, c_b_type, a_sig, c_reg_a_b_inputs, c_mem_type, c_pipeline, c_mult_type, c_has_loadb, c_baat, c_b_value, c_a_type, c_has_swapb, c_sqm_type, c_has_aclr, c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, bram_addr_width)) downto 0) := (others => '0');
   signal a_i            : std_logic_vector((real_a_width-1) downto 0);
   signal b_i            : std_logic_vector((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) downto 0)                                                                                                           := (others => '0');
   signal reg_b          : std_logic_vector((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) downto 0)                                                                                                           := (others => '0');
   signal reg_reg_b      : std_logic_vector((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) downto 0)                                                                                                           := (others => '0');
   signal reg_swapb      : std_logic;
   signal reg_reg_swapb  : std_logic;
   signal reg_loadb      : std_logic;
   signal reg_reg_loadb  : std_logic;
   signal dina_q         : std_logic_vector((real_a_width-1) downto 0)                                                                                                                                                                                      := (others => '0');
   signal dinb_q         : std_logic_vector((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) downto 0)                                                                                                           := (others => '0');
   signal load_b_value   : std_logic_vector((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) downto 0);

   signal product_i     : std_logic_vector((c_out_width-1) downto 0) := (others => '0');
   signal sub_product   : multiplier_stages           := (others => (others => '0'));
   signal q_i           : std_logic_vector((c_out_width-1) downto 0) := (others => '0');
   signal o_i           : std_logic_vector((c_out_width-1) downto 0) := (others => '0');
   signal cleared       : std_logic;

   constant no_of_cycles : integer := find_no_of_cycles(c_a_width, c_baat, mult_type);

   signal loading              : integer := 0;
   constant no_sign : integer := inc_if_no_sign(c_a_type, c_b_type);

   signal not_loaded       : integer := 1;
   signal c_latency        : integer := calc_latency(c_a_width, actual_b_width, c_b_type, a_sig, c_reg_a_b_inputs, c_mem_type, c_pipeline, c_mult_type, c_has_loadb, c_baat, c_b_value, c_a_type, c_has_swapb, c_sqm_type, c_has_aclr, c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, bram_addr_width);

   constant ccm_serial : integer := inc_if_serial(mult_type, c_sqm_type);

   type   sub_mult is array (0 to calc_latency(c_a_width, actual_b_width, c_b_type, a_sig, 0, c_mem_type, c_pipeline, c_mult_type, c_has_loadb, 1, c_b_value, c_a_type, c_has_swapb, c_sqm_type, c_has_aclr, c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, bram_addr_width) - 1) of
      std_logic_vector (out_size-no_sign downto 0);

   signal nd_q_tmp   : std_logic := '0';
   signal nd_q_p     : std_logic := '0';
   signal nd_q_c     : std_logic := '0';
   signal ready      : std_logic;
   signal ready_rl   : std_logic := '0';

   signal a_in    : std_logic_vector (real_a_width-1 downto 0)   := (others => '0');
   signal b_in    : std_logic_vector (b_input'length-1 downto 0) := (others => '0'); --set_b_value; --(others => '0');
   signal a_sign  : std_logic;
   signal nd_i_rl : std_logic := '0';

begin

----------------------------------------------------------------------------
-- PROCESS DECLARATION
---------------------------------------------------------------------------- 

   -- Generate internal control signals using IP variables.
   generate_inputs : process (clk, a, aclr, sclr, ce, nd, rfd_i, b, swapb, loadb, a_signed, load_done_i, reg_b, reg_reg_b, reg_swapb, reg_reg_swapb, reg_loadb, reg_reg_loadb)
   begin  -- process generate_inputs
      if (c_reg_a_b_inputs = 1 or c_has_q = 1 or c_latency > 0 or c_has_loadb = 1 or c_baat < c_a_width) then
         clk_i <= clk;
      else
         clk_i <= '0';
      end if;
      a_i <= a;
      if (c_predelay = 0 and mult_type /= 2) then
        b_i <= b;
      elsif (c_predelay = 0 and mult_type = 2) then
        b_i <= b((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) downto 0);
      elsif (c_predelay = 1) then
        b_i <= reg_b;
      else
        b_i <= reg_reg_b;
      end if;
      if (c_has_aclr = 1) and not(c_baat = c_a_width and c_latency = 0 and c_reg_a_b_inputs = 0 and c_has_q = 0 and mult_type < 3) then -- Change 1910d.
         aclr_i <= aclr;
      else
         aclr_i <= '0';
      end if;
      if (c_has_sclr = 1) and not(c_baat = c_a_width and c_latency = 0 and c_reg_a_b_inputs = 0 and c_has_q = 0 and mult_type < 3) then
--         and not(mult_type = 3 and loadb_count /= -1) then
         sclr_i <= sclr;
      else
         sclr_i <= '0';
      end if;
      if (c_has_ce = 1) and not(c_baat = c_a_width and c_has_q = 0 and c_latency = 0 and c_reg_a_b_inputs = 0 and c_has_loadb = 0) then
         ce_i <= ce;
      else
         ce_i <= '1';
      end if;
      if (c_has_nd = 1) then
         nd_i <= nd;
      else
         nd_i <= '1';
      end if;
      if (c_has_loadb = 1 and mult_type > 2) then
         loadb_i_nop <= loadb;
         if (c_predelay = 0) then
           loadb_i <= loadb;
         elsif (c_predelay = 1) then
           loadb_i <= reg_loadb;
         else
           loadb_i <= reg_reg_loadb;
         end if;
      else
         loadb_i <= '0';
      end if;
      if (c_has_swapb = 1 and mult_type > 2) then
         if (c_predelay = 0) then
            swapb_i <= swapb;
         elsif (c_predelay = 1) then
            swapb_i <= reg_swapb;
         else
            swapb_i <= reg_reg_swapb;
         end if;
      else
         swapb_i <= '0';
      end if;
      if (c_has_a_signed = 1) then
         asign_i <= a_signed;
      else
         asign_i <= '1';
      end if;
   end process generate_inputs;

   -- Register Inputs => a, b, nd.  Generate 'Ready for Data'- rfd.
   -- For the non-sequential case rfd_i is always '1' unless there is a aclr,
   -- sclr or loadb. This signal is fed to the rfd output. 
   register_inputs : process (clk_i, aclr_i, sclr_i, swapb_i, rfd_f, ce_i, nd_q_tmp)
   begin  -- process register_inputs
      if (aclr_i'event and aclr_i = '1') then
         dina_q   <= (others => '0');
         dinb_q   <= (others => '0');
         nd_q_p   <= '0';
         nd_q_c   <= '0';
         rfd_i    <= '0';
      elsif (sclr_i'event and sclr_i = '1') then
         rfd_i  <= '0';
      elsif (aclr_i'event and aclr_i = '0' and sclr_i = '0') then 
         rfd_i  <= '1';
      elsif (sclr_i'event and sclr_i = '0' and aclr_i = '0') then
         rfd_i  <= '1';
      elsif (clk_i'event and clk_i = '1' and aclr_i = '0') then
         if (sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0)) then
            dina_q   <= (others => '0');
            if (mult_type /= 3 or loadb_count = -1) then
              dinb_q   <= (others => '0');
            end if;
            nd_q_p   <= '0';
            nd_q_c   <= '0';
         elsif (ce_i = '1') then
            dina_q  <= a_i;
            dinb_q  <= b_input;
            asign_q <= asign_i;
            nd_q_p  <= nd_i;
            nd_q_c  <= nd_i;
         else
            -- New data ignores the clock enable in the parm.
            nd_q_p  <= nd_i;
         end if;
      end if;
      
   end process register_inputs;
   
   choosend : process(nd_q_c, nd_q_p)
   begin
     if mult_type < 2 then
       nd_q <= nd_q_p;
     else
       nd_q <= nd_q_c;
     end if;
   end process choosend;

   -- Cope with predelay from the sequential.
   prdelay : process(aclr_i, clk_i)
   begin
     if (aclr_i = '1') then
       reg_b <= (others => '0');
       reg_reg_b <= (others => '0');
       reg_swapb <= '0';
       reg_reg_swapb <= '0';
       reg_loadb <= '0';
       reg_reg_loadb <= '0';
     elsif clk_i'event and clk_i = '1' then
       if sclr_i = '1' then
         reg_b <= (others => '0');
         reg_reg_b <= (others => '0');
         reg_swapb <= '0';
         reg_reg_swapb <= '0';
         reg_loadb <= '0';
         reg_reg_loadb <= '0';
       elsif (ce_i = '1') then
         --reg_b <= b;
         reg_b <= b((find_ccm_b_width(str_to_slv(c_b_value, c_b_width), c_b_width, mult_type, c_has_loadb)-1) downto 0);
         reg_reg_b <= reg_b;
         reg_swapb <= swapb;
         reg_reg_swapb <= reg_swapb;
         reg_loadb <= loadb; 
         reg_reg_loadb <= reg_loadb;
       end if;
     end if;
   end process prdelay;
   
   -- Multiply operands A and B. 
   -- This produces the product_i signal which is input to the pipeline.
   multiply : process (clk_i, dina_q, dinb_q, a_i, b_input, asign_i, asign_q, aclr_i, nd_i)
   begin  -- process multiply
      if not(c_baat < c_a_width) then
         
         -- Get the a and b values to multiply together.
         if (c_reg_a_b_inputs = 1) and (mult_type < 3) then
           if (c_has_nd = 1) and ((c_has_q = 1 and c_has_o = 0 and mult_type = 2) or c_latency > 0) then -- mult_type = 2 is Change 51101a.
             a_in   <= dina_q;
             b_in   <= dinb_q;
             a_sign <= asign_q;
           elsif (c_has_nd = 1) then
             if aclr_i = '1' then
               a_in   <= (others => '0');
               b_in   <= (others => '0');
               a_sign <= '0';
             elsif clk_i'event and clk_i = '1' then
               if sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0) then
                 a_in   <= (others => '0');
                 b_in   <= (others => '0');
                 a_sign <= '0';
               elsif (nd_i = '1' and ce_i = '1') then
                 a_in   <= a_i;
                 b_in   <= b_input;
                 a_sign <= asign_i;
               end if;
             end if;
           else -- no ND
             a_in   <= dina_q;
             b_in   <= dinb_q;
             a_sign <= asign_q;
           end if;
         elsif (mult_type >= 3 and c_reg_a_b_inputs = 1) then
           if (c_has_nd = 1) then
             if aclr_i = '1' then
               a_in   <= (others => '0');
               a_sign <= '0';
             elsif clk_i'event and clk_i = '1' then
               if sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0) then
                 a_in   <= (others => '0');
                 a_sign <= '0';
               elsif (nd_i = '1' and ce_i = '1') then -- and (mult_type /= 3 or loadb_count = -1 or loadb = '1')) then
                 a_in   <= a_i;
                 a_sign <= asign_i;
               end if;
             end if;
           else -- no ND
             a_in   <= dina_q;
             a_sign <= asign_q;
           end if;
           -- The reloadable B constant is held by the b_input signal.
           if (mult_type = 3 and c_latency = 0 and c_has_o = 1 and c_has_nd = 1) then
             if (clk_i'event and clk_i = '1') then
			   if (sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0)) then
                 b_in <= (others => '0');
               elsif (load_done_i = '0' or (nd_i = '1' and (ce_i = '1' or c_has_ce = 0))) then
			--	 elsif (loadb_count /= -1 or (nd_i = '1' and (ce_i = '1' or c_has_ce = 0))) then
                 b_in <= b_input;
               end if;
             end if;
           elsif mult_type = 3 then
             b_in <= dinb_q; --b_input;
           else
             b_in <= dinb_q;
           end if;
         else -- c_reg_a_b_inputs = 0.
           if mult_type < 3 or c_latency = 0 then
             a_in   <= a_i;
             a_sign <= asign_i;
           else
             if aclr_i = '1' then
               a_in <= (others => '0');
               a_sign <= '0';
             elsif clk_i'event and clk_i = '1' then
               if sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0) then
                 a_in <= (others => '0');
                 a_sign <= '0';
               elsif ce_i = '1' and (nd_i = '1' or c_has_nd = 0 or
                 (mult_type = 4 and c_latency = 1 
                   and c_mem_type = 0 and c_has_q = 0 and c_has_swapb = 1)) then
                 a_in <= a_i;
                 a_sign <= asign_i;
               end if;
             end if;
           end if;
           if (mult_type = 3 and c_has_nd = 1) then
             if ((clk_i'event and clk_i = '1') 
               or (mult_type = 3 and c_latency = 0 and nd_i'event and nd_i = '1')) then
			   --if (sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0)) then
               --  b_in <= (others => '0');
               --elsif (load_done_i = '0' or (nd_i = '1' and (ce_i = '1' or c_has_ce = 0))) then
               if (not_loaded = 1 or load_done_i = '0' or (nd_i = '1' 
                          and (ce_i = '1' or c_has_ce = 0))) then
                 b_in <= b_input;
               end if;
             end if;
           else
             b_in <= b_input;
           end if;
           --b_in   <= b_input;
         end if;

      end if;
   end process multiply;

   multiply2 : process(a_in, b_in, a_sign, loadb_count, loadb_count_dly_int)
   begin
      if (c_baat = c_a_width) then   
         -- Calculate output of multiplier stage
         --if (c_has_loadb = 1 and c_has_swapb = 0) and (loadb_count /= -1 and (loadb_count /= 0 or loadb = '1') and not_loaded = 0) then
         --if (c_has_loadb = 1 and c_has_swapb = 0) and ((loadb_count /= -1 or loadb_count_dly_int /= -1) and not_loaded = 0) then
         --if (c_has_loadb = 1 and c_has_swapb = 0) and (loadb_count /= -1 and not_loaded = 0) then
         if (c_has_loadb = 1 and c_has_swapb = 0) and c_latency = 0 and 
             (loadb_count /= -1 and not_loaded = 0) then
           -- Loading.
           product_i <= (others => 'X');
         elsif (c_has_loadb = 1 and c_has_swapb = 0) and c_latency /= 0 and 
              ((loadb_count /= -1 or loadb_count_dly_int /= -1) and not_loaded = 0) then
           -- Loading.
           product_i <= (others => 'X');
         else
           product_i <= mult(a_in, b_in, a_sign, 0, c_out_width);
         end if;
      end if;
   end process multiply2;
   
   -- For the reloadable ccm without a swapb pin we have to mask of the incoming
   -- new data with the load_done output.
   rdyrlgen : process(aclr_i, clk_i)
   begin
     if (aclr_i = '1') then
       ready_rl <= '0';
     elsif (clk_i'event and clk_i = '1') then
       if (sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0)) then
         ready_rl <= '0';
       elsif ce_i = '1' then
         ready_rl <= nd_i and load_done_i;
       end if;
     end if;
   end process rdyrlgen;
     
   -- Model the ready generation.
   rdygen : process(nd_i, nd_q, nd_q_c, ce_i, load_done_i, ready_rl)
   begin
     if c_baat = c_a_width then
       if c_has_swapb = 0 and c_has_loadb = 1 and mult_type = 3 then -- Reloadable ccm (stop during reload).
         if c_reg_a_b_inputs = 0 then
           ready <= nd_i and load_done_i;
         else
           ready <= ready_rl;
         end if;
       elsif mult_type > 1 then -- ccm and continue_during_reload rccm.
         if c_reg_a_b_inputs = 0 then
           ready <= nd_i;
         else
           ready <= nd_q;
         end if;
       else -- parm
         if (c_latency+c_reg_a_b_inputs = 0) or (c_latency = 1 and c_reg_a_b_inputs = 0 and c_has_q = 0) then
           ready <= nd_i and ce_i;
         elsif (c_latency = 0 and c_reg_a_b_inputs = 1 and c_has_q = 0) then
           ready <= nd_q_c;
         else
           ready <= nd_q and ce_i;
         end if;
       end if;
     end if;
   end process rdygen;

   -- The block memory doesn't have an aclr and so the reloadable can have an 
   -- undefined output just after an aclr. The cleared signal helps us model this.
   clrgen : process(aclr_i, clk_i)
   begin
     if (aclr_i = '0') then
       cleared <= '0';
     elsif (clk_i'event and clk_i = '1' and ce_i = '1') then
       cleared <= '1';
     end if;
   end process clrgen;
   
   -- Model the pipeline. The product_i signal is input to position 0 in the pipeline.
   -- If there is some latency in the design the o and q outputs are taken from the 
   -- c_latency position in the pipeline. Otherwise they are taken from product_i.
   pipeline_output : process (clk_i, aclr_i, product_i, ce_i, nd_q, nd_i, swapb_i)
   begin  -- process register_output
    if (c_baat = c_a_width) then
      -- Load the pipeline
      --if (loadb_count /= -1 and c_has_swapb = 0) then
      --  sub_product(0) <= (others => 'X'); -- Undefined during the load.
      --elsif mult_type > 2 and c_latency > 0 and c_reg_a_b_inputs = 0 then
      if mult_type > 2 and c_latency > 0 and c_reg_a_b_inputs = 0 then
        sub_product(0) <= product_i;
      elsif c_reg_a_b_inputs = 1 then
        if (c_has_q = 0) and c_latency = 0 then
          sub_product(0) <= product_i;
        else -- Some registers after the input stage.
          if aclr_i = '1' and (mult_type < 2 or c_mem_type = 0 or b_is_1) then
            sub_product(0) <= (others => '0');
          elsif clk_i'event and clk_i = '1' then
            if sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0) and 
              not(mult_type = 3 and loadb_count /= -1) then
              sub_product(0) <= (others => '0');
            elsif (mult_type < 2 and c_latency = 0 and ce_i = '1' and c_has_q = 1) then
              sub_product(0) <= product_i;
            elsif ((nd_q = '1' or (mult_type = 3 and loadb_count /= -1)) 
              or c_has_swapb = 1 or c_has_nd = 0 
                or (mult_type < 2 and c_latency = 0 and c_has_q = 0)) and ce_i = '1' then 
              sub_product(0) <= product_i;
            end if;
          end if;
        end if;
      else -- c_reg_a_b_inputs = 0.
        if c_latency = 0 and c_has_q = 0 then
          sub_product(0) <= product_i;
        elsif c_has_nd = 0 then -- c_has_nd = 0
          if aclr_i = '1' and (mult_type < 2 or c_mem_type = 0 or b_is_1) then
            sub_product(0) <= (others => '0');
          elsif clk_i'event and clk = '1' then
            if sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0) 
              and not(mult_type = 3 and loadb_count /= -1) then
              sub_product(0) <= (others => '0');
            elsif ce_i = '1' then
              sub_product(0) <= product_i;
            end if;
          end if;
        elsif (c_has_nd = 1 and mult_type < 2 and not(c_latency = 1 and c_has_o = 1)) then
          if aclr_i = '1' and (mult_type < 2 or c_mem_type = 0) then
            sub_product(0) <= (others => '0');
          elsif clk_i'event and clk = '1' then
            if sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0) 
              and not(mult_type = 3 and loadb_count /= -1) then
              sub_product(0) <= (others => '0');
            elsif ((ce_i = '1' and c_latency = 0 and c_has_q = 1 and nd_i = '1') 
               or  (ce_i = '1' and not(c_latency = 0 and c_has_q = 1))) then
              sub_product(0) <= product_i;
            end if;
          end if;
        else -- c_has_nd = 1.
          if c_latency = 0 then
            if aclr_i = '1' and (mult_type < 2 or c_mem_type = 0 or b_is_1) then
              sub_product(0) <= (others => '0');
            elsif clk_i'event and clk = '1' then
              if sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0) 
                and not(mult_type = 3 and loadb_count /= -1) then
                sub_product(0) <= (others => '0');
              elsif (nd_i = '1' or (mult_type = 3 and loadb_count /= -1)) and ce_i = '1' then
                sub_product(0) <= product_i;
              elsif ce_i = '1' then
              end if;
            end if;
          else -- c_latency > 0
            if aclr_i = '1' and (mult_type < 2 or c_mem_type = 0) then
              sub_product(0) <= (others => '0');
            elsif clk_i'event and clk = '1' then
              if sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0) 
                and not(mult_type = 3 and loadb_count /= -1) then
                sub_product(0) <= (others => '0');
              elsif ce_i = '1' and ((nd_i = '1' or (mult_type = 3 and loadb_count /= -1)) or swapb_i = '1') then
                sub_product(0) <= product_i;
              elsif ce_i = '1' then
              end if;
            end if;
          end if;
        end if;
      end if;
      -- Update the pipeline
      -- Clear it.
      if ((aclr_i = '1')) then
        if (c_mem_type = 2 and mult_type > 2 and (c_latency > 1 or (mult_type = 3 and c_mem_type = 2 and c_latency = 1))) then --and (c_pipeline = 0 or c_latency < 4)) then -- Change 1910b/d and 2610a.
          if (cleared = '0' and clk_i'event and clk_i = '1' and ce_i = '1') then
            sub_product(c_latency) <= (others => '0');
          elsif (cleared = '0') then
            for n in 0 to c_latency loop
              sub_product(n) <= (others => 'X');
            end loop;
          end if;
        else
          for n in 1 to c_latency loop
            sub_product(n) <= (others => '0');
          end loop;
        end if;
      elsif (clk_i'event and clk_i = '1') then
        if (sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0)) 
          and not(mult_type = 3 and loadb_count /= -1 and c_mem_type = 2) then
          if (c_mem_type = 0 or mult_type < 2 or c_sync_enable = 1 or ce_i = '1') then
            if (mult_type > 2 and c_mem_type = 2 and c_has_loadb = 1 and c_has_swapb = 0 and c_latency > 1 and loadb_count /= -1) then
              for n in c_latency-1 to c_latency loop
                sub_product(n) <= (others => '0');
              end loop;
            elsif (mult_type = 3 and loadb_count /= -1 and c_mem_type = 0 and c_latency > 3) then
              for n in 1 to c_latency loop
                sub_product(n)   <= (others => '0');
              end loop;  -- n
            elsif (mult_type /= 3 or loadb_count = -1) then
              for n in 0 to c_latency loop
                sub_product(n)   <= (others => '0');
              end loop;  -- n
            else
              for n in 1 to c_latency loop
                sub_product(n)   <= (others => '0');
              end loop;
            end if;
          elsif c_latency > 0 then
            if (mult_type > 2 and c_mem_type = 2 and c_has_loadb = 1 and c_has_swapb = 0 and c_latency > 1 and loadb_count /= -1) then
              for n in 2 to c_latency loop
                sub_product(n) <= (others => '0');
              end loop;
            else
              for n in 1 to c_latency loop
                sub_product(n)   <= (others => '0');
              end loop;  -- n
            end if;
          end if;
        elsif (ce_i = '1') then
          if (c_reg_a_b_inputs = 1 or c_has_nd = 0 or (mult_type > 1 or (mult_type < 2 and c_latency = 1 and c_has_o = 1)) or c_pipeline = 0) and c_latency > 0  then -- Temp change 2410a.
            for n in 1 to c_latency loop
              sub_product(n)   <= sub_product(n-1);
            end loop;  -- n
          else 
            -- Here the first pipeline stage gets the output of the multiplier when 
            -- clock enable is high but the result is only passed onto the second stage 
            -- when a high on new data is recieved.
            if c_latency > 1 then
              for n in 2 to c_latency loop
                sub_product(n)   <= sub_product(n-1);
              end loop;  -- n
            end if;
            if c_latency > 0 then
              for n in 1 to 1 loop
                if nd_q = '1' then
                  sub_product(n) <= sub_product(0);
                end if;
              end loop;
            end if;
          end if;
        end if;
      end if;
    end if;
   end process pipeline_output;
  
   -- Model the ready output pipeline.
   rdypipegen : process(ready, clk_i, aclr_i)
   begin
     if (c_baat = c_a_width) then
       if (ready'event or aclr_i'event) and (aclr_i = '0' or c_latency = 0) then
         sub_rdy(0) <= ready;
       elsif (aclr_i = '1') then
         for n in 0 to c_latency loop
          sub_rdy(n) <= '0';
         end loop;
       elsif clk_i'event and clk_i = '1' then
         if sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0) then
           for n in 1 to c_latency loop
             sub_rdy(n)   <= '0';
           end loop;
         elsif ce_i = '1' then
           for n in 1 to c_latency loop
             sub_rdy(n)   <= sub_rdy(n-1);
           end loop;
         end if;
       end if;
     end if;
   end process rdypipegen;
       
   -- Now drive the internal versions of the o and q outputs.
   register_output : process (sub_product, product_i, clk_i, aclr_i, sub_rdy, ready, sclr_i, ce_i)
   begin  -- process register_output
      if (c_baat = c_a_width) then
        if (aclr_i = 'X' or sclr_i = 'X' or ce_i = 'X') then -- or clk_i = 'X') then
          if (c_latency > 0 or c_reg_a_b_inputs = 1) then
            o_i <= (others => 'X');
          else
            o_i <= product_i;
          end if;
          q_i <= (others => 'X');
          rdy_i <= 'X';
        elsif c_latency = 0 then
          o_i   <= product_i;
          if (c_mem_type = 0 or mult_type < 2) then
            if (aclr_i = '1') then
              q_i <= (others => '0');
            else
              q_i   <= sub_product(0);
            end if;
          else
            q_i <= sub_product(0);
          end if;
          rdy_i <= ready;
        else
          if (c_mem_type = 2 and mult_type > 2 and c_latency > 2 and (c_pipeline = 0 or c_latency > 3)) then
            if aclr_i = '1' then
              o_i <= (others => '0');
              q_i <= (others => '0');
            else
              o_i <= sub_product(c_latency - 1);
              q_i <= sub_product(c_latency);
            end if;
          elsif (c_mem_type = 2 and mult_type > 2 and (c_latency = 2 or (c_pipeline = 1 and c_latency > 1))) then
            o_i   <= sub_product(c_latency - 1);
            if aclr_i = '1' then
              q_i <= (others => '0');
            elsif sub_product'event or aclr_i'event then
              q_i <= sub_product(c_latency);
            end if;
          else
            o_i <= sub_product(c_latency - 1);
		    q_i <= sub_product(c_latency);
          end if;
          if (c_reg_a_b_inputs = 1 or c_has_nd = 0 or mult_type > 1 or c_pipeline = 0 or c_latency < 1) 
            or (c_pipeline = 1 and c_has_nd = 1 and mult_type < 2 and c_latency = 1 and c_reg_a_b_inputs = 0 and c_has_q = 0) then
            rdy_i <= sub_rdy(c_latency);
          else
            rdy_i <= sub_rdy(c_latency - 1);
          end if;
        end if;
        if (aclr_i = 'X' or sclr_i = 'X' or ce_i = 'X') then -- or clk_i = 'X') then
          rdy_q <= 'X';
          rfd_q <= 'X';
        elsif aclr_i = '1' then
          rdy_q <= '0';
          rfd_q <= '0';
        elsif clk_i'event and clk_i = '1' then
          if sclr_i = '1' and (ce_i = '1' or c_sync_enable = 0) then
            rdy_q <= '0';
            rfd_q <= '0';
          elsif ce_i = '1' then
            rdy_q <= rdy_i;
            rfd_q <= rfd_i;
          end if;
        end if;
      end if;
   end process register_output;
   
   lastclkgen : process(clk_i)
   begin
      if (clk_i'event and clk_i = '1') then
         last_clk <= '1';
      end if;
   end process lastclkgen;

   -- loadb PROCESS
   -- If a reloadable multiplier is selected this process calculates the b input value. 
   process (aclr_i, clk_i, b, rfd_i, nd_i, nd_q)
   constant rom_addr_width : integer :=
         get_rom_addr_width(c_mem_type, bram_addr_width);
   constant sig_bits    : integer := select_val(c_baat, rom_addr_width, c_baat >= rom_addr_width);
   constant loadb_delay : integer := 2**sig_bits - 1;
   begin

     if (mult_type < 3) then
     elsif (c_has_loadb = 1) then
       if c_has_aclr /= 0 and aclr_i = '1' then
         if loadb_count /= -1 then
           loadb_count <= -2;
         end if;
       elsif (clk_i'event and (clk_i = '1')) then
         if (loadb_i = 'X') then
           loadb_count <= -3;
           if (c_has_swapb /= 0 and bank_sel = 'X') then
             bconst1 <= (others => 'X');
             bconst0 <= (others => 'X');
           elsif c_has_swapb /= 0 and bank_sel = '0' then
             bconst1 <= (others => 'X');
           else
             bconst0 <= (others => 'X');
           end if;
         elsif (c_sync_enable = c_override and c_has_sclr /= 0 and sclr_i = '1') or
            (c_has_sclr /= 0 and sclr_i = '1' and (c_has_ce = 0 or ce_i = '1')) then
           if loadb_count /= -1 then
             loadb_count <= -2;
           end if;
         elsif c_has_ce = 0 or ce_i = '1' then
           if loadb_i = '1' then
             if (c_reg_a_b_inputs = 1 or c_has_a_signed = 1 or c_a_type = c_signed) then
               loadb_count <= loadb_delay+1+c_reg_a_b_inputs;
             else
               loadb_count  <= loadb_delay;
             end if;
             load_b_value <= b_i;
             not_loaded <= 0;
           else
             if (c_has_o = 1 and mult_type = 3 and c_has_swapb = 0 and loadb_count = 2
                and loadb_delay > 2 and c_has_nd = 1) then -- and c_reg_a_b_inputs = 1 and c_latency = 0) then
             -- Load the constant early in this case.
               bconst0 <= load_b_value;
               loadb_count <= loadb_count-1;
             elsif loadb_count > 0 then
               loadb_count <= loadb_count-1;
             elsif loadb_count = 0 then
               -- Write opposite bank to the one we are currently reading
               if c_has_swapb /= 0 and bank_sel = '0' then
                 bconst1 <= load_b_value;
               else
                 bconst0 <= load_b_value;
               end if;  -- bank_sel
               --if (nd_i = '1' or (c_has_swapb = 1 or c_has_nd = 0 or c_reg_a_b_inputs = 1)) then
                 loadb_count <= -1;
               --end if;
               not_loaded  <= 0;
             elsif loadb_count = -2 then
               -- Load has been interrupted by a clear. Load constant 
               -- with X's.
               if c_has_swapb /= 0 and bank_sel = '0' then
                 bconst1 <= (others => 'X');
               else
                 bconst0 <= (others => 'X');
               end if;  -- bank_sel
               not_loaded  <= 0;
             end if;  -- loadb_count
           end if;  -- loadb
         end if;  -- c_has_ce
       end if;  -- aclr
     end if;
   end process;

   process (aclr_i, clk_i, b, rfd_i, nd_i, nd_q)
   constant rom_addr_width : integer :=
         get_rom_addr_width(c_mem_type, bram_addr_width);
   constant sig_bits    : integer := select_val(c_baat, rom_addr_width, c_baat >= rom_addr_width);
   constant loadb_delay : integer := 2**sig_bits - 1;
   variable pre_delay_comp : integer := 0;
   begin
     if (c_predelay = 0 or c_predelay = 1 or (c_predelay = 2 and loadb_delay > 1)) then
       pre_delay_comp := c_predelay;
     else
       pre_delay_comp := 1;
     end if;

     if (mult_type < 3) then
       load_done_i <= '1';
     elsif (c_has_loadb = 1) then
       if c_has_aclr /= 0 and aclr_i = '1' then
         load_done_i <= '1';
         rfd_f      <= '1';
         if loadb_count /= -1 then
           loadb_count_no_predelay <= -2;
         end if;
       elsif (clk_i'event and (clk_i = '1')) then
         if (loadb_i_nop = 'X') then
           load_done_i <= 'X';
           rfd_f <= 'X';
           loadb_count_no_predelay <= -3;
         elsif (c_sync_enable = c_override and c_has_sclr /= 0 and sclr_i = '1') or
           (c_has_sclr /= 0 and sclr_i = '1' and (c_has_ce = 0 or ce_i = '1')) then
           load_done_i <= '1';
           rfd_f      <= '1';
           if loadb_count /= -1 then
             loadb_count_no_predelay <= -2;
           end if;
         elsif c_has_ce = 0 or ce_i = '1' then
           if loadb_i_nop = '1' then
             loadb_count_no_predelay  <= loadb_delay;
             load_done_i  <= '0';
             if (c_baat = c_a_width) or (ccm_serial = 1 and c_reg_a_b_inputs = 0) then
               if(c_has_swapb = 0) then
                 rfd_f <= '0';
               else
                 rfd_f <= '1';
               end if;
             end if;
           else --if loadb = '0' then
             if (loadb_count_no_predelay > 0) then
               loadb_count_no_predelay <= loadb_count_no_predelay-1;
             elsif (loadb_count_no_predelay = 0) then
               load_done_i <= '1';
               rfd_f <= '1';
             elsif (loadb_count_no_predelay = -2) then
               load_done_i <= '1';
               rfd_f <= '1';
             end if;  -- loadb_count
           end if;  -- loadb
         end if;  -- c_has_ce
       end if;  -- aclr
     end if;
   end process;

   -- Loadb_count_dly is just loadb_count delayed by 1 clock cycle. This is necessary 
   -- to mask out the first result after a load in certain cases.
   process(aclr_i, clk_i)
   begin
     if aclr_i = '1' then
       loadb_count_dly <= -1;
       loadb_count_dly_int <= -1;
     elsif clk_i'event and clk_i = '1' and ce_i = '1' then
       loadb_count_dly_int <= loadb_count;
       --if (nd_i = '1' or (c_has_swapb = 1 or c_has_nd = 0 or c_reg_a_b_inputs = 1)) then
         loadb_count_dly <= loadb_count_dly_int;
       --end if;
     end if;
   end process; 

  process(loadb_count_dly, loadb_count_dly_int)
  begin
    if (loadb_count = -1 and loadb_count_dly_int = 0) then
      nd_i_rl <= '1';
    else
      nd_i_rl <= '0';
    end if;
  end process;
 

   process (bconst0, bconst1, bank_sel, b, load_done_i, aclr_i, clk_i, rfd_i, nd_i, nd_q)
   variable b_tmp  : std_logic_vector(c_b_width-1 downto 0) := (others => '0');
   variable b_tmp2 : std_logic_vector(c_b_width-1 downto 0) := (others => '0');
   variable msb    : integer                                := 0;
   begin
     if (mult_type < 2) then
       b_input <= b;
     elsif (mult_type < 3) or (not_loaded = 1 and loadb_i = '0') then
     else
       --if (load_done_i = '1' or c_has_swapb = 1) then
       if (loadb_count = -1 or c_has_swapb = 1) then
         if(bank_sel = '0' and mult_type > 2 and not_loaded = 0) then
           if (c_has_nd = 0) or (c_has_swapb = 1 and loadb_count < 0) then
             b_input <= bconst0;
           elsif (c_has_nd = 1 and c_has_swapb = 0) then -- and nd_i = '1') then
             b_input <= bconst0;
           end if;
         elsif(bank_sel = '1' and mult_type > 2 and not_loaded = 0 and loadb_count < 0) then -- Change 2910a.
             b_input <= bconst1;
         end if;
       else
       -- Loading.
         b_input <= (others => 'X');
       end if;
     end if;
   end process;

   -- If the multiplier has a swapb pin then this process is used to swap between the two
   -- banks of memory.
   process (aclr_i, clk_i)
   begin
     if (c_has_swapb = 0) then
       bank_sel <= '0';
     elsif c_has_swapb /= 0 then
       if c_has_aclr /= 0 and aclr_i = '1' then
         bank_sel <= '0';
         bank_sel_pre <= '0';
       elsif (clk_i'event and (clk_i = '1')) then
         if (c_reg_a_b_inputs = 0 and c_latency > 0 and c_has_swapb = 1 and (c_has_ce = 0 or ce_i ='1')) then
           bank_sel <= bank_sel_pre;
         end if;
         if (c_sync_enable = c_override and c_has_sclr /= 0 and sclr_i = '1') or
           (c_has_sclr /= 0 and sclr_i = '1' and (c_has_ce = 0 or ce_i = '1')) then
           bank_sel <= '0';
           bank_sel_pre <= '0';
         elsif c_has_ce = 0 or ce_i = '1' then
           if (c_reg_a_b_inputs = 1 or c_latency = 0 or c_baat < c_a_width) and c_has_swapb = 1  and swapb_i = '1' and loadb_count < 0 then -- Change 1910e.
             bank_sel <= not(bank_sel);
           elsif (c_reg_a_b_inputs = 0 and c_latency > 0 and c_baat = c_a_width) and c_has_swapb = 1 and swapb_i = '1' and loadb_count < 0 then --and (c_latency < 2 or c_has_nd = 0 or nd_i = '1') then -- Change 1910e.
             bank_sel_pre <= not(bank_sel_pre);
           end if;
         end if;  -- c_has_ce ...
       end if;  -- aclr
     end if;  -- c_has_swapb
   end process;

   -- Connect up the outputs.
   drive_output : process (o_i, rdy_q, rdy_i, q_i, rfd_i, load_done_i, clk_i, aclr_i)
   begin 
     if (c_has_o = 1) then
       o <= o_i;
     else
       o <= (others => 'X');
     end if;
     if (c_has_q = 1) then
       q <= q_i;
       if (c_has_nd = 1) then
         if ((c_has_rdy = 1) and ((c_pipeline = 0 or c_latency = 0) and c_reg_a_b_inputs = 0 and c_has_q = 0 and c_has_o = 1)) or (b_is_0) then
           rdy <= rdy_i;
         elsif (c_has_rdy = 1) and ((c_pipeline = 1 and c_latency /= 0) or c_reg_a_b_inputs = 1 or c_has_q = 1) then
           rdy <= rdy_q;
         end if;
       elsif (c_has_nd = 0) then
         rdy <= '1';
       else
         rdy <= 'X';
       end if;
       if (c_has_rfd = 1) then
         rfd <= rfd_i and rfd_f;
       else
         rfd <= 'X';
       end if;
       if (c_has_load_done = 1) then
         load_done <= load_done_i;
       else
         load_done <= 'X';
       end if;
     else
       q <= (others => 'X');
       if (c_has_rdy = 1) then
         if (c_has_nd = 0) then
           rdy <= '1';
         else
           rdy <= rdy_i;
         end if;
       else
         rdy <= 'X';
       end if;
       if (c_has_rfd = 1) then
         rfd <= rfd_i and rfd_f;
       else
         rfd <= 'X';
       end if;
       if (c_has_load_done = 1) then
         load_done <= load_done_i;
       else
         load_done <= 'X';
       end if;
     end if;
   end process drive_output;
   

end behavioral;

-- $RCSfile: mult_pkg_v8_0.vhd,v $ $Revision: 1.8 $ $Date: 2008/09/08 19:37:44 $
-------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY std;
USE std.textio.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v8_0.ALL;
--use xilinxcorelib.mult_const_pkg_behav_v8_0.all;
USE XilinxCoreLib.mult_gen_const_pkg_v8_0.ALL;
USE XilinxCoreLib.mult_gen_v8_0_services.ALL;

PACKAGE mult_pkg_v8_0 IS

  FUNCTION eval(condition : BOOLEAN)
    RETURN INTEGER;
  
  FUNCTION anyX(vect : STD_LOGIC_VECTOR)
    RETURN BOOLEAN;
  
  FUNCTION rat(value : STD_LOGIC)
    RETURN STD_LOGIC;

  FUNCTION all0(a : STD_LOGIC_VECTOR)
    RETURN BOOLEAN;

  FUNCTION hex_to_std_logic_vector(hexstring : STRING)
    RETURN STD_LOGIC_VECTOR;

  FUNCTION calc_latency(c_family : string;
    c_a_width        : INTEGER;
                        c_b_width        : INTEGER;
                        c_b_type         : INTEGER;
                        c_has_a_signed   : INTEGER;
                        c_reg_a_b_inputs : INTEGER;
                        c_mem_type       : INTEGER;
                        c_pipeline       : INTEGER;
                        c_mult_type      : INTEGER;
                        c_has_loadb      : INTEGER;
                        c_baat           : INTEGER;
                        c_b_value        : STRING;
                        c_a_type         : INTEGER;
                        c_has_swapb      : INTEGER;
                        c_sqm_type       : INTEGER;
                        c_has_aclr       : INTEGER;
                        c_has_sclr       : INTEGER;
                        c_has_ce         : INTEGER;
                        c_sync_enable    : INTEGER;
                        c_has_nd         : INTEGER;
                        c_has_q          : INTEGER;
                        bram_addr_width  : INTEGER
                        ) RETURN INTEGER ;

  FUNCTION calc_num_adders(c_a_width        : INTEGER;
                           c_b_width        : INTEGER;
                           c_b_type         : INTEGER;
                           c_has_a_signed   : INTEGER;
                           c_reg_a_b_inputs : INTEGER;
                           c_mem_type       : INTEGER;
                           c_pipeline       : INTEGER;
                           c_mult_type      : INTEGER;
                           c_has_loadb      : INTEGER;
                           c_baat           : INTEGER;
                           c_b_value        : STRING;
                           c_a_type         : INTEGER;
                           c_has_swapb      : INTEGER;
                           c_sqm_type       : INTEGER;
                           bram_addr_width  : INTEGER
                           ) RETURN INTEGER ;

  FUNCTION find_no_of_cycles(a_input_width, c_baat, c_mult_type : INTEGER)  --c_sqm_type, c_latency, c_pipeline : integer)
    RETURN INTEGER;

  FUNCTION "+"(a, b : STD_LOGIC_VECTOR)
    RETURN STD_LOGIC_VECTOR;
  
  FUNCTION two_comp(vect : STD_LOGIC_VECTOR)
    RETURN STD_LOGIC_VECTOR;

  FUNCTION add (a, b : STD_LOGIC_VECTOR; a_sign, b_sign : INTEGER)
    RETURN STD_LOGIC_VECTOR;

  FUNCTION add2 (a, b : STD_LOGIC_VECTOR; a_sign, b_sign : INTEGER)
    RETURN STD_LOGIC_VECTOR;

  FUNCTION calc_a_input_width(operand_width, c_has_a_signed,
                              rom_addr_width, baat, c_has_loadb : INTEGER) RETURN INTEGER;

  FUNCTION calc_num_pps(a_width, rom_addr_width : INTEGER) RETURN INTEGER;

  FUNCTION get_rom_addr_width(mem_type : INTEGER) RETURN INTEGER;

  FUNCTION log2d(x : INTEGER) RETURN INTEGER;

  FUNCTION str_to_slv(bitsin : STRING; nbits : INTEGER)
    RETURN STD_LOGIC_VECTOR;
  
  FUNCTION str_to_slv2(bitsin : STRING; nbits : INTEGER)
    RETURN STD_LOGIC_VECTOR;

  FUNCTION str_to_bv(bitsin : STRING; nbits : INTEGER) RETURN BIT_VECTOR;

  FUNCTION extend(vector : STD_LOGIC_VECTOR; bits : INTEGER; sign : INTEGER)
    RETURN STD_LOGIC_VECTOR;

  FUNCTION find_ccm_b_width(bitsin : STD_LOGIC_VECTOR; b_width, mult_type, has_load : INTEGER)
    RETURN INTEGER;

  FUNCTION bitstorep_bv(a_value    : BIT_VECTOR;
                        a_type     : INTEGER;
                        a_positive : BOOLEAN) RETURN NATURAL;

  FUNCTION check_18(has_a_signed, a_width, a_type, b_width, b_type : INTEGER)
    RETURN INTEGER;

  FUNCTION parm_calc_num_pps(
    c_mult_type    : INTEGER;
    c_a_width      : INTEGER;
    c_a_type       : INTEGER;
    c_b_width      : INTEGER;
    c_b_type       : INTEGER;
    c_has_a_signed : INTEGER
    ) RETURN INTEGER;


  FUNCTION select_val(i0 : INTEGER; i1 : INTEGER; sel : BOOLEAN)
    RETURN INTEGER;

  FUNCTION get_rom_addr_width(mem_type        : INTEGER;
                              bram_addr_width : INTEGER) RETURN INTEGER;

  FUNCTION bitstorep_string(a_value : STRING;
                            a_type  : INTEGER) RETURN NATURAL;

  FUNCTION calc_shift_bits(b_value    : STRING;
                           b_constant : INTEGER;
                           b_type     : INTEGER) RETURN INTEGER;

  FUNCTION calc_reqd_b_value(b_value      : STRING;
                             b_width      : INTEGER;
                             b_type       : INTEGER;
                             reqd_b_width : INTEGER) RETURN STRING;

END mult_pkg_v8_0;

PACKAGE BODY mult_pkg_v8_0 IS

  FUNCTION calc_shift_bits(b_value    : STRING;
                           b_constant : INTEGER;
                           b_type     : INTEGER) RETURN INTEGER IS
    VARIABLE BIT        : INTEGER;
    VARIABLE shift_bits : INTEGER;
  BEGIN
    shift_bits := 0;

    IF b_constant /= 0 THEN
      BIT := b_value'high;

      WHILE (BIT >= b_value'low) LOOP
        IF b_value(BIT) = '0' THEN
          shift_bits := shift_bits + 1;
        ELSE
          EXIT;
        END IF;
        BIT := BIT - 1;
      END LOOP;
      
    END IF;

    IF shift_bits >= b_value'high THEN
      shift_bits := 0;                  -- All zeroes value
    END IF;

    IF (b_type = c_signed) THEN
      shift_bits := 0;
    END IF;

    RETURN shift_bits;
    
  END calc_shift_bits;

  FUNCTION all0(a : STD_LOGIC_VECTOR)
    RETURN BOOLEAN IS
    VARIABLE z : STD_LOGIC_VECTOR(a'length-1 DOWNTO 0) := (OTHERS => '0');
  BEGIN
    RETURN (a = z);
  END all0;

  FUNCTION str_to_bv(bitsin : STRING; nbits : INTEGER) RETURN BIT_VECTOR IS
    VARIABLE ret     : BIT_VECTOR(nbits-1 DOWNTO 0);
    VARIABLE bit_num : INTEGER;
  BEGIN
    ret := (OTHERS => '0');

    IF (bitsin'length = 0) THEN         -- Make all '0's
      RETURN ret;
    END IF;

    bit_num := 0;

    --  FOR i IN bitsin'REVERSE_RANGE LOOP -- doesn't work with XCC
    FOR i IN bitsin'high DOWNTO bitsin'low LOOP
      
      IF bitsin(i) = '1' THEN
        ret(bit_num) := '1';
      ELSIF bitsin(i) = '0' THEN
        ret(bit_num) := '0';
      ELSE
      END IF;

      bit_num := bit_num + 1;

      IF bit_num >= nbits THEN
        EXIT;  -- Ignore ms characters in STRING if STRING is longer than BV
      END IF;
    END LOOP;

    RETURN ret;
    
  END str_to_bv;

  FUNCTION bitstorep_bv(a_value    : BIT_VECTOR;
                        a_type     : INTEGER;
                        a_positive : BOOLEAN) RETURN NATURAL IS
    VARIABLE return_value : INTEGER;
  BEGIN
    return_value := a_value'length;

    IF a_type = c_unsigned THEN

      -- a_value represents an unsigned number
      FOR i IN a_value'high DOWNTO a_value'low LOOP
        IF a_value(i) = '1' THEN
          EXIT;                         -- EXIT when the msb is found
        ELSIF a_value(i) = '0' THEN
          return_value := return_value - 1;
        END IF;
      END LOOP;
      
    ELSE

      -- a_value represents a signed number
      
      IF a_positive THEN
        -- Look for ms '1' then add 1 for a leading 0
        FOR i IN a_value'high DOWNTO a_value'low LOOP
          IF a_value(i) = '1' THEN
            return_value := return_value + 1;
            EXIT;
          ELSE
            return_value := return_value - 1;
          END IF;
        END LOOP;
      ELSE
        -- Look for ms '1' followed by a '0'
        FOR i IN a_value'high DOWNTO a_value'low LOOP
          IF a_value(i) = '1' THEN
            
            IF i > a_value'low THEN
              IF a_value(i-1) = '0' THEN
                EXIT;                   -- EXIT when the msb is found
                ELSE
                  return_value := return_value - 1;
              END IF;
            ELSE
              EXIT;                     -- EXIT when end of STRING reached
            END IF;
            
          ELSE
            return_value := return_value - 1;
          END IF;
        END LOOP;
        
      END IF;  -- a_positive
      
    END IF;

    --IF a_type=c_unsigned AND return_value <= 0 THEN
    IF return_value <= 0 THEN
      RETURN 1;
    ELSIF a_type /= c_unsigned AND return_value <= 2 THEN
      RETURN 2;  -- always need at least 2 bits to represent signed numbers
    ELSE
      RETURN return_value;
    END IF;

  END bitstorep_bv;

-- Converts hex string to a standard logic vector.
  FUNCTION hex_to_std_logic_vector(hexstring : STRING)
    RETURN STD_LOGIC_VECTOR IS
    CONSTANT length : INTEGER := hexstring'length;
    VARIABLE bitval : STD_LOGIC_VECTOR((length*4)-1 DOWNTO 0);
    VARIABLE posn   : INTEGER := bitval'left;
    VARIABLE ch     : CHARACTER;
  BEGIN
    FOR i IN 1 TO length LOOP
      ch := hexstring(i);
      CASE ch IS
        WHEN '0'       => bitval(posn DOWNTO posn-3) := "0000";
        WHEN '1'       => bitval(posn DOWNTO posn-3) := "0001";
        WHEN '2'       => bitval(posn DOWNTO posn-3) := "0010";
        WHEN '3'       => bitval(posn DOWNTO posn-3) := "0011";
        WHEN '4'       => bitval(posn DOWNTO posn-3) := "0100";
        WHEN '5'       => bitval(posn DOWNTO posn-3) := "0101";
        WHEN '6'       => bitval(posn DOWNTO posn-3) := "0110";
        WHEN '7'       => bitval(posn DOWNTO posn-3) := "0111";
        WHEN '8'       => bitval(posn DOWNTO posn-3) := "1000";
        WHEN '9'       => bitval(posn DOWNTO posn-3) := "1001";
        WHEN 'A' | 'a' => bitval(posn DOWNTO posn-3) := "1010";
        WHEN 'B' | 'b' => bitval(posn DOWNTO posn-3) := "1011";
        WHEN 'C' | 'c' => bitval(posn DOWNTO posn-3) := "1100";
        WHEN 'D' | 'd' => bitval(posn DOWNTO posn-3) := "1101";
        WHEN 'E' | 'e' => bitval(posn DOWNTO posn-3) := "1110";
        WHEN 'F' | 'f' => bitval(posn DOWNTO posn-3) := "1111";
        WHEN OTHERS    => ASSERT false
                            REPORT "Invalid hex value in MIF file" SEVERITY error;
                          bitval(posn DOWNTO posn-3) := "XXXX";
      END CASE;
      posn := posn - 4;
    END LOOP;
    RETURN bitval;
  END hex_to_std_logic_vector;

  FUNCTION select_val(i0 : INTEGER; i1 : INTEGER; sel : BOOLEAN) RETURN INTEGER IS
  BEGIN
    IF sel THEN
      RETURN i1;
    ELSE
      RETURN i0;
    END IF;  -- sel
  END select_val;
  
  FUNCTION calc_num_adders(c_a_width        : INTEGER;
                           c_b_width        : INTEGER;
                           c_b_type         : INTEGER;
                           c_has_a_signed   : INTEGER;
                           c_reg_a_b_inputs : INTEGER;
                           c_mem_type       : INTEGER;
                           c_pipeline       : INTEGER;
                           c_mult_type      : INTEGER;
                           c_has_loadb      : INTEGER;
                           c_baat           : INTEGER;
                           c_b_value        : STRING;
                           c_a_type         : INTEGER;
                           c_has_swapb      : INTEGER;
                           c_sqm_type       : INTEGER;
                           bram_addr_width  : INTEGER
                           ) RETURN INTEGER IS

    CONSTANT real_a_width   : INTEGER := (c_a_width-1) - ((c_a_width-1)*c_sqm_type) + 1;
    CONSTANT rom_addr_width : INTEGER := get_rom_addr_width(c_mem_type, bram_addr_width);

    CONSTANT a_input_width : INTEGER :=
      calc_a_input_width(real_a_width, c_has_a_signed, rom_addr_width, c_baat, c_has_loadb);

    CONSTANT b_is_0 : BOOLEAN := c_b_width = 1 AND c_b_value(c_b_value'high) = '0';

    CONSTANT b_is_1 : BOOLEAN := c_b_type = c_unsigned AND
                                 c_b_width = 1 AND c_b_value(c_b_value'high) = '1';

    CONSTANT need_addsub : BOOLEAN := c_has_loadb = 1 AND (c_a_type /= c_unsigned OR c_has_a_signed /= 0);

    --CONSTANT a_is_signed : BOOLEAN := c_a_type/=c_unsigned OR c_has_a_signed/=0;

    VARIABLE num_adders      : INTEGER;
    VARIABLE latency         : INTEGER := 0;
    VARIABLE need_0_minus_pp : BOOLEAN;
    VARIABLE num_pps         : INTEGER;

  BEGIN
    
    num_pps         := calc_num_pps(a_input_width, rom_addr_width);  ---1;
    need_0_minus_pp := need_addsub AND num_pps <= 1;
    num_adders      := select_val(num_pps-1, 1, need_0_minus_pp);
    RETURN num_adders;
  END calc_num_adders;

  FUNCTION calc_latency(c_family : string;
    c_a_width        : INTEGER;
                        c_b_width        : INTEGER;
                        c_b_type         : INTEGER;
                        c_has_a_signed   : INTEGER;
                        c_reg_a_b_inputs : INTEGER;
                        c_mem_type       : INTEGER;
                        c_pipeline       : INTEGER;
                        c_mult_type      : INTEGER;
                        c_has_loadb      : INTEGER;
                        c_baat           : INTEGER;
                        c_b_value        : STRING;
                        c_a_type         : INTEGER;
                        c_has_swapb      : INTEGER;
                        c_sqm_type       : INTEGER;
                        c_has_aclr       : INTEGER;
                        c_has_sclr       : INTEGER;
                        c_has_ce         : INTEGER;
                        c_sync_enable    : INTEGER;
                        c_has_nd         : INTEGER;
                        c_has_q          : INTEGER;
                        bram_addr_width  : INTEGER
                        ) RETURN INTEGER IS

    CONSTANT real_a_width   : INTEGER := (c_a_width-1) - ((c_a_width-1)*c_sqm_type) + 1;
    CONSTANT rom_addr_width : INTEGER := get_rom_addr_width(c_mem_type, bram_addr_width);

    CONSTANT a_input_width : INTEGER :=
      calc_a_input_width(real_a_width, c_has_a_signed, rom_addr_width, c_baat, c_has_loadb);

    CONSTANT b_is_0 : BOOLEAN := c_b_width = 1 AND c_b_value(c_b_value'high) = '0';

    CONSTANT b_is_1 : BOOLEAN := c_b_type = c_unsigned AND
                                 c_b_width = 1 AND c_b_value(c_b_value'high) = '1';

    CONSTANT need_addsub : BOOLEAN := c_has_loadb = 1 AND (c_a_type /= c_unsigned OR c_has_a_signed /= 0);

    --CONSTANT a_is_signed : BOOLEAN := c_a_type/=c_unsigned OR c_has_a_signed/=0;

    VARIABLE num_adders      : INTEGER;
    VARIABLE latency         : INTEGER := 0;
    VARIABLE need_0_minus_pp : BOOLEAN;
    VARIABLE num_pps         : INTEGER;

  BEGIN
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

    RETURN get_mult_gen_v8_0_registers(c_family, c_a_width, c_b_width, c_b_type, c_has_a_signed, c_reg_a_b_inputs, c_mem_type, c_pipeline, c_mult_type, c_has_loadb, c_baat, c_b_value, c_a_type, c_has_swapb, c_sqm_type, c_has_aclr, c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, bram_addr_width) - c_reg_a_b_inputs;
    
  END calc_latency;

  FUNCTION find_no_of_cycles(a_input_width, c_baat, c_mult_type : INTEGER)  --c_sqm_type, c_latency, c_pipeline : integer)

    RETURN INTEGER IS
    VARIABLE l : INTEGER := 1;
  BEGIN
    IF c_baat < a_input_width THEN
      l := l + (a_input_width / c_baat);
      IF (a_input_width REM c_baat) /= 0 THEN
        l := l + 1;
      END IF;
    ELSE
      l := 4;
    END IF;
    --if (c_sqm_type = 1 and (c_pipeline = 0 or c_latency = 0)) then
    --        l := l - 1 ;
    --end if ;
    RETURN l;
  END find_no_of_cycles;

-- Addition function that correctly handles when inputs are 'X'.
  FUNCTION add (a, b : STD_LOGIC_VECTOR; a_sign, b_sign : INTEGER)
    RETURN STD_LOGIC_VECTOR IS
    CONSTANT a_width   : INTEGER := a'length;
    CONSTANT b_width   : INTEGER := b'length;
    CONSTANT max_width : INTEGER := eval(a_width >= b_width)*a_width
                                    + eval(b_width > a_width)*b_width;
    VARIABLE sa     : STD_LOGIC_VECTOR(max_width-1 DOWNTO 0);  --:=
    --extend(a, max_width+1, a_sign);
    VARIABLE sb     : STD_LOGIC_VECTOR(max_width-1 DOWNTO 0);  --:=
    --extend(b, max_width+1, b_sign);
    VARIABLE retval : STD_LOGIC_VECTOR(max_width-1 DOWNTO 0);
    VARIABLE carry  : STD_LOGIC := '0';
  BEGIN  -- plus
    --if (anyX(sa) or anyX(sb)) then
    --  retval := (others => 'X');
    --if (all0(sa)) then
    --  retval := sb;
    --elsif (all0(sb)) then
    --  retval := sa;
    --else
    IF (b_sign = 0) THEN
      sa := extend(a, max_width, 0);
    ELSE
      sa := extend(a, max_width, a_sign);
    END IF;
    sb := extend(b, max_width, b_sign);

    FOR i IN 0 TO max_width-1 LOOP
      IF (sa(i) = 'X' OR sb(i) = 'X') THEN
        retval(i) := 'X';
        carry     := 'X';
      ELSIF (carry = 'X') THEN
        retval(i) := 'X';
        carry     := '0';
      ELSE
        retval(i) := sa(i) XOR sb(i) XOR carry;
        carry     := (sa(i) AND sb(i)) OR
                     (sa(i) AND carry) OR
                     (sb(i) AND carry);
      END IF;
    END LOOP;  -- i
    --end if;    
    RETURN retval;
  END add;

  FUNCTION add2 (a, b : STD_LOGIC_VECTOR; a_sign, b_sign : INTEGER)
    RETURN STD_LOGIC_VECTOR IS
    CONSTANT a_width   : INTEGER := a'length;
    CONSTANT b_width   : INTEGER := b'length;
    CONSTANT max_width : INTEGER := eval(a_width >= b_width)*a_width
                                    + eval(b_width > a_width)*b_width;
    VARIABLE sa     : STD_LOGIC_VECTOR(max_width DOWNTO 0);  --:=
    --extend(a, max_width+1, a_sign);
    VARIABLE sb     : STD_LOGIC_VECTOR(max_width DOWNTO 0);  --:=
    --extend(b, max_width+1, b_sign);
    VARIABLE retval : STD_LOGIC_VECTOR(max_width DOWNTO 0);
    VARIABLE carry  : STD_LOGIC := '0';
  BEGIN  -- plus
    IF (b_sign = 0) THEN
      sa := extend(a, max_width, 0);
    ELSE
      sa := extend(a, max_width+1, a_sign);
    END IF;
    sb := extend(b, max_width+1, b_sign);

    FOR i IN 0 TO max_width LOOP
      IF (sa(i) = 'X' OR sb(i) = 'X') THEN
        retval(i) := 'X';
        carry     := 'X';
      ELSIF (carry = 'X') THEN
        retval(i) := 'X';
        carry     := '0';
      ELSE
        retval(i) := sa(i) XOR sb(i) XOR carry;
        carry     := (sa(i) AND sb(i)) OR
                     (sa(i) AND carry) OR
                     (sb(i) AND carry);
      END IF;
    END LOOP;  -- i
    --end if;    
    RETURN retval;
  END add2;

-- Addition function that correctly handles when inputs are 'X'.
  FUNCTION "+"(a, b : STD_LOGIC_VECTOR)
    RETURN STD_LOGIC_VECTOR IS
    CONSTANT a_width   : INTEGER := a'length;
    CONSTANT b_width   : INTEGER := b'length;
    CONSTANT max_width : INTEGER := eval(a_width >= b_width)*a_width
                                    + eval(b_width > a_width)*b_width;
    VARIABLE sa : STD_LOGIC_VECTOR(max_width-1 DOWNTO 0) :=
      extend(a, max_width, 0);
    VARIABLE sb : STD_LOGIC_VECTOR(max_width-1 DOWNTO 0) :=
      extend(b, max_width, 0);
    VARIABLE retval : STD_LOGIC_VECTOR(max_width-1 DOWNTO 0);
    VARIABLE carry  : STD_LOGIC := '0';
  BEGIN  -- plus
    IF (anyX(sa) OR anyX(sb)) THEN
      retval := (OTHERS => 'X');
    ELSIF (all0(sa)) THEN
      retval := sb;
    ELSIF (all0(sb)) THEN
      retval := sa;
    ELSE
      FOR i IN 0 TO max_width-1 LOOP
        retval(i) := sa(i) XOR sb(i) XOR carry;
        carry     := (sa(i) AND sb(i)) OR
                     (sa(i) AND carry) OR
                     (sb(i) AND carry);
      END LOOP;  -- i
    END IF;
    RETURN retval;
  END "+";

  FUNCTION calc_a_input_width(operand_width, c_has_a_signed,
                              rom_addr_width, baat, c_has_loadb : INTEGER) RETURN INTEGER IS
    VARIABLE effective_op_width : INTEGER;
    VARIABLE a_input_width      : INTEGER;
  BEGIN
    IF (baat < operand_width) THEN
      a_input_width := baat;
    ELSE
      a_input_width := operand_width;
    END IF;
    --if (baat < operand_width) then
    --  return baat ;
    --end if ;
    IF (c_has_a_signed = 0 OR c_has_loadb = 1) THEN
      effective_op_width := a_input_width;
    ELSE
      -- Allow extra input for 'a_signed'
      effective_op_width := a_input_width + 1;
    END IF;

    IF (effective_op_width MOD rom_addr_width = 0) THEN
      RETURN effective_op_width;
    ELSE
      RETURN effective_op_width + rom_addr_width -
        (effective_op_width MOD rom_addr_width);
    END IF;
  END calc_a_input_width;

  FUNCTION calc_num_pps(a_width, rom_addr_width : INTEGER) RETURN INTEGER IS
  BEGIN
    IF (a_width MOD rom_addr_width /= 0) THEN
      RETURN (a_width / rom_addr_width) + 1;
    ELSE
      RETURN (a_width / rom_addr_width);
    END IF;
  END calc_num_pps;
  FUNCTION check_18(has_a_signed, a_width, a_type, b_width, b_type : INTEGER)
    RETURN INTEGER IS
    VARIABLE case_18                      : BOOLEAN := false;
    VARIABLE a_w, b_w, a_t, b_t, t_w, t_t : INTEGER;
    CONSTANT mult_in                      : INTEGER := 18;
    CONSTANT mult_in_unsigned             : INTEGER := 17;
  BEGIN
    a_w := a_width;
    b_w := b_width;
    a_t := a_type;
    b_t := b_type;
    IF(has_a_signed = 1) THEN
      a_w := a_w + 1;
    END IF;
    IF(a_t = c_pin) THEN
      a_t := c_signed;
    END IF;

    IF (a_w < b_w) THEN
      t_w := a_w;
      a_w := b_w;
      b_w := t_w;

      t_t := a_t;
      a_t := b_t;
      b_t := t_t;
    END IF;

    case_18 :=
      (
        (a_t = c_signed AND a_w REM mult_in_unsigned = 1) AND
        (
          (b_type = c_signed AND b_w <= a_w) OR
          (b_type = c_unsigned AND b_width < a_w)
          )
        ) ;

    IF(case_18) THEN
      RETURN 1;
    END IF;
    RETURN 0;
  END check_18;

  FUNCTION parm_calc_num_pps(
    c_mult_type    : INTEGER;
    c_a_width      : INTEGER;
    c_a_type       : INTEGER;
    c_b_width      : INTEGER;
    c_b_type       : INTEGER;
    c_has_a_signed : INTEGER
    ) RETURN INTEGER IS
    CONSTANT mult18      : INTEGER := check_18(c_has_a_signed, c_a_width, c_a_type, c_b_width, c_b_type);
    CONSTANT a_ext_width : INTEGER := select_val(c_a_width, c_a_width +1, (c_has_a_signed = 1));
    CONSTANT a_prods     : INTEGER := (a_ext_width-1)/(17 + mult18) + 1;  -- number of products involving a !!! a_signed
    CONSTANT b_prods     : INTEGER := (c_b_width-1)/(17 + mult18) + 1;  -- number of products involving b

    CONSTANT a_count : INTEGER := (a_ext_width+1)/2;
    CONSTANT b_count : INTEGER := (c_b_width+1)/2;
  BEGIN
    IF(c_mult_type = V2_PARALLEL) THEN
--          if(check_18(c_has_a_signed, c_a_width, c_a_type, c_b_width, c_b_type) = 1) then
--             return 1;
--          else
      RETURN a_prods * b_prods;
      --end if;
    ELSIF (c_mult_type = PARALLEL) THEN
      -- larger width is always used as the a input port
      -- width within the multiplier
      IF(a_ext_width <= c_b_width) THEN
        RETURN a_count;
      ELSE
        RETURN b_count;
      END IF;
    END IF;
    RETURN 0;
  END parm_calc_num_pps;


  FUNCTION get_rom_addr_width(mem_type : INTEGER) RETURN INTEGER IS
  BEGIN
    IF mem_type = c_distributed THEN
      RETURN 4;
    ELSE
      RETURN 8;
    END IF;
  END get_rom_addr_width;

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

  FUNCTION str_to_slv(bitsin : STRING; nbits : INTEGER) RETURN STD_LOGIC_VECTOR IS

    -- STRING types RANGE from 1 to len!!!
    VARIABLE ret     : STD_LOGIC_VECTOR(nbits-1 DOWNTO 0);
    VARIABLE bit_num : INTEGER;
  BEGIN
    
    ret := (OTHERS => '0');

    IF (bitsin = "") THEN               -- Make all '0's
      RETURN ret;
    END IF;

    bit_num := 0;

    FOR i IN bitsin'reverse_range LOOP
      
      IF bitsin(i) = '1' THEN
        ret(bit_num) := '1';
      ELSIF bitsin(i) = '0' THEN
        ret(bit_num) := '0';
      ELSIF (bitsin(i) = 'U' OR bitsin(i) = 'u') THEN
        ret(bit_num) := 'U';
      ELSIF (bitsin(i) = 'X' OR bitsin(i) = 'x') THEN
        ret(bit_num) := 'X';
      ELSIF (bitsin(i) = 'Z' OR bitsin(i) = 'z') THEN
        ret(bit_num) := 'Z';
      ELSIF (bitsin(i) = 'W' OR bitsin(i) = 'w') THEN
        ret(bit_num) := 'W';
      ELSIF (bitsin(i) = 'L' OR bitsin(i) = 'l') THEN
        ret(bit_num) := 'L';
      ELSIF (bitsin(i) = 'H' OR bitsin(i) = 'h') THEN
        ret(bit_num) := 'H';
      ELSIF (bitsin(i) = '-') THEN
        ret(bit_num) := '-';
      ELSE
        ASSERT false
          REPORT "ERROR: invalid character passed to str_to_slv function." &
          " STRING passed in was: " & bitsin
          SEVERITY failure;
      END IF;

      bit_num := bit_num + 1;

      IF bit_num >= nbits THEN
        EXIT;  -- Ignore ms characters in STRING if STRING is longer than BV
      END IF;
    END LOOP;

    RETURN ret;
    
  END str_to_slv;

  FUNCTION str_to_slv2(bitsin : STRING; nbits : INTEGER) RETURN STD_LOGIC_VECTOR IS

    -- STRING types RANGE from 1 to len!!!
    VARIABLE ret     : STD_LOGIC_VECTOR(nbits-1 DOWNTO 0);
    VARIABLE bit_num : INTEGER;
  BEGIN
    
    ret := (OTHERS => '0');

    IF (bitsin = "") THEN               -- Make all '0's
      RETURN ret;
    END IF;

    bit_num := 0;

    FOR i IN bitsin'reverse_range LOOP
      
      IF bitsin(i) = '1' THEN
        ret(bit_num) := '1';
      ELSIF bitsin(i) = '0' THEN
        ret(bit_num) := '0';
      ELSIF (bitsin(i) = 'U' OR bitsin(i) = 'u') THEN
        ret(bit_num) := 'U';
      ELSIF (bitsin(i) = 'X' OR bitsin(i) = 'x') THEN
        ret(bit_num) := 'X';
      ELSIF (bitsin(i) = 'Z' OR bitsin(i) = 'z') THEN
        ret(bit_num) := 'Z';
      ELSIF (bitsin(i) = 'W' OR bitsin(i) = 'w') THEN
        ret(bit_num) := 'W';
      ELSIF (bitsin(i) = 'L' OR bitsin(i) = 'l') THEN
        ret(bit_num) := 'L';
      ELSIF (bitsin(i) = 'H' OR bitsin(i) = 'h') THEN
        ret(bit_num) := 'H';
      ELSIF (bitsin(i) = '-') THEN
        ret(bit_num) := '-';
      ELSE
        ASSERT false
          REPORT "ERROR: invalid character passed to str_to_slv function." &
          " STRING passed in was: " & bitsin
          SEVERITY failure;
      END IF;

      bit_num := bit_num + 1;

      IF bit_num >= nbits THEN
        EXIT;  -- Ignore ms characters in STRING if STRING is longer than BV
      END IF;
    END LOOP;

    RETURN ret;
    
  END str_to_slv2;


  FUNCTION find_ccm_b_width(bitsin : STD_LOGIC_VECTOR; b_width, mult_type, has_load : INTEGER) RETURN INTEGER IS
    VARIABLE b_in : STD_LOGIC_VECTOR(bitsin'length-1 DOWNTO 0) := bitsin;
    VARIABLE ret  : INTEGER                                    := 1;
    -- STRING types RANGE from 1 to len!!!
  BEGIN
    
--    IF (mult_type > 1) AND (has_load = 0) AND NOT(anyX(bitsin)) THEN -- edited andreww 24/08
    IF (mult_type > 1 AND mult_type < 5) AND (has_load = 0) AND NOT(anyX(bitsin)) THEN    
      FOR i IN 0 TO (bitsin'length-1) LOOP
        IF b_in(i) = '1' THEN ret := i+1;
        END IF;
      END LOOP;
    ELSE
      ret := b_width;
    END IF;

    RETURN ret;
  END find_ccm_b_width;


  FUNCTION extend(vector : STD_LOGIC_VECTOR; bits : INTEGER; sign : INTEGER)
    RETURN STD_LOGIC_VECTOR IS

    CONSTANT return_width : INTEGER := bits;  -- greatest2( bits, vector'LENGTH );
    VARIABLE return_value : STD_LOGIC_VECTOR(return_width-1 DOWNTO 0);

  BEGIN

    FOR i IN 0 TO return_width-1 LOOP
      IF i <= vector'length-1 THEN
        return_value(i) := vector(i);
      ELSIF (sign = 0) THEN
        return_value(i) := vector(vector'high);
      ELSIF (sign = 1) THEN
        return_value(i) := '0';
      END IF;
    END LOOP;

    RETURN return_value;

  END extend;

  FUNCTION get_rom_addr_width(mem_type        : INTEGER;
                              bram_addr_width : INTEGER) RETURN INTEGER IS
  BEGIN
    IF mem_type = c_distributed THEN
      RETURN 4;
    ELSE
      --ASSERT (bram_addr_width=8 OR bram_addr_width=9)
      --  REPORT "ERROR: CCM - bram_addr_width must be set to 8 or 9." & new_line
      --  SEVERITY ERROR;
      
      IF bram_addr_width = 9 THEN
        RETURN 9;
      ELSE
        RETURN 8;
      END IF;  -- bram_addr_width
      
    END IF;
  END get_rom_addr_width;

  FUNCTION bitstorep_string(a_value : STRING;
                            a_type  : INTEGER) RETURN NATURAL IS
    VARIABLE return_value : INTEGER;
  BEGIN
    return_value := a_value'length;

    IF a_type = c_unsigned THEN

      -- a_value represents an unsigned number
      FOR i IN a_value'range LOOP
        IF a_value(i) = '1' THEN
          EXIT;                         -- EXIT when the msb is found
        ELSIF a_value(i) = '0' THEN
          return_value := return_value - 1;
        ELSE
        END IF;
      END LOOP;
      
    ELSE

      -- a_value represents a signed number
      -- Look for ms '1' followed by a '0'
      FOR i IN a_value'range LOOP
        IF a_value(i) = '1' THEN
          
          IF i < a_value'high THEN
            IF a_value(i+1) = '0' THEN
              EXIT;                     -- EXIT when the msb is found
              ELSE
                return_value := return_value - 1;
            END IF;
          ELSE
            EXIT;                       -- EXIT when end of STRING reached
          END IF;
          
        ELSIF a_value(i) = '0' THEN
          return_value := return_value - 1;
        ELSE
        END IF;
      END LOOP;
      
    END IF;

    IF return_value <= 0 THEN
      RETURN 1;
    ELSE
      RETURN return_value;
    END IF;

  END bitstorep_string;

  FUNCTION calc_reqd_b_value(b_value      : STRING;
                             b_width      : INTEGER;
                             b_type       : INTEGER;
                             reqd_b_width : INTEGER) RETURN STRING IS
    CONSTANT b_lsb        : INTEGER := b_value'high;
    VARIABLE b_bit        : INTEGER;
    VARIABLE reqd_b_value : STRING(1 TO reqd_b_width);
  BEGIN
    
    FOR BIT IN 1 TO reqd_b_width LOOP
      b_bit := BIT + b_lsb - reqd_b_width;
      IF b_bit > 0 THEN
        reqd_b_value(BIT) := b_value(b_bit);
      ELSE
        IF b_type = c_signed THEN
          reqd_b_value(BIT) := b_value(1);
        ELSE
          reqd_b_value(BIT) := '0';
        END IF;  -- b_type
      END IF;  -- b_bit
    END LOOP;

    RETURN reqd_b_value;
  END calc_reqd_b_value;

  FUNCTION eval(condition : BOOLEAN)
    RETURN INTEGER IS

  BEGIN

    IF condition = true THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;

  END eval;

  FUNCTION anyX(vect : STD_LOGIC_VECTOR)

    RETURN BOOLEAN IS

  BEGIN

    FOR i IN vect'range LOOP
      IF (rat(vect(i)) = 'X') THEN
        RETURN true;
      END IF;
    END LOOP;

    RETURN false;

  END anyX;

  FUNCTION rat(value : STD_LOGIC)
    RETURN STD_LOGIC IS

  BEGIN

    CASE value IS
      WHEN '0' | '1' => RETURN value;
      WHEN 'H'       => RETURN '1';
      WHEN 'L'       => RETURN '0';
      WHEN OTHERS    => RETURN 'X';
    END CASE;

  END rat;

  FUNCTION two_comp(vect : STD_LOGIC_VECTOR)
    RETURN STD_LOGIC_VECTOR IS

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


END mult_pkg_v8_0;


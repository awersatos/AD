-------------------------------------------------------------------------------
-- $Id: iputils_conv.vhd,v 1.16 2008/09/08 20:08:59 akennedy Exp $
-------------------------------------------------------------------------------
--
-- IP Utilities Library - Data Type Conversion Functions
--
-------------------------------------------------------------------------------
--                                                                       
-- This file is owned and controlled by Xilinx and must be used solely   
-- for design, simulation, implementation and creation of design files   
-- limited to Xilinx devices or technologies. Use with non-Xilinx        
-- devices or technologies is expressly prohibited and immediately       
-- terminates your license.                                              
--                                                                       
-- Xilinx products are not intended for use in life support              
-- appliances, devices, or systems. Use in such applications is          
-- expressly prohibited.                                                 
--
--            **************************************
--            ** Copyright (C) 2000, Xilinx, Inc. **
--            ** All Rights Reserved.             **
--            **************************************
--
-------------------------------------------------------------------------------
--
-- This file contains the following packages:
--   iputils_conv - data conversions between different data types
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
---- iputils_conv
----   data conversions between different data types
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
LIBRARY std;
USE std.textio.ALL;

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE iputils_conv IS
	
	FUNCTION rat( value : std_logic )
	RETURN std_logic;
	
    FUNCTION std_logic_vector_2_string(v : STD_LOGIC_VECTOR)
    RETURN STRING;

    FUNCTION std_logic_2_string(v : STD_LOGIC)
    RETURN STRING; 
 
    FUNCTION std_logic_vector_2_int(vect : std_logic_vector)
	RETURN integer;
	
	FUNCTION two_comp(vect : std_logic_vector)
	RETURN std_logic_vector;
	
	FUNCTION int_2_std_logic_vector( value, bitwidth : integer )
	RETURN std_logic_vector;
	
	FUNCTION std_logic_vector_2_posint(vect : std_logic_vector)
	RETURN integer;

     FUNCTION int_2_boolean(int: integer)
       RETURN BOOLEAN;

     FUNCTION int_2_string(val : integer; str_length :integer)
       RETURN string;

     FUNCTION bint_2_sl (X : integer)
       RETURN std_logic;
        
     FUNCTION str_to_slv_0(bitsin : string; nbits : integer)
       RETURN std_logic_vector;

  FUNCTION number_of_bits (data_value : integer)
    RETURN integer;

  FUNCTION number_of_digits (data_value : integer; radix : integer)
    RETURN integer;

  FUNCTION conv_int_to_new_radix(number : integer; target_str_len : integer; target_radix : integer)
    RETURN string;
        
  FUNCTION int_2_hex( value, bitwidth : INTEGER )
    RETURN STRING;

  FUNCTION bin_2_hex_string(bin: string)
    RETURN string;

  FUNCTION hexstr_to_std_logic_vec( arg1 : string; size : integer )
    RETURN std_logic_vector;        


END iputils_conv;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
---- PACKAGE CONTENTS DEFINED AFTER THIS POINT
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


PACKAGE BODY iputils_conv IS
	
	--This function included to support other functions in this package
	FUNCTION rat( value : std_logic )
		RETURN std_logic IS
		
	BEGIN
		
		CASE value IS
			WHEN '0' | '1' => RETURN value;
			WHEN 'H'       => RETURN '1';
			WHEN 'L'       => RETURN '0';
			WHEN OTHERS    => RETURN 'X';
		END CASE;
		
	END rat;
	
  ----------------------------------------------------------------------------
  -- This function converts a a standard logic vector to a string.
  ----------------------------------------------------------------------------
  FUNCTION std_logic_vector_2_string(v : STD_LOGIC_VECTOR) RETURN STRING IS
    VARIABLE str                       : STRING(1 TO v'high+1);
    CONSTANT ss                        : STRING(1 TO 3) := "01X";
  BEGIN
    FOR i IN v'high DOWNTO v'low LOOP
      IF (v(i) = '0') THEN
        str(v'high-i+1)                                 := ss(1);
      ELSIF (v(i) = '1') THEN
        str(v'high-i+1)                                 := ss(2);
      ELSE
        str(v'high-i+1)                                 := ss(3);
      END IF;
    END LOOP;
    RETURN str;
  END std_logic_vector_2_string;

  ----------------------------------------------------------------------------
  -- This function converts a standard logic signal to a string.
  ----------------------------------------------------------------------------
  FUNCTION std_logic_2_string(v : STD_LOGIC) RETURN STRING IS
    VARIABLE str                : STRING(1 TO 2) := "  ";
    CONSTANT ss                 : STRING(1 TO 3) := "01X";
  BEGIN
    IF (v = '0') THEN
      str(2)                                     := ss(1);
    ELSIF (v = '1') THEN
      str(2)                                     := ss(2);
    ELSE
      str(2)                                     := ss(3);
    END IF;
    RETURN str;
  END std_logic_2_string;
	
	
	
	FUNCTION std_logic_vector_2_int(vect : std_logic_vector)
		RETURN integer IS
		
		VARIABLE local_vect : std_logic_vector(vect'high DOWNTO 0);
		VARIABLE result     : integer := 0;
		
	BEGIN
		
		IF (rat(vect(vect'high)) = '1') THEN  -- negative number
			local_vect := two_comp(vect);
		ELSE
			local_vect := vect;
		END IF;
		
		FOR i IN vect'high DOWNTO 0 LOOP
			result   := result * 2;
			IF (rat(local_vect(i)) = '1') THEN
				result := result + 1;
			ELSIF (rat(local_vect(i)) /= '0') THEN
				ASSERT false
				REPORT "Treating a non 0-1 std_logic_vector as 0 in std_logic_vector_2_int"
				SEVERITY warning;
			END IF;
		END LOOP;
		
		IF (rat(vect(vect'high)) = '1') THEN
			result := -1 * result;
		END IF;
		
		RETURN result;
		
	END std_logic_vector_2_int;
	
	FUNCTION two_comp(vect : std_logic_vector)
		RETURN std_logic_vector IS
		
		VARIABLE local_vect : std_logic_vector(vect'high DOWNTO 0);
		VARIABLE toggle     : integer := 0;
		
	BEGIN
		
		FOR i IN 0 TO vect'high LOOP
			IF (toggle = 1) THEN
				IF (vect(i) = '0') THEN
					local_vect(i) := '1';
				ELSE
					local_vect(i) := '0';
				END IF;
			ELSE
				local_vect(i)   := vect(i);
				IF (vect(i) = '1') THEN
					toggle        := 1;
				END IF;
			END IF;
		END LOOP;
		
		RETURN local_vect;
		
	END two_comp;
	
	FUNCTION int_2_std_logic_vector( value, bitwidth : integer )
		RETURN std_logic_vector IS
		
		VARIABLE running_value  : integer := value;
		VARIABLE running_result : std_logic_vector(bitwidth-1 DOWNTO 0);
		
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
			running_value       := running_value/2;
		END LOOP;
		
		IF (value < 0) THEN                 -- find the 2s complement
			RETURN two_comp(running_result);
		ELSE
			RETURN running_result;
		END IF;
		
	END int_2_std_logic_vector;
	
	FUNCTION std_logic_vector_2_posint(vect : std_logic_vector)
		RETURN integer IS
		
		VARIABLE result : integer := 0;
		
	BEGIN
		
		FOR i IN vect'high DOWNTO vect'low LOOP
			result   := result * 2;
			IF (rat(vect(i)) = '1') THEN
				result := result + 1;
			ELSIF (rat(vect(i)) /= '0') THEN
				ASSERT false
				REPORT "Treating a non 0-1 std_logic_vector as 0 in std_logic_vector_2_posint"
				SEVERITY warning;
			END IF;
		END LOOP;
		
		RETURN result;
		
	END std_logic_vector_2_posint;


  -----------------------------------------------------------------------------
  -- int_2_boolean:
  -- Converts an integer to a boolean value.
  --  This function assumes 1=true, otherwise false.
  -----------------------------------------------------------------------------
  FUNCTION int_2_boolean(int: integer)
    RETURN BOOLEAN IS
    VARIABLE bool : boolean := false;
    BEGIN
      IF (int = 1) THEN
        bool := TRUE;
      END IF;
      RETURN TRUE;--bool;
    END int_2_boolean;       


  -----------------------------------------------------------------------------
  -- int_2_string:
  --  Converts an integer to a string of the desired string length.
  -----------------------------------------------------------------------------
  FUNCTION int_2_string(val : integer;str_length :integer)
    RETURN string IS

    VARIABLE digit : INTEGER;
    VARIABLE value : integer := val;
    VARIABLE length : INTEGER := 0;
    VARIABLE posn : INTEGER;
    CONSTANT str : STRING(1 TO 10) := "0123456789";
    VARIABLE ret_value : string(1 to str_length);

  BEGIN

    ASSERT (val >= 0)
    REPORT "Function iputils_conv.int_2_string must receive a positive integer."
    SEVERITY ERROR;
    ASSERT (str_length >= 1)
    REPORT "Function iputils_conv.int_2_string was given an invalid str_length."
    SEVERITY ERROR;
    ASSERT (10**str_length >= val)
    REPORT "Function iputils_conv.int_2_string has too small of str_length to display value."
    SEVERITY ERROR;

      FOR i IN 1 TO str_length LOOP
        ret_value(i) := str(1);
      END LOOP;  -- i

      posn := str_length;
      WHILE (value /= 0) LOOP
	digit := value MOD 10;
  	ret_value(posn) := str(digit+1);  --right here
 	value := value/10;
 	posn := posn - 1;
      END LOOP;


    RETURN ret_value;

  END int_2_string;



  -----------------------------------------------------------------------------
  -- bint_2_sl:
  --  Converts a binary integer (0 or 1) to a std_logic binary value.
  --
  --  Formula:  std_logic='0' when integer=0, else std_logic='1'
  -----------------------------------------------------------------------------

  FUNCTION bint_2_sl (X : integer) RETURN std_logic IS
  BEGIN
    IF (X = 0) THEN
      RETURN '0';
    ELSE
      RETURN '1';
    END IF;
  END bint_2_sl;


  -----------------------------------------------------------------------------
  -- str_to_slv_0:
  --
  -- Converts a string containing 1's and 0's into a std_logic_vector of
  --  width nbits.
  -----------------------------------------------------------------------------

  FUNCTION str_to_slv_0(bitsin : string; nbits : integer) RETURN std_logic_vector is
		variable ret : std_logic_vector(bitsin'range);
		-- String types range from 1 to len!!!
		variable ret0s : std_logic_vector(1 to nbits) := (others => '0');
		variable retpadded : std_logic_vector(1 to nbits) := (others => '0');
		variable offset : integer := 0;
   begin
   		if(bitsin = "") then -- Make all '0's
			return ret0s;
		end if;
		if(bitsin'length < nbits) then -- pad MSBs with '0's
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

 
 -------------------------------------------------------------------------------
-- number_of_bits
-------------------------------------------------------------------------------
-- Purpose:
-- Calculates the number of bits needed to represent the specified value
-- Algorithm:
-- ????
-- Parameters:
-- data_value : input number
-- return : number of bits needed
-------------------------------------------------------------------------------
  FUNCTION number_of_bits (data_value : integer)
    RETURN integer IS

    VARIABLE dwidth : integer := 0;

  BEGIN
    WHILE 2**dwidth-1 < data_value AND data_value > 0 LOOP
      dwidth := dwidth + 1;
    END LOOP;

    RETURN dwidth;
  END number_of_bits;

  

-------------------------------------------------------------------------------
-- number_of_digits
-------------------------------------------------------------------------------
-- Purpose:
-- Calculates the number of bits needed to represent the specified value
-- Algorithm:
-- ????
-- Parameters:
-- data_value : input number
-- return : number of bits needed
-------------------------------------------------------------------------------
  FUNCTION number_of_digits (data_value : integer; radix : integer)
    RETURN integer IS

    VARIABLE dwidth : integer := 0;

  BEGIN
    WHILE radix**dwidth-1 < data_value AND data_value > 0 LOOP
      dwidth := dwidth + 1;
    END LOOP;

    RETURN dwidth;
  END number_of_digits;

        
-------------------------------------------------------------------------------
-- conv_int_to_new_radix
-------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------
  FUNCTION conv_int_to_new_radix(number : integer; target_str_len : integer; target_radix : integer) RETURN string IS

    VARIABLE return_string   : string(1 TO target_str_len) := (OTHERS => '0');
    VARIABLE string_location : integer                     := 0;
    VARIABLE tmp_string_val  : integer                     := 0;
    VARIABLE new_number      : integer                     := number;
    VARIABLE hexdigits       : string(1 TO 16)             := "0123456789ABCDEF";
    VARIABLE max_exp         : integer                     := 0;
  BEGIN
    max_exp                                                := number_of_digits(number, target_radix);
    IF target_str_len < max_exp THEN
      max_exp                                              := target_str_len;
    END IF;

    new_number := number;

    FOR exp IN max_exp-1 DOWNTO 0 LOOP
      string_location := target_str_len-exp;

      tmp_string_val := new_number/(target_radix**exp);

      new_number := new_number - tmp_string_val*(target_radix**exp);

      return_string(string_location) := hexdigits(tmp_string_val+1);

    END LOOP;

    RETURN return_string;

  END conv_int_to_new_radix;

-------------------------------------------------------------------------------
-- int_2_hex
--   Converts an integer to a hexidecimal string value
-------------------------------------------------------------------------------
  FUNCTION int_2_hex( value, bitwidth : INTEGER )
    RETURN STRING IS

    VARIABLE hexdigits	    : STRING(1 TO 16) := "0123456789ABCDEF";
    VARIABLE running_value  : INTEGER	      := value;
    VARIABLE digit_value    : INTEGER	      := 0;
    VARIABLE digit_position : INTEGER	      := 1;
    VARIABLE results_string : STRING(1 TO bitwidth/4);

  BEGIN

    FOR i IN bitwidth-1 DOWNTO 0 LOOP

      IF (2**i) <= running_value THEN
	running_value := running_value - (2**i);
	digit_value := digit_value + (2**(i mod 4));
      END IF;

      IF i MOD 4 = 0 THEN
	results_string(digit_position) := hexdigits(1+digit_value);
	digit_value := 0;
	digit_position := digit_position + 1;
      END IF;

    END LOOP;

    RETURN results_string;

  END int_2_hex;

        
	-----------------------------------------------------------------------------
	-- FUNCTION : div4roundup_v2
	-- Returns the ceiling value of the division by 4
        --  This version of this function is only for use by the
        --  bin_2_hex_string function.  Users should use
        --  div4roundup from iputils_math.
	-----------------------------------------------------------------------------
	FUNCTION div4roundup_v2 (data_value : integer)
		RETURN integer IS
		VARIABLE div                   : integer;
	BEGIN
		div   := data_value/4;
		IF ( (data_value MOD 4) /= 0) THEN
			div := div+1;
		END IF;
		RETURN div;
	END div4roundup_v2;

        
  ------------------------------------------------------------------------------
  -- bin_2_hex_string
  -- This function converts a standard logic vector to a string.
  ------------------------------------------------------------------------------
  function bin_2_hex_string(bin: string) return string is
    variable hex_len : integer := div4roundup_v2(bin'high);
    variable bin_ext : string(1 to hex_len*4);
    variable hex: string(1 to hex_len);
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

  end bin_2_hex_string;


-------------------------------------------------------------------------------
-- hexstr_to_std_logic_vec
--  This function converts a hex string to a std_logic_vector
-------------------------------------------------------------------------------
  FUNCTION hexstr_to_std_logic_vec( arg1 : string; size : integer ) RETURN std_logic_vector IS
    VARIABLE RESULT                      : std_logic_vector(size-1 DOWNTO 0)                   := (OTHERS => '0');
    VARIABLE BIN                         : std_logic_vector(3 DOWNTO 0);
    VARIABLE INDEX                       : integer                                             := 0;
  BEGIN
    FOR i IN arg1'reverse_range LOOP
      CASE arg1(i) IS
        WHEN '0'                                                                        => BIN := (OTHERS => '0');
        WHEN '1'                                                                        => BIN := (0 => '1', OTHERS => '0');
        WHEN '2'                                                                        => BIN := (1 => '1', OTHERS => '0');
        WHEN '3'                                                                        => BIN := (0 => '1', 1 => '1', OTHERS => '0');
        WHEN '4'                                                                        => BIN := (2 => '1', OTHERS => '0');
        WHEN '5'                                                                        => BIN := (0 => '1', 2 => '1', OTHERS => '0');
        WHEN '6'                                                                        => BIN := (1 => '1', 2 => '1', OTHERS => '0');
        WHEN '7'                                                                        => BIN := (3 => '0', OTHERS => '1');
        WHEN '8'                                                                        => BIN := (3 => '1', OTHERS => '0');
        WHEN '9'                                                                        => BIN := (0 => '1', 3 => '1', OTHERS => '0');
        WHEN 'A'                                                                        => BIN := (0 => '0', 2 => '0', OTHERS => '1');
        WHEN 'a'                                                                        => BIN := (0 => '0', 2 => '0', OTHERS => '1');
        WHEN 'B'                                                                        => BIN := (2 => '0', OTHERS => '1');
        WHEN 'b'                                                                        => BIN := (2 => '0', OTHERS => '1');
        WHEN 'C'                                                                        => BIN := (0 => '0', 1 => '0', OTHERS => '1');
        WHEN 'c'                                                                        => BIN := (0 => '0', 1 => '0', OTHERS => '1');
        WHEN 'D'                                                                        => BIN := (1 => '0', OTHERS => '1');
        WHEN 'd'                                                                        => BIN := (1 => '0', OTHERS => '1');
        WHEN 'E'                                                                        => BIN := (0 => '0', OTHERS => '1');
        WHEN 'e'                                                                        => BIN := (0 => '0', OTHERS => '1');
        WHEN 'F'                                                                        => BIN := (OTHERS => '1');
        WHEN 'f'                                                                        => BIN := (OTHERS => '1');
        WHEN OTHERS                                                                     =>
          --ASSERT false
          --  REPORT "NOT A HEX CHARACTER" SEVERITY error;
          FOR j IN 0 TO 3 LOOP
            BIN(j)                                                                             := 'X';
          END LOOP;
      END CASE;
      FOR j IN 0 TO 3 LOOP
        IF (INDEX*4)+j < size THEN
          RESULT((INDEX*4)+j)                                                                  := BIN(j);
        END IF;
      END LOOP;
      INDEX                                                                                    := INDEX + 1;
    END LOOP;
    RETURN RESULT;
  END hexstr_to_std_logic_vec;

	
END iputils_conv;

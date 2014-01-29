-------------------------------------------------------------------------------
-- $Id: iputils_math.vhd,v 1.16 2008/09/08 20:08:59 akennedy Exp $
-------------------------------------------------------------------------------
--
-- IP Utilities Library - Math Functions
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
--   iputils_slv - operators on std_logic_vectors
--   iputils_math - mathematical operations (like rounding, logarithms, etc)
--   iputils_mem - memory features (like reading/writing to .mif files)
--   iputils_misc - miscellaneous functions
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
---- iputils_math
----   mathematical operations (like rounding, logarithms, etc)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
LIBRARY std;
USE std.textio.ALL;

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE iputils_math IS
	
	-------------------------------------------------------------------------------
	-- Contant Declarations
	-------------------------------------------------------------------------------
	
	CONSTANT one  : std_logic := '1';
	CONSTANT zero : std_logic := '0';
	
	
	-------------------------------------------------------------------------------
	-- FUNCTION DECLARATION
	-------------------------------------------------------------------------------
	FUNCTION addr_width_for_depth (depth : integer)
	RETURN integer;
	
	FUNCTION binary_width_of_integer (data_value : integer)
	RETURN integer;
	
	FUNCTION log2roundup (data_value : integer)
	RETURN integer;
	
	FUNCTION get_min ( a : integer;	b : integer)
	RETURN integer;
	
	FUNCTION get_max ( a : integer;	b : integer)
	RETURN integer;
	
	FUNCTION div4roundup (data_value : integer)
	RETURN integer;
	
	FUNCTION divroundup (data_value : integer; divisor : integer)
	RETURN integer;

	FUNCTION divrounddown (data_value : integer; divisor : integer)
	RETURN integer;

	FUNCTION roundup_to_multiple(data_value : integer; multipleof : integer)
	RETURN integer;
	
	FUNCTION rand_int_base (seed : integer; maxval : integer; iterations : integer; feedback_val : integer)
    RETURN integer;
	
	FUNCTION rand_int (seed : integer; maxval : integer)
    RETURN integer;
	
	FUNCTION rand_slv_bits (seed : integer; width : integer)
    RETURN std_logic_vector;
	
	FUNCTION rand_slv (seed : integer; width : integer; maxval : integer)
    RETURN std_logic_vector;

        
END iputils_math;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
---- PACKAGE CONTENTS DEFINED AFTER THIS POINT
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LIBRARY std;
USE std.textio.ALL;

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.iputils_conv.int_2_std_logic_vector;

PACKAGE BODY iputils_math IS
	---------------------------------------------------------------------------
	-- addr_width_for_depth
	---------------------------------------------------------------------------
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
	---------------------------------------------------------------------------
	FUNCTION addr_width_for_depth (depth : integer)
		RETURN integer IS
		VARIABLE bits : integer := 0;
		
	BEGIN
		WHILE 2**bits < depth AND depth > 1 LOOP
			bits := bits + 1;
		END LOOP;
		
		RETURN bits;
	END addr_width_for_depth;
	
	
	-------------------------------------------------------------------------------
	-- binary_width_of_integer
	-------------------------------------------------------------------------------
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
	-------------------------------------------------------------------------------
	FUNCTION binary_width_of_integer (data_value : integer)
		RETURN integer IS
		
		VARIABLE dwidth : integer := 0;
		
	BEGIN
		WHILE 2**dwidth-1 < data_value AND data_value > 0 LOOP
			dwidth := dwidth + 1;
		END LOOP;
		
		RETURN dwidth;
	END binary_width_of_integer;
	
	
	
	---------------------------------------------------------------------------
	-- FUNCTION : log2roundup
	---------------------------------------------------------------------------
	FUNCTION log2roundup (data_value : integer)
		RETURN integer IS
		
		VARIABLE width       : integer := 0;
		VARIABLE cnt         : integer := 1;
		CONSTANT lower_limit : integer := 1;
		CONSTANT upper_limit : integer := 8;
		
	BEGIN
		IF (data_value <= 1) THEN
			width   := 0;
		ELSE
			WHILE (cnt < data_value) LOOP
				width := width + 1;
				cnt   := cnt *2;
			END LOOP;
		END IF;
		
		RETURN width;
	END log2roundup;
	
	
	-----------------------------------------------------------------------------
	-- FUNCTION : get_min
	-- Returns the min(a,b)                           
	-----------------------------------------------------------------------------
	FUNCTION get_min ( a : integer;
		b : integer
		)
		RETURN integer IS
		VARIABLE smallest  : integer := 1;
	BEGIN
		IF (a < b) THEN
			smallest                   := a;
		ELSE
			smallest                   := b;
		END IF;
		RETURN smallest;
	END get_min;
	
	-----------------------------------------------------------------------------
	-- FUNCTION : get_max
	-- Returns the max(a,b)                           
	-----------------------------------------------------------------------------
	FUNCTION get_max ( a : integer; b : integer)
		RETURN integer IS
		VARIABLE biggest  : integer := 1;
	BEGIN
		IF (a > b) THEN
			biggest                   := a;
		ELSE
			biggest                   := b;
		END IF;
		RETURN biggest;
	END get_max;
	
	-----------------------------------------------------------------------------
	-- FUNCTION : div4roundup
	-- Returns the ceiling value of the division by 4
	-----------------------------------------------------------------------------
	FUNCTION div4roundup (data_value : integer)
		RETURN integer IS
		VARIABLE div                   : integer;
	BEGIN
		div   := data_value/4;
		IF ( (data_value MOD 4) /= 0) THEN
			div := div+1;
		END IF;
		RETURN div;
	END div4roundup;
	
	-----------------------------------------------------------------------------
	-- FUNCTION : divroundup
	-- Returns the ceiling value of the division
	-- Data_value - the quantity to be divided, dividend
	-- Divisor - the value to divide the data_value by
	-----------------------------------------------------------------------------
	FUNCTION divroundup (data_value : integer; divisor : integer)
		RETURN integer IS
		VARIABLE div                   : integer;
	BEGIN
		div   := data_value/divisor;
		IF ( (data_value MOD divisor) /= 0) THEN
			div := div+1;
		END IF;
		RETURN div;
	END divroundup;
	
	
	-----------------------------------------------------------------------------
	-- FUNCTION : divrounddown
	-- Returns the floor value of the division
	-- Data_value - the quantity to be divided, dividend
	-- Divisor - the value to divide the data_value by
	-----------------------------------------------------------------------------
	FUNCTION divrounddown (data_value : integer; divisor : integer)
		RETURN integer IS
		VARIABLE div                   : integer;
	BEGIN
		div   := data_value/divisor;
--		IF ( (data_value MOD divisor) /= 0) THEN
--			div := div-1;
--		END IF;
		RETURN div;
	END divrounddown;
	
	-------------------------------------------------------------------------------
	-- roundup_to_multiple
	-------------------------------------------------------------------------------
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
	-- NOTES: 
	-------------------------------------------------------------------------------
	FUNCTION roundup_to_multiple(data_value : integer; multipleof : integer)
		RETURN integer IS
		VARIABLE retval                   : integer;
	BEGIN
		retval   := data_value/multipleof;
		IF ( (data_value MOD multipleof) /= 0) THEN
			retval := retval+1;
		END IF;
		retval := multipleof * retval;
		RETURN retval;
	END roundup_to_multiple;
	
	


-------------------------------------------------------------------------------
-- rand_int_base
--
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
-- Also, feedback_val works best when a large prime number (like 19).
-------------------------------------------------------------------------------
  FUNCTION rand_int_base (seed : integer; maxval : integer; iterations : integer; feedback_val : integer)
    RETURN integer IS
    VARIABLE ret_val           : integer := 0;
  BEGIN
    ret_val                              := seed;
    FOR i IN 0 TO iterations LOOP
      IF ret_val >= maxval/2 THEN
        ret_val                          := ret_val * 2 + feedback_val;
      ELSE
        ret_val                          := ret_val * 2;
      END IF;

      WHILE ret_val > maxval LOOP
        ret_val := ret_val - maxval;
      END LOOP;
    END LOOP;  -- i
    RETURN ret_val;
  END rand_int_base;

-------------------------------------------------------------------------------
-- rand_int
--
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
-------------------------------------------------------------------------------
  FUNCTION rand_int (seed : integer; maxval : integer)
    RETURN integer IS
    VARIABLE ret_val      : integer := 0;
  BEGIN
    ret_val                         := rand_int_base(seed, maxval + 15000, 2, 19);
    WHILE ret_val > maxval LOOP
      ret_val                       := ret_val - maxval;
    END LOOP;
    RETURN ret_val;
  END rand_int;

-------------------------------------------------------------------------------
-- rand_slv_bits
--
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
-------------------------------------------------------------------------------
  FUNCTION rand_slv_bits (seed : integer; width : integer)
    RETURN std_logic_vector IS
    VARIABLE ret_vect          : std_logic_vector(width-1 DOWNTO 0) := (OTHERS => '0');
    VARIABLE rand_val          : integer                            := seed;
  BEGIN
    FOR i IN 0 TO width-1 LOOP
      rand_val                                                      := rand_int(rand_val, 19);
      IF rand_val >= 10 THEN
        ret_vect(i)                                                 := '1';
      ELSE
        ret_vect(i)                                                 := '0';
      END IF;
    END LOOP;  -- i
    RETURN ret_vect;
  END rand_slv_bits;

-------------------------------------------------------------------------------
-- rand_slv
--
-- Purpose: To randomly generate a std_logic_vector between 0 and maxval.
--          (including 0 and maxval)
--
-- Inputs:
-- seed : Any integer value. Given the same seed, this function will
-- always generate the same output. It is recommended to always
-- use the output of this function as the seed for the next call.
-- width : The number of bits in the output.
-- maxval : The maximum value allowed. This may be less than or
-- equal to 2^width-1.
-- Return:
-- pseudo-random std_logic_vector from 0 to maxval.
-------------------------------------------------------------------------------
  FUNCTION rand_slv (seed : integer; width : integer; maxval : integer)
    RETURN std_logic_vector IS
    VARIABLE ret_vect     : std_logic_vector(width-1 DOWNTO 0) := (OTHERS => '0');
    VARIABLE rand_val     : integer                            := seed;
  BEGIN
    --Generate a random integer using the seed
    rand_val                                                   := rand_int(rand_val, maxval);
    --Put it into a std_logic_vector of the correct size
    ret_vect                                                   := int_2_std_logic_vector(rand_val, width);
    RETURN ret_vect;
  END rand_slv;






        
		
END iputils_math;


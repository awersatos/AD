--$ID:$
-- CORE NAME: BIT_CORRELATOR_V3_0
-- Copyright : Xilinx, Inc.
-- Filename: bit_correlator_pack_v3_0.vhd
-- Core Description : correlates input with a binary pattern
-- File Description : provides a package of functions that can
--                    used for bit correlator core.

library ieee;	
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

LIBRARY std;
use std.TEXTIO.all;

------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------
package bit_correlator_pack_v3_0 is	 
	
  FUNCTION hex_to_std_logic_vector(hexstring: STRING) RETURN std_logic_vector;
	FUNCTION size_of_patternmask_vector(number_of_values:INTEGER; has_mask:INTEGER) RETURN INTEGER;
	FUNCTION read_pattern_mask( filename: string; number_of_values: integer; has_mask: integer) RETURN std_logic_vector;
	
end;

package body bit_correlator_pack_v3_0 is

  FUNCTION hex_to_std_logic_vector(hexstring: STRING)
    RETURN std_logic_vector IS

    CONSTANT length 	  : integer := hexstring'LENGTH;
    VARIABLE bitval       : std_logic_vector((length*4)-1 downto 0);
    VARIABLE posn	  : integer := bitval'LEFT;
    VARIABLE ch           : character;
  BEGIN
    FOR i in 1 to length LOOP
      ch := hexstring(i);
      CASE ch IS
        WHEN '0' => bitval(posn downto posn-3) := "0000";
        WHEN '1' => bitval(posn downto posn-3) := "0001";
        WHEN '2' => bitval(posn downto posn-3) := "0010";
        WHEN '3' => bitval(posn downto posn-3) := "0011";
        WHEN '4' => bitval(posn downto posn-3) := "0100";
        WHEN '5' => bitval(posn downto posn-3) := "0101";
        WHEN '6' => bitval(posn downto posn-3) := "0110";
        WHEN '7' => bitval(posn downto posn-3) := "0111";
        WHEN '8' => bitval(posn downto posn-3) := "1000";
        WHEN '9' => bitval(posn downto posn-3) := "1001";
        WHEN 'A' | 'a' => bitval(posn downto posn-3) := "1010";
        WHEN 'B' | 'b' => bitval(posn downto posn-3) := "1011";
        WHEN 'C' | 'c' => bitval(posn downto posn-3) := "1100";
        WHEN 'D' | 'd' => bitval(posn downto posn-3) := "1101";
        WHEN 'E' | 'e' => bitval(posn downto posn-3) := "1110";
        WHEN 'F' | 'f' => bitval(posn downto posn-3) := "1111";
        WHEN OTHERS => ASSERT false
                       REPORT "Invalid hex value in MIF file" SEVERITY ERROR;
                       bitval(posn downto posn-3) := "XXXX";
     END CASE;
     posn := posn - 4;
   END LOOP;
   RETURN bitval;
 END hex_to_std_logic_vector;

-- READ THE SIZE OF THE PATTERN_MASK dependent on has_mask

	FUNCTION size_of_patternmask_vector(number_of_values:INTEGER; has_mask:INTEGER )
	   RETURN INTEGER IS

		 VARIABLE returnValue: integer := 0;
	BEGIN

		if(has_mask = 0) then
			returnValue := number_of_values;
		else
			returnValue := number_of_values*2;
		end if;

		return returnValue;
	END size_of_patternmask_vector;


--  READ THE PATTERN BITS WITH/WITHOUT THE MASK BITS
	FUNCTION read_pattern_mask( filename:STRING; number_of_values: INTEGER; has_mask:INTEGER ) 
          	RETURN STD_LOGIC_VECTOR IS
		
		FILE pattern_file : TEXT IS filename;
		VARIABLE hexline  : LINE;
		VARIABLE pattern_mask  : STD_LOGIC_VECTOR((size_of_patternmask_vector(number_of_values,has_mask) - 1) downto 0);
		VARIABLE lines    : INTEGER :=0;
		VARIABLE hexstring: STRING(1 to 1) := "0";  
		VARIABLE bits     : STD_LOGIC_VECTOR(3 downto 0);
	
	BEGIN
		
		WHILE (NOT(endfile(pattern_file)) AND (lines <= number_of_values)) LOOP
			readline(pattern_file, hexline);
			read(hexline, hexstring);
			bits := hex_to_std_logic_vector(hexstring);
	
		-- Check the mask bit requirement
			pattern_mask(lines) := bits(0);
			IF(has_mask = 1) THEN
				pattern_mask(lines + number_of_values) := bits(1);
			END IF;
			lines := lines + 1;
	
		END LOOP;

		RETURN pattern_mask;
	END read_pattern_mask;
	
end bit_correlator_pack_v3_0;

-------------------------------------------------------------------------------
-- $Id: iputils_misc.vhd,v 1.16 2008/09/08 20:08:59 akennedy Exp $
-------------------------------------------------------------------------------
--
-- IP Utilities Library - Miscellaneous Functions
--
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
-- This file contains the following package:
--   iputils_misc - miscellaneous functions
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
---- iputils_misc
----   Miscellaneous utility functions
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE iputils_misc IS

	FUNCTION if_then_else (condition : integer; true_case : integer; false_case : integer)
	RETURN integer;
	
	FUNCTION if_then_else (condition : boolean; true_case : integer; false_case : integer)
	RETURN integer;
	
 FUNCTION index_in_str(stringtosearch : string; stringsize : integer; char : string; instnum : integer) RETURN integer;

  FUNCTION cond_string (condition : boolean; true_string : string; false_string : string) RETURN string;        

FUNCTION get_lesser (a: INTEGER; b: INTEGER)
RETURN INTEGER;

FUNCTION get_greater (a: INTEGER; b: INTEGER)
RETURN INTEGER;

FUNCTION  zero_string (length: INTEGER)
RETURN STRING;

FUNCTION  ones_string (length: INTEGER)
RETURN STRING;

  FUNCTION lcase(instring : string)
    RETURN string;

  FUNCTION ucase(instring : string)
    RETURN string;
  
  FUNCTION case_sensitive_compare(a, b : string)
    RETURN boolean;

  FUNCTION case_insensitive_compare(a, b : string)
    RETURN boolean;

  FUNCTION strbool_to_int(boolean_string : string)
    RETURN integer;


END iputils_misc;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
---- PACKAGE CONTENTS DEFINED AFTER THIS POINT
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
PACKAGE BODY iputils_misc IS

-------------------------------------------------------------------------------
-- This function is used to implement an IF..THEN when such a statement is not
--  allowed.  It considers all non-zero integers as TRUE.
-------------------------------------------------------------------------------
FUNCTION if_then_else (condition : integer; true_case : integer; false_case : integer) RETURN integer IS
VARIABLE retval : integer := 0;
BEGIN
  IF condition=0 THEN
    retval:=false_case;
  ELSE
    retval:=true_case;
  END IF;
  RETURN retval;
END if_then_else;
	
	
-------------------------------------------------------------------------------
-- This function is used to implement an IF..THEN when such a statement is not
--  allowed. 
-------------------------------------------------------------------------------
FUNCTION if_then_else (condition : boolean; true_case : integer; false_case : integer) RETURN integer IS
VARIABLE retval : integer := 0;
BEGIN
  IF NOT condition THEN
    retval:=false_case;
  ELSE
    retval:=true_case;
  END IF;
  RETURN retval;
END if_then_else;
	

-------------------------------------------------------------------------------
-- index_in_str:
-- Returns the index of a specified instance of a specified character in another string
-- Example: What is the index of the third "l" in "Hello World"? =10
--
-- Inputs:
-- string of characters of any length
-- length of string (number of characters)
-- character to search for
-- number of instance to locate
-- Outputs:
-- integer index value 1 to stringsize, if char exists. Returns 0 if the char
-- was not found.
-------------------------------------------------------------------------------
  FUNCTION index_in_str(stringtosearch : string; stringsize : integer; char : string; instnum : integer) RETURN integer IS

    VARIABLE instfound    : integer := 0;
    VARIABLE foundatindex : integer := 0;
  BEGIN
    FOR i IN 1 TO stringsize LOOP
      IF stringtosearch(i) = char(1) THEN
        instfound                   := instfound + 1;

        IF instfound = instnum THEN
          foundatindex := i;
        END IF;
      END IF;
    END LOOP;  -- i

    RETURN foundatindex;
  END index_in_str;

  -----------------------------------------------------------------------------
  -- cond_string:
  --  Conditional string selection.  If condition is TRUE, then the string
  --  passed-in as true_string is returned, otherwise, the false_string
  --  string value is returned.
  -----------------------------------------------------------------------------
  FUNCTION cond_string (condition : boolean; true_string : string; false_string : string) RETURN string IS
  BEGIN
    IF condition THEN
      RETURN true_string;
    ELSE
      RETURN false_string;
    END IF;
  END cond_string;



-- ---------------------------------------------------
-- FUNCTION : get_lesser
--  Returns the smaller of two integers.
-- ---------------------------------------------------
FUNCTION get_lesser (a: INTEGER; b: INTEGER)
	RETURN INTEGER IS
	VARIABLE smallest : INTEGER := 1;
	
	BEGIN
		IF (a < b) THEN
          		smallest := a;
          	ELSE
          		smallest := b;
          	END IF;          			
	RETURN smallest;
END get_lesser;	


--------------------------------------------------------
---  FUNCION : get_greater           -------------------
--  Returns the larger of two integers.
--------------------------------------------------------

FUNCTION get_greater(a: INTEGER; b: INTEGER) RETURN INTEGER IS
       VARIABLE largest : INTEGER;
       BEGIN
               IF (a > b) THEN
                       largest := a;
               ELSE
                       largest := b;
               END IF;
       RETURN largest;
END get_greater;

--------------------------------------------------------
---  zero_string
--  Creates a string of 0's of the specified length
--------------------------------------------------------

FUNCTION zero_string (length: INTEGER) RETURN STRING IS
       VARIABLE zeros : string(1 TO length);
       BEGIN
               FOR i IN 1 TO length LOOP
                       zeros(i) := '0';
               end LOOP;
       RETURN zeros;
END zero_string;

--------------------------------------------------------
---  ones_string
--  Creates a string of 1's of the specified length
--------------------------------------------------------

FUNCTION ones_string (length: INTEGER) RETURN STRING IS
       VARIABLE ones : string(1 TO length);
       BEGIN
               FOR i IN 1 TO length LOOP
                       ones(i) := '1';
               end LOOP;
       RETURN ones;
END ones_string;


-------------------------------------------------------------------------------
-- lcase
--   Converts a string to all lowercase.
-------------------------------------------------------------------------------
  FUNCTION lcase(instring : string) RETURN string IS
    VARIABLE retstring : string (instring'low TO instring'high);
  BEGIN
    FOR i IN instring'low TO instring'high LOOP

      CASE instring(i) IS
        WHEN 'A' => retstring(i) := 'a';
        WHEN 'B' => retstring(i) := 'b';
        WHEN 'C' => retstring(i) := 'c';
        WHEN 'D' => retstring(i) := 'd';
        WHEN 'E' => retstring(i) := 'e';
        WHEN 'F' => retstring(i) := 'f';
        WHEN 'G' => retstring(i) := 'g';
        WHEN 'H' => retstring(i) := 'h';
        WHEN 'I' => retstring(i) := 'i';
        WHEN 'J' => retstring(i) := 'j';
        WHEN 'K' => retstring(i) := 'k';
        WHEN 'L' => retstring(i) := 'l';
        WHEN 'M' => retstring(i) := 'm';
        WHEN 'N' => retstring(i) := 'n';
        WHEN 'O' => retstring(i) := 'o';
        WHEN 'P' => retstring(i) := 'p';
        WHEN 'Q' => retstring(i) := 'q';
        WHEN 'R' => retstring(i) := 'r';
        WHEN 'S' => retstring(i) := 's';
        WHEN 'T' => retstring(i) := 't';
        WHEN 'U' => retstring(i) := 'u';
        WHEN 'V' => retstring(i) := 'v';
        WHEN 'W' => retstring(i) := 'w';
        WHEN 'X' => retstring(i) := 'x';
        WHEN 'Y' => retstring(i) := 'y';
        WHEN 'Z' => retstring(i) := 'z';
        WHEN OTHERS => retstring(i) := instring(i);
      END CASE;
    END LOOP;  -- i

    RETURN retstring;

  END lcase;


-------------------------------------------------------------------------------
-- ucase
--   Converts a string to all uppercase.
-------------------------------------------------------------------------------
  FUNCTION ucase(instring : string) RETURN string IS
    VARIABLE retstring : string (instring'low TO instring'high);
  BEGIN
    FOR i IN instring'low TO instring'high LOOP

      CASE instring(i) IS
        WHEN 'a' => retstring(i) := 'A';
        WHEN 'b' => retstring(i) := 'B';
        WHEN 'c' => retstring(i) := 'C';
        WHEN 'd' => retstring(i) := 'D';
        WHEN 'e' => retstring(i) := 'E';
        WHEN 'f' => retstring(i) := 'F';
        WHEN 'g' => retstring(i) := 'G';
        WHEN 'h' => retstring(i) := 'H';
        WHEN 'i' => retstring(i) := 'I';
        WHEN 'j' => retstring(i) := 'J';
        WHEN 'k' => retstring(i) := 'K';
        WHEN 'l' => retstring(i) := 'L';
        WHEN 'm' => retstring(i) := 'M';
        WHEN 'n' => retstring(i) := 'N';
        WHEN 'o' => retstring(i) := 'O';
        WHEN 'p' => retstring(i) := 'P';
        WHEN 'q' => retstring(i) := 'Q';
        WHEN 'r' => retstring(i) := 'R';
        WHEN 's' => retstring(i) := 'S';
        WHEN 't' => retstring(i) := 'T';
        WHEN 'u' => retstring(i) := 'U';
        WHEN 'v' => retstring(i) := 'V';
        WHEN 'w' => retstring(i) := 'W';
        WHEN 'x' => retstring(i) := 'X';
        WHEN 'y' => retstring(i) := 'Y';
        WHEN 'z' => retstring(i) := 'Z';
        WHEN OTHERS => retstring(i) := instring(i);
      END CASE;
    END LOOP;  -- i

    RETURN retstring;

  END ucase;


-------------------------------------------------------------------------------
-- case_sensitive_compare
--      Compares two strings for equality, case dependent
-------------------------------------------------------------------------------
  FUNCTION case_sensitive_compare(a, b : string) RETURN boolean IS
    VARIABLE retval : boolean := true;
  BEGIN
    --If strings are not the same length can they not be considered equivalent
    IF NOT(a'length = b'length) THEN
      retval := false;
    ELSE
      --if strings are the same length
      --compare each character
      FOR i IN a'low TO a'high LOOP
        --if a character doesn't match, return false
        IF a(i)/=b(i) THEN
          retval:=false;
        END IF;
      END LOOP;  -- i
    END IF;

    RETURN retval;
  END case_sensitive_compare;

  
-------------------------------------------------------------------------------
-- case_insensitive_compare
--      Compares two strings for equality, ignoring case differences.
-------------------------------------------------------------------------------
  FUNCTION case_insensitive_compare(a, b : string) RETURN boolean IS
  BEGIN
    
    RETURN case_sensitive_compare(ucase(a), ucase(b));

  END case_insensitive_compare;


-------------------------------------------------------------------------------
-- strbool_to_int
--      Converts a boolean string to an integer (0 or 1).
-------------------------------------------------------------------------------
  FUNCTION strbool_to_int(boolean_string : string) RETURN integer IS
  BEGIN
    IF case_insensitive_compare(boolean_string, "TRUE") THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END strbool_to_int;

  

END iputils_misc;


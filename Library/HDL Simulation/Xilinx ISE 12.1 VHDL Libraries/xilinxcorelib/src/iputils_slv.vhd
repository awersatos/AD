-------------------------------------------------------------------------------
-- $Id: iputils_slv.vhd,v 1.16 2008/09/08 20:08:59 akennedy Exp $
-------------------------------------------------------------------------------
--
-- IP Utilities Library - Functions for std_logic_vector operations
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
--   iputils_slv - operators on std_logic_vectors
-------------------------------------------------------------------------------
LIBRARY std;
USE std.textio.ALL;

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE iputils_slv IS
	FUNCTION anySLV_active_2SL (vector : std_logic_vector)
	RETURN std_logic;
	
	FUNCTION one_hot (binval : std_logic_vector; one_hot_size : integer)
	RETURN std_logic_vector;
	
	FUNCTION SLV_binary_encoder (vector : std_logic_vector)
	RETURN std_logic_vector;
	
	FUNCTION set_bit (bit_to_set : integer; binval : std_logic_vector)
	RETURN std_logic_vector;
	
  FUNCTION binary_compare (dataa : std_logic_vector; datab : std_logic_vector)
    RETURN boolean;

        
  FUNCTION SLV_binary_encoder_of_width (vector : std_logic_vector; output_width : integer)
    RETURN std_logic_vector;

END iputils_slv;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
---- PACKAGE CONTENTS DEFINED AFTER THIS POINT
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.iputils_math.log2roundup;
USE XilinxCoreLib.iputils_conv.int_2_std_logic_vector;
USE XilinxCoreLib.iputils_conv.std_logic_vector_2_posint;

PACKAGE BODY iputils_slv IS
	-----------------------------------------------------------------------------
	-- FUNCTION : anySLV_active_2SL
	-- Returns a std_logic of value '1' if the input standard logic vector
	-- contains any '1'
	-----------------------------------------------------------------------------
	FUNCTION anySLV_active_2SL (vector : std_logic_vector)
		RETURN std_logic IS
		VARIABLE anyactive               : std_logic := '0';
	BEGIN
		FOR i IN 0 TO vector'length-1 LOOP
			IF (vector(i) = '1') THEN
				anyactive                                := '1';
			END IF;
		END LOOP;
		RETURN anyactive;
	END anySLV_active_2SL;
	
  -----------------------------------------------------------------------------
  -- FUNCTION: SLV_binary_encoder
  --
  -- DESCRIPTION:       Returns a binary encoded std_logic_vector
  --                    (from a decoded one-hot value)
  --                    Note: An input of all-zeros produces a zero output
  --
  -- INPUTS:
  --   vector = one-hot encoded value (any width)
  --
  -- OUTPUT:    binary encoded equivalent
  -----------------------------------------------------------------------------
  FUNCTION SLV_binary_encoder (vector : std_logic_vector)
    RETURN std_logic_vector IS
    VARIABLE active_index             : integer := 0;
    VARIABLE output_width             : integer := log2roundup(vector'length);
  BEGIN
    FOR i IN 0 TO vector'length-1 LOOP
      IF (vector(i) = '1') THEN
        active_index                            := i;
      END IF;
    END LOOP;

    RETURN int_2_std_logic_vector(active_index, output_width);
  END SLV_binary_encoder;
	
  -----------------------------------------------------------------------------
  -- FUNCTION:  one_hot
  --
  -- DESCRIPTION: This function converts a binary value into a one-hot encoded
  --    value of width one_hot_size.
  --
  -- INPUTS:
  --    binval       = binary value to convert to one-hot
  --    one_hot_size = width of the desired one-hot vector
  --
  -- OUTPUT: one-hot encoded equivalent of binval
  -----------------------------------------------------------------------------
	FUNCTION one_hot (binval  : std_logic_vector; one_hot_size : integer)
		RETURN std_logic_vector IS
		VARIABLE one_hot_result : std_logic_vector(one_hot_size-1 DOWNTO 0) := (OTHERS => '0');
	BEGIN
		FOR i IN 0 TO one_hot_size-1 LOOP
			IF i = std_logic_vector_2_posint(binval) THEN
				one_hot_result(i)                                               := '1';
			END IF;
		END LOOP;  -- i
		
		RETURN one_hot_result;
	END one_hot;
	
  -----------------------------------------------------------------------------
  -- FUNCTION:  set_bit
  --
  -- DESCRIPTION: 
  --    This function sets the bit bit_to_set of the input binary value. It
  --    returns the modified std_logic_vector of that binary value.
  --
  -- INPUTS:
  --    bit_to_set = integer index of the bit, in the slv, to set
  --    binval     = original vector
  -- OUTPUT:
  --    identical to binval, but with the bit_to_set bit set to '1'.
  -----------------------------------------------------------------------------
	FUNCTION set_bit (bit_to_set : integer; binval : std_logic_vector) RETURN std_logic_vector IS
		VARIABLE retval            : std_logic_vector(binval'high DOWNTO binval'low);
	BEGIN
		retval             := binval;
		retval(bit_to_set) := '1';
		RETURN retval;
	END set_bit;
	
	
-------------------------------------------------------------------------------
-- binary_compare
-- This function compares two std_logic_vectors (dataa and datab). It returns
-- true if they are identical, false otherwise.
-- If any bit is 'U', the vectors are considered to not match.
-------------------------------------------------------------------------------

  FUNCTION binary_compare (dataa : std_logic_vector; datab : std_logic_vector) RETURN boolean IS
    VARIABLE equal               : boolean := true;
  BEGIN
    FOR i IN dataa'low TO dataa'high LOOP
      IF i >= datab'low AND i <= datab'high THEN
        IF dataa(i) = 'U' OR datab(i) = 'U' THEN
          equal                            := false;
        END IF;
        IF dataa(i) = '1' AND datab(i) = '0' THEN
          equal                            := false;
        END IF;
        IF dataa(i) = '0' AND datab(i) = '1' THEN
          equal                            := false;
        END IF;
      END IF;
    END LOOP;  -- i

    RETURN equal;
  END binary_compare;


        

  -----------------------------------------------------------------------------
  -- FUNCTION:  SLV_binary_encoder
  --
  -- DESCRIPTION:       Returns a binary encoded std_logic_vector
  --                    (from a decoded one-hot value)
  --
  -- INPUTS:
  --    vector       = one-hot encoded value
  --    output_width = width of "vector"
  --
  -- OUTPUT: binary encoded equivalent
  -----------------------------------------------------------------------------
  FUNCTION SLV_binary_encoder_of_width (vector : std_logic_vector; output_width : integer)
    RETURN std_logic_vector IS
    VARIABLE active_index                      : integer := 0;
  BEGIN
    FOR i IN 0 TO vector'length-1 LOOP
      IF (vector(i) = '1') THEN
        active_index                                     := i;
      END IF;
    END LOOP;

    RETURN int_2_std_logic_vector(active_index, output_width);
  END SLV_binary_encoder_of_width;



END iputils_slv;


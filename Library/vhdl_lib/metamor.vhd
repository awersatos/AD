-- mm 2.0.0
-------------------------------------------------------
-- Copyright (c) 2002 Altium Ltd.     
-- metamor.vhd
-- DO NOT CHANGE THIS FILE
-------------------------------------------------------

-------------------------------------------------------
-- package attributes
-- VHDL user defined attributes which have special
-- meaning to Metamor logic synthesis.
-------------------------------------------------------

package attributes is
  -------------------------------------------------------
  -- User defined place and route information passed to 
  -- output file
  -------------------------------------------------------
  attribute pinnum : string;
  attribute part_name : string;
  attribute property : string;
  
  -------------------------------------------------------
  -- User defined encoding of enumerated types
  -- apply to enumerated type declaration
  -------------------------------------------------------  
  attribute enum_encoding : string;
  
  -------------------------------------------------------
  -- User specified critical nodes
  -- apply to signal declaration
  -------------------------------------------------------
  attribute critical : boolean;
  
  -------------------------------------------------------
  -- User specified Macrocell component
  -- apply to component declaration
  -------------------------------------------------------
  attribute macrocell : boolean;
  
end attributes;


-------------------------------------------------------
-- package array arith
----------------------
-- Subprograms that allow arithmetic operations on arrays.
--
-- These are *magic* functions , they *must* reside in library metamor,
-- and *must* be used as described. 
-- BEWARE : these functions provide a superset of vhdl semantics , your 
-- VHDL simulator does not know these functions are magic. 
--
-- The intention is that these functions would be hidden from the end user
-- within some other function contained in a package. There would be 
-- two implementations of the package body, one optimized for synthesis
-- (uses these functions), and the other optimized for simulation.
-- 
-- The reason for supplying these magic functions is EEs seem to like
-- arrays of bits for arithmetic operations. VHDL provides arithmetic 
-- operations only for numeric types (integer..). In synthesis the convertion
-- an array_to_integer is slow to compile, and a general purpose function 
-- returns an integer type and not a constrained subtype, this may further 
-- slow compilation.
-- Also numeric operations are constained to no more than 31/32 bit.
--
-- Assumptions :
----------------
-- 1) function arguments : msb = 'left , and lsb = 'right = 0 AND decending 
--    i.e. subtype of arguments must be  bit_vector(N downto 0)
--    both arguments must be the same length.
--
-- 2) The result subtype depends on the funtion :
--    "+" , "-"              bit_vector(  N +1  downto 0)
--    "*"                    bit_vector( 2*N +1 downto 0)
--    "/" , "mod" , "rem"    bit_vector(   N    downto 0)
--
-- 3) These functions implement unsigned operations
--
-- 4) These functions are not constrained to 31 bits
--
-- Example :
------------
--   use metamor.array_arith.all;
--   function add (v1, v2 : bit_vector) return bit_vector is
--      variable i : natural := max (v1'length, v2'length);
--      variable l,r : bit_vector(i -1 downto 0);
--   begin
--      l := extendum(v1,i);  -- zero extend function
--      r := extendum(v2,i);
--      return l + r ;        -- magic bit_vector "+"
--   end;
--
-- More examples of the use of these functions can be found in vlbit.vhd
--
-------------------------------------------------------
package array_arith is
  function "+" (A,B: bit_vector) return bit_vector;
  function "-" (A,B: bit_vector) return bit_vector;
  function "*" (A,B: bit_vector) return bit_vector;
  function "/" (A,B: bit_vector) return bit_vector;
  function "mod" (A,B: bit_vector) return bit_vector;
  function "rem" (A,B: bit_vector) return bit_vector;
end array_arith;

package body array_arith is
  -- these function bodies are template , they are ignored by Metamor

  function "+" (A,B: bit_vector) return bit_vector is
  begin
    return a;
  end;

  function "-" (A,B: bit_vector) return bit_vector is
  begin
    return a;
  end;

  function "*" (A,B: bit_vector) return bit_vector is
  begin
    return a;
  end;

  function "/" (A,B: bit_vector) return bit_vector is
  begin
    return a;
  end;

  function "mod" (A,B: bit_vector) return bit_vector is
  begin
    return a;
  end;

  function "rem" (A,B: bit_vector) return bit_vector is
  begin
    return a;
  end;

end array_arith;


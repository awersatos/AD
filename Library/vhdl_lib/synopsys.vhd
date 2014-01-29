-- mm 2.4.6
-----------------------------------------------------------------------------
-- Synopsys package std_logic_arith optimized for use with Metamor logic
-- synthesis, by Altium Limited    
-- Includes packages std_logic_unsigned and std_logic_signed
-----------------------------------------------------------------------------
--                                                                         --
-- Copyright (c) 1994, 1990 - 1993 by Synopsys, Inc.  All rights reserved. --
--                                                                         --
-- This source file may be used and distributed without restriction        --
-- provided that this copyright statement is not removed from the file     --
-- and that any derivative work contains this copyright notice.            --
--                                                                         --
--                                                                         --
--  Package name: std_logic_arith                                          --
--                                                                         --
--  Description:  This package contains a set of arithmetic operators      --
--                and functions.                                           --
--                                                                         --
--                                                                         --
--                                                                         --
------------------------------------------------------------------------------
  
library IEEE;
use IEEE.std_logic_1164.ALL;

package std_logic_arith is
  
  type UNSIGNED is array (NATURAL range <>) of STD_LOGIC;
  type SIGNED is array (NATURAL range <>) of STD_LOGIC;
  subtype SMALL_INT is INTEGER range 0 to 1;
  
  function "+"(L: UNSIGNED; R: UNSIGNED) return UNSIGNED;
  function "+"(L: SIGNED; R: SIGNED) return SIGNED;
  function "+"(L: UNSIGNED; R: SIGNED) return SIGNED;
  function "+"(L: SIGNED; R: UNSIGNED) return SIGNED;
  function "+"(L: UNSIGNED; R: INTEGER) return UNSIGNED;
  function "+"(L: INTEGER; R: UNSIGNED) return UNSIGNED;
  function "+"(L: SIGNED; R: INTEGER) return SIGNED;
  function "+"(L: INTEGER; R: SIGNED) return SIGNED;
  function "+"(L: UNSIGNED; R: STD_ULOGIC) return UNSIGNED;
  function "+"(L: STD_ULOGIC; R: UNSIGNED) return UNSIGNED;
  function "+"(L: SIGNED; R: STD_ULOGIC) return SIGNED;
  function "+"(L: STD_ULOGIC; R: SIGNED) return SIGNED;
      
  function "+"(L: UNSIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR;
  function "+"(L: SIGNED; R: SIGNED) return STD_LOGIC_VECTOR;
  function "+"(L: UNSIGNED; R: SIGNED) return STD_LOGIC_VECTOR;
  function "+"(L: SIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR;
  function "+"(L: UNSIGNED; R: INTEGER) return STD_LOGIC_VECTOR;
  function "+"(L: INTEGER; R: UNSIGNED) return STD_LOGIC_VECTOR;
  function "+"(L: SIGNED; R: INTEGER) return STD_LOGIC_VECTOR;
  function "+"(L: INTEGER; R: SIGNED) return STD_LOGIC_VECTOR;
  function "+"(L: UNSIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR;
  function "+"(L: STD_ULOGIC; R: UNSIGNED) return STD_LOGIC_VECTOR;
  function "+"(L: SIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR;
  function "+"(L: STD_ULOGIC; R: SIGNED) return STD_LOGIC_VECTOR;
      
  function "-"(L: UNSIGNED; R: UNSIGNED) return UNSIGNED;
  function "-"(L: SIGNED; R: SIGNED) return SIGNED;
  function "-"(L: UNSIGNED; R: SIGNED) return SIGNED;
  function "-"(L: SIGNED; R: UNSIGNED) return SIGNED;
  function "-"(L: UNSIGNED; R: INTEGER) return UNSIGNED;
  function "-"(L: INTEGER; R: UNSIGNED) return UNSIGNED;
  function "-"(L: SIGNED; R: INTEGER) return SIGNED;
  function "-"(L: INTEGER; R: SIGNED) return SIGNED;
  function "-"(L: UNSIGNED; R: STD_ULOGIC) return UNSIGNED;
  function "-"(L: STD_ULOGIC; R: UNSIGNED) return UNSIGNED;
  function "-"(L: SIGNED; R: STD_ULOGIC) return SIGNED;
  function "-"(L: STD_ULOGIC; R: SIGNED) return SIGNED;
      
  function "-"(L: UNSIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR;
  function "-"(L: SIGNED; R: SIGNED) return STD_LOGIC_VECTOR;
  function "-"(L: UNSIGNED; R: SIGNED) return STD_LOGIC_VECTOR;
  function "-"(L: SIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR;
  function "-"(L: UNSIGNED; R: INTEGER) return STD_LOGIC_VECTOR;
  function "-"(L: INTEGER; R: UNSIGNED) return STD_LOGIC_VECTOR;
  function "-"(L: SIGNED; R: INTEGER) return STD_LOGIC_VECTOR;
  function "-"(L: INTEGER; R: SIGNED) return STD_LOGIC_VECTOR;
  function "-"(L: UNSIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR;
  function "-"(L: STD_ULOGIC; R: UNSIGNED) return STD_LOGIC_VECTOR;
  function "-"(L: SIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR;
  function "-"(L: STD_ULOGIC; R: SIGNED) return STD_LOGIC_VECTOR;
      
  function "+"(L: UNSIGNED) return UNSIGNED;
  function "+"(L: SIGNED) return SIGNED;
  function "-"(L: SIGNED) return SIGNED;
  function "ABS"(L: SIGNED) return SIGNED;
      
  function "+"(L: UNSIGNED) return STD_LOGIC_VECTOR;
  function "+"(L: SIGNED) return STD_LOGIC_VECTOR;
  function "-"(L: SIGNED) return STD_LOGIC_VECTOR;
  function "ABS"(L: SIGNED) return STD_LOGIC_VECTOR;
      
  function "*"(L: UNSIGNED; R: UNSIGNED) return UNSIGNED;
  function "*"(L: SIGNED; R: SIGNED) return SIGNED;
  function "*"(L: SIGNED; R: UNSIGNED) return SIGNED;
  function "*"(L: UNSIGNED; R: SIGNED) return SIGNED;
      
  function "*"(L: UNSIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR;
  function "*"(L: SIGNED; R: SIGNED) return STD_LOGIC_VECTOR;
  function "*"(L: SIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR;
  function "*"(L: UNSIGNED; R: SIGNED) return STD_LOGIC_VECTOR;
      
  function "<"(L: UNSIGNED; R: UNSIGNED) return BOOLEAN;
  function "<"(L: SIGNED; R: SIGNED) return BOOLEAN;
  function "<"(L: UNSIGNED; R: SIGNED) return BOOLEAN;
  function "<"(L: SIGNED; R: UNSIGNED) return BOOLEAN;
  function "<"(L: UNSIGNED; R: INTEGER) return BOOLEAN;
  function "<"(L: INTEGER; R: UNSIGNED) return BOOLEAN;
  function "<"(L: SIGNED; R: INTEGER) return BOOLEAN;
  function "<"(L: INTEGER; R: SIGNED) return BOOLEAN;
      
  function "<="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN;
  function "<="(L: SIGNED; R: SIGNED) return BOOLEAN;
  function "<="(L: UNSIGNED; R: SIGNED) return BOOLEAN;
  function "<="(L: SIGNED; R: UNSIGNED) return BOOLEAN;
  function "<="(L: UNSIGNED; R: INTEGER) return BOOLEAN;
  function "<="(L: INTEGER; R: UNSIGNED) return BOOLEAN;
  function "<="(L: SIGNED; R: INTEGER) return BOOLEAN;
  function "<="(L: INTEGER; R: SIGNED) return BOOLEAN;
      
  function ">"(L: UNSIGNED; R: UNSIGNED) return BOOLEAN;
  function ">"(L: SIGNED; R: SIGNED) return BOOLEAN;
  function ">"(L: UNSIGNED; R: SIGNED) return BOOLEAN;
  function ">"(L: SIGNED; R: UNSIGNED) return BOOLEAN;
  function ">"(L: UNSIGNED; R: INTEGER) return BOOLEAN;
  function ">"(L: INTEGER; R: UNSIGNED) return BOOLEAN;
  function ">"(L: SIGNED; R: INTEGER) return BOOLEAN;
  function ">"(L: INTEGER; R: SIGNED) return BOOLEAN;
      
  function ">="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN;
  function ">="(L: SIGNED; R: SIGNED) return BOOLEAN;
  function ">="(L: UNSIGNED; R: SIGNED) return BOOLEAN;
  function ">="(L: SIGNED; R: UNSIGNED) return BOOLEAN;
  function ">="(L: UNSIGNED; R: INTEGER) return BOOLEAN;
  function ">="(L: INTEGER; R: UNSIGNED) return BOOLEAN;
  function ">="(L: SIGNED; R: INTEGER) return BOOLEAN;
  function ">="(L: INTEGER; R: SIGNED) return BOOLEAN;
      
  function "="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN;
  function "="(L: SIGNED; R: SIGNED) return BOOLEAN;
  function "="(L: UNSIGNED; R: SIGNED) return BOOLEAN;
  function "="(L: SIGNED; R: UNSIGNED) return BOOLEAN;
  function "="(L: UNSIGNED; R: INTEGER) return BOOLEAN;
  function "="(L: INTEGER; R: UNSIGNED) return BOOLEAN;
  function "="(L: SIGNED; R: INTEGER) return BOOLEAN;
  function "="(L: INTEGER; R: SIGNED) return BOOLEAN;
      
  function "/="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN;
  function "/="(L: SIGNED; R: SIGNED) return BOOLEAN;
  function "/="(L: UNSIGNED; R: SIGNED) return BOOLEAN;
  function "/="(L: SIGNED; R: UNSIGNED) return BOOLEAN;
  function "/="(L: UNSIGNED; R: INTEGER) return BOOLEAN;
  function "/="(L: INTEGER; R: UNSIGNED) return BOOLEAN;
  function "/="(L: SIGNED; R: INTEGER) return BOOLEAN;
  function "/="(L: INTEGER; R: SIGNED) return BOOLEAN;
      
  function SHL(ARG: UNSIGNED; COUNT: UNSIGNED) return UNSIGNED;
  function SHL(ARG: SIGNED; COUNT: UNSIGNED) return SIGNED;
  function SHR(ARG: UNSIGNED; COUNT: UNSIGNED) return UNSIGNED;
  function SHR(ARG: SIGNED; COUNT: UNSIGNED) return SIGNED;
      
  function CONV_INTEGER(ARG: INTEGER) return INTEGER;
  function CONV_INTEGER(ARG: UNSIGNED) return NATURAL;
  function CONV_INTEGER(ARG: SIGNED) return INTEGER;
  function CONV_INTEGER(ARG: STD_ULOGIC) return SMALL_INT;
      
  function CONV_UNSIGNED(ARG: INTEGER; SIZE: INTEGER) return UNSIGNED;
  function CONV_UNSIGNED(ARG: UNSIGNED; SIZE: INTEGER) return UNSIGNED;
  function CONV_UNSIGNED(ARG: SIGNED; SIZE: INTEGER) return UNSIGNED;
  function CONV_UNSIGNED(ARG: STD_ULOGIC; SIZE: INTEGER) return UNSIGNED;
      
  function CONV_SIGNED(ARG: INTEGER; SIZE: INTEGER) return SIGNED;
  function CONV_SIGNED(ARG: UNSIGNED; SIZE: INTEGER) return SIGNED;
  function CONV_SIGNED(ARG: SIGNED; SIZE: INTEGER) return SIGNED;
  function CONV_SIGNED(ARG: STD_ULOGIC; SIZE: INTEGER) return SIGNED;
      
  function CONV_STD_LOGIC_VECTOR(ARG: INTEGER; SIZE: INTEGER) return STD_LOGIC_VECTOR;
  function CONV_STD_LOGIC_VECTOR(ARG: UNSIGNED; SIZE: INTEGER) return STD_LOGIC_VECTOR;
  function CONV_STD_LOGIC_VECTOR(ARG: SIGNED; SIZE: INTEGER) return STD_LOGIC_VECTOR;
  function CONV_STD_LOGIC_VECTOR(ARG: STD_ULOGIC; SIZE: INTEGER)  return STD_LOGIC_VECTOR;
-- zero extend STD_LOGIC_VECTOR (ARG) to SIZE, 
-- SIZE < 0 is same as SIZE = 0
-- returns STD_LOGIC_VECTOR(SIZE-1 downto 0)
  function EXT(ARG: STD_LOGIC_VECTOR; SIZE: INTEGER) return STD_LOGIC_VECTOR;

-- sign extend STD_LOGIC_VECTOR (ARG) to SIZE, 
-- SIZE < 0 is same as SIZE = 0
-- return STD_LOGIC_VECTOR(SIZE-1 downto 0)
  function SXT(ARG: STD_LOGIC_VECTOR; SIZE: INTEGER) return STD_LOGIC_VECTOR;
	    
end std_logic_arith;
	    
library metamor;
use metamor.array_arith.all;

package body std_logic_arith is
    
  function max(L, R: INTEGER) return INTEGER is
    variable result :INTEGER;
  begin
    if L > R then
      result := L;
    else
      result := R;
    end if;
      
    return result;
  end;
    
    
  function min(L, R: INTEGER) return INTEGER is
    variable result :INTEGER;
  begin
    if L < R then
      result := L;
    else
      result := R;
    end if;
    
    return result;
  end;
    
  type sl2b_type is array (std_logic) of bit;
  constant sl2b : sl2b_type := ('0', '0', '0', '1', '0', '0', '0', '0', '0');

  function to_bitvector ( s : signed ) return bit_vector is
    alias sv : signed ( s'length-1 downto 0 ) is s;
    variable result : bit_vector ( s'length-1 downto 0 );
  begin
    for i in result'range loop
      result(i) := sl2b(sv(i));
    end loop;
    return result;
  end;

    function to_bitvector ( s : unsigned ) return bit_vector is
        alias sv : unsigned ( s'length-1 downto 0 ) is s;
        variable result : bit_vector ( s'length-1 downto 0 );
    begin
        for i in result'range loop
            result(i) := sl2b(sv(i));
        end loop;
        return result;
    end;

    type b2sl_type is array (bit) of STD_LOGIC;
    constant b2sl : b2sl_type := ('0', '1');

    function to_signed ( s : bit_vector ) return signed is
        alias sv : bit_vector ( s'length-1 downto 0 ) is s;
        variable result : signed ( s'length-1 downto 0 );
    begin
        for i in result'range loop
            result(i) := b2sl(sv(i));
        end loop;
        return result;
    end;

    function to_unsigned ( s : bit_vector ) return unsigned is
        alias sv : bit_vector ( s'length-1 downto 0 ) is s;
        variable result : unsigned ( s'length-1 downto 0 );
    begin
        for i in result'range loop
            result(i) := b2sl(sv(i));
        end loop;
        return result;
    end;


    ---??????????
    type tbl_type is array (STD_ULOGIC) of STD_ULOGIC;
    constant tbl_BINARY : tbl_type :=
    ('X', 'X', '0', '1', 'X', 'X', '0', '1', 'X');
    
    type tbl_mvl9_boolean is array (STD_ULOGIC) of boolean;
    constant IS_X : tbl_mvl9_boolean :=
    (true, true, false, false, true, true, false, false, true);
    
    
    
  function MAKE_BINARY(A : STD_ULOGIC) return STD_ULOGIC is
  begin
    return A;
    end;
    
  function MAKE_BINARY(A : UNSIGNED) return UNSIGNED is
  begin
    return A;
    end;
    
  function MAKE_BINARY(A : UNSIGNED) return SIGNED is
  begin
    return SIGNED(A);
  end;
    
  function MAKE_BINARY(A : SIGNED) return UNSIGNED is
  begin
    return UNSIGNED(A);
  end;
    
  function MAKE_BINARY(A : SIGNED) return SIGNED is
  begin
    return A;
  end;
    
  function MAKE_BINARY(A : STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
  begin
    return A;
  end;
    
  function MAKE_BINARY(A : UNSIGNED) return STD_LOGIC_VECTOR is
  begin
    return STD_LOGIC_VECTOR(A);
  end;
    
  function MAKE_BINARY(A : SIGNED) return STD_LOGIC_VECTOR is
  begin
    return STD_LOGIC_VECTOR(A);
  end;
    
    
-- arrays need not have the same length 
  function mult(A,B: SIGNED) return SIGNED is
    variable PA: SIGNED(A'length+B'length-1 downto 0);
    variable Al: SIGNED(A'length -1 downto 0);
    variable Bl: SIGNED(B'length -1 downto 0);
    constant i : natural := max (a'length, b'length) - 1;
    variable l,r : bit_vector( i downto 0);
    variable s : bit_vector( 2*i + 1 downto 0);
    variable sign : boolean := false;
  begin
    if a(a'left) = '1' then
      al :=  - a;
      sign := not sign;
    else 
      al := a;
    end if;
    if b(b'left) = '1' then
      bl :=  - b;
      sign := not sign;
    else 
      bl := b;
    end if;
      
    l := to_bitvector(conv_signed(al,i +1));
    r := to_bitvector(conv_signed(bl,i +1));

    --* use Metamor internal operation
    s :=    l * r  ;

    pa := to_signed(s((A'length+B'length-1) downto 0));

    if sign then
      pa := - pa;
    end if;
    return(PA);
  end;

  function mult(A,B: UNSIGNED) return UNSIGNED is
    variable PA: UNSIGNED((A'length+B'length-1) downto 0);
    constant i : natural := max (a'length, b'length) -1;
    variable l,r : bit_vector( i downto 0);
    variable s : bit_vector( 2*i + 1 downto 0);
  begin
    l := to_bitvector(conv_unsigned(a,i +1));
    r := to_bitvector(conv_unsigned(b,i +1));
    --* use Metamor internal operation
    s :=  l * r  ;
    pa := to_unsigned(s((A'length+B'length-1) downto 0));
    return(PA);
  end;

    -- subtract two signed numbers of the same length
    -- both arrays must have range (msb downto 0)
  function minus(A, B: SIGNED) return SIGNED is
    variable sum: SIGNED (A'left +1 downto 0);
  begin
      --* use Metamor internal operation
    sum := to_signed( to_bitvector(A) - to_bitvector(B) ) ;
    return sum(a'left downto 0);
  end;

    -- add two signed numbers of the same length
    -- both arrays must have range (msb downto 0)
  function plus(A, B: SIGNED) return SIGNED is
    variable sum: SIGNED (A'left +1 downto 0);
  begin
      --* use Metamor internal operation
    sum := to_signed( to_bitvector(A) + to_bitvector(B) ) ;
    return sum (A'left downto 0);
  end;


    -- subtract two unsigned numbers of the same length
    -- both arrays must have range (msb downto 0)
  function unsigned_minus(A, B: UNSIGNED) return UNSIGNED is
    variable sum: UNSIGNED (A'left +1 downto 0);
  begin
      --* use Metamor internal operation
    sum := to_unsigned( to_bitvector(A) - to_bitvector(B) ) ;
    return sum(A'left downto 0);
  end;

    -- add two unsigned numbers of the same length
    -- both arrays must have range (msb downto 0)
  function unsigned_plus(A, B: UNSIGNED) return UNSIGNED is
    variable sum: UNSIGNED (A'left + 1 downto 0);
  begin
      --* use Metamor internal operation
    sum := to_unsigned( to_bitvector(A) + to_bitvector(B) ) ;
    return sum (A'left downto 0);
  end;



  function "*"(L: SIGNED; R: SIGNED) return SIGNED is
  begin
    return mult(CONV_SIGNED(L, L'length), CONV_SIGNED(R, R'length)); 
  end;
      
  function "*"(L: UNSIGNED; R: UNSIGNED) return UNSIGNED is
  begin
    return mult(CONV_UNSIGNED(L, L'length),  CONV_UNSIGNED(R, R'length));
  end;
        
  function "*"(L: UNSIGNED; R: SIGNED) return SIGNED is
  begin
    return mult(CONV_SIGNED(L, L'length+1), CONV_SIGNED(R, R'length));
  end;

  function "*"(L: SIGNED; R: UNSIGNED) return SIGNED is
  begin
    return mult(CONV_SIGNED(L, L'length), CONV_SIGNED(R, R'length+1));
  end;


  function "*"(L: SIGNED; R: SIGNED) return STD_LOGIC_VECTOR is
  begin
    return STD_LOGIC_VECTOR (mult(CONV_SIGNED(L, L'length),
				  CONV_SIGNED(R, R'length)));
  end;
      
  function "*"(L: UNSIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR is
  begin
    return STD_LOGIC_VECTOR (mult(CONV_UNSIGNED(L, L'length),
				  CONV_UNSIGNED(R, R'length)));
  end;
        
  function "*"(L: UNSIGNED; R: SIGNED) return STD_LOGIC_VECTOR is
  begin
    return STD_LOGIC_VECTOR (mult(CONV_SIGNED(L, L'length+1),
				  CONV_SIGNED(R, R'length))); 
  end;

  function "*"(L: SIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR is
  begin
    return STD_LOGIC_VECTOR (mult(CONV_SIGNED(L, L'length),
				  CONV_SIGNED(R, R'length+1)));
  end;


  function "+"(L: UNSIGNED; R: UNSIGNED) return UNSIGNED is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return unsigned_plus(CONV_UNSIGNED(L, length), CONV_UNSIGNED(R, length)); 
  end;


  function "+"(L: SIGNED; R: SIGNED) return SIGNED is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return plus(CONV_SIGNED(L, length), CONV_SIGNED(R, length)); 
  end;


  function "+"(L: UNSIGNED; R: SIGNED) return SIGNED is
    constant length: INTEGER := max(L'length + 1, R'length);
  begin
    return plus(CONV_SIGNED(L, length), CONV_SIGNED(R, length));
  end;


  function "+"(L: SIGNED; R: UNSIGNED) return SIGNED is
    constant length: INTEGER := max(L'length, R'length + 1);
  begin
    return plus(CONV_SIGNED(L, length), CONV_SIGNED(R, length)); 
  end;


  function "+"(L: UNSIGNED; R: INTEGER) return UNSIGNED is
    constant length: INTEGER := L'length + 1;
  begin
    return CONV_UNSIGNED(plus(CONV_SIGNED(L, length), CONV_SIGNED(R, length)),
		         length-1);
  end;


  function "+"(L: INTEGER; R: UNSIGNED) return UNSIGNED is
    constant length: INTEGER := R'length + 1;
  begin
    return CONV_UNSIGNED(plus(CONV_SIGNED(L, length), CONV_SIGNED(R, length)),
			 length-1);
  end;


  function "+"(L: SIGNED; R: INTEGER) return SIGNED is
    constant length: INTEGER := L'length;
  begin
    return plus(CONV_SIGNED(L, length), CONV_SIGNED(R, length));
  end;


  function "+"(L: INTEGER; R: SIGNED) return SIGNED is
    constant length: INTEGER := R'length;
  begin
    return plus(CONV_SIGNED(L, length), CONV_SIGNED(R, length));
  end;


  function "+"(L: UNSIGNED; R: STD_ULOGIC) return UNSIGNED is
    constant length: INTEGER := L'length;
  begin
    return unsigned_plus(CONV_UNSIGNED(L, length), CONV_UNSIGNED(R, length)) ;
  end;


  function "+"(L: STD_ULOGIC; R: UNSIGNED) return UNSIGNED is
    constant length: INTEGER := R'length;
  begin
    return unsigned_plus(CONV_UNSIGNED(L, length), CONV_UNSIGNED(R, length)); 
  end;


  function "+"(L: SIGNED; R: STD_ULOGIC) return SIGNED is
    constant length: INTEGER := L'length;
  begin
    return plus(CONV_SIGNED(L, length),  CONV_SIGNED(R, length));
  end;


  function "+"(L: STD_ULOGIC; R: SIGNED) return SIGNED is
    constant length: INTEGER := R'length;
  begin
    return plus(CONV_SIGNED(L, length), CONV_SIGNED(R, length)); 
  end;



  function "+"(L: UNSIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return STD_LOGIC_VECTOR (unsigned_plus(CONV_UNSIGNED(L, length),
					   CONV_UNSIGNED(R, length))); 
  end;


  function "+"(L: SIGNED; R: SIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return STD_LOGIC_VECTOR (plus(CONV_SIGNED(L, length),
				  CONV_SIGNED(R, length)));
  end;


  function "+"(L: UNSIGNED; R: SIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := max(L'length + 1, R'length);
  begin
    return STD_LOGIC_VECTOR (plus(CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length))); 
  end;


  function "+"(L: SIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := max(L'length, R'length + 1);
  begin
    return STD_LOGIC_VECTOR (plus(CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length))); 
  end;


  function "+"(L: UNSIGNED; R: INTEGER) return STD_LOGIC_VECTOR is
    constant length: INTEGER := L'length + 1;
  begin
    return STD_LOGIC_VECTOR (CONV_UNSIGNED(
		plus(
		    CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)),
		length-1));
  end;


  function "+"(L: INTEGER; R: UNSIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := R'length + 1;
  begin
    return STD_LOGIC_VECTOR (CONV_UNSIGNED(
		plus(
		    CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)),
		length-1));
  end;


  function "+"(L: SIGNED; R: INTEGER) return STD_LOGIC_VECTOR is
    constant length: INTEGER := L'length;
  begin
    return STD_LOGIC_VECTOR (plus(CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)));
  end;


  function "+"(L: INTEGER; R: SIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := R'length;
  begin
    return STD_LOGIC_VECTOR (plus(CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length))); 
  end;


  function "+"(L: UNSIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR is
    constant length: INTEGER := L'length;
  begin
    return STD_LOGIC_VECTOR (unsigned_plus(CONV_UNSIGNED(L, length),
		     CONV_UNSIGNED(R, length))) ; 
  end;


  function "+"(L: STD_ULOGIC; R: UNSIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := R'length;
  begin
    return STD_LOGIC_VECTOR (unsigned_plus(CONV_UNSIGNED(L, length),
		     CONV_UNSIGNED(R, length)));
  end;


  function "+"(L: SIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR is
    constant length: INTEGER := L'length;
  begin
    return STD_LOGIC_VECTOR (plus(CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length))); 
  end;


  function "+"(L: STD_ULOGIC; R: SIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := R'length;
  begin
    return STD_LOGIC_VECTOR (plus(CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length))); 
  end;



  function "-"(L: UNSIGNED; R: UNSIGNED) return UNSIGNED is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return unsigned_minus(CONV_UNSIGNED(L, length),
		      	      CONV_UNSIGNED(R, length)); 
  end;


  function "-"(L: SIGNED; R: SIGNED) return SIGNED is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length));
  end;


  function "-"(L: UNSIGNED; R: SIGNED) return SIGNED is
    constant length: INTEGER := max(L'length + 1, R'length);
  begin
    return minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)); 
  end;


  function "-"(L: SIGNED; R: UNSIGNED) return SIGNED is
    constant length: INTEGER := max(L'length, R'length + 1);
  begin
    return minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length));
  end;


  function "-"(L: UNSIGNED; R: INTEGER) return UNSIGNED is
    constant length: INTEGER := L'length + 1;
  begin
    return CONV_UNSIGNED(
		minus(
		    CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)),
		length-1);
  end;


  function "-"(L: INTEGER; R: UNSIGNED) return UNSIGNED is
    constant length: INTEGER := R'length + 1;
  begin
    return CONV_UNSIGNED(
		minus(
		    CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)),
		length-1);
  end;


  function "-"(L: SIGNED; R: INTEGER) return SIGNED is
    constant length: INTEGER := L'length;
  begin
    return minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length));
  end;


  function "-"(L: INTEGER; R: SIGNED) return SIGNED is
    constant length: INTEGER := R'length;
  begin
    return minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)); 
  end;


  function "-"(L: UNSIGNED; R: STD_ULOGIC) return UNSIGNED is
    constant length: INTEGER := L'length + 1;
  begin
    return CONV_UNSIGNED(
		minus( 
		    CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)),
		length-1);
  end;


  function "-"(L: STD_ULOGIC; R: UNSIGNED) return UNSIGNED is
    constant length: INTEGER := R'length + 1;
  begin
    return CONV_UNSIGNED(
		minus( 
		    CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)),
		length-1);
  end;


  function "-"(L: SIGNED; R: STD_ULOGIC) return SIGNED is
    constant length: INTEGER := L'length;
  begin
    return minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)); 
  end;


  function "-"(L: STD_ULOGIC; R: SIGNED) return SIGNED is
    constant length: INTEGER := R'length;
  begin
    return minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)); 
  end;




  function "-"(L: UNSIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return STD_LOGIC_VECTOR (unsigned_minus(CONV_UNSIGNED(L, length),
		      	      CONV_UNSIGNED(R, length)));
  end;


  function "-"(L: SIGNED; R: SIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return STD_LOGIC_VECTOR (minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length))); 
  end;


  function "-"(L: UNSIGNED; R: SIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := max(L'length + 1, R'length);
  begin
    return STD_LOGIC_VECTOR (minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)));
  end;


  function "-"(L: SIGNED; R: UNSIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := max(L'length, R'length + 1);
  begin
    return STD_LOGIC_VECTOR (minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length))); 
  end;


  function "-"(L: UNSIGNED; R: INTEGER) return STD_LOGIC_VECTOR is
    constant length: INTEGER := L'length + 1;
  begin
    return STD_LOGIC_VECTOR (CONV_UNSIGNED(
		minus( 
		    CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)),
		length-1));
  end;


  function "-"(L: INTEGER; R: UNSIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := R'length + 1;
  begin
    return STD_LOGIC_VECTOR (CONV_UNSIGNED(
		minus(
		    CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)),
		length-1));
  end;


  function "-"(L: SIGNED; R: INTEGER) return STD_LOGIC_VECTOR is
    constant length: INTEGER := L'length;
  begin
    return STD_LOGIC_VECTOR (minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)));
  end;


  function "-"(L: INTEGER; R: SIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := R'length;
  begin
    return STD_LOGIC_VECTOR (minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)));
  end;


  function "-"(L: UNSIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR is
    constant length: INTEGER := L'length + 1;
  begin
    return STD_LOGIC_VECTOR (CONV_UNSIGNED(
		minus(
		    CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)),
		length-1));
  end;


  function "-"(L: STD_ULOGIC; R: UNSIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := R'length + 1;
  begin
    return STD_LOGIC_VECTOR (CONV_UNSIGNED(
		minus(
		    CONV_SIGNED(L, length),
		    CONV_SIGNED(R, length)),
		length-1));
  end;


  function "-"(L: SIGNED; R: STD_ULOGIC) return STD_LOGIC_VECTOR is
    constant length: INTEGER := L'length;
  begin
    return STD_LOGIC_VECTOR (minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)));
  end;


  function "-"(L: STD_ULOGIC; R: SIGNED) return STD_LOGIC_VECTOR is
    constant length: INTEGER := R'length;
  begin
    return STD_LOGIC_VECTOR (minus(CONV_SIGNED(L, length),
		     CONV_SIGNED(R, length)));
  end;




  function "+"(L: UNSIGNED) return UNSIGNED is
  begin
    return L;
  end;


  function "+"(L: SIGNED) return SIGNED is
  begin
    return L;
  end;


  function "-"(L: SIGNED) return SIGNED is
  begin
    return 0 - L; 
  end;


  function "ABS"(L: SIGNED) return SIGNED is
    variable result: SIGNED(L'length-1 downto 0);
  begin
    if (L(L'left) = '0' or L(L'left) = 'L') then
      result := L;
    else
      result :=  0 - L;
    end if;

    return result;
  end;


  function "+"(L: UNSIGNED) return STD_LOGIC_VECTOR is
  begin
    return STD_LOGIC_VECTOR (L);
  end;


  function "+"(L: SIGNED) return STD_LOGIC_VECTOR is
  begin
    return STD_LOGIC_VECTOR (L);
  end;


  function "-"(L: SIGNED) return STD_LOGIC_VECTOR is
    variable tmp: SIGNED(L'length-1 downto 0);
  begin
    tmp := 0 - L;  
    return STD_LOGIC_VECTOR (tmp); 
  end;


  function "ABS"(L: SIGNED) return STD_LOGIC_VECTOR is
    variable tmp: SIGNED(L'length-1 downto 0);
  begin
    if (L(L'left) = '0' or L(L'left) = 'L') then
      tmp := L;
    else
      tmp := 0 - L;
    end if;

    return STD_LOGIC_VECTOR (tmp);
  end;

    -- compare two signed numbers of the same length
    -- both arrays must have range (msb downto 0)
  function is_less(A, B: SIGNED) return BOOLEAN is
    constant sign: INTEGER := A'left;
    variable result : boolean;
  begin
    if A(sign) /= B(sign) then
      result := A(sign) = '1';
    elsif sign = 0 then
      result := false;
    else   
      result := to_bitvector(A(sign -1 downto 0)) <  
                  to_bitvector(B(sign -1 downto 0));
    end if;
    return result;
  end;


    -- compare two signed numbers of the same length
    -- both arrays must have range (msb downto 0)
  function is_less_or_equal(A, B: SIGNED) return BOOLEAN is
    constant sign: INTEGER := A'left;
    variable a_is_0, b_is_1, result : boolean;
  begin
    if A(sign) /= B(sign) then
      result := A(sign) = '1';
    elsif sign = 0 then
      result := A(sign) = B(sign);
    else   
      result := to_bitvector(A(sign -1 downto 0)) <=  
	      to_bitvector(B(sign -1 downto 0));
    end if;
    return result;
  end;



    -- compare two unsigned numbers of the same length
    -- both arrays must have range (msb downto 0)
  function unsigned_is_less(A, B: UNSIGNED) return BOOLEAN is
  begin
    return to_bitvector(A) < to_bitvector(B);
  end;


    -- compare two unsigned numbers of the same length
    -- both arrays must have range (msb downto 0)
  function unsigned_is_less_or_equal(A, B: UNSIGNED) return BOOLEAN is
  begin
    return to_bitvector(A) <= to_bitvector(B);
  end;




  function "<"(L: UNSIGNED; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return unsigned_is_less(CONV_UNSIGNED(L, length),
				CONV_UNSIGNED(R, length));
  end;


  function "<"(L: SIGNED; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return is_less(CONV_SIGNED(L, length),
			CONV_SIGNED(R, length));
  end;


  function "<"(L: UNSIGNED; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length + 1, R'length);
  begin
    return is_less(CONV_SIGNED(L, length),
			CONV_SIGNED(R, length));
  end;


  function "<"(L: SIGNED; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length + 1);
  begin
    return is_less(CONV_SIGNED(L, length),
			CONV_SIGNED(R, length));
  end;


  function "<"(L: UNSIGNED; R: INTEGER) return BOOLEAN is
    constant length: INTEGER := L'length + 1;
  begin
    return is_less(CONV_SIGNED(L, length),
			CONV_SIGNED(R, length));
  end;


  function "<"(L: INTEGER; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := R'length + 1;
  begin
    return is_less(CONV_SIGNED(L, length),
			CONV_SIGNED(R, length)); 
  end;


  function "<"(L: SIGNED; R: INTEGER) return BOOLEAN is
    constant length: INTEGER := L'length;
  begin
    return is_less(CONV_SIGNED(L, length),
			CONV_SIGNED(R, length));
  end;


  function "<"(L: INTEGER; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := R'length;
  begin
    return is_less(CONV_SIGNED(L, length),
			CONV_SIGNED(R, length));
  end;


  function "<="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return unsigned_is_less_or_equal(CONV_UNSIGNED(L, length),
			     CONV_UNSIGNED(R, length)); 
  end;


  function "<="(L: SIGNED; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return is_less_or_equal(CONV_SIGNED(L, length),
				CONV_SIGNED(R, length));
  end;


  function "<="(L: UNSIGNED; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length + 1, R'length);
  begin
    return is_less_or_equal(CONV_SIGNED(L, length),
				CONV_SIGNED(R, length)); 
  end;


  function "<="(L: SIGNED; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length + 1);
  begin
    return is_less_or_equal(CONV_SIGNED(L, length),
				CONV_SIGNED(R, length));
  end;


  function "<="(L: UNSIGNED; R: INTEGER) return BOOLEAN is
    constant length: INTEGER := L'length + 1;
  begin
    return is_less_or_equal(CONV_SIGNED(L, length),
				CONV_SIGNED(R, length));
  end;


  function "<="(L: INTEGER; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := R'length + 1;
  begin
    return is_less_or_equal(CONV_SIGNED(L, length),
				CONV_SIGNED(R, length)); 
  end;


  function "<="(L: SIGNED; R: INTEGER) return BOOLEAN is
    constant length: INTEGER := L'length;
  begin
    return is_less_or_equal(CONV_SIGNED(L, length),
				CONV_SIGNED(R, length)); 
  end;


  function "<="(L: INTEGER; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := R'length;
  begin
    return is_less_or_equal(CONV_SIGNED(L, length),
				CONV_SIGNED(R, length));
  end;


  function ">"(L: UNSIGNED; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return unsigned_is_less(CONV_UNSIGNED(R, length),
				CONV_UNSIGNED(L, length)); 
  end;


  function ">"(L: SIGNED; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return is_less(CONV_SIGNED(R, length),
		       CONV_SIGNED(L, length));
  end;


  function ">"(L: UNSIGNED; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length + 1, R'length);
  begin
    return is_less(CONV_SIGNED(R, length),
		       CONV_SIGNED(L, length));
  end;


  function ">"(L: SIGNED; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length + 1);
  begin
    return is_less(CONV_SIGNED(R, length),
		       CONV_SIGNED(L, length)); 
  end;


  function ">"(L: UNSIGNED; R: INTEGER) return BOOLEAN is
    constant length: INTEGER := L'length + 1;
  begin
    return is_less(CONV_SIGNED(R, length),
		       CONV_SIGNED(L, length));
  end;


  function ">"(L: INTEGER; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := R'length + 1;
  begin
    return is_less(CONV_SIGNED(R, length),
		       CONV_SIGNED(L, length));
  end;


  function ">"(L: SIGNED; R: INTEGER) return BOOLEAN is
    constant length: INTEGER := L'length;
  begin
    return is_less(CONV_SIGNED(R, length),
		       CONV_SIGNED(L, length)); 
  end;


  function ">"(L: INTEGER; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := R'length;
  begin
    return is_less(CONV_SIGNED(R, length),
		       CONV_SIGNED(L, length));
  end;


  function ">="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return unsigned_is_less_or_equal(CONV_UNSIGNED(R, length),
				 CONV_UNSIGNED(L, length));
  end;


  function ">="(L: SIGNED; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return is_less_or_equal(CONV_SIGNED(R, length),
				CONV_SIGNED(L, length));
  end;


  function ">="(L: UNSIGNED; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length + 1, R'length);
  begin
    return is_less_or_equal(CONV_SIGNED(R, length),
				CONV_SIGNED(L, length));
  end;


  function ">="(L: SIGNED; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length + 1);
  begin
    return is_less_or_equal(CONV_SIGNED(R, length),
				CONV_SIGNED(L, length)); 
  end;


  function ">="(L: UNSIGNED; R: INTEGER) return BOOLEAN is
    constant length: INTEGER := L'length + 1;
  begin
    return is_less_or_equal(CONV_SIGNED(R, length),
				CONV_SIGNED(L, length));
  end;


  function ">="(L: INTEGER; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := R'length + 1;
  begin
    return is_less_or_equal(CONV_SIGNED(R, length),
				CONV_SIGNED(L, length));
  end;


  function ">="(L: SIGNED; R: INTEGER) return BOOLEAN is
    constant length: INTEGER := L'length;
  begin
    return is_less_or_equal(CONV_SIGNED(R, length),
				CONV_SIGNED(L, length)); 
  end;


  function ">="(L: INTEGER; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := R'length;
  begin
    return is_less_or_equal(CONV_SIGNED(R, length),
				CONV_SIGNED(L, length));
  end;




    -- for internal use only.  Assumes SIGNED arguments of equal length.
  function bitwise_eql(L: STD_ULOGIC_VECTOR; R: STD_ULOGIC_VECTOR)
					    return BOOLEAN is
  begin
   return L = R ;
  end;

    -- for internal use only.  Assumes SIGNED arguments of equal length.
  function bitwise_neq(L: STD_ULOGIC_VECTOR; R: STD_ULOGIC_VECTOR)
					    return BOOLEAN is
  begin
    return L /= R;
  end;


  function "="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return bitwise_eql( STD_ULOGIC_VECTOR( CONV_UNSIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_UNSIGNED(R, length) ) );
  end;


  function "="(L: SIGNED; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return bitwise_eql( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
  end;


  function "="(L: UNSIGNED; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length + 1, R'length);
  begin
    return bitwise_eql( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
  end;


  function "="(L: SIGNED; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length + 1);
  begin
    return bitwise_eql( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
  end;


  function "="(L: UNSIGNED; R: INTEGER) return BOOLEAN is
    constant length: INTEGER := L'length + 1;
  begin
    return bitwise_eql( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
  end;


  function "="(L: INTEGER; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := R'length + 1;
  begin
    return bitwise_eql( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
  end;


  function "="(L: SIGNED; R: INTEGER) return BOOLEAN is
    constant length: INTEGER := L'length;
  begin
    return bitwise_eql( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
  end;


  function "="(L: INTEGER; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := R'length;
  begin
    return bitwise_eql( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
  end;




  function "/="(L: UNSIGNED; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return bitwise_neq( STD_ULOGIC_VECTOR( CONV_UNSIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_UNSIGNED(R, length) ) );
  end;


  function "/="(L: SIGNED; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length);
  begin
    return bitwise_neq( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
  end;


  function "/="(L: UNSIGNED; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length + 1, R'length);
  begin
    return bitwise_neq( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
  end;


  function "/="(L: SIGNED; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := max(L'length, R'length + 1);
  begin
    return bitwise_neq( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
  end;


  function "/="(L: UNSIGNED; R: INTEGER) return BOOLEAN is
    constant length: INTEGER := L'length + 1;
  begin
    return bitwise_neq( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
  end;


  function "/="(L: INTEGER; R: UNSIGNED) return BOOLEAN is
    constant length: INTEGER := R'length + 1;
  begin
    return bitwise_neq( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
  end;


  function "/="(L: SIGNED; R: INTEGER) return BOOLEAN is
    constant length: INTEGER := L'length;
  begin
    return bitwise_neq( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
  end;


  function "/="(L: INTEGER; R: SIGNED) return BOOLEAN is
    constant length: INTEGER := R'length;
  begin
    return bitwise_neq( STD_ULOGIC_VECTOR( CONV_SIGNED(L, length) ),
		STD_ULOGIC_VECTOR( CONV_SIGNED(R, length) ) );
  end;



  function SHL(ARG: UNSIGNED; COUNT: UNSIGNED) return UNSIGNED is
    variable result : UNSIGNED (ARG'length-1 downto 0); 
  begin
    result := to_unsigned(to_bitvector(arg) sll CONV_INTEGER(count));
    return result;
  end;

  function SHL(ARG: SIGNED; COUNT: UNSIGNED) return SIGNED is
    variable result : SIGNED (ARG'length-1 downto 0); 
  begin
    result := to_signed(to_bitvector(arg) sll CONV_INTEGER(count));
    return result;
  end;


  function SHR(ARG: UNSIGNED; COUNT: UNSIGNED) return UNSIGNED is
    variable result : UNSIGNED (ARG'length-1 downto 0); 
  begin
    result := to_unsigned(to_bitvector(arg) srl CONV_INTEGER(count));
    return result;
  end;

  function SHR(ARG: SIGNED; COUNT: UNSIGNED) return SIGNED is
    variable result : SIGNED (ARG'length-1 downto 0); 
  begin
    result := to_signed(to_bitvector(arg) sra CONV_INTEGER(count));
    return result;
  end;


  function TO_INTEGER(ARG: bit_vector) return INTEGER is
    attribute array_to_numeric : boolean;
    attribute array_to_numeric of to_integer : function is true;
    variable result : integer;
  begin
    return result;
  end;

  function TO_NATURAL(ARG: bit_vector) return INTEGER is
    attribute array_to_numeric : boolean;
    attribute array_to_numeric of to_natural : function is true;
    variable result : natural;
  begin
    return result;
  end;


  function CONV_INTEGER(ARG: INTEGER) return INTEGER is
  begin
    return ARG;
  end;

  function CONV_INTEGER(ARG: UNSIGNED) return NATURAL is
  begin
    assert ARG'length <= 31
      report "ARG is too large in CONV_INTEGER"
      severity FAILURE;
    return to_natural(to_bitvector(ARG));
  end;


  function CONV_INTEGER(ARG: SIGNED) return INTEGER is
  begin
    assert ARG'length <= 32
      report "ARG is too large in CONV_INTEGER"
      severity FAILURE;
    return to_integer(to_bitvector(ARG));
  end;


  function CONV_INTEGER(ARG: STD_ULOGIC) return SMALL_INT is
    variable result : SMALL_INT;
  begin
    if ARG = '1' then
      result := 1;
    else
      result := 0;
    end if;
        
    return result;
  end;


    -- convert an integer to a unsigned STD_ULOGIC_VECTOR
  function CONV_UNSIGNED(ARG: INTEGER; SIZE: INTEGER) return UNSIGNED is
    variable result: UNSIGNED(SIZE-1 downto 0);
    variable temp: natural;
    attribute numeric_to_array : boolean;
    attribute numeric_to_array of conv_unsigned : function is true;
  begin
    temp := ARG;
    for i in 0 to SIZE-1 loop
      if (temp mod 2) = 1 then
      	result(i) := '1';
      else 
    	result(i) := '0';
      end if;
      if temp > 0 then
       	temp := temp / 2;
      else
      	temp := (temp - 1) / 2; -- simulate ASR
      end if;
    end loop;
    return result;
  end;


  function CONV_UNSIGNED(ARG: UNSIGNED; SIZE: INTEGER) return UNSIGNED is
    constant msb: INTEGER := min(ARG'length, SIZE) - 1;
    subtype rtype is UNSIGNED (SIZE-1 downto 0);
    variable new_bounds: UNSIGNED (ARG'length-1 downto 0);
    variable result: rtype;
  begin
    new_bounds := arg;
    result := rtype'(others => '0');
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
  end;


  function CONV_UNSIGNED(ARG: SIGNED; SIZE: INTEGER) return UNSIGNED is
    constant msb: INTEGER := min(ARG'length, SIZE) - 1;
    subtype rtype is UNSIGNED (SIZE-1 downto 0);
    variable new_bounds: UNSIGNED (ARG'length-1 downto 0);
    variable result: rtype;
  begin
    new_bounds := MAKE_BINARY(ARG);
    result := rtype'(others => new_bounds(new_bounds'left));
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
  end;


  function CONV_UNSIGNED(ARG: STD_ULOGIC; SIZE: INTEGER) return UNSIGNED is
    subtype rtype is UNSIGNED (SIZE-1 downto 0);
    variable result: rtype;
  begin
    result := rtype'(others => '0');
    result(0) := ARG;
    return result;
  end;


    -- convert an integer to a 2's complement STD_ULOGIC_VECTOR
  function CONV_SIGNED(ARG: INTEGER; SIZE: INTEGER) return SIGNED is
    variable result: SIGNED (SIZE-1 downto 0);
    variable temp: natural;
    variable b_val : std_logic;
    attribute numeric_to_array : boolean;
    attribute numeric_to_array of conv_signed : function is true;
  begin
    if arg < 0 then
      temp := -(arg+1) ;
      b_val := '1' ;
    else
      temp := arg ;
      b_val := '0' ;
    end if ;
    for i in 0 to size -1 loop
      if (temp MOD 2) = 0 then
	result(i) := b_val;
      else 
	result(i) := not b_val ;
      end if;
      temp := temp/2 ;
    end loop;

    return result;
  end;



  function CONV_SIGNED(ARG: UNSIGNED; SIZE: INTEGER) return SIGNED is
    constant msb: INTEGER := min(ARG'length, SIZE) - 1;
    subtype rtype is SIGNED (SIZE-1 downto 0);
    variable new_bounds : SIGNED (ARG'length-1 downto 0);
    variable result: rtype;
  begin
    new_bounds := MAKE_BINARY(ARG);
    result := rtype'(others => '0');
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
  end;

  function CONV_SIGNED(ARG: SIGNED; SIZE: INTEGER) return SIGNED is
    constant msb: INTEGER := min(ARG'length, SIZE) - 1;
	subtype rtype is SIGNED (SIZE-1 downto 0);
    variable new_bounds : SIGNED (ARG'length-1 downto 0);
    variable result: rtype;
  begin
    new_bounds := ARG;
    result := rtype'(others => new_bounds(new_bounds'left));
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
  end;


  function CONV_SIGNED(ARG: STD_ULOGIC; SIZE: INTEGER) return SIGNED is
    subtype rtype is SIGNED (SIZE-1 downto 0);
    variable result: rtype;
  begin
    result := rtype'(others => '0');
    result(0) := ARG;
    return result;
  end;


    -- convert an integer to an STD_LOGIC_VECTOR
  function CONV_STD_LOGIC_VECTOR(ARG: INTEGER; SIZE: INTEGER) return STD_LOGIC_VECTOR is
    variable result: STD_LOGIC_VECTOR (SIZE-1 downto 0);
    variable temp: integer;

    attribute numeric_to_array : boolean;
    attribute numeric_to_array of conv_std_logic_vector : function is true;

  begin
    temp := ARG;
    for i in 0 to SIZE-1 loop
      if (temp mod 2) = 1 then
        result(i) := '1';
      else 
        result(i) := '0';
      end if;
      if temp > 0 then
	temp := temp / 2;
      else
  	temp := (temp - 1) / 2; -- simulate ASR
      end if;
    end loop;
    return result;
  end;


  function CONV_STD_LOGIC_VECTOR(ARG: UNSIGNED; SIZE: INTEGER) return STD_LOGIC_VECTOR is
    constant msb: INTEGER := min(ARG'length, SIZE) - 1;
    subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
    variable new_bounds : STD_LOGIC_VECTOR (ARG'length-1 downto 0);
    variable result: rtype;
  begin
    new_bounds := MAKE_BINARY(ARG);
    result := rtype'(others => '0');
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
  end;

  function CONV_STD_LOGIC_VECTOR(ARG: SIGNED; SIZE: INTEGER) return STD_LOGIC_VECTOR is
    constant msb: INTEGER := min(ARG'length, SIZE) - 1;
    subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
    variable new_bounds : STD_LOGIC_VECTOR (ARG'length-1 downto 0);
    variable result: rtype;
  begin
    new_bounds := MAKE_BINARY(ARG);
    result := rtype'(others => new_bounds(new_bounds'left));
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
  end;


  function CONV_STD_LOGIC_VECTOR(ARG: STD_ULOGIC; SIZE: INTEGER) return STD_LOGIC_VECTOR is
    subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
    variable result: rtype;
  begin
    result := rtype'(others => '0');
    result(0) := ARG;
    return result;
  end;

  function EXT(ARG: STD_LOGIC_VECTOR; SIZE: INTEGER) return STD_LOGIC_VECTOR is
    constant msb: INTEGER := min(ARG'length, SIZE) - 1;
    subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
    variable new_bounds: STD_LOGIC_VECTOR (ARG'length-1 downto 0);
    variable result: rtype;
  begin
    new_bounds := MAKE_BINARY(ARG);
    result := rtype'(others => '0');
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
  end;


  function SXT(ARG: STD_LOGIC_VECTOR; SIZE: INTEGER) return STD_LOGIC_VECTOR is
    constant msb: INTEGER := min(ARG'length, SIZE) - 1;
    subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
    variable new_bounds : STD_LOGIC_VECTOR (ARG'length-1 downto 0);
    variable result: rtype;
  begin
    new_bounds := ARG;
    result := rtype'(others => new_bounds(new_bounds'left));
    result(msb downto 0) := new_bounds(msb downto 0);
    return result;
  end;


end std_logic_arith;


--------------------------------------------------------------------------
--                                                                      --
-- Copyright (c) 1990, 1991, 1992 by Synopsys, Inc.                     --
--                                             All rights reserved.     --
--                                                                      --
-- This source file may be used and distributed without restriction     --
-- provided that this copyright statement is not removed from the file  --
-- and that any derivative work contains this copyright notice.         --
--                                                                      --
--	Package name: STD_LOGIC_UNSIGNED                                --
--                                 					--
--									--
--      Date:        	09/11/92	KN				--
--			10/08/92 	AMT				--
--									--
--	Purpose: 							--
--	 A set of unsigned arithemtic, conversion,                      --
--           and comparision functions for STD_LOGIC_VECTOR.            --
--									--
--	Note:  comparision of same length discrete arrays is defined	--
--		by the LRM.  This package will "overload" those 	--
--		definitions						--
--									--
--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.std_logic_arith.all;

package STD_LOGIC_UNSIGNED is

    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "+"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
    function "+"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR;
    function "+"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
    function "-"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "+"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "*"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "<"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "<"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "<"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function "<="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "<="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "<="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function ">"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function ">"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function ">"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function ">="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function ">="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function ">="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function "="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function "/="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "/="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "/="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function SHL(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function SHR(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function CONV_INTEGER(ARG: STD_LOGIC_VECTOR) return INTEGER;

-- remove this since it is already in std_logic_arith
--    function CONV_STD_LOGIC_VECTOR(ARG: INTEGER; SIZE: INTEGER) return STD_LOGIC_VECTOR;

end STD_LOGIC_UNSIGNED;



library IEEE;
use IEEE.std_logic_1164.all;
use work.std_logic_arith.all;

package body STD_LOGIC_UNSIGNED is


    function maximum(L, R: INTEGER) return INTEGER is
    begin
        if L > R then
            return L;
        else
            return R;
        end if;
    end;


    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to plus
        constant length: INTEGER := maximum(L'length, R'length);
        variable result  : STD_LOGIC_VECTOR (length-1 downto 0);
    begin
        result  := UNSIGNED(L) + UNSIGNED(R);-- pragma label plus
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to plus
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := UNSIGNED(L) + R;-- pragma label plus
        return   std_logic_vector(result);
    end;

    function "+"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to plus
        variable result  : STD_LOGIC_VECTOR (R'range);
    begin
        result  := L + UNSIGNED(R);-- pragma label plus
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to plus
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := UNSIGNED(L) + R;-- pragma label plus
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
            -- pragma label_applies_to plus
    variable result  : STD_LOGIC_VECTOR (R'range);
    begin
        result  := L + UNSIGNED(R);-- pragma label plus
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to minus
        constant length: INTEGER := maximum(L'length, R'length);
        variable result  : STD_LOGIC_VECTOR (length-1 downto 0);
    begin
        result  := UNSIGNED(L) - UNSIGNED(R); -- pragma label minus
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to minus
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := UNSIGNED(L) - R; -- pragma label minus
        return   std_logic_vector(result);
    end;

    function "-"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to minus
        variable result  : STD_LOGIC_VECTOR (R'range);
    begin
        result  := L - UNSIGNED(R);  -- pragma label minus
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := UNSIGNED(L) - R;
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to minus
        variable result  : STD_LOGIC_VECTOR (R'range);
    begin
        result  := L - UNSIGNED(R);  -- pragma label minus
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := + UNSIGNED(L);
        return   std_logic_vector(result);
    end;

    function "*"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to mult
        constant length: INTEGER := maximum(L'length, R'length);
        variable result  : STD_LOGIC_VECTOR ((L'length+R'length-1) downto 0);
    begin
        result  := UNSIGNED(L) * UNSIGNED(R); -- pragma label mult
        return   std_logic_vector(result);
    end;
        
    function "<"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to lt
        constant length: INTEGER := maximum(L'length, R'length);
    begin
        return   UNSIGNED(L) < UNSIGNED(R); -- pragma label lt
    end;

    function "<"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
        -- pragma label_applies_to lt
    begin
        return   UNSIGNED(L) < R; -- pragma label lt
    end;

    function "<"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to lt
    begin
        return   L < UNSIGNED(R); -- pragma label lt
    end;

    function "<="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
       -- pragma label_applies_to leq
    begin
        return   UNSIGNED(L) <= UNSIGNED(R); -- pragma label leq
    end;

    function "<="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
       -- pragma label_applies_to leq
    begin
        return   UNSIGNED(L) <= R; -- pragma label leq
    end;

    function "<="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
       -- pragma label_applies_to leq
    begin
        return   L <= UNSIGNED(R); -- pragma label leq
    end;

    function ">"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to gt
    begin
        return   UNSIGNED(L) > UNSIGNED(R); -- pragma label gt
    end;

    function ">"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
        -- pragma label_applies_to gt
    begin
        return   UNSIGNED(L) > R; -- pragma label gt
    end;

    function ">"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to gt
    begin
        return   L > UNSIGNED(R); -- pragma label gt
    end;

    function ">="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to geq
    begin
        return   UNSIGNED(L) >= UNSIGNED(R);  -- pragma label geq
    end;

    function ">="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
        -- pragma label_applies_to geq
    begin
        return   UNSIGNED(L) >= R;  -- pragma label geq
    end;

    function ">="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to geq
    begin
        return   L >= UNSIGNED(R);  -- pragma label geq
    end;

    function "="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   UNSIGNED(L) = UNSIGNED(R);
    end;

    function "="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
    begin
        return   UNSIGNED(L) = R;
    end;

    function "="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   L = UNSIGNED(R);
    end;

    function "/="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   UNSIGNED(L) /= UNSIGNED(R);
    end;

    function "/="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
    begin
        return   UNSIGNED(L) /= R;
    end;

    function "/="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   L /= UNSIGNED(R);
    end;

    function CONV_INTEGER(ARG: STD_LOGIC_VECTOR) return INTEGER is
        variable result    : UNSIGNED(ARG'range);
    begin
        result    := UNSIGNED(ARG);
        return   CONV_INTEGER(result);
    end;
    function SHL(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
    begin
       return STD_LOGIC_VECTOR(SHL(UNSIGNED(ARG),UNSIGNED(COUNT)));
    end;
 
    function SHR(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
    begin
       return STD_LOGIC_VECTOR(SHR(UNSIGNED(ARG),UNSIGNED(COUNT)));
    end;


-- remove this since it is already in std_logic_arith
    --function CONV_STD_LOGIC_VECTOR(ARG: INTEGER; SIZE: INTEGER) return STD_LOGIC_VECTOR is
        --variable result1 : UNSIGNED (SIZE-1 downto 0);
        --variable result2 : STD_LOGIC_VECTOR (SIZE-1 downto 0);
    --begin
        --result1 := CONV_UNSIGNED(ARG,SIZE);
        --return   std_logic_vector(result1);
    --end;


end STD_LOGIC_UNSIGNED;


--------------------------------------------------------------------------
--                                                                      --
-- Copyright (c) 1990, 1991, 1992 by Synopsys, Inc.                     --
--                                             All rights reserved.     --
--                                                                      --
-- This source file may be used and distributed without restriction     --
-- provided that this copyright statement is not removed from the file  --
-- and that any derivative work contains this copyright notice.         --
--                                                                      --
--	Package name: STD_LOGIC_SIGNED                                  --
--                                 					--
--									--
--      Date:        09/11/91 KN                                        --
--                   10/08/92 AMT change std_ulogic to signed std_logic --
--		     10/28/92 AMT added signed functions, -, ABS	--
--									--
--	Purpose: 							--
--	 A set of signed arithemtic, conversion,                        --
--           and comparision functions for STD_LOGIC_VECTOR.            --
--									--
--	Note:	Comparision of same length std_logic_vector is defined  --
--		in the LRM.  The interpretation is for unsigned vectors --
--		This package will "overload" that definition.		--
--									--
--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.std_logic_arith.all;

package STD_LOGIC_SIGNED is

    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "+"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
    function "+"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR;
    function "+"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
    function "-"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "+"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "ABS"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;


    function "*"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "<"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "<"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "<"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function "<="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "<="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "<="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function ">"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function ">"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function ">"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function ">="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function ">="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function ">="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function "="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function "/="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "/="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "/="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function SHL(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR; 
    function SHR(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR; 

    function CONV_INTEGER(ARG: STD_LOGIC_VECTOR) return INTEGER;

-- remove this since it is already in std_logic_arith
--    function CONV_STD_LOGIC_VECTOR(ARG: INTEGER; SIZE: INTEGER) return STD_LOGIC_VECTOR;

end STD_LOGIC_SIGNED;



library IEEE;
use IEEE.std_logic_1164.all;
use work.std_logic_arith.all;

package body STD_LOGIC_SIGNED is


    function maximum(L, R: INTEGER) return INTEGER is
    begin
        if L > R then
            return L;
        else
            return R;
        end if;
    end;


    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to plus
        constant length: INTEGER := maximum(L'length, R'length);
        variable result  : STD_LOGIC_VECTOR (length-1 downto 0);
    begin
        result  := SIGNED(L) + SIGNED(R); -- pragma label plus
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to plus
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := SIGNED(L) + R; -- pragma label plus
        return   std_logic_vector(result);
    end;

    function "+"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to plus
        variable result  : STD_LOGIC_VECTOR (R'range);
    begin
        result  := L + SIGNED(R); -- pragma label plus
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to plus
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := SIGNED(L) + R; -- pragma label plus
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to plus
        variable result  : STD_LOGIC_VECTOR (R'range);
    begin
        result  := L + SIGNED(R); -- pragma label plus
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to minus
        constant length: INTEGER := maximum(L'length, R'length);
        variable result  : STD_LOGIC_VECTOR (length-1 downto 0);
    begin
        result  := SIGNED(L) - SIGNED(R); -- pragma label minus
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to minus
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := SIGNED(L) - R; -- pragma label minus
        return   std_logic_vector(result);
    end;

    function "-"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to minus
        variable result  : STD_LOGIC_VECTOR (R'range);
    begin
        result  := L - SIGNED(R); -- pragma label minus
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to minus
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := SIGNED(L) - R; -- pragma label minus
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to minus
        variable result  : STD_LOGIC_VECTOR (R'range);
    begin
        result  := L - SIGNED(R); -- pragma label minus
        return   std_logic_vector(result);
    end;

    function "+"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to plus
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := + SIGNED(L); -- pragma label plus
        return   std_logic_vector(result);
    end;

    function "-"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to minus
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := - SIGNED(L); -- pragma label minus
        return   std_logic_vector(result);
    end;

    function "ABS"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        variable result  : STD_LOGIC_VECTOR (L'range);
    begin
        result  := ABS( SIGNED(L));
        return   std_logic_vector(result);
    end;

    function "*"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
        -- pragma label_applies_to mult
        constant length: INTEGER := maximum(L'length, R'length);
        variable result  : STD_LOGIC_VECTOR ((L'length+R'length-1) downto 0);
    begin
        result  := SIGNED(L) * SIGNED(R); -- pragma label mult
        return   std_logic_vector(result);
    end;
        
    function "<"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to lt
        constant length: INTEGER := maximum(L'length, R'length);
    begin
        return   SIGNED(L) < SIGNED(R); -- pragma label lt
    end;

    function "<"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
            -- pragma label_applies_to lt
    begin
        return   SIGNED(L) < R; -- pragma label lt
    end;

    function "<"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to lt
    begin
        return   L < SIGNED(R); -- pragma label lt
    end;

    function "<="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to leq
    begin
        return   SIGNED(L) <= SIGNED(R); -- pragma label leq
    end;

    function "<="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
        -- pragma label_applies_to leq
    begin
        return   SIGNED(L) <= R; -- pragma label leq
    end;

    function "<="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to leq
    begin
        return   L <= SIGNED(R); -- pragma label leq
    end;

    function ">"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to gt
    begin
        return   SIGNED(L) > SIGNED(R); -- pragma label gt
    end;

    function ">"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
        -- pragma label_applies_to gt
    begin
        return   SIGNED(L) > R; -- pragma label gt
    end;

    function ">"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to gt
    begin
        return   L > SIGNED(R); -- pragma label gt
    end;

    function ">="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to geq
    begin
        return   SIGNED(L) >= SIGNED(R); -- pragma label geq
    end;

    function ">="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
        -- pragma label_applies_to geq
    begin
        return   SIGNED(L) >= R; -- pragma label geq
    end;

    function ">="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
        -- pragma label_applies_to geq
    begin
        return   L >= SIGNED(R); -- pragma label geq
    end;

    function "="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   SIGNED(L) = SIGNED(R);
    end;

    function "="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
    begin
        return   SIGNED(L) = R;
    end;

    function "="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   L = SIGNED(R);
    end;

    function "/="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   SIGNED(L) /= SIGNED(R);
    end;

    function "/="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
    begin
        return   SIGNED(L) /= R;
    end;

    function "/="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
    begin
        return   L /= SIGNED(R);
    end;

    function SHL(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is 
    begin
       return STD_LOGIC_VECTOR(SHL(SIGNED(ARG),UNSIGNED(COUNT)));
    end; 

    function SHR(ARG:STD_LOGIC_VECTOR;COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
    begin
       return STD_LOGIC_VECTOR(SHR(SIGNED(ARG),UNSIGNED(COUNT)));
    end;
 


--  This function converts std_logic_vector to a signed integer value
--  using a conversion function in std_logic_arith
    function CONV_INTEGER(ARG: STD_LOGIC_VECTOR) return INTEGER is
        variable result    : SIGNED(ARG'range);
    begin
        result    := SIGNED(ARG);
        return   CONV_INTEGER(result);
    end;
end STD_LOGIC_SIGNED;

--------------------------------------------------------------------------
--
-- Copyright (c) 1990, 1991, 1992 by Synopsys, Inc.  All rights reserved.
-- 
-- This source file may be used and distributed without restriction 
-- provided that this copyright statement is not removed from the file 
-- and that any derivative work contains this copyright notice.
--
--	Package name: std_logic_misc
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions for the Std_logic_1164 Package.
--
--	Author:  GWH
--
--------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package std_logic_misc is

    -- output-strength types

    type STRENGTH is (strn_X01, strn_X0H, strn_XL1, strn_X0Z, strn_XZ1, 
		      strn_WLH, strn_WLZ, strn_WZH, strn_W0H, strn_WL1);


--synopsys synthesis_off

    type MINOMAX is array (1 to 3) of TIME;
    

    ---------------------------------------------------------------------
    --
    -- functions for mapping the STD_(U)LOGIC according to STRENGTH
    --
    ---------------------------------------------------------------------

    function strength_map(input: STD_ULOGIC; strn: STRENGTH) return STD_LOGIC;

    function strength_map_z(input:STD_ULOGIC; strn:STRENGTH) return STD_LOGIC;

    ---------------------------------------------------------------------
    --
    -- conversion functions for STD_ULOGIC_VECTOR and STD_LOGIC_VECTOR
    --
    ---------------------------------------------------------------------

--synopsys synthesis_on
    function Drive (V: STD_ULOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function Drive (V: STD_LOGIC_VECTOR) return STD_ULOGIC_VECTOR;
--synopsys synthesis_off

--    attribute CLOSELY_RELATED_TCF of Drive: function is TRUE;

    ---------------------------------------------------------------------
    --
    -- conversion functions for sensing various types
    -- (the second argument allows the user to specify the value to
    --  be returned when the network is undriven)
    --
    ---------------------------------------------------------------------

    function Sense (V: STD_ULOGIC; vZ, vU, vDC: STD_ULOGIC) return STD_LOGIC;

    function Sense (V: STD_ULOGIC_VECTOR; vZ, vU, vDC: STD_ULOGIC) 
    					   return STD_LOGIC_VECTOR;
    function Sense (V: STD_ULOGIC_VECTOR; vZ, vU, vDC: STD_ULOGIC) 
    					   return STD_ULOGIC_VECTOR;

    function Sense (V: STD_LOGIC_VECTOR; vZ, vU, vDC: STD_ULOGIC) 
    					   return STD_LOGIC_VECTOR;
    function Sense (V: STD_LOGIC_VECTOR; vZ, vU, vDC: STD_ULOGIC) 
    					   return STD_ULOGIC_VECTOR;

--synopsys synthesis_on


    ---------------------------------------------------------------------
    --
    --	Function: STD_LOGIC_VECTORtoBIT_VECTOR STD_ULOGIC_VECTORtoBIT_VECTOR
    --
    --	Purpose: Conversion fun. from STD_(U)LOGIC_VECTOR to BIT_VECTOR
    --
    --	Mapping:	0, L --> 0
    --			1, H --> 1
    --			X, W --> vX if Xflag is TRUE
    --			X, W --> 0  if Xflag is FALSE
    --			Z --> vZ if Zflag is TRUE
    --			Z --> 0  if Zflag is FALSE
    --			U --> vU if Uflag is TRUE
    --			U --> 0  if Uflag is FALSE
    --			- --> vDC if DCflag is TRUE
    --			- --> 0  if DCflag is FALSE
    --
    ---------------------------------------------------------------------

    function STD_LOGIC_VECTORtoBIT_VECTOR (V: STD_LOGIC_VECTOR
--synopsys synthesis_off
    	; vX, vZ, vU, vDC: BIT := '0'; 
    	  Xflag, Zflag, Uflag, DCflag: BOOLEAN := FALSE
--synopsys synthesis_on
    	) return BIT_VECTOR;

    function STD_ULOGIC_VECTORtoBIT_VECTOR (V: STD_ULOGIC_VECTOR
--synopsys synthesis_off
    	; vX, vZ, vU, vDC: BIT := '0'; 
    	  Xflag, Zflag, Uflag, DCflag: BOOLEAN := FALSE
--synopsys synthesis_on
    	) return BIT_VECTOR;
    

    ---------------------------------------------------------------------
    --
    --	Function: STD_ULOGICtoBIT
    --
    --	Purpose: Conversion function from STD_(U)LOGIC to BIT
    --
    --	Mapping:	0, L --> 0
    --			1, H --> 1
    --			X, W --> vX if Xflag is TRUE
    --			X, W --> 0  if Xflag is FALSE
    --			Z --> vZ if Zflag is TRUE
    --			Z --> 0  if Zflag is FALSE
    --			U --> vU if Uflag is TRUE
    --			U --> 0  if Uflag is FALSE
    --			- --> vDC if DCflag is TRUE
    --			- --> 0  if DCflag is FALSE
    --
    ---------------------------------------------------------------------

    function STD_ULOGICtoBIT (V: STD_ULOGIC
--synopsys synthesis_off
    	; vX, vZ, vU, vDC: BIT := '0'; 
    	  Xflag, Zflag, Uflag, DCflag: BOOLEAN := FALSE
--synopsys synthesis_on
    	) return BIT;

        --------------------------------------------------------------------
        function AND_REDUCE(ARG: STD_LOGIC_VECTOR) return UX01;
        function NAND_REDUCE(ARG: STD_LOGIC_VECTOR) return UX01;
        function OR_REDUCE(ARG: STD_LOGIC_VECTOR) return UX01;
        function NOR_REDUCE(ARG: STD_LOGIC_VECTOR) return UX01;
        function XOR_REDUCE(ARG: STD_LOGIC_VECTOR) return UX01;
        function XNOR_REDUCE(ARG: STD_LOGIC_VECTOR) return UX01;
    
        function AND_REDUCE(ARG: STD_ULOGIC_VECTOR) return UX01;
        function NAND_REDUCE(ARG: STD_ULOGIC_VECTOR) return UX01;
        function OR_REDUCE(ARG: STD_ULOGIC_VECTOR) return UX01;
        function NOR_REDUCE(ARG: STD_ULOGIC_VECTOR) return UX01;
        function XOR_REDUCE(ARG: STD_ULOGIC_VECTOR) return UX01;
        function XNOR_REDUCE(ARG: STD_ULOGIC_VECTOR) return UX01;
    
--synopsys synthesis_off
	
        function fun_BUF3S(Input, Enable: UX01; Strn: STRENGTH) return STD_LOGIC;
        function fun_BUF3SL(Input, Enable: UX01; Strn: STRENGTH) return STD_LOGIC;
        function fun_MUX2x1(Input0, Input1, Sel: UX01) return UX01;

        function fun_MAJ23(Input0, Input1, Input2: UX01) return UX01;
        function fun_WiredX(Input0, Input1: std_ulogic) return STD_LOGIC;

--synopsys synthesis_on
	
end;


package body std_logic_misc is

--synopsys synthesis_off

    type STRN_STD_ULOGIC_TABLE is array (STD_ULOGIC,STRENGTH) of STD_ULOGIC;

    --------------------------------------------------------------------
    --
    -- Truth tables for output strength --> STD_ULOGIC lookup
    --
    --------------------------------------------------------------------

    -- truth table for output strength --> STD_ULOGIC lookup
    constant tbl_STRN_STD_ULOGIC: STRN_STD_ULOGIC_TABLE := 
    --  ------------------------------------------------------------------
    --  | X01  X0H  XL1  X0Z  XZ1  WLH  WLZ  WZH  W0H  WL1 | strn/ output|
    --  ------------------------------------------------------------------
        (('U', 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U'),  -- |   U   |
         ('X', 'X', 'X', 'X', 'X', 'W', 'W', 'W', 'W', 'W'),  -- |   X   |
         ('0', '0', 'L', '0', 'Z', 'L', 'L', 'Z', '0', 'L'),  -- |   0   |
         ('1', 'H', '1', 'Z', '1', 'H', 'Z', 'H', 'H', '1'),  -- |   1   |
         ('X', 'X', 'X', 'X', 'X', 'W', 'W', 'W', 'W', 'W'),  -- |   Z   |
         ('X', 'X', 'X', 'X', 'X', 'W', 'W', 'W', 'W', 'W'),  -- |   W   |
         ('0', '0', 'L', '0', 'Z', 'L', 'L', 'Z', '0', 'L'),  -- |   L   |
         ('1', 'H', '1', 'Z', '1', 'H', 'Z', 'H', 'H', '1'),  -- |   H   |
         ('X', 'X', 'X', 'X', 'X', 'W', 'W', 'W', 'W', 'W')); -- |   -   |



    --------------------------------------------------------------------
    --
    -- Truth tables for strength --> STD_ULOGIC mapping ('Z' pass through)
    --
    --------------------------------------------------------------------

    -- truth table for output strength --> STD_ULOGIC lookup
    constant tbl_STRN_STD_ULOGIC_Z: STRN_STD_ULOGIC_TABLE := 
    --  ------------------------------------------------------------------
    --  | X01  X0H  XL1  X0Z  XZ1  WLH  WLZ  WZH  W0H  WL1 | strn/ output|
    --  ------------------------------------------------------------------
        (('U', 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U'),  -- |   U   |
         ('X', 'X', 'X', 'X', 'X', 'W', 'W', 'W', 'W', 'W'),  -- |   X   |
         ('0', '0', 'L', '0', 'Z', 'L', 'L', 'Z', '0', 'L'),  -- |   0   |
         ('1', 'H', '1', 'Z', '1', 'H', 'Z', 'H', 'H', '1'),  -- |   1   |
         ('Z', 'Z', 'Z', 'Z', 'Z', 'Z', 'Z', 'Z', 'Z', 'Z'),  -- |   Z   |
         ('X', 'X', 'X', 'X', 'X', 'W', 'W', 'W', 'W', 'W'),  -- |   W   |
         ('0', '0', 'L', '0', 'Z', 'L', 'L', 'Z', '0', 'L'),  -- |   L   |
         ('1', 'H', '1', 'Z', '1', 'H', 'Z', 'H', 'H', '1'),  -- |   H   |
         ('X', 'X', 'X', 'X', 'X', 'W', 'W', 'W', 'W', 'W')); -- |   -   |



    ---------------------------------------------------------------------
    --
    -- functions for mapping the STD_(U)LOGIC according to STRENGTH
    --
    ---------------------------------------------------------------------

    function strength_map(input: STD_ULOGIC; strn: STRENGTH) return STD_LOGIC is
	-- pragma subpgm_id 387
    begin
    	return tbl_STRN_STD_ULOGIC(input, strn);
    end strength_map;


    function strength_map_z(input:STD_ULOGIC; strn:STRENGTH) return STD_LOGIC is
	-- pragma subpgm_id 388
    begin
    	return tbl_STRN_STD_ULOGIC_Z(input, strn);
    end strength_map_z;


    ---------------------------------------------------------------------
    --
    -- conversion functions for STD_LOGIC_VECTOR and STD_ULOGIC_VECTOR
    --
    ---------------------------------------------------------------------

--synopsys synthesis_on
    function Drive (V: STD_LOGIC_VECTOR) return STD_ULOGIC_VECTOR is
      -- pragma built_in SYN_FEED_THRU
      -- pragma subpgm_id 389
--synopsys synthesis_off
        alias Value: STD_LOGIC_VECTOR (V'length-1 downto 0) is V;
--synopsys synthesis_on
    begin
--synopsys synthesis_off
    	return STD_ULOGIC_VECTOR(Value);
--synopsys synthesis_on
    end Drive;


    function Drive (V: STD_ULOGIC_VECTOR) return STD_LOGIC_VECTOR is
      -- pragma built_in SYN_FEED_THRU
      -- pragma subpgm_id 390
--synopsys synthesis_off
        alias Value: STD_ULOGIC_VECTOR (V'length-1 downto 0) is V;
--synopsys synthesis_on
    begin
--synopsys synthesis_off
    	return STD_LOGIC_VECTOR(Value);
--synopsys synthesis_on
    end Drive;
--synopsys synthesis_off


    ---------------------------------------------------------------------
    --
    -- conversion functions for sensing various types
    --
    -- (the second argument allows the user to specify the value to
    --  be returned when the network is undriven)
    --
    ---------------------------------------------------------------------

    function Sense (V: STD_ULOGIC; vZ, vU, vDC: STD_ULOGIC) 
    					        return STD_LOGIC is
	-- pragma subpgm_id 391
    begin
    	if V = 'Z' then
    		return vZ;
	elsif V = 'U' then
		return vU;
	elsif V = '-' then
		return vDC;
    	else
    		return V;
    	end if;
    end Sense;


    function Sense (V: STD_ULOGIC_VECTOR; vZ, vU, vDC: STD_ULOGIC) 
    					return STD_LOGIC_VECTOR is
	-- pragma subpgm_id 392
    	alias Value: STD_ULOGIC_VECTOR (V'length-1 downto 0) is V;
    	variable Result: STD_LOGIC_VECTOR (V'length-1 downto 0);
    begin
    	for i in Value'range loop
    		if ( Value(i) = 'Z' ) then
    			Result(i) := vZ;
		elsif Value(i) = 'U' then
			Result(i) :=  vU;
		elsif Value(i) = '-' then
			Result(i) := vDC;
    		else
    			Result(i) := Value(i);
    		end if;
    	end loop;
    	return Result;
    end Sense;


    function Sense (V: STD_ULOGIC_VECTOR; vZ, vU, vDC: STD_ULOGIC) 
    					return STD_ULOGIC_VECTOR is
	-- pragma subpgm_id 393
    	alias Value: STD_ULOGIC_VECTOR (V'length-1 downto 0) is V;
    	variable Result: STD_ULOGIC_VECTOR (V'length-1 downto 0);
    begin
    	for i in Value'range loop
    		if ( Value(i) = 'Z' ) then
    			Result(i) := vZ;
		elsif Value(i) = 'U' then
			Result(i) :=  vU;
		elsif Value(i) = '-' then
			Result(i) := vDC;
    		else
    			Result(i) := Value(i);
    		end if;
    	end loop;
    	return Result;
    end Sense;


    function Sense (V: STD_LOGIC_VECTOR; vZ, vU, vDC: STD_ULOGIC) 
    					return STD_LOGIC_VECTOR is
	-- pragma subpgm_id 394
    	alias Value: STD_LOGIC_VECTOR (V'length-1 downto 0) is V;
    	variable Result: STD_LOGIC_VECTOR (V'length-1 downto 0);
    begin
    	for i in Value'range loop
    		if ( Value(i) = 'Z' ) then
    			Result(i) := vZ;
		elsif Value(i) = 'U' then
			Result(i) :=  vU;
		elsif Value(i) = '-' then
			Result(i) := vDC;
    		else
    			Result(i) := Value(i);
    		end if;
    	end loop;
    	return Result;
    end Sense;


    function Sense (V: STD_LOGIC_VECTOR; vZ, vU, vDC: STD_ULOGIC) 
    					return STD_ULOGIC_VECTOR is
	-- pragma subpgm_id 395
    	alias Value: STD_LOGIC_VECTOR (V'length-1 downto 0) is V;
    	variable Result: STD_ULOGIC_VECTOR (V'length-1 downto 0);
    begin
    	for i in Value'range loop
    		if ( Value(i) = 'Z' ) then
    			Result(i) := vZ;
		elsif Value(i) = 'U' then
			Result(i) :=  vU;
		elsif Value(i) = '-' then
			Result(i) := vDC;
    		else
    			Result(i) := Value(i);
    		end if;
    	end loop;
    	return Result;
    end Sense;

    ---------------------------------------------------------------------
    --
    --	Function: STD_LOGIC_VECTORtoBIT_VECTOR
    --
    --	Purpose: Conversion fun. from STD_LOGIC_VECTOR to BIT_VECTOR
    --
    --	Mapping:	0, L --> 0
    --			1, H --> 1
    --			X, W --> vX if Xflag is TRUE
    --			X, W --> 0  if Xflag is FALSE
    --			Z --> vZ if Zflag is TRUE
    --			Z --> 0  if Zflag is FALSE
    --			U --> vU if Uflag is TRUE
    --			U --> 0  if Uflag is FALSE
    --			- --> vDC if DCflag is TRUE
    --			- --> 0  if DCflag is FALSE
    --
    ---------------------------------------------------------------------

--synopsys synthesis_on
    function STD_LOGIC_VECTORtoBIT_VECTOR (V: STD_LOGIC_VECTOR
--synopsys synthesis_off
    	; vX, vZ, vU, vDC: BIT := '0'; 
    	  Xflag, Zflag, Uflag, DCflag: BOOLEAN := FALSE
--synopsys synthesis_on
    		   ) return BIT_VECTOR is
      -- pragma built_in SYN_FEED_THRU
      -- pragma subpgm_id 396
--synopsys synthesis_off
    	alias Value: STD_LOGIC_VECTOR (V'length-1 downto 0) is V;
    	variable Result: BIT_VECTOR (V'length-1 downto 0);
--synopsys synthesis_on
    begin
--synopsys synthesis_off
    	for i in Value'range loop
    		case Value(i) is
    			when '0' | 'L' =>
    				Result(i) := '0';
    			when '1' | 'H' =>
    				Result(i) := '1';
	    		when 'X' =>
    				if ( Xflag ) then
    					Result(i) := vX;
    				else
    					Result(i) := '0';
	    		 		assert FALSE
    				 	    report "STD_LOGIC_VECTORtoBIT_VECTOR: X --> 0"
    				 	    severity WARNING;
    				end if;
	    		when 'W' =>
    				if ( Xflag ) then
    					Result(i) := vX;
    				else
    					Result(i) := '0';
	    		 		assert FALSE
    				 	    report "STD_LOGIC_VECTORtoBIT_VECTOR: W --> 0"
    				 	    severity WARNING;
    				end if;
	    		when 'Z' =>
    				if ( Zflag ) then
    					Result(i) := vZ;
	    			else
    					Result(i) := '0';
    					assert FALSE
    					    report "STD_LOGIC_VECTORtoBIT_VECTOR: Z --> 0"
    					    severity WARNING;
	    			end if;
    			when 'U' =>
    				if ( Uflag ) then
    					Result(i) := vU;
	    			else
    					Result(i) := '0';
    					assert FALSE
    					    report "STD_LOGIC_VECTORtoBIT_VECTOR: U --> 0"
    					    severity WARNING;
				end if;
    			when '-' =>
    				if ( DCflag ) then
    					Result(i) := vDC;
	    			else
    					Result(i) := '0';
    					assert FALSE
    					    report "STD_LOGIC_VECTORtoBIT_VECTOR: - --> 0"
    					    severity WARNING;
	    			end if;
    			end case;
	    	end loop;
    	return Result;
--synopsys synthesis_on
    end STD_LOGIC_VECTORtoBIT_VECTOR;




    ---------------------------------------------------------------------
    --
    --	Function: STD_ULOGIC_VECTORtoBIT_VECTOR
    --
    --	Purpose: Conversion fun. from STD_ULOGIC_VECTOR to BIT_VECTOR
    --
    --	Mapping:	0, L --> 0
    --			1, H --> 1
    --			X, W --> vX if Xflag is TRUE
    --			X, W --> 0  if Xflag is FALSE
    --			Z --> vZ if Zflag is TRUE
    --			Z --> 0  if Zflag is FALSE
    --			U --> vU if Uflag is TRUE
    --			U --> 0  if Uflag is FALSE
    --			- --> vDC if DCflag is TRUE
    --			- --> 0  if DCflag is FALSE
    --
    ---------------------------------------------------------------------

    function STD_ULOGIC_VECTORtoBIT_VECTOR (V: STD_ULOGIC_VECTOR
--synopsys synthesis_off
    	; vX, vZ, vU, vDC: BIT := '0'; 
    	  Xflag, Zflag, Uflag, DCflag: BOOLEAN := FALSE
--synopsys synthesis_on
    		   ) return BIT_VECTOR is
      -- pragma built_in SYN_FEED_THRU
      -- pragma subpgm_id 397
--synopsys synthesis_off
    	alias Value: STD_ULOGIC_VECTOR (V'length-1 downto 0) is V;
    	variable Result: BIT_VECTOR (V'length-1 downto 0);
--synopsys synthesis_on
    begin
--synopsys synthesis_off
    	for i in Value'range loop
    		case Value(i) is
    			when '0' | 'L' =>
    				Result(i) := '0';
    			when '1' | 'H' =>
    				Result(i) := '1';
	    		when 'X' =>
    				if ( Xflag ) then
    					Result(i) := vX;
	    			else
    					Result(i) := '0';
	    		 		assert FALSE
    				 	    report "STD_ULOGIC_VECTORtoBIT_VECTOR: X --> 0"
    				 	    severity WARNING;
	    			end if;
    			when 'W' =>
	    			if ( Xflag ) then
    					Result(i) := vX;
    				else
    					Result(i) := '0';
	    		 		assert FALSE
    				 	    report "STD_ULOGIC_VECTORtoBIT_VECTOR: W --> 0"
    				 	    severity WARNING;
	    			end if;
    			when 'Z' =>
    				if ( Zflag ) then
	    				Result(i) := vZ;
    				else
    					Result(i) := '0';
    					assert FALSE
    					    report "STD_ULOGIC_VECTORtoBIT_VECTOR: Z --> 0"
	    				    severity WARNING;
    				end if;
	    		when 'U' =>
    				if ( Uflag ) then
    					Result(i) := vU;
	    			else
    					Result(i) := '0';
    					assert FALSE
    					    report "STD_ULOGIC_VECTORtoBIT_VECTOR: U --> 0"
    					    severity WARNING;
				end if;
    			when '-' =>
    				if ( DCflag ) then
    					Result(i) := vDC;
	    			else
    					Result(i) := '0';
    					assert FALSE
    					    report "STD_ULOGIC_VECTORtoBIT_VECTOR: - --> 0"
    					    severity WARNING;
	    			end if;
    			end case;
    	end loop;
    	return Result;
--synopsys synthesis_on
    end STD_ULOGIC_VECTORtoBIT_VECTOR;




    ---------------------------------------------------------------------
    --
    --	Function: STD_ULOGICtoBIT
    --
    --	Purpose: Conversion function from STD_ULOGIC to BIT
    --
    --	Mapping:	0, L --> 0
    --			1, H --> 1
    --			X, W --> vX if Xflag is TRUE
    --			X, W --> 0  if Xflag is FALSE
    --			Z --> vZ if Zflag is TRUE
    --			Z --> 0  if Zflag is FALSE
    --			U --> vU if Uflag is TRUE
    --			U --> 0  if Uflag is FALSE
    --			- --> vDC if DCflag is TRUE
    --			- --> 0  if DCflag is FALSE
    --
    ---------------------------------------------------------------------

    function STD_ULOGICtoBIT (V: STD_ULOGIC
--synopsys synthesis_off
    	; vX, vZ, vU, vDC: BIT := '0'; 
    	  Xflag, Zflag, Uflag, DCflag: BOOLEAN := FALSE
--synopsys synthesis_on
    		   ) return BIT is
      -- pragma built_in SYN_FEED_THRU
      -- pragma subpgm_id 398
    	variable Result: BIT;
    begin
--synopsys synthesis_off
    	case V is
    		when '0' | 'L' =>
    			Result := '0';
    		when '1' | 'H' =>
    			Result := '1';
    		when 'X' =>
    			if ( Xflag ) then
    				Result := vX;
    			else
    				Result := '0';
    		 		assert FALSE
    			 	    report "STD_ULOGICtoBIT: X --> 0"
    			 	    severity WARNING;
    			end if;
    		when 'W' =>
    			if ( Xflag ) then
    				Result := vX;
    			else
    				Result := '0';
    		 		assert FALSE
    			 	    report "STD_ULOGICtoBIT: W --> 0"
    			 	    severity WARNING;
    			end if;
    		when 'Z' =>
    			if ( Zflag ) then
    				Result := vZ;
    			else
    				Result := '0';
    				assert FALSE
    				    report "STD_ULOGICtoBIT: Z --> 0"
    				    severity WARNING;
    			end if;
    		when 'U' =>
    			if ( Uflag ) then
    				Result := vU;
    			else
    				Result := '0';
    				assert FALSE
    				    report "STD_ULOGICtoBIT: U --> 0"
    				    severity WARNING;
			end if;
    		when '-' =>
    			if ( DCflag ) then
    				Result := vDC;
    			else
    				Result := '0';
    				assert FALSE
    				    report "STD_ULOGICtoBIT: - --> 0"
    				    severity WARNING;
    			end if;
    	end case;
    	return Result;
--synopsys synthesis_on
    end STD_ULOGICtoBIT;


    --------------------------------------------------------------------------

    function AND_REDUCE(ARG: STD_LOGIC_VECTOR) return UX01 is
	-- pragma subpgm_id 399
	variable result: STD_LOGIC;
    begin
	result := '1';
	for i in ARG'range loop
	    result := result and ARG(i);
	end loop;
        return result;
    end;

    function NAND_REDUCE(ARG: STD_LOGIC_VECTOR) return UX01 is
	-- pragma subpgm_id 400
    begin
        return not AND_REDUCE(ARG);
    end;

    function OR_REDUCE(ARG: STD_LOGIC_VECTOR) return UX01 is
	-- pragma subpgm_id 401
	variable result: STD_LOGIC;
    begin
	result := '0';
	for i in ARG'range loop
	    result := result or ARG(i);
	end loop;
        return result;
    end;

    function NOR_REDUCE(ARG: STD_LOGIC_VECTOR) return UX01 is
	-- pragma subpgm_id 402
    begin
        return not OR_REDUCE(ARG);
    end;

    function XOR_REDUCE(ARG: STD_LOGIC_VECTOR) return UX01 is
	-- pragma subpgm_id 403
	variable result: STD_LOGIC;
    begin
	result := '0';
	for i in ARG'range loop
	    result := result xor ARG(i);
	end loop;
        return result;
    end;

    function XNOR_REDUCE(ARG: STD_LOGIC_VECTOR) return UX01 is
	-- pragma subpgm_id 404
    begin
        return not XOR_REDUCE(ARG);
    end;

    function AND_REDUCE(ARG: STD_ULOGIC_VECTOR) return UX01 is
	-- pragma subpgm_id 405
	variable result: STD_LOGIC;
    begin
	result := '1';
	for i in ARG'range loop
	    result := result and ARG(i);
	end loop;
        return result;
    end;

    function NAND_REDUCE(ARG: STD_ULOGIC_VECTOR) return UX01 is
	-- pragma subpgm_id 406
    begin
        return not AND_REDUCE(ARG);
    end;

    function OR_REDUCE(ARG: STD_ULOGIC_VECTOR) return UX01 is
	-- pragma subpgm_id 407
	variable result: STD_LOGIC;
    begin
	result := '0';
	for i in ARG'range loop
	    result := result or ARG(i);
	end loop;
        return result;
    end;

    function NOR_REDUCE(ARG: STD_ULOGIC_VECTOR) return UX01 is
	-- pragma subpgm_id 408
    begin
        return not OR_REDUCE(ARG);
    end;

    function XOR_REDUCE(ARG: STD_ULOGIC_VECTOR) return UX01 is
	-- pragma subpgm_id 409
	variable result: STD_LOGIC;
    begin
	result := '0';
	for i in ARG'range loop
	    result := result xor ARG(i);
	end loop;
        return result;
    end;

    function XNOR_REDUCE(ARG: STD_ULOGIC_VECTOR) return UX01 is
	-- pragma subpgm_id 410
    begin
        return not XOR_REDUCE(ARG);
    end;

--synopsys synthesis_off
	
    function fun_BUF3S(Input, Enable: UX01; Strn: STRENGTH) return STD_LOGIC is
	-- pragma subpgm_id 411
	type TRISTATE_TABLE is array(STRENGTH, UX01, UX01) of STD_LOGIC;

	-- truth table for tristate "buf" function (Enable active Low)
          constant tbl_BUF3S: TRISTATE_TABLE := 
          -- ----------------------------------------------------
          -- | Input   U    X    0    1       | Enable Strength |
          -- ---------------------------------|-----------------|
        	   ((('U', 'U', 'U', 'U'),  --|   U       X01   |
        	     ('U', 'X', 'X', 'X'),  --|   X       X01   |
        	     ('Z', 'Z', 'Z', 'Z'),  --|   0       X01   |
        	     ('U', 'X', '0', '1')), --|   1       X01   |
        	    (('U', 'U', 'U', 'U'),  --|   U       X0H   |
        	     ('U', 'X', 'X', 'X'),  --|   X       X0H   |
        	     ('Z', 'Z', 'Z', 'Z'),  --|   0       X0H   |
        	     ('U', 'X', '0', 'H')), --|   1       X0H   |
        	    (('U', 'U', 'U', 'U'),  --|   U       XL1   |
        	     ('U', 'X', 'X', 'X'),  --|   X       XL1   |
        	     ('Z', 'Z', 'Z', 'Z'),  --|   0       XL1   |
        	     ('U', 'X', 'L', '1')), --|   1       XL1   |
        	    (('U', 'U', 'U', 'Z'),  --|   U       X0Z   |
        	     ('U', 'X', 'X', 'Z'),  --|   X       X0Z   |
        	     ('Z', 'Z', 'Z', 'Z'),  --|   0       X0Z   |
        	     ('U', 'X', '0', 'Z')), --|   1       X0Z   |
        	    (('U', 'U', 'U', 'U'),  --|   U       XZ1   |
        	     ('U', 'X', 'X', 'X'),  --|   X       XZ1   |
        	     ('Z', 'Z', 'Z', 'Z'),  --|   0       XZ1   |
        	     ('U', 'X', 'Z', '1')), --|   1       XZ1   |
        	    (('U', 'U', 'U', 'U'),  --|   U       WLH   |
        	     ('U', 'W', 'W', 'W'),  --|   X       WLH   |
        	     ('Z', 'Z', 'Z', 'Z'),  --|   0       WLH   |
        	     ('U', 'W', 'L', 'H')), --|   1       WLH   |
        	    (('U', 'U', 'U', 'U'),  --|   U       WLZ   |
        	     ('U', 'W', 'W', 'Z'),  --|   X       WLZ   |
        	     ('Z', 'Z', 'Z', 'Z'),  --|   0       WLZ   |
        	     ('U', 'W', 'L', 'Z')), --|   1       WLZ   |
        	    (('U', 'U', 'U', 'U'),  --|   U       WZH   |
        	     ('U', 'W', 'W', 'W'),  --|   X       WZH   |
        	     ('Z', 'Z', 'Z', 'Z'),  --|   0       WZH   |
        	     ('U', 'W', 'Z', 'H')), --|   1       WZH   |
        	    (('U', 'U', 'U', 'U'),  --|   U       W0H   |
        	     ('U', 'W', 'W', 'W'),  --|   X       W0H   |
        	     ('Z', 'Z', 'Z', 'Z'),  --|   0       W0H   |
        	     ('U', 'W', '0', 'H')), --|   1       W0H   |
        	    (('U', 'U', 'U', 'U'),  --|   U       WL1   |
        	     ('U', 'W', 'W', 'W'),  --|   X       WL1   |
        	     ('Z', 'Z', 'Z', 'Z'),  --|   0       WL1   |
        	     ('U', 'W', 'L', '1')));--|   1       WL1   |
    begin
	return tbl_BUF3S(Strn, Enable, Input);
    end fun_BUF3S;


    function fun_BUF3SL(Input, Enable: UX01; Strn: STRENGTH) return STD_LOGIC is
	-- pragma subpgm_id 412
	type TRISTATE_TABLE is array(STRENGTH, UX01, UX01) of STD_LOGIC;

	-- truth table for tristate "buf" function (Enable active Low)
          constant tbl_BUF3SL: TRISTATE_TABLE := 
          -- ----------------------------------------------------
          -- | Input   U    X    0    1       | Enable Strength |
          -- ---------------------------------|-----------------|
        	   ((('U', 'U', 'U', 'U'),  --|   U       X01   |
        	     ('U', 'X', 'X', 'X'),  --|   X       X01   |
        	     ('U', 'X', '0', '1'),  --|   0       X01   |
        	     ('Z', 'Z', 'Z', 'Z')), --|   1       X01   |
        	    (('U', 'U', 'U', 'U'),  --|   U       X0H   |
        	     ('U', 'X', 'X', 'X'),  --|   X       X0H   |
        	     ('U', 'X', '0', 'H'),  --|   0       X0H   |
        	     ('Z', 'Z', 'Z', 'Z')), --|   1       X0H   |
        	    (('U', 'U', 'U', 'U'),  --|   U       XL1   |
        	     ('U', 'X', 'X', 'X'),  --|   X       XL1   |
        	     ('U', 'X', 'L', '1'),  --|   0       XL1   |
        	     ('Z', 'Z', 'Z', 'Z')), --|   1       XL1   |
        	    (('U', 'U', 'U', 'Z'),  --|   U       X0Z   |
        	     ('U', 'X', 'X', 'Z'),  --|   X       X0Z   |
        	     ('U', 'X', '0', 'Z'),  --|   0       X0Z   |
        	     ('Z', 'Z', 'Z', 'Z')), --|   1       X0Z   |
        	    (('U', 'U', 'U', 'U'),  --|   U       XZ1   |
        	     ('U', 'X', 'X', 'X'),  --|   X       XZ1   |
        	     ('U', 'X', 'Z', '1'),  --|   0       XZ1   |
        	     ('Z', 'Z', 'Z', 'Z')), --|   1       XZ1   |
        	    (('U', 'U', 'U', 'U'),  --|   U       WLH   |
        	     ('U', 'W', 'W', 'W'),  --|   X       WLH   |
        	     ('U', 'W', 'L', 'H'),  --|   0       WLH   |
        	     ('Z', 'Z', 'Z', 'Z')), --|   1       WLH   |
        	    (('U', 'U', 'U', 'U'),  --|   U       WLZ   |
        	     ('U', 'W', 'W', 'Z'),  --|   X       WLZ   |
        	     ('U', 'W', 'L', 'Z'),  --|   0       WLZ   |
        	     ('Z', 'Z', 'Z', 'Z')), --|   1       WLZ   |
        	    (('U', 'U', 'U', 'U'),  --|   U       WZH   |
        	     ('U', 'W', 'W', 'W'),  --|   X       WZH   |
        	     ('U', 'W', 'Z', 'H'),  --|   0       WZH   |
        	     ('Z', 'Z', 'Z', 'Z')), --|   1       WZH   |
        	    (('U', 'U', 'U', 'U'),  --|   U       W0H   |
        	     ('U', 'W', 'W', 'W'),  --|   X       W0H   |
        	     ('U', 'W', '0', 'H'),  --|   0       W0H   |
        	     ('Z', 'Z', 'Z', 'Z')), --|   1       W0H   |
        	    (('U', 'U', 'U', 'U'),  --|   U       WL1   |
        	     ('U', 'W', 'W', 'W'),  --|   X       WL1   |
        	     ('U', 'W', 'L', '1'),  --|   0       WL1   |
        	     ('Z', 'Z', 'Z', 'Z')));--|   1       WL1   |
    begin
	return tbl_BUF3SL(Strn, Enable, Input);
    end fun_BUF3SL;


    function fun_MUX2x1(Input0, Input1, Sel: UX01) return UX01 is
	-- pragma subpgm_id 413
	type MUX_TABLE is array (UX01, UX01, UX01) of UX01;

	-- truth table for "MUX2x1" function
	constant tbl_MUX2x1: MUX_TABLE :=
	--------------------------------------------
        --| In0  'U'  'X'  '0'  '1'      | Sel In1 |
	--------------------------------------------
	      ((('U', 'U', 'U', 'U'),  --| 'U' 'U' |
	        ('U', 'U', 'U', 'U'),  --| 'X' 'U' |
		('U', 'X', '0', '1'),  --| '0' 'U' |
		('U', 'U', 'U', 'U')), --| '1' 'U' |
	       (('U', 'X', 'U', 'U'),  --| 'U' 'X' |
	        ('U', 'X', 'X', 'X'),  --| 'X' 'X' |
		('U', 'X', '0', '1'),  --| '0' 'X' |
		('X', 'X', 'X', 'X')), --| '1' 'X' |
	       (('U', 'U', '0', 'U'),  --| 'U' '0' |
	        ('U', 'X', '0', 'X'),  --| 'X' '0' |
		('U', 'X', '0', '1'),  --| '0' '0' |
		('0', '0', '0', '0')), --| '1' '0' |
	       (('U', 'U', 'U', '1'),  --| 'U' '1' |
	        ('U', 'X', 'X', '1'),  --| 'X' '1' |
		('U', 'X', '0', '1'),  --| '0' '1' |
		('1', '1', '1', '1')));--| '1' '1' |
    begin
	return tbl_MUX2x1(Input1, Sel, Input0);
    end fun_MUX2x1;


    function fun_MAJ23(Input0, Input1, Input2: UX01) return UX01 is
	-- pragma subpgm_id 414
	type MAJ23_TABLE is array (UX01, UX01, UX01) of UX01;

	----------------------------------------------------------------------------
	--	The "tbl_MAJ23" truth table return 1 if the majority of three
	--	inputs is 1, a 0 if the majority is 0, a X if unknown, and a U if
	--	uninitialized.
	----------------------------------------------------------------------------
	constant tbl_MAJ23: MAJ23_TABLE :=
        --------------------------------------------
        --| In0  'U'  'X'  '0'  '1'      | In1 In2 |
        --------------------------------------------
              ((('U', 'U', 'U', 'U'),  --| 'U' 'U' |
                ('U', 'U', 'U', 'U'),  --| 'X' 'U' |
                ('U', 'U', '0', 'U'),  --| '0' 'U' |
                ('U', 'U', 'U', '1')), --| '1' 'U' |
               (('U', 'U', 'U', 'U'),  --| 'U' 'X' |
                ('U', 'X', 'X', 'X'),  --| 'X' 'X' |
                ('U', 'X', '0', 'X'),  --| '0' 'X' |
                ('U', 'X', 'X', '1')), --| '1' 'X' |
               (('U', 'U', '0', 'U'),  --| 'U' '0' |
                ('U', 'X', '0', 'X'),  --| 'X' '0' |
                ('0', '0', '0', '0'),  --| '0' '0' |
                ('U', 'X', '0', '1')), --| '1' '0' |
               (('U', 'U', 'U', '1'),  --| 'U' '1' |
                ('U', 'X', 'X', '1'),  --| 'X' '1' |
                ('U', 'X', '0', '1'),  --| '0' '1' |
                ('1', '1', '1', '1')));--| '1' '1' |

    begin
	return tbl_MAJ23(Input0, Input1, Input2);
    end fun_MAJ23;


    function fun_WiredX(Input0, Input1: STD_ULOGIC) return STD_LOGIC is
	-- pragma subpgm_id 415
        TYPE stdlogic_table IS ARRAY(STD_ULOGIC, STD_ULOGIC) OF STD_LOGIC;

	-- truth table for "WiredX" function
        -------------------------------------------------------------------    
        -- resolution function
        -------------------------------------------------------------------    
        CONSTANT resolution_table : stdlogic_table := (
        --      ---------------------------------------------------------
        --      |  U    X    0    1    Z    W    L    H    -        |   |  
        --      ---------------------------------------------------------
                ( 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U' ), -- | U |
                ( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X' ), -- | X |
                ( 'U', 'X', '0', 'X', '0', '0', '0', '0', 'X' ), -- | 0 |
                ( 'U', 'X', 'X', '1', '1', '1', '1', '1', 'X' ), -- | 1 |
                ( 'U', 'X', '0', '1', 'Z', 'W', 'L', 'H', 'X' ), -- | Z |
                ( 'U', 'X', '0', '1', 'W', 'W', 'W', 'W', 'X' ), -- | W |
                ( 'U', 'X', '0', '1', 'L', 'W', 'L', 'W', 'X' ), -- | L |
                ( 'U', 'X', '0', '1', 'H', 'W', 'W', 'H', 'X' ), -- | H |
                ( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X' ));-- | - |
    begin
	return resolution_table(Input0, Input1);
    end fun_WiredX;

--synopsys synthesis_on
	
end;

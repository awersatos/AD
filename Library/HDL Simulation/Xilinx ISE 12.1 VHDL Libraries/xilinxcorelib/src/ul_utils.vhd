-- ************************************************************************
--  Copyright (C) 1996, 1997 - Xilinx, Inc.
-- ************************************************************************
--  Title:	Unified library utilities
--  Created:	Fri Apr 11 11:09:56 1997
--  Author:	Tony Williams
--  $Id: ul_utils.vhd,v 1.12 2008/09/08 20:10:11 akennedy Exp $
--
--  Description:
--
--  Modification History:
--
--  $Header: /devl/xcs/repo/env/Databases/ip/src/com/xilinx/ip/ul/simulation/ul_utils.vhd,v 1.12 2008/09/08 20:10:11 akennedy Exp $
--
-- ************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE ul_utils IS

-- ------------------------------------------------------------------------ --
-- TYPES:								    --
-- ------------------------------------------------------------------------ --

  TYPE	  masktype    IS ARRAY(NATURAL RANGE<>) OF BIT;
  TYPE	  memdatatype IS ARRAY(NATURAL RANGE<>) OF INTEGER;
  SUBTYPE porttype    IS std_logic;
  SUBTYPE rloctype    IS INTEGER;
  SUBTYPE ffdestype   IS INTEGER;
  SUBTYPE fgdestype   IS INTEGER;
  SUBTYPE tbdestype   IS INTEGER;
  SUBTYPE husettype   IS STRING;
  SUBTYPE rominittype IS INTEGER;
  SUBTYPE rpmflagtype IS BOOLEAN;
  SUBTYPE husetflagtype IS BOOLEAN;

-- ------------------------------------------------------------------------ --
-- CONSTANTS:								    --
-- ------------------------------------------------------------------------ --

  CONSTANT ff_x		       : ffdestype   := 0;
  CONSTANT ff_y		       : ffdestype   := 1;
  CONSTANT ff_dont_care	       : ffdestype   := 2;
  CONSTANT default_ffselect    : ffdestype   := ff_dont_care;

  CONSTANT fg_f		       : fgdestype   := 0;
  CONSTANT fg_g		       : fgdestype   := 1;
  CONSTANT fg_dont_care	       : fgdestype   := 2;
  CONSTANT default_fgselect    : fgdestype   := fg_dont_care;

  CONSTANT tb_1		       : tbdestype   := 0;
  CONSTANT tb_2		       : tbdestype   := 1;
  CONSTANT tb_dont_care	       : tbdestype   := 2;
  CONSTANT default_tbselect    : tbdestype   := tb_dont_care;

  CONSTANT no_rpm	       : rpmflagtype := FALSE;
  CONSTANT yes_rpm	       : rpmflagtype := TRUE;
  CONSTANT default_userpm      : rpmflagtype := no_rpm;

  CONSTANT default_huset       : husettype   := "MOD";

  CONSTANT no_huset            : husetflagtype := FALSE;
  CONSTANT yes_huset           : husetflagtype := TRUE;
  CONSTANT default_usehuset    : husetflagtype := no_huset;

  CONSTANT default_2input_mask : masktype    := "00";
  CONSTANT default_3input_mask : masktype    := "000";
  CONSTANT default_4input_mask : masktype    := "0000";
  CONSTANT default_5input_mask : masktype    := "00000";

  CONSTANT default_fdce_ce     : porttype    := '1';
  CONSTANT default_fdce_clr    : porttype    := '0';
  CONSTANT default_fdpe_pre    : porttype := '0';
  CONSTANT default_fdpe_ce     : porttype := '1';

  CONSTANT default_rloc	       : rloctype    := 0;

  CONSTANT default_raminitval  : rominittype := 0;



-- ------------------------------------------------------------------------ --
-- SIMULATION CONSTANTS:						    --
-- ------------------------------------------------------------------------ --

  CONSTANT timeunit : TIME := 1 NS;

-- ------------------------------------------------------------------------ --
-- XNF ATTRIBUTES DECLARATIONS:						    --
-- ------------------------------------------------------------------------ --
			     -- ---------------------------------------- --
  attribute BLKNM : string;	--  Logical block name
  attribute CAP : boolean;	--  XC000H I/O
  attribute CMOS : boolean;	--  XC000H I/O
  attribute CYMODE : string;	--  carry mode
  attribute DECODE : boolean;	--  WAND attribute
  attribute DEF : string;		--  HM, BLOX, XBLOX, ROM
  attribute DIVIDE1_BY : string;	--  For XC5200 OSC52
  attribute DIVIDE2_BY : string;	--  For XC5200 OSC52
  attribute DOUBLE : boolean;	--  Double pullup
  attribute EQN : string;		--  For EQN symbol only
  attribute FAST : boolean;	--  Output transition time
--  attribute \FILE\ : string;	--  External XNF file
  -- Use of hu_set attribute has some Metamor --
  -- dependancies.			      --
  -- 2/20/97 TonyW			      --
  attribute HU_SET : string;	--  user-defined parameter for SYMs with RLOC
  attribute HBLKNM : string;	--  Hierarchical block name
  attribute INIT : string;	--  Initial value for FF and ROM
  attribute INTERNAL : boolean;	--  internal IOB
  attribute LEVEL : string;
  attribute LIBVER : string;	--  version string
  attribute LOC : string;
--attribute \MAP\ : string;	--  CLBMAP, FMAP, F5MAP, HMAP partitioning info
  attribute MEDFAST : boolean;	--  Output transition time
  attribute MEDSLOW : boolean;	--  Output transition time
  attribute NODELAY : boolean;	--  reduce input setup time
  attribute OSC : string;		--  source clock for OSC52
  attribute RES : boolean;	--  XC000H I/O
  attribute RLOC : string;	--  relative location
  attribute RLOC_ORIGIN : string;	--  relative location origin
  attribute RLOC_RANGE : string;	--  relative location range
  attribute SCHNM : string;	--  symbol type from schematic library
  attribute SLOW : boolean;	--  Output transition time
  attribute SYSTEM : string;	--  transfer info between programs
  attribute TNM : string;		--  TIMESPEC name
  --  TSnn attributes need to be added as needed.
  attribute TTL : boolean;	--  XC000H I/O
  attribute U_SET : string;	--  user-defined parameter for SYMs with RLOC
  attribute USE_RLOC : string;	--  TRUE or FALSE

  --  XNF signal attributes
  attribute C : boolean;		--  critical net
  attribute L : boolean;		--  use long-line
  attribute N : boolean;		--  non-critical net
  attribute PIN : string;		--  package pin name
  attribute S : boolean;		--  external connection
  attribute SC : boolean;		--  skew-critical net
  attribute X : boolean;		--  explicit net
  attribute W : integer;		--  routing weight

  --  XNF Pin (port) attributes
--  The INV attribute cannot currently be used when there is a component
--  called INV.	 So don't uncomment this until this problem is fixed.
--  Steve 97/04/11
--  attribute INV : boolean;	--  Invert pin
  attribute P : boolean;		--  lock pin

-- ------------------------------------------------------------------------ --
-- FUNCTION PROTOTYPES:							    --
-- ------------------------------------------------------------------------ --

  FUNCTION int_2_hex( value, bitwidth : INTEGER )
    RETURN STRING;

  FUNCTION int_2_std_logic_vector( value, bitwidth : INTEGER )
    RETURN std_logic_vector;

  FUNCTION two_comp(vect : std_logic_vector)
    RETURN std_logic_vector;

  FUNCTION func_rloc(rloc_x, rloc_y : rloctype; fg : fgdestype)
    RETURN STRING;

  FUNCTION hfunc_rloc(rloc_x, rloc_y : rloctype)
    RETURN STRING;

  FUNCTION flop_rloc(rloc_x, rloc_y : rloctype; xy : ffdestype)
    RETURN STRING;

  FUNCTION tbuf_rloc(rloc_x, rloc_y : rloctype; ab : tbdestype)
    RETURN STRING;

  FUNCTION cy4_rloc(rloc_x, rloc_y : rloctype)
    RETURN STRING;

  FUNCTION huset_name(huset:string; i:integer )
    RETURN STRING;

  FUNCTION form_huset(huset : string)
    RETURN STRING;

  FUNCTION std_logic_vector_2_posint(vect : std_logic_vector)
    RETURN INTEGER;

  FUNCTION int_2_string(rloc : rloctype)
    RETURN STRING;

  FUNCTION int_2_string3(val : integer)
    RETURN STRING;

  FUNCTION int_2_logic_string(value, bitwidth : INTEGER)
    RETURN STRING;

-- The RANGE has to be specified because of metamor bug
  FUNCTION mem_vector_2_int(bvec : STD_LOGIC_VECTOR(15 DOWNTO 0)) 
    RETURN INTEGER;

  FUNCTION bitsneededtorepresent( a_value : INTEGER )
    RETURN INTEGER;

  FUNCTION div2roundup( a_value : INTEGER )
    RETURN INTEGER;

  FUNCTION eval( condition : BOOLEAN )
    RETURN INTEGER;

  FUNCTION trim( vector : std_logic_vector; bits : INTEGER )
    RETURN std_logic_vector;

  FUNCTION extend( vector : std_logic_vector; bits : INTEGER )
    RETURN std_logic_vector;

  FUNCTION extend( vector : std_logic_vector; bits : POSITIVE; signed : BOOLEAN )
    RETURN std_logic_vector;

  FUNCTION range_check( value, lower_limit, upper_limit : INTEGER )
    RETURN INTEGER;

-- ------------------------------------------------------------------------ --
-- SIMULATION FUNCTION PROTOTYPES:					    --
-- ------------------------------------------------------------------------ --

  FUNCTION rat( value : std_logic )
    RETURN std_logic;

  FUNCTION std_logic_vector_2_int(vect : std_logic_vector)
    RETURN INTEGER;

  FUNCTION std_logic_vector_2_var(vect: std_logic_vector) 
    RETURN std_logic_vector;

  FUNCTION anyX(vect : std_logic_vector)
    RETURN BOOLEAN;

  FUNCTION any0(vect : std_logic_vector)
    RETURN BOOLEAN;

  FUNCTION setallX(width : integer)
    RETURN std_logic_vector;

  FUNCTION setall0(width : integer)
    RETURN std_logic_vector;


END ul_utils;

PACKAGE BODY ul_utils IS

-- ------------------------------------------------------------------------ --
-- FUNCTIONS:								    --
-- ------------------------------------------------------------------------ --

  FUNCTION range_check( value, lower_limit, upper_limit : INTEGER )
    RETURN INTEGER IS

  BEGIN

    IF value>upper_limit THEN
      RETURN upper_limit;
    ELSIF value<lower_limit THEN
      RETURN lower_limit;
    ELSE
      RETURN value;
    END IF;

  END range_check;

-- ------------------------------------------------------------------------ --

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

-- ------------------------------------------------------------------------ --

  FUNCTION int_2_std_logic_vector( value, bitwidth : INTEGER )
    RETURN std_logic_vector IS

    VARIABLE running_value  : INTEGER := value;
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
        running_value := running_value/2;
    END LOOP;

    IF (value < 0) THEN -- find the 2s complement
       RETURN two_comp(running_result);
    ELSE
      RETURN running_result;
    END IF;

  END int_2_std_logic_vector;

-- ------------------------------------------------------------------------ --

  FUNCTION two_comp(vect : std_logic_vector)
    RETURN std_logic_vector IS

  variable local_vect : std_logic_vector(vect'HIGH downto 0);
  variable toggle : INTEGER := 0;

  BEGIN

    FOR i IN 0 to vect'HIGH LOOP
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

-- ------------------------------------------------------------------------ --

  FUNCTION func_rloc(rloc_x, rloc_y : rloctype; fg : fgdestype)
    RETURN STRING IS

  BEGIN

    CASE fg IS
      WHEN fg_f => RETURN ("R" & int_2_string(rloc_y) & "C" & int_2_string(rloc_x) & ".F");
      WHEN fg_g => RETURN ("R" & int_2_string(rloc_y) & "C" & int_2_string(rloc_x) & ".G");
      WHEN OTHERS => RETURN ("R" & int_2_string(rloc_y) & "C" & int_2_string(rloc_x));
    END CASE;

  END func_rloc;

-- ------------------------------------------------------------------------ --

  FUNCTION hfunc_rloc(rloc_x, rloc_y : rloctype)
    RETURN STRING IS

  BEGIN

    RETURN ("R" & int_2_string(rloc_y) & "C" & int_2_string(rloc_x));

  END hfunc_rloc;

-- ------------------------------------------------------------------------ --

  FUNCTION flop_rloc(rloc_x, rloc_y : rloctype; xy : ffdestype)
    RETURN STRING IS

  BEGIN

    CASE xy IS
      WHEN ff_x => RETURN ("R" & int_2_string(rloc_y) & "C" & int_2_string(rloc_x) & ".FFX");
      WHEN ff_y => RETURN ("R" & int_2_string(rloc_y) & "C" & int_2_string(rloc_x) & ".FFY");
      WHEN OTHERS => RETURN ("R" & int_2_string(rloc_y) & "C" & int_2_string(rloc_x));
    END CASE;

  END flop_rloc;

-- ------------------------------------------------------------------------ --

  FUNCTION tbuf_rloc(rloc_x, rloc_y : rloctype; ab : tbdestype)
    RETURN STRING IS

  BEGIN

    CASE ab IS
      WHEN tb_1 => RETURN ("R" & int_2_string(rloc_y) & "C" & int_2_string(rloc_x) & ".1");
      WHEN tb_2 => RETURN ("R" & int_2_string(rloc_y) & "C" & int_2_string(rloc_x) & ".2");
      WHEN OTHERS => RETURN ("R" & int_2_string(rloc_y) & "C" & int_2_string(rloc_x));
    END CASE;

  END tbuf_rloc;

-- ------------------------------------------------------------------------ --

  FUNCTION cy4_rloc(rloc_x, rloc_y : rloctype)
    RETURN STRING IS

  BEGIN

    RETURN ("R" & int_2_string(rloc_y) & "C" & int_2_string(rloc_x));

  END cy4_rloc;

-- ------------------------------------------------------------------------ --

  FUNCTION form_huset(huset : string)

    RETURN STRING IS

  BEGIN

    IF (huset = "") THEN
      RETURN default_huset;
    ELSE
      RETURN huset;
    END IF;

  END form_huset;

-- ------------------------------------------------------------------------ --

  FUNCTION huset_name(huset: string; i : integer)

    RETURN STRING IS
  BEGIN

    RETURN  int_2_string3(i); -- & huset
  END huset_name;

-- ------------------------------------------------------------------------ --

  FUNCTION std_logic_vector_2_posint(vect : std_logic_vector)
    RETURN INTEGER IS

    variable result : INTEGER := 0;

  BEGIN

    FOR i in vect'HIGH downto vect'LOW LOOP
      result := result * 2;
      IF (rat(vect(i)) = '1') THEN
	result := result + 1;
      ELSIF (rat(vect(i)) /= '0') THEN
	ASSERT FALSE
	  REPORT "Treating a non 0-1 std_logic_vector as 0 in std_logic_vector_2_posint"
	  SEVERITY WARNING;
      END IF;
    END LOOP;

    RETURN result;

  END std_logic_vector_2_posint;

-- ------------------------------------------------------------------------ --

  FUNCTION int_2_string(rloc : rloctype)
    RETURN STRING IS

    VARIABLE digit : INTEGER;
    VARIABLE value : rloctype := rloc;
    VARIABLE length : INTEGER := 0;
    VARIABLE posn : INTEGER;
    CONSTANT str : STRING(1 TO 10) := "0123456789";
    VARIABLE ret_value : STRING(1 TO 5);

  BEGIN

    ASSERT (rloc >= 0)
    REPORT "Function int_2_string must receive a positive integer."
    SEVERITY ERROR;

    IF (rloc = 0) THEN
      RETURN "0";
    ELSIF (rloc < 10) THEN
      length := 1;
    ELSIF (rloc < 100) THEN
      length := 2;
    ELSIF (rloc < 1000) THEN
      length := 3;
    ELSIF (rloc < 10000) THEN
      length := 4;
    ELSIF (rloc < 100000) THEN
      length := 5;
    ELSE
      ASSERT (false)
      REPORT "Function int_2_string must receive an integer < 100,000."
      SEVERITY ERROR;
    END IF;

    IF (length > 0) THEN -- Required because Metamor bombs without it
      posn := length;
      WHILE (value /= 0) LOOP
	digit := value MOD 10;
	ret_value(posn) := str(digit+1);
	value := value/10;
	posn := posn - 1;
      END LOOP;
    END IF;

    RETURN ret_value(1 TO length);

  END int_2_string;

-- ------------------------------------------------------------------------ --

  FUNCTION int_2_string3(val : integer)
    RETURN string IS

    VARIABLE digit : INTEGER;
    VARIABLE value : integer := val;
    VARIABLE length : INTEGER := 0;
    VARIABLE posn : INTEGER;
    CONSTANT str : STRING(1 TO 10) := "0123456789";
    VARIABLE ret_value : string(1 to 3) := "000";

  BEGIN

    ASSERT (val >= 0)
    REPORT "Function int_2_string3 must receive a positive integer."
    SEVERITY ERROR;

    ASSERT (val < 999)
    REPORT "Function int_2_string3 must receive an integer < 999."
    SEVERITY ERROR;

    IF (val = 0) THEN
      RETURN "000";
    ELSE
      posn := 3;
      WHILE (value /= 0) LOOP
	digit := value MOD 10;
	ret_value(posn) := str(digit+1);
	value := value/10;
	posn := posn - 1;
      END LOOP;
    END IF;

    RETURN ret_value;

  END int_2_string3;

-- ------------------------------------------------------------------------ --

-- Not deal with negative number
  FUNCTION int_2_logic_string( value, bitwidth : INTEGER )
    RETURN STRING IS

    VARIABLE running_value  : INTEGER := value;
    VARIABLE running_result : STRING(bitwidth DOWNTO 1);
    constant str: STRING(1 to 2) :="01";
  BEGIN

    FOR i IN bitwidth-1 DOWNTO 0 LOOP

      IF (2**i)>running_value THEN
	running_result(i+1) := str(1);
      ELSE
	running_result(i+1) := str(2);
	running_value := running_value - (2**i);
      END IF;

    END LOOP;

    RETURN running_result;

  END int_2_logic_string;

-- ------------------------------------------------------------------------ --

FUNCTION mem_vector_2_int(bvec : STD_LOGIC_VECTOR(15 DOWNTO 0)) 
  RETURN INTEGER IS
  VARIABLE memint : INTEGER;
  BEGIN
    memint := 0;
    FOR nbit IN 15 DOWNTO 0
    LOOP
	memint := 2*memint;
      IF (bvec(nbit) = '1') THEN
        memint := memint+1;
      ELSIF (bvec(nbit) /= '0') THEN
        ASSERT FALSE 
          REPORT "Treating a non 0-1 std_logic_vector as 0 in mem_vec_2_int"
          SEVERITY WARNING;
      END IF;
    END LOOP;
  RETURN memint;
END mem_vector_2_int;

-- ------------------------------------------------------------------------ --

  FUNCTION trim( vector : std_logic_vector; bits : INTEGER )
    RETURN std_logic_vector IS

    VARIABLE return_value : std_logic_vector(bits-1 DOWNTO 0);

  BEGIN

    RETURN vector(bits-1 DOWNTO 0);

  END trim;

-------------------------------------------------------------------------------
--  extend: sign extend a bit vector to the designated width.
-------------------------------------------------------------------------------

  FUNCTION extend( vector : std_logic_vector; bits : INTEGER )
    RETURN std_logic_vector IS

    CONSTANT return_width : INTEGER := bits; -- greatest2( bits, vector'LENGTH );
    VARIABLE return_value : std_logic_vector(return_width-1 DOWNTO 0);

  BEGIN

    FOR i IN 0 TO return_width-1 LOOP
      IF i <= vector'LENGTH-1 THEN
	return_value(i) := vector(i);
      ELSE
	return_value(i) := vector(vector'high);
      END IF;
    END LOOP;

    RETURN return_value;

  END extend;

-------------------------------------------------------------------------------
--  extend: Extend a bit vector to the designated width.
--  Depending on the value of "signed", the vector is either sign-extended or
--  zero-extended.
-------------------------------------------------------------------------------

  FUNCTION extend( vector : std_logic_vector; bits : POSITIVE; signed : BOOLEAN )
    RETURN std_logic_vector IS

    VARIABLE return_value :
	std_logic_vector(bits-1 +vector'low  DOWNTO vector'low);

  BEGIN

--    report "extend(vector,"&integer'image(bits)&")"&cr&"return_value bounds: "
--	& integer'image(return_value'high) & " downto "
--	& integer'image(return_value'low) & cr
--	& "vector bounds: "
--	& integer'image(vector'high) & " downto "
--	& integer'image(vector'low) & cr;

    return_value(vector'high downto return_value'low) := vector;
    FOR i IN vector'high +1 TO return_value'high LOOP
      if (signed) then			--  Sign extend.
	return_value(i) := vector(vector'high);
      ELSE				 --  Zero extend.
	return_value(i) := '0';
      END IF;
    END LOOP;

    RETURN return_value;

  END extend;

-- ------------------------------------------------------------------------ --

  FUNCTION eval( condition : BOOLEAN )
    RETURN INTEGER IS

  BEGIN

    IF condition=TRUE THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;

  END eval;

-- ------------------------------------------------------------------------ --

  FUNCTION div2roundup( a_value : INTEGER )
    RETURN INTEGER IS

  BEGIN

    RETURN (a_value / 2) + (a_value MOD 2);

  END div2roundup;

-- ------------------------------------------------------------------------ --

  FUNCTION bitsneededtorepresent( a_value : INTEGER )
    RETURN INTEGER IS

    VARIABLE return_value : INTEGER := 1;

  BEGIN

    FOR i IN 30 DOWNTO 0 LOOP
      IF a_value >= 2**i THEN
	return_value := i+1;
	EXIT;
      END IF;
    END LOOP;

    RETURN return_value;

  END bitsneededtorepresent;

-- ------------------------------------------------------------------------ --
-- SIMULATION FUNCTIONS							    --
-- ------------------------------------------------------------------------ --

  FUNCTION rat( value : std_logic )
    RETURN std_logic IS

  BEGIN

    CASE value IS
      WHEN '0' | '1' => RETURN value;
      WHEN 'H' => RETURN '1';
      WHEN 'L' => RETURN '0';
      WHEN OTHERS => RETURN 'X';
    END CASE;

  END rat;

-- ------------------------------------------------------------------------ --

  FUNCTION std_logic_vector_2_int(vect : std_logic_vector)
    RETURN INTEGER IS

    variable local_vect : std_logic_vector(vect'HIGH downto 0);
    variable result : INTEGER := 0;

  BEGIN

    IF (rat(vect(vect'HIGH)) = '1') THEN -- negative number
      local_vect := two_comp(vect);
    ELSE
      local_vect := vect;
    END IF;

    FOR i in vect'HIGH downto 0 LOOP
      result := result * 2;
      IF (rat(local_vect(i)) = '1') THEN
	result := result + 1;
      ELSIF (rat(local_vect(i)) /= '0') THEN
	ASSERT FALSE
	  REPORT "Treating a non 0-1 std_logic_vector as 0 in std_logic_vector_2_int"
	  SEVERITY WARNING;
      END IF;
    END LOOP;

    IF (rat(vect(vect'HIGH)) = '1') THEN
       result := -1 * result;
    END IF;

    RETURN result;

  END std_logic_vector_2_int;

-- ------------------------------------------------------------------------ --
  FUNCTION std_logic_vector_2_var (vect: std_logic_vector) 

  RETURN std_logic_vector IS
    VARIABLE mvl: std_logic_vector(vect'LEFT DOWNTO vect'RIGHT);

  BEGIN
    FOR i IN vect'RANGE LOOP
	mvl(i) := rat(vect(i));
    END LOOP;
    RETURN mvl;

  END std_logic_vector_2_var;

-- ------------------------------------------------------------------------ --

  FUNCTION anyX(vect : std_logic_vector)

    RETURN BOOLEAN IS

  BEGIN

    FOR i IN vect'RANGE LOOP
      IF (rat(vect(i)) = 'X') THEN
	 return TRUE;
      END IF;
    END LOOP;

    return FALSE;

  END anyX;

-- ------------------------------------------------------------------------ --

  FUNCTION any0(vect : std_logic_vector)

    RETURN BOOLEAN IS

  BEGIN

    FOR i IN vect'RANGE LOOP
      IF (rat(vect(i)) = '0') THEN
	 return TRUE;
      END IF;
    END LOOP;

    return FALSE;

  END any0;

-- ------------------------------------------------------------------------ --

  FUNCTION setallX(width : integer)

    RETURN std_logic_vector IS

  variable vect: std_logic_vector(width-1 downto 0);
  BEGIN

    FOR i in 0 to width-1 LOOP
      vect(i) := 'X';
    END LOOP;

    return vect;

  END setallX;

-- ------------------------------------------------------------------------ --

  FUNCTION setall0(width : integer)

    RETURN std_logic_vector IS

  variable vect: std_logic_vector(width-1 downto 0);
  BEGIN

    FOR i in 0 to width-1 LOOP
      vect(i) := '0';
    END LOOP;

    return vect;

  END setall0;

END ul_utils;

-- ------------------------------------------------------------------------ --

Library IEEE;

Package MATH_INT is

    --
    -- function declarations
    --
    function SIGN (X: integer ) return integer;
	-- returns 1 if X > 0; 0 if X == 0; -1 if X < 0

    function CEILING (X : real ) return integer;
	-- returns smallest integer value not less than X

    function CEILING_RAT (N, D : real ) return integer;
	-- returns smallest integer value not less than N / D

    function FLOOR (X : real ) return integer;
	-- returns largest integer value not greater than X

    function IMAX (X, Y : integer ) return integer;
	-- returns the algebraically larger of X and Y

    function IMIN (X, Y : integer ) return integer;
	-- returns the algebraically smaller of X and Y

end  MATH_INT;
Library IEEE;

Package body MATH_INT is

    --
    -- non-trascendental functions
    --
function SIGN (X: integer ) return integer is
  -- returns 1 if X > 0; 0 if X == 0; -1 if X < 0
begin
    if	( X > 0 )
    then
      return 1;
    elsif ( X < 0 )
    then
      return -1;
    else
      return 0;
    end if;
end SIGN;

function CEILING (X : real ) return integer is
  -- returns smallest integer value (as integer) not less than X
  -- No conversion to an integer type is expected, so truncate cannot
  -- overflow for large arguments.

  constant large: integer  := 1073741824;
  type long is range -1073741824 to 1073741824;
  -- 2**30 is longer than any single-precision mantissa
  variable round: integer;

  begin
    if integer(abs( X)) >= large
    then
      return integer(X);
    else
      round := integer(X);	-- Defined as rounding (up or down)
--	report "CEILING(" & real'image(X) & ") = " & integer'image(round) & cr;
      if X > 0.0
      then
	if real(round) >= X
	then
	  return round;
	else
	  return round + 1;
	end if;
      elsif  X = 0.0
      then
	return 0;
      else
	if real(round) <= X
	then
	  return round;
	else
	  return round - 1;
	end if;
      end if;
    end if;
end CEILING;

--  A CEILING function for rational numbers.
function CEILING_RAT (N, D : real ) return integer is
  -- returns smallest integer value (as integer) not less than N/D
  variable trunc: integer;
  variable mult : real;

begin
  trunc := integer(N / D);
  mult := D * real(trunc);
  if (N = 0.0)
  then
    trunc := 0;
  end if;

  if (N > 0.0 AND D > 0.0) OR (N < 0.0 AND D < 0.0)
  then			       --  result is positive
    if mult /= N
    then	--  Truncation is towards 0.
      trunc := trunc +1;
    end if;
	--  If the result is negative, the result is either already exact or
	--  truncated in the correct direction.
  end if;
--  report "CEILING_RAT(" & real'image(N) & ", " & real'image(D) & ") = " & integer'image(trunc) & cr;
  return (trunc);
end CEILING_RAT;

function FLOOR (X : real ) return integer is
  -- returns largest integer value (as integer) not greater than X
  -- No conversion to an integer type is expected, so truncate
  -- cannot overflow for large arguments.
  --
  variable large: integer  := 1073741824;
  type long is range -1073741824 to 1073741824;
  -- 2**30 is longer than any single-precision mantissa
  variable round: integer;

begin
  if abs( X ) >= real(large)
  then
    return large;
  else
    round := integer(X);	-- Defined as rounding (up or down).
    if X > 0.0
    then
      if real(round) <= X
      then
	return round;
      else
	return round - 1;
      end if;
    elsif  X = 0.0
    then
      return 0;
    else
      if real(round) >= X
      then
	return round;
      else
	return round + 1;
      end if;
    end if;
  end if;
end FLOOR;

function IMAX (X, Y : integer ) return integer is
  -- returns the algebraically larger of X and Y
begin
  if X > Y
  then
    return X;
  else
    return Y;
  end if;
end IMAX;

function IMIN (X, Y : integer ) return integer is
  -- returns the algebraically smaller of X and Y
begin
  if X < Y
  then
    return X;
  else
    return Y;
  end if;
end IMIN;

end  MATH_INT;

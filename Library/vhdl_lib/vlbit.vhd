-- mm 2.0.0
------------------------------------------------------------------------
--                                                                    --
-- Contents:       Package pack1076                                   --
--                                                                    --
--                 This package contains type and subprogram          --
--                 declarations for Viewlogic's builtin               --
--                 type conversion and bus resolution functions.      --
--                 This package should be used when porting VHDL      --
--                 models written for the Viewsim simulator to other  --
--                 VHDL environments.                                 --
--                                                                    --
--                 This code may be freely distributed, copied, or    --
--                 modified by any interested parties (with the       --
--                 request that modifications be noted in the         --
--                 revision history, and any errors found be reported --
--                 to Customer Support at Viewlogic Systems.)         --
--                                                                    --
--                 This code is NOT copyrighted.  Viewlogic supplies  --
--                 this package with the intention that it be         --
--                 distributed as a deliverable with VHDL models.     --
--                                                                    --
-- Caveats:        The behavior of the builtin function bschanging()  --
--                 is not defined here since it is not portable.      --
--                 (It violates the rule of a statically determinable --
--                 signal name.)                                      --
--                                                                    --
-- Revision History:                                                  --
--                                                                    --
-- Who          When       What                                       --
--                                                                    --
-- bobf         01-Aug-94  Metamor port, changes marked with "--*"    --
-- I.Dahan      13-Mar-91  Added definitions for character_1d.        --
-- M.Chapman    04-Mar-91  Removed copyright notice.                  --
-- I.Dahan      15-Dec-90  Final code cleanup for initial release.    --
------------------------------------------------------------------------
------------------------------------------------------------------------

--*---------------------------------------------------------------------
--* Metamor modifications , for use with Metamor compler ONLY
--*----------------------
--* 1) comment all subprograms using textio.
--* 2) use vhdl'93 shift operations.
--* 3) use Metamor array_arith functions in arithmetic subprograms.
--* 4) add 4 local functions : vlb2bit , bit2vlb, v1d2bv, bv2v1d
--*
--* CAVEAT : vlbit designs *may* make use of register inferrence conventions
--* that are different from those used by Metamor. Watch out for preset/reset
--* specified in a wait statement along with the clock. Using Metamor this
--* will result in a gated clock which is probably not what you want.
--* You should validate using simulation and also check the number of registers
--* used and their type (flip-flop/latch, preset/reset, sync/async).
--* 
--*---------------------------------------------------------------------

--*use std.textio.all;
--* add reference to Metamor
library metamor;
use metamor.attributes.all;
use metamor.array_arith.all;

package pack1076 is

------------------------------------------------------------------------
-- Type declaration for Viewlogic's bit and vector types.             --
-- Resolution function is also given.                                 --
------------------------------------------------------------------------

   type     vlbit_base        is ('X', 'Z', '0', '1');

--* Metamor specific attribute		       
--*-----------------------------------------------------------------    
   attribute enum_encoding of vlbit_base : type is  "- Z 0 1";
    
   type     vlbit_base_vector is array (integer range<>) of vlbit_base;

   function vlbit_resolve     (inputs: vlbit_base_vector) return vlbit_base;

   subtype  vlbit             is vlbit_resolve vlbit_base;

   type     vlbit_1d          is array (integer range<>) of vlbit;
   subtype  vlbit_vector      is vlbit_1d;
   type     vlbit_2d          is array (integer range<>,
                                        integer range<>) of vlbit;

   type     integer_1d        is array (integer range<>) of integer;
   type     integer_2d        is array (integer range<>,
                                        integer range<>) of integer;

   type     boolean_1d        is array (integer range<>) of boolean;
   type     boolean_2d        is array (integer range<>,
                                        integer range<>) of boolean;

   type     time_1d           is array (integer range<>) of time;
   type     time_2d           is array (integer range<>,
                                        integer range<>) of time;

   type     character_1d      is array (integer range<>) of character;
   type     character_2d      is array (integer range<>,
                                        integer range<>) of character;

------------------------------------------------------------------------
-- Conversion functions                                               --
------------------------------------------------------------------------

   function int2vlb             (i: integer)  return vlbit;
   function boo2vlb             (b: boolean)  return vlbit;
   function vlb2boo             (v: vlbit)    return boolean;
   function int2boo             (i: integer)  return boolean;
   function vlb2int             (v: vlbit)    return integer;
   function boo2int             (b: boolean)  return integer;

   function int2vec             (i: integer)  return vlbit_vector;
   function int2v1d             (i: integer)  return vlbit_1d;
   function v1d2int             (v: vlbit_1d) return integer;

------------------------------------------------------------------------
-- overloading                                                        --
------------------------------------------------------------------------

   function "="                 (v1, v2: vlbit)    return boolean;
   function "/="                (v1, v2: vlbit)    return boolean;
   function "<"                 (v1, v2: vlbit)    return boolean;
   function "<="                (v1, v2: vlbit)    return boolean;
   function ">"                 (v1, v2: vlbit)    return boolean;
   function ">="                (v1, v2: vlbit)    return boolean;
   function "AND"               (v1, v2: vlbit)    return vlbit;
   function "OR"                (v1, v2: vlbit)    return vlbit;
   function "NAND"              (v1, v2: vlbit)    return vlbit;
   function "NOR"               (v1, v2: vlbit)    return vlbit;
   function "XOR"               (v1, v2: vlbit)    return vlbit;
   function "NOT"               (v:      vlbit)    return vlbit;
   function "AND"               (v1, v2: vlbit_1d) return vlbit_1d;
   function "OR"                (v1, v2: vlbit_1d) return vlbit_1d;
   function "NAND"              (v1, v2: vlbit_1d) return vlbit_1d;
   function "NOR"               (v1, v2: vlbit_1d) return vlbit_1d;
   function "XOR"               (v1, v2: vlbit_1d) return vlbit_1d;
   function "NOT"               (v:      vlbit_1d) return vlbit_1d;

------------------------------------------------------------------------
-- predefined functions                                               --
------------------------------------------------------------------------

   function addum             (v1, v2: vlbit_1d)             return vlbit_1d;
   function add2c             (v1, v2: vlbit_1d)             return vlbit_1d;
   function comp2c            (v:      vlbit_1d)             return vlbit_1d;
   function divum             (v1, v2: vlbit_1d)             return vlbit_1d;
   function div2c             (v1, v2: vlbit_1d)             return vlbit_1d;
   function extendum          (v: vlbit_1d; i: integer)      return vlbit_1d;
   function extend2c          (v: vlbit_1d; i: integer)      return vlbit_1d;
   function mulum             (v1, v2: vlbit_1d)             return vlbit_1d;
   function mul2c             (v1, v2: vlbit_1d)             return vlbit_1d;
   function shiftlum          (v:      vlbit_1d; i: integer) return vlbit_1d;
   function shiftl2c          (v:      vlbit_1d; i: integer) return vlbit_1d;
   function shiftrum          (v:      vlbit_1d; i: integer) return vlbit_1d;
   function shiftr2c          (v:      vlbit_1d; i: integer) return vlbit_1d;
   function subum             (v1, v2: vlbit_1d)             return vlbit_1d; 
   function sub2c             (v1, v2: vlbit_1d)             return vlbit_1d;

--* function bchanging         (signal s: vlbit_1d) return boolean;
--* function bitunknown        (v:        vlbit)    return boolean;
--* function bitX              (v:        vlbit)    return boolean;
--* function bitZ              (v:        vlbit)    return boolean;
--* function bschanging        (signal s: vlbit_1d;
--*                               i, j:   integer)  return boolean;
--* function pchanging         (signal s: vlbit)    return boolean;
   function pfalling          (signal s: vlbit)    return boolean;
   function prising           (signal s: vlbit)    return boolean;
--* function vecunknown        (v:        vlbit_1d) return boolean;
--* function vecX              (v:        vlbit_1d) return boolean;
--* function vecZ              (v:        vlbit_1d) return boolean;

------------------------------------------------------------------------
-- Predefined I/O procedures                                          --
------------------------------------------------------------------------

--* procedure put              (s: in string);
--* procedure putline          (s: in string);
--* procedure put              (s: in string; v: in vlbit);
--* procedure putline          (s: in string; v: in vlbit);
--* procedure put              (s: in string; v: in vlbit_1d);
--* procedure putline          (s: in string; v: in vlbit_1d);
--* procedure put              (s: in string; v: in vlbit_2d);
--* procedure putline          (s: in string; v: in vlbit_2d);
--* procedure put              (s: in string; b: in boolean);
--* procedure putline          (s: in string; b: in boolean);
--* procedure put              (s: in string; b: in boolean_1d);
--* procedure putline          (s: in string; b: in boolean_1d);
--* procedure put              (s: in string; b: in boolean_2d);
--* procedure putline          (s: in string; b: in boolean_2d);
--* procedure put              (s: in string; i: in integer);
--* procedure putline          (s: in string; i: in integer);
--* procedure put              (s: in string; i: in integer_1d);
--* procedure putline          (s: in string; i: in integer_1d);
--* procedure put              (s: in string; i: in integer_2d);
--* procedure putline          (s: in string; i: in integer_2d);
--* procedure put              (s: in string; t: in time);
--* procedure putline          (s: in string; t: in time);
--* procedure put              (s: in string; t: in time_1d);
--* procedure putline          (s: in string; t: in time_1d);
--* procedure put              (s: in string; t: in time_2d);
--* procedure putline          (s: in string; t: in time_2d);
--* procedure put              (s: in string; c: in character);
--* procedure putline          (s: in string; c: in character);
--* procedure put              (s: in string; c1: in character_1d);
--* procedure putline          (s: in string; c1: in character_1d);
--* procedure put              (s: in string; c2: in character_2d);
--* procedure putline          (s: in string; c2: in character_2d);
--* procedure put              (s: in string; st: in string);
--* procedure putline          (s: in string; st: in string);
   
--* procedure fwrite           (variable ft: out text; v: in vlbit;       b: out boolean);
--* procedure fwriteline       (variable ft: out text; v: in vlbit;       b: out boolean); 
--* procedure fwrite           (variable ft: out text; v: in vlbit_1d;    b: out boolean);
--* procedure fwriteline       (variable ft: out text; v: in vlbit_1d;    b: out boolean);
--* procedure fwrite           (variable ft: out text; v: in vlbit_2d;    b: out boolean);
--* procedure fwriteline       (variable ft: out text; v: in vlbit_2d;    b: out boolean);
--* procedure fwrite           (variable ft: out text; b1: in boolean;    b: out boolean);
--* procedure fwriteline       (variable ft: out text; b1: in boolean;    b: out boolean);
--* procedure fwrite           (variable ft: out text; b1: in boolean_1d; b: out boolean);
--* procedure fwriteline       (variable ft: out text; b1: in boolean_1d; b: out boolean);
--* procedure fwrite           (variable ft: out text; b1: in boolean_2d; b: out boolean);
--* procedure fwriteline       (variable ft: out text; b1: in boolean_2d; b: out boolean);
--* procedure fwrite           (variable ft: out text; i: in integer;     b: out boolean);
--* procedure fwriteline       (variable ft: out text; i: in integer;     b: out boolean);
--* procedure fwrite           (variable ft: out text; i: in integer_1d;  b: out boolean);
--* procedure fwriteline       (variable ft: out text; i: in integer_1d;  b: out boolean);
--* procedure fwrite           (variable ft: out text; i: in integer_2d;  b: out boolean);
--* procedure fwriteline       (variable ft: out text; i: in integer_2d;  b: out boolean);
--* procedure fwrite           (variable ft: out text; t: in time;        b: out boolean);
--* procedure fwriteline       (variable ft: out text; t: in time;        b: out boolean);
--* procedure fwrite           (variable ft: out text; t: in time_1d;     b: out boolean);
--* procedure fwriteline       (variable ft: out text; t: in time_1d;     b: out boolean);
--* procedure fwrite           (variable ft: out text; t: in time_2d;     b: out boolean);
--* procedure fwriteline       (variable ft: out text; t: in time_2d;     b: out boolean);
--* procedure fwrite           (variable ft: out text; c: in character;   b: out boolean);
--* procedure fwriteline       (variable ft: out text; c: in character;   b: out boolean);
--* procedure fwrite           (variable ft: out text; c1: in character_1d;   b: out boolean);
--* procedure fwriteline       (variable ft: out text; c1: in character_1d;   b: out boolean);
--* procedure fwrite           (variable ft: out text; c2: in character_2d;   b: out boolean);
--* procedure fwriteline       (variable ft: out text; c2: in character_2d;   b: out boolean);
--* procedure fwrite           (variable ft: out text; st: in string;     b: out boolean);
--* procedure fwriteline       (variable ft: out text; st: in string;     b: out boolean);

--* procedure freadline        (variable ft: in text; c: out character; b: out boolean) ;
--* procedure freadline        (variable ft: in text; st: out string;   b: out boolean) ;
--* procedure freadline        (variable ft: in text; c1: out character_1d; b: out boolean) ;
--* procedure freadline        (variable ft: in text; c2: out character_2d; b: out boolean) ;
--* procedure freadline        (variable ft: in text; v: out vlbit;     b: out boolean) ;
--* procedure freadline        (variable ft: in text; v: out vlbit_1d;  b: out boolean) ;
--* procedure freadline        (variable ft: in text; v: out vlbit_2d;  b: out boolean) ;
--* procedure freadline        (variable ft: in text; b1: out boolean;  b: out boolean) ;
--* procedure freadline        (variable ft: in text; b1: out boolean_1d;  b: out boolean) ;
--* procedure freadline        (variable ft: in text; b1: out boolean_2d;  b: out boolean) ;
--* procedure freadline        (variable ft: in text; i: out integer;       b: out boolean) ;
--* procedure freadline        (variable ft: in text; i1: out integer_1d;   b: out boolean) ;
--* procedure freadline        (variable ft: in text; i1: out integer_2d;   b: out boolean) ;
--* procedure freadline        (variable ft: in text; t: out time;         b: out boolean) ;
--* procedure freadline        (variable ft: in text; t: out time_1d;      b: out boolean) ;
--* procedure freadline        (variable ft: in text; t: out time_2d;      b: out boolean) ;

--* procedure getline          (s: in string; c: out character;    b: out boolean) ;
--* procedure getline          (s: in string; st: out string;      b: out boolean) ;
--* procedure getline          (s: in string; c1: out character_1d;    b: out boolean) ;
--* procedure getline          (s: in string; c2: out character_2d;    b: out boolean) ;
--* procedure getline          (s: in string; v: out vlbit;        b: out boolean) ;
--* procedure getline          (s: in string; v: out vlbit_1d;     b: out boolean) ;
--* procedure getline          (s: in string; v: out vlbit_2d;     b: out boolean) ;
--* procedure getline          (s: in string; b1: out boolean;     b: out boolean) ;
--* procedure getline          (s: in string; b1:out boolean_1d;  b: out boolean) ;
--* procedure getline          (s: in string; b1:out boolean_2d;  b: out boolean) ;
--* procedure getline          (s: in string; i: out integer;      b: out boolean) ;
--* procedure getline          (s: in string; i1:out integer_1d;  b: out boolean) ;
--* procedure getline          (s: in string; i1:out integer_2d;  b: out boolean) ;
--* procedure getline          (s: in string; t: out time;         b: out boolean) ;
--* procedure getline          (s: in string; t: out time_1d;      b: out boolean) ;
--* procedure getline          (s: in string; t: out time_2d;      b: out boolean) ;

end pack1076;


package body pack1076 is

------------------------------------------------------------------------
   function vlbit_resolve     (inputs: vlbit_base_vector) return vlbit_base is
      type vlbit_base_table is array (vlbit_base'left to vlbit_base'right, 
                                      vlbit_base'left to vlbit_base'right) of 
                                      vlbit_base;

      constant merge: vlbit_base_table := -- 'X' 'Z' '0' '1'
                                           (('X','X','X','X'), -- 'X'
                                            ('X','Z','0','1'), -- 'Z'
                                            ('X','0','0','X'), -- '0'
                                            ('X','1','X','1'));-- '1'
      variable result: vlbit_base := 'Z';
   begin
      for i in inputs'range loop
         result := merge (result, inputs (i));
      end loop;
      return result;
   end;

------------------------------------------------------------------------
   function int2vlb             (i: integer) return vlbit is
   begin
      case i is
         when 0 =>      return '0';
         when 1 =>      return '1';
         when others => return 'X';
      end case;
   end;

------------------------------------------------------------------------
   function boo2vlb             (b: boolean) return vlbit is
   begin
      case b is
         when false => return '0';
         when true  => return '1';
      end case;
   end;

------------------------------------------------------------------------
   function vlb2boo           (v: vlbit)   return boolean is
   begin
      case v is
         when '1'    => return true;
         when others => return false;
      end case;
   end;

------------------------------------------------------------------------
   function int2boo           (i: integer) return boolean is
   begin
      case i is 
         when 1      => return true;
         when others => return false;
      end case;
   end;

------------------------------------------------------------------------
   function vlb2int           (v: vlbit)   return integer is
   begin
      case v is
         when '1'    => return 1;
         when others => return 0;
      end case;
   end;

------------------------------------------------------------------------
   function boo2int           (b: boolean) return integer is
   begin
      case b is
         when false => return 0;
         when true  => return 1;
      end case;
   end;

------------------------------------------------------------------------
   function int2vec      (i: integer)  return vlbit_vector is
      variable temp: integer := i;
      variable result: vlbit_vector (0 to 31) := 
           ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
            '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0');
   begin
      for b in 31 downto 0 loop
         if temp rem 2 = 1 then
            result (b) := '1';
         end if;
         temp := temp / 2;
      end loop;
      return result;
   end;

------------------------------------------------------------------------
   function int2v1d          (i: integer)  return vlbit_1d is
      variable temp:   integer := i;
      variable result: vlbit_1d (31 downto 0) := 
           ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0',
            '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0');
   begin
      for b in 0 to 31 loop
         if temp rem 2 = 1 then
            result (b) := '1';
         end if;
         temp := temp / 2;
      end loop;
      return result;
   end;

------------------------------------------------------------------------
   function v1d2int           (v: vlbit_1d) return integer is
      variable result: integer := 0;
      variable addition: integer := 1;
   begin
      for b in v'reverse_range loop
         if v (b) = '1' then
            result := result + addition;
         end if;
         addition := addition *2;
      end loop;
      return result;
   end;


--*----------------------------------------------------------------------
--* added four local functions for interface to Metamor array_arith
--* vlb2bit , bit2vlb, v1d2bv bv2v1d
--*----------------------------------------------------------------------
   function vlb2bit           (v: vlbit)   return bit is
   begin
      case v is
         when '1'    => return '1';
         when others => return '0';
      end case;
   end;

   function bit2vlb           (v: bit)   return vlbit is
   begin
      case v is
         when '1'    => return '1';
         when others => return '0';
      end case;
   end;

   function v1d2bv           (v: vlbit_1d) return bit_vector is
      variable result: bit_vector(v'range);
   begin
      for b in v'range loop
	 result(b) := vlb2bit(v(b));
      end loop;
      return result;
   end;

   function bv2v1d           (v: bit_vector) return vlbit_1d is
      variable result: vlbit_1d(v'range);
   begin
      for b in v'range loop
	 result(b) := bit2vlb(v(b));
      end loop;
      return result;
   end;


-----------------------------------------------------------------------
   type vlbit_relation_table is array (vlbit_base'left to vlbit_base'right,
                                       vlbit_base'left to vlbit_base'right) of boolean;

------------------------------------------------------------------------
   function "="               (v1, v2: vlbit)    return boolean is
      constant equal: vlbit_relation_table :=
                       --   'X'   'Z'   '0'   '1'
                         ((FALSE,FALSE,FALSE,FALSE), -- 'X'
                          (FALSE,FALSE,FALSE,FALSE), -- 'Z'
                          (FALSE,FALSE,TRUE, FALSE), -- '0'
                          (FALSE,FALSE,FALSE,TRUE ));-- '1'
   begin
      return equal (v1, v2);
   end;

------------------------------------------------------------------------
   function "/="              (v1, v2: vlbit)    return boolean is
      constant unequal: vlbit_relation_table :=
                       --   'X'   'Z'   '0'   '1'
                         ((FALSE,FALSE,FALSE,FALSE), -- 'X'
                          (FALSE,FALSE,FALSE,FALSE), -- 'Z'
                          (FALSE,FALSE,FALSE,TRUE ), -- '0'
                          (FALSE,FALSE,TRUE, FALSE));-- '1'
   begin
      return unequal (v1, v2);
   end;

------------------------------------------------------------------------
   function "<"               (v1, v2: vlbit)    return boolean is
      constant lessthan: vlbit_relation_table :=
                       --   'X'   'Z'   '0'   '1'
                         ((FALSE,FALSE,FALSE,FALSE), -- 'X'
                          (FALSE,FALSE,FALSE,FALSE), -- 'Z'
                          (FALSE,FALSE,FALSE,TRUE ), -- '0'
                          (FALSE,FALSE,FALSE,FALSE));-- '1'
   begin
      return lessthan (v1, v2);
   end;

------------------------------------------------------------------------
   function "<="              (v1, v2: vlbit)    return boolean is
      constant lessoreq: vlbit_relation_table :=
                       --   'X'   'Z'   '0'   '1'
                         ((FALSE,FALSE,FALSE,TRUE ), -- 'X'
                          (FALSE,FALSE,FALSE,TRUE ), -- 'Z'
                          (TRUE,TRUE,TRUE,TRUE ),    -- '0'
                          (FALSE,FALSE,FALSE,TRUE ));-- '1'
   begin
      return lessoreq (v1, v2);
   end;

------------------------------------------------------------------------
   function ">"               (v1, v2: vlbit)    return boolean is
      constant greaterthan: vlbit_relation_table :=
                       --   'X'   'Z'   '0'   '1'
                         ((FALSE,FALSE,FALSE,FALSE), -- 'X'
                          (FALSE,FALSE,FALSE,FALSE), -- 'Z'
                          (FALSE,FALSE,FALSE,FALSE), -- '0'
                          (FALSE,FALSE,TRUE, FALSE));-- '1'
   begin
      return greaterthan (v1, v2);
   end;

------------------------------------------------------------------------
   function ">="              (v1, v2: vlbit)    return boolean is
      constant greateroreq: vlbit_relation_table :=
                       --   'X'   'Z'   '0'   '1'
                         ((FALSE,FALSE,TRUE, FALSE), -- 'X'
                          (FALSE,FALSE,TRUE, FALSE), -- 'Z'
                          (FALSE,FALSE,TRUE, FALSE), -- '0'
                          (FALSE,FALSE,TRUE, TRUE ));-- '1'
   begin
      return greateroreq (v1, v2);
   end;

   type vlbit_table is array (vlbit_base'left to vlbit_base'right,
                              vlbit_base'left to vlbit_base'right) of vlbit;

------------------------------------------------------------------------
   function "AND"             (v1, v2: vlbit)    return vlbit is
      constant and_t: vlbit_table := -- 'X' 'Z' '0' '1'
                                      (('X','X','0','X'), -- 'X'
                                       ('X','X','0','X'), -- 'Z'
                                       ('0','0','0','0'), -- '0'
                                       ('X','X','0','1'));-- '1'
   begin
      return and_t (v1, v2);
   end;

------------------------------------------------------------------------
   function "OR"              (v1, v2: vlbit)    return vlbit is
      constant or_t: vlbit_table :=  -- 'X' 'Z' '0' '1'
                                      (('X','X','X','1'), -- 'X'
                                       ('X','X','X','1'), -- 'Z'
                                       ('X','X','0','1'), -- '0'
                                       ('1','1','1','1'));-- '1'
   begin
      return or_t (v1, v2);
   end;

------------------------------------------------------------------------
   function "NAND"            (v1, v2: vlbit)    return vlbit is
      constant nand_t: vlbit_table :=-- 'X' 'Z' '0' '1'
                                      (('X','X','1','X'), -- 'X'
                                       ('X','X','1','X'), -- 'Z'
                                       ('1','1','1','1'), -- '0'
                                       ('X','X','1','0'));-- '1'
   begin
      return nand_t (v1, v2);
   end;

------------------------------------------------------------------------
   function "NOR"             (v1, v2: vlbit)    return vlbit is
      constant nor_t: vlbit_table := -- 'X' 'Z' '0' '1'
                                      (('X','X','X','0'), -- 'X'
                                       ('X','X','X','0'), -- 'Z'
                                       ('X','X','1','0'), -- '0'
                                       ('0','0','0','0'));-- '1'
   begin
      return nor_t (v1, v2);
   end;

------------------------------------------------------------------------
   function "XOR"             (v1, v2: vlbit)    return vlbit is
      constant xor_t: vlbit_table := -- 'X' 'Z' '0' '1'
                                      (('X','X','X','X'), -- 'X'
                                       ('X','X','X','X'), -- 'Z'
                                       ('X','X','0','1'), -- '0'
                                       ('X','X','1','0'));-- '1'
   begin
      return xor_t (v1, v2);
   end;

------------------------------------------------------------------------
   function "NOT"             (v:      vlbit)    return vlbit is
   begin
      case v is
         when 'X' | 'Z' => return 'X';
         when '0'       => return '1';
         when '1'       => return '0';
      end case;
   end;

------------------------------------------------------------------------
   function "AND"             (v1, v2: vlbit_1d) return vlbit_1d is
      alias lv: vlbit_1d (1 to v1'length) is v1 ;
      alias rv: vlbit_1d (1 to v2'length) is v2 ;
      variable j: integer := 1 ;
      variable result: vlbit_1d (v1'range);
   begin
      assert v1'length = v2'length
             report "vlbit array AND: operands of unequal lengths"
             severity FAILURE;
      for i in v1'range loop
         result (i) := lv (j) and rv (j) ;
         j := j + 1 ;
      end loop;
      return result;
   end;

------------------------------------------------------------------------
   function "OR"              (v1, v2: vlbit_1d) return vlbit_1d is
      alias lv: vlbit_1d (1 to v1'length) is v1 ;
      alias rv: vlbit_1d (1 to v2'length) is v2 ;
      variable j: integer := 1 ;
      variable result: vlbit_1d (v1'range);
   begin
      assert v1'length = v2'length
             report "vlbit array OR: operands of unequal lengths"
             severity FAILURE;
      for i in v1'range loop
         result (i) := lv (j) or rv (j) ;
         j := j + 1 ;
      end loop;
      return result;
   end;

------------------------------------------------------------------------
   function "NAND"            (v1, v2: vlbit_1d) return vlbit_1d is
      alias lv: vlbit_1d (1 to v1'length) is v1 ;
      alias rv: vlbit_1d (1 to v2'length) is v2 ;
      variable j: integer := 1 ;
      variable result: vlbit_1d (v1'range);
   begin
      assert v1'length = v2'length
             report "vlbit array NAND: operands of unequal lengths"
             severity FAILURE;
      for i in v1'range loop
         result (i) := lv (j) nand rv (j) ;
         j := j + 1 ;
      end loop;
      return result;
   end;

------------------------------------------------------------------------
   function "NOR"             (v1, v2: vlbit_1d) return vlbit_1d is
      alias lv: vlbit_1d (1 to v1'length) is v1 ;
      alias rv: vlbit_1d (1 to v2'length) is v2 ;
      variable j: integer := 1 ;
      variable result: vlbit_1d (v1'range);
   begin
      assert v1'length = v2'length
             report "vlbit array NOR: operands of unequal lengths"
             severity FAILURE;
      for i in v1'range loop
         result (i) := lv (j) nor rv (j);
         j := j + 1 ;
      end loop;
      return result;
   end;

------------------------------------------------------------------------
   function "XOR"             (v1, v2: vlbit_1d) return vlbit_1d is
      alias lv: vlbit_1d (1 to v1'length) is v1 ;
      alias rv: vlbit_1d (1 to v2'length) is v2 ;
      variable j: integer := 1 ;
      variable result: vlbit_1d (v1'range);
   begin
      assert v1'length = v2'length
             report "vlbit array XOR: operands of unequal lengths"
             severity FAILURE;
      for i in v1'range loop
         result (i) := lv (j) xor rv (j);
         j := j + 1 ;
      end loop;
      return result;
   end;

------------------------------------------------------------------------
   function "NOT"             (v:      vlbit_1d) return vlbit_1d is
      variable result: vlbit_1d (v'range);
   begin
      for b in v'range loop
         result (b) := not v (b);
      end loop;
      return result;
   end;

------------------------------------------------------------------------
   function max               (i1, i2: integer)              return integer is
   begin
      if i1 < i2 then
         return i2;
      else
         return i1;
      end if;
   end;

------------------------------------------------------------------------
  function addum              (v1, v2 : vlbit_1d)           return vlbit_1d is
--*      variable i: integer := v1'length ;
--*      variable j: integer := v2'length ;
--*      alias lv: vlbit_1d (1 to i) is v1 ;
--*      alias rv: vlbit_1d (1 to j) is v2 ;
--*      variable bit1: vlbit := lv (i) ;
--*      variable bit2: vlbit := rv (j) ;
--*      variable carry:  vlbit := '0';
--*      variable result: vlbit_1d (0 to max (v1'length, v2'length)); 
      variable i : natural := max (v1'length, v2'length);
      variable l,r : bit_vector(i -1 downto 0);
   begin
      l := v1d2bv(extendum(v1,i));
      r := v1d2bv(extendum(v2,i));
      --* use Metamor internal operation
      return  bv2v1d( l + r ) ;

--*      for k in result'reverse_range loop
--*         result (k) := bit1 xor bit2 xor carry;
--*         carry      := (bit1 and bit2) or (carry and (bit1 or bit2));
--*         if i = 1 then
--*            bit1 := '0';
--*         else
--*            i := i - 1 ;
--*            bit1 := lv (i);
--*         end if;
--*         if j = 1 then
--*            bit2 := '0';
--*         else
--*            j := j - 1 ;
--*            bit2 := rv (j);
--*         end if;
--*      end loop;
--*      return result;
   end;

------------------------------------------------------------------------ 
   function add2c             (v1, v2: vlbit_1d)             return vlbit_1d is
--*      variable i: integer := v1'length ;
--*      variable j: integer := v2'length ;
--*      alias lv: vlbit_1d (1 to i) is v1 ; 
--*      alias rv: vlbit_1d (1 to j) is v2 ; 
--*      variable bit1: vlbit := lv (i) ;
--*      variable bit2: vlbit := rv (j) ; 
--*      variable carry:  vlbit := '0'; 
--*      variable result: vlbit_1d (0 to max (v1'length, v2'length)); 
      variable i : natural := max (v1'length, v2'length);
      variable l,r : bit_vector(i -1 downto 0);
   begin
      l := v1d2bv(extend2c(v1,i));
      r := v1d2bv(extend2c(v2,i));
      --* use Metamor internal operation
      return  bv2v1d( l + r ) ;

--*      for k in (result'length - 1) downto 1 loop
--*         result (k) := bit1 xor bit2 xor carry; 
--*         carry      := (bit1 and bit2) or (carry and (bit1 or bit2)); 
--*         if i /= 1 then 
--*            i := i - 1 ; 
--*            bit1 := lv (i); 
--*         end if; 
--*         if j /= 1 then 
--*            j := j - 1 ;
--*            bit2 := rv (j); 
--*         end if; 
--*      end loop; 
--*      if bitX(bit1) or bitX(bit2) or bitZ(bit1) or bitZ(bit2) then
--*         result(0) := 'X';
--*      else
--*         result(0) := bit1 xor bit2 xor carry;
--*      end if;
--*      return result;
   end;

------------------------------------------------------------------------
   function comp2c            (v:      vlbit_1d)             return vlbit_1d is
      variable i: integer := v'length ;
      alias av: vlbit_1d (1 to i) is v ;
      variable carry:  vlbit := '1';
      variable result: vlbit_1d (0 to v'length - 1);
   begin
      for j in result'reverse_range loop
         result (j) := carry xor not av (i);
         carry      := carry and not av (i);
         i := i - 1 ;
      end loop;
      return result;
   end;

------------------------------------------------------------------------
   function bitgoreq          (v1, v2: vlbit_1d)             return vlbit is
      variable resnot1,
               resnot0: boolean := false;
   begin
      assert v1'length = v2'length 
         report "internal error: (bitgoreq) length of args " severity FAILURE;
      for i in v1'range loop
         if v1 (i) < v2 (i) then
            if resnot0 then return 'X';
            else            return '0';
            end if;
         elsif v1 (i) > v2 (i) then
            if resnot1 then return 'X';
            else            return '1';
            end if;
--*         elsif (v1 (i) = '0' and bitunknown (v2 (i))) or
--*                (bitunknown (v1 (i)) and v2 (i) = '1') then
--*            resnot1 := TRUE;
--*         elsif (v1 (i) = '1' and bitunknown (v2 (i))) or
--*                (bitunknown (v1 (i)) and v2 (i) = '0') then
--*            resnot0 := TRUE;
         end if;
      end loop;
      if resnot1 then
         return 'X';
      else
         return '1';
      end if;
   end;

------------------------------------------------------------------------
   function divum             (v1, v2: vlbit_1d)             return vlbit_1d is
--*   variable maxlen: integer;
--*   variable rmd,
--*            dif,
--*            result: vlbit_1d (0 to max (v1'length, v2'length) - 1);
      variable i : natural := max (v1'length, v2'length);
      variable l,r : bit_vector(i -1 downto 0);
   begin
      l := v1d2bv(extendum(v1,i));
      r := v1d2bv(extendum(v2,i));
      --* use Metamor internal operation
      return  bv2v1d( l / r ) ;

--*   rmd := extendum (v1, result'length);
--*   for i in result'range loop
--*      maxlen := max (i + 1, v2'length);
--*      result (i) := bitgoreq (extendum (rmd (0 to i), maxlen),
--*                              extendum (v2,           maxlen));
--*      case result (i) is
--*         when '0'    => null;
--*         when '1'    => rmd (0 to i) :=
--*                           subum (rmd (0 to i), v2) (maxlen - i to maxlen);
--*         when others => dif (0 to i) :=
--*                           subum (rmd (0 to i), v2) (maxlen - i to maxlen);
--*                        for j in 0 to i loop
--*                           if not (rmd (i) = dif (i)) then
--*                              rmd (i) := 'X';
--*                           end if;
--*                        end loop;
--*         end case;
--*      end loop;
--*      return result;
   end;

------------------------------------------------------------------------
   function div2c             (v1, v2: vlbit_1d)             return vlbit_1d is
--*      variable maxlen: integer;
--*      variable rmd,
--*               dif,
--*               result: vlbit_1d (0 to max (v1'length, v2'length) - 1);
      variable vec1:   vlbit_1d (v1'range);
      variable vec2:   vlbit_1d (v2'range);
      variable negresult: boolean := false;

     variable i : natural := max (v1'length, v2'length);
     variable result: vlbit_1d (0 to i - 1);
     variable l,r : bit_vector(i -1 downto 0);
   begin
      if v1 (v1'left) = '1' then
         vec1 := comp2c (v1); negresult := true;
      else
         vec1 := v1;
      end if;
      if v2 (v2'left) = '1' then
         vec2 := comp2c (v2); negresult := not negresult;
      else
         vec2 := v2;
      end if;

      l := v1d2bv(extendum(vec1,i));
      r := v1d2bv(extendum(vec2,i));
      --* use Metamor internal operation
      result :=  bv2v1d( l / r ) ;

--*      rmd := extendum (vec1, result'length);
--*      for i in result'range loop
--*         maxlen := max (i + 1, vec2'length);
--*         result (i) := bitgoreq (extendum (rmd (0 to i), maxlen),
--*                                 extendum (vec2,         maxlen));
--*         case result (i) is
--*            when '0'    => null;
--*            when '1'    => rmd (0 to i) :=
--*                           subum (rmd (0 to i), vec2) (maxlen - i to maxlen);
--*            when others => dif (0 to i) :=
--*                           subum (rmd (0 to i), vec2) (maxlen - i to maxlen);
--*                           for j in 0 to i loop
--*                              if not (rmd (i) = dif (i)) then
--*                                 rmd (i) := 'X';
--*                              end if;
--*                           end loop;
--*         end case;
--*      end loop;
      if negresult then
         return comp2c (result);
      else
         return result;
      end if;
   end;

------------------------------------------------------------------------
   function extendum          (v: vlbit_1d; i: integer)      return vlbit_1d is
      variable result: vlbit_1d (0 to i - 1);
   begin
      assert i >= v'length report "extendum: invalid extension length"
                           severity FAILURE;
      for j in 0 to i - v'length - 1 loop
         result (j) := '0';
      end loop;
      result (i - v'length to i - 1) := v;
      return result;
   end;

------------------------------------------------------------------------
   function extend2c          (v: vlbit_1d; i: integer)      return vlbit_1d is
      variable result: vlbit_1d (0 to i - 1);
   begin
      assert i >= v'length report "extend2c: invalid extension length"
                           severity FAILURE;
      for j in 0 to i - v'length - 1 loop
         result (j) := v (v'left);
      end loop;
      result (i - v'length to i - 1) := v;
      return result;
   end;

------------------------------------------------------------------------
   function mulum             (v1, v2: vlbit_1d)             return vlbit_1d is
--*      variable t: integer := v1'length ;
--*      variable j: integer := v2'length ;
--*      alias lv: vlbit_1d (0 to t-1) is v1 ;
--*      alias rv: vlbit_1d (0 to j-1) is v2;
--*      variable pl:      integer;
--*      variable product,
--*               result:  vlbit_1d (0 to v1'length + v2'length - 1); 
      variable i : natural := max (v1'length, v2'length);
      variable l,r : bit_vector( i -1 downto 0);
   begin
      l := v1d2bv(extendum(v1,i));
      r := v1d2bv(extendum(v2,i));
      --* use Metamor internal operation
      return  bv2v1d( l * r ) ;

--*      for i in result'range loop
--*         result (i) := '0';
--*      end loop;
--*      pl := result'length ;
--*      for i in lv'range loop
--*         for j in rv'range loop
--*            product(j) := lv(i) and rv(j);
--*         end loop;
--*         product := shiftlum(shiftrum(product,lv'length),pl-rv'length -1);
--*         result := addum (result, product ) (1 to result'length );
--*         pl := pl - 1;
--*      end loop;
--*      return result;
   end;

------------------------------------------------------------------------
   function mul2c             (v1, v2: vlbit_1d)             return vlbit_1d is
      variable t: integer := v1'length ;
      variable j: integer := v2'length ;
      variable lv: vlbit_1d (0 to t-1);
      variable rv: vlbit_1d (0 to j-1); 
      variable pl:      integer; 
      variable product, 
               result:  vlbit_1d (0 to v1'length + v2'length - 1);
      variable sign : boolean := false;

      variable i : natural := max (v1'length, v2'length);
      variable l,r : bit_vector(i -1 downto 0);
   begin
--*      if (not ( vecX(v1) or vecZ(v1) or vecZ(v2) or vecX(v2))) then
      if v1(v1'left) = '1' then
	lv := comp2c(v1);
	sign := not sign;
      else 
	lv := v1;
      end if;
      if v2(v2'left) = '1' then
        rv := comp2c(v2);
        sign := not sign;
      else
        rv := v2;
      end if;

      l := v1d2bv(extendum(lv,i));
      r := v1d2bv(extendum(rv,i));
      --* use Metamor internal operation
      result :=  bv2v1d( l * r ) ;

--*         for i in result'range loop
--*            result (i) := '0';
--*         end loop;
--*         pl := result'length ;
--*         for i in lv'reverse_range loop
--*            for j in rv'reverse_range loop
--*               product(j) := lv(i) and rv(j);
--*            end loop;
--*            product := shiftlum(shiftrum(product,lv'length),product'length-pl);
--*            result := addum (result, product ) (1 to result'length );
--*            pl := pl - 1;
--*         end loop;
--*      else
--*         result := mulum (v1, v2);
--*         result(result'left) := v1(v1'left) xor v2(v2'left);
--*         return result;
--*      end if;
      if sign then
         return comp2c(result);
      else
         return result;
      end if;
   end;

------------------------------------------------------------------------
   function shiftlum          (v:      vlbit_1d; i: integer) return vlbit_1d is
--*      variable result: vlbit_1d (0 to v'length + i - 1);
   begin
--*      result (0 to v'length - 1) := v;
--*      for j in v'length to v'length + i - 1 loop
--*          result (j) := '0';
--*      end loop;
--*      return result (i to v'length + i - 1);

         --* use the vhdl'93 operation
         return bv2v1d( v1d2bv(v) sll i);
   end;

------------------------------------------------------------------------
   function shiftl2c          (v:      vlbit_1d; i: integer) return vlbit_1d is
--*      variable result: vlbit_1d (0 to v'length + i - 1);
   begin
--*      result (0 to v'length - 1) := v;
--*      for j in v'length to v'length + i - 1 loop
--*         result (j) := '0';
--*      end loop;
--*      return result (i to v'length + i - 1);

         --* use the vhdl'93 operation
         return bv2v1d( v1d2bv(v) sll i);
   end;

------------------------------------------------------------------------
   function shiftrum          (v:      vlbit_1d; i: integer) return vlbit_1d is
--*      variable result: vlbit_1d (0 to v'length + i - 1);
   begin
--*      for j in 0 to i - 1 loop
--*         result (j) := '0';
--*      end loop;
--*      result (i to v'length + i - 1) := v;
--*      return result (0 to v'length - 1);

         --* use the vhdl'93 operation 
         return bv2v1d( v1d2bv(v) srl i);
   end;

------------------------------------------------------------------------
   function shiftr2c          (v:      vlbit_1d; i: integer) return vlbit_1d is
--*      variable result: vlbit_1d (0 to v'length + i - 1);
   begin
--*      for j in 0 to i - 1 loop
--*         result (j) := v (v'left);
--*      end loop;
--*      result (i to v'length + i - 1) := v;
--*      return result (0 to v'length - 1);

         --* use the vhdl'93 operation
         return bv2v1d( v1d2bv(v) sra i);
   end;

------------------------------------------------------------------------
   function subum             (v1, v2: vlbit_1d)             return vlbit_1d is
--*      variable i: integer := v1'length ;
--*      variable j: integer := v2'length ;
--*      alias lv: vlbit_1d (1 to i) is v1 ;
--*      alias rv: vlbit_1d (1 to j) is v2 ;
--*      variable bit1: vlbit := lv (i) ;
--*      variable bit2: vlbit := rv (j) ;
--*      variable carry:  vlbit := '0';
--*      variable result: vlbit_1d (0 to max (v1'length, v2'length));
      variable i : natural := max (v1'length, v2'length);
      variable l,r : bit_vector(i -1 downto 0);
   begin
      l := v1d2bv(extendum(v1,i));
      r := v1d2bv(extendum(v2,i));
      --* use Metamor internal operation
      return  bv2v1d( l - r ) ;

--*      for k in result'reverse_range loop
--*         result (k) := bit1 xor bit2 xor carry;
--*         carry      := ((not bit1) and (bit2 or  carry)) or
--*                            (bit1  and (bit2 and carry));
--*         if i = 1 then
--*            bit1 := '0';
--*         else
--*            i := i - 1 ;
--*            bit1 := lv (i) ;
--*         end if;
--*         if j = 1 then
--*            bit2 := '0' ;
--*         else
--*            j := j - 1 ;
--*            bit2 := rv (j) ;
--*         end if;
--*      end loop;
--*      return result;
   end;

-----------------------------------------------------------------------
   function sub2c             (v1, v2: vlbit_1d)             return vlbit_1d is
--*      variable i: integer := v1'length ;
--*      variable j: integer := v2'length ;
--*      alias lv: vlbit_1d (1 to i) is v1 ;
--*      alias rv: vlbit_1d (1 to j) is v2 ;
--*      variable bit1: vlbit := lv (i) ;
--*      variable bit2: vlbit := rv (j) ;
--*      variable carry:  vlbit := '0';
--*      variable result: vlbit_1d (0 to max (v1'length, v2'length));
      variable i : natural := max (v1'length, v2'length);
      variable l,r : bit_vector(i -1 downto 0);
   begin
      l := v1d2bv(extend2c(v1,i));
      r := v1d2bv(extend2c(v2,i));
      --* use Metamor internal operation
      return  bv2v1d( l - r ) ;

--*      for k in result'reverse_range loop
--*         result (k) := bit1 xor bit2 xor carry;
--*         carry      := ((not bit1) and (bit2 or  carry)) or
--*                            (bit1  and (bit2 and carry));
--*         if i /= 1 then
--*            i := i - 1 ;
--*            bit1 := lv (i);
--*         end if;
--*           if j /= 1 then
--*            j := j - 1 ;
--*            bit2 := rv (j);
--*         end if;
--*      end loop;
--*      return result;
   end;

------------------------------------------------------------------------
--*  function bchanging         (signal s: vlbit_1d) return boolean is
--*  begin
--*     return s'event;
--*  end;

------------------------------------------------------------------------
--* function bschanging        ( signal s: vlbit_1d;
--*                              i,j: integer ) return boolean is
--*  begin
--*    putline("The behavior of function bschanging() is not portable.");
--*    return true;
--*  end;

------------------------------------------------------------------------
--*  function bitunknown        (v:        vlbit)    return boolean is
--*  begin
--*     case v is
--*        when 'X' | 'Z' => return true;
--*        when others    => return false;
--*     end case;
--*  end;

------------------------------------------------------------------------
--*  function bitX              (v:        vlbit)    return boolean is
--*  begin
--*     case v is
--*        when 'X'    => return true;
--*        when others => return false;
--*     end case;
--*  end;

------------------------------------------------------------------------
--*  function bitZ              (v:        vlbit)    return boolean is
--*  begin
--*     case v is
--*        when 'Z'    => return true;
--*        when others => return false;
--*     end case;
--*  end;

------------------------------------------------------------------------
--*  function pchanging         (signal s: vlbit)    return boolean is
--*  begin
--*     return s'event;
--*  end;

------------------------------------------------------------------------
    function pfalling          (signal s: vlbit)    return boolean is
    begin
       return s'event and s = '0';
    end;

------------------------------------------------------------------------
    function prising           (signal s: vlbit)    return boolean is
    begin
       return s'event and s = '1';
    end;

------------------------------------------------------------------------
--*  function vecunknown        (v:        vlbit_1d) return boolean is
--*  begin
--*     for b in v'range loop
--*        if bitunknown (v (b)) then
--*           return true;
--*        end if;
--*     end loop;
--*     return false;
--*  end;

------------------------------------------------------------------------
--*  function vecX              (v:        vlbit_1d) return boolean is
--*  begin
--*     for b in v'range loop
--*        if bitX (v (b)) then
--*           return true;
--*        end if;
--*     end loop;
--*     return false;
--*  end;

------------------------------------------------------------------------
--*  function vecZ              (v:        vlbit_1d) return boolean is
--*  begin
--*     for b in v'range loop
--*        if bitZ (v (b)) then
--*           return true;
--*        end if;
--*     end loop;
--*     return false;
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string) is
--*     variable l:  line;
--*  begin
--*     write (l, s);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string) is
--*  begin
--*     put (s);
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string; c: in character) is
--*     variable l:  line;
--*     variable co: character:=''';
--*  begin
--*     write (l, s);
--*     write (l,co);
--*     write (l, c);
--*     write (l,co);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; c: in character) is
--*  begin
--*     put (s, c);
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string; c1: in character_1d) is
--*     variable l:  line;
--*  begin
--*     write (l, s);
--*     for r in c1'range(1) loop
--*             write (l, c1(r)) ;
--*     end loop;
--*     writeline (output, l);
--*  end;
------------------------------------------------------------------------
--*  procedure putline          (s: in string; c1: in character_1d) is
--*  begin
--*     put (s, c1);
--*  end;

-------------------------------------------------------------------------
--*  procedure put              (s: in string; c2: in character_2d) is
--*     variable l:  line;
--*  begin
--*     write (l, s);
--*     for r in c2'range(1) loop
--*        for c in c2'range(2) loop
--*             write (l, c2(r,c)) ;
--*        end loop;
--*     end loop;
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; c2: in character_2d) is
--*  begin
--*     put (s, c2);
--*  end;

-------------------------------------------------------------------------
--*  procedure put              (s: in string; st: in string) is
--*     variable l:  line;
--*  begin
--*     write (l, s);
--*     write (l, st);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; st: in string) is
--*  begin
--*     put (s, st);
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string; v: in vlbit) is
--*     variable l:  line;
--*     variable co: character := ''';
--*  begin
--*     write (l, s);
--*     write (l,co);
--*     case v is
--*        when 'X' => write (l, 'X');
--*        when 'Z' => write (l, 'Z');
--*        when '0' => write (l, character'('0')) ;
--*        when '1' => write (l, character'('1')) ;
--*     end case;
--*     write (l,co);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; v: in vlbit) is
--*  begin
--*     put (s, v);
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string; v: in vlbit_1d) is
--*     variable l:  line;
--*     variable co : character := ''';
--*     variable prel : character :='(';
--*     variable prer : character :=')';
--*     variable com : character:=',';

--*  begin
--*     write (l, s);
--*     write (l,prel);
--*     for b in v'range loop
--*        write (l,co);
--*        case v (b) is
--*           when 'X' => write (l, 'X');
--*           when 'Z' => write (l, 'Z');
--*           when '0' => write (l, character'('0')) ;
--*           when '1' => write (l, character'('1')) ;
--*        end case;
--*       write (l,co);
--*       if b /= v'right(1) then
--*        write (l,com);
--*       end if;
--*     end loop;
--*     write (l,prer);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; v: in vlbit_1d) is
--*  begin
--*     put (s, v);
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string; v: in vlbit_2d) is
--*     variable l:  line;
--*     variable co : character := ''';
--*     variable prel : character :='(';
--*     variable prer : character :=')';
--*     variable com : character:=',';
--*  begin
--*     write (l, s);
--*     write (l,prel);
--*     for r in v'range(1) loop
--*        write (l,prel);
--*        for c in v'range(2) loop
--*           write (l,co);
--*           case v (r, c) is
--*              when 'X' => write (l, 'X');
--*              when 'Z' => write (l, 'Z');
--*              when '0' => write (l, character'('0')) ;
--*              when '1' => write (l, character'('1')) ;
--*           end case;
--*           write (l,co);
--*           if c /= v'right(2) then
--*             write (l,com);
--*           end if;
--*        end loop;
--*        write (l,prer);
--*        if r /= v'right(1) then
--*          write (l,com);
--*        end if;
--*     end loop;
--*     write (l,prer);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; v: in vlbit_2d) is
--*  begin
--*     put (s, v);
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string; b: in boolean) is
--*     variable l:  line;
--*  begin
--*     write (l, s);
--*     write (l, b);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; b: in boolean) is
--*  begin
--*     put (s, b);
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string; b: in boolean_1d) is
--*     variable l:  line;
--*     variable prel : character :='(';
--*     variable prer : character :=')';
--*     variable com : character:=',';
--*  begin
--*     write (l, s);
--*     write (l,prel);
--*     for i in b'range(1) loop
--*        write (l, b (i));
--*        if i /= b'right(1) then
--*          write(l,com);
--*        end if;
--*     end loop;
--*     write(l,prer);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; b: in boolean_1d) is
--*  begin
--*     put (s, b);
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string; b: in boolean_2d) is
--*     variable l:  line;
--*     variable prel : character :='(';
--*     variable prer : character :=')';
--*     variable com : character:=',';
--*  begin
--*     write (l, s);
--*     write (l,prel);
--*     for r in b'range(1) loop
--*        write (l,prel);
--*        for c in b'range(2) loop
--*           write (l, b (r, c));
--*           if c /= b'right(2) then
--*             write (l,com);
--*           end if;
--*        end loop;
--*        write (l,prer);
--*        if r /= b'right(1) then
--*          write(l,com);
--*        end if;
--*     end loop;
--*     write(l,prer);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; b: in boolean_2d) is
--*  begin
--*     put (s, b);
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string; i: in integer) is
--*     variable l:  line;
--*  begin
--*     write (l, s);
--*     write (l, i);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; i: in integer) is
--*  begin
--*     put (s, i);
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string; i: in integer_1d) is
--*     variable l:  line;
--*     variable prel : character :='(';
--*     variable prer : character :=')';
--*     variable com : character:=',';
--*  begin
--*     write (l, s);
--*     write (l, prel);
--*     for ix in i'range loop
--*        write (l, i (ix));
--*        if ix /= i'right(1) then
--*          write (l,com);
--*        end if;
--*     end loop;
--*     write(l,prer);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; i: in integer_1d) is
--*  begin
--*     put (s, i);
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string; i: in integer_2d) is
--*     variable l:  line;
--*     variable prel : character :='(';
--*     variable prer : character :=')';
--*     variable com : character:=',';
--*  begin
--*    write (l, s);
--*    write (l,prel);
--*      for r in i'range(1) loop
--*        write (l,prel);
--*        for c in i'range(2) loop
--*           write (l, i (r, c));
--*           if c /= i'right(2) then
--*              write (l, com);
--*           end if;
--*        end loop;
--*        write (l,prer);
--*        if r /= i'right(1) then
--*          write(l,com);
--*        end if;
--*     end loop;
--*     write(l,prer);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; i: in integer_2d) is
--*  begin
--*     put (s, i);
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string; t: in time) is
--*     variable l:  line;
--*  begin
--*     write (l, s);
--*     write (l, t);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; t: in time) is
--*  begin
--*     put (s, t);
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string; t: in time_1d) is
--*     variable l:  line;
--*     variable prel : character :='(';
--*     variable prer : character :=')';
--*     variable com : character:=',';
--*  begin
--*     write (l, s);
--*     write (l,prel);
--*     for tx in t'range loop
--*        write (l, t(tx));
--*        if tx /= t'right(1) then
--*          write (l,com);
--*        end if;
--*     end loop;
--*     write(l,prer);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; t: in time_1d) is
--*  begin
--*     put (s, t);
--*  end;

------------------------------------------------------------------------
--*  procedure put              (s: in string; t: in time_2d) is
--*     variable l:  line;
--*     variable prel : character :='(';
--*     variable prer : character :=')';
--*     variable com : character:=',';
--*  begin
--*     write (l, s);
--*     write (l, prel);
--*     for r in t'range(1) loop
--*        write (l,prel);
--*        for c in t'range(2) loop
--*           write (l, t (r, c));
--*           if c /= t'right(2) then
--*             write (l,com);
--*           end if;
--*        end loop;
--*        write (l,prer);
--*        if r /= t'right(1) then
--*          write (l,com);
--*        end if;
--*     end loop;
--*     write(l,prer);
--*     writeline (output, l);
--*  end;

------------------------------------------------------------------------
--*  procedure putline          (s: in string; t: in time_2d) is
--*  begin
--*     put (s, t);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; c: in character; b: out boolean) is
--*     variable l:  line;
--*     variable co: character := ''';
--*  begin
--*     b := true ;
--*     write (l,co);
--*     write (l, c);
--*     write (l,co);
--*     writeline (ft, l);
--*  end;
------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; c: in character; b: out boolean) is
--*  begin
--*     fwrite (ft, c, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; c1: in character_1d; b: out boolean) is
--*     variable l:  line;
--*  begin
--*     b := true ;
--*     for r in c1'range(1) loop
--*          write(l,c1(r));
--*     end loop;
--*    writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; c1: in character_1d; b: out boolean) is
--*  begin
--*     fwrite (ft, c1, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; c2: in character_2d; b: out boolean) is
--*     variable l:  line;
--*  begin
--*     b := true ;
--*     for r in c2'range(1) loop
--*        for c in c2'range(2) loop
--*          write(l,c2(r,c));
--*        end loop;
--*     end loop;
--*    writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; c2: in character_2d; b: out boolean) is
--*  begin
--*     fwrite (ft, c2, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; st: in string; b: out boolean) is
--*     variable l:  line;
--*  begin
--*     b := true ;
--*     write (l, st);
--*     writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; st: in string; b: out boolean) is
--*  begin
--*     fwrite (ft, st, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; v: in vlbit; b: out boolean) is
--*     variable l:  line;
--*     variable co: character := ''';
--*  begin
--*     b := true ;
--*     write(l,co);
--*     case v is
--*        when 'X' => write (l, 'X');
--*        when 'Z' => write (l, 'Z');
--*        when '0' => write (l, character'('0')) ;
--*        when '1' => write (l, character'('1')) ;
--*     end case;
--*     write(l,co);
--*     writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; v: in vlbit; b: out boolean) is
--*  begin
--*     fwrite (ft, v, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; v: in vlbit_1d; b: out boolean) is
--*     variable l:  line;
--*     variable co: character := ''';
--*     variable prel : character := '(';
--*     variable prer : character := ')';
--*     variable com : character := ',';
--*  begin
--*     b := true ;
--*     write(l,prel);
--*     for i in v'range loop
--*        write(l,co);
--*        case v (i) is
--*           when 'X' => write (l, 'X');
--*           when 'Z' => write (l, 'Z');
--*           when '0' => write (l, character'('0')) ;
--*           when '1' => write (l, character'('1')) ;
--*        end case;
--*        write(l,co);
--*        if i /= v'right(1) then
--*          write (l,com);
--*        end if;
--*     end loop;
--*     write(l,prer);
--*     writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; v: in  vlbit_1d; b:  out boolean) is
--*  begin
--*     fwrite (ft, v, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; v: in vlbit_2d; b: out boolean) is
--*     variable l:  line;
--*     variable co: character := ''';
--*     variable prel : character := '(';
--*     variable prer : character := ')';
--*     variable com : character := ',';
--*  begin
--*     b := true ;
--*     write(l,prel);
--*     for r in v'range(1) loop
--*        write (l,prel);
--*        for c in v'range(2) loop
--*           write(l,co);
--*           case v (r, c) is
--*              when 'X' => write (l, 'X');
--*              when 'Z' => write (l, 'Z');
--*              when '0' => write (l, character'('0')) ;
--*              when '1' => write (l, character'('1')) ;
--*           end case;
--*           write(l,co);
--*           if c /= v'right(2) then
--*             write(l,com);
--*           end if;
--*        end loop;
--*        write(l,prer);
--*        if r /= v'right(1) then
--*          write(l,com);
--*        end if;
--*     end loop;
--*     write(l,prer);
--*     writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; v: in  vlbit_2d; b: out boolean) is
--*  begin
--*     fwrite (ft, v, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; b1: in boolean; b:  out boolean) is
--*     variable l:  line;
--*  begin
--*     b := true ;
--*     write (l, b1);
--*     writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; b1: in boolean; b: out boolean) is
--*  begin
--*     fwrite (ft, b1, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; b1: in boolean_1d; b: out boolean) is
--*     variable l:  line;
--*     variable prel : character := '(';
--*     variable prer : character := ')';
--*     variable com : character := ',';
--*  begin
--*     b := true ;
--*     write(l,prel);
--*     for i in b1'range loop
--*        write (l, b1 (i));
--*        if i /= b1'right(1) then
--*          write(l,com);
--*        end if;
--*     end loop;
--*     write(l,prer);
--*     writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; b1: in boolean_1d; b: out boolean) is
--*  begin
--*     fwrite (ft, b1, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; b1: in boolean_2d; b: out boolean) is
--*     variable l:  line;
--*     variable prel : character := '(';
--*     variable prer : character := ')';
--*     variable com : character := ',';
--*  begin
--*     b := true ;
--*     write(l,prel);
--*     for r in b1'range(1) loop
--*        write(l,prel);
--*        for c in b1'range(2) loop
--*           write (l, b1 (r, c));
--*           if c /= b1'right(2) then
--*             write(l,com);
--*           end if;
--*        end loop;
--*        write(l,prer);
--*        if r /= b1'right(1) then
--*          write(l,com);
--*        end if;
--*     end loop;
--*     write(l,prer);
--*     writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; b1: in boolean_2d; b: out boolean) is
--*  begin
--*     fwrite (ft, b1, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; i: in integer; b: out boolean) is
--*     variable l:  line;
--*  begin
--*     b := true ;
--*     write (l, i);
--*     writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; i: in integer; b: out boolean) is
--*  begin
--*     fwrite (ft, i, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; i: in integer_1d; b: out boolean) is
--*     variable l:  line;
--*     variable prel : character := '(';
--*     variable prer : character := ')';
--*     variable com : character := ',';
--*  begin
--*     b := true ;
--*     write(l,prel);
--*     for ix in i'range loop
--*        write (l, i (ix));
--*        if ix /= i'right(1) then
--*          write(l,com);
--*        end if;
--*     end loop;
--*     write(l,prer);
--*     writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; i: in integer_1d; b: out boolean) is
--*  begin
--*     fwrite (ft, i, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; i: in integer_2d; b: out boolean) is
--*     variable l:  line;
--*     variable prel : character := '(';
--*     variable prer : character := ')';
--*     variable com : character := ',';
--*  begin
--*     b := true ;
--*     write(l,prel);
--*     for r in i'range(1) loop
--*        write(l,prel);
--*        for c in i'range(2) loop
--*           write (l, i (r, c));
--*           if c /= i'right(2) then
--*             write(l,com);   
--*           end if;
--*        end loop;
--*        write(l,prer);
--*        if r /= i'right(1) then
--*          write(l,com);
--*        end if;
--*     end loop;
--*     write(l,prer);
--*     writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; i: in integer_2d; b: out boolean) is
--*  begin
--*     fwrite (ft, i, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; t: in time; b: out boolean) is
--*     variable l:  line;
--*  begin
--*     b := true ;
--*     write (l, t);
--*     writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; t: in time; b: out boolean) is
--*  begin
--*     fwrite (ft, t, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; t: in time_1d; b: out boolean) is
--*     variable l:  line;
--*     variable prel : character := '(';
--*     variable prer : character := ')';
--*     variable com : character := ',';
--*  begin
--*     b := true ;
--*     write(l,prel);
--*     for tx in t'range loop
--*        write (l, t (tx));
--*        if tx /= t'right(1) then
--*          write (l,com);
--*        end if;
--*     end loop;
--*     write(l,prer);
--*     writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; t: in time_1d; b:  out boolean) is
--*  begin
--*     fwrite (ft, t, b);
--*  end;

------------------------------------------------------------------------
--*  procedure fwrite              (variable ft: out text; t: in time_2d; b: out boolean) is
--*     variable l:  line;
--*     variable prel : character := '(';
--*     variable prer : character := ')';
--*     variable com : character := ',';
--*  begin
--*     b := true ;
--*     write(l,prel);
--*     for r in t'range(1) loop
--*        write(l,prel);
--*        for c in t'range(2) loop
--*           write (l, t (r, c));
--*           if c /= t'right(2) then
--*             write(l,com);
--*           end if;
--*        end loop;
--*        write(l,prer);
--*        if r /= t'right(1) then
--*          write(l,com);
--*        end if;
--*     end loop;
--*     write(l,prer);
--*     writeline (ft, l);
--*  end;

------------------------------------------------------------------------
--*  procedure fwriteline          (variable ft: out text; t:in time_2d; b: out boolean) is
--*  begin
--*     fwrite (ft, t, b);
--*  end;

------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text; c: out character; b: out boolean) is
--*     variable l:  line;
--*     variable temp: character;
--*  begin 
--*     readline (ft, l);
--*     read (l, temp, b);
--*     read (l, c, b);
--*  end;

------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text; c1: out character_1d; b: out boolean) is
--*      variable l: line;
--*  begin
--*      readline(ft,l);
--*      for i in c1'range(1) loop
--*          read( l, c1(i), b);
--*       end loop;
--*   end;

--------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text; c2: out character_2d; b: out boolean) is
--*      variable l: line;
--*  begin
--*      readline(ft,l);
--*      for i in c2'range(1) loop
--*        for j in c2'range(2) loop
--*          read( l, c2(i,j), b);
--*         end loop;
--*       end loop;
--*   end;

--------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text; st: out string; b: out boolean) is
--*     variable l:  line;
--*  begin
--*     readline (ft, l);
--*     read (l, st, b);
--*  end;

----------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text; v:  out vlbit; b: out boolean) is
--*     variable l:  line ;
--*     variable c:  character ;
--*     variable temp: character;
--*  begin
--*     readline (ft, l);
--*     read (l,temp,b);
--*     read (l, c, b);
--*     case c is
--*          when 'X' => v := 'X' ;
--*          when 'Z' => v := 'Z' ;
--*          when '0' => v := '0' ;
--*          when '1' => v := '1' ;
--*          when others => b := false ;
--*     end case ;
--*  end;

------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text; v:  out vlbit_1d; b: out boolean) is
--*     variable l:  line ;
--*     variable temp, c:  character ;
--*  begin
--*     readline (ft, l);
--*     read (l,temp,b);
--*     for i in v'range(1) loop
--*        read (l,temp,b);
--*        read (l, c, b);
--*        case c is
--*             when 'X' => v(i) := 'X' ;
--*             when 'Z' => v(i) := 'Z' ;
--*             when '0' => v(i) := '0' ;
--*             when '1' => v(i) := '1' ;
--*             when others => b := false ;
--*        end case ;
--*        read(l,temp,b);
--*        if i /= v'right(1) then
--*          read(l,temp,b);
--*        end if;
--*     end loop ;
--*     read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*procedure freadline            (variable ft: in text; v: out vlbit_2d; b: out boolean) is
--*      variable l: line ;
--*      variable c: character ;
--*      variable temp: character;
--*  begin
--*      readline(ft, l);
--*      read(l,temp,b);
--*      for i in v'range(1) loop
--*        read(l,temp,b);
--*        for j in v'range(2) loop
--*          read(l,temp,b);
--*          read( l, c, b);
--*          case c is
--*             when 'X' => v(i,j) := 'X' ;
--*             when 'Z' => v(i,j) := 'Z' ;
--*             when '0' => v(i,j) := '0' ;
--*             when '1' => v(i,j) := '1' ;
--*             when others => b := false ;
--*          end case ;
--*          read(l,temp,b);
--*          if j /= v'right(2) then
--*            read(l,temp,b);
--*          end if;
--*         end loop;
--*         read(l,temp,b);
--*         if i /= v'right(1) then
--*            read(l,temp,b);
--*         end if;
--*       end loop;
--*       read(l,temp,b);
--*   end;

--------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text; b1:  out boolean; b: out boolean) is
--*     variable l:  line;
--*  begin
--*     readline (ft, l);
--*     read (l, b1, b);
--*  end;

------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text; b1:out  boolean_1d; b: out boolean) is
--*     variable l:  line ;
--*     variable temp: character;
--*  begin
--*     readline (ft, l);
--*     read(l,temp,b);
--*     for i in b1'range loop
--*       read (l, b1(i), b) ;
--*       if i /= b1'right(1) then
--*         read(l,temp,b);
--*       end if;
--*     end loop ;
--*     read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text; b1: out  boolean_2d; b: out boolean) is
--*     variable l:  line ;
--*     variable temp: character;
--*  begin
--*     readline (ft, l);
--*     read(l,temp,b);
--*     for i in b1'range(1) loop
--*        read(l,temp,b);
--*        for j in b1'range(2) loop
--*           read (l, b1(i, j), b) ;
--*           if j /= b1'right(2) then
--*            read(l,temp,b);
--*           end if;
--*        end loop ;
--*        read(l,temp,b);
--*        if i /= b1'right(1) then
--*          read(l,temp,b);
--*        end if;
--*     end loop ;
--*    read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text; i: out integer; b: out boolean) is
--*     variable l:  line;
--*  begin
--*     readline (ft, l);
--*     read (l, i, b);
--*  end;

------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text; i1: out integer_1d; b: out boolean) is
--*     variable l:  line ;
--*     variable temp: character;
--*  begin
--*     readline (ft, l);
--*     read(l,temp,b);
--*     for i in i1'range loop
--*       read (l, i1(i), b) ;
--*       if i /= i1'right(1) then
--*         read(l,temp,b);
--*       end if;
--*     end loop ;
--*    read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text; i1: out integer_2d; b: out boolean) is
--*     variable l:  line ;
--*     variable temp: character;
--*  begin
--*     readline (ft, l);
--*     read(l,temp,b);
--*     for i in i1'range(1) loop
--*        read(l,temp,b);
--*        for j in i1'range(2) loop
--*         read (l, i1(i, j), b) ;
--*         if j /= i1'right(2) then
--*           read(l,temp,b);
--*         end if;
--*        end loop ;
--*        read(l,temp,b);
--*        if i /= i1'right(1) then
--*          read(l,temp,b);
--*        end if;
--*     end loop ;
--*     read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text; t: out time; b: out boolean) is
--*     variable l:  line;
--*  begin
--*     readline (ft, l);
--*     read (l, t, b);
--*  end;

------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text;  t: out time_1d; b: out boolean) is
--*     variable l:  line ;
--*     variable temp: character;
--*  begin
--*     readline (ft, l);
--*     read(l,temp,b);
--*     for i in t'range(1) loop
--*       read (l, t(i), b) ;
--*       if i /= t'right(1) then
--*         read(l,temp,b);
--*       end if;
--*     end loop ;
--*     read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*  procedure freadline          (variable ft: in text;  t: out  time_2d; b: out boolean) is
--*     variable l:  line ;
--*     variable temp: character;
--*  begin
--*     readline (ft, l);
--*     read(l,temp,b);
--*     for i in t'range(1) loop
--*        read(l,temp,b);
--*        for j in t'range(2) loop
--*           read (l, t(i, j), b) ;
--*           if j /= t'right(2) then
--*             read(l,temp,b);
--*           end if;
--*        end loop ;
--*        read(l,temp,b);
--*        if i /= t'right(1) then
--*          read(l,temp,b);
--*        end if;
--*     end loop ;
--*    read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; c: out character; b: out boolean) is
--*     variable l:  line;
--*     variable temp: character;
--*  begin
--*     write (l, s);
--*     write (l, CR);
--*     writeline (output, l);
--*     readline (input, l);
--*     read (l, temp, b);
--*     read (l, c, b);
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; c1: out character_1d; b: out boolean) is
--*     variable l:  line ;
--*     variable  c:  character ;
--*     
--*  begin
--*     write (l, s) ;
--*     write (l, CR) ;
--*     writeline (output, l) ;
--*     readline (input, l);
--*     for i in c1'range(1) loop
--*           read (l, c1(i), b);
--*     end loop ;
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; c2: out character_2d; b: out boolean) is
--*     variable l:  line ;
--*     variable  c:  character ;
--*  begin
--*     write (l, s) ;
--*     write (l, CR) ;
--*     writeline (output, l) ;
--*     readline (input, l);
--*     for i in c2'range(1) loop
--*        for j in c2'range(2) loop
--*           read (l, c2(i,j), b);
--*        end loop ;
--*     end loop ;
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; st: out string; b: out boolean) is
--*     variable l:  line;
--*  begin
--*     write (l, s);
--*     write (l, CR);
--*     writeline (output, l);
--*     readline (input, l);
--*     read (l, st, b);
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; v: out vlbit; b: out boolean) is
--*     variable l:  line ;
--*     variable temp, c:  character ;
--*  begin
--*     write (l, s) ;
--*     write (l, CR) ;
--*     writeline (output, l) ;
--*     readline (input, l);
--*     read (l,temp,b);
--*     read (l, c, b);
--*     case c is
--*          when 'X' => v := 'X' ;
--*          when 'Z' => v := 'Z' ;
--*          when '0' => v := '0' ;
--*          when '1' => v := '1' ;
--*          when others => b := false ;
--*     end case ;
--*     read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; v: out vlbit_1d; b: out boolean) is
--*     variable l:  line ;
--*     variable temp, c:  character ;
--*  begin
--*     write (l, s) ;
--*     write (l, CR) ;
--*     writeline (output, l) ;
--*     readline (input, l);
--*     read(l,temp,b);
--*     for i in v'range loop
--*        read (l,temp,b);
--*        read (l, c, b);
--*        case c is
--*             when 'X' => v(i) := 'X' ;
--*             when 'Z' => v(i) := 'Z' ;
--*             when '0' => v(i) := '0' ;
--*             when '1' => v(i) := '1' ;
--*             when others => b := false ;
--*        end case ;
--*        read(l,temp,b);
--*        if i /= v'right(1) then
--*          read(l,temp,b);
--*        end if;
--*     end loop ;
--*    read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; v: out vlbit_2d; b: out boolean) is
--*     variable l:  line ;
--*     variable temp, c:  character ;
--*  begin
--*     write (l, s) ;
--*     write (l, CR) ;
--*     writeline (output, l) ;
--*     readline (input, l);
--*     read(l, temp,b);
--*     for i in v'range(1) loop
--*        read(l,temp,b);
--*        for j in v'range(2) loop
--*           read (l, temp, b);
--*           read (l, c, b);
--*           case c is
--*                when 'X' => v(i, j) := 'X' ;
--*                when 'Z' => v(i, j) := 'Z' ;
--*                when '0' => v(i, j) := '0' ;
--*                when '1' => v(i, j) := '1' ;
--*                when others => b := false ;
--*           end case ;
--*           read(l, temp, b);
--*           if j /= v'right(2) then
--*             read(l,temp,b);
--*           end if;
--*        end loop ;
--*        read (l,temp,b);
--*        if i /= v'right(1) then
--*          read (l,temp,b);
--*        end if;
--*     end loop ;
--*    read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; b1: out boolean; b: out boolean) is
--*     variable l:  line;
--*  begin
--*     write (l, s);
--*     write (l, CR);
--*     writeline (output, l);
--*     readline (input, l);
--*     read (l, b1, b);
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; b1: out boolean_1d; b: out boolean) is
--*     variable l:  line;
--*     variable temp: character;
--*  begin
--*     write (l, s);
--*     write (l, CR);
--*     writeline (output, l);
--*     readline (input, l);
--*     read(l,temp,b);
--*     for i in b1'range loop
--*        read (l, b1(i), b);
--*        if i /= b1'right(1) then
--*          read(l,temp,b);
--*        end if;
--*     end loop ;
--*     read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; b1: out boolean_2d; b: out boolean) is
--*     variable l:  line;
--*     variable temp: character;
--*  begin
--*     write (l, s);
--*     write (l, CR);
--*     writeline (output, l);
--*     readline (input, l);
--*     read(l,temp,b);
--*     for i in b1'range(1) loop
--*        read(l,temp,b);
--*        for j in b1'range(2) loop
--*           read (l, b1(i, j), b);
--*           if j /= b1'right(2) then
--*             read(l,temp,b);
--*           end if;
--*        end loop ;
--*        read(l,temp,b);
--*        if i /= b1'right(1) then
--*          read(l,temp,b);
--*        end if;
--*     end loop ;
--*    read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; i: out integer; b: out boolean) is
--*     variable l:  line;
--*  begin
--*     write (l, s);
--*     write (l, CR);
--*     writeline (output, l);
--*     readline (input, l);
--*     read (l, i, b);
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; i1: out integer_1d; b: out boolean) is
--*     variable l:  line;
--*     variable temp: character;
--*  begin
--*     write (l, s);
--*     write (l, CR);
--*     writeline (output, l);
--*     readline (input, l);
--*     read(l,temp,b);
--*     for i in i1'range loop
--*        read (l, i1(i), b);
--*        if i /= i1'right(1) then
--*          read(l,temp,b);
--*        end if;
--*     end loop ;
--*     read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; i1: out integer_2d; b:  out boolean) is
--*     variable l:  line;
--*     variable temp: character;
--*  begin
--*     write (l, s);
--*     write (l, CR);
--*     writeline (output, l);
--*     readline (input, l);
--*     read(l,temp,b);
--*     for i in i1'range(1) loop
--*        read(l,temp,b);
--*        for j in i1'range(2) loop
--*           read (l, i1(i, j), b);
--*           if j /= i1'right(2) then
--*             read(l,temp,b);
--*           end if;
--*        end loop ;
--*        read(l,temp,b);
--*        if i /= i1'right(1) then
--*          read(l,temp,b);
--*        end if;
--*     end loop ;
--*     read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; t: out time; b: out boolean) is
--*     variable l:  line;
--*  begin
--*     write (l, s);
--*     write (l, CR);
--*     writeline (output, l);
--*     readline (input, l);
--*     read (l, t, b);
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; t: out time_1d; b: out boolean) is
--*     variable l:  line;
--*     variable temp: character;
--*  begin
--*     write (l, s);
--*     write (l, CR);
--*     writeline (output, l);
--*     readline (input, l);
--*     read(l,temp,b);
--*     for i in t'range(1) loop
--*        read (l, t(i), b);
--*        if i /= t'right(1) then
--*          read(l,temp,b);
--*        end if;
--*     end loop ;
--*    read(l,temp,b);
--*  end;

------------------------------------------------------------------------
--*  procedure getline          (s: in string; t: out time_2d; b: out boolean) is
--*     variable l:  line;
--*     variable temp: character;
--*  begin
--*     write (l, s);
--*     write (l, CR);
--*     writeline (output, l);
--*     readline (input, l);
--*     read(l,temp,b);
--*     for i in t'range(1) loop
--*        read(l,temp,b);
--*        for j in t'range(2) loop
--*           read (l, t(i, j), b);
--*           if j /= t'right(2) then
--*             read(l,temp,b);
--*           end if;
--*        end loop ;
--*        read(l,temp,b);
--*        if i /= t'right(1) then
--*          read(l,temp,b);
--*        end if;
--*     end loop ;
--*    read(l,temp,b);
--*  end;

end pack1076;



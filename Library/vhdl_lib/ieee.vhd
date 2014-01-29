-- mm 2.3.0
-- --------------------------------------------------------------------
--
--   Title     :  std_logic_1164 multi-value logic system
--   Library   :  This package shall be compiled into a library 
--             :  symbolically named IEEE.
--             :  
--   Developers:  IEEE model standards group (par 1164)
--   Purpose   :  This packages defines a standard for designers
--             :  to use in describing the interconnection data types
--             :  used in vhdl modeling.
--             : 
--   Limitation:  The logic system defined in this package may
--             :  be insufficient for modeling switched transistors,
--             :  since such a requirement is out of the scope of this
--             :  effort. Furthermore, mathematics, primitives,
--             :  timing standards, etc. are considered orthogonal
--             :  issues as it relates to this package and are therefore
--             :  beyond the scope of this effort.
--             :  
--   Note      :  No declarations or definitions shall be included in,
--             :  or excluded from this package. The "package declaration" 
--             :  defines the types, subtypes and declarations of 
--             :  std_logic_1164. The std_logic_1164 package body shall be 
--             :  considered the formal definition of the semantics of 
--             :  this package. Tool developers may choose to implement 
--             :  the package body in the most efficient manner available 
--             :  to them.
--             :
-- --------------------------------------------------------------------
--   modification history :
-- --------------------------------------------------------------------
--  version | mod. date:| 
--   v4.200 | 01/02/92  | 
--   v4.202 | 08/25/93  |  Modified for use with Metamor logic synthesis :
--                      |  1) Added attribute enum_encoding 
--                      |  2) Removed logical operations functions
--   v4.203 | 09/15/95  |  changed value of enum_encoding for 1076.3
-- --------------------------------------------------------------------
library metamor;

PACKAGE std_logic_1164 IS

    -------------------------------------------------------------------    
    -- logic state system  (unresolved)
    -------------------------------------------------------------------    
    TYPE std_ulogic IS ( 'U',  -- Uninitialized
                         'X',  -- Forcing  Unknown
                         '0',  -- Forcing  0
                         '1',  -- Forcing  1
                         'Z',  -- High Impedance   
                         'W',  -- Weak     Unknown
                         'L',  -- Weak     0       
                         'H',  -- Weak     1       
                         '-'   -- Don't care
                       );

    -------------------------------------------------------------------    
    -- Metamor specific attribute		       
    -------------------------------------------------------------------    
    use metamor.attributes.enum_encoding;
    attribute enum_encoding of std_ulogic : type is  "M M 0 1 Z M 0 1 -";
    
    -------------------------------------------------------------------    
    -- unconstrained array of std_ulogic for use with the resolution function
    -------------------------------------------------------------------    
    TYPE std_ulogic_vector IS ARRAY ( NATURAL RANGE <> ) OF std_ulogic;
                                    
    -------------------------------------------------------------------    
    -- resolution function
    -------------------------------------------------------------------    
    FUNCTION resolved ( s : std_ulogic_vector ) RETURN std_ulogic;


    -------------------------------------------------------------------    
    -- *** industry standard logic type ***
    -------------------------------------------------------------------    
    SUBTYPE std_logic IS resolved std_ulogic;

    -------------------------------------------------------------------    
    -- unconstrained array of std_logic for use in declaring signal arrays
    -------------------------------------------------------------------    
    TYPE std_logic_vector IS ARRAY ( NATURAL RANGE <>) OF std_logic;

    -------------------------------------------------------------------    
    -- common subtypes
    -------------------------------------------------------------------    
    SUBTYPE X01     IS resolved std_ulogic RANGE 'X' TO '1'; -- ('X','0','1') 
    SUBTYPE X01Z    IS resolved std_ulogic RANGE 'X' TO 'Z'; -- ('X','0','1','Z') 
    SUBTYPE UX01    IS resolved std_ulogic RANGE 'U' TO '1'; -- ('U','X','0','1') 
    SUBTYPE UX01Z   IS resolved std_ulogic RANGE 'U' TO 'Z'; -- ('U','X','0','1','Z') 

    -------------------------------------------------------------------    
    -- overloaded logical operators
    -- Built in to Metamor
    -------------------------------------------------------------------    
--    FUNCTION "and"  ( l : std_ulogic; r : std_ulogic ) RETURN UX01;
    -------------------------------------------------------------------    
    -- vectorized overloaded logical operators
    -- Built in to Metamor
    -------------------------------------------------------------------    

    -------------------------------------------------------------------
    -- conversion functions
    -------------------------------------------------------------------
    FUNCTION To_bit       ( s : std_ulogic;        xmap : BIT := '0') RETURN BIT;
    FUNCTION To_bitvector ( s : std_logic_vector ; xmap : BIT := '0') RETURN BIT_VECTOR;
    FUNCTION To_bitvector ( s : std_ulogic_vector; xmap : BIT := '0') RETURN BIT_VECTOR;

    FUNCTION To_StdULogic       ( b : BIT               ) RETURN std_ulogic;
    FUNCTION To_StdLogicVector  ( b : BIT_VECTOR        ) RETURN std_logic_vector;
    FUNCTION To_StdLogicVector  ( s : std_ulogic_vector ) RETURN std_logic_vector;
    FUNCTION To_StdULogicVector ( b : BIT_VECTOR        ) RETURN std_ulogic_vector;
    FUNCTION To_StdULogicVector ( s : std_logic_vector  ) RETURN std_ulogic_vector;
    
    -------------------------------------------------------------------    
    -- strength strippers and type convertors
    -------------------------------------------------------------------    

    FUNCTION To_X01  ( s : std_logic_vector  ) RETURN  std_logic_vector;
    FUNCTION To_X01  ( s : std_ulogic_vector ) RETURN  std_ulogic_vector;
    FUNCTION To_X01  ( s : std_ulogic        ) RETURN  X01;
    FUNCTION To_X01  ( b : BIT_VECTOR        ) RETURN  std_logic_vector;
    FUNCTION To_X01  ( b : BIT_VECTOR        ) RETURN  std_ulogic_vector;
    FUNCTION To_X01  ( b : BIT               ) RETURN  X01;       

    FUNCTION To_X01Z ( s : std_logic_vector  ) RETURN  std_logic_vector;
    FUNCTION To_X01Z ( s : std_ulogic_vector ) RETURN  std_ulogic_vector;
    FUNCTION To_X01Z ( s : std_ulogic        ) RETURN  X01Z;
    FUNCTION To_X01Z ( b : BIT_VECTOR        ) RETURN  std_logic_vector;
    FUNCTION To_X01Z ( b : BIT_VECTOR        ) RETURN  std_ulogic_vector;
    FUNCTION To_X01Z ( b : BIT               ) RETURN  X01Z;      

    FUNCTION To_UX01  ( s : std_logic_vector  ) RETURN  std_logic_vector;
    FUNCTION To_UX01  ( s : std_ulogic_vector ) RETURN  std_ulogic_vector;
    FUNCTION To_UX01  ( s : std_ulogic        ) RETURN  UX01;
    FUNCTION To_UX01  ( b : BIT_VECTOR        ) RETURN  std_logic_vector;
    FUNCTION To_UX01  ( b : BIT_VECTOR        ) RETURN  std_ulogic_vector;
    FUNCTION To_UX01  ( b : BIT               ) RETURN  UX01;       

    -------------------------------------------------------------------    
    -- edge detection
    -------------------------------------------------------------------    
    FUNCTION rising_edge  (SIGNAL s : std_ulogic) RETURN BOOLEAN;
    FUNCTION falling_edge (SIGNAL s : std_ulogic) RETURN BOOLEAN;

    -------------------------------------------------------------------    
    -- object contains an unknown
    -------------------------------------------------------------------    
    FUNCTION Is_X ( s : std_ulogic_vector ) RETURN  BOOLEAN;
    FUNCTION Is_X ( s : std_logic_vector  ) RETURN  BOOLEAN;
    FUNCTION Is_X ( s : std_ulogic        ) RETURN  BOOLEAN;

END std_logic_1164;


PACKAGE BODY std_logic_1164 IS
    -------------------------------------------------------------------    
    -- internals modified for use only with Metamor
    -- external interface unchanged
    -------------------------------------------------------------------    
    
    -------------------------------------------------------------------    
    -- resolution function
    -------------------------------------------------------------------    
            
    FUNCTION resolved ( s : std_ulogic_vector ) RETURN std_ulogic IS
        VARIABLE result : std_ulogic := 'Z';  -- weakest state default
    BEGIN
    	RETURN result;
    END resolved;

    -------------------------------------------------------------------    
    -- conversion functions
    -------------------------------------------------------------------    
    FUNCTION To_bit ( s : std_ulogic;        xmap : BIT := '0') RETURN BIT IS
    BEGIN
            CASE s IS
                WHEN '0' | 'L' => RETURN ('0');
                WHEN '1' | 'H' => RETURN ('1');
                WHEN OTHERS => RETURN xmap;
            END CASE;
    END;
    --------------------------------------------------------------------
    FUNCTION To_bitvector ( s : std_logic_vector ; xmap : BIT := '0') RETURN BIT_VECTOR IS
        ALIAS sv : std_logic_vector ( s'LENGTH-1 DOWNTO 0 ) IS s;
        VARIABLE result : BIT_VECTOR ( s'LENGTH-1 DOWNTO 0 );
    BEGIN
        FOR i IN result'RANGE LOOP
            CASE sv(i) IS
                WHEN '0' | 'L' => result(i) := '0';
                WHEN '1' | 'H' => result(i) := '1';
                WHEN OTHERS => result(i) := xmap;
            END CASE;
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_bitvector ( s : std_ulogic_vector; xmap : BIT := '0') RETURN BIT_VECTOR IS
        ALIAS sv : std_ulogic_vector ( s'LENGTH-1 DOWNTO 0 ) IS s;
        VARIABLE result : BIT_VECTOR ( s'LENGTH-1 DOWNTO 0 );
    BEGIN
        FOR i IN result'RANGE LOOP
            CASE sv(i) IS
                WHEN '0' | 'L' => result(i) := '0';
                WHEN '1' | 'H' => result(i) := '1';
                WHEN OTHERS => result(i) := xmap;
            END CASE;
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_StdULogic       ( b : BIT               ) RETURN std_ulogic IS
    BEGIN
        CASE b IS
            WHEN '0' => RETURN '0';
            WHEN '1' => RETURN '1';
        END CASE;
    END;
    --------------------------------------------------------------------
    FUNCTION To_StdLogicVector  ( b : BIT_VECTOR  ) RETURN std_logic_vector IS
        ALIAS bv : BIT_VECTOR ( b'LENGTH-1 DOWNTO 0 ) IS b;
        VARIABLE result : std_logic_vector ( b'LENGTH-1 DOWNTO 0 );
    BEGIN
        FOR i IN result'RANGE LOOP
            CASE bv(i) IS
                WHEN '0' => result(i) := '0';
                WHEN '1' => result(i) := '1';
            END CASE;
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_StdLogicVector  ( s : std_ulogic_vector ) RETURN std_logic_vector IS
        ALIAS sv : std_ulogic_vector ( s'LENGTH-1 DOWNTO 0 ) IS s;
        VARIABLE result : std_logic_vector ( s'LENGTH-1 DOWNTO 0 );
    BEGIN
        FOR i IN result'RANGE LOOP
            result(i) := sv(i);
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_StdULogicVector ( b : BIT_VECTOR  ) RETURN std_ulogic_vector IS
        ALIAS bv : BIT_VECTOR ( b'LENGTH-1 DOWNTO 0 ) IS b;
        VARIABLE result : std_ulogic_vector ( b'LENGTH-1 DOWNTO 0 );
    BEGIN
        FOR i IN result'RANGE LOOP
            CASE bv(i) IS
                WHEN '0' => result(i) := '0';
                WHEN '1' => result(i) := '1';
            END CASE;
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_StdULogicVector ( s : std_logic_vector ) RETURN std_ulogic_vector IS
        ALIAS sv : std_logic_vector ( s'LENGTH-1 DOWNTO 0 ) IS s;
        VARIABLE result : std_ulogic_vector ( s'LENGTH-1 DOWNTO 0 );
    BEGIN
        FOR i IN result'RANGE LOOP
            result(i) := sv(i);
        END LOOP;
        RETURN result;
    END;
    
    -------------------------------------------------------------------    
    -- strength strippers and type convertors
    -------------------------------------------------------------------    
    -- to_x01
    -------------------------------------------------------------------    
    FUNCTION To_X01  ( s : std_logic_vector ) RETURN  std_logic_vector IS
    BEGIN
        RETURN s;
    END;
    --------------------------------------------------------------------
    FUNCTION To_X01  ( s : std_ulogic_vector ) RETURN  std_ulogic_vector IS
    BEGIN
        RETURN s ;
    END;
    --------------------------------------------------------------------
    FUNCTION To_X01  ( s : std_ulogic ) RETURN  X01 IS
    BEGIN
        RETURN s;
    END;
    --------------------------------------------------------------------
    FUNCTION To_X01  ( b : BIT_VECTOR ) RETURN  std_logic_vector IS
        ALIAS bv : BIT_VECTOR ( 1 TO b'LENGTH ) IS b;
        VARIABLE result : std_logic_vector ( 1 TO b'LENGTH );
    BEGIN
        FOR i IN result'RANGE LOOP
            CASE bv(i) IS
                WHEN '0' => result(i) := '0';
                WHEN '1' => result(i) := '1';
            END CASE;
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_X01  ( b : BIT_VECTOR ) RETURN  std_ulogic_vector IS
        ALIAS bv : BIT_VECTOR ( 1 TO b'LENGTH ) IS b;
        VARIABLE result : std_ulogic_vector ( 1 TO b'LENGTH );
    BEGIN
        FOR i IN result'RANGE LOOP
            CASE bv(i) IS
                WHEN '0' => result(i) := '0';
                WHEN '1' => result(i) := '1';
            END CASE;
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_X01  ( b : BIT ) RETURN  X01 IS
    BEGIN
            CASE b IS
                WHEN '0' => RETURN('0');
                WHEN '1' => RETURN('1');              
            END CASE;
    END;
    --------------------------------------------------------------------
    -- to_x01z
    -------------------------------------------------------------------    
    FUNCTION To_X01Z  ( s : std_logic_vector ) RETURN  std_logic_vector IS
    BEGIN
        RETURN s;
    END;
    --------------------------------------------------------------------
    FUNCTION To_X01Z  ( s : std_ulogic_vector ) RETURN  std_ulogic_vector IS
    BEGIN
        RETURN s;
    END;
    --------------------------------------------------------------------
    FUNCTION To_X01Z  ( s : std_ulogic ) RETURN  X01Z IS
    BEGIN
        RETURN s;
    END;
    --------------------------------------------------------------------
    FUNCTION To_X01Z  ( b : BIT_VECTOR ) RETURN  std_logic_vector IS
        ALIAS bv : BIT_VECTOR ( 1 TO b'LENGTH ) IS b;
        VARIABLE result : std_logic_vector ( 1 TO b'LENGTH );
    BEGIN
        FOR i IN result'RANGE LOOP
            CASE bv(i) IS
                WHEN '0' => result(i) := '0';
                WHEN '1' => result(i) := '1';
            END CASE;
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_X01Z  ( b : BIT_VECTOR ) RETURN  std_ulogic_vector IS
        ALIAS bv : BIT_VECTOR ( 1 TO b'LENGTH ) IS b;
        VARIABLE result : std_ulogic_vector ( 1 TO b'LENGTH );
    BEGIN
        FOR i IN result'RANGE LOOP
            CASE bv(i) IS
                WHEN '0' => result(i) := '0';
                WHEN '1' => result(i) := '1';
            END CASE;
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_X01Z  ( b : BIT ) RETURN  X01Z IS
    BEGIN
            CASE b IS
                WHEN '0' => RETURN('0');
                WHEN '1' => RETURN('1');              
            END CASE;
    END;
    --------------------------------------------------------------------
    -- to_ux01
    -------------------------------------------------------------------    
    FUNCTION To_UX01  ( s : std_logic_vector ) RETURN  std_logic_vector IS
    BEGIN
        RETURN s;
    END;
    --------------------------------------------------------------------
    FUNCTION To_UX01  ( s : std_ulogic_vector ) RETURN  std_ulogic_vector IS
    BEGIN
        RETURN s;
    END;
    --------------------------------------------------------------------
    FUNCTION To_UX01  ( s : std_ulogic ) RETURN  UX01 IS
    BEGIN
        RETURN s;
    END;
    --------------------------------------------------------------------
    FUNCTION To_UX01  ( b : BIT_VECTOR ) RETURN  std_logic_vector IS
        ALIAS bv : BIT_VECTOR ( 1 TO b'LENGTH ) IS b;
        VARIABLE result : std_logic_vector ( 1 TO b'LENGTH );
    BEGIN
        FOR i IN result'RANGE LOOP
            CASE bv(i) IS
                WHEN '0' => result(i) := '0';
                WHEN '1' => result(i) := '1';
            END CASE;
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_UX01  ( b : BIT_VECTOR ) RETURN  std_ulogic_vector IS
        ALIAS bv : BIT_VECTOR ( 1 TO b'LENGTH ) IS b;
        VARIABLE result : std_ulogic_vector ( 1 TO b'LENGTH );
    BEGIN
        FOR i IN result'RANGE LOOP
            CASE bv(i) IS
                WHEN '0' => result(i) := '0';
                WHEN '1' => result(i) := '1';
            END CASE;
        END LOOP;
        RETURN result;
    END;
    --------------------------------------------------------------------
    FUNCTION To_UX01  ( b : BIT ) RETURN  UX01 IS
    BEGIN
            CASE b IS
                WHEN '0' => RETURN('0');
                WHEN '1' => RETURN('1');              
            END CASE;
    END;

    -------------------------------------------------------------------    
    -- edge detection
    -------------------------------------------------------------------    
    FUNCTION rising_edge  (SIGNAL s : std_ulogic) RETURN BOOLEAN IS
    BEGIN
        RETURN (s'EVENT AND (To_X01(s) = '1'));
    END;

    FUNCTION falling_edge (SIGNAL s : std_ulogic) RETURN BOOLEAN IS
    BEGIN
        RETURN (s'EVENT AND (To_X01(s) = '0'));
    END;

    -------------------------------------------------------------------    
    -- object contains an unknown
    -------------------------------------------------------------------    
    FUNCTION Is_X ( s : std_ulogic_vector ) RETURN  BOOLEAN IS
    BEGIN
        RETURN FALSE;
    END;
    --------------------------------------------------------------------
    FUNCTION Is_X ( s : std_logic_vector  ) RETURN  BOOLEAN IS
    BEGIN
        RETURN FALSE;
    END;
    --------------------------------------------------------------------
    FUNCTION Is_X ( s : std_ulogic        ) RETURN  BOOLEAN IS
    BEGIN
        RETURN FALSE;
    END;

END std_logic_1164;


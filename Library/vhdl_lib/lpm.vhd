-- mm 3.0
------------------------------------------------------------------
-- Library  LPM
-- Copyright (c) 2002 Altium Ltd  
-- Copyrignt (c) 1993 EDIF LPM Subcommittee, Electronic Industries Assn
-- LPM specification published by EIA, 1-800-854-7179 / 303-792-2181
------------------------------------------------------------------
-- Component definitions for direct instantiation of LPM Modules
-- For use with Metamor logic synthesis
--
--************************************************************************
-- THIS file contains THREE packages :
--  one for LPM 2 1 0, one for LPM 2 0 1, and one for LPM 2 0 0
-- IMPORTANT : Check which version your silicon vendor is using .
--************************************************************************
--
-- Macro Instiantation
----------------------
--
-- To use this libary include the following two statements in your vhd file
--   library LPM;
--   use LPM.macros201.all;
--
-- these components may be instainatiated in your design in the usual
-- way , eg :
--    u1 : lpm_compare generic map (4,"unsigned") port map (d1,d2, aeb => x);
--
-- The compiler will issue a run time message in the log file , 
-- such as :
--    component : u1 : Macrocell "lpm_compare"
-- this is not an error, simply a note that this components behavior is not 
-- defined in vhdl , it will be defined by the LPM compiler.
--
-- Macro Inferrence
-------------------
--
-- LPM macros will also be inferred from certain vhdl expressions, e.g.
--    c <= a = b;  
-- will infer a LPM_COMPARE macro if a and b are signals.
--
-- This library is not required to infer macros, no special messages
-- are issued for infered macros
--
-- Macro inferrence occurs automatically for relational and arithmetic 
-- operations when the LPM format is selected. 
--
-- However these operations dont always infer macros , eg
--     c <= 1 + 3;     -- wont infer a LPM_ADD_SUB macro 
--     c <= a + b      -- will infer a LPM_ADD_SUB macro a and b are signals
-- So the user may force macro instantiation for  relational and arithmetic 
-- operations by making both operands signals (or more generally, not metalogic
-- expressions - see Metamor Users Guide ).
-- 
--
-- Component ports datatypes and defaults
-----------------------------------------
--
-- If you wish to use datatypes other than std_logic_1164 , then create
-- your own package by copying from this one. There are no hidden magic
-- words, except that the and generic names must match the LPM specification.
-- All components that are LPM macrocells must have the Metamor synthesis
-- attribute 'macrocell' set to 'true'. Unbound components with this attribute
-- are LPM macrocells, unbound components without this attribute are
-- simply design hierarchy.
--
-- Also for your own declarations you need not declare all the ports and 
-- generics , only those required by the LPM specification (see note beleow). 
-- In this package optional inputs have default values so that by using named 
-- association in the port map they need not be connected if they are optional
-- in LPM. Note that the actual default values are ignored, the actual default
-- value may depend on several factors and is set in the LPM compiler.
--
-- NOTE : For OpenAbel output the port order in this file must be maintained,
--        and LPM 2 0 0 MUST be used.
--
-- LPM Properties 
-----------------
-- LPM requires instance specific Properties , these are specified using
-- VHDL generics.
-- The component declarations include these generic declarations.
-- Instance specific values are specified with a generic map. Some examples
-- are :
--
--    signal d1 : std_logic_vector(3 downto 0)      
--    signal d2 : std_logic_vector(0 to 3)          
--    signal d3,d4 : std_logic_vector(7 downto 6)   
--   ....
--    u1 : lpm_compare generic map (4)         --default is "signed"
--                     port map (d1,d2, aeb => x); 
--    u2 : lpm_compare generic map (2,"unsigned") 
--                     port map (d3,d4, y1, y2);   -- agb not used
--    u3 : lpm_compare generic map (representation =>"unsigned",
--                              width => 2 ) 
--                     port map (d3,d4, z);        -- alb is used
--
--
-- Constraints
--------------
-- LPM_AND, LPM_OR, LPM_XOR, LPM_MUX have  Width = 1
--
------------------------------------------------------------------

--*****************************
-- LPM 210
--*****************************

------------------------------------------------------------------
-- Version 1.1   Date 07/30/96
-- source www.edif.org
------------------------------------------------------------------
-- Excluded:
--
-- 1. LPM_POLARITY.
-- 2. SCAN pins are eliminated from storage functions.
------------------------------------------------------------------
-- Assumptions:
--
--    LPM_SVALUE, LPM_AVALUE, LPM_MODULUS, and LPM_NUMWORDS, LPM_HINT,
--    LPM_STRENGTH, LPM_DIRECTION, and LPM_PVALUE  default value is
--    string UNUSED.
------------------------------------------------------------------

------------------------------------------------------------------
-- Metamor changes :
-- type STD_LOGIC_2D not supported, LPM_AND, LPM_OR, LPM_XOR, LPM_MUX modified
-- added metamor synthesis attributes at end of package
------------------------------------------------------------------



library IEEE;
use IEEE.std_logic_1164.all;

package LPM_COMPONENTS is

  constant SIGNED : string := "SIGNED";
  constant UNSIGNED : string := "UNSIGNED";
  constant ADD : string := "ADD";
  constant SUB : string := "SUB";
  constant UP : string := "UP";
  constant DOWN : string := "DOWN";
  constant LOGICAL : string := "LOGICAL";
  constant ROTATE : string := "ROTATE";
  constant ARITHMETIC : string := "ARITHMETIC";
  constant REGISTERED : string := "REGISTERED";
  constant UNREGISTERED : string := "UNREGISTERED";
  constant F : string := "F";
  constant FD : string := "FD";
  constant FR : string := "FR";
  constant FDR : string := "FDR";
  constant UNUSED : string := "UNUSED";
  constant FFTYPE_DFF : string := "DFF";
  constant FFTYPE_TFF : string := "TFF";
  constant L_CONSTANT : string := "LPM_CONSTANT";
  constant L_INV : string := "LPM_INV";
  constant L_AND : string := "LPM_AND";
  constant L_OR : string := "LPM_OR";
  constant L_XOR : string := "LPM_XOR";
  constant L_BUSTRI : string := "LPM_BUSTRI";
  constant L_MUX : string := "LPM_MUX";
  constant L_DECODE : string := "LPM_DECODE";
  constant L_CLSHIFT : string := "LPM_CLSHIFT";
  constant L_ADD_SUB : string := "LPM_ADD_SUB";
  constant L_COMPARE : string := "LPM_COMPARE";
  constant L_MULT : string := "LPM_MULT";
  constant L_ABS : string := "LPM_ABS";
  constant L_COUNTER : string := "LPM_COUNTER";
  constant L_LATCH : string := "LPM_LATCH";
  constant L_FF : string := "LPM_FF";
  constant L_SHIFTREG : string := "LPM_SHIFTREG";
  constant L_RAM_DQ : string := "LPM_RAM_DQ";
  constant L_RAM_IO : string := "LPM_RAM_IO";
  constant L_ROM : string := "LPM_ROM";
  constant L_TTABLE : string := "LPM_TTABLE";
  constant L_FSM : string := "LPM_FSM";
  constant L_INPAD : string := "LPM_INPAD";
  constant L_OUTPAD : string := "LPM_OUTPAD";
  constant L_BIPAD : string := "LPM_BIPAD";

---------- not supported
--  type STD_LOGIC_2D is array (NATURAL RANGE <>, NATURAL RANGE <>) of STD_LOGIC;

  component LPM_COUNTER
    generic (LPM_WIDTH : positive;
	     LPM_MODULUS: string := UNUSED;
	     LPM_AVALUE : string := UNUSED;
	     LPM_SVALUE : string := UNUSED;
	     LPM_DIRECTION : string := UNUSED;
	     LPM_TYPE: string := L_COUNTER;
	     LPM_PVALUE : string := UNUSED;
	     LPM_HINT : string := UNUSED);
    port (DATA: in std_logic_vector(LPM_WIDTH-1 downto 0):= (OTHERS => '0');
	  CLOCK : in std_logic ;
	  CLK_EN : in std_logic := '1';
	  CNT_EN : in std_logic := '1';
	  UPDOWN : in std_logic := '1';
	  SLOAD : in std_logic := '0';
	  SSET : in std_logic := '0';
	  SCLR : in std_logic := '0';
	  ALOAD : in std_logic := '0';
	  ASET : in std_logic := '0';
	  ACLR : in std_logic := '0';
	  EQ : out std_logic;
	  Q : out std_logic_vector(LPM_WIDTH-1 downto 0));
  end component;

  component LPM_ABS
    generic (LPM_WIDTH : positive;
	     LPM_TYPE: string := L_ABS);
    port (DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
	  RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0);
	  OVERFLOW: out std_logic);
  end component;

  component LPM_MULT
    generic (LPM_WIDTHA : positive;
	     LPM_WIDTHB : positive;
	     LPM_WIDTHS : positive;
	     LPM_WIDTHP : positive;
	     LPM_REPRESENTATION : string := UNSIGNED;
	     LPM_PIPELINE : integer := 0;
	     LPM_TYPE: string := L_MULT;
	     LPM_HINT : string := UNUSED);
    port (DATAA : in std_logic_vector(LPM_WIDTHA-1 downto 0);
	  DATAB : in std_logic_vector(LPM_WIDTHB-1 downto 0);
	  ACLR : in std_logic := '0';
	  CLOCK : in std_logic := '0';
	  SUM: in std_logic_vector(LPM_WIDTHS-1 downto 0) := (OTHERS => '0');
	  RESULT : out std_logic_vector(LPM_WIDTHP-1 downto 0));
  end component;

  component LPM_COMPARE
    generic (LPM_WIDTH : positive;
	     LPM_REPRESENTATION : string := UNSIGNED;
	     LPM_PIPELINE : integer := 0;
	     LPM_TYPE: string := L_COMPARE;
	     LPM_HINT : string := UNUSED);
    port (DATAA: in std_logic_vector(LPM_WIDTH-1 downto 0);
	  DATAB: in std_logic_vector(LPM_WIDTH-1 downto 0);
	  ACLR : in std_logic := '0';
	  CLOCK : in std_logic := '0';
	  AGB: out std_logic;
	  AGEB: out std_logic;
	  AEB: out std_logic;
	  ANEB: out std_logic;
	  ALB: out std_logic;
	  ALEB: out std_logic);
  end component;

  component LPM_ADD_SUB
    generic (LPM_WIDTH: positive;
	     LPM_REPRESENTATION: string := SIGNED;
	     LPM_DIRECTION: string := UNUSED;
	     LPM_HINT : string := UNUSED;
	     LPM_PIPELINE : integer := 0;
	     LPM_TYPE: string := L_ADD_SUB);
    port (DATAA: in std_logic_vector(LPM_WIDTH-1 downto 0);
	  DATAB: in std_logic_vector(LPM_WIDTH-1 downto 0);
	  ACLR : in std_logic := '0';
	  CLOCK : in std_logic := '0';
	  CIN: in std_logic := '0';
	  ADD_SUB: in std_logic := '1';
	  RESULT: out std_logic_vector(LPM_WIDTH-1 downto 0);
	  COUT: out std_logic;
	  OVERFLOW: out std_logic);
  end component;

  component LPM_LATCH
    generic (LPM_WIDTH : positive;
	     LPM_PVALUE : string := UNUSED;
	     LPM_TYPE: string := L_LATCH;
	     LPM_AVALUE : string := UNUSED);
    port (DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
	  GATE : in std_logic;
	  ASET : in std_logic := '0';
	  ACLR : in std_logic := '0';
	  Q : out std_logic_vector(LPM_WIDTH-1 downto 0));
  end component;



  component LPM_FF
    generic (LPM_WIDTH : positive;
	     LPM_AVALUE : string := UNUSED;
	     LPM_FFTYPE: string := FFTYPE_DFF;
	     LPM_TYPE: string := L_FF;
	     LPM_SVALUE : string := UNUSED);
    port (DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
	  CLOCK : in std_logic;
	  ENABLE : in std_logic := '1';
	  SLOAD : in std_logic := '0';
	  SCLR : in std_logic := '0';
	  SSET : in std_logic := '0';
	  ALOAD : in std_logic := '0';
	  ACLR : in std_logic := '0';
	  ASET : in std_logic := '0';
	  Q : out std_logic_vector(LPM_WIDTH-1 downto 0));
  end component;



  component LPM_SHIFTREG
    generic (LPM_WIDTH : positive;
	     LPM_AVALUE : string := UNUSED;
	     LPM_DIRECTION: string := UNUSED;
	     LPM_TYPE: string := L_SHIFTREG;
	     LPM_SVALUE : string := UNUSED);
    port (DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
	  CLOCK : in std_logic;
	  ENABLE : in std_logic := '1';
	  SHIFTIN : in std_logic := '1';
	  LOAD : in std_logic := '0';
	  SCLR : in std_logic := '0';
	  SSET : in std_logic := '0';
	  ACLR : in std_logic := '0';
	  ASET : in std_logic := '0';
	  Q : out std_logic_vector(LPM_WIDTH-1 downto 0);
	  SHIFTOUT : out std_logic);
  end component;

  component LPM_DECODE
    generic (LPM_WIDTH : positive;
	     LPM_TYPE: string := L_DECODE;
	     LPM_PIPELINE : integer := 0;
	     LPM_DECODES : natural);
    port (DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
	  ACLR : in std_logic := '0';
	  CLOCK : in std_logic := '0';
	  ENABLE : in std_logic := '1';
	  EQ : out std_logic_vector(LPM_DECODES-1 downto 0));
  end component;

  component LPM_CONSTANT
    generic (LPM_WIDTH : positive;
	     LPM_CVALUE: natural;
	     LPM_TYPE: string := L_CONSTANT;
	     LPM_STRENGTH : string := UNUSED);
    port (RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0));
  end component;

  component LPM_INV
    generic (LPM_WIDTH : positive;
	     LPM_TYPE: string := L_INV);
    port (DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
	  RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0));
  end component;

  component LPM_BUSTRI
    generic (LPM_WIDTH : positive;
	     LPM_TYPE: string := L_BUSTRI);
    port (DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
	  ENABLEDT : in std_logic := '0';
	  ENABLETR : in std_logic := '0';
	  RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0);
	  TRDATA : inout std_logic_vector(LPM_WIDTH-1 downto 0));
  end component;

  component LPM_INPAD
    generic (LPM_WIDTH : positive;
	     LPM_TYPE: string := L_INPAD);
    port (PAD : in std_logic_vector(LPM_WIDTH-1 downto 0);
	  RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0));
  end component;

  component LPM_OUTPAD
    generic (LPM_WIDTH : positive;
	     LPM_TYPE: string := L_OUTPAD);
    port (DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
	  PAD : out std_logic_vector(LPM_WIDTH-1 downto 0));
  end component;

  component LPM_BIPAD
    generic (LPM_WIDTH : positive;
	     LPM_TYPE: string := L_BIPAD);
    port (DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
	  ENABLE : in std_logic;
	  RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0);
	  PAD: inout std_logic_vector(LPM_WIDTH-1 downto 0));
  end component;

  component LPM_CLSHIFT
    generic (LPM_WIDTH: positive;
	     LPM_WIDTHDIST: positive;
	     LPM_TYPE: string := L_CLSHIFT;
	     LPM_SHIFTTYPE: string := LOGICAL);
    port (DATA: in STD_LOGIC_VECTOR(LPM_WIDTH-1 downto 0);
	  DISTANCE: in STD_LOGIC_VECTOR(LPM_WIDTHDIST-1 downto 0);
	  DIRECTION: in STD_LOGIC := '0';
	  RESULT: out STD_LOGIC_VECTOR(LPM_WIDTH-1 downto 0);
	  UNDERFLOW: out STD_LOGIC;
	  OVERFLOW: out STD_LOGIC);
  end component;

  component LPM_RAM_DQ
    generic (LPM_WIDTH: positive;
	     LPM_TYPE: string := L_RAM_DQ;
	     LPM_WIDTHAD: positive;
	     LPM_NUMWORDS: string := UNUSED;
	     LPM_FILE: string := UNUSED;
	     LPM_INDATA: string := REGISTERED;
	     LPM_ADDRESS_CONTROL: string := REGISTERED;
	     LPM_OUTDATA: string := REGISTERED);
    port (DATA: in STD_LOGIC_VECTOR(LPM_WIDTH-1 downto 0);
	  ADDRESS: in STD_LOGIC_VECTOR(LPM_WIDTHAD-1 downto 0);
	  WE: in STD_LOGIC := '1';
	  INCLOCK: in STD_LOGIC := '1';
	  OUTCLOCK: in STD_LOGIC := '1';
	  Q: out STD_LOGIC_VECTOR(LPM_WIDTH-1 downto 0));
  end component;

  component LPM_RAM_IO
    generic (LPM_WIDTH: positive;
	     LPM_TYPE: string := L_RAM_IO;
	     LPM_WIDTHAD: positive;
	     LPM_NUMWORDS: string := UNUSED;
	     LPM_FILE: string := UNUSED;
	     LPM_INDATA: string := REGISTERED;
	     LPM_ADDRESS_CONTROL: string := REGISTERED;
	     LPM_OUTDATA: string := REGISTERED);

    port (ADDRESS: in STD_LOGIC_VECTOR(LPM_WIDTHAD-1 downto 0);
	  WE: in STD_LOGIC;
	  INCLOCK: in STD_LOGIC := '1';
	  OUTCLOCK: in STD_LOGIC := '1';
	  OUTENAB: in STD_LOGIC := '1';
	  MEMENAB: in STD_LOGIC := '1';
	  DIO: inout STD_LOGIC_VECTOR(LPM_WIDTH-1 downto 0));
  end component;

  component LPM_ROM
    generic (LPM_WIDTH: positive;
	     LPM_TYPE: string := L_ROM;
	     LPM_WIDTHAD: positive;
	     LPM_NUMWORDS: string := UNUSED;
	     LPM_FILE: string ;
	     LPM_ADDRESS_CONTROL: string := REGISTERED;
	     LPM_OUTDATA: string := REGISTERED);
    port (ADDRESS: in STD_LOGIC_VECTOR(LPM_WIDTHAD-1 downto 0);
	  INCLOCK: in STD_LOGIC := '1';
	  OUTCLOCK: in STD_LOGIC := '1';
	  MEMENAB: in STD_LOGIC := '1';
	  Q: out STD_LOGIC_VECTOR(LPM_WIDTH-1 downto 0));
  end component;

  component LPM_TTABLE
    generic (LPM_WIDTHIN: positive;
	     LPM_WIDTHOUT: positive;
	     LPM_TYPE: string := L_TTABLE;
	     LPM_FILE: string ;
	     LPM_TRUTHTYPE : string := FD);
    port (DATA: in std_logic_vector(LPM_WIDTHIN-1 downto 0);
	  RESULT: out std_logic_vector(LPM_WIDTHOUT-1 downto 0));
  end component;

  component LPM_FSM
    generic (LPM_WIDTHIN: positive;
	     LPM_WIDTHOUT: positive;
	     LPM_WIDTHS: positive := 1;
	     LPM_TYPE: string := L_FSM;
	     LPM_FILE: string ;
	     LPM_AVALUE: string := UNUSED;
	     LPM_TRUTHTYPE : string := FD);
    port (DATA: in std_logic_vector(LPM_WIDTHIN-1 downto 0);
	  CLOCK: in std_logic;
	  ASET: in std_logic := '0';
	  STATE: out std_logic_vector(LPM_WIDTHS-1 downto 0);
	  RESULT: out std_logic_vector(LPM_WIDTHOUT-1 downto 0));
  end component;

  component LPM_AND
    generic (LPM_WIDTH : positive;  -- must be 1
	     LPM_SIZE : positive);
--    port (DATA : in std_logic_2D(LPM_SIZE-1 downto 0, LPM_WIDTH-1 downto 0);
    port (DATA : in std_logic_vector(LPM_SIZE-1 downto 0);
	  RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0));
  end component;

  component LPM_OR
    generic (LPM_WIDTH : positive; -- must be 1
	     LPM_SIZE : positive);
--    port (DATA : in std_logic_2D(LPM_SIZE-1 downto 0, LPM_WIDTH-1 downto 0);
    port (DATA : in std_logic_vector(LPM_SIZE-1 downto 0);
	  RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0));
  end component;

  component LPM_XOR
    generic (LPM_WIDTH : positive;  -- must be 1
	     LPM_SIZE : positive);
--    port (DATA : in std_logic_2D(LPM_SIZE-1 downto 0, LPM_WIDTH-1 downto 0);
    port (DATA : in std_logic_vector(LPM_SIZE-1 downto 0);
	  RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0));
  end component;

  component LPM_MUX
    generic (LPM_WIDTH: positive;   -- must be 1
	     LPM_WIDTHS : positive;
	     LPM_PIPELINE : integer := 0;
	     LPM_SIZE: positive);

--    port (DATA : in std_logic_2D(LPM_SIZE-1 downto 0, LPM_WIDTH-1 downto 0);
    port (DATA : in std_logic_vector(LPM_SIZE-1 downto 0);
	  ACLR : in std_logic := '0';
	  CLOCK : in std_logic := '0';
	  SEL : in std_logic_vector(LPM_WIDTHS-1 downto 0);
	  RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0));
  end component;

  -- Metamor synthesis attribute
  attribute macrocell : boolean;
  attribute macrocell of LPM_COUNTER, LPM_ABS, LPM_MULT, LPM_COMPARE, 
    LPM_ADD_SUB, LPM_LATCH, LPM_FF, LPM_SHIFTREG, LPM_DECODE, LPM_CONSTANT, 
    LPM_INV, LPM_BUSTRI, LPM_INPAD, LPM_OUTPAD, LPM_BIPAD, LPM_CLSHIFT, 
    LPM_RAM_DQ, LPM_RAM_IO, LPM_ROM, LPM_TTABLE, LPM_FSM, LPM_AND, LPM_OR, 
    LPM_XOR, LPM_MUX : component is true;

  -- LPM non instance specific Attributes
  attribute LPM_TYPE : string;
  attribute LPM_TYPE of LPM_COUNTER : component is L_COUNTER;
  attribute LPM_TYPE of LPM_ABS : component is L_ABS;
  attribute LPM_TYPE of LPM_MULT : component is L_MULT;
  attribute LPM_TYPE of LPM_COMPARE : component is L_COMPARE;
  attribute LPM_TYPE of LPM_ADD_SUB : component is L_ADD_SUB;
  attribute LPM_TYPE of LPM_LATCH : component is L_LATCH;
  attribute LPM_TYPE of LPM_FF : component is L_FF;
  attribute LPM_TYPE of LPM_SHIFTREG : component is L_SHIFTREG;
  attribute LPM_TYPE of LPM_DECODE : component is L_DECODE;
  attribute LPM_TYPE of LPM_CONSTANT : component is L_CONSTANT;
  attribute LPM_TYPE of LPM_INV : component is L_INV;
  attribute LPM_TYPE of LPM_BUSTRI : component is L_BUSTRI;
  attribute LPM_TYPE of LPM_INPAD : component is L_INPAD;
  attribute LPM_TYPE of LPM_OUTPAD : component is L_OUTPAD;
  attribute LPM_TYPE of LPM_BIPAD : component is L_BIPAD;
  attribute LPM_TYPE of LPM_CLSHIFT : component is L_CLSHIFT;
  attribute LPM_TYPE of LPM_RAM_DQ : component is L_RAM_DQ;
  attribute LPM_TYPE of LPM_RAM_IO : component is L_RAM_IO;
  attribute LPM_TYPE of LPM_ROM : component is L_ROM;
  attribute LPM_TYPE of LPM_TTABLE : component is L_TTABLE;
  attribute LPM_TYPE of LPM_FSM : component is L_FSM;
  attribute LPM_TYPE of LPM_AND : component is L_AND;
  attribute LPM_TYPE of LPM_OR : component is L_OR;
  attribute LPM_TYPE of LPM_XOR : component is L_XOR;
  attribute LPM_TYPE of LPM_MUX : component is L_MUX;

  function str_to_int( s : string ) return integer;

end LPM_COMPONENTS;

package body LPM_COMPONENTS is

  function str_to_int( s : string ) return integer is
    variable len : integer := s'length;
    variable ivalue : integer := 0;
    variable digit : integer;
  begin
    for i in len downto 1 loop
      case s(i) is
	when '0' =>
	  digit := 0;
	when '1' =>
	  digit := 1;
	when '2' =>
	  digit := 2;
	when '3' =>
	  digit := 3;
	when '4' =>
	  digit := 4;
	when '5' =>
	  digit := 5;
	when '6' =>
	  digit := 6;
	when '7' =>
	  digit := 7;
	when '8' =>
	  digit := 8;
	when '9' =>
	  digit := 9;
	when others =>
	  ASSERT FALSE
	    REPORT "Illegal Character "&  s(i) & "in string parameter! "
	    SEVERITY ERROR;
      end case;
      ivalue := ivalue * 10 + digit;
    end loop;
    return ivalue;
  end;
end;


--*****************************
-- LPM 201
--*****************************




library ieee;
use ieee.std_logic_1164.all;

package macros201 is

  component LPM_CONSTANT is
    generic(Lpm_Width, Lpm_Cvalue : natural); 
    port (Result: out std_logic_vector);
  end component;

  component LPM_INV is
    generic(Lpm_Width : natural); 
    port (Data : std_logic_vector;  Result: out std_logic);
  end component;

  component LPM_AND is   
    generic(Lpm_Size : natural); 
    port (Data0 : std_logic_vector; Result0: out std_logic);
  end component;

  component LPM_OR is 
    generic(Lpm_Size : natural); 
    port (Data0 : std_logic_vector; Result0: out std_logic);
  end component;

  component LPM_XOR is 
    generic(Lpm_Size : natural); 
    port (Data0 : std_logic_vector; Result0: out std_logic);
  end component;

  component LPM_BUSTRI is
    generic(Lpm_Width : natural); 
    port (EnableDT,EnableTR : std_logic;
	  Data : std_logic_vector; 
	  Tridata : inout std_logic_vector; 
	  Result : out std_logic_vector);
  end component;

  component LPM_MUX is         
    generic(Lpm_Width, Lpm_Size, Lpm_WidthS : natural); 
    port (Sel, Data : std_logic_vector;    
	  Result : out std_logic);
  end component;

  component LPM_DECODE is 
    generic(Lpm_Width, Lpm_Decodes : natural); 
    port (Data : std_logic_vector; 
	  Enable : std_logic;
	  Eq : out std_logic_vector);
  end component;

  component LPM_CLSHIFT is              
    generic (Lpm_Width, Lpm_WidthDist : natural;
             Lpm_ShiftType : string); -- "logical" , "rotate", or "arithmetic"
    port (Data, Distance : std_logic_vector;
	  Direction : std_logic;
	  Overflow, Underflow : out std_logic;
	  Result : out std_logic_vector);
  end component;

  -- do not remove and ports from lpm_add_sub
  component LPM_ADD_SUB is
    generic (Lpm_Width : natural;
             Lpm_Representation : string := ""); -- "unsigned" "signed"
    port (DataA, DataB : std_logic_vector; 
	  Add_Sub : std_logic;
	  Cin : std_logic := '0';
	  Result : out std_logic_vector;
	  Cout, Overflow : out std_logic);
  end component;

  -- do not remove and ports from lpm_compare
  component LPM_COMPARE is
    generic (Lpm_Width : natural;
             Lpm_Representation : string := ""); -- "unsigned" "signed"
    port (DataA, DataB : std_logic_vector; 
	  ALB, AEB, AGB, ANEB, AGEB, ALEB : out std_logic);
  end component;

  component LPM_MULT is
    generic (Lpm_WidthA,Lpm_WidthB,Lpm_WidthS,Lpm_WidthP : natural;
	     Lpm_Representation : string := ""); -- "unsigned" "signed"
    port (DataA, DataB, Sum : std_logic_vector; 
	  Result : out std_logic_vector);
  end component;

  component LPM_ABS is
    generic (Lpm_Width : natural);
    port (Data : std_logic_vector; 
          Overflow : out std_logic;
	  Result : out std_logic_vector);
  end component;

  component LPM_COUNTER is
    generic (Lpm_Width,Lpm_Modulus,Lpm_Avalue,Lpm_Svalue,Lpm_Pvalue : natural;
             Lpm_Representation : string := ""); -- "unsigned" "grey"
    port (Data : std_logic_vector := ""; 
	  Clock : std_logic;
	  Clk_En, Cnt_En, UpDown : std_logic := '1';
	  Aset, Aclr, Aload : std_logic := '0';
	  Sset, Sclr, Sload : std_logic := '0';
	  TestEnab, TestIn : std_logic := '0';
          TestOut : std_logic;
	  Q,Eq : out std_logic_vector);
  end component;

  component LPM_LATCH is
    generic (Lpm_Width : natural;
             Lpm_Avalue, Lpm_Pvalue : std_logic_vector := "");
    port (Data : std_logic_vector := ""; 
	  Gate : std_logic;
	  Aset, Aclr : std_logic := '0';
	  TestEnab, TestIn : std_logic := '0';
          TestOut : std_logic;
	  Q : out std_logic_vector);
  end component;

  component LPM_DFF is
    generic (Lpm_Width : natural;
             Lpm_Avalue, Lpm_Svalue, Lpm_Pvalue : std_logic_vector := "");
    port (Data : std_logic_vector := ""; 
	  Clock : std_logic;
	  Enable,ShiftIn,ShiftEn : std_logic := '1';
	  Aset, Aclr : std_logic := '0';
	  Sset, Sclr : std_logic := '0';
	  TestEnab, TestIn : std_logic := '0';
          TestOut : std_logic;
	  ShiftOut : std_logic;
	  Q : out std_logic_vector);
  end component;

  component LPM_TFF is
    generic (Lpm_Width : natural;
             Lpm_Avalue, Lpm_Svalue, Lpm_Pvalue : std_logic_vector := "");
    port (Data : std_logic_vector; 
	  Clock : std_logic;
	  Enable: std_logic := '1';
	  Aset, Aclr, Aload : std_logic := '0';
	  Sset, Sclr, Sload : std_logic := '0';
	  TestEnab, TestIn : std_logic := '0';
          TestOut : std_logic;
	  Q : out std_logic_vector);
  end component;


  component LPM_RAM_DQ is
    generic (Lpm_Width, Lpm_WidthAd, Lpm_NumWords : natural);
    port (Data, Address : std_logic_vector; 
	  InClock, OutClock, WE: std_logic := '1';
	  Q : out std_logic_vector);
  end component;

  component LPM_RAM_IO is
    generic (Lpm_Width, Lpm_widthAd, Lpm_NumWords : natural);
    port (Address : std_logic_vector; 
	  InClock, OutClock, MemEnab, OutEnab, WE: std_logic := '1';
          DIO : inout std_logic_vector); 
  end component;

  component LPM_ROM is
    generic (Lpm_Width, Lpm_WidthAd, Lpm_Numwords : natural;
             Lpm_File : string); 
    port (Address : std_logic_vector;
	  InClock, OutClock : std_logic := '0';
	  MemEnab : std_logic;
	  Q : out std_logic_vector);
  end component;

  component LPM_TTABLE is
    generic (Lpm_WidthIn, Lpm_WidthOut : natural;
             Lpm_File : string; TruthType : string := ""); 
    port (Data : std_logic_vector;
	  Result : out std_logic_vector);
  end component;

  -- Metamor synthesis attribute
  attribute macrocell : boolean;
  attribute macrocell of LPM_CONSTANT, LPM_INV, LPM_AND, LPM_OR, LPM_XOR,
    LPM_BUSTRI, LPM_MUX, LPM_DECODE, LPM_CLSHIFT, LPM_ADD_SUB, LPM_COMPARE,
    LPM_MULT, LPM_ABS, LPM_COUNTER, LPM_LATCH, LPM_DFF, LPM_TFF, LPM_RAM_DQ,
    LPM_RAM_IO, LPM_ROM, LPM_TTABLE : component is true;

  -- LPM non instance specific Attributes
  attribute LPMTYPE : string;
  attribute LPMTYPE of LPM_CONSTANT : component is "LPM_CONSTANT";
  attribute LPMTYPE of LPM_INV : component is "LPM_INV";
  attribute LPMTYPE of LPM_AND : component is "LPM_AND";
  attribute LPMTYPE of LPM_OR : component is "LPM_OR";
  attribute LPMTYPE of LPM_XOR : component is "LPM_XOR";
  attribute LPMTYPE of LPM_BUSTRI : component is "LPM_BUSTRI";
  attribute LPMTYPE of LPM_MUX : component is "LPM_MUX";
  attribute LPMTYPE of LPM_DECODE : component is "LPM_DECODE";
  attribute LPMTYPE of LPM_CLSHIFT : component is "LPM_CLSHIFT";
  attribute LPMTYPE of LPM_ADD_SUB : component is "LPM_ADD_SUB";
  attribute LPMTYPE of LPM_COMPARE : component is "LPM_COMPARE";
  attribute LPMTYPE of LPM_MULT : component is "LPM_MULT";
  attribute LPMTYPE of LPM_ABS : component is "LPM_ABS";
  attribute LPMTYPE of LPM_COUNTER : component is "LPM_COUNTER";
  attribute LPMTYPE of LPM_LATCH : component is "LPM_LATCH";
  attribute LPMTYPE of LPM_DFF : component is "LPM_DFF";
  attribute LPMTYPE of LPM_TFF : component is "LPM_TFF";
  attribute LPMTYPE of LPM_RAM_DQ : component is "LPM_RAM_DQ";
  attribute LPMTYPE of LPM_RAM_IO : component is "LPM_RAM_IO";
  attribute LPMTYPE of LPM_ROM : component is "LPM_ROM";
  attribute LPMTYPE of LPM_TTABLE : component is "LPM_TTABLE";

end macros201;


--*****************************
-- LPM 200
--*****************************


library ieee;
use ieee.std_logic_1164.all;

package macros200 is

  component LPM_CONSTANT is
    generic(Width, Cvalue : natural); 
    port (Result: out std_logic_vector);
  end component;

  component LPM_INV is
    generic(Width : natural); 
    port (Data : std_logic_vector;  Result: out std_logic);
  end component;

  component LPM_AND is   
    generic(Size : natural); 
    port (Data0 : std_logic_vector; Result0: out std_logic);
  end component;

  component LPM_OR is 
    generic(Size : natural); 
    port (Data0 : std_logic_vector; Result0: out std_logic);
  end component;

  component LPM_XOR is 
    generic(Size : natural); 
    port (Data0 : std_logic_vector; Result0: out std_logic);
  end component;

  component LPM_BUSTRI is
    generic(Width : natural); 
    port (EnableDT,EnableTR : std_logic;
	  Data : std_logic_vector; 
	  Tridata : inout std_logic_vector; 
	  Result : out std_logic_vector);
  end component;

  component LPM_MUX is         
    generic(Width, Size, WidthS : natural); 
    port (\Select\, Data : std_logic_vector;    --select is vhdl keyword
	  Result : out std_logic);
  end component;

  component LPM_DECODE is 
    generic(Width, Decodes : natural); 
    port (Data : std_logic_vector; 
	  Enable : std_logic;
	  Eq : out std_logic_vector);
  end component;

  component LPM_CLSHIFT is              
    generic (Width, DistWidth : natural;
             ShiftType : string); -- "logical" , "rotate", or "arithmetic"
    port (Data, Distance : std_logic_vector;
	  Direction : std_logic;
	  Overflow, Underflow : out std_logic;
	  Result : out std_logic_vector);
  end component;

  -- do not remove and ports from lpm_add_sub
  component LPM_ADD_SUB is
    generic (Width : natural;
             Representation : string := ""); -- "unsigned" "signed"
    port (DataA, DataB : std_logic_vector; 
	  Add_Sub : std_logic;
	  Cin : std_logic := '0';
	  Sum : out std_logic_vector;
	  Cout, Overflow : out std_logic);
  end component;

  -- do not remove and ports from lpm_compare
  component LPM_COMPARE is
    generic (Width : natural;
             Representation : string := ""); -- "unsigned" "signed"
    port (DataA, DataB : std_logic_vector; 
	  ALB, AEB, AGB : out std_logic);
  end component;

  component LPM_MULT is
    generic (WidthA,WidthB,WidthS,WidthP : natural;
	     Representation : string := ""); -- "unsigned" "signed"
    port (DataA, DataB, Sum : std_logic_vector; 
	  Product : out std_logic_vector);
  end component;

  component LPM_ABS is
    generic (Width : natural);
    port (DataA : std_logic_vector; 
          Overflow : out std_logic;
	  Result : out std_logic_vector);
  end component;

  component LPM_COUNTER is
    generic (Width,Modulus,Avalue,Svalue,Pvalue : natural;
             Representation : string := ""); -- "unsigned" "grey"
    port (Data : std_logic_vector := ""; 
	  Clock : std_logic;
	  Enable, UpDown : std_logic := '1';
	  Aset, Aclr, Aload, Aconst : std_logic := '0';
	  Sset, Sclr, Sload, Sconst : std_logic := '0';
	  TestEnab, TestIn : std_logic := '0';
          TestOut : std_logic;
	  Q,Eq : out std_logic_vector);
  end component;

  component LPM_LATCH is
    generic (Width : natural;
             Avalue, Pvalue : std_logic_vector := "");
    port (Data : std_logic_vector := ""; 
	  Gate : std_logic;
	  Aset, Aclr, Aconst : std_logic := '0';
	  TestEnab, TestIn : std_logic := '0';
          TestOut : std_logic;
	  Q : out std_logic_vector);
  end component;

  component LPM_DFF is
    generic (Width : natural;
             Avalue, Svalue, Pvalue : std_logic_vector := "");
    port (Data : std_logic_vector := ""; 
	  Clock : std_logic;
	  Enable,ShiftIn,ShiftEn : std_logic := '1';
	  Aset, Aclr, Aconst : std_logic := '0';
	  Sset, Sclr, Sconst : std_logic := '0';
	  TestEnab, TestIn : std_logic := '0';
          TestOut : std_logic;
	  ShiftOut : std_logic;
	  Q : out std_logic_vector);
  end component;

  component LPM_TFF is
    generic (Width : natural;
             Avalue, Svalue, Pvalue : std_logic_vector := "");
    port (Data : std_logic_vector; 
	  Clock : std_logic;
	  Enable: std_logic := '1';
	  Aset, Aclr, Aconst, Aload : std_logic := '0';
	  Sset, Sclr, Sconst, Sload : std_logic := '0';
	  TestEnab, TestIn : std_logic := '0';
          TestOut : std_logic;
	  Q : out std_logic_vector);
  end component;


  component LPM_RAM_DQ is
    generic (Width, Ad_width, Numwords : natural);
    port (Data, Address : std_logic_vector; 
	  Clock, MemEnab, WE: std_logic := '1';
	  Q : out std_logic_vector);
  end component;

  component LPM_RAM_IO is
    generic (Width, Ad_width, Numwords : natural);
    port (Address : std_logic_vector; 
	  Clock, MemEnab, WE, OutEnab: std_logic := '1';
          DIO : inout std_logic_vector); 
  end component;

  component LPM_ROM is
    generic (Width, Ad_Width, Numwords : natural;
             \File\ : string);                   --file is vhdl keyword
    port (Address : std_logic_vector;
	  MemEnab : std_logic;
	  Q : out std_logic_vector);
  end component;

  component LPM_TTABLE is
    generic (InWidth, OutWidth : natural;
             \File\ : string; TruthType : string := ""); --file is vhdl keyword
    port (Data : std_logic_vector;
	  Result : out std_logic_vector);
  end component;

  -- Metamor synthesis attribute
  attribute macrocell : boolean;
  attribute macrocell of LPM_CONSTANT, LPM_INV, LPM_AND, LPM_OR, LPM_XOR,
    LPM_BUSTRI, LPM_MUX, LPM_DECODE, LPM_CLSHIFT, LPM_ADD_SUB, LPM_COMPARE,
    LPM_MULT, LPM_ABS, LPM_COUNTER, LPM_LATCH, LPM_DFF, LPM_TFF, LPM_RAM_DQ,
    LPM_RAM_IO, LPM_ROM, LPM_TTABLE : component is true;

  -- LPM non instance specific Attributes
  attribute LPMTYPE : string;
  attribute LPMTYPE of LPM_CONSTANT : component is "LPM_CONSTANT";
  attribute LPMTYPE of LPM_INV : component is "LPM_INV";
  attribute LPMTYPE of LPM_AND : component is "LPM_AND";
  attribute LPMTYPE of LPM_OR : component is "LPM_OR";
  attribute LPMTYPE of LPM_XOR : component is "LPM_XOR";
  attribute LPMTYPE of LPM_BUSTRI : component is "LPM_BUSTRI";
  attribute LPMTYPE of LPM_MUX : component is "LPM_MUX";
  attribute LPMTYPE of LPM_DECODE : component is "LPM_DECODE";
  attribute LPMTYPE of LPM_CLSHIFT : component is "LPM_CLSHIFT";
  attribute LPMTYPE of LPM_ADD_SUB : component is "LPM_ADD_SUB";
  attribute LPMTYPE of LPM_COMPARE : component is "LPM_COMPARE";
  attribute LPMTYPE of LPM_MULT : component is "LPM_MULT";
  attribute LPMTYPE of LPM_ABS : component is "LPM_ABS";
  attribute LPMTYPE of LPM_COUNTER : component is "LPM_COUNTER";
  attribute LPMTYPE of LPM_LATCH : component is "LPM_LATCH";
  attribute LPMTYPE of LPM_DFF : component is "LPM_DFF";
  attribute LPMTYPE of LPM_TFF : component is "LPM_TFF";
  attribute LPMTYPE of LPM_RAM_DQ : component is "LPM_RAM_DQ";
  attribute LPMTYPE of LPM_RAM_IO : component is "LPM_RAM_IO";
  attribute LPMTYPE of LPM_ROM : component is "LPM_ROM";
  attribute LPMTYPE of LPM_TTABLE : component is "LPM_TTABLE";

end macros200;

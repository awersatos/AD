-- mm 2.1.0
------------------------------------------------------------------
-- Library  XBLOX     
-- version 1.2
-- Copyright (c) Xilinx , Inc
-- Copyright (c) 2002 Altium Limited
------------------------------------------------------------------
-- Component definitions for direct instantiation of Xblox Modules
-- For use with Metamor X-Blox output
--
-- Macro Instiantation
----------------------
--
-- To use this libary include the following two statements in your vhd file
--   library xblox;
--   use xblox.macros.all;
--
-- these components may be instainatiated in your design in the usual
-- way , eg :
--    u1 : compare port map (d1,d2, a_ne_b => x);
--
-- The compiler will issue a run time message in verbose mode , 
-- such as :
--    component : u1 : Parameterized nMacrocell "compare"
-- this is not an error, simply a note that this components behavior is not 
-- defined in vhdl , it will be defined by the Xblox compiler.
--
-- Macro Inferrence
-------------------
--
-- Xblox macros will also be inferred from certain vhdl expressions, e.g.
--    c <= a = b;  
-- will infer a COMPARE macro if a and b are signals.
--
-- This library is not required to infer macros, no special messages
-- are issued for infered macros unless Verbose option is selected
--
-- Macro inferrence occurs automatically for relational and arithmetic 
-- operations when the Xblox format is selected. 
--
-- However these operations dont always infer macros , eg
--     c <= 1 + 3;     -- wont infer a ADD_SUB macro 
--     c <= a + b      -- will infer a ADD_SUB macro a and b are signals
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
-- words, except that the port and generic names must match the Xblox 
-- specification.
--
-- All components that are Xblox macrocells must have the Metamor synthesis
-- attribute 'macrocell' set to 'true'. Unbound components with this attribute
-- are Xblox macrocells, unbound components without this attribute are
-- simply un-linked design hierarchy.
--
-- Also for your own declarations you need not declare all the ports and 
-- generics , only those required by the Xblox specification (see note below). 
-- In this package optional inputs have default values so that by using named 
-- association in the port map they need not be connected if they are optional
-- in Xblox. Note that the actual default values are ignored, the actual 
-- default value may depend on several factors and is set in the Xblox 
-- compiler.
--
-- NOTE : For OpenAbel output the port order in this file must be maintained.
--
-- Xblox BOUNDS and ENCODING
----------------------------
--
-- by default vhdl arrays are mapped to Xblox busses with ENCODING = UBIN and
-- BOUNDS = array'left : array'right
--
-- you may change the bounds by changing the subtype of the actuals in
-- the port map , so :
--
--    signal d1 : std_logic_vector(3 downto 0)      -- decending/big-endian
--    signal d2 : std_logic_vector(0 to 3)          -- ascending/little-endian
--   ....
--    u1 : compare port map (d1,d2, x);
--
-- results in a compare macro with ports with different bounds 
--    A input BOUNDS = 3:0         -- decending/big-endian
--    B input BOUNDS = 0:3         -- ascending/little-endian
--
-- User defined components with numeric ports will have decending bounds.
--
-- You may change the encoding of all Xblox busses connected to a component
-- instance using the generic ENCODING. If not specified the value of 
-- ENCODING defaults to UBIN
--
-- Inferred macros will always have bus ports with attributes 
--    BOUNDS=(length-1):0   ENCODING=UBIN
-- behavior of the original vhdl description is maintained
------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package macros is

  component ANDBUS is
    generic (ENCODING : string := "");
    port (A : std_logic_vector;  O: out std_logic);
  end component;
  component ANDBUS1 is
    generic (ENCODING : string := "");
    port (A : std_logic; B : std_logic_vector;  O: out std_logic_vector);
  end component;
  component ANDBUS2 is
    generic (ENCODING : string := "");
    port (A , B : std_logic_vector;  O: out std_logic_vector);
  end component;

  component INVBUS is
    generic (ENCODING : string := "");
    port (A : std_logic_vector;  O: out std_logic);
  end component;

  component ORBUS is
    generic (ENCODING : string := "");
    port (A : std_logic_vector;  O: out std_logic);
  end component;
  component ORBUS1 is
    generic (ENCODING : string := "");
    port (A : std_logic; B : std_logic_vector;  O: out std_logic_vector);
  end component;
  component ORBUS2 is
    generic (ENCODING : string := "");
    port (A , B : std_logic_vector;  O: out std_logic_vector);
  end component;

  component XORBUS is
    generic (ENCODING : string := "");
    port (A : std_logic_vector;  O: out std_logic);
  end component;
  component XORBUS1 is
    generic (ENCODING : string := "");
    port (A : std_logic; B : std_logic_vector;  O: out std_logic_vector);
  end component;
  component XORBUS2 is
    generic (ENCODING : string := "");
    port (A , B : std_logic_vector;  O: out std_logic_vector);
  end component;
  
  component ACCUM is
    generic (ASYNC_VAL, SYNC_VAL : std_logic_vector := "";
             ENCODING : string := "");
    port (B : std_logic_vector; 
	  CLOCK :std_logic;
	  ADD_SUB, C_IN, LOAD, CLK_EN, ASYNC_CTRL, SYNC_CTRL :std_logic := '1';
	  Q_OUT : out std_logic_vector;
	  C_OUT, OVFL : out std_logic);
  end component;

  component ADD_SUB is
    generic (ENCODING : string := "");
    port (A,B : std_logic_vector; 
	  ADD_SUB, C_IN :std_logic := '1';
	  FUNC : out std_logic_vector;
	  C_OUT, OVFL : out std_logic);
  end component;

  component CLK_DIV is
    generic (DIVIDE_BY, DUTY_CYCLE : natural := 0;
             ENCODING : string := "");
    port (CLOCK : std_logic;
	  EN : std_logic := '1';
	  CLK_OUT : out std_logic);
  end component;

  component COMPARE is
    generic(STYLE : string := ""; -- "arith", "arith-wired", "ripple", etc.
            ENCODING : string := "");
    port (A, B : std_logic_vector; 
	  A_EQ_B, A_NE_B, A_LT_B, A_GT_B, A_LE_B, A_GE_B : out std_logic);
  end component;

  component COUNTER is
    generic (ASYNC_VAL, SYNC_VAL : std_logic_vector := "";
	     STYLE : string := ""; -- "binary", "johnson", or "lfsr"
	     COUNT_TO : natural := 0; 
             ENCODING : string := "");
    port (D_IN : std_logic_vector := ""; 
	  CLOCK : std_logic;
	  LOAD, UP_DN, ASYNC_CTRL, SYNC_CTRL, CLK_EN : std_logic := '1';
	  Q_OUT : out std_logic_vector;
	  TERM_CNT : out std_logic);
  end component;

  component DATA_REG is
    generic (ASYNC_VAL, SYNC_VAL : std_logic_vector := "";
             ENCODING : string := "");
    port (D_IN : std_logic_vector; 
	  CLOCK : std_logic;
	  ASYNC_CTRL, SYNC_CTRL, CLK_EN : std_logic := '1';
	  Q_OUT : out std_logic_vector);
  end component;

  component DECODE is
    generic (ENCODING : string := "");
    port (SEL : std_logic_vector; 
	  EN : std_logic := '1';
	  SEL_ERROR : out std_logic;
	  D_OUT : out std_logic_vector);
  end component;

  component INC_DEC is
    generic (STYLE : string := "";
	     INC_BY : natural; 
             ENCODING : string := "");
    port (A : std_logic_vector; 
	  INC_DEC : std_logic := '1';
	  FUNC : out std_logic_vector;
	  OVFL, C_OUT : out std_logic);
  end component;

  component MUXBUS is
    generic (ENCODING : string := "");
    port (MUX_IN, SEL : std_logic_vector; 
	  SEL_ERROR : out std_logic;
	  MUX_OUT : out std_logic);
  end component;

  component MUXBUS2 is
    generic (ENCODING : string := "");
    port (M0, M1, SEL : std_logic_vector; 
	  SEL_ERROR : out std_logic;
	  MUX_OUT : out std_logic_vector);
  end component;

  component MUXBUS4 is
    generic (ENCODING : string := "");
    port (M0, M1, M2, M3, SEL : std_logic_vector; 
	  SEL_ERROR : out std_logic;
	  MUX_OUT : out std_logic_vector);
  end component;

  component MUXBUS8 is
    generic (ENCODING : string := "");
    port (M0, M1, M2, M3, M4, M5, M6, M7, SEL : std_logic_vector; 
	  SEL_ERROR : out std_logic;
	  MUX_OUT : out std_logic_vector);
  end component;

  component PROM is
    generic ( MEMFILE : string := ""; 
	      DEPTH : natural := 0;
              ENCODING : string := "");
    port (ADDR : std_logic_vector; 
	  ADDR_ERROR : out std_logic;
	  D_OUT : out std_logic_vector);
  end component;

  component SHIFT is
    generic (ASYNC_VAL, SYNC_VAL : std_logic_vector := "";
	     STYLE : string := ""; -- "logical" , "circular", or "arith"
             ENCODING : string := "");
    port (PAR_IN : std_logic_vector := ""; 
	  CLOCK : std_logic;
	  LOAD, MS_IN, LS_IN, RIGHT_LEFT, ASYNC_CTRL, CLK_EN :std_logic := '1';
	  LS_OUT, MS_OUT : out std_logic;
	  PAR_OUT : out std_logic_vector);
  end component;

  component SRAM is
    generic ( DEPTH : natural := 0;
              ENCODING : string := "");
    port (D_IN, ADDR : std_logic_vector; 
	  WR_EN : std_logic;
	  ADDR_ERROR : out std_logic;
	  D_OUT : out std_logic_vector);
  end component;

  component TRISTATE is
    generic ( FLOAT_VAL : string;
              ENCODING : string := "");
    port (I : std_logic_vector; 
	  OE : std_logic;
	  O : out std_logic_vector);
  end component;

  -- Metamor synthesis attribute
  attribute macrocell : boolean;
  attribute macrocell of ANDBUS, ANDBUS1, ANDBUS2, INVBUS,
       ORBUS, ORBUS1, ORBUS2, XORBUS, XORBUS1, XORBUS2,
       ACCUM, ADD_SUB, CLK_DIV, COMPARE, COUNTER, DATA_REG,
       DECODE, INC_DEC, MUXBUS, MUXBUS2, MUXBUS4, MUXBUS8,
       PROM, SHIFT, SRAM, TRISTATE : component is true;

end macros;

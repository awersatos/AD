-- $Header
--
--  Copyright(C) 2007 by Xilinx, Inc. All rights reserved.
--  This text/file contains proprietary, confidential
--  information of Xilinx, Inc., is distributed under license
--  from Xilinx, Inc., and may be used, copied and/or
--  disclosed only pursuant to the terms of a valid license
--  agreement with Xilinx, Inc.  Xilinx hereby grants you
--  a license to use this text/file solely for design, simulation,
--  implementation and creation of design files limited
--  to Xilinx devices or technologies. Use with non-Xilinx
--  devices or technologies is expressly prohibited and
--  immediately terminates your license unless covered by
--  a separate agreement.
--
--  Xilinx is providing this design, code, or information
--  "as is" solely for use in developing programs and
--  solutions for Xilinx devices.  By providing this design,
--  code, or information as one possible implementation of
--  this feature, application or standard, Xilinx is making no
--  representation that this implementation is free from any
--  claims of infringement.  You are responsible for
--  obtaining any rights you may require for your implementation.
--  Xilinx expressly disclaims any warranty whatsoever with
--  respect to the adequacy of the implementation, including
--  but not limited to any warranties or representations that this
--  implementation is free from claims of infringement, implied
--  warranties of merchantability or fitness for a particular
--  purpose.
--
--  Xilinx products are not intended for use in life support
--  appliances, devices, or systems. Use in such applications are
--  expressly prohibited.
--
--  This copyright and support notice must be retained as part
--  of this text at all times. (c) Copyright 2007 Xilinx, Inc.
--  All rights reserved.

library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all;

package div_gen_hdl_pkg_v2_0 is

  --core_if on component div_gen_synth
  component div_gen_synth
    generic (
      C_VERBOSITY         : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE        : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY     : string  := "virtex4";
      C_HAS_SCLR          : integer := 0;
      C_HAS_CE            : integer := 0;
      C_CE_OVERRIDES_SCLR : integer := 0;
      C_LATENCY           : integer := 1;
      ALGORITHM_TYPE      : integer := 1;          -- 0=auto, 1=sdiv, 2=repmult
      DIVISOR_WIDTH       : integer := 16;
      DIVIDEND_WIDTH      : integer := 16;
      SIGNED_B            : integer := 0;          -- 0=unsigned, 1=signed
      DIVCLK_SEL          : integer := 1;          -- divisions per clock cycle
      FRACTIONAL_B        : integer := 0;
      FRACTIONAL_WIDTH    : integer := 16;
      C_HAS_DIV_BY_ZERO   : integer := 0
      );
    port (
      CLK            : in  std_logic                                     := '1';
      CE             : in  std_logic                                     := '1';
      SCLR           : in  std_logic                                     := '0';
      ND             : in  std_logic                                     := '0';
      RDY            : out std_logic                                     := '0';
      RFD            : out std_logic                                     := '0';
      DIVIDEND       : in  std_logic_vector(DIVIDEND_WIDTH-1 downto 0)   := (others => '0');
      DIVISOR        : in  std_logic_vector(DIVISOR_WIDTH-1 downto 0)    := (others => '0');
      QUOTIENT       : out std_logic_vector(DIVIDEND_WIDTH-1 downto 0)   := (others => '0');
      FRACTIONAL     : out std_logic_vector(FRACTIONAL_WIDTH-1 downto 0) := (others => '0');
      DIVIDE_BY_ZERO : out std_logic                                     := '0'
      );
  end component;
  --core_if off

  --core_if on component div_gen_behv
  component div_gen_behv
    generic (
      C_VERBOSITY         : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE        : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY     : string  := "virtex4";
      C_HAS_SCLR          : integer := 0;
      C_HAS_CE            : integer := 0;
      C_CE_OVERRIDES_SCLR : integer := 0;
      C_LATENCY           : integer := 1;
      ALGORITHM_TYPE      : integer := 1;          -- 0=auto, 1=sdiv, 2=repmult
      DIVISOR_WIDTH       : integer := 16;
      DIVIDEND_WIDTH      : integer := 16;
      SIGNED_B            : integer := 0;          -- 0=unsigned, 1=signed
      DIVCLK_SEL          : integer := 1;          -- divisions per clock cycle
      FRACTIONAL_B        : integer := 0;
      FRACTIONAL_WIDTH    : integer := 16;
      C_HAS_DIV_BY_ZERO   : integer := 0
      );
    port (
      CLK            : in  std_logic                                     := '1';
      CE             : in  std_logic                                     := '1';
      SCLR           : in  std_logic                                     := '0';
      ND             : in  std_logic                                     := '0';
      RDY            : out std_logic                                     := '0';
      RFD            : out std_logic                                     := '0';
      DIVIDEND       : in  std_logic_vector(DIVIDEND_WIDTH-1 downto 0)   := (others => '0');
      DIVISOR        : in  std_logic_vector(DIVISOR_WIDTH-1 downto 0)    := (others => '0');
      QUOTIENT       : out std_logic_vector(DIVIDEND_WIDTH-1 downto 0)   := (others => '0');
      FRACTIONAL     : out std_logic_vector(FRACTIONAL_WIDTH-1 downto 0) := (others => '0');
      DIVIDE_BY_ZERO : out std_logic                                     := '0'
      );
  end component;
  --core_if off

  --poor man's enumerated type for c_algorithm
  constant cval_algo_auto    : integer := 0;
  constant cval_algo_rad2    : integer := 1;
  constant cval_algo_repmult : integer := 2;
  constant cval_algo_hrdiv   : integer := 3;
  constant cval_algo_last    : integer := cval_algo_hrdiv;

  --poor man's enumerated type for c_opt_goal
  constant cval_optgoal_auto    : integer := 0;
  constant cval_optgoal_speed   : integer := 1;
  constant cval_optgoal_area    : integer := 2;
  constant cval_optgoal_latency : integer := 3;
  constant cval_optgoal_last    : integer := cval_optgoal_latency;

  --poor man's enumerated type for c_div_per_clk
  constant cval_divclk_1   : integer := 1;
  constant cval_divclk_2   : integer := 2;
  constant cval_divclk_4   : integer := 4;
  constant cval_divclk_8   : integer := 8;
  constant cval_divclk_max : integer := 8;

  --poor man's enumerated type for c_operand_type
  constant cval_optype_auto  : integer := 0;
  constant cval_optype_int   : integer := 1;
  constant cval_optype_mant  : integer := 2;
  constant cval_optype_last  : integer := cval_optype_mant;
    
  constant c_rad2_max_width    : integer := 32;
  constant c_repmult_max_width : integer := 64;
  constant c_ram_width         : integer := 10;
  
  type t_enum_algorithm    is (enum_rad2_nonrestore, enum_repmult, enum_hrdiv);
--  type t_enum_operand_type is (enum_optype_int, enum_optype_mant);

  function fn_choose_algo (
    p_algorithm         : integer
    )
    return t_enum_algorithm;


--  function fn_bias (
--    p_bias  : integer;
--    p_width : integer)
--    return integer;
--
--  function fn_mantissa_width (
--    p_mantissa_width : integer)
--    return integer;
--
--  function fn_choose_operand_type (
--    p_algorithm : t_enum_algorithm;
--    p_optype    : integer)
--    return t_enum_operand_type;
  
end package div_gen_hdl_pkg_v2_0;

package body div_gen_hdl_pkg_v2_0 is

  -----------------------------------------------------------------------------
  -- Chose algorithm to implement 
  -----------------------------------------------------------------------------
  function fn_choose_algo (
    p_algorithm : integer
    )
    return t_enum_algorithm is
  begin
    case p_algorithm is
      --When auto, Pick an algorithm according to other generic choices.
      --Explicit choices. Do what the user asks
      when cval_algo_rad2    => return enum_rad2_nonrestore;  
      when cval_algo_repmult => return enum_repmult;
      when cval_algo_hrdiv   => return enum_hrdiv;

      --there should be no other choices, so flag error.
      when others =>
        assert false report "ERROR: Unrecognised algorithm_type value "&INTEGER'IMAGE(p_algorithm) severity FAILURE;
        return enum_hrdiv;  --keep compiler happy that all cases return something.
    end case;
  end fn_choose_algo;

    
    

-------------------------------------------------------------------------------
-- Code below this point is retained in case repmult is reinstated.
-------------------------------------------------------------------------------
  
--  --bias is whatever the user wants if it's positive. -1 means use midpoint.
--  function fn_bias (
--    p_bias  : integer;
--    p_width : integer)
--    return integer is
--  begin
--    if p_bias >= 0 then
--      return p_bias;
--    else
--      return 2**(p_width -1)-1;
--    end if;
--  end fn_bias;


--  function fn_mantissa_width (
--    p_mantissa_width : integer)
--    return integer is
--  begin
--    if p_mantissa_width >8 then
--      return p_mantissa_width;
--    else
--      return 9;
--    end if;
--  end fn_mantissa_width;

--  function fn_choose_operand_type (
--    p_algorithm : t_enum_algorithm;
--    p_optype    : integer)
--    return t_enum_operand_type is
--  begin
--    case p_optype is
--      when cval_optype_auto =>
--        case p_algorithm is
--          when enum_rad2_nonrestore => return enum_optype_int;
--          when enum_repmult         => return enum_optype_mant;
--          when others               => return enum_optype_mant;
--        end case;
--      when cval_optype_int  => return enum_optype_int;
--      when cval_optype_mant => return enum_optype_mant;                       
--      when others =>
--        assert false
--          report "Error: Unrecognised optype in fn_choose_operand_type"
--          severity ERROR;
--        return enum_optype_mant;
--    end case;
--  end fn_choose_operand_type;

end package body div_gen_hdl_pkg_v2_0;

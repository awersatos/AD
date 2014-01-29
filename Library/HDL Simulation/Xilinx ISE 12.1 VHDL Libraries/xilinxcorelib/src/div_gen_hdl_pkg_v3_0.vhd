-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 3.0
--  \   \        Filename: $RCSfile: div_gen_hdl_pkg_v3_0.vhd,v $
--  /   /        Date Last Modified: $Date: 2009/12/04 11:46:49 $
-- /___/   /\    Date Created: 2007
-- \   \  /  \
--  \___\/\___\
--
-- Device  : All
-- Library : div_gen_v3_0
-- Purpose : HDL package for behavioral model
-------------------------------------------------------------------------------
--  (c) Copyright 2007, 2009 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES. 
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;

package div_gen_hdl_pkg_v3_0 is

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
  
end package div_gen_hdl_pkg_v3_0;

package body div_gen_hdl_pkg_v3_0 is

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

end package body div_gen_hdl_pkg_v3_0;

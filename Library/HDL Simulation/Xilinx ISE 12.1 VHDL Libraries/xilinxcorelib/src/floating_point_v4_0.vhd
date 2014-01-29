-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version: 4.0
--  \   \        Filename: $RCSfile: floating_point_v4_0.vhd,v $           
--  /   /        Date Last Modified: $Date: 2008/09/09 20:27:09 $ 
-- /___/   /\    Date Created: Dec 2005
-- \   \  /  \
--  \___\/\___\
-- 
--Device  : All
--Library : xilinxcorelib
--Purpose : Floating-point operator entity
--
--------------------------------------------------------------------------------    
-- DISCLAIMER OF LIABILITY
-- 
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you 
-- a license to use this text/file solely for design, simulation, 
-- implementation and creation of design files limited 
-- to Xilinx devices or technologies. Use with non-Xilinx 
-- devices or technologies is expressly prohibited and 
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information 
-- "as is" solely for use in developing programs and 
-- solutions for Xilinx devices. By providing this design, 
-- code, or information as one possible implementation of 
-- this feature, application or standard, Xilinx is making no 
-- representation that this implementation is free from any 
-- claims of infringement. You are responsible for 
-- obtaining any rights you may require for your implementation. 
-- Xilinx expressly disclaims any warranty whatsoever with 
-- respect to the adequacy of the implementation, including 
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied 
-- warranties of merchantability or fitness for a particular 
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
-- 
--
-- Copyright (c) 2005, 2006, 2007, 2008 Xilinx, Inc. All rights reserved.
--
-- This copyright and support notice must be retained as part 
-- of this text at all times.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- use local definitions
library xilinxcorelib;
use xilinxcorelib.floating_point_v4_0_consts.all;
use xilinxcorelib.floating_point_v4_0_xst_comp.all;

entity floating_point_v4_0 is
  generic (
    C_XDEVICEFAMILY         : string  := C_FAMILY_DEFAULT;
    C_HAS_ADD               : integer := C_HAS_ADD_DEFAULT;
    C_HAS_SUBTRACT          : integer := C_HAS_SUBTRACT_DEFAULT;
    C_HAS_MULTIPLY          : integer := C_HAS_MULTIPLY_DEFAULT;
    C_HAS_DIVIDE            : integer := C_HAS_DIVIDE_DEFAULT;
    C_HAS_SQRT              : integer := C_HAS_SQRT_DEFAULT;
    C_HAS_COMPARE           : integer := C_HAS_COMPARE_DEFAULT;
    C_HAS_FIX_TO_FLT        : integer := C_HAS_FIX_TO_FLT_DEFAULT;
    C_HAS_FLT_TO_FIX        : integer := C_HAS_FLT_TO_FIX_DEFAULT;
    C_HAS_FLT_TO_FLT        : integer := C_HAS_FLT_TO_FLT_DEFAULT; 
    C_A_WIDTH               : integer := C_A_WIDTH_DEFAULT;
    C_A_FRACTION_WIDTH      : integer := C_A_FRACTION_WIDTH_DEFAULT;
    C_B_WIDTH               : integer := C_B_WIDTH_DEFAULT;
    C_B_FRACTION_WIDTH      : integer := C_B_FRACTION_WIDTH_DEFAULT;
    C_RESULT_WIDTH          : integer := C_RESULT_WIDTH_DEFAULT;
    C_RESULT_FRACTION_WIDTH : integer := C_RESULT_FRACTION_WIDTH_DEFAULT;
    C_COMPARE_OPERATION     : integer := C_COMPARE_OPERATION_DEFAULT;   
    C_LATENCY               : integer := C_LATENCY_DEFAULT;
    C_OPTIMIZATION          : integer := C_OPTIMIZATION_DEFAULT;
    C_MULT_USAGE            : integer := C_MULT_USAGE_DEFAULT;
    C_RATE                  : integer := C_RATE_DEFAULT;
    C_HAS_ACLR              : integer := C_HAS_ACLR_DEFAULT;
    C_HAS_CE                : integer := C_HAS_CE_DEFAULT;
    C_HAS_SCLR              : integer := C_HAS_SCLR_DEFAULT;
    C_HAS_A_NEGATE          : integer := C_HAS_A_NEGATE_DEFAULT;
    C_HAS_B_NEGATE          : integer := C_HAS_B_NEGATE_DEFAULT;   
    C_HAS_A_ND              : integer := C_HAS_A_ND_DEFAULT;
    C_HAS_A_RFD             : integer := C_HAS_A_RFD_DEFAULT;
    C_HAS_B_ND              : integer := C_HAS_B_ND_DEFAULT;
    C_HAS_B_RFD             : integer := C_HAS_B_RFD_DEFAULT;          
    C_HAS_OPERATION_ND      : integer := C_HAS_OPERATION_ND_DEFAULT;
    C_HAS_OPERATION_RFD     : integer := C_HAS_OPERATION_RFD_DEFAULT; 
    C_HAS_RDY               : integer := C_HAS_RDY_DEFAULT;
    C_HAS_CTS               : integer := C_HAS_CTS_DEFAULT;
    C_HAS_UNDERFLOW         : integer := C_HAS_UNDERFLOW_DEFAULT;
    C_HAS_OVERFLOW          : integer := C_HAS_OVERFLOW_DEFAULT;
    C_HAS_INVALID_OP        : integer := C_HAS_INVALID_OP_DEFAULT;
    C_HAS_INEXACT           : integer := C_HAS_INEXACT_DEFAULT;
    C_HAS_DIVIDE_BY_ZERO    : integer := C_HAS_DIVIDE_BY_ZERO_DEFAULT;
    C_HAS_STATUS            : integer := C_HAS_STATUS_DEFAULT;
    C_HAS_EXCEPTION         : integer := C_HAS_EXCEPTION_DEFAULT;
    C_STATUS_EARLY          : integer := C_STATUS_EARLY_DEFAULT;
    C_SPEED                 : integer := C_SPEED_DEFAULT
  );
  port (
    A                       : in std_logic_vector(C_A_WIDTH-1 downto 0);
    B                       : in std_logic_vector(C_B_WIDTH-1 downto 0):=(others=>'0');
    A_NEGATE                : in std_logic:='0';
    B_NEGATE                : in std_logic:='0';
    OPERATION               : in std_logic_vector(FLT_PT_OPERATION_WIDTH-1 downto 0):=(others=>'0');
    A_ND                    : in std_logic:='1';
    A_RFD                   : out std_logic;
    B_ND                    : in std_logic:='1';
    B_RFD                   : out std_logic;
    OPERATION_ND            : in std_logic:='1';
    OPERATION_RFD           : out std_logic;
    CLK                     : in std_logic;
    SCLR                    : in std_logic:='0';
    ACLR                    : in std_logic:='0';
    CE                      : in std_logic:='1';
    RESULT                  : out std_logic_vector(C_RESULT_WIDTH-1 downto 0);
    STATUS                  : out std_logic_vector(FLT_PT_STATUS_WIDTH-1 downto 0);
    EXCEPTION               : out std_logic;
    UNDERFLOW               : out std_logic;
    OVERFLOW                : out std_logic;
    INVALID_OP              : out std_logic;
    INEXACT                 : out std_logic;
    DIVIDE_BY_ZERO          : out std_logic;
    RDY                     : out std_logic;
    CTS                     : in std_logic:='1'
    );
end floating_point_v4_0;

architecture behavioral of floating_point_v4_0 is

begin

  op_inst : floating_point_v4_0_xst
    generic map (
      C_XDEVICEFAMILY         => C_XDEVICEFAMILY,
      C_HAS_ADD               => C_HAS_ADD,
      C_HAS_SUBTRACT          => C_HAS_SUBTRACT,
      C_HAS_MULTIPLY          => C_HAS_MULTIPLY,
      C_HAS_DIVIDE            => C_HAS_DIVIDE, 
      C_HAS_SQRT              => C_HAS_SQRT,
      C_HAS_COMPARE           => C_HAS_COMPARE,
      C_HAS_FIX_TO_FLT        => C_HAS_FIX_TO_FLT,
      C_HAS_FLT_TO_FIX        => C_HAS_FLT_TO_FIX,
      C_HAS_FLT_TO_FLT        => C_HAS_FLT_TO_FLT,     
      C_A_WIDTH               => C_A_WIDTH,
      C_A_FRACTION_WIDTH      => C_A_FRACTION_WIDTH,
      C_B_WIDTH               => C_B_WIDTH,
      C_B_FRACTION_WIDTH      => C_B_FRACTION_WIDTH,
      C_RESULT_WIDTH          => C_RESULT_WIDTH,
      C_RESULT_FRACTION_WIDTH => C_RESULT_FRACTION_WIDTH,
      C_COMPARE_OPERATION     => C_COMPARE_OPERATION,
      C_LATENCY               => C_LATENCY,
      C_OPTIMIZATION          => C_OPTIMIZATION,
      C_MULT_USAGE            => C_MULT_USAGE,
      C_RATE                  => C_RATE,
      C_HAS_ACLR              => C_HAS_ACLR,
      C_HAS_CE                => C_HAS_CE,
      C_HAS_SCLR              => C_HAS_SCLR,
      C_HAS_A_NEGATE          => C_HAS_A_NEGATE,
      C_HAS_B_NEGATE          => C_HAS_B_NEGATE,
      C_HAS_A_ND              => C_HAS_A_RFD,
      C_HAS_A_RFD             => C_HAS_A_RFD,
      C_HAS_B_ND              => C_HAS_B_ND,
      C_HAS_B_RFD             => C_HAS_B_RFD,         
      C_HAS_OPERATION_ND      => C_HAS_OPERATION_ND,
      C_HAS_OPERATION_RFD     => C_HAS_OPERATION_RFD,
      C_HAS_RDY               => C_HAS_RDY,
      C_HAS_CTS               => C_HAS_CTS,
      C_HAS_UNDERFLOW         => C_HAS_UNDERFLOW,
      C_HAS_OVERFLOW          => C_HAS_OVERFLOW,
      C_HAS_INVALID_OP        => C_HAS_INVALID_OP,
      C_HAS_INEXACT           => C_HAS_INEXACT,
      C_HAS_DIVIDE_BY_ZERO    => C_HAS_DIVIDE_BY_ZERO,
      C_HAS_STATUS            => C_HAS_STATUS,
      C_HAS_EXCEPTION         => C_HAS_EXCEPTION,
      C_STATUS_EARLY          => C_STATUS_EARLY,
      C_SPEED                 => C_SPEED
    )
    port map (
      CLK                     => CLK,
      SCLR                    => SCLR,
      ACLR                    => ACLR,
      CE                      => CE,
      A                       => A,
      B                       => B,
      A_NEGATE                => A_NEGATE,
      B_NEGATE                => B_NEGATE,
      OPERATION               => OPERATION,
      A_ND                    => A_ND,
      B_ND                    => B_ND,
      OPERATION_ND            => OPERATION_ND,
      CTS                     => CTS,
      A_RFD                   => A_RFD,
      B_RFD                   => B_RFD,
      OPERATION_RFD           => OPERATION_RFD,
      RESULT                  => RESULT,
      STATUS                  => STATUS,
      EXCEPTION               => EXCEPTION,
      UNDERFLOW               => UNDERFLOW,
      OVERFLOW                => OVERFLOW,
      INVALID_OP              => INVALID_OP,
      INEXACT                 => INEXACT,
      DIVIDE_BY_ZERO          => DIVIDE_BY_ZERO,
      RDY                     => RDY
      );
end behavioral;





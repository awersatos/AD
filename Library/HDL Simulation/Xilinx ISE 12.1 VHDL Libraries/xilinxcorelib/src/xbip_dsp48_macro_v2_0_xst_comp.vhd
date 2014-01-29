-- $RCSfile $ $Date: 2009/12/04 11:46:21 $ $Revision: 1.3 $
--
--  Copyright(C) 2008 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 2008 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Component statement for wrapper of behavioural model
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all; 
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all; 


package xbip_dsp48_macro_v2_0_xst_comp is

----------------------------------------------------------
-- Insert component declaration of top level xst file here
----------------------------------------------------------
  --core_if on component xbip_dsp48_macro_v2_0_xst
  component xbip_dsp48_macro_v2_0_xst
    generic (
      C_VERBOSITY        : integer := 0  ;                                 -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE       : integer := 0  ;                                 -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY    : string  := "virtex5";
      C_HAS_CE           : integer := 0;
      C_HAS_SCLR         : integer := 0;
      C_HAS_CARRYCASCIN  : integer := 0;
      C_HAS_CARRYIN      : integer := 0;
      C_HAS_ACIN         : integer := 0;
      C_HAS_BCIN         : integer := 0;
      C_HAS_PCIN         : integer := 0;
      C_HAS_A            : integer := 1;
      C_HAS_B            : integer := 1;
      C_HAS_D            : integer := 1;
      C_HAS_CONCAT       : integer := 0;
      C_HAS_C            : integer := 0;
      C_A_WIDTH          : integer := ci_dsp48_b_width ;                   -- can't use a function here.
      C_B_WIDTH          : integer := ci_dsp48_b_width;
      C_C_WIDTH          : integer := ci_dsp48_c_width;
      C_D_WIDTH          : integer := 0 ;                                  -- can't use a function here.
      C_CONCAT_WIDTH     : integer := 0;
      C_P_MSB            : integer := ci_dsp48_p_width-1  ;
      C_P_LSB            : integer := 0;
      C_SEL_WIDTH        : integer := 5;
      C_HAS_ACOUT        : integer := 0;
      C_HAS_BCOUT        : integer := 0;
      C_HAS_CARRYCASCOUT : integer := 0;
      C_HAS_CARRYOUT     : integer := 0;
      C_HAS_PCOUT        : integer := 0;
      C_CONSTANT_1       : integer := 1;
      C_LATENCY          : integer := -1;
      C_OPMODES          : string  := "";
      C_REG_CONFIG       : string  := "00000000000000000000000000000000";
      C_TEST_CORE        : integer := 0                                    --  0 = normal releas core behavour 1 = generate a test core
      );
    port (
      CLK          : in  std_logic                                                           := '1';
      CE           : in  std_logic                                                           := '1';
      SCLR         : in  std_logic                                                           := '0';
      SEL          : in  std_logic_vector(C_SEL_WIDTH+boolean'pos(C_SEL_WIDTH=0)-1 downto 0) := (others => '0');  -- Guard against -1 to 0 when C_SEL_WIDTH=0
      CARRYCASCIN  : in  std_logic                                                           := '0';
      CARRYIN      : in  std_logic                                                           := '0';
      PCIN         : in  std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0');
      ACIN         : in  std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)      := (others => '0');
      BCIN         : in  std_logic_vector(ci_dsp48_b_width-1 downto 0)                       := (others => '0');
      A            : in  std_logic_vector(C_A_WIDTH-1 downto 0)                              := (others => '0');
      B            : in  std_logic_vector(C_B_WIDTH-1 downto 0)                              := (others => '0');
      C            : in  std_logic_vector(C_C_WIDTH-1 downto 0)                              := (others => '0');
      D            : in  std_logic_vector(C_D_WIDTH-1 downto 0)                              := (others => '0');
      CONCAT       : in  std_logic_vector(C_CONCAT_WIDTH-1 downto 0)                         := (others => '0');
      ACOUT        : out std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)      := (others => '0');
      BCOUT        : out std_logic_vector(ci_dsp48_b_width-1 downto 0)                       := (others => '0');
      CARRYOUT     : out std_logic                                                           := '0';
      CARRYCASCOUT : out std_logic                                                           := '0';
      PCOUT        : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0');
      P            : out std_logic_vector(C_P_MSB-C_P_LSB downto 0)                          := (others => '0')
      );
  --core_if off
  END COMPONENT;


end xbip_dsp48_macro_v2_0_xst_comp;


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
---------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all; 
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all; 
use xilinxcorelib.xbip_dsp48_multadd_v1_0_comp.all;   

entity xbip_dsp48_multadd_v1_0_xst is
  generic (
    C_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
    C_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
    C_XDEVICEFAMILY   : string  := "virtex4";
    C_LATENCY         : integer := -1;
    C_USE_PCIN        : integer := 0;
    C_USE_ACIN        : integer := 0;
    C_USE_BCIN        : integer := 0
    );
  port (
    CLK          : in  std_logic                                                      := '1';
    CE           : in  std_logic                                                      := '1';
    SCLR         : in  std_logic                                                      := '0';
    SUBTRACT     : in  std_logic                                                      := '0';
    CARRYIN      : in  std_logic                                                      := '0';
    PCIN         : in  std_logic_vector(ci_dsp48_p_width-1 downto 0)                  := (others => '0');
    ACIN         : in  std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
    BCIN         : in  std_logic_vector(ci_dsp48_b_width-1 downto 0)                  := (others => '0');
    A            : in  std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
    B            : in  std_logic_vector(ci_dsp48_b_width-1 downto 0)                  := (others => '0');
    C            : in  std_logic_vector(ci_dsp48_c_width-1 downto 0)                  := (others => '0');
    ACOUT        : out std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
    BCOUT        : out std_logic_vector(ci_dsp48_b_width-1 downto 0)                  := (others => '0');
    CARRYOUT     : out std_logic                                                      := '0';
    PCOUT        : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                  := (others => '0');
    P            : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                  := (others => '0')
    );
end xbip_dsp48_multadd_v1_0_xst;

architecture behavioral of xbip_dsp48_multadd_v1_0_xst is

begin  -- architecture behavioral

  i_behv : xbip_dsp48_multadd_v1_0
    generic map (
      C_VERBOSITY       => C_VERBOSITY,
      C_MODEL_TYPE      => C_MODEL_TYPE,
      C_XDEVICEFAMILY   => C_XDEVICEFAMILY,
      C_LATENCY         => C_LATENCY,
      C_USE_PCIN        => C_USE_PCIN,
      C_USE_ACIN        => C_USE_ACIN,
      C_USE_BCIN        => C_USE_BCIN
      )
    port map (
      CLK          => CLK,
      CE           => CE,
      SCLR         => SCLR,
      SUBTRACT     => SUBTRACT,
      CARRYIN      => CARRYIN,
      PCIN         => PCIN,
      ACIN         => ACIN,
      BCIN         => BCIN,
      A            => A,
      B            => B,
      C            => C,
      ACOUT        => ACOUT,
      BCOUT        => BCOUT,
      CARRYOUT     => CARRYOUT,
      PCOUT        => PCOUT,
      P            => P
      );  

end architecture behavioral;

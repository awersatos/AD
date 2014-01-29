
-- $RCSfile: xbip_addsub_v1_0.vhd,v $
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
--
-------------------------------------------------------------------------------
-- Behavioural Model
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xilinxcorelib;
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all;
use xilinxcorelib.xbip_dsp48_addsub_v1_0_comp.all;

--core_if on entity xbip_addsub_v1_0
entity xbip_addsub_v1_0 is
  generic (
    C_XDEVICEFAMILY     : string  := "no_family";
    C_LATENCY           : integer := -1;
    C_A_WIDTH           : integer := 16;
    C_B_WIDTH           : integer := 16;
    C_OUT_WIDTH         : integer := 16;
--	    C_BYPASS_LOW        : integer := 0;
	C_CE_OVERRIDES_SCLR : integer := 0;
    C_VERBOSITY         : integer := 0;  -- 0 = Errors  1 = +Warnings, 2 = +Notes and tips
    C_MODEL_TYPE        : integer := 0;  -- 0 = synth,  1 = RTL
    C_DATA_TYPE         : integer := 0  -- 0 = signed, 1 = unsigned.
    );
  port (
    CLK    : in  std_logic                                := '1';
    CE     : in  std_logic                                := '1';
    SCLR   : in  std_logic                                := '0';
    ADDF    : in  std_logic                                := '0';
    BYPASS : in  std_logic                                := '0';
    C_IN   : in  std_logic                                := '0';
    A      : in  std_logic_vector(C_A_WIDTH-1 downto 0)   := (others => '0');
    B      : in  std_logic_vector(C_B_WIDTH-1 downto 0)   := (others => '0');
    Q      : out std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0')
    );
--core_if off
end xbip_addsub_v1_0;


architecture behavioral of xbip_addsub_v1_0 is

  function check_generics(P_XDEVICEFAMILY : string;
                          P_LATENCY,
                          P_A_WIDTH,
                          P_B_WIDTH,
                          P_OUT_WIDTH,
                          P_CE_OVERRIDES_SCLR,
                          P_VERBOSITY,
                          P_MODEL_TYPE,
                          P_DATA_TYPE     : integer) return boolean is
  begin  -- function check_generics
    if P_B_WIDTH > fn_dsp48_concat_width(P_XDEVICEFAMILY) then
      report "ERROR: xbip_addsub_v1_0: C_B_WIDTH must be <= " & integer'image(fn_dsp48_concat_width(P_XDEVICEFAMILY)) severity error;
    end if;

	--bi goes to the ABCONCAT port in DSP48 and and ai goes to the C port (C port is 48 bits in all DSP48s)

--    if P_B_WIDTH > fn_dsp48_concat_width(P_XDEVICEFAMILY) then
--      report "ERROR: xbip_addsub_v1_0: C_B_WIDTH must be <= " & integer'image(fn_dsp48_concat_width(P_XDEVICEFAMILY)) severity error;
--    end if;

--	 if P_A_WIDTH > 48 then
--      report "ERROR: xbip_addsub_v1_0: C_B_WIDTH must be <= "48 severity error;
--    end if;

    -- need more checks! - at least C_OUT_WIDTH, C_CE_OVERRIDES_SCLR,
    -- C_DATA_TYPE, C_LATENCY
    return true;
  end function check_generics;

  constant verify_generics : boolean := check_generics(C_XDEVICEFAMILY, C_LATENCY, C_A_WIDTH, C_B_WIDTH, C_OUT_WIDTH, C_CE_OVERRIDES_SCLR, C_VERBOSITY, C_MODEL_TYPE, C_DATA_TYPE);

--  constant use_usecase : boolean := (C_B_WIDTH <= fn_dsp48_concat_width(C_XDEVICEFAMILY) and C_B_WIDTH <= fn_dsp48_concat_width(C_XDEVICEFAMILY));
    constant use_usecase : boolean := (C_B_WIDTH <= fn_dsp48_concat_width(C_XDEVICEFAMILY));
 
--  signal bypass_f : std_logic ;
--  signal sclr_i : std_logic := '0';
--  signal sclr_i : std_logic;
--  signal subtract_i : std_logic;
--  signal c_in_i : std_logic;

begin
--  bypass_active_high: if C_BYPASS_LOW = 0 generate
--    bypass_f <= not(bypass);
--  end generate bypass_active_high;
--  bypass_active_low: if C_BYPASS_LOW = 1 generate
--    bypass_f <= bypass;
--  end generate bypass_active_low;
--  -- needed so that when you load in during a subtraction you don't load in the negative of the b input.
----   turn the DSP48 to an add during the load.
--   subtract_i <= ADDF and bypass_f;  --only time a subtract happens is when ADDF = 1 (opposite sense, remember) and bypass_f = 1 (No bypass);  otherwise add
---- gate out carry in during bypass
 --  c_in_i <= C_IN and bypass_f;  --only time C_IN is when C_IN is 1 and No Bypass; otherwise no C_IN 
----   signal sclr_i : std_logic := '0';
--begin
--problem sith override cktry
--    sclr_i <= SCLR when C_CE_OVERRIDES_SCLR=0 else (SCLR and CE);

  addsub_usecase : if use_usecase generate
    signal ai : std_logic_vector(ci_dsp48_c_width-1 downto 0)                       := (others => '0');
    signal bi : std_logic_vector(fn_dsp48_concat_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
    signal qi : std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0');
  begin

    data_signed : if C_DATA_TYPE = 0 generate
      ai <= std_logic_vector(resize(signed(A), ai'length));
      bi <= std_logic_vector(resize(signed(B), bi'length));
--      Q  <= std_logic_vector(resize(signed(qi), Q'length));
	  Q <= qi(c_out_width - 1 downto 0);
    end generate data_signed;
    data_unsigned : if C_DATA_TYPE = 1 generate
      ai <= std_logic_vector(resize(unsigned(A), ai'length));
      bi <= std_logic_vector(resize(unsigned(B), bi'length));
--      Q  <= std_logic_vector(resize(unsigned(qi), Q'length));
	  Q <= qi(c_out_width - 1 downto 0);
    end generate data_unsigned;

    i_addsub : xbip_dsp48_addsub_v1_0
      generic map(
        C_VERBOSITY       => C_VERBOSITY,
        C_MODEL_TYPE      => C_MODEL_TYPE,
        C_XDEVICEFAMILY   => C_XDEVICEFAMILY,
        C_LATENCY         => C_LATENCY,
        C_USE_CARRYCASCIN => 0,
        C_USE_PCIN        => 0,
        C_USE_ACIN        => 0,
        C_USE_BCIN        => 0)
      port map(
        CLK          => CLK,
        CE           => CE,
        SCLR         => SCLR,
        SUBTRACT     => ADDF,
        BYPASS       => BYPASS,
        CARRYIN      => C_IN,
        CARRYCASCIN  => '0',
--      PCIN         => PCIN,
--      ACIN         => ACIN,
--      BCIN         => BCIN,
        ABCONCAT     => bi,
        C            => ai,
        PCOUT        => open,
        ACOUT        => open,
        BCOUT        => open,
        CARRYOUT     => open,
        CARRYCASCOUT => open,
        P            => qi);

  end generate addsub_usecase;

--  no_model : if not(use_usecase) generate
--    assert false report "ERROR: xbip_addsub_v1_0: no model in place" severity failure;
--  end generate no_model;
  
end behavioral;


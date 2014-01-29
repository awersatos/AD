
-- $Id: xbip_accum_v1_0.vhd,v 1.2 2008/09/10 09:45:17 akennedy Exp $
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
--  of this text at all times. (c) Copyright 1995-2008 Xilinx, Inc.
--  All rights reserved.
--
-------------------------------------------------------------------------------
-- Behavioural Model
-------------------------------------------------------------------------------
  
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_signed.ALL;
USE IEEE.numeric_std.ALL;

LIBRARY XilinxCoreLib;
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all;
use xilinxcorelib.bip_utils_pkg_v1_0.all;
use xilinxcorelib.xbip_dsp48_acc_v1_0_comp.all;
use xilinxcorelib.xbip_accum_v1_0_pkg.all;

--
--core_if on entity xbip_accum_v1_0
  entity xbip_accum_v1_0 is
    GENERIC (
      C_XDEVICEFAMILY       : STRING  := "no_family";
      C_IMPLEMENTATION      : INTEGER := 0;
      C_VERBOSITY           : integer := 0;
      C_LATENCY             : integer := 0;
      C_BYPASS_LOW          : integer := 0;
      C_B_WIDTH             : INTEGER := 16;
      C_OUT_WIDTH           : INTEGER := 16;
      C_CE_OVERRIDES_SCLR   : INTEGER := 0; --0=SYNC over CE, 1 = CE over SYNC
      C_DATA_TYPE           : INTEGER := 1 --0=signed, 1=unsigned;
      );
    PORT (
      B        : in  std_logic_vector(C_B_WIDTH-1 downto 0) := (others => '0');  -- input value
      CLK      : in  std_logic                              := '0';  -- clock
      ADDF     : in  std_logic                              := '1';
      C_IN     : in  std_logic                              := '0';  -- carry in
      CE       : in  std_logic                              := '1';  -- clock enable
      BYPASS   : in  std_logic                              := '0';  -- sync load of b into reg
      SCLR     : in  std_logic                              := '0';  -- synch init.
      Q        : out std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0')  -- synch output value
      );
--core_if off
END xbip_accum_v1_0;


ARCHITECTURE behavioral OF xbip_accum_v1_0 IS

  constant check_generics : integer := fn_xbip_accum_v1_0_check_generics(
    p_xdevicefamily  => C_XDEVICEFAMILY,
    p_implementation => C_IMPLEMENTATION,
    p_verbosity => C_VERBOSITY,
    p_latency => C_LATENCY,
    p_bypass_low => C_BYPASS_LOW,
    p_b_width => C_B_WIDTH,
    p_out_width => C_OUT_WIDTH,
    p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR,
    p_data_type => C_DATA_TYPE
    );
  constant ci_pipe_all : t_xbip_accum_v1_0_latency := fn_xbip_accum_v1_0_latency(
    p_xdevicefamily  => C_XDEVICEFAMILY,
    p_implementation => C_IMPLEMENTATION,
    p_verbosity => C_VERBOSITY,
    p_latency => C_LATENCY,
    p_bypass_low => C_BYPASS_LOW,
    p_b_width => C_B_WIDTH,
    p_out_width => C_OUT_WIDTH,
    p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR,
    p_data_type => C_DATA_TYPE
    );
  constant ci_resources : t_xbip_accum_v1_0_resources := fn_xbip_accum_v1_0_get_resources(
    p_xdevicefamily  => C_XDEVICEFAMILY,
    p_implementation => C_IMPLEMENTATION,
    p_verbosity => C_VERBOSITY,
    p_latency => C_LATENCY,
    p_bypass_low => C_BYPASS_LOW,
    p_b_width => C_B_WIDTH,
    p_out_width => C_OUT_WIDTH,
    p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR,
    p_data_type => C_DATA_TYPE
    );
 
  constant pipe_used : integer := ci_pipe_all.used;
  signal diag_pipe : t_xbip_accum_v1_0_latency := ci_pipe_all;
  signal diag_resources : t_xbip_accum_v1_0_resources := ci_resources;

  function fn_bypass_sense(
    p_bypass_low    : integer
    )
    return std_logic is
    variable ret_val : std_logic := '1';
  begin
    if (p_bypass_low = 0) then
      ret_val := '1';
      return ret_val;
    else
      ret_val := '0';
      return ret_val;
    end if;
  end function fn_bypass_sense;
 

  constant bypass_sense : std_logic := fn_bypass_sense(C_BYPASS_LOW);

  signal bypass_i : std_logic := '0';
  signal addf_i : std_logic := '0';
  signal c_in_i : std_logic := '0';
  signal sclr_i : std_logic := '0';
  signal b_i : std_logic_vector(C_B_WIDTH-1 downto 0) := (others => '0');
  signal q_i : std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0');
  signal b_i_ext : std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0');

BEGIN
  sclr_i <= SCLR when C_CE_OVERRIDES_SCLR=0 else (SCLR and CE);

  input_no_pipe: if pipe_used < 2 generate
    bypass_i <= bypass;
    addf_i <= ADDF;
    c_in_i <= C_IN;
    b_i <= B;
  end generate input_no_pipe;

  input_pipe: if pipe_used = 2 generate
    input_regs: process (clk)
    begin 
      if rising_edge(clk) then
        if sclr_i = '1' then
          bypass_i <= '0';
          addf_i <= '0';
          c_in_i <= '0';
          b_i <= (others => '0');
        elsif CE = '1' then
          bypass_i <= bypass;
          addf_i <= ADDF;
          c_in_i <= C_IN;
          b_i <= B;
        end if;
      end if;
    end process input_regs;
  end generate input_pipe;

  equal_widths: if (C_OUT_WIDTH = C_B_WIDTH) generate
    b_i_ext <= b_i;
  end generate equal_widths;
  resize_b: if (C_OUT_WIDTH > C_B_WIDTH) generate
    b_i_ext <= std_logic_vector(resize(signed(b_i),C_OUT_WIDTH)) when C_DATA_TYPE=c_signed else 
        std_logic_vector(resize(unsigned(b_i),C_OUT_WIDTH)); 
  end generate resize_b;

  accumulation: process (clk)
  begin 
    if rising_edge(clk) then
      if sclr_i = '1' then
        q_i <= (others => '0');
      elsif CE = '1' then
        if bypass_i = bypass_sense then 
          q_i <= b_i_ext; 
        else
          if addf_i = '0' then
            q_i <= q_i + (b_i_ext + c_in_i); 
          else 
            q_i <= q_i - (b_i_ext + c_in_i);
          end if;
        end if;
      end if;
    end if;
  end process accumulation;

  Q <= q_i;
END behavioral;

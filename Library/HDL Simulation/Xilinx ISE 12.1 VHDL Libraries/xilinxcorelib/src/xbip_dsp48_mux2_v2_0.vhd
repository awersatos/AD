-- $Header: /devl/xcs/repo/env/Databases/ip/src2/L/xbip_dsp48_mux2_v2_0/simulation/xbip_dsp48_mux2_v2_0.vhd,v 1.3 2009/09/08 16:46:35 akennedy Exp $
--
--  (c) Copyright 2008 Xilinx, Inc. All rights reserved.
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
---------------------------------------------------------------
-- This is the Behavioural model (aka 'pure RTL')
-- This model is not intended to be synthesized.
-- Its purpose is to verify the functionality of the other model(s)
-- It should be bit and cycle accurate.
-- The workings of this model need not take account of Xilinx primitives,
-- other than to match the behaviour of the other models. E.g
-- if the DSP48 and fabric variants of a core behave identically, the
-- behavioral model needs only one architecture and the C_USE_DSP48 generic
-- can be ignored.
---------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all; 
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all; 
use xilinxcorelib.xbip_pipe_v2_0_comp.all; 
use xilinxcorelib.bip_dsp48_mux2_pkg_v2_0.all;   

--core_if on entity bip_dsp48_mux2_v2_0
entity xbip_dsp48_mux2_v2_0 is
  generic (
    C_VERBOSITY     : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
    C_MODEL_TYPE    : integer := 0;          -- 0 = synth, 1 = RTL
    C_XDEVICEFAMILY : string  := "virtex4";
    C_LATENCY       : integer := -1
    );
  port (
    CLK   : in  std_logic                                                           := '1';
    CE    : in  std_logic                                                           := '1';
    SCLR  : in  std_logic                                                           := '0';
    SELA  : in  std_logic                                                           := '0';
    SELB  : in  std_logic                                                           := '0';
    X     : in  std_logic_vector(fn_dsp48_concat_width(C_XDEVICEFAMILY)-1 downto 0) := (others => '0');
    Z     : in  std_logic_vector(ci_dsp48_c_width-1 downto 0)                       := (others => '0');
    PCOUT : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0');
    P     : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0')
    );
end entity;
--core_if off

architecture behavioral of xbip_dsp48_mux2_v2_0 is

--  -- purpose: devolved checking of generics
--  function fn_local_check_generics (
--    p_model_type : integer)
--    return integer is
--  begin  -- local_check_generics
--    --C_MODEL_TYPE
--    assert p_model_type = 2
--      report "ERROR: xbip_dsp48_mux2_behv: BEHV model has been called with C_MODEL_TYPE set to something other than BEHV"
--      severity ERROR;
--    return 0;                           --keeps modelsim happy.
--  end fn_local_check_generics;
--  constant c_local_check_generics : integer := fn_local_check_generics(C_MODEL_TYPE);
  
  
  constant dsp48_mux2_latency : t_dsp48_mux2_latency := fn_dsp48_mux2_latency(
    P_LATENCY       => C_LATENCY,
    P_XDEVICEFAMILY => C_XDEVICEFAMILY
    );
  constant ci_pipe : t_dsp48_mux2_pipe := dsp48_mux2_latency.pipe;

  signal xmux   : std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
  signal zmux   : std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
  signal p_i    : std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
  signal preg   : std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
begin

  i_vx5: if supports_dsp48e(C_XDEVICEFAMILY)>0 or has_dsp48(C_XDEVICEFAMILY) generate
  begin
    xmux <= std_logic_vector(resize(signed(X),ci_dsp48_p_width));
    zmux <= Z;
    p_i <= xmux when sela = '1' else zmux;
  end generate i_vx5;

  i_sp3adsp_vx4: if supports_dsp48a(C_XDEVICEFAMILY)>0 generate
    xmux <= std_logic_vector(resize(signed(X),ci_dsp48_p_width)) when sela = '1' else (others => '0');
    zmux <= Z when selb = '1' else (others => '0');
    p_i <= zmux + xmux;
  end generate i_sp3adsp_vx4;
  
  i_p : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage3)+ci_pipe(ci_stage4),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => ci_dsp48_p_width
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D     => p_i,
      Q     => preg
      );

  P     <= preg;
  PCOUT <= preg;
end behavioral;

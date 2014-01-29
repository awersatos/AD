
-- $Id: xbip_dsp48_acc_v2_0.vhd,v 1.3 2009/09/08 16:46:31 akennedy Exp $
--
--  (c) Copyright 1995-2008 Xilinx, Inc. All rights reserved.
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
--
-------------------------------------------------------------------------------
-- Behavioural Model
-------------------------------------------------------------------------------
  
LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

LIBRARY XilinxCoreLib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;
use xilinxcorelib.xbip_pipe_v2_0_comp.all;
use xilinxcorelib.bip_dsp48_acc_pkg_v2_0.all;


-- (A)synchronous multi-input gate
--
--core_if on entity xbip_dsp48_acc_v2_0
  entity xbip_dsp48_acc_v2_0 is
    GENERIC (
      C_VERBOSITY       : integer := 0;          -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE      : integer := 0;          -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY   : string  := "virtex4";
      C_LATENCY         : integer := -1;
      C_HAS_SUBTRACT    : integer := 1;          -- see check generics for explanation
      C_USE_PCIN        : integer := 0;
      C_USE_CARRYCASCIN : integer := 0
      );
    PORT (
      CLK          : in  std_logic                                     := '1';
      CE           : in  std_logic                                     := '1';
      SCLR         : in  std_logic                                     := '0';
      CARRYIN      : in  std_logic                                     := '0';
      CARRYCASCIN  : in  std_logic                                     := '0';
      ACC_NLOAD    : in  std_logic                                     := '0';
      SUBTRACT     : in  std_logic                                     := '0';
      C            : in  std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0');
      PCIN         : in  std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
      CARRYOUT     : out std_logic                                     := '0';
      CARRYCASCOUT : out std_logic                                     := '0';
      PCOUT        : out std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0');
      P            : out std_logic_vector(ci_dsp48_p_width-1 downto 0) := (others => '0')
      );
--core_if off
END xbip_dsp48_acc_v2_0;


ARCHITECTURE behavioral OF xbip_dsp48_acc_v2_0 IS
--  -- purpose: devolved checking of generics
--  function fn_local_check_generics (
--    p_model_type : integer)
--    return integer is
--  begin  -- local_check_generics
--    --C_MODEL_TYPE
--    assert p_model_type = 2
--      report "ERROR: xbip_dsp48_acc_behv: BEHV model has been called with C_MODEL_TYPE set to something other than BEHV"
--      severity ERROR;
--    return 0;                           --keeps modelsim happy.
--  end fn_local_check_generics;
--  constant c_local_check_generics : integer := fn_local_check_generics(C_MODEL_TYPE);
  
  
  constant dsp48_acc_latency : t_dsp48_acc_latency := fn_dsp48_acc_latency(
    P_LATENCY       => C_LATENCY,
    P_XDEVICEFAMILY => C_XDEVICEFAMILY
    );
  constant ci_pipe : t_dsp48_acc_pipe := dsp48_acc_latency.pipe;

  signal carryin_i    : std_logic := '0';
  signal carryinreg   : std_logic := '0';
  signal subtract_i   : std_logic := '0';
  signal subtractreg  : std_logic := '0';
  signal acc_nloadreg : std_logic := '0';
  signal creg         : std_logic_vector(ci_dsp48_c_width-1 downto 0)                     := (others => '0');
  signal y_i          : std_logic_vector(ci_dsp48_p_width-1 downto 0)                     := (others => '0');
  signal z_i          : std_logic_vector(ci_dsp48_p_width-1 downto 0)                     := (others => '0');
  signal p_i          : std_logic_vector(ci_dsp48_p_width+1-1 downto 0)                     := (others => '0');
  signal preg         : std_logic_vector(ci_dsp48_p_width+1-1 downto 0)                       := (others => '0');
  signal carryout_i   : std_logic := '0';
  signal carryoutreg  : std_logic := '0';
begin
  i_sub: if C_HAS_SUBTRACT = 1 generate
    subtract_i <= SUBTRACT;
  end generate i_sub;
  i_carryin: if C_USE_CARRYCASCIN = 0 generate
    carryin_i <= CARRYIN;
  end generate i_carryin;
  i_carrycascin: if C_USE_CARRYCASCIN = 1 generate
    carryin_i <= CARRYCASCIN;
  end generate i_carrycascin;
  
  has_carryinreg : if C_USE_CARRYCASCIN = 0  or supports_dsp48a(C_XDEVICEFAMILY)>0 generate
    i_carryreg : xbip_pipe_v2_0
      generic map(
        C_LATENCY             => ci_pipe(ci_stage3),
        C_HAS_CE              => 1,
        C_HAS_SCLR            => 1,
        C_WIDTH               => 1
        )
      port map(
        CLK   => CLK,
        CE    => CE,
        SCLR  => SCLR,
        D(0)  => carryin_i,
        Q(0)  => carryinreg
        );
  end generate has_carryinreg;
  no_carryinreg : if C_USE_CARRYCASCIN = 1 and not(supports_dsp48a(C_XDEVICEFAMILY)>0) generate
    carryinreg <= carryin_i;
  end generate no_carryinreg;


  i_subreg : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage3),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => 1
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D(0)  => subtract_i,
      Q(0)  => subtractreg
      );
  i_loadreg : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage3),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => 1
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D(0)  => ACC_NLOAD,
      Q(0)  => acc_nloadreg
      );
  
  i_c : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage3),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => ci_dsp48_c_width
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D     => C,
      Q     => creg
      );

  i_usec: if C_USE_PCIN = 0 generate
    y_i <= creg;
  end generate i_usec;
  i_usepcin: if C_USE_PCIN = 1 generate
    y_i <= PCIN;
  end generate i_usepcin; 
  z_i <= preg(ci_dsp48_p_width-1 downto 0) when acc_nloadreg = '1' else
         (others => '0');
  --could create a ymux output to simplify the following equation
  --y = preg when acc_nload = 1, 0 when acc_nload = 0
  --p_i = z_i + y_i when subtract = 0 else z_i - y_i;
  --perform the operation!
  
  p_i <= ('0'&z_i) + (('0'&y_i) + carryinreg) when subtractreg = '0' else
         ('0'&z_i) - (('0'&y_i) + carryinreg);
  carryout_i <= p_i(p_i'LEFT) xor subtractreg;

  i_p : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage4),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => ci_dsp48_p_width+1
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D     => p_i,
      Q     => preg
      );
  
  i_carryout : xbip_pipe_v2_0
    generic map(
      C_LATENCY             => ci_pipe(ci_stage4),
      C_HAS_CE              => 1,
      C_HAS_SCLR            => 1,
      C_WIDTH               => 1
      )
    port map(
      CLK   => CLK,
      CE    => CE,
      SCLR  => SCLR,
      D(0)  => carryout_i,
      Q(0)  => carryoutreg
      );

  i_sp3adsp: if supports_dsp48a(C_XDEVICEFAMILY)>0 generate
    CARRYCASCOUT <= p_i(p_i'LEFT);
  end generate i_sp3adsp;
  i_vx5: if supports_dsp48e(C_XDEVICEFAMILY)>0 generate
    CARRYCASCOUT <= preg(preg'LEFT);
    CARRYOUT     <= carryoutreg;
  end generate i_vx5;
  P     <= preg(ci_dsp48_p_width-1 downto 0);
  PCOUT <= preg(ci_dsp48_p_width-1 downto 0);
  
END behavioral;


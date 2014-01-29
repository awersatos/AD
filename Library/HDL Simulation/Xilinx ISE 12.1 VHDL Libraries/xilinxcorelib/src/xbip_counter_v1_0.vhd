
-- $Id: xbip_counter_v1_0.vhd,v 1.3 2010/01/29 09:06:43 gordono Exp $
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
  
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all;
use xilinxcorelib.xbip_pipe_v1_0_xst_comp.all;
use xilinxcorelib.xbip_counter_v1_0_pkg.all;

--core_if on entity xbip_counter_v1_0
  entity xbip_counter_v1_0 is
    GENERIC (
      C_XDEVICEFAMILY     : string  := "virtex2";
      C_VERBOSITY         : integer := 0;
      C_USE_DSP48         : integer := 0;
      C_HAS_CE            : integer := 0;
      C_HAS_SCLR          : integer := 0;
      C_LATENCY           : integer := 1;
      C_FB_LATENCY        : integer := 1;
      C_WIDTH             : integer := 16;
      C_RESTRICT_COUNT    : integer := 0;
      C_COUNT_TO          : string  := "0";
      C_COUNT_BY          : string  := "0";
      C_COUNT_MODE        : integer := 0;          -- 0=up, 1=down, 2=updown
      C_THRESH0_VALUE     : string  := "0";
      C_CE_OVERRIDES_SCLR : integer := 0;          -- 0=override;
      C_HAS_THRESH0       : integer := 0;
      C_HAS_LOAD          : integer := 0;
      C_LOAD_LOW          : integer := 0
      );
    PORT (
      CLK     : in  std_logic                            := '0';              -- optional clock
      CE      : in  std_logic                            := '1';              -- optional clock enable
      SCLR    : in  std_logic                            := '0';              -- synch init.
      UP      : in  std_logic                            := '1';              -- controls direction of count - '1' = up.
      LOAD    : in  std_logic                            := '0';              -- optional synch load trigger
      L       : in  std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');  -- optional synch load value
      THRESH0 : out std_logic                            := '1';
      Q       : out std_logic_vector(C_WIDTH-1 downto 0)                      -- output value
      );
--core_if off
end xbip_counter_v1_0;


architecture behavioral of xbip_counter_v1_0 is

  constant ci_reg_delay : time := 100 ps;  -- behv models must have finite delay on register outputs
  
  constant ci_pipe_all : t_xbip_counter_v1_0_latency := fn_xbip_counter_v1_0_latency(
    p_xdevicefamily     => C_XDEVICEFAMILY,
    p_verbosity         => C_VERBOSITY ,
    p_use_dsp48         => C_USE_DSP48, 
    p_latency           => C_LATENCY,
    p_fb_latency        => C_FB_LATENCY,
    p_width             => C_WIDTH,
    p_restrict_count    => C_RESTRICT_COUNT,
    p_count_to          => C_COUNT_TO ,
    p_count_by          => C_COUNT_BY ,
    p_count_mode        => C_COUNT_MODE ,
    p_thresh0_value     => C_THRESH0_VALUE,
    p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR, 
    p_has_thresh0       => C_HAS_THRESH0,
    p_has_load          => C_HAS_LOAD,
    p_load_low          => C_LOAD_LOW
    );
  signal diag_pipe :  t_xbip_counter_v1_0_latency := ci_pipe_all;
  constant ci_pipe : t_xbip_counter_v1_0_pipe := ci_pipe_all.pipe;
  
  constant ci_fb_latency : t_xbip_counter_v1_0_fb_latency := fn_xbip_counter_v1_0_get_fb_latency(
    p_width             => C_WIDTH,
    p_xdevicefamily     => C_XDEVICEFAMILY,
    p_fb_latency        => C_FB_LATENCY,
    p_verbosity         => C_VERBOSITY,
    p_use_dsp48         => C_USE_DSP48,
    p_latency           => C_LATENCY,
    p_restrict_count    => C_RESTRICT_COUNT,
    p_count_to          => C_COUNT_TO,
    p_count_by          => C_COUNT_BY,
    p_count_mode        => C_COUNT_MODE,
    p_thresh0_value     => C_THRESH0_VALUE,
    p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR,
    p_has_thresh0       => C_HAS_THRESH0,
    p_has_load          => C_HAS_LOAD,
    p_load_low          => C_LOAD_LOW 
    );
  signal diag_fb_latency : t_xbip_counter_v1_0_fb_latency := ci_fb_latency;

  constant ci_thresh_latency : t_xbip_counter_v1_0_thresh_latency := fn_xbip_counter_v1_0_get_thresh_latency(
    p_width             => C_WIDTH,
    p_xdevicefamily     => C_XDEVICEFAMILY,
    p_fb_latency        => C_FB_LATENCY,
    p_verbosity         => C_VERBOSITY,
    p_use_dsp48         => C_USE_DSP48,
    p_latency           => C_LATENCY,
    p_restrict_count    => C_RESTRICT_COUNT,
    p_count_to          => C_COUNT_TO,
    p_count_by          => C_COUNT_BY,
    p_count_mode        => C_COUNT_MODE,
    p_thresh0_value     => C_THRESH0_VALUE,
    p_ce_overrides_sclr => C_CE_OVERRIDES_SCLR,
    p_has_thresh0       => C_HAS_THRESH0,
    p_has_load          => C_HAS_LOAD,
    p_load_low          => C_LOAD_LOW
    );
  
  constant ci_count_by    : std_logic_vector(c_width-1 downto 0) := str_to_bound_slv_0(C_COUNT_BY,c_width);
  constant ci_count_to    : std_logic_vector(c_width-1 downto 0) := str_to_bound_slv_0(C_COUNT_TO,c_width);
  constant ci_thresh0_val : std_logic_vector(c_width-1 downto 0) := str_to_bound_slv_0(C_THRESH0_VALUE,c_width);
  signal pre_ntc : std_logic := '1';
  signal pre_ntc1 : std_logic := '1';
  signal ntc     : std_logic := '1';
  signal load_i  : std_logic := '0';
  signal up_i    : std_logic := '0';
  signal l_i     : std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
  signal pre_q   : std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
  signal q_i     : std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
  signal thresh0_i : std_logic := '0';
  signal ce_i    : std_logic := '1';
  signal sclr_i  : std_logic := '0';

begin
  -----------------------------------------------------------------------------
  -- Condition inputs
  -----------------------------------------------------------------------------
  i_ce : if C_HAS_CE = 1 generate
  begin
    ce_i <= CE;
  end generate i_ce;

  i_sclr : if C_HAS_SCLR = 1 generate
  begin
    i_ce_overrides_sclr : if C_CE_OVERRIDES_SCLR = 1 generate
    begin
      sclr_i <= SCLR when ce_i = '1' else '0';
    end generate i_ce_overrides_sclr;
    i_SCLR_overrides_CE : if C_CE_OVERRIDES_SCLR = 0 generate
    begin
      sclr_i <= sclr;
    end generate i_SCLR_overrides_CE;
  end generate i_sclr;

  i_has_load: if C_HAS_LOAD = 1 generate
  begin
    i_hi_load: if C_LOAD_LOW = 0 generate
    begin
      load_i <= LOAD;
    end generate i_hi_load;
    i_low_load: if C_LOAD_LOW = 1 generate
    begin
      load_i <= not LOAD;
    end generate i_low_load;
  end generate i_has_load;
  i_no_load: if C_HAS_LOAD = 0 generate
  begin
    load_i <= '0';
  end generate i_no_load;

  i_up_only: if C_COUNT_MODE = 0 generate
  begin
    up_i <= '1';
  end generate i_up_only;
  i_down_only: if C_COUNT_MODE = 1 generate
  begin
    up_i <= '0';
  end generate i_down_only;
  i_up_down: if C_COUNT_MODE = 2 generate
  begin
    up_i <= UP;
  end generate i_up_down;
  
  -- purpose: the actual count!
  -- type   : combinational
  -- inputs : clk
  -- outputs: pre_q
  i_count: process (clk)
  begin  -- process i_count
    if rising_edge(clk) then
      if sclr_i = '1' then
        pre_q <= (others => '0');
      elsif ce_i = '1' then
        if load_i = '1' then
          pre_q <= L;        
        elsif ntc = '0' then
          pre_q <= (others => '0');
        elsif up_i = '1' then
          pre_q <= pre_q + ci_count_by;
        else
          pre_q <= pre_q - ci_count_by;
        end if;
      end if;
    end if;
  end process i_count;

  i_forward_pipe : xbip_pipe_v1_0_xst
    generic map(
      C_LATENCY  => ci_pipe_all.used-1,
      C_HAS_CE   => 1,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => C_WIDTH
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => pre_q,
      Q    => q_i
      );

  -----------------------------------------------------------------------------
  -- Terminal count
  -----------------------------------------------------------------------------
  i_restrict_count: if C_RESTRICT_COUNT = 1 generate
    
    function fn_get_tc_det_val (
      p_det_val   : std_logic_vector(C_WIDTH-1 downto 0);
      p_count_by  : std_logic_vector(C_WIDTH-1 downto 0);
      p_latency   : integer;
      p_mode      : integer)
      return std_logic_vector is
      variable ret_val : std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
    begin  -- fn_get_thresh_det_val
      ret_val := p_det_val;
      for i in 1 to p_latency loop
        if p_mode = 0 then
          ret_val := ret_val - p_count_by;
        elsif p_mode = 1 then
          ret_val := ret_val + p_count_by;
        end if;
      end loop;  -- i
      return ret_val;
    end fn_get_tc_det_val;
    constant ci_tc_det_val : std_logic_vector(C_WIDTH-1 downto 0) := fn_get_tc_det_val(
      p_det_val   => ci_count_to,
      p_count_by  => ci_count_by,
      p_latency   => ci_pipe_all.used + ci_fb_latency.used -1,
      p_mode      => C_COUNT_MODE
      );
    signal diag_tc_det_val : std_logic_vector(C_WIDTH-1 downto 0) := ci_tc_det_val;
  begin

    ---------------------------------------------------------------------------
    -- run-time trap for malicious LOAD values
    ---------------------------------------------------------------------------
    i_check: process (clk)
    begin  -- process i_check
      if rising_edge(clk) then  -- rising clock edge
        if load_i = '1' then
          if C_COUNT_MODE = 0 then
            if signed(('0'&ci_count_to) - ('0'&L)) < signed('0'&ci_count_by)*to_signed((ci_pipe_all.used + ci_fb_latency.used -1),c_width)  then
              assert not (C_VERBOSITY > 0)
                report
                "WARNING: Value of load will cause Terminal count detection to be missed."
                severity warning;
            end if;
          else
            if signed( ('0'&L) - ('0'&ci_count_to) ) < signed('0'&ci_count_by)*to_signed((ci_pipe_all.used + ci_fb_latency.used -1),c_width)  then
              assert not (C_VERBOSITY > 0)
                report
                "WARNING: Value of load will cause Terminal count detection to be missed."
                severity warning;
            end if;
            
          end if;
        end if;
      end if;
    end process i_check;
    
    pre_ntc <= '0' when q_i = ci_tc_det_val else '1';
    i_fb_pipe : xbip_pipe_v1_0_xst
      generic map(
        C_LATENCY  => ci_fb_latency.used,
        C_HAS_CE   => 1,
        C_HAS_SSET => C_HAS_SCLR,
        C_WIDTH    => 1
        )
      port map(
        CLK  => CLK,
        CE   => ce_i,
        SSET => sclr_i,
        D(0) => pre_ntc,
        Q(0) => ntc
        );
  end generate i_restrict_count;

  -----------------------------------------------------------------------------
  -- Threshold detection
  -----------------------------------------------------------------------------
  i_thresh: if C_HAS_THRESH0 = 1 generate
    signal pre_thresh   : std_logic := '0';
    function fn_get_thresh_det_val (
      p_thresh_val     : std_logic_vector(C_WIDTH-1 downto 0);
      p_count_by       : std_logic_vector(C_WIDTH-1 downto 0);
      p_thresh_latency : integer;
      p_mode           : integer)
      return std_logic_vector is
      variable ret_val : std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
    begin  -- fn_get_thresh_det_val
      ret_val := p_thresh_val;
      for i in 1 to p_thresh_latency loop
        if p_mode = 0 then
          ret_val := ret_val - p_count_by;
        elsif p_mode = 1 then
          ret_val := ret_val + p_count_by;
        end if;
      end loop;  -- i
      return ret_val;
    end fn_get_thresh_det_val;
    constant ci_thresh_det_val : std_logic_vector(C_WIDTH-1 downto 0) := fn_get_thresh_det_val(
      p_thresh_val     => ci_thresh0_val,
      p_count_by       => ci_count_by,
      p_thresh_latency => (ci_thresh_latency.gate_op + ci_thresh_latency.gate_pipes),
      p_mode           => C_COUNT_MODE
      );
  begin
    pre_thresh <= '1' when q_i = ci_thresh_det_val else '0';
  i_thresh_pipe : xbip_pipe_v1_0_xst
    generic map(
      C_LATENCY  => ci_thresh_latency.gate_op + ci_thresh_latency.gate_pipes,
      C_HAS_CE   => 1,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => 1
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D(0) => pre_thresh,
      Q(0) => thresh0_i
      );
  end generate i_thresh;

  THRESH0 <= thresh0_i after ci_reg_delay;
  Q       <= q_i after ci_reg_delay;
  
end behavioral;



-- $Id: c_counter_binary_v10_0.vhd,v 1.2 2008/09/09 20:23:11 akennedy Exp $
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

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v1_0.all;
use xilinxcorelib.c_counter_binary_v10_0_pkg.all;
use xilinxcorelib.c_counter_binary_v9_1_xst_comp.all;
use xilinxcorelib.xbip_counter_v1_0_xst_comp.all;

--core_if on entity c_counter_binary_v10_0
  entity c_counter_binary_v10_0 is
    GENERIC (
      C_IMPLEMENTATION      : integer := 0;
      C_VERBOSITY           : integer := 0;
      C_XDEVICEFAMILY       : string  := "nofamily";  -- must be set
      C_WIDTH               : integer := 16;
      C_HAS_CE              : integer := 0;
      C_HAS_SCLR            : integer := 0;
      C_RESTRICT_COUNT      : integer := 0;
      C_COUNT_TO            : string  := "1";
      C_COUNT_BY            : string  := "1";
      C_COUNT_MODE          : integer := 0;           -- 0=up, 1=down, 2=updown
      C_THRESH0_VALUE       : string  := "1";
      C_CE_OVERRIDES_SYNC   : integer := 0;           -- 0=override;
      C_HAS_THRESH0         : integer := 0;
      C_HAS_LOAD            : integer := 0;
      C_LOAD_LOW            : integer := 0;
      C_LATENCY             : integer := 1;
      C_FB_LATENCY          : integer := 0;
      C_AINIT_VAL           : string  := "0";
      C_SINIT_VAL           : string  := "0";
      C_SCLR_OVERRIDES_SSET : integer := 1;           -- 0=set, 1=clear;
      C_HAS_SSET            : integer := 0;
      C_HAS_SINIT           : integer := 0
      );
    PORT (
      CLK     : in  std_logic                            := '0';              -- optional clock
      CE      : in  std_logic                            := '1';              -- optional clock enable
      SCLR    : in  std_logic                            := '0';              -- synch init.
      SSET    : in  std_logic                            := '0';              -- optional synch set to '1'
      SINIT   : in  std_logic                            := '0';              -- optional synch reset to init_val
      UP      : in  std_logic                            := '1';              -- controls direction of count - '1' = up.
      LOAD    : in  std_logic                            := '0';              -- optional synch load trigger
      L       : in  std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');  -- optional synch load value
      THRESH0 : out std_logic                            := '1';
      Q       : out std_logic_vector(C_WIDTH-1 downto 0)                      -- output value
      );
--core_if off
end c_counter_binary_v10_0;


architecture behavioral OF c_counter_binary_v10_0 IS
  constant check_gens : integer := fn_counter_binary_v10_0_check_generics (
    p_implementation      => C_IMPLEMENTATION,
    p_verbosity           => C_VERBOSITY,
    p_xdevicefamily       => C_XDEVICEFAMILY,
    p_width               => C_WIDTH,
    p_has_ce              => C_HAS_CE,
    p_has_sclr            => C_HAS_SCLR,
    p_restrict_count      => C_RESTRICT_COUNT,
    p_count_to            => C_COUNT_TO,
    p_count_by            => C_COUNT_BY,
    p_count_mode          => C_COUNT_MODE,
    p_thresh0_value       => C_THRESH0_VALUE,
    p_ce_overrides_sync   => C_CE_OVERRIDES_SYNC,
    p_has_thresh0         => C_HAS_THRESH0,
    p_has_load            => C_HAS_LOAD,
    p_load_low            => C_LOAD_LOW,
    p_latency             => C_LATENCY,
    p_fb_latency          => C_FB_LATENCY,
    p_ainit_val           => C_AINIT_VAL,
    p_sinit_val           => C_SINIT_VAL,
    p_sclr_overrides_sset => C_SCLR_OVERRIDES_SSET,
    p_has_sset            => C_HAS_SSET,
    p_has_sinit           => C_HAS_SINIT
    );

  function fn_mode_to_up (
    p_mode : integer)
    return integer is
  begin  -- fn_mode_to_up
    if p_mode = 0 or p_mode = 1 then
      return 0;
    end if;
    return 1;
  end fn_mode_to_up;
  constant ci_has_up : integer := fn_mode_to_up(C_COUNT_MODE);

  constant ci_use_baseblox : boolean := fn_c_counter_binary_v10_0_use_baseblox(
    p_implementation => c_implementation,
    p_latency        => c_latency,
    p_fb_latency     => c_fb_latency,
    p_width          => c_width
    );

begin
  i_baseblox : if ci_use_baseblox generate
    constant ci_family : string := c_xdevicefamily_to_c_family(C_XDEVICEFAMILY);
  begin
    i_baseblox_counter : c_counter_binary_v10_0_legacy
      generic map (
        C_FAMILY         => ci_family,
        C_WIDTH          => C_WIDTH,
        C_RESTRICT_COUNT => C_RESTRICT_COUNT,
        C_COUNT_TO       => C_COUNT_TO,
        C_COUNT_BY       => C_COUNT_BY,
        C_COUNT_MODE     => C_COUNT_MODE,
        C_THRESH0_VALUE  => C_THRESH0_VALUE,
        C_THRESH1_VALUE  => "0",
        C_THRESH_EARLY   => 1,
        C_AINIT_VAL      => C_AINIT_VAL,
        C_SINIT_VAL      => C_SINIT_VAL,
        C_LOAD_ENABLE    => 1,          --subject to CE
        C_SYNC_ENABLE    => C_CE_OVERRIDES_SYNC,
        C_SYNC_PRIORITY  => C_SCLR_OVERRIDES_SSET,
        C_PIPE_STAGES    => 0,
        C_HAS_THRESH0    => 0,
        C_HAS_Q_THRESH0  => C_HAS_THRESH0,
        C_HAS_THRESH1    => 0,
        C_HAS_Q_THRESH1  => 0,
        C_HAS_CE         => C_HAS_CE,
        C_HAS_UP         => ci_has_up,
        C_HAS_IV         => 0,
        C_HAS_L          => C_HAS_LOAD,
        C_HAS_LOAD       => C_HAS_LOAD,
        C_LOAD_LOW       => C_LOAD_LOW,
        C_HAS_ACLR       => 0,
        C_HAS_ASET       => 0,
        C_HAS_AINIT      => 0,
        C_HAS_SCLR       => C_HAS_SCLR,
        C_HAS_SSET       => C_HAS_SSET,
        C_HAS_SINIT      => C_HAS_SINIT,
        C_ENABLE_RLOCS   => 0
        )
      port map(
        CLK       => CLK,
        UP        => UP,
        CE        => CE,
        LOAD      => LOAD,
        L         => L,
--        IV        => "0",
        ACLR      => '0',
        ASET      => '0',
        AINIT     => '0',
        SCLR      => SCLR,
        SSET      => SSET,
        SINIT     => SINIT,
        THRESH0   => open,
        Q_THRESH0 => THRESH0,
        THRESH1   => open,
        Q_THRESH1 => open,
        Q         => Q
        );

  end generate i_baseblox;
  
  i_baseip : if not(ci_use_baseblox) generate
  begin
    i_xbip_counter : xbip_counter_v1_0_xst
      generic map(
      C_XDEVICEFAMILY     => C_XDEVICEFAMILY,
      C_VERBOSITY         => C_VERBOSITY,
      C_USE_DSP48         => C_IMPLEMENTATION,
      C_HAS_CE            => C_HAS_CE,
      C_HAS_SCLR          => C_HAS_SCLR,
      C_LATENCY           => C_LATENCY,
      C_FB_LATENCY        => C_FB_LATENCY,
      C_WIDTH             => C_WIDTH,
      C_RESTRICT_COUNT    => C_RESTRICT_COUNT,
      C_COUNT_TO          => C_COUNT_TO,
      C_COUNT_BY          => C_COUNT_BY,
      C_COUNT_MODE        => C_COUNT_MODE,
      C_THRESH0_VALUE     => C_THRESH0_VALUE,
      C_CE_OVERRIDES_SCLR => C_CE_OVERRIDES_SYNC,
      C_HAS_THRESH0       => C_HAS_THRESH0,
      C_HAS_LOAD          => C_HAS_LOAD,
      C_LOAD_LOW          => C_LOAD_LOW
      )
    port map (
      CLK     => CLK,
      CE      => CE,
      SCLR    => SCLR,
      UP      => UP,
      LOAD    => LOAD,
      L       => L,
      THRESH0 => THRESH0,
      Q       => Q
      );
       
  end generate i_baseip;

end behavioral;


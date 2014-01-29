-- $RCSfile: c_counter_binary_v11_0.vhd,v $ $Revision: 1.4 $ $Date: 2009/12/04 11:46:41 $
-------------------------------------------------------------------------------
-- $Id: c_counter_binary_v11_0.vhd,v 1.4 2009/12/04 11:46:41 akennedy Exp $
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
  
library ieee;
use ieee.std_logic_1164.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.c_counter_binary_v11_0_pkg.all;
--use xilinxcorelib.c_counter_binary_v11_0_xst_comp.all;
use xilinxcorelib.xbip_counter_v2_0_xst_comp.all;

--core_if on entity c_counter_binary_v11_0
  entity c_counter_binary_v11_0 is
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
end c_counter_binary_v11_0;


architecture behavioral OF c_counter_binary_v11_0 IS
  constant check_gens : integer := fn_counter_binary_v11_0_check_generics (
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

  constant ci_use_baseblox : boolean := fn_c_counter_binary_v11_0_use_baseblox(
    p_implementation => c_implementation,
    p_latency        => c_latency,
    p_fb_latency     => c_fb_latency,
    p_width          => c_width
    );

begin
  i_baseblox : if ci_use_baseblox generate
    constant ci_family : string := c_xdevicefamily_to_c_family(C_XDEVICEFAMILY);
  begin
    i_baseblox_counter : c_counter_binary_v11_0_legacy
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
    i_xbip_counter : xbip_counter_v2_0_xst
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


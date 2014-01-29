-- $RCSfile: c_accum_v11_0.vhd,v $  $Revision: 1.4 $  $Date: 2009/12/04 11:46:40 $
--
--  (c) Copyright 1995-2009 Xilinx, Inc. All rights reserved.
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

library IEEE;
use IEEE.std_logic_1164.all;

library XilinxCoreLib;
use xilinxcorelib.xbip_accum_v2_0_comp.all;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;
use xilinxcorelib.c_accum_pkg_v11_0.all;

--
--core_if on entity c_accum_v11_0
entity c_accum_v11_0 is
  generic (
    C_XDEVICEFAMILY     : string  := "no_family";
    C_IMPLEMENTATION    : integer := 0;
    C_VERBOSITY         : integer := 0;
    C_B_WIDTH           : integer := 16;
    C_OUT_WIDTH         : integer := 16;
    C_B_TYPE            : integer := 1;  -- 0=signed, 1=unsigned;
    C_CE_OVERRIDES_SCLR : integer := 0;  -- 0=SYNC over CE, 1 = CE over SYNC
    C_ADD_MODE          : integer := 0;  -- 0=add, 1=sub, 2=addsub;
    C_HAS_C_IN          : integer := 1;
    C_HAS_CE            : integer := 0;
    C_HAS_BYPASS        : integer := 0;
    C_HAS_SCLR          : integer := 0;
    C_LATENCY           : integer := 1;

    C_SCALE               :     integer                                  := 0;
    C_AINIT_VAL           :     string                                   := "0";
    C_SINIT_VAL           :     string                                   := "0";
    C_BYPASS_LOW          :     integer                                  := 0;
    C_SCLR_OVERRIDES_SSET :     integer                                  := 1;  -- 0=set wins, 1=clear wins
    C_HAS_SSET            :     integer                                  := 0;
    C_HAS_SINIT           :     integer                                  := 0
    );
  port (
    B                     : in  std_logic_vector(C_B_WIDTH-1 downto 0)   := (others => '0');  -- input value
    CLK                   : in  std_logic                                := '0';  -- clock
    ADD                   : in  std_logic                                := '1';
    C_IN                  : in  std_logic                                := '0';  -- carry in
    CE                    : in  std_logic                                := '1';  -- clock enable
    BYPASS                : in  std_logic                                := '0';  -- sync load of b into reg
    SCLR                  : in  std_logic                                := '0';  -- synch init.
    SSET                  : in  std_logic                                := '0';  -- synch set.
    SINIT                 : in  std_logic                                := '0';  -- synch init.
    Q                     : out std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0')  -- synch output value
    );
--core_if off
end c_accum_v11_0;


architecture behavioral of c_accum_v11_0 is

  component c_accum_v11_0_legacy
    generic (
      c_family              : string  := "virtex2";
      c_verbosity           : integer := 0;
      c_use_dsp48           : integer := 0;
      c_b_width             : integer := 16;
      c_out_width           : integer := 16;
      c_low_bit             : integer := 0;
      c_high_bit            : integer := 15;
      c_add_mode            : integer := c_add;
      c_b_type              : integer := c_unsigned;
      c_b_constant          : integer := 0;
      c_b_value             : string  := "0000000000000000";
      c_scale               : integer := 0;
      c_saturate            : integer := 0;
      c_ainit_val           : string  := "0000000000000000";
      c_sinit_val           : string  := "0000000000000000";
      c_bypass_enable       : integer := c_no_override;
      c_bypass_low          : integer := 0;
      c_sync_enable         : integer := c_override;
      c_sync_priority       : integer := c_clear;
      c_pipe_stages         : integer := 0;
      c_has_s               : integer := 0;
      c_has_c_in            : integer := 1;
      c_has_c_out           : integer := 0;
      c_has_q_c_out         : integer := 0;
      c_has_b_in            : integer := 0;
      c_has_b_out           : integer := 0;
      c_has_q_b_out         : integer := 0;
      c_has_ovfl            : integer := 0;
      c_has_q_ovfl          : integer := 0;
      c_has_ce              : integer := 0;
      c_has_add             : integer := 0;
      c_has_bypass          : integer := 0;
      c_has_b_signed        : integer := 0;
      c_has_aclr            : integer := 0;
      c_has_aset            : integer := 0;
      c_has_ainit           : integer := 0;
      c_has_sclr            : integer := 0;
      c_has_sset            : integer := 0;
      c_has_sinit           : integer := 0;
      c_has_bypass_with_cin : integer := 0;
      c_enable_rlocs        : integer := 1;
      c_use_infered_rtl     : integer := 0
      );
  
    port (
      b        : in  std_logic_vector(c_b_width-1 downto 0) := (others => '0');  -- input value
      clk      : in  std_logic                              := '0';  -- clock
      add      : in  std_logic                              := '1';
      ovfl     : out std_logic;
      q_ovfl   : out std_logic;
      c_in     : in  std_logic                              := '0';  -- carry in
      c_out    : out std_logic;
      q_c_out  : out std_logic;
      b_in     : in  std_logic                              := '0';  -- borrow in
      b_out    : out std_logic;
      q_b_out  : out std_logic;
      ce       : in  std_logic                              := '1';  -- clock enable
      b_signed : in  std_logic                              := '0';
      bypass   : in  std_logic                              := '0';  -- sync load of b into reg
      aclr     : in  std_logic                              := '0';  -- asynch init.
      aset     : in  std_logic                              := '0';  -- asynch set.
      ainit    : in  std_logic                              := '0';  -- asynch init.
      sclr     : in  std_logic                              := '0';  -- synch init.
      sset     : in  std_logic                              := '0';  -- synch set.
      sinit    : in  std_logic                              := '0';  -- synch init.
      s        : out std_logic_vector(c_high_bit downto c_low_bit);
      q        : out std_logic_vector(c_high_bit downto c_low_bit)  -- synch output value
      );
  end component;



  constant check_gens : integer := fn_c_accum_v11_0_check_generics(
    C_XDEVICEFAMILY       => C_XDEVICEFAMILY,
    C_IMPLEMENTATION      => C_IMPLEMENTATION,
    C_VERBOSITY           => C_VERBOSITY,
    C_B_WIDTH             => C_B_WIDTH,
    C_OUT_WIDTH           => C_OUT_WIDTH,
    C_B_TYPE              => C_B_TYPE,
    C_CE_OVERRIDES_SCLR   => C_CE_OVERRIDES_SCLR,
    C_ADD_MODE            => C_ADD_MODE,
    C_HAS_C_IN            => C_HAS_C_IN,
    C_HAS_CE              => C_HAS_CE,
    C_HAS_BYPASS          => C_HAS_BYPASS,
    C_HAS_SCLR            => C_HAS_SCLR,
    C_LATENCY             => C_LATENCY,
    C_SCALE               => C_SCALE,
    C_BYPASS_LOW          => C_BYPASS_LOW,
    C_SCLR_OVERRIDES_SSET => C_SCLR_OVERRIDES_SSET,
    C_HAS_SSET            => C_HAS_SSET,
    C_HAS_SINIT           => C_HAS_SINIT,
    C_AINIT_VAL           => C_AINIT_VAL,
    C_SINIT_VAL           => C_SINIT_VAL
    );

  constant ci_latency      : t_c_accum_v11_0_latency := fn_c_accum_v11_0_latency(
    C_XDEVICEFAMILY       => C_XDEVICEFAMILY,
    C_IMPLEMENTATION      => C_IMPLEMENTATION,
    C_VERBOSITY           => C_VERBOSITY,
    C_B_WIDTH             => C_B_WIDTH,
    C_OUT_WIDTH           => C_OUT_WIDTH,
    C_B_TYPE              => C_B_TYPE,
    C_CE_OVERRIDES_SCLR   => C_CE_OVERRIDES_SCLR,
    C_ADD_MODE            => C_ADD_MODE,
    C_HAS_C_IN            => C_HAS_C_IN,
    C_HAS_CE              => C_HAS_CE,
    C_HAS_BYPASS          => C_HAS_BYPASS,
    C_HAS_SCLR            => C_HAS_SCLR,
    C_LATENCY             => C_LATENCY,
    C_SCALE               => C_SCALE,
    C_BYPASS_LOW          => C_BYPASS_LOW,
    C_SCLR_OVERRIDES_SSET => C_SCLR_OVERRIDES_SSET,
    C_HAS_SSET            => C_HAS_SSET,
    C_HAS_SINIT           => C_HAS_SINIT,
    C_AINIT_VAL           => C_AINIT_VAL,
    C_SINIT_VAL           => C_SINIT_VAL
    );
  signal   diag_latency    : t_c_accum_v11_0_latency := ci_latency;
  constant ci_latency_used : integer                 := ci_latency.used;

  constant ci_resources   : t_c_accum_v11_0_resources := fn_c_accum_v11_0_resources(
    C_XDEVICEFAMILY       => C_XDEVICEFAMILY,
    C_IMPLEMENTATION      => C_IMPLEMENTATION,
    C_VERBOSITY           => C_VERBOSITY,
    C_B_WIDTH             => C_B_WIDTH,
    C_OUT_WIDTH           => C_OUT_WIDTH,
    C_B_TYPE              => C_B_TYPE,
    C_CE_OVERRIDES_SCLR   => C_CE_OVERRIDES_SCLR,
    C_ADD_MODE            => C_ADD_MODE,
    C_HAS_C_IN            => C_HAS_C_IN,
    C_HAS_CE              => C_HAS_CE,
    C_HAS_BYPASS          => C_HAS_BYPASS,
    C_HAS_SCLR            => C_HAS_SCLR,
    C_LATENCY             => ci_latency_used,
    C_SCALE               => C_SCALE,
    C_BYPASS_LOW          => C_BYPASS_LOW,
    C_SCLR_OVERRIDES_SSET => C_SCLR_OVERRIDES_SSET,
    C_HAS_SSET            => C_HAS_SSET,
    C_HAS_SINIT           => C_HAS_SINIT,
    C_AINIT_VAL           => C_AINIT_VAL,
    C_SINIT_VAL           => C_SINIT_VAL
    );
  signal   diag_resources : t_c_accum_v11_0_resources := ci_resources;

  constant ci_use_baseblox : boolean := fn_use_baseblox(
    p_implementation => C_IMPLEMENTATION,
    p_latency        => ci_latency_used
    );

  constant p_has_b_in  : integer := fn_borrow_ports(
    has_port  => c_has_c_in,
    add_mode  => c_add_mode,
    data_type => 1
    );
  constant p_has_b_out : integer := fn_borrow_ports(
    has_port  => 0,
    add_mode  => c_add_mode,
    data_type => c_b_type
    );
  constant p_has_c_in  : integer := fn_carry_ports(
    has_port  => c_has_c_in,
    add_mode  => c_add_mode,
    data_type => 1
    );
  constant p_has_c_out : integer := fn_carry_ports(
    has_port  => 0,
    add_mode  => c_add_mode,
    data_type => c_b_type
    );
  constant p_has_add   : integer := fn_add_port(
    add_mode  => c_add_mode
    );

begin

  i_baseblox : if ci_use_baseblox generate

    signal i_s, i_q           : std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0');
    signal i_q_ovfl, i_ovfl   : std_logic                                := '0';
    signal i_q_c_out, i_c_out : std_logic                                := '0';
    signal i_q_b_out, i_b_out : std_logic                                := '0';
    signal i_b_in, i_c_in     : std_logic                                := '0';

  begin
    -- removed direct instantiation; did not work with get_models
    --i_baseblox_accum_behv : entity xilinxcorelib.c_accum_v11_0_legacy(behavioral)
    i_baseblox_accum_behv : c_accum_v11_0_legacy
      generic map(
        c_verbosity           => C_VERBOSITY,
        c_b_width             => C_B_WIDTH,
        c_out_width           => C_OUT_WIDTH,
        c_low_bit             => 0,
        c_high_bit            => C_OUT_WIDTH-1,
        c_add_mode            => C_ADD_MODE,
        c_b_type              => C_B_TYPE,
        c_b_constant          => 0,
        c_b_value             => "0",
        c_scale               => C_SCALE,
        c_saturate            => 0,
        c_ainit_val           => C_AINIT_VAL,
        c_sinit_val           => C_SINIT_VAL,
        c_bypass_enable       => 0,     --- CE will always override bypass C_CE_OVERRIDES_BYPASS,
        c_bypass_low          => C_BYPASS_LOW,
        c_sync_enable         => C_CE_OVERRIDES_SCLR,
        c_sync_priority       => C_SCLR_OVERRIDES_SSET,
        c_pipe_stages         => 1,     -- non-operational   
        c_has_s               => 1,     -- alwahs have s output
        c_has_c_in            => p_has_c_in,
        c_has_c_out           => 0,     -- no carry out
        c_has_q_c_out         => p_has_c_out,
        c_has_b_in            => p_has_b_in,
        c_has_b_out           => 0,
        c_has_q_b_out         => p_has_b_out,  -- *ci_accum_regs.op_reg,
        c_has_ovfl            => 0,     -- Overflow removed
        c_has_q_ovfl          => 0,     -- Overflow removed
        c_has_ce              => C_HAS_CE,
        c_has_add             => p_has_add,
        c_has_bypass          => C_HAS_BYPASS,
        c_has_b_signed        => 0,
        c_has_aclr            => 0,
        c_has_aset            => 0,
        c_has_ainit           => 0,
        c_has_sclr            => C_HAS_SCLR,
        c_has_sset            => C_HAS_SSET,
        c_has_sinit           => C_HAS_SINIT,
        c_has_bypass_with_cin => 0,
        c_enable_rlocs        => 0
        )
      port map(
        b                     => B,
        clk                   => CLK,
        add                   => ADD,
        ovfl                  => open,
        q_ovfl                => open,
        c_in                  => i_c_in,
        c_out                 => open,
        q_c_out               => i_q_c_out,
        b_in                  => i_b_in,
        b_out                 => open,
        q_b_out               => i_q_b_out,
        ce                    => CE,
        b_signed              => '0',
        bypass                => BYPASS,
        aclr                  => '0',
        aset                  => '0',
        ainit                 => '0',
        sclr                  => SCLR,
        sset                  => SSET,
        sinit                 => SINIT,
        s                     => i_s,
        q                     => i_q
        );

    Q <= i_q;

    has_cin : if p_has_c_in = 1 generate
      i_c_in <= C_IN;
    end generate has_cin;
    has_bin : if p_has_b_in = 1 generate
      i_b_in <= C_IN;
    end generate has_bin;

  end generate i_baseblox;

  i_baseip            : if not(ci_use_baseblox) generate
    signal i_CE       : std_logic := '1';
    signal i_SCLR     : std_logic := '0';
    signal i_BYPASS   : std_logic := '0';
    signal i_ADDf     : std_logic := '0';
    signal i_C_IN     : std_logic;
  begin
    i_xbip_accum_behv : xbip_accum_v2_0
      generic map(
        C_XDEVICEFAMILY     => C_XDEVICEFAMILY,
        C_USE_DSP48         => C_IMPLEMENTATION,
        C_VERBOSITY         => C_VERBOSITY,
        C_LATENCY           => ci_latency_used,
        C_BYPASS_LOW        => C_BYPASS_LOW,
        C_B_WIDTH           => C_B_WIDTH,
        C_OUT_WIDTH         => C_OUT_WIDTH,
        C_CE_OVERRIDES_SCLR => C_CE_OVERRIDES_SCLR,
        C_DATA_TYPE         => C_B_TYPE,
        C_HAS_BYPASS        => C_HAS_BYPASS,
        C_ADD_MODE          => C_ADD_MODE
        )
      port map(
        CLK                 => CLK,
        CE                  => i_CE,
        SCLR                => i_SCLR,
        B                   => B,
        ADDF                => i_ADDf,
        BYPASS              => i_BYPASS,
        C_IN                => i_C_IN,
        Q                   => Q
        );

    mode_adder      : if C_ADD_MODE = 0 generate
      i_ADDf <= '0';
    end generate mode_adder;
    mode_subtractor : if C_ADD_MODE = 1 generate
      i_ADDf <= '1';
    end generate mode_subtractor;
    mode_addsub     : if C_ADD_MODE = 2 generate
      i_ADDf <= not(ADD);
    end generate mode_addsub;

    has_c_in    : if C_HAS_C_IN = 1 generate
      i_C_IN <= C_IN;
    end generate has_c_in;
    has_no_c_in : if C_HAS_C_IN = 0 generate
      i_C_IN <= '0';
    end generate has_no_c_in;

    has_ce    : if C_HAS_CE = 1 generate
      i_CE <= CE;
    end generate has_ce;
    has_no_ce : if C_HAS_CE = 0 generate
      i_CE <= '1';
    end generate has_no_ce;

    has_sclr    : if C_HAS_SCLR = 1 generate
      i_SCLR <= SCLR;
    end generate has_sclr;
    has_no_sclr : if C_HAS_SCLR = 0 generate
      i_SCLR <= '0';
    end generate has_no_sclr;

    has_bypass    : if C_HAS_BYPASS = 1 generate
      i_BYPASS   <= BYPASS;
    end generate has_bypass;
    has_no_bypass : if C_HAS_BYPASS = 0 generate
      bypass_high : if C_BYPASS_LOW = 0 generate
        i_BYPASS <= '0';
      end generate bypass_high;
      bypass_low  : if C_BYPASS_LOW = 1 generate
        i_BYPASS <= '1';
      end generate bypass_low;
    end generate has_no_bypass;

  end generate i_baseip;
end behavioral;

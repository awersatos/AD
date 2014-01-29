
-- $Id: c_accum_v10_0.vhd,v 1.2 2008/09/09 20:22:52 akennedy Exp $
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

LIBRARY XilinxCoreLib;
--use xilinxcorelib.prims_utils_v9_1.all;
use xilinxcorelib.c_accum_v9_1_comp.all;
use xilinxcorelib.xbip_accum_v1_0_comp.all;
use xilinxcorelib.bip_usecase_utils_pkg_v1_0.all;
use xilinxcorelib.c_accum_pkg_v10_0.all;

--
--core_if on entity c_accum_v10_0
  entity c_accum_v10_0 is
    GENERIC (
      C_XDEVICEFAMILY       : STRING  := "no_family";
      C_IMPLEMENTATION      : INTEGER := 0;
      C_VERBOSITY           : integer := 0;
      C_B_WIDTH             : INTEGER := 16;
      C_OUT_WIDTH           : INTEGER := 16;
      C_B_TYPE           : INTEGER := 1;            -- 0=signed, 1=unsigned;
      C_CE_OVERRIDES_SCLR   : INTEGER := 0;            -- 0=SYNC over CE, 1 = CE over SYNC
      C_ADD_MODE            : integer := 0;            -- 0=add, 1=sub, 2=addsub;
      C_HAS_C_IN            : integer := 1;
      C_HAS_CE              : integer := 0;
      C_HAS_BYPASS          : integer := 0;
      C_HAS_SCLR            : integer := 0;
      C_LATENCY             : integer := 1;

      C_SCALE               : integer := 0;
      C_AINIT_VAL           : string  := "0";
      C_SINIT_VAL           : string  := "0";
      C_BYPASS_LOW          : integer := 0;
      C_SCLR_OVERRIDES_SSET : integer := 1;            -- 0=set wins, 1=clear wins
      C_HAS_SSET            : integer := 0;
      C_HAS_SINIT           : integer := 0
      );
    PORT (
      B      : in  std_logic_vector(C_B_WIDTH-1 downto 0)   := (others => '0');  -- input value
      CLK    : in  std_logic                                := '0';              -- clock
      ADD    : in  std_logic                                := '1';
      C_IN   : in  std_logic                                := '0';              -- carry in
      CE     : in  std_logic                                := '1';              -- clock enable
      BYPASS : in  std_logic                                := '0';              -- sync load of b into reg
      SCLR   : in  std_logic                                := '0';              -- synch init.
      SSET   : in  std_logic                                := '0';              -- synch set.
      SINIT  : in  std_logic                                := '0';              -- synch init.
      Q      : out std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0')   -- synch output value
      );
--core_if off
END c_accum_v10_0;


ARCHITECTURE behavioral OF c_accum_v10_0 IS


  constant check_gens : integer := fn_c_accum_v10_0_check_generics(
    C_XDEVICEFAMILY       => C_XDEVICEFAMILY,
    C_IMPLEMENTATION      => C_IMPLEMENTATION,
    C_VERBOSITY           => C_VERBOSITY,
    C_B_WIDTH             => C_B_WIDTH,
    C_OUT_WIDTH           => C_OUT_WIDTH,
    C_B_TYPE         => C_B_TYPE,
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

  constant ci_latency : t_c_accum_v10_0_latency := fn_c_accum_v10_0_latency(
    C_XDEVICEFAMILY       => C_XDEVICEFAMILY,
    C_IMPLEMENTATION      => C_IMPLEMENTATION,
    C_VERBOSITY           => C_VERBOSITY,
    C_B_WIDTH             => C_B_WIDTH,
    C_OUT_WIDTH           => C_OUT_WIDTH,
    C_B_TYPE         => C_B_TYPE,
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
  signal diag_latency : t_c_accum_v10_0_latency := ci_latency;

  constant ci_resources : t_c_accum_v10_0_resources := fn_c_accum_v10_0_resources(
    C_XDEVICEFAMILY       => C_XDEVICEFAMILY,
    C_IMPLEMENTATION      => C_IMPLEMENTATION,
    C_VERBOSITY           => C_VERBOSITY,
    C_B_WIDTH             => C_B_WIDTH,
    C_OUT_WIDTH           => C_OUT_WIDTH,
    C_B_TYPE         => C_B_TYPE,
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
  signal diag_resources : t_c_accum_v10_0_resources := ci_resources;

  constant p_has_b_in      : integer := fn_borrow_ports(c_has_c_in,c_add_mode,1);
  constant p_has_b_out     : integer := fn_borrow_ports(0,c_add_mode,c_b_type);
  constant p_has_c_in      : integer := fn_carry_ports(c_has_c_in,c_add_mode,1);
  constant p_has_c_out     : integer := fn_carry_ports(0,c_add_mode,c_b_type);
  constant p_has_add       : integer := fn_add_port(c_add_mode);
  
begin
  i_baseblox : if C_IMPLEMENTATION = 0 generate
    
--    constant ci_family     : string       := c_xdevicefamily_to_c_family(C_XDEVICEFAMILY);

    signal i_s, i_q           : std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0');
    signal i_q_ovfl, i_ovfl   : std_logic                                := '0';
    signal i_q_c_out, i_c_out : std_logic                                := '0';
    signal i_q_b_out, i_b_out : std_logic                                := '0';
    signal i_b_in, i_c_in     : std_logic                                := '0';
    
  begin
    i_baseblox_accum_behv : c_accum_v9_1
      generic map(
--        c_use_dsp48           => 0,
--        c_family              => ci_family,
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
        c_bypass_enable       => 0,  --- CE will always override bypass C_CE_OVERRIDES_BYPASS,
        c_bypass_low          => C_BYPASS_LOW,
        c_sync_enable         => C_CE_OVERRIDES_SCLR,
        c_sync_priority       => C_SCLR_OVERRIDES_SSET,
        c_pipe_stages         => 1,  -- non-operational   ci_accum_regs.pipe_regs,
        c_has_s               => 1,  -- 1-ci_accum_regs.op_reg,
        c_has_c_in            => p_has_c_in,
        c_has_c_out           => 0, -- *(1-ci_accum_regs.op_reg),
        c_has_q_c_out         => p_has_c_out, -- *ci_accum_regs.op_reg,
        c_has_b_in            => p_has_b_in,
        c_has_b_out           => 0, -- *(1-ci_accum_regs.op_reg),
        c_has_q_b_out         => p_has_b_out, -- *ci_accum_regs.op_reg,
        c_has_ovfl            => 0, -- C_HAS_OVFL*(1-ci_accum_regs.op_reg),
        c_has_q_ovfl          => 0, -- C_HAS_OVFL*(ci_accum_regs.op_reg),
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
--        c_use_infered_rtl     => 0
        )
      port map(
        b        => B,
        clk      => CLK,
        add      => ADD,
        ovfl     => OPEN,
        q_ovfl   => OPEN,
        c_in     => i_c_in,
        c_out    => OPEN,
        q_c_out  => i_q_c_out,
        b_in     => i_b_in,
        b_out    => OPEN,
        q_b_out  => i_q_b_out,
        ce       => CE,
        b_signed => '0',
        bypass   => BYPASS,
        aclr     => '0',
        aset     => '0',
        ainit    => '0',
        sclr     => SCLR,
        sset     => SSET,
        sinit    => SINIT,
        s        => i_s,
        q        => i_q
        );

      Q     <= i_q;

      has_cin : if p_has_c_in = 1 generate
        i_c_in <= C_IN;
      end generate has_cin;
      has_bin : if p_has_b_in = 1 generate
        i_b_in <= C_IN;
      end generate has_bin;
    
  end generate i_baseblox;

  i_baseip : if C_IMPLEMENTATION = 1 generate
    signal i_CE : std_logic := '1';    
    signal i_SCLR : std_logic := '0';    
    signal i_BYPASS : std_logic := '0';    
    signal i_ADDf : std_logic := '0';    
    signal i_C_IN : std_logic; 
  begin
    i_xbip_accum_behv : xbip_accum_v1_0
      generic map(
        C_XDEVICEFAMILY     => C_XDEVICEFAMILY,
        C_IMPLEMENTATION    => C_IMPLEMENTATION,
        C_VERBOSITY         => C_VERBOSITY,
        C_LATENCY           => C_LATENCY,
        C_BYPASS_LOW        => C_BYPASS_LOW,
        C_B_WIDTH           => C_B_WIDTH,
        C_OUT_WIDTH         => C_OUT_WIDTH,
        C_CE_OVERRIDES_SCLR => C_CE_OVERRIDES_SCLR,
        C_DATA_TYPE         => C_B_TYPE
        )
      port map(
        CLK    => CLK,
        CE     => i_CE,
        SCLR   => i_SCLR,
        B      => B,
        ADDF   => i_ADDf,
        BYPASS => i_BYPASS,
        C_IN   => i_C_IN,
        Q      => Q
        );

    mode_adder : if C_ADD_MODE = 0 generate
      i_ADDf <= '0';
    end generate mode_adder;
    mode_subtractor : if C_ADD_MODE = 1 generate
      i_ADDf <= '1';
    end generate mode_subtractor;
    mode_addsub : if C_ADD_MODE = 2 generate
      i_ADDf <= not(ADD);
    end generate mode_addsub;

    has_c_in : if C_HAS_C_IN = 1 generate
      i_C_IN <= C_IN;
    end generate has_c_in;
    has_no_c_in : if C_HAS_C_IN = 0 generate
      i_C_IN <= '0';
    end generate has_no_c_in;
    
    has_ce : if C_HAS_CE = 1 generate
      i_CE <= CE;
    end generate has_ce;
    has_no_ce : if C_HAS_CE = 0 generate
      i_CE <= '1';
    end generate has_no_ce;
    
    has_sclr : if C_HAS_SCLR = 1 generate
      i_SCLR <= SCLR;
    end generate has_sclr;
    has_no_sclr : if C_HAS_SCLR = 0 generate
      i_SCLR <= '0';
    end generate has_no_sclr;
    
    has_bypass : if C_HAS_BYPASS = 1 generate
      i_BYPASS <= BYPASS;
    end generate has_bypass;
    has_no_bypass : if C_HAS_BYPASS = 0 generate
      bypass_high : if C_BYPASS_LOW = 0 generate
        i_BYPASS <= '0';
      end generate bypass_high;
      bypass_low : if C_BYPASS_LOW = 1 generate
        i_BYPASS <= '1';
      end generate bypass_low;
    end generate has_no_bypass;

  end generate i_baseip;
end behavioral;

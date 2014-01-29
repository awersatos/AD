-- $Id: xbip_dsp48_macro_v2_0.vhd,v 1.3 2009/12/04 11:46:21 akennedy Exp $
-------------------------------------------------------------------------------
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
---------------------------------------------------------------
-- This is the Synthesizable RTL model (aka 'soft instantiation')
-- This model is intended to be synthesized using only RTL and sub-blocks which
-- ultimately use only RTL. The purpose is to test XST inference QoR, but also
-- allow delivery of RTL-only source code.
---------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

library xilinxcorelib;
use xilinxcorelib.bip_usecase_utils_pkg_v2_0.all;
use xilinxcorelib.bip_utils_pkg_v2_0.all;

library xilinxcorelib;
use xilinxcorelib.xbip_pipe_v2_0_xst_comp.all;

library xilinxcorelib;
use xilinxcorelib.bip_dsp48_macro_pkg_v2_0.all;   

--core_if on entity xbip_dsp48_macro_v2_0
  entity xbip_dsp48_macro_v2_0 is
    generic (
      C_VERBOSITY        : integer := 0  ;                                 -- 0 = Errors 1 = +Warnings, 2 = +Notes and tips
      C_MODEL_TYPE       : integer := 0  ;                                 -- 0 = synth, 1 = RTL
      C_XDEVICEFAMILY    : string  := "virtex5";
      C_HAS_CE           : integer := 0;
      C_HAS_SCLR         : integer := 0;
      C_HAS_CARRYCASCIN  : integer := 0;
      C_HAS_CARRYIN      : integer := 0;
      C_HAS_ACIN         : integer := 0;
      C_HAS_BCIN         : integer := 0;
      C_HAS_PCIN         : integer := 0;
      C_HAS_A            : integer := 1;
      C_HAS_B            : integer := 1;
      C_HAS_D            : integer := 1;
      C_HAS_CONCAT       : integer := 0;
      C_HAS_C            : integer := 0;
      C_A_WIDTH          : integer := ci_dsp48_b_width ;                   -- can't use a function here.
      C_B_WIDTH          : integer := ci_dsp48_b_width;
      C_C_WIDTH          : integer := ci_dsp48_c_width;
      C_D_WIDTH          : integer := 0 ;                                  -- can't use a function here.
      C_CONCAT_WIDTH     : integer := 0;
      C_P_MSB            : integer := ci_dsp48_p_width-1  ;
      C_P_LSB            : integer := 0;
      C_SEL_WIDTH        : integer := 5;
      C_HAS_ACOUT        : integer := 0;
      C_HAS_BCOUT        : integer := 0;
      C_HAS_CARRYCASCOUT : integer := 0;
      C_HAS_CARRYOUT     : integer := 0;
      C_HAS_PCOUT        : integer := 0;
      C_CONSTANT_1       : integer := 1;
      C_LATENCY          : integer := -1;
      C_OPMODES          : string  := "";
      C_REG_CONFIG       : string  := "00000000000000000000000000000000";
      C_TEST_CORE        : integer := 0                                    --  0 = normal releas core behavour 1 = generate a test core
      );
    port (
      CLK          : in  std_logic                                                           := '1';
      CE           : in  std_logic                                                           := '1';
      SCLR         : in  std_logic                                                           := '0';
      SEL          : in  std_logic_vector(C_SEL_WIDTH+boolean'pos(C_SEL_WIDTH=0)-1 downto 0) := (others => '0');  -- Guard against -1 to 0 when C_SEL_WIDTH=0
      CARRYCASCIN  : in  std_logic                                                           := '0';
      CARRYIN      : in  std_logic                                                           := '0';
      PCIN         : in  std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0');
      ACIN         : in  std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)      := (others => '0');
      BCIN         : in  std_logic_vector(ci_dsp48_b_width-1 downto 0)                       := (others => '0');
      A            : in  std_logic_vector(C_A_WIDTH-1 downto 0)                              := (others => '0');
      B            : in  std_logic_vector(C_B_WIDTH-1 downto 0)                              := (others => '0');
      C            : in  std_logic_vector(C_C_WIDTH-1 downto 0)                              := (others => '0');
      D            : in  std_logic_vector(C_D_WIDTH-1 downto 0)                              := (others => '0');
      CONCAT       : in  std_logic_vector(C_CONCAT_WIDTH-1 downto 0)                         := (others => '0');
      ACOUT        : out std_logic_vector(fn_dsp48_a_width(C_XDEVICEFAMILY)-1 downto 0)      := (others => '0');
      BCOUT        : out std_logic_vector(ci_dsp48_b_width-1 downto 0)                       := (others => '0');
      CARRYOUT     : out std_logic                                                           := '0';
      CARRYCASCOUT : out std_logic                                                           := '0';
      PCOUT        : out std_logic_vector(ci_dsp48_p_width-1 downto 0)                       := (others => '0');
      P            : out std_logic_vector(C_P_MSB-C_P_LSB downto 0)                          := (others => '0')
      );
--core_if off
end entity xbip_dsp48_macro_v2_0;


architecture behavioral of xbip_dsp48_macro_v2_0 is

  constant dsp48_macro_latency : t_dsp48_macro_latency := fn_dsp48_macro_v2_0_latency(
    P_VERBOSITY       => C_VERBOSITY,
    P_MODEL_TYPE      => C_MODEL_TYPE,
    P_XDEVICEFAMILY   => C_XDEVICEFAMILY,
    P_HAS_CE          => C_HAS_CE,
    P_HAS_SCLR        => C_HAS_SCLR,
    P_HAS_CARRYCASCIN => C_HAS_CARRYCASCIN,
    P_HAS_CARRYIN     => C_HAS_CARRYIN,
    P_HAS_ACIN        => C_HAS_ACIN,
    P_HAS_BCIN        => C_HAS_BCIN,
    P_HAS_A           => C_HAS_A,
    P_HAS_B           => C_HAS_B,
    P_HAS_D           => C_HAS_D,
    P_HAS_CONCAT      => C_HAS_CONCAT,
    P_A_WIDTH         => C_A_WIDTH,
    P_B_WIDTH         => C_B_WIDTH,
    P_C_WIDTH         => C_C_WIDTH,
    P_D_WIDTH         => C_D_WIDTH,
    P_CONCAT_WIDTH    => C_CONCAT_WIDTH,
    -- P_P_WIDTH         => C_P_WIDTH,
    P_SEL_WIDTH       => C_SEL_WIDTH,
    P_LATENCY         => C_LATENCY,
    P_OPMODES         => C_OPMODES,
    P_REG_CONFIG      => C_REG_CONFIG
    );

  signal diag_latency : t_dsp48_macro_latency := dsp48_macro_latency;
  constant ci_pipe : t_dsp48_macro_pipe := dsp48_macro_latency.reg_config;--.pipe; 
  -- Use reg config, this is the value fedback to the GUI and show from a simplistic point of view which registers are enabled rather than actual implementation 

  type t_opmode_rom is array (0 to 2**C_SEL_WIDTH-1) of std_logic_vector(ci_opmode_width-1 downto 0);
  function fn_opmodes_to_rom(
    p_opmodes : string
    ) return t_opmode_rom is
    variable v_val          : string(1 to p_opmodes'length);
    variable temp_str       : string(1 to p_opmodes'length);
    variable clear_str      : string(1 to p_opmodes'length);
    variable opmode         : std_logic_vector(ci_opmode_width-1 downto 0);
    variable len            : integer;
    variable start          : integer;
    variable cursor         : integer;
    variable ret_val        : t_opmode_rom := (others=>(others=>'0')); -- give all locations a default;
    variable rom_addr : integer;
  begin
    --find the first non-space character
    start    := 0;
    rom_addr := 0;
    v_val    := p_opmodes;
    len      := p_opmodes'length;
    for i in 1 to len loop
      if v_val(i) = '0' or v_val(i) = '1' then
        start := i;
        exit;
      end if;
    end loop;  -- i
   
    if start = 0 then
      assert false
        report "ERROR: xbip_dsp48_macro_v2_0: no 0/1's detected in OPMODE string"
        severity ERROR;
      return ret_val;                       --return default  invalid
    end if;
    
    for w in temp_str'range loop
      clear_str(w) := '0';              --used to clear temp_str
    end loop;     

    temp_str := clear_str;
    cursor := 0;

    --will this loop detect the last opmode? &&&
    for j in start to len loop
      if v_val(j) = '1' or v_val(j) = '0' then
        cursor := cursor +1;            --keep track of its length
        temp_str(cursor) := v_val(j);   --construct element string
      else
        --next word
        opmode := str_to_bound_slv_0(str_to_bound_str(temp_str(1 to cursor),ci_opmode_width,"0"),ci_opmode_width);
        ret_val(rom_addr) := opmode;
        rom_addr := rom_addr +1;
        temp_str := clear_str;
        cursor := 0;
      end if;
      if j = len and (v_val(j) = '1' or v_val(j) = '0') then
        --next word
        opmode := str_to_bound_slv_0(str_to_bound_str(temp_str(1 to cursor),ci_opmode_width,"0"),ci_opmode_width);
        ret_val(rom_addr) := opmode;
        rom_addr := rom_addr +1;
      end if;
      
    end loop;  -- j
    
    return ret_val;
    
  end function fn_opmodes_to_rom;
  constant ci_opmode_rom : t_opmode_rom := fn_opmodes_to_rom(C_OPMODES);
  signal diag_opmode_rom : t_opmode_rom;

  constant ci_macro_config : t_macro_config := fn_get_macro_config(C_OPMODES);
  signal diag_macro_config : t_macro_config;

  --resolve calls to xbip_utils now to save multiple calls later.
  constant ci_dsp48_concat_width : integer := fn_dsp48_concat_width(C_XDEVICEFAMILY);
  constant ci_dsp48_a_width      : integer := fn_dsp48_a_width(C_XDEVICEFAMILY);
  constant ci_dsp48_amult_width  : integer := fn_dsp48_amult_width(C_XDEVICEFAMILY);
  constant ci_dsp48_d_width      : integer := fn_dsp48_d_width(C_XDEVICEFAMILY);
  constant supports_dsp48a       : integer := supports_dsp48a(C_XDEVICEFAMILY);
  constant supports_dsp48a1      : integer := supports_dsp48a1(C_XDEVICEFAMILY);
  constant supports_dsp48e       : integer := supports_dsp48e(C_XDEVICEFAMILY);
  constant supports_dsp48e1      : integer := supports_dsp48e1(C_XDEVICEFAMILY);
  constant has_dsp48             : boolean := has_dsp48(C_XDEVICEFAMILY);
  constant has_dsp               : boolean := has_dsp(C_XDEVICEFAMILY);
  
  constant ci_round_const : std_logic_vector(ci_dsp48_c_width-1 downto 0) := fn_get_round_const(C_P_LSB);
  
  -- signals section
  -----------------------------------------------------------------------------
  -- Naming convention
  -- Many of the signal names follow the form X_YZ where X and Y are letters
  -- and Z is a number.
  -- X refers to the input port. Y is 'i' or 'r'. Although these started life
  -- as 'internal' and 'resized', think of them as post-register and pre-next-register.
  -- Hence the code is broken into registers and logic, with the register described
  -- by an xbip_pipe and the logic converting X_iZ signals into X_rZ signals.
  -----------------------------------------------------------------------------

  signal ce_i   : std_logic := '1';
  signal sclr_i : std_logic := '0';
  
  signal a_i1      : std_logic_vector(C_A_WIDTH-1 downto 0) := (others => '0');
  signal b_i1      : std_logic_vector(C_B_WIDTH-1 downto 0) := (others => '0');
  -- signal c_i1      : std_logic_vector(C_C_WIDTH-1 downto 0) := (others => '0');
  signal d_i1      : std_logic_vector(C_D_WIDTH-1 downto 0) := (others => '0');

  constant ci_b_one  : std_logic_vector(C_B_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(C_CONSTANT_1, C_B_WIDTH));
  signal a_mux1      : std_logic_vector(C_A_WIDTH-1 downto 0) := (others => '0');
  signal b_mux1      : std_logic_vector(C_B_WIDTH-1 downto 0) := (others => '0');
  
  
  signal a_i2 : std_logic_vector(C_A_WIDTH-1 downto 0) := (others => '0');
  signal b_i2 : std_logic_vector(C_B_WIDTH-1 downto 0) := (others => '0');
  -- signal c_i2 : std_logic_vector(C_C_WIDTH-1 downto 0) := (others => '0');
  signal d_i2 : std_logic_vector(C_D_WIDTH-1 downto 0) := (others => '0');

  --these signals are the output of the mux between direct inputs and concat
  signal a_p2 : std_logic_vector(ci_dsp48_a_width-1 downto 0) := (others => '0');
  signal b_p2 : std_logic_vector(ci_dsp48_b_width-1 downto 0) := (others => '0');

  --these signals are the output of the mux between fabric inputs and cascade.
  signal a_r2 : std_logic_vector(ci_dsp48_a_width-1 downto 0) := (others => '0');
  signal b_r2 : std_logic_vector(ci_dsp48_b_width-1 downto 0) := (others => '0');
  signal d_r2 : std_logic_vector(ci_dsp48_d_width-1 downto 0) := (others => '0');

  signal a_i3 : std_logic_vector(ci_dsp48_a_width-1 downto 0) := (others => '0');
  signal b_i3 : std_logic_vector(ci_dsp48_b_width-1 downto 0) := (others => '0');
  signal c_i3 : std_logic_vector(C_C_WIDTH-1 downto 0) := (others => '0');
  signal d_i3 : std_logic_vector(ci_dsp48_d_width-1 downto 0) := (others => '0');

  signal a_r3 : std_logic_vector(ci_dsp48_a_width-1 downto 0) := (others => '0');
  signal b_r3 : std_logic_vector(ci_dsp48_b_width-1 downto 0) := (others => '0');
  signal c_r3 : std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0');
  
  signal concat_i2 : std_logic_vector(ci_dsp48_concat_width-1 downto 0) := (others => '0');
  signal concat_i3 : std_logic_vector(ci_dsp48_concat_width-1 downto 0) := (others => '0');
  signal concat_i5 : std_logic_vector(ci_dsp48_concat_width-1 downto 0) := (others => '0');

  signal a_i4 : std_logic_vector(ci_dsp48_a_width-1 downto 0) := (others => '0');
  signal b_i4 : std_logic_vector(ci_dsp48_b_width-1 downto 0) := (others => '0');
  -- signal c_i4 : std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others => '0');
  signal m_r4 : std_logic_vector(ci_dsp48_amult_width+ci_dsp48_b_width-1 downto 0) := (others =>'0');

  signal c_i5 : std_logic_vector(ci_dsp48_c_width-1 downto 0) := (others =>'0');
  signal m_i5 : std_logic_vector(ci_dsp48_amult_width+ci_dsp48_b_width-1 downto 0) := (others =>'0');

  signal op_i0 : std_logic_vector(ci_opmode_width-1 downto 0) := (others =>'0');
  signal op_i1 : std_logic_vector(ci_opmode_width-1 downto 0) := (others =>'0');
  signal op_i2 : std_logic_vector(ci_opmode_width-1 downto 0) := (others =>'0');
  signal op_i3 : std_logic_vector(ci_opmode_width-1 downto 0) := (others =>'0');
  -- signal op_i4 : std_logic_vector(ci_opmode_width-1 downto 0) := (others =>'0');
  signal op_i5 : std_logic_vector(ci_opmode_width-1 downto 0) := (others =>'0');

  -- signal carryin_i1 : std_logic := '0';
  -- signal carryin_i2 : std_logic := '0';
  signal carryin_i3 : std_logic := '0';
  -- signal carryin_i4 : std_logic := '0';
  signal carryin_i5 : std_logic := '0';
  
  signal carryin_r3 : std_logic := '0';
  signal carryin_r5 : std_logic := '0';

  signal subtract_i : std_logic := '0';
  
  signal pcin_i      : std_logic_vector(ci_dsp48_p_width-1 downto 0)   := (others => '0');
  signal shift_pcin  : std_logic_vector(ci_dsp48_p_width-1 downto 0)   := (others => '0');
  signal shift_preg  : std_logic_vector(ci_dsp48_p_width-1 downto 0)   := (others => '0');
  signal x_i5 : std_logic_vector(ci_dsp48_p_width-1 downto 0)   := (others => '0');
  signal y_i5 : std_logic_vector(ci_dsp48_p_width-1 downto 0)   := (others => '0');
  signal z_i5 : std_logic_vector(ci_dsp48_p_width-1 downto 0)   := (others => '0');
  signal p_r5 : std_logic_vector(ci_dsp48_p_width+1-1 downto 0) := (others => '0');
  signal p_i6 : std_logic_vector(ci_dsp48_p_width+1-1 downto 0) := (others => '0');
  signal carryout_i6 : std_logic := '0';
  

  attribute use_dsp48 : string;
  attribute use_dsp48 of p_i6 : signal is "no";
  attribute use_dsp48 of m_i5 : signal is "no";
  attribute mult_style : string;
  attribute mult_style of m_i5 : signal is "lut";
begin

  -----------------------------------------------------------------------------
  -- Diagnostics
  -----------------------------------------------------------------------------
  diag_opmode_rom <= ci_opmode_rom;
  diag_macro_config <= ci_macro_config;
  
  --see bip_utils_v2_0 for 'simulating'. Basically, this code will only operate
  --when simulating, not for synthesis.
  i_runtime_checks : if simulating=1 generate
    i_proc : process (clk)
      variable opmode_str : string(1 to 50);
      variable opmode : std_logic_vector(ci_opmode_width-1 downto 0);
    begin
      --yes, deliberately falling edge clock. Since tools 'snoop' code I dare
      --not write an unsynthesizable 'wait'.
      if falling_edge(clk) then
        opmode     := op_i0;   -- i.e. ci_opmode_rom(to_integer(unsigned(SEL)));
        opmode_str := fn_interpret_opmode(opmode).disassembled;
        --Insert check for SUBTRACT with rounding here.
        assert C_VERBOSITY<2 report "opmode is "&opmode_str severity note;
        assert C_VERBOSITY<2 report "opmode = "&slv_to_str(opmode) severity note;
      end if;
    end process i_proc;
  end generate i_runtime_checks;

  -----------------------------------------------------------------------------
  -- Start of synth code.
  -----------------------------------------------------------------------------
  i_has_ce: if C_HAS_CE = 1 generate
    ce_i <= CE;
  end generate i_has_ce;
  i_has_sclr: if C_HAS_SCLR = 1 generate
    sclr_i <= SCLR;
  end generate i_has_sclr;

  -----------------------------------------------------------------------------
  -- Tier 1 (Mult path)
  -----------------------------------------------------------------------------
  i_has_a : if C_HAS_A /= 0 generate
    i_a1 : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY  => ci_pipe(ci_a1),
        C_HAS_CE   => C_HAS_CE,
        C_HAS_SCLR => C_HAS_SCLR,
        C_WIDTH    => C_A_WIDTH
        )
      port map(
        CLK  => CLK,
        CE   => ce_i,
        SCLR => sclr_i,
        D    => A,
        Q    => a_i1
        );
  end generate i_has_a;
  
  i_has_b : if C_HAS_B = 1 generate
    i_b1 : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY  => ci_pipe(ci_b1),
        C_HAS_CE   => C_HAS_CE,
        C_HAS_SCLR => C_HAS_SCLR,
        C_WIDTH    => C_B_WIDTH
        )
      port map(
        CLK  => CLK,
        CE   => ce_i,
        SCLR => sclr_i,
        D    => B,
        Q    => b_i1
        );
  end generate i_has_b;
  
  i_has_d : if C_HAS_D = 1 generate
    i_d1 : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY  => ci_pipe(ci_d1),
        C_HAS_CE   => C_HAS_CE,
        C_HAS_SCLR => C_HAS_SCLR,
        C_WIDTH    => C_D_WIDTH
        )
      port map(
        CLK  => CLK,
        CE   => ce_i,
        SCLR => sclr_i,
        D    => D,
        Q    => d_i1
        );
  end generate i_has_d;

  a_mux1 <= a_i1;
  b_mux1 <= b_i1 when op_i1(ci_opfield_abmux) = '0' else ci_b_one;
  
  -----------------------------------------------------------------------------
  -- Tier 2 (Mult path)
  -----------------------------------------------------------------------------
  i_a2 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_a2),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => C_A_WIDTH
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => a_mux1,
      Q    => a_i2
      );
  i_b2 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_b2),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => C_B_WIDTH
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => b_mux1,
      Q    => b_i2
      );
  i_d2 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_d2),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => C_D_WIDTH
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => d_i1,
      Q    => d_i2
      );

  i_mux_concat : if C_HAS_CONCAT = 1 generate
    concat_i2 <= std_logic_vector(resize(signed(CONCAT), ci_dsp48_concat_width));
    a_p2      <= concat_i2(ci_dsp48_a_width + ci_dsp48_b_width-1 downto ci_dsp48_b_width);
    b_p2      <= concat_i2(ci_dsp48_b_width-1 downto 0);
    i_has_d : if supports_dsp48a > 0 or supports_dsp48e1 > 0 generate
      d_r2 <= std_logic_vector(resize(signed(concat_i2(concat_i2'left downto ci_dsp48_a_width + ci_dsp48_b_width)), ci_dsp48_d_width));
    end generate i_has_d;
  end generate i_mux_concat;
  i_mux_no_concat : if C_HAS_CONCAT = 0 generate
    a_p2 <= std_logic_vector(resize(signed(a_i2), ci_dsp48_a_width));
    b_p2 <= std_logic_vector(resize(signed(b_i2), ci_dsp48_b_width));
    d_r2 <= std_logic_vector(resize(signed(d_i2), ci_dsp48_d_width));
  end generate i_mux_no_concat;

  i_acin: if C_HAS_ACIN /=0 generate
    a_r2 <= ACIN;
  end generate i_acin;
  i_no_acin: if C_HAS_ACIN=0 generate
    a_r2 <= std_logic_vector(resize(signed(a_p2),ci_dsp48_a_width));
  end generate i_no_acin;
  i_bcin: if C_HAS_BCIN /=0 generate
    b_r2 <= BCIN;
  end generate i_bcin;
  i_no_bcin: if C_HAS_BCIN=0 generate
    b_r2 <= std_logic_vector(resize(signed(b_p2),ci_dsp48_b_width));
  end generate i_no_bcin;

  -----------------------------------------------------------------------------
  -- Tier3 Mult path
  -----------------------------------------------------------------------------
  i_a3 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_a3),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => ci_dsp48_a_width
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => a_r2,
      Q    => a_i3
      );
  i_b3 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_b3),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => ci_dsp48_b_width
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => b_r2,
      Q    => b_i3
      );
  i_has_d3: if C_HAS_D = 1 or (C_HAS_CONCAT = 1 and supports_dsp48a>0) generate
    i_d3 : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY  => ci_pipe(ci_d3),
        C_HAS_CE   => C_HAS_CE,
        C_HAS_SCLR => C_HAS_SCLR,
        C_WIDTH    => ci_dsp48_d_width
        )
      port map(
        CLK  => CLK,
        CE   => ce_i,
        SCLR => sclr_i,
        D    => d_r2,
        Q    => d_i3
        );
  end generate i_has_d3;

  -----------------------------------------------------------------------------
  -- pre-adder (tier 3 of Mult path)
  -----------------------------------------------------------------------------
  i_v6_preadder: if supports_DSP48E1>0 generate
    a_r3 <= a_i3                                                           when op_i3(ti_opfield_preadd) = "00000" else   --  "00001"
            std_logic_vector(resize(signed(d_i3),ci_dsp48_a_width)) + a_i3 when op_i3(ti_opfield_preadd) = "00100" else   --  "00101"
            std_logic_vector(resize(signed(d_i3),ci_dsp48_a_width)) - a_i3 when op_i3(ti_opfield_preadd) = "01100" else   --  "01101"
            - a_i3                                                         when op_i3(ti_opfield_preadd) = "01000" else   --  "01001"
            std_logic_vector(resize(signed(d_i3),ci_dsp48_a_width));
    b_r3 <= b_i3;
  end generate i_v6_preadder;
  i_spartan_preadder: if supports_dsp48a>0 generate
    a_r3 <= a_i3        when op_i3(ti_opfield_preadd) = "00000" else
            d_i3 + a_i3 when op_i3(ti_opfield_preadd) = "00001" else
            d_i3 - a_i3;
    b_r3 <= b_i3;
  end generate i_spartan_preadder;
  i_no_preadder: if supports_dsp48a=0 and supports_dsp48e1=0 generate
    a_r3 <= a_i3;
    b_r3 <= b_i3;
  end generate i_no_preadder;

  -----------------------------------------------------------------------------
  -- Concat bus (tier 3 of Mult path)
  -----------------------------------------------------------------------------
  i_spartan_concat: if supports_dsp48a>0 generate
    signal concat_temp : std_logic_vector(ci_dsp48_d_width+ci_dsp48_a_width+ci_dsp48_b_width-1 downto 0) := (others => '0');
  begin
    concat_temp <= d_i3&a_i3&b_i3;
    concat_i3 <= concat_temp(ci_dsp48_concat_width-1 downto 0);
  end generate i_spartan_concat;
  i_virtex_concat: if not(supports_dsp48a>0) generate
    signal concat_temp : std_logic_vector(ci_dsp48_a_width+ci_dsp48_b_width-1 downto 0) := (others => '0');
  begin
    concat_temp <= a_i3&b_i3;    
    concat_i3 <= concat_temp(ci_dsp48_concat_width-1 downto 0);
  end generate i_virtex_concat;

  -----------------------------------------------------------------------------
  -- Tier 4 and 5 (Concat path)
  -- These registers are unusual. They are to balance C4 and C5. Since they
  -- dont exist in the primitive, they are invented. In the synth model, they
  -- preced the A, B, D ports.
  -----------------------------------------------------------------------------
  i_concat45 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_concat4)+ci_pipe(ci_concat5),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => ci_dsp48_concat_width
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => concat_i3,
      Q    => concat_i5
      );
  
  -----------------------------------------------------------------------------
  -- Tier 4 (Mult path)
  -----------------------------------------------------------------------------

  i_a4 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_a4),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => ci_dsp48_a_width
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => a_r3,
      Q    => a_i4
      );
  i_b4 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_b4),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => ci_dsp48_b_width
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => b_r3,
      Q    => b_i4
      );
  BCOUT <= b_i4;
  
  -- Note: On DSP48A the a(b)cout is taken from after the preadder, when DSP48E1 it is taken from the a path but will 
  -- always have A2 (normally ci_a4) set to zero but ADreg will be set for ci_a4 instead to keep the pipeline OK, can't use
  -- A1 as the input to the pre-adder as it can't be disabled for 0 lat but if A2 is used then can have 0 lat.
  ACOUT <= a_i4 when not(C_HAS_D=1 and supports_dsp48e1>0) else a_i3;
  
  -- i_acout4 : xbip_pipe_v2_0_xst
    -- generic map(
      -- C_LATENCY  => fn_select_int(ci_pipe(ci_a4),0,not(C_HAS_D=1 and supports_dsp48e1>0)),--ci_pipe(ci_a4),
      -- C_HAS_CE   => C_HAS_CE,
      -- C_HAS_SCLR => C_HAS_SCLR,
      -- C_WIDTH    => ci_dsp48_a_width
      -- )
    -- port map(
      -- CLK  => CLK,
      -- CE   => ce_i,
      -- SCLR => sclr_i,
      -- D    => a_i3,
      -- Q    => ACOUT
      -- );

  m_r4 <= a_i4(ci_dsp48_amult_width-1 downto 0) * b_i4;

  -----------------------------------------------------------------------------
  -- Tier 5 (Mult path)
  -----------------------------------------------------------------------------
  i_m5 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_m5),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => ci_dsp48_amult_width+ci_dsp48_b_width
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => m_r4,
      Q    => m_i5 
      );

  -----------------------------------------------------------------------------
  -- Tier 0, 1, 2 and 3 (C Path)
  -----------------------------------------------------------------------------
  i_has_c: if C_HAS_C/=0 generate
    i_c123 : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY  => ci_pipe(ci_c1)+ci_pipe(ci_c2)+ci_pipe(ci_c3),
        C_HAS_CE   => C_HAS_CE,
        C_HAS_SCLR => C_HAS_SCLR,
        C_WIDTH    => C_C_WIDTH
        )
      port map(
        CLK  => CLK,
        CE   => ce_i,
        SCLR => sclr_i,
        D    => C,
        Q    => c_i3 
        );
  end generate i_has_c;
  c_r3 <= std_logic_vector(resize(signed(c_i3),ci_dsp48_c_width)) when op_i3(ci_opfield_cmux)= '0' else
          ci_round_const;

  -----------------------------------------------------------------------------
  -- Tier 4 (C Path)
  -----------------------------------------------------------------------------
  i_c45 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_c4)+ci_pipe(ci_c5),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => ci_dsp48_c_width
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => c_r3,
      Q    => c_i5 
      );
  
  -----------------------------------------------------------------------------
  -- OPMODE 
  -----------------------------------------------------------------------------

  op_i0   <= ci_opmode_rom(to_integer(unsigned(SEL))) when C_SEL_WIDTH>0 else
             ci_opmode_rom(0);
       
  i_op1 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_op1),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => ci_opmode_width
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => op_i0,
      Q    => op_i1 
      );
   i_op2 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_op2),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => ci_opmode_width
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => op_i1,
      Q    => op_i2 
      );
   i_op3 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_op3),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => ci_opmode_width
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => op_i2,
      Q    => op_i3 
      );
  i_op45 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_op4)+ci_pipe(ci_op5),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => ci_opmode_width
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => op_i3,
      Q    => op_i5 
      );

  -----------------------------------------------------------------------------
  -- Carryin 
  -----------------------------------------------------------------------------
  i_carryin123 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_carryin1)+ci_pipe(ci_carryin2)+ci_pipe(ci_carryin3),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => 1
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D(0)    => CARRYIN,
      Q(0)    => carryin_i3 
      );
  
  carryin_r3 <= '0' when op_i3(ci_opfield_carryin)='0' else
                carryin_i3;
  
  i_carryin45 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_carryin4)+ci_pipe(ci_carryin5),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => 1
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D(0)    => carryin_r3,
      Q(0)    => carryin_i5 
      );
      
  --Spartan
  i_spartan_carryin: if supports_dsp48a>0 generate
    i_use_carrycascin: if C_HAS_CARRYCASCIN = 1 generate
      -- carryin_r5 <= CARRYCASCIN;
      i_carrycascin5: xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY  => ci_pipe(ci_carryin5),
        C_HAS_CE   => C_HAS_CE,
        C_HAS_SCLR => C_HAS_SCLR,
        C_WIDTH    => 1
        )
      port map(
        CLK  => CLK,
        CE   => ce_i,
        SCLR => sclr_i,
        D(0)    => CARRYCASCIN,
        Q(0)    => carryin_r5 
        );
    end generate i_use_carrycascin;
    i_no_use_carrycascin: if C_HAS_CARRYCASCIN = 0 generate
      carryin_r5 <= carryin_i5;
    end generate i_no_use_carrycascin;
  end generate i_spartan_carryin;

  --V4 and non-dsp48 families
  i_v4_and_non_dsp_carryin: if has_dsp48 or not (has_dsp) generate
    signal carry_rnd_i4 : std_logic := '0';
    signal carry_rnd_i5 : std_logic := '0';
  begin
    -- carry_rnd_i4 <= NOT(A(A'LEFT)) when op_i5(ti_opfield_xmux) = "01" else
                    -- A(A'LEFT) xnor B(B'LEFT);
    carry_rnd_i4 <= NOT(a_i4(ci_dsp48_amult_width-1)) when op_i5(ti_opfield_xmux) = "11" else
                    a_i4(ci_dsp48_amult_width-1) xnor b_i4(b_i4'LEFT);                    
    i_carryrnd5 : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY  => 1,--ci_pipe(ci_m5),
        C_HAS_CE   => C_HAS_CE,
        C_HAS_SCLR => C_HAS_SCLR,
        C_WIDTH    => 1
        )
      port map(
        CLK  => CLK,
        CE   => ce_i,
        SCLR => sclr_i,
        D(0) => carry_rnd_i4,
        Q(0) => carry_rnd_i5
        );
    
    carryin_r5 <= carryin_i5                    when op_i5(ti_opfield_carrysel) = "000" else
                  NOT(z_i5(ci_dsp48_p_width-1)) when op_i5(ti_opfield_carrysel) = "001" else
                  carry_rnd_i4                  when op_i5(ti_opfield_carrysel) = "010" else
                  carry_rnd_i5                  when op_i5(ti_opfield_carrysel) = "011" else
                  'X';      --opmode out of range
                  
  end generate i_v4_and_non_dsp_carryin;

  --V5, V6 and beyoooond
  i_v5on_carryin: if supports_dsp48e>0 generate
    signal carry_rnd_i4 : std_logic := '0';
    signal carry_rnd_i5 : std_logic := '0';
    signal carrycascin_i : std_logic := '0';
  begin
    -- carry_rnd_i4 <= A(A'LEFT) xnor B(B'LEFT);
    carry_rnd_i4 <= a_i4(ci_dsp48_amult_width-1) xnor b_i4(b_i4'LEFT);
    i_carryrnd5 : xbip_pipe_v2_0_xst
      generic map(
        C_LATENCY  => ci_pipe(ci_m5),
        C_HAS_CE   => C_HAS_CE,
        C_HAS_SCLR => C_HAS_SCLR,
        C_WIDTH    => 1
        )
      port map(
        CLK  => CLK,
        CE   => ce_i,
        SCLR => sclr_i,
        D(0) => carry_rnd_i4,
        Q(0) => carry_rnd_i5
        );
   
   carrycascin_i <= CARRYCASCIN when C_HAS_CARRYCASCIN=1 else '0';
   
   carryin_r5 <= carryin_i5             when op_i5(ti_opfield_carrysel) = "000" else
                 not (PCIN(PCIN'LEFT))  when op_i5(ti_opfield_carrysel) = "001" else
                 carrycascin_i          when op_i5(ti_opfield_carrysel) = "010" else
                 (PCIN(PCIN'LEFT))      when op_i5(ti_opfield_carrysel) = "011" else
                 p_i6(p_i6'LEFT)        when op_i5(ti_opfield_carrysel) = "100" else
                 not(p_i6(p_i6'LEFT-1)) when op_i5(ti_opfield_carrysel) = "101" else
                 carry_rnd_i5           when op_i5(ti_opfield_carrysel) = "110" else
                 p_i6(p_i6'LEFT-1)      when op_i5(ti_opfield_carrysel) = "111" else
                 'X'; --opmode out of range, avoid latch errors
  end generate i_v5on_carryin;

  -----------------------------------------------------------------------------
  -- X, Y, Z Mux and postadder
  -----------------------------------------------------------------------------
  subtract_i <= op_i5(ci_opfield_subtract);
  pcin_i     <= PCIN when C_HAS_PCIN/=0 else (others=>'0');-- required to avoid map errors on mux inputs being undriven
  shift_pcin <= std_logic_vector(resize(signed(pcin_i(pcin_i'LEFT downto 17)),ci_dsp48_p_width));
  shift_preg <= std_logic_vector(resize(signed(p_i6(ci_dsp48_p_width-1 downto 17)),ci_dsp48_p_width));
  
  x_i5 <= (others => '0')                                             when op_i5(ti_opfield_xmux) = "00" else
          std_logic_vector(resize(signed(m_i5),ci_dsp48_p_width))     when op_i5(ti_opfield_xmux) = "01" else
          p_i6(ci_dsp48_p_width-1 downto 0)                           when op_i5(ti_opfield_xmux) = "10" else
          std_logic_vector(resize(signed(concat_i5),ci_dsp48_p_width)) when op_i5(ti_opfield_xmux) = "11" else
          (others => 'X');
  y_i5 <= (others => '0')                   when op_i5(ti_opfield_ymux) = "00" else
          (others => '0')                   when op_i5(ti_opfield_ymux) = "01" else --
          --only need to add the mult_result once!
          p_i6(ci_dsp48_p_width-1 downto 0) when op_i5(ti_opfield_ymux) = "10" else
          c_i5                              when op_i5(ti_opfield_ymux) = "11" else
          (others => 'X');
  z_i5 <= (others => '0')                   when op_i5(ti_opfield_zmux) = "000" else
          pcin_i                            when op_i5(ti_opfield_zmux) = "001" else
          p_i6(ci_dsp48_p_width-1 downto 0) when op_i5(ti_opfield_zmux) = "010" else
          c_i5                              when op_i5(ti_opfield_zmux) = "011" else
          shift_pcin                        when op_i5(ti_opfield_zmux) = "101" else
          shift_preg                        when op_i5(ti_opfield_zmux) = "110" else
          (others => 'X');
  p_r5 <= ('0'&z_i5) + (('0'&x_i5) + ('0'&y_i5) + carryin_r5) when subtract_i = '0' else
          ('0'&z_i5) - (('0'&x_i5) + ('0'&y_i5) + carryin_r5);
--  carryout_i <= p_r5(p_r5'left) xor subtract_i;

  i_p6 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_p6),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => ci_dsp48_p_width+1
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D    => p_r5,
      Q    => p_i6 
      );

  i_carryout6 : xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_carryout6),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => 1
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D(0) => p_r5(p_r5'LEFT),
      Q(0) => carryout_i6 
      );

  --Only Vx5 has fabric carryout
  i_vx5_carryout: if supports_dsp48e>0 generate
    signal carryout_r5: std_logic;
    signal carrycascout_r5: std_logic;
  begin
    --Need to duplicate X on CARRYOUT with multiplier is used
    --Invert for V5 when subtract, V6 produces a fabric compatible carryout
    carryout_r5 <= 'X'                 when op_i5(ti_opfield_xmux) = "01" and C_MODEL_TYPE=0 else -- when used for behavoural model for synth core to match unisim/simprim
                   '0'                 when op_i5(ti_opfield_xmux) = "01" and C_MODEL_TYPE=1 else
                   not p_r5(p_i6'LEFT) when op_i5(ci_opfield_subtract) = '1' and supports_dsp48e>0 else 
                   p_r5(p_i6'LEFT);
                   
    --When subtract carryout is inverted compared to normal/fabric carry chain implementation 
    carrycascout_r5 <= --not p_r5(p_i6'LEFT) when op_i5(ci_opfield_subtract) = '1' else
                       p_r5(p_i6'LEFT);
    
    i_carryout6: xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_p6),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => 1
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D(0)    => carryout_r5,
      Q(0)    => CARRYOUT 
      );
      
    i_carrycaseout6: xbip_pipe_v2_0_xst
    generic map(
      C_LATENCY  => ci_pipe(ci_p6),
      C_HAS_CE   => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_WIDTH    => 1
      )
    port map(
      CLK  => CLK,
      CE   => ce_i,
      SCLR => sclr_i,
      D(0)    => carrycascout_r5,
      Q(0)    => CARRYCASCOUT 
      );
  end generate i_vx5_carryout;
  i_sp3adsp_carryout: if supports_dsp48a=1 generate
    --Bugfix note: the register of the carrycasc for sp3adsp is actually on the
    --input which differs from this description, but since it only applies when
    --dsps are cascaded, the fact that this model doesn't match the primitive
    --isn't a problem. However, the code is kept separate in case it becomes one.
--    CARRYCASCOUT   <= preg(preg'LEFT);
--    CARRYCASCOUT <= p_i(p_i'LEFT);
    CARRYCASCOUT <= p_r5(p_r5'LEFT);
  end generate i_sp3adsp_carryout;
  i_sp6_carryout: if supports_dsp48a1 > 0 generate
    CARRYCASCOUT <= carryout_i6;
    CARRYOUT     <= carryout_i6;
  end generate i_sp6_carryout;
  
  P     <= p_i6(C_P_MSB downto C_P_LSB);
  
  PCOUT <= p_i6(ci_dsp48_p_width-1 downto 0);
end behavioral;

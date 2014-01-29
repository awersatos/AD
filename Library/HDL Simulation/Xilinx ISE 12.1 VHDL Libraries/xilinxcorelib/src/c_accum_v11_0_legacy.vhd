-- $RCSfile: c_accum_v11_0_legacy.vhd,v $  $Revision: 1.4 $  $Date: 2009/12/04 11:46:40 $

--  (c) Copyright 1995-2005, 2009 Xilinx, Inc. All rights reserved.
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
-- Filename - c_accum_v11_0.vhd
-- Author - Xilinx
-- Creation - 1 Oct 3 2008
--
-- Description - This file contains the behavior for
-- the c_accum_v11_0 core

library IEEE;
use IEEE.std_logic_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.bip_utils_pkg_v2_0.all;
use XilinxCoreLib.c_addsub_pkg_v11_0.all;
use XilinxCoreLib.c_reg_fd_v11_0_comp.all;
use XilinxCoreLib.c_accum_pkg_v11_0.all;

-- (A)Synchronous Accumulator
--

entity c_accum_v11_0_legacy is
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
end c_accum_v11_0_legacy;

architecture behavioral of c_accum_v11_0_legacy is

  -- Local types:
  type T_BYPASS_ENABLE is (CE_OVERRIDES_BYPASS, BYPASS_OVERRIDES_CE);

  function fn_select_bypass_enable (c_bypass_enable                    : integer) return T_BYPASS_ENABLE is
    variable ret_val                                                   : t_bypass_enable;
  begin
    case c_bypass_enable is
      when c_override    => ret_val := BYPASS_OVERRIDES_CE;
      when c_no_override => ret_val := CE_OVERRIDES_BYPASS;
      when others        => assert false report "ERROR - c_accum_v11_0_legacy : Invalid value found in c_bypass_enable"
                       severity failure;
    end case;
    return ret_val;
  end;

  -- Clean versions of generics:
  constant enum_c_add_mode      : T_ADD_MODE      := fn_select_add_mode (c_add_mode);
  constant enum_c_bypass_enable : T_BYPASS_ENABLE := fn_select_bypass_enable(c_bypass_enable);
  constant enum_c_sync_enable   : T_SYNC_ENABLE   := fn_select_sync_enable(c_sync_enable);
  constant enum_c_sync_priority : T_REG_PRIORITY  := fn_select_sync_priority(c_sync_priority);
  constant enum_c_b_type        : T_NUMBER_FORMAT := fn_select_number_format(c_b_type);

  constant ci_ainit_val : std_logic_vector(c_out_width - 1 downto 0) := str_to_bound_slv_0(c_ainit_val, c_out_width);
  constant ci_sinit_val : std_logic_vector(c_out_width - 1 downto 0) := str_to_bound_slv_0(c_sinit_val, c_out_width);
  constant ci_b_value   : std_logic_vector(c_b_width - 1 downto 0)   := str_to_bound_slv_0(c_b_value, c_b_width);

  -- The following line should make sure that check_generics
  -- is called on instantiation
  constant check_gens : integer := fn_c_accum_v11_0_legacy_check_generics(
    c_verbosity           => c_verbosity,
    c_use_dsp48           => c_use_dsp48,
    c_family              => c_family,
    c_b_width             => c_b_width,
    c_out_width           => c_out_width,
    c_low_bit             => c_low_bit,
    c_high_bit            => c_high_bit,
    c_add_mode            => c_add_mode,
    c_b_type              => c_b_type,
    c_b_constant          => c_b_constant,
    c_b_value             => c_b_value,
    c_scale               => c_scale,
    c_saturate            => c_saturate,
    c_ainit_val           => c_ainit_val,
    c_sinit_val           => c_sinit_val,
    c_bypass_enable       => c_bypass_enable,
    c_bypass_low          => c_bypass_low,
    c_sync_enable         => c_sync_enable,
    c_sync_priority       => c_sync_priority,
    c_pipe_stages         => c_pipe_stages,
    c_has_s               => c_has_s,
    c_has_c_in            => c_has_c_in,
    c_has_c_out           => c_has_c_out,
    c_has_q_c_out         => c_has_q_c_out,
    c_has_b_in            => c_has_b_in,
    c_has_b_out           => c_has_b_out,
    c_has_q_b_out         => c_has_q_b_out,
    c_has_ovfl            => c_has_ovfl,
    c_has_q_ovfl          => c_has_q_ovfl,
    c_has_ce              => c_has_ce,
    c_has_add             => c_has_add,
    c_has_bypass          => c_has_bypass,
    c_has_b_signed        => c_has_b_signed,
    c_has_aclr            => c_has_aclr,
    c_has_aset            => c_has_aset,
    c_has_ainit           => c_has_ainit,
    c_has_sclr            => c_has_sclr,
    c_has_sset            => c_has_sset,
    c_has_sinit           => c_has_sinit,
    c_has_bypass_with_cin => c_has_bypass_with_cin,
    enum_c_add_mode       => enum_c_add_mode,
    enum_c_b_type         => enum_c_b_type,
    c_enable_rlocs        => c_enable_rlocs
    );


  -- signals for optional pins...

  signal intS             : std_logic_vector(C_OUT_WIDTH-1 downto 0);
  signal intFB            : std_logic_vector(C_OUT_WIDTH-1 downto 0);
  signal intFBq           : std_logic_vector(C_OUT_WIDTH-1 downto 0);
  signal intB_SIGNED      : std_logic;
  signal intC_OUT         : std_logic;
  signal intB_OUT         : std_logic;
  signal intSCLR          : std_logic;
  signal intSSET          : std_logic;
  signal intSCLR_TO_ADDER : std_logic;
  signal intSSET_TO_ADDER : std_logic;
  signal intSCLR_TO_MSB   : std_logic;
  signal intSSET_TO_MSB   : std_logic;
  signal intSCLR_TO_REST  : std_logic;
  signal intSSET_TO_REST  : std_logic;
  signal intSCLRbase      : std_logic;
  signal intSSETbase      : std_logic;
  signal intCE            : std_logic;
  signal intB             : std_logic;
  signal tempCE           : std_logic;
  signal tmpB             : std_logic_vector(C_B_WIDTH-1 downto 0) := (others => 'X');

  -- pipelining signals

  function getAType(C_TYPE : integer) return integer is
  begin
    if C_TYPE = c_pin then
      return c_signed;
    else
      return C_TYPE;
    end if;
  end getAType;


  function setSyncEnable(C_HAS_CE, C_HAS_SSET, C_HAS_SCLR, C_SYNC_ENABLE, C_SATURATE : integer) return integer is
  begin
    if (C_SATURATE = 1 and (C_HAS_CE = 1 and (C_HAS_SSET = 1 or C_HAS_SCLR = 1 ) and C_SYNC_ENABLE = 0)) then
      return 1;
    else
      return C_SYNC_ENABLE;
    end if;
  end setSyncEnable;


begin

  -- Deal with optional pins...
  bs1 : if C_HAS_B_SIGNED = 1 generate
    intB_SIGNED <= B_SIGNED;
  end generate;
  bs0 : if not (C_HAS_B_SIGNED = 1) generate
    intB_SIGNED <= '0';
  end generate;

  sclr1 : if C_HAS_SCLR = 1 generate
    intSCLR <= SCLR;
  end generate;
  sclr0 : if not(C_HAS_SCLR = 1) generate
    intSCLR <= '0';
  end generate;

  ss1 : if C_HAS_SSET = 1 generate
    intSSET <= SSET;
  end generate;
  ss0 : if not(C_HAS_SSET = 1) generate
    intSSET <= '0';
  end generate;

  strconvconst1 : if C_B_CONSTANT = 1 generate
    tmpB <= str_to_bound_slv_0(C_B_VALUE, C_B_WIDTH);
  end generate;

  strconvconst0 : if not (C_B_CONSTANT = 1) generate
    tmpB <= B;
  end generate;

  -- Deal with the saturation logic. 
  -- The adder ALWAYS has SCLR and SSET inputs and C_OUT and B_OUT outputs.
  -- The correct values must be placed on the inputs depending on the
  -- Saturation setting and the availability of those signals from outside.
  sat0     : if not(C_SATURATE = 1) generate
    -- Instanciate an addsub module
    addsub : c_addsub_v11_0_legacy
      generic map (
        C_A_WIDTH             => C_OUT_WIDTH,
        C_B_WIDTH             => C_B_WIDTH,
        C_OUT_WIDTH           => C_OUT_WIDTH,
        C_LOW_BIT             => 0,
        C_HIGH_BIT            => C_OUT_WIDTH-1,
        C_ADD_MODE            => C_ADD_MODE,
        C_A_TYPE              => getAType(C_B_TYPE),
        C_B_TYPE              => C_B_TYPE,
        C_B_CONSTANT          => C_B_CONSTANT,
        C_B_VALUE             => C_B_VALUE,
        C_AINIT_VAL           => C_AINIT_VAL,
        C_SINIT_VAL           => C_SINIT_VAL,
        C_BYPASS_ENABLE       => C_BYPASS_ENABLE,
        C_BYPASS_LOW          => C_BYPASS_LOW,
        C_SYNC_ENABLE         => C_SYNC_ENABLE,
        C_SYNC_PRIORITY       => C_SYNC_PRIORITY,
        C_PIPE_STAGES         => C_PIPE_STAGES,
        C_HAS_S               => C_HAS_S,
        C_HAS_Q               => 1,
        C_HAS_C_IN            => C_HAS_C_IN,
        C_HAS_C_OUT           => C_HAS_C_OUT,
        C_HAS_Q_C_OUT         => C_HAS_Q_C_OUT,
        C_HAS_B_IN            => C_HAS_B_IN,
        C_HAS_B_OUT           => C_HAS_B_OUT,
        C_HAS_Q_B_OUT         => C_HAS_Q_B_OUT,
        C_HAS_OVFL            => C_HAS_OVFL,
        C_HAS_Q_OVFL          => C_HAS_Q_OVFL,
        C_HAS_CE              => C_HAS_CE,
        C_HAS_ADD             => C_HAS_ADD,
        C_HAS_BYPASS          => C_HAS_BYPASS,
        C_HAS_A_SIGNED        => C_HAS_B_SIGNED,
        C_HAS_B_SIGNED        => C_HAS_B_SIGNED,
        C_HAS_ACLR            => C_HAS_ACLR,
        C_HAS_ASET            => C_HAS_ASET,
        C_HAS_AINIT           => C_HAS_AINIT,
        C_HAS_SCLR            => C_HAS_SCLR,
        C_HAS_SSET            => C_HAS_SSET,
        C_HAS_SINIT           => C_HAS_SINIT,
        C_HAS_BYPASS_WITH_CIN => C_HAS_BYPASS_WITH_CIN,
        C_ENABLE_RLOCS        => C_ENABLE_RLOCS
        )
      port map (
        A                     => intFB,
        B                     => B,
        CLK                   => CLK,
        ADD                   => ADD,
        C_IN                  => C_IN,
        B_IN                  => B_IN,
        CE                    => CE,
        BYPASS                => BYPASS,
        ACLR                  => ACLR,
        ASET                  => ASET,
        AINIT                 => AINIT,
        SCLR                  => SCLR,
        SSET                  => SSET,
        SINIT                 => SINIT,
        A_SIGNED              => B_SIGNED,
        B_SIGNED              => B_SIGNED,
        OVFL                  => OVFL,
        C_OUT                 => intC_OUT,
        B_OUT                 => intB_OUT,
        Q_OVFL                => Q_OVFL,
        Q_C_OUT               => Q_C_OUT,
        Q_B_OUT               => Q_B_OUT,
        S                     => intS,
        Q                     => intFBq
        );
  end generate;  -- sat0

  sat1         : if C_SATURATE = 1 generate  -- We DO want saturation logic
    unsinsat1  : if C_B_TYPE = c_unsigned and C_ADD_MODE = c_add generate  -- Unsigned adder
      sata     : if not(C_HAS_SSET = 1) and not(C_HAS_SCLR = 1) generate
        intSSET_TO_ADDER <= intC_OUT;
        intSCLR_TO_ADDER <= intSCLR;
      end generate;
      satb     : if not(C_HAS_SSET = 1) and C_HAS_SCLR = 1 generate
        intSSET_TO_ADDER <= intC_OUT and not(intSCLR);
        intSCLR_TO_ADDER <= intSCLR;
      end generate;
      satc     : if C_HAS_SSET = 1 and not(C_HAS_SCLR = 1) generate
        intSSET_TO_ADDER <= intC_OUT or intSSET;
        intSCLR_TO_ADDER <= intSCLR;
      end generate;
      satd     : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
        intSSET_TO_ADDER <= not(intSCLR) and (intC_OUT or intSSET);
        intSCLR_TO_ADDER <= intSCLR;
      end generate;
      sate     : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
        intSSET_TO_ADDER <= intSSET or (intC_OUT and not(intSCLR));
        intSCLR_TO_ADDER <= intSCLR and not(intSSET);
      end generate;
    end generate;  -- unsinsat1
    unsinsat2  : if C_B_TYPE = c_unsigned and C_ADD_MODE = c_sub and (C_HAS_BYPASS = 0) generate  -- Unsigned adder
      sata     : if not(C_HAS_SSET = 1) and not(C_HAS_SCLR = 1) generate
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= not(intB_OUT);
      end generate;
      satb     : if not(C_HAS_SSET = 1) and C_HAS_SCLR = 1 generate
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= not(intB_OUT) or intSCLR;
      end generate;
      satc     : if C_HAS_SSET = 1 and not(C_HAS_SCLR = 1) generate
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= not(intB_OUT) and not(intSSET);
      end generate;
      satd     : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
        intSSET_TO_ADDER <= intSSET and not(intSCLR);
        intSCLR_TO_ADDER <= intSCLR or (not(intB_OUT) and not(intSSET));
      end generate;
      sate     : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (not intSSET) and (intSCLR or not(intB_OUT));
      end generate;
    end generate;  -- unsinsat2
    unsinsat2a : if C_B_TYPE = c_unsigned and C_ADD_MODE = c_sub and (C_HAS_BYPASS = 1 and C_BYPASS_LOW = 1) generate  -- Unsigned adder
      sata     : if not(C_HAS_SSET = 1) and not(C_HAS_SCLR = 1) generate
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (not(intB_OUT) and BYPASS);
      end generate;
      satb     : if not(C_HAS_SSET = 1) and C_HAS_SCLR = 1 generate
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (not(intB_OUT) and BYPASS)or intSCLR;
      end generate;
      satc     : if C_HAS_SSET = 1 and not(C_HAS_SCLR = 1) generate
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (not(intB_OUT) and BYPASS) and not(intSSET);
      end generate;
      satd     : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
        intSSET_TO_ADDER <= intSSET and not(intSCLR);
        intSCLR_TO_ADDER <= intSCLR or ((not(intB_OUT) and BYPASS) and not(intSSET));
      end generate;
      sate     : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (not intSSET) and (intSCLR or (not(intB_OUT) and BYPASS));
      end generate;
    end generate;  -- unsinsat2a
    unsinsat2b : if C_B_TYPE = c_unsigned and C_ADD_MODE = c_sub and (C_HAS_BYPASS = 1 and C_BYPASS_LOW = 0) generate  -- Unsigned adder
      sata     : if not(C_HAS_SSET = 1) and not(C_HAS_SCLR = 1) generate
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (not(intB_OUT) and not(BYPASS));
      end generate;
      satb     : if not(C_HAS_SSET = 1) and C_HAS_SCLR = 1 generate
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (not(intB_OUT) and not(BYPASS))or intSCLR;
      end generate;
      satc     : if C_HAS_SSET = 1 and not(C_HAS_SCLR = 1) generate
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (not(intB_OUT) and not(BYPASS)) and not(intSSET);
      end generate;
      satd     : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
        intSSET_TO_ADDER <= intSSET and not(intSCLR);
        intSCLR_TO_ADDER <= intSCLR or ((not(intB_OUT) and not(BYPASS)) and not(intSSET));
      end generate;
      sate     : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
        intSSET_TO_ADDER <= intSSET;
        intSCLR_TO_ADDER <= (not intSSET) and (intSCLR or (not(intB_OUT) and not(BYPASS)));
      end generate;
    end generate;  -- unsinsat2b
    unsinsat3  : if C_B_TYPE = c_unsigned and C_ADD_MODE = c_add_sub and (C_HAS_BYPASS = 0) generate  -- Unsigned adder
      sata     : if not(C_HAS_SSET = 1) and not(C_HAS_SCLR = 1) generate
        intSSET_TO_ADDER <= intC_OUT and ADD;
        intSCLR_TO_ADDER <= (not(intC_OUT) and not(ADD));
      end generate;
      satb     : if not(C_HAS_SSET = 1) and C_HAS_SCLR = 1 generate
        intSSET_TO_ADDER <= intC_OUT and not(intSCLR) and ADD;
        intSCLR_TO_ADDER <= intSCLR or (not(intC_OUT) and not(ADD));
      end generate;
      satc     : if C_HAS_SSET = 1 and not(C_HAS_SCLR = 1) generate
        intSSET_TO_ADDER <= (intC_OUT and ADD) or intSSET;
        intSCLR_TO_ADDER <= not(intSSET) and (not(intC_OUT) and not(ADD));
      end generate;
      satd     : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
        intSSET_TO_ADDER <= (not(intSCLR) and intC_OUT and ADD) or (intSSET and not(intSCLR));
        intSCLR_TO_ADDER <= intSCLR or (not(intSSET) and not(intC_OUT) and not(ADD));
      end generate;
      sate     : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
        intSSET_TO_ADDER <= intSSET or (intC_OUT and ADD and not(intSCLR));
        intSCLR_TO_ADDER <= (intSCLR and not(intSSET)) or (not(intSSET) and not(intC_OUT) and not(ADD));
      end generate;
    end generate;  -- unsinsat3

    unsinsat4 : if C_B_TYPE = c_unsigned and C_ADD_MODE = c_add_sub and (C_HAS_BYPASS = 1 and (C_BYPASS_LOW = 1)) generate  -- Unsigned adder
      sata    : if not(C_HAS_SSET = 1) and not(C_HAS_SCLR = 1) generate
        intSSET_TO_ADDER <= intC_OUT and ADD;
        intSCLR_TO_ADDER <= (not(intC_OUT) and not(ADD) and BYPASS);
      end generate;
      satb    : if not(C_HAS_SSET = 1) and C_HAS_SCLR = 1 generate
        intSSET_TO_ADDER <= intC_OUT and not(intSCLR) and ADD;
        intSCLR_TO_ADDER <= intSCLR or (not(intC_OUT) and not(ADD) and BYPASS);
      end generate;
      satc    : if C_HAS_SSET = 1 and not(C_HAS_SCLR = 1) generate
        intSSET_TO_ADDER <= (intC_OUT and ADD) or intSSET;
        intSCLR_TO_ADDER <= not(intSSET) and (not(intC_OUT) and not(ADD) and BYPASS);
      end generate;
      satd    : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
        intSSET_TO_ADDER <= (not(intSCLR) and intC_OUT and ADD) or (intSSET and not(intSCLR));
        intSCLR_TO_ADDER <= intSCLR or (not(intSSET) and not(intC_OUT) and not(ADD) and BYPASS);
      end generate;
      sate    : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
        intSSET_TO_ADDER <= intSSET or (intC_OUT and ADD and not(intSCLR));
        intSCLR_TO_ADDER <= (intSCLR and not(intSSET)) or (not(intSSET) and not(intC_OUT) and not(ADD) and BYPASS);
      end generate;
    end generate;  -- unsinsat4

    unsinsat5 : if C_B_TYPE = c_unsigned and C_ADD_MODE = c_add_sub and (C_HAS_BYPASS = 1 and (C_BYPASS_LOW = 0)) generate  -- Unsigned adder
      sata    : if not(C_HAS_SSET = 1) and not(C_HAS_SCLR = 1) generate
        intSSET_TO_ADDER <= intC_OUT and ADD;
        intSCLR_TO_ADDER <= (not(intC_OUT) and not(ADD) and not(BYPASS));
      end generate;
      satb    : if not(C_HAS_SSET = 1) and C_HAS_SCLR = 1 generate
        intSSET_TO_ADDER <= intC_OUT and not(intSCLR) and ADD;
        intSCLR_TO_ADDER <= intSCLR or (not(intC_OUT) and not(ADD) and not(BYPASS));
      end generate;
      satc    : if C_HAS_SSET = 1 and not(C_HAS_SCLR = 1) generate
        intSSET_TO_ADDER <= (intC_OUT and ADD) or intSSET;
        intSCLR_TO_ADDER <= not(intSSET) and (not(intC_OUT) and not(ADD) and not(BYPASS));
      end generate;
      satd    : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
        intSSET_TO_ADDER <= (not(intSCLR) and intC_OUT and ADD) or (intSSET and not(intSCLR));
        intSCLR_TO_ADDER <= intSCLR or (not(intSSET) and not(intC_OUT) and not(ADD) and not(BYPASS));
      end generate;
      sate    : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
        intSSET_TO_ADDER <= intSSET or (intC_OUT and ADD and not(intSCLR));
        intSCLR_TO_ADDER <= (intSCLR and not(intSSET)) or (not(intSSET) and not(intC_OUT) and not(ADD) and not(BYPASS));
      end generate;
    end generate;  -- unsinsat5


    satcegen   : if (C_HAS_CE = 1 and (C_HAS_SSET = 1 or C_HAS_SCLR = 1 ) and C_SYNC_ENABLE = 0) generate
      tempCE <= CE or intSSET or intSCLR;
      --        tempSyncEnable := 1;
    end generate;
    nosatcegen : if (not(C_HAS_CE = 1 and (C_HAS_SSET = 1 or C_HAS_SCLR = 1 ) and C_SYNC_ENABLE = 0)) generate
      tempCE <= CE;
      --        tempSyncEnable := C_SYNC_ENABLE;
    end generate;



    unsinsatadder : if C_B_TYPE = c_unsigned generate
      -- Instanciate an addsub module
      addsub      : c_addsub_v11_0_legacy
        generic map (
          C_A_WIDTH             => C_OUT_WIDTH,
          C_B_WIDTH             => C_B_WIDTH,
          C_OUT_WIDTH           => C_OUT_WIDTH,
          C_LOW_BIT             => 0,
          C_HIGH_BIT            => C_OUT_WIDTH-1,
          C_ADD_MODE            => C_ADD_MODE,
          C_A_TYPE              => C_B_TYPE,
          C_B_TYPE              => C_B_TYPE,
          C_B_CONSTANT          => C_B_CONSTANT,
          C_B_VALUE             => C_B_VALUE,
          C_AINIT_VAL           => "",
          C_SINIT_VAL           => "",
          C_BYPASS_ENABLE       => C_BYPASS_ENABLE,
          C_BYPASS_LOW          => C_BYPASS_LOW,
          C_SYNC_ENABLE         => setSyncEnable(C_HAS_CE, C_HAS_SSET, C_HAS_SCLR, C_SYNC_ENABLE, C_SATURATE),
          C_SYNC_PRIORITY       => C_SYNC_PRIORITY,
          C_PIPE_STAGES         => C_PIPE_STAGES,
          C_HAS_S               => C_HAS_S,
          C_HAS_Q               => 1,
          C_HAS_C_IN            => C_HAS_C_IN,
          C_HAS_C_OUT           => 1,
          C_HAS_Q_C_OUT         => C_HAS_Q_C_OUT,
          C_HAS_B_IN            => C_HAS_B_IN,
          C_HAS_B_OUT           => 1,
          C_HAS_Q_B_OUT         => C_HAS_Q_B_OUT,
          C_HAS_OVFL            => C_HAS_OVFL,
          C_HAS_Q_OVFL          => C_HAS_Q_OVFL,
          C_HAS_CE              => C_HAS_CE,
          C_HAS_ADD             => C_HAS_ADD,
          C_HAS_BYPASS          => C_HAS_BYPASS,
          C_HAS_A_SIGNED        => C_HAS_B_SIGNED,
          C_HAS_B_SIGNED        => C_HAS_B_SIGNED,
          C_HAS_ACLR            => 0,
          C_HAS_ASET            => 0,
          C_HAS_AINIT           => 0,
          C_HAS_SCLR            => 1,
          C_HAS_SSET            => 1,
          C_HAS_SINIT           => 0,
          C_HAS_BYPASS_WITH_CIN => C_HAS_BYPASS_WITH_CIN,
          C_ENABLE_RLOCS        => C_ENABLE_RLOCS
          )
        port map (
          A                     => intFB,
          B                     => B,
          CLK                   => CLK,
          ADD                   => ADD,
          C_IN                  => C_IN,
          B_IN                  => B_IN,
          CE                    => tempCE,
          BYPASS                => BYPASS,
          ACLR                  => ACLR,
          ASET                  => ASET,
          AINIT                 => AINIT,
          SCLR                  => intSCLR_TO_ADDER,
          SSET                  => intSSET_TO_ADDER,
          SINIT                 => SINIT,
          A_SIGNED              => B_SIGNED,
          B_SIGNED              => B_SIGNED,
          OVFL                  => OVFL,
          C_OUT                 => intC_OUT,
          B_OUT                 => intB_OUT,
          Q_OVFL                => Q_OVFL,
          Q_C_OUT               => Q_C_OUT,
          Q_B_OUT               => Q_B_OUT,
          S                     => intS,
          Q                     => intFBq
          );
    end generate;  -- unsinsatadder
    sinsat1       : if C_B_TYPE = c_signed or C_B_TYPE = c_pin generate  -- signed accum wanted - we need to pull the register out of the adder to get at the 
                                        -- MSB register which has different control to the rest

      -- Instanciate an addsub module
      addsub : c_addsub_v11_0_legacy
        generic map (
          C_A_WIDTH             => C_OUT_WIDTH,
          C_B_WIDTH             => C_B_WIDTH,
          C_OUT_WIDTH           => C_OUT_WIDTH,
          C_LOW_BIT             => 0,
          C_HIGH_BIT            => C_OUT_WIDTH-1,
          C_ADD_MODE            => C_ADD_MODE,
          C_A_TYPE              => C_B_TYPE,
          C_B_TYPE              => C_B_TYPE,
          C_B_CONSTANT          => C_B_CONSTANT,
          C_B_VALUE             => C_B_VALUE,
          C_AINIT_VAL           => "",
          C_SINIT_VAL           => "",
          C_BYPASS_ENABLE       => C_BYPASS_ENABLE,
          C_BYPASS_LOW          => C_BYPASS_LOW,
          C_SYNC_ENABLE         => setSyncEnable(C_HAS_CE, C_HAS_SSET, C_HAS_SCLR, C_SYNC_ENABLE, C_SATURATE),
          C_SYNC_PRIORITY       => C_SYNC_PRIORITY,
          C_PIPE_STAGES         => C_PIPE_STAGES,
          C_HAS_S               => 1,
          C_HAS_Q               => 0,
          C_HAS_C_IN            => C_HAS_C_IN,
          C_HAS_C_OUT           => 1,
          C_HAS_Q_C_OUT         => C_HAS_Q_C_OUT,
          C_HAS_B_IN            => C_HAS_B_IN,
          C_HAS_B_OUT           => 1,
          C_HAS_Q_B_OUT         => C_HAS_Q_B_OUT,
          C_HAS_OVFL            => C_HAS_OVFL,
          C_HAS_Q_OVFL          => C_HAS_Q_OVFL,
          C_HAS_CE              => C_HAS_CE,
          C_HAS_ADD             => C_HAS_ADD,
          C_HAS_BYPASS          => C_HAS_BYPASS,
          C_HAS_A_SIGNED        => C_HAS_B_SIGNED,
          C_HAS_B_SIGNED        => C_HAS_B_SIGNED,
          C_HAS_ACLR            => C_HAS_ACLR,
          C_HAS_ASET            => C_HAS_ASET,
          C_HAS_AINIT           => 0,
          C_HAS_SCLR            => C_HAS_SCLR,
          C_HAS_SSET            => C_HAS_SSET,
          C_HAS_SINIT           => 0,
          C_HAS_BYPASS_WITH_CIN => C_HAS_BYPASS_WITH_CIN,
          C_ENABLE_RLOCS        => C_ENABLE_RLOCS
          )
        port map (
          A                     => intFB,
          B                     => B,
          CLK                   => CLK,
          ADD                   => ADD,
          C_IN                  => C_IN,
          B_IN                  => B_IN,
          CE                    => tempCE,
          BYPASS                => BYPASS,
          ACLR                  => ACLR,
          ASET                  => ASET,
          AINIT                 => AINIT,
          SCLR                  => SCLR,
          SSET                  => SSET,
          SINIT                 => SINIT,
          A_SIGNED              => B_SIGNED,
          B_SIGNED              => B_SIGNED,
          OVFL                  => OVFL,
          C_OUT                 => intC_OUT,
          B_OUT                 => intB_OUT,
          Q_OVFL                => Q_OVFL,
          Q_C_OUT               => Q_C_OUT,
          Q_B_OUT               => Q_B_OUT,
          S                     => intS
          );

      -- A single bit register for the MSB
      msb_reg : c_reg_fd_v11_0
        generic map(
          C_WIDTH         => 1,
          C_AINIT_VAL     => "",
          C_SINIT_VAL     => "",
          C_SYNC_ENABLE   => setSyncEnable(C_HAS_CE, C_HAS_SSET, C_HAS_SCLR, C_SYNC_ENABLE, C_SATURATE),
          C_SYNC_PRIORITY => C_SYNC_PRIORITY,
          C_HAS_CE        => C_HAS_CE,
          C_HAS_ACLR      => 0,
          C_HAS_ASET      => 0,
          C_HAS_AINIT     => 0,
          C_HAS_SCLR      => 1,
          C_HAS_SSET      => 1,
          C_HAS_SINIT     => 0,
          C_ENABLE_RLOCS  => C_ENABLE_RLOCS
          )
        port map(
          D(0)            => intS(C_OUT_WIDTH-1),
          CLK             => CLK,
          CE              => intCE,
          ACLR            => ACLR,
          ASET            => ASET,
          AINIT           => AINIT,
          SCLR            => intSCLR_TO_MSB,
          SSET            => intSSET_TO_MSB,
          SINIT           => SINIT,
          Q(0)            => intFBq(C_OUT_WIDTH-1)
          );


      -- A register for lower bits
      cbwidthgt1 : if C_B_WIDTH > 1 generate
        rest_reg : c_reg_fd_v11_0
          generic map(
            C_WIDTH         => C_OUT_WIDTH-1,
            C_AINIT_VAL     => "",
            C_SINIT_VAL     => "",
            C_SYNC_ENABLE   => setSyncEnable(C_HAS_CE, C_HAS_SSET, C_HAS_SCLR, C_SYNC_ENABLE, C_SATURATE),
            C_SYNC_PRIORITY => C_SYNC_PRIORITY,
            C_HAS_CE        => C_HAS_CE,
            C_HAS_ACLR      => 0,
            C_HAS_ASET      => 0,
            C_HAS_AINIT     => 0,
            C_HAS_SCLR      => 1,
            C_HAS_SSET      => 1,
            C_HAS_SINIT     => 0,
            C_ENABLE_RLOCS  => C_ENABLE_RLOCS
            )
          port map(
            D               => intS(C_OUT_WIDTH-2 downto 0),
            CLK             => CLK,
            CE              => intCE,
            ACLR            => ACLR,
            ASET            => ASET,
            AINIT           => AINIT,
            SCLR            => intSCLR_TO_REST,
            SSET            => intSSET_TO_REST,
            SINIT           => SINIT,
            Q               => intFBq(C_OUT_WIDTH-2 downto 0)
            );
      end generate;

      s1 : if C_B_CONSTANT = 1 generate
        intB <= tmpB(C_B_WIDTH-1);
      end generate;
      s3 : if C_B_CONSTANT = 0 generate
        intB <= B(C_B_WIDTH-1);
      end generate;


      bissigned : if C_B_TYPE = c_signed generate
        satadd  : if C_ADD_MODE = c_add generate
          sata  : intSCLRbase <= intS(C_HIGH_BIT) and not(intFBq(C_HIGH_BIT)) and not(intB);
          satb  : intSSETbase <= not(intS(C_HIGH_BIT)) and intFBq(C_HIGH_BIT) and intB;
        end generate;
        satsub  : if C_ADD_MODE = c_sub generate
          satc  : intSCLRbase <= intS(C_HIGH_BIT) and not(intFBq(C_HIGH_BIT)) and intB;
          satd  : intSSETbase <= not(intS(C_HIGH_BIT)) and intFBq(C_HIGH_BIT) and not(intB);  --was not(intB) ;
        end generate;
        satads  : if C_ADD_MODE = c_add_sub generate
          sate  : intSCLRbase <= (not(ADD) and intS(C_HIGH_BIT) and not(intFBq(C_HIGH_BIT)) and intB) or (ADD and intS(C_HIGH_BIT) and not(intFBq(C_HIGH_BIT)) and not(intB));
          satf  : intSSETbase <= (not(ADD) and not(intS(C_HIGH_BIT)) and intFBq(C_HIGH_BIT) and not(intB)) or (ADD and not(intS(C_HIGH_BIT)) and intFBq(C_HIGH_BIT) and intB);
        end generate;
      end generate;
      bispin    : if C_B_TYPE = c_pin generate
        satadd  : if C_ADD_MODE = c_add generate
          sata  : intSCLRbase <= (not(intB_SIGNED) and not(intFBq(C_HIGH_BIT)) and intS(C_HIGH_BIT)) or (intB_SIGNED and not(intFBq(C_HIGH_BIT)) and intS(C_HIGH_BIT) and not(intB));
          satb  : intSSETbase <= intB_SIGNED and intFBq(C_HIGH_BIT) and not(intS(C_HIGH_BIT)) and intB;
        end generate;
        satsub  : if C_ADD_MODE = c_sub generate
          satc  : intSCLRbase <= intB_SIGNED and not(intFBq(C_HIGH_BIT)) and intS(C_HIGH_BIT) and intB;
          satd  : intSSETbase <= (not(intB_SIGNED) and intFBq(C_HIGH_BIT) and not(intS(C_HIGH_BIT))) or (intB_SIGNED and intFBq(C_HIGH_BIT) and not(intS(C_HIGH_BIT)) and not(intB));
        end generate;
        satads  : if C_ADD_MODE = c_add_sub generate
          sate  : intSCLRbase <= (not(ADD) and intB_SIGNED and not(intFBq(C_HIGH_BIT)) and intS(C_HIGH_BIT) and intB)
                                or (ADD and ((not(intB_SIGNED) and not(intFBq(C_HIGH_BIT)) and intS(C_HIGH_BIT))
                                             or (intB_SIGNED and not(intFBq(C_HIGH_BIT)) and intS(C_HIGH_BIT) and not(intB))));
          satf  : intSSETbase <= (not(ADD) and ((not(intB_SIGNED) and intFBq(C_HIGH_BIT) and not(intS(C_HIGH_BIT)))
                                               or (intB_SIGNED and intFBq(C_HIGH_BIT) and not(intS(C_HIGH_BIT)) and not(intB))))
                                or (ADD and intB_SIGNED and intFBq(C_HIGH_BIT) and not(intS(C_HIGH_BIT)) and intB);
        end generate;
      end generate;

      bplow  : if (C_HAS_BYPASS = 1) and (C_BYPASS_LOW = 1) generate
        byce : if (C_BYPASS_ENABLE = c_override) generate
          intCE           <= (not BYPASS) or tempCE;
        end generate;
        bycn : if (C_BYPASS_ENABLE = c_no_override) generate
          intCE           <= tempCE;
        end generate;
        satg : if (C_HAS_SSET = 0) and (C_HAS_SCLR = 0) generate
          intSCLR_TO_MSB  <= intSCLRbase and BYPASS;
          intSSET_TO_MSB  <= intSSETbase and BYPASS;
          intSCLR_TO_REST <= intSSET_TO_MSB;
          intSSET_TO_REST <= intSCLR_TO_MSB;
        end generate;
        sath : if (C_HAS_SSET = 0) and (C_HAS_SCLR = 1) generate
          intSCLR_TO_MSB  <= (intSCLRbase and BYPASS) or SCLR;
          intSSET_TO_MSB  <= (intSSETbase and BYPASS) and not(SCLR);
          intSCLR_TO_REST <= (intSSETbase and BYPASS) or SCLR;
          intSSET_TO_REST <= (intSCLRbase and BYPASS) and not(SCLR);
        end generate;
        sati : if (C_HAS_SSET = 1) and (C_HAS_SCLR = 0) generate
          intSCLR_TO_MSB  <= (intSCLRbase and BYPASS) and not(SSET);
          intSSET_TO_MSB  <= (intSSETbase and BYPASS) or SSET;
          intSCLR_TO_REST <= (intSSETbase and BYPASS) and not (SSET);
          intSSET_TO_REST <= (intSCLRbase and BYPASS) or SSET;
        end generate;
        satj : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
          intSCLR_TO_MSB  <= ((intSCLRbase and not SSET) and BYPASS) or SCLR;
          intSSET_TO_MSB  <= ((intSSETbase and BYPASS) or SSET) and not(SCLR);
          intSCLR_TO_REST <= ((intSSETbase and BYPASS) and not SSET) or SCLR;
          intSSET_TO_REST <= ((intSCLRbase and BYPASS) or SSET) and not(SCLR);
        end generate;
        satk : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
          intSCLR_TO_MSB  <= ((intSCLRbase and BYPASS) or SCLR) and not(SSET);
          intSSET_TO_MSB  <= ((intSSETbase and not SCLR)and BYPASS) or SSET;
          intSCLR_TO_REST <= ((intSSETbase and BYPASS) or SCLR) and not(SSET);
          intSSET_TO_REST <= (intSCLRbase and BYPASS) or SSET;
        end generate;
      end generate;
      bphigh : if (C_HAS_BYPASS = 1) and (C_BYPASS_LOW = 0) generate
        byce : if (C_BYPASS_ENABLE = c_override) generate
          intCE           <= BYPASS or tempCE;
        end generate;
        bycn : if (C_BYPASS_ENABLE = c_no_override) generate
          intCE           <= tempCE;
        end generate;
        satl : if (C_HAS_SSET = 0) and (C_HAS_SCLR = 0) generate
          intSCLR_TO_MSB  <= intSCLRbase and not(BYPASS);
          intSSET_TO_MSB  <= intSSETbase and not(BYPASS);
          intSCLR_TO_REST <= intSSET_TO_MSB;
          intSSET_TO_REST <= intSCLR_TO_MSB;
        end generate;
        satm : if (C_HAS_SSET = 0) and (C_HAS_SCLR = 1) generate
          intSCLR_TO_MSB  <= (intSCLRbase and not(BYPASS)) or SCLR;
          intSSET_TO_MSB  <= (intSSETbase and not(BYPASS)) and not(SCLR);
          intSCLR_TO_REST <= (intSSETbase and not(BYPASS)) or SCLR;
          intSSET_TO_REST <= (intSCLRbase and not(BYPASS)) and not(SCLR);
        end generate;
        satn : if (C_HAS_SSET = 1) and (C_HAS_SCLR = 0) generate
          intSCLR_TO_MSB  <= (intSCLRbase and not(BYPASS)) and not(SSET);
          intSSET_TO_MSB  <= (intSSETbase and not(BYPASS)) or SSET;
          intSCLR_TO_REST <= (intSSETbase and not(BYPASS)) and not (SSET);
          intSSET_TO_REST <= (intSCLRbase and not(BYPASS)) or SSET;
        end generate;
        sato : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
          intSCLR_TO_MSB  <= ((intSCLRbase and not SSET) and not(BYPASS)) or SCLR;
          intSSET_TO_MSB  <= ((intSSETbase and not(BYPASS)) or SSET) and not(SCLR);
          intSCLR_TO_REST <= ((intSSETbase and not(BYPASS) and not SSET)) or SCLR;  -- added and not SSET)
          intSSET_TO_REST <= ((intSCLRbase and not(BYPASS)) or SSET) and not(SCLR);
        end generate;
        satp : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set generate
          intSCLR_TO_MSB  <= ((intSCLRbase and not(BYPASS)) or SCLR) and not(SSET);
          intSSET_TO_MSB  <= ((intSSETbase and not SCLR)and not(BYPASS) and not SCLR) or SSET;
          intSCLR_TO_REST <= ((intSSETbase and not(BYPASS)) or SCLR) and not(SSET);
          intSSET_TO_REST <= (intSCLRbase and not(BYPASS) and not SCLR) or SSET;
        end generate;
      end generate;
      bpnot  : if (C_HAS_BYPASS = 0) generate
        byce : intCE      <= tempCE;
        satq : if (C_HAS_SSET = 0) and (C_HAS_SCLR = 0) generate
          intSCLR_TO_MSB  <= intSCLRbase;
          intSSET_TO_MSB  <= intSSETbase;
          intSCLR_TO_REST <= intSSET_TO_MSB;
          intSSET_TO_REST <= intSCLR_TO_MSB;
        end generate;
        satr : if (C_HAS_SSET = 0) and (C_HAS_SCLR = 1) generate
          intSCLR_TO_MSB  <= intSCLRbase or SCLR;
          intSSET_TO_MSB  <= intSSETbase and not(SCLR);
          intSCLR_TO_REST <= intSSETbase or SCLR;
          intSSET_TO_REST <= intSCLRbase and not(SCLR);
        end generate;
        sats : if (C_HAS_SSET = 1) and (C_HAS_SCLR = 0) generate
          intSCLR_TO_MSB  <= intSCLRbase and not(SSET);
          intSSET_TO_MSB  <= intSSETbase or SSET;
          intSCLR_TO_REST <= intSSETbase and not (SSET);
          intSSET_TO_REST <= intSCLRbase or SSET;
        end generate;
        satt : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_clear generate
          intSCLR_TO_MSB  <= (intSCLRbase and not SSET) or SCLR;
          intSSET_TO_MSB  <= (intSSETbase or SSET) and not(SCLR);
          intSCLR_TO_REST <= (intSSETbase and not SSET) or SCLR;
          intSSET_TO_REST <= (intSCLRbase or SSET) and not(SCLR);
        end generate;
        satu : if C_HAS_SSET = 1 and C_HAS_SCLR = 1 and C_SYNC_PRIORITY = c_set GENERATE
          intSCLR_TO_MSB  <= (intSCLRbase OR SCLR) AND NOT(SSET);
          intSSET_TO_MSB  <= (intSSETbase AND NOT SCLR)OR SSET;
          intSCLR_TO_REST <= (intSSETbase OR SCLR) AND NOT(SSET);
          intSSET_TO_REST <= (intSCLRbase AND NOT SCLR) OR SSET;
        END GENERATE;
      END GENERATE;
    END GENERATE;  -- sinsat1
  END GENERATE;  -- sat1

  -- Feed the asynch output out if necessary
  s1 : IF C_HAS_S = 1 GENERATE
    S <= intS(C_HIGH_BIT DOWNTO C_LOW_BIT);
  END GENERATE;
  s0 : IF NOT (C_HAS_S = 1) GENERATE
    S <= (OTHERS => 'X');
  END GENERATE;

  co1 : IF C_HAS_C_OUT = 1 GENERATE
    C_OUT <= intC_OUT;
  END GENERATE;
  co0 : IF NOT (C_HAS_C_OUT = 1) GENERATE
    C_OUT <= 'X';
  END GENERATE;

  bo1 : IF C_HAS_B_OUT = 1 GENERATE
    B_OUT <= intB_OUT;
  END GENERATE;
  bo0 : IF NOT (C_HAS_B_OUT = 1) GENERATE
    B_OUT <= 'X';
  END GENERATE;


  -- Feedback the correct signals, conditioned by C_SCALE

  scaling_s : IF(C_B_TYPE = c_signed) GENERATE
    intFB(C_OUT_WIDTH-1-C_SCALE DOWNTO 0)             <= intFBq(C_OUT_WIDTH-1 DOWNTO C_SCALE);
    scgt0   : IF C_SCALE > 0 GENERATE
      intFB(C_OUT_WIDTH-1 DOWNTO C_OUT_WIDTH-C_SCALE) <= (OTHERS => intFBq(C_OUT_WIDTH-1));
    END GENERATE;
  END GENERATE;
  scaling_u : IF(C_B_TYPE = c_unsigned) GENERATE
    intFB(C_OUT_WIDTH-1-C_SCALE DOWNTO 0)             <= intFBq(C_OUT_WIDTH-1 DOWNTO C_SCALE);
    scgt0   : IF C_SCALE > 0 GENERATE
      intFB(C_OUT_WIDTH-1 DOWNTO C_OUT_WIDTH-C_SCALE) <= (OTHERS => '0');
    END GENERATE;
  END GENERATE;
  scaling_p : IF(C_B_TYPE = c_pin) GENERATE
    intFB(C_OUT_WIDTH-1-C_SCALE DOWNTO 0)             <= intFBq(C_OUT_WIDTH-1 DOWNTO C_SCALE);
    scgt0   : IF C_SCALE > 0 GENERATE
      intFB(C_OUT_WIDTH-1 DOWNTO C_OUT_WIDTH-C_SCALE) <= (OTHERS => intFBq(C_OUT_WIDTH-1));
    END GENERATE;
  END GENERATE;

  Q <= intFBq;
  
END behavioral;


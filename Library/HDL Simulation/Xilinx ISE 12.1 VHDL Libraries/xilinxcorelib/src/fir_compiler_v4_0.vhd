-------------------------------------------------------------------------------
-- $RCSfile: fir_compiler_v4_0.vhd,v $ $Revision: 1.3 $ $Date: 2008/09/09 20:26:58 $
-------------------------------------------------------------------------------
-- DISCLAIMER OF LIABILITY
-- 
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you 
-- a license to use this text/file solely for design, simulation, 
-- implementation and creation of design files limited 
-- to Xilinx devices or technologies. Use with non-Xilinx 
-- devices or technologies is expressly prohibited and 
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information 
-- "as-is" solely for use in developing programs and 
-- solutions for Xilinx devices. By providing this design, 
-- code, or information as one possible implementation of 
-- this feature, application or standard, Xilinx is making no 
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for 
-- obtaining any rights you may require for your implementation. 
-- Xilinx expressly disclaims any warranty whatsoever with 
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied 
-- warranties of merchantability or fitness for a particular 
-- purpose. 
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications is
-- expressly prohibited.
-- 
--
-- Copyright (c) 2006 - 2008 Xilinx, Inc. All rights reserved.
--
-- This copyright and support notice must be retained as part 
-- of this text at all times.
-------------------------------------------------------------------------------
-- Description:
--     This block instantiates the either the toplevel DA FIR or MAC FIR behavoural model
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.prims_utils_v9_1.all;
use XilinxCoreLib.fir_compiler_v4_0_sim_pkg.all;
use XilinxCoreLib.fir_compiler_v4_0_sim_comps.all;


entity fir_compiler_v4_0 is
generic (
  C_FAMILY            : string  := "virtex4";
  C_XDEVICEFAMILY     : string  := "virtex4";
  C_ELABORATION_DIR   : string  := "./";
  C_COMPONENT_NAME    : string  := "fir";
  C_MEM_INIT_FILE     : string  := "COEFF";
  FILTER_TYPE         : integer := 0;
  INTERP_RATE         : integer := 1;
  DECIM_RATE          : integer := 1;
  RATE_CHANGE_TYPE    : integer := 0;
  ZERO_PACKING_FACTOR : integer := 0;
  NUM_CHANNELS        : integer := 1;
  CHAN_IN_ADV         : integer := 0;
  CHAN_SEL_WIDTH      : integer := 4;
  NUM_TAPS            : integer := 16;
  CLOCK_FREQ          : integer := 400000000;
  SAMPLE_FREQ         : integer := 100000000;
  FILTER_ARCH         : integer := 1;
  DATA_TYPE           : integer := 0;
  DATA_WIDTH          : integer := 16;
  COEF_TYPE           : integer := 0;
  COEF_WIDTH          : integer := 16;
  ROUND_MODE          : integer := 0;
  ACCUM_WIDTH         : integer := 48;
  OUTPUT_WIDTH        : integer := 48;
  ALLOW_APPROX        : integer := 0;
  OUTPUT_REG          : integer := 1;
  SYMMETRY            : integer := 0;
  ODD_SYMMETRY        : integer := 0;
  NEG_SYMMETRY        : integer := 0;
  COEF_RELOAD         : integer := 0;
  NUM_FILTS           : integer := 1;
  FILTER_SEL_WIDTH    : integer := 4;
  C_HAS_SCLR          : integer := 1;
  C_HAS_CE            : integer := 0;
  C_HAS_ND            : integer := 1;
  -- C_HAS_CHAN0_IN      : integer := 0;
  C_HAS_DATA_VALID    : integer := 0;
  DATA_MEMTYPE        : integer := 0;
  COEF_MEMTYPE        : integer := 0;
  IPBUFF_MEMTYPE      : integer := 0;
  OPBUFF_MEMTYPE      : integer := 0;
  DATAPATH_MEMTYPE    : integer := 0;
  COL_MODE            : integer := 0;
  COL_1ST_LEN         : integer := 3;
  COL_WRAP_LEN        : integer := 4;
  COL_PIPE_LEN        : integer := 3;
  C_LATENCY           : integer := 0;
  C_OPTIMIZATION      : integer := 0;
  -- XIL_FFT_COMPATIBLE  : integer := 1;
  NUM_PATHS           : integer := 1;
  SCLR_DETERMINISTIC  : integer := 0
);
port (
  SCLR                : in  std_logic:='0';
  CLK                 : in  std_logic;
  CE                  : in  std_logic:='0';
  
  ND                  : in  std_logic:='0';
  FILTER_SEL          : in  std_logic_vector(FILTER_SEL_WIDTH-1 downto 0):=(others=>'0');
  -- CHAN0_IN            : in  std_logic:='0';
  
  COEF_LD             : in  std_logic:='0';
  COEF_WE             : in  std_logic:='0';
  COEF_DIN            : in  std_logic_vector(COEF_WIDTH-1 downto 0):=(others=>'0');
  COEF_FILTER_SEL     : in  std_logic_vector(FILTER_SEL_WIDTH-1 downto 0):=(others=>'0');

  RFD                 : out std_logic;
  RDY                 : out std_logic;
  DATA_VALID          : out std_logic;
  CHAN_IN             : out std_logic_vector(CHAN_SEL_WIDTH-1 downto 0);
  CHAN_OUT            : out std_logic_vector(CHAN_SEL_WIDTH-1 downto 0);

  --Single path ports, NUM_PATHS=1
  DIN                 : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  
  DOUT                : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I              : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);

  --Multi-path ports, NUM_PATHS>1
  DIN_1               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_2               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_3               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_4               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_5               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_6               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_7               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_8               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_9               : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_10              : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_11              : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_12              : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_13              : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_14              : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_15              : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');
  DIN_16              : in  std_logic_vector(DATA_WIDTH-1 downto 0):=(others=>'0');

  DOUT_1              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_1            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_1            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_2              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_2            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_2            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_3              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_3            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_3            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_4              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_4            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_4            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_5              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_5            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_5            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_6              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_6            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_6            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_7              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_7            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_7            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_8              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_8            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_8            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_9              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_9            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_9            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_10              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_10            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_10            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_11              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_11            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_11            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_12              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_12            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_12            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_13              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_13            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_13            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_14              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_14            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_14            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_15              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_15            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_15            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_16              : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  DOUT_I_16            : out std_logic_vector(DATA_WIDTH-1 downto 0);
  DOUT_Q_16            : out std_logic_vector(OUTPUT_WIDTH-1 downto 0)
);
end fir_compiler_v4_0;


architecture behavioral of fir_compiler_v4_0 is
  
begin

  -----------------------------------------------------------------------------
  -- MULTIPLY-ACCUMULATE FILTER
  -----------------------------------------------------------------------------
  g_mac : if FILTER_ARCH /= 3 generate
    constant round_mode: integer:=select_integer(
                                    ROUND_MODE,
                                    select_integer(
                                      select_integer(
                                        ROUND_MODE,
                                        c_non_symmetric_up,
                                        ROUND_MODE=c_symmetric_inf),
                                      c_non_symmetric_down,
                                      ROUND_MODE=c_symmetric_zero),
                                    DATA_TYPE=c_unsigned and COEF_TYPE=c_unsigned);
  begin

    mac: fir_compiler_v4_0_mac_fir
    generic map (
      C_FAMILY            => C_FAMILY,
      C_XDEVICEFAMILY     => C_XDEVICEFAMILY,
      C_ELABORATION_DIR   => C_ELABORATION_DIR,
      C_COMPONENT_NAME    => C_COMPONENT_NAME,
      C_MEM_INIT_FILE     => C_MEM_INIT_FILE,--hex_mif_file,
      FILTER_TYPE         => FILTER_TYPE,
      INTERP_RATE         => INTERP_RATE,
      DECIM_RATE          => DECIM_RATE,
      RATE_CHANGE_TYPE    => RATE_CHANGE_TYPE,
      ZERO_PACKING_FACTOR => ZERO_PACKING_FACTOR,
      NUM_CHANNELS        => NUM_CHANNELS,
      CHAN_IN_ADV         => CHAN_IN_ADV,
      CHAN_SEL_WIDTH      => CHAN_SEL_WIDTH,
      NUM_TAPS            => NUM_TAPS,
      CLOCK_FREQ          => CLOCK_FREQ,
      SAMPLE_FREQ         => SAMPLE_FREQ,
      FILTER_ARCH         => FILTER_ARCH,
      DATA_TYPE           => DATA_TYPE,
      DATA_WIDTH          => DATA_WIDTH,
      COEF_TYPE           => COEF_TYPE,
      COEF_WIDTH          => COEF_WIDTH,
      ROUND_MODE          => ROUND_MODE,
      ACCUM_WIDTH         => ACCUM_WIDTH,
      OUTPUT_WIDTH        => OUTPUT_WIDTH,
      ALLOW_APPROX        => ALLOW_APPROX,
      OUTPUT_REG          => OUTPUT_REG,
      SYMMETRY            => SYMMETRY,
      ODD_SYMMETRY        => ODD_SYMMETRY,
      NEG_SYMMETRY        => NEG_SYMMETRY,
      COEF_RELOAD         => COEF_RELOAD,
      NUM_FILTS           => NUM_FILTS,
      FILTER_SEL_WIDTH    => FILTER_SEL_WIDTH,
      C_HAS_SCLR          => C_HAS_SCLR,
      C_HAS_CE            => C_HAS_CE,
      C_HAS_ND            => C_HAS_ND,
      C_HAS_CHAN0_IN      => 0,--C_HAS_CHAN0_IN,
      C_HAS_DATA_VALID    => C_HAS_DATA_VALID,
      DATA_MEMTYPE        => DATA_MEMTYPE,
      COEF_MEMTYPE        => COEF_MEMTYPE,
      IPBUFF_MEMTYPE      => IPBUFF_MEMTYPE,  
      OPBUFF_MEMTYPE      => OPBUFF_MEMTYPE, 
      DATAPATH_MEMTYPE    => DATAPATH_MEMTYPE,
      COL_MODE            => COL_MODE,
      COL_1ST_LEN         => COL_1ST_LEN,
      COL_WRAP_LEN        => COL_WRAP_LEN,
      COL_PIPE_LEN        => COL_PIPE_LEN,
      C_LATENCY           => C_LATENCY,
      C_OPTIMIZATION      => C_OPTIMIZATION,
      XIL_FFT_COMPATIBLE  => 1,--XIL_FFT_COMPATIBLE,
      NUM_PATHS           => NUM_PATHS,
      SCLR_DETERMINISTIC  => SCLR_DETERMINISTIC
    )
    port map (
      SCLR                => SCLR,
      CLK                 => CLK,
      CE                  => CE,
      ND                  => ND,
      DIN                 => DIN,
      FILTER_SEL          => FILTER_SEL,
      CHAN0_IN            => '0',--CHAN0_IN,
      COEF_LD             => COEF_LD,
      COEF_WE             => COEF_WE,
      COEF_DIN            => COEF_DIN,
      COEF_FILTER_SEL     => COEF_FILTER_SEL,
      RFD                 => RFD,
      RDY                 => RDY,
      DATA_VALID          => DATA_VALID,
      DOUT                => DOUT,
      DOUT_I              => DOUT_I,
      DOUT_Q              => DOUT_Q,
      CHAN_IN             => CHAN_IN,
      CHAN_OUT            => CHAN_OUT,
      DIN_1               => DIN_1,
      DIN_2               => DIN_2,
      DIN_3               => DIN_3,
      DIN_4               => DIN_4,
      DIN_5               => DIN_5,
      DIN_6               => DIN_6,
      DIN_7               => DIN_7,
      DIN_8               => DIN_8,
      DIN_9               => DIN_9,
      DIN_10              => DIN_10,
      DIN_11              => DIN_11,
      DIN_12              => DIN_12,
      DIN_13              => DIN_13,
      DIN_14              => DIN_14,
      DIN_15              => DIN_15,
      DIN_16              => DIN_16,

      DOUT_1              => DOUT_1,
      DOUT_I_1            => DOUT_I_1,
      DOUT_Q_1            => DOUT_Q_1,
      DOUT_2              => DOUT_2 ,
      DOUT_I_2            => DOUT_I_2,
      DOUT_Q_2            => DOUT_Q_2,
      DOUT_3              => DOUT_3 ,
      DOUT_I_3            => DOUT_I_3,
      DOUT_Q_3            => DOUT_Q_3,
      DOUT_4              => DOUT_4 ,
      DOUT_I_4            => DOUT_I_4,
      DOUT_Q_4            => DOUT_Q_4,
      DOUT_5              => DOUT_5 ,
      DOUT_I_5            => DOUT_I_5,
      DOUT_Q_5            => DOUT_Q_5,
      DOUT_6              => DOUT_6 ,
      DOUT_I_6            => DOUT_I_6,
      DOUT_Q_6            => DOUT_Q_6,
      DOUT_7              => DOUT_7 ,
      DOUT_I_7            => DOUT_I_7,
      DOUT_Q_7            => DOUT_Q_7,
      DOUT_8              => DOUT_8 ,
      DOUT_I_8            => DOUT_I_8,
      DOUT_Q_8            => DOUT_Q_8,
      DOUT_9              => DOUT_9 ,
      DOUT_I_9            => DOUT_I_9,
      DOUT_Q_9            => DOUT_Q_9,
      DOUT_10             => DOUT_10,
      DOUT_I_10           => DOUT_I_10,
      DOUT_Q_10           => DOUT_Q_10,
      DOUT_11             => DOUT_11,
      DOUT_I_11           => DOUT_I_11,
      DOUT_Q_11           => DOUT_Q_11,
      DOUT_12             => DOUT_12,
      DOUT_I_12           => DOUT_I_12,
      DOUT_Q_12           => DOUT_Q_12,
      DOUT_13             => DOUT_13,
      DOUT_I_13           => DOUT_I_13,
      DOUT_Q_13           => DOUT_Q_13,
      DOUT_14             => DOUT_14,
      DOUT_I_14           => DOUT_I_14,
      DOUT_Q_14           => DOUT_Q_14,
      DOUT_15             => DOUT_15,
      DOUT_I_15           => DOUT_I_15,
      DOUT_Q_15           => DOUT_Q_15,
      DOUT_16             => DOUT_16,
      DOUT_I_16           => DOUT_I_16,
      DOUT_Q_16           => DOUT_Q_16
    );

  end generate; -- g_mac

  -----------------------------------------------------------------------------
  -- DISTRIBUTED ARITHMETIC FILTER 
  -----------------------------------------------------------------------------
  g_da : if FILTER_ARCH = 3 generate
    
    -----------------------------------------------------------------------------
    -- Constants mapped to DA_FIR_V9_0 generics
    constant clk_per_samp          : integer := CLOCK_FREQ/SAMPLE_FREQ;
    constant clk_per_samp_per_chan : integer := clk_per_samp/NUM_CHANNELS;

    constant da_filt_type       : integer := map_da_type(FILTER_TYPE);
    --constant da9_rate           : integer := RATE;
    constant da9_rate           : integer := map_da_rate(
                                             FILTER_TYPE,
                                             INTERP_RATE,
                                             DECIM_RATE);
    constant clk_per_op_dec     : integer := clk_per_samp_per_chan*DECIM_RATE;
    constant clk_per_op_int     : integer := clk_per_samp_per_chan;--/INTERP_RATE;
    constant clk_per_output     : integer
                                := select_integer (
                                   clk_per_op_dec,
                                   clk_per_op_int,
                                   FILTER_TYPE=c_polyphase_interpolating or
                                   FILTER_TYPE=c_interpolating_half_band );
    constant c_baat             : integer
                                := get_da_baat(
                                   FILTER_TYPE,
                                   DATA_WIDTH,
                                   clk_per_output,
                                   SYMMETRY);
    constant da_symmetry1       : integer
                                := select_integer (
                                   1,
                                   0,
                                   SYMMETRY=1);
    constant da_symmetry        : integer
                                := select_integer (
                                   da_symmetry1,
                                   2,
                                   NEG_SYMMETRY=1 and SYMMETRY=1);
    constant c_has_sel_i        : integer
                                := select_integer(0,1,
                                   NUM_CHANNELS > 1);
    constant c_has_sel_o        : integer := c_has_sel_i;
    constant c_optimize_coef    : integer := 0; -- no support initially?
    constant c_reload_mem_type  : integer := 1; -- 1=blk, 2=dist

    -----------------------------------------------------------------------------
    -- Convert mif file into a HEX representation
--     constant convert_mif_result : integer := convert_bin_mif_to_hex (
--                                              C_ELABORATION_DIR,
--                                              C_MEM_INIT_FILE,
--                                              NUM_TAPS,
--                                              COEF_WIDTH,
--                                              NUM_FILTS);
-- 
--     constant hex_mif_file : string := "hex_" & C_MEM_INIT_FILE;
--     
--     constant hex_mif_file_fullpath : string := C_ELABORATION_DIR & hex_mif_file;

  begin
    
--     assert convert_mif_result=1 report "hex mif file generation failed" severity failure;

    da:  fir_compiler_v4_0_da_fir
    generic map (
      c_data_width        => DATA_WIDTH,
      c_result_width      => OUTPUT_WIDTH,
      c_coeff_width       => COEF_WIDTH,
      c_taps              => NUM_TAPS,
      c_response          => da_symmetry,
      c_data_type         => DATA_TYPE,
      c_coeff_type        => COEF_TYPE,
      c_channels          => NUM_CHANNELS,
      c_filter_type       => da_filt_type,
      c_saturate          => 0, -- not implemented
      c_has_sel_o         => c_has_sel_o,
      c_has_sel_i         => c_has_sel_i,
      c_has_reset         => C_HAS_SCLR,
      c_mem_init_file     => C_MEM_INIT_FILE,--hex_mif_file,
      c_zpf               => ZERO_PACKING_FACTOR,
      c_baat              => c_baat, 
      c_has_sin_f         => 0, -- not supported 
      c_has_sin_r         => 0, -- not supported 
      c_has_sout_r        => 0, -- not supported
      c_has_sout_f        => 0, -- not supported
      c_reload            => COEF_RELOAD,
      --c_reload_delay      => 0, -- not required
      c_reload_mem_type   => c_reload_mem_type,
      c_reg_output        => OUTPUT_REG, 
      c_polyphase_factor  => da9_rate,
      c_optimize          => c_optimize_coef,
      c_enable_rlocs      => 0,
      c_use_model_func    => 0, -- simulation only
      --c_latency           => 0, -- simulation only
      c_shape             => 0  -- not implemented
    )
    port map (
      din                 => DIN,
      nd                  => ND,
      clk                 => CLK,
      rst                 => SCLR,
      coef_ld             => COEF_LD,
      ld_din              => COEF_DIN,
      ld_we               => COEF_WE,
      --cas_f_in          => (others=>'0'),
      --cas_r_in          => (others=>'0'),
      --cas_f_out         => open,
      --cas_r_out         => open,
      sel_i               => CHAN_IN,
      sel_o               => CHAN_OUT,
      dout                => DOUT,
      dout_q              => DOUT_Q,
      dout_i              => DOUT_I,
      rdy                 => RDY,
      rfd                 => RFD     
    );
    
  end generate; -- g_da
  
end behavioral;

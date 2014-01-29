-------------------------------------------------------------------------------
-- $RCSfile: fir_compiler_v4_0_xst_comp.vhd,v $ $Revision: 1.3 $ $Date: 2008/09/09 20:26:58 $
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

library ieee;
use ieee.std_logic_1164.all;

package fir_compiler_v4_0_xst_comp is

  -----------------------------------------------------------------------------
  component fir_compiler_v4_0_xst
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
  end component;

  -----------------------------------------------------------------------------

end fir_compiler_v4_0_xst_comp;

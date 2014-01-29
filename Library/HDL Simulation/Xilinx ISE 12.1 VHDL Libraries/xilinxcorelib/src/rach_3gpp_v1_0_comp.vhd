-- $Header
--
--  Copyright(C) 2007 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-2007 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Component statement for behavioral model
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package rach_3gpp_v1_0_comp is

  --core_if on component no_coregen_specials
  component rach_3gpp_v1_0
    generic (
      c_family          :    string    := "virtex4";
      C_XDEVICEFAMILY      : STRING  := "virtex4";
      component_name    :    string    := "rach_3gpp_v1_0";
      c_clock_rate      :     integer := 64;
      c_min_coh_win_len :    integer   := 256;
      c_search_winsize  :    integer   := 32;
      c_quantize        :    integer   := 5;
      c_n_oversample    :    integer   := 2;
      c_has_ce          :    integer  := 0
      );
    port (
      clk               : in std_logic := '0';
      ce                : in std_logic := '0';
      sclr              : in std_logic := '0';

      -- CONFIG interface
      scramble_code_init : in std_logic_vector(23 downto 0 )                           := (others => '0');
      coherence_win_len  : in std_logic_vector(8 downto 0)  := (others => '0');

      --antenna interface
      sample_write   : in  std_logic                                 := '0';
      antenna_data_Q : in  std_logic_vector(c_quantize - 1 downto 0) := (others => '0');
      antenna_data_I : in  std_logic_vector(c_quantize - 1 downto 0) := (others => '0');
      slot_sync      : in  std_logic                                 := '0';
      sample_accept  : out std_logic                                 := '0';

      --outputs - should be OCP DSP interface
      fht_data_out_valid : out std_logic                                  := '0';
      fht_data_out_q     : out std_logic_vector(c_quantize + 11 downto 0) := (others => '0');
      fht_data_out_i     : out std_logic_vector(c_quantize + 11 downto 0) := (others => '0');
      fht_data_out_sync  : out std_logic                                  := '0';
      last_fht_running   : out std_logic                                  := '0'
      );
    --core_if off
  end component;
  -- The following tells XST that rach_3gpp_v1_0 is a black box which  
  -- should be generated command given by the value of this attribute 
  -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- basis of the core

  -- xcc exclude
  attribute box_type                            : string;
  attribute generator_default                   : string;
  attribute box_type of rach_3gpp_v1_0          : component is "black_box";
  ATTRIBUTE generator_default OF rach_3gpp_v1_0 : COMPONENT IS
    "generatecore com.xilinx.ip.rach_3gpp_v1_0.rach_3gpp_v1_0";
  -- xcc include

END rach_3gpp_v1_0_comp;

--------------------------------------------------------------------------------
--  Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
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
--  of this text at all times. (c) Copyright 1995-200 Xilinx, Inc.
--  All rights reserved.
--------------------------------------------------------------------------------
-- $RCSfile: cordic_v3_0_comp.vhd,v $
--------------------------------------------------------------------------------
-- Project  : cordic
-- Unit     : cordic_v3_0_comp
-- Author   : Jeffrey Graham
-- Function :  Top Level Module Component 
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE cordic_v3_0_comp IS

  COMPONENT cordic_v3_0
  GENERIC (
    c_architecture	: INTEGER := 2; 
    c_cordic_function : INTEGER := 0;
    c_coarse_rotate : INTEGER := 1;
    c_data_format : INTEGER := 0;
    c_enable_rlocs : INTEGER := 1;
    c_family : STRING := "virtex2";
    c_has_aclr : INTEGER := 0;
    c_has_ce : INTEGER := 0;
    c_has_clk : INTEGER := 0;
    c_has_nd : INTEGER := 0;
    c_has_phase_in : INTEGER := 0;
    c_has_phase_out : INTEGER := 0;
    c_has_rdy : INTEGER := 0;
    c_has_rfd : INTEGER := 0;
    c_has_sclr : INTEGER := 0;
    c_has_x_in : INTEGER := 0;
    c_has_x_out : INTEGER := 0;
    c_has_y_in : INTEGER := 0;
    c_has_y_out : INTEGER := 0;
    c_input_width : INTEGER := 32;
    c_iterations : INTEGER := 16;
    c_mif_file_prefix : STRING := "cor1";
    c_output_width : INTEGER := 16;
    c_phase_format : INTEGER := 0;
    c_pipeline_mode : INTEGER := -2;
    c_precision : INTEGER := 0;
    c_reg_inputs : INTEGER := 1;
    c_reg_outputs : INTEGER := 1;
    c_round_mode : INTEGER := 2;
    c_scale_comp : INTEGER := 0;
    c_sync_enable : INTEGER := 0
    );
  PORT (
    x_in : in STD_LOGIC_VECTOR(c_input_width-1 downto 0) := (OTHERS => 'Z');
    y_in : in STD_LOGIC_VECTOR(c_input_width-1 downto 0) := (OTHERS => 'Z');
    phase_in : in STD_LOGIC_VECTOR(c_input_width-1 downto 0) := (OTHERS => 'Z');
    nd : IN STD_LOGIC := '1';
    x_out : OUT STD_LOGIC_VECTOR(c_output_width-1 downto 0);
    y_out : OUT STD_LOGIC_VECTOR(c_output_width-1 downto 0);
    phase_out : OUT STD_LOGIC_VECTOR(c_output_width-1 downto 0);
    rdy : OUT STD_LOGIC;
    rfd : OUT STD_LOGIC;
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC := '1';
    aclr : IN STD_LOGIC := '0';
    sclr : IN STD_LOGIC := '0'
  );  
  END COMPONENT;

END cordic_v3_0_comp;

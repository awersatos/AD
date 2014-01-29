--------------------------------------------------------------------------------
-- Copyright 2002 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
-- $Header: /devl/xcs/repo/env/Databases/ip/src/com/xilinx/ip/tcc_decoder_v1_0/simulation/tcc_decoder_v1_0_comp.vhd,v 1.13 2008/09/08 20:10:08 akennedy Exp $
--
-- Description: Component statement for Turbo Convolutional Decoder
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE tcc_decoder_v1_0_comp IS


FUNCTION bits_needed_to_represent(a_value : INTEGER) RETURN INTEGER;



--------------------------------------------------------------------------------
-- Component declaration
--------------------------------------------------------------------------------
COMPONENT tcc_decoder_v1_0 IS
GENERIC (
  c_family  	              : STRING;
  c_mem_init_prefix         : STRING;
  c_input_int_bits          : INTEGER;
  c_input_frac_bits         : INTEGER;
  c_metric_int_bits         : INTEGER;
  c_metric_frac_bits        : INTEGER;
  c_window_size             : INTEGER;
  c_max_block_size          : INTEGER := 20736; -- Includes all tail bits
  c_num_simultaneous_blocks : INTEGER;
  c_mem_unit                : INTEGER;
  c_ping_pong               : INTEGER;
  c_external_ram            : INTEGER;
  c_algorithm_type			: INTEGER;  
  -- Implementation generics
  c_memstyle                : INTEGER;
  c_enable_rlocs            : INTEGER;
  -- Optional pin generics
  c_has_ce                  : INTEGER;
  c_has_nd                  : INTEGER;
  c_has_rd_ram              : INTEGER;
  c_has_it_rdy              : INTEGER;
  c_has_rdy                 : INTEGER;
  c_has_rfd                 : INTEGER;
  c_has_rffd                : INTEGER;
  c_has_sclr                : INTEGER;
  c_has_aclr                : INTEGER
  );
PORT (
  -- Mandatory input pins
  block_size_sel       : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  clk                  : IN STD_LOGIC;
  d_in                 : IN STD_LOGIC_VECTOR(
                             5*(c_input_int_bits+c_input_frac_bits)-1 DOWNTO 0);
  fd                   : IN STD_LOGIC;
  iterations           : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  -- Optional input pins
  aclr                 : IN STD_LOGIC := '0';
  ce                   : IN STD_LOGIC := '1';
  nd                   : IN STD_LOGIC := '1';
  rd_d_in              : IN STD_LOGIC_VECTOR(
                             5*(c_input_int_bits+c_input_frac_bits)-1 DOWNTO 0);
  --rd_d_in1             : IN STD_LOGIC_VECTOR(
  --                           5*(c_input_int_bits+c_input_frac_bits)-1 DOWNTO 0);
  sclr                 : IN STD_LOGIC := '0';
  --start                : IN STD_LOGIC;
  -- Mandatory output pins
  d_out                : OUT STD_LOGIC;
  -- Optional output pins
  --busy                 : OUT STD_LOGIC;
  p_addr               : OUT STD_LOGIC_VECTOR(bits_needed_to_represent(
                   c_max_block_size * c_num_simultaneous_blocks -1)-1 DOWNTO 0);
  --p_addr1              : OUT STD_LOGIC_VECTOR(bits_needed_to_represent(
  --                 c_max_block_size * c_num_simultaneous_blocks -1)-1 DOWNTO 0);
  s_addr               : OUT STD_LOGIC_VECTOR(bits_needed_to_represent(
                   c_max_block_size * c_num_simultaneous_blocks -1)-1 DOWNTO 0);
  --s_addr1              : OUT STD_LOGIC_VECTOR(bits_needed_to_represent(
  --                 c_max_block_size * c_num_simultaneous_blocks -1)-1 DOWNTO 0);
  --rd_ram               : OUT STD_LOGIC;
  it_rdy               : OUT STD_LOGIC;                   
  rdy                  : OUT STD_LOGIC;
  rfd                  : OUT STD_LOGIC;
  rffd                 : OUT STD_LOGIC;
  --rfs                  : OUT STD_LOGIC; -- Mandatory if c_mem_unit=0
  we                   : OUT STD_LOGIC;
  --we1                  : OUT STD_LOGIC;
  wr_d_out             : OUT STD_LOGIC_VECTOR(
                             5*(c_input_int_bits+c_input_frac_bits)-1 DOWNTO 0)
  --signals used for debugging
  -- systematic_du    : OUT STD_LOGIC_VECTOR(c_input_int_bits+c_input_frac_bits-1 DOWNTO 0);
--   parity_0_du	   : OUT STD_LOGIC_VECTOR(c_input_int_bits+c_input_frac_bits-1 DOWNTO 0);
--   parity_1_du	   : OUT STD_LOGIC_VECTOR(c_input_int_bits+c_input_frac_bits-1 DOWNTO 0);
--   interleaver_addr : OUT STD_LOGIC_VECTOR(bits_needed_to_represent(
--                    c_max_block_size * c_num_simultaneous_blocks -1)-1 DOWNTO 0);
--   gamma_db		: OUT STD_LOGIC_VECTOR(	((c_metric_int_bits+c_metric_frac_bits-1)*4)-1 DOWNTO 0);
--   gamma_twos_db	: OUT STD_LOGIC_VECTOR(	((c_metric_int_bits+c_metric_frac_bits-1)*4)-1 DOWNTO 0);
--   alpha_db		: OUT STD_LOGIC_VECTOR(	((c_metric_int_bits+c_metric_frac_bits)*8)-1 DOWNTO 0);
--   beta1_db		: OUT STD_LOGIC_VECTOR(	((c_metric_int_bits+c_metric_frac_bits)*8)-1 DOWNTO 0);
--   beta2_db		: OUT STD_LOGIC_VECTOR(	((c_metric_int_bits+c_metric_frac_bits)*8)-1 DOWNTO 0)
  );
END COMPONENT; -- tcc_decoder_v1_0

-- The following tells XST that this core is a black box which 
-- should be generated by the command given by the value of this attribute.
-- Note the fully qualified SIM (JAVA class) name that forms the basis of the
-- core.
ATTRIBUTE box_type : STRING; 
ATTRIBUTE box_type OF TCC_DECODER_V1_0 : COMPONENT IS "black_box"; 
ATTRIBUTE GENERATOR_DEFAULT : STRING; 
ATTRIBUTE GENERATOR_DEFAULT OF TCC_DECODER_V1_0 : COMPONENT IS 
                                 "generatecore com.xilinx.ip.tcc_decoder_v1_0.tcc_decoder_v1_0";

END tcc_decoder_v1_0_comp;


PACKAGE BODY tcc_decoder_v1_0_comp IS

--------------------------------------------------------------------------------
-- Return number of bits required to represent the supplied parameter
-- Returns 1 for values <= 0.
--------------------------------------------------------------------------------
FUNCTION bits_needed_to_represent(a_value : INTEGER) RETURN INTEGER IS
  VARIABLE return_value : NATURAL := 1;
BEGIN

  FOR i IN 30 DOWNTO 0 LOOP
    IF a_value >= 2**i THEN
        return_value := i+1;
        EXIT;
    END IF;
  END LOOP;

  RETURN return_value;

END bits_needed_to_represent;



END tcc_decoder_v1_0_comp;

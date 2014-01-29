--------------------------------------------------------------------------------
-- Copyright 2002 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
-- $Header: /devl/xcs/repo/env/Databases/ip/src/com/xilinx/ip/tcc_decoder_3gpp_v1_0/simulation/tcc_decoder_3gpp_v1_0_comp.vhd,v 1.11 2008/09/08 20:10:02 akennedy Exp $
--
-- Description: Component statement for Turbo Convolutional Decoder
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

--LIBRARY XilinxCoreLib;
--USE XilinxCoreLib.tcc_decoder_3gpp_const_pkg.ALL;
--USE XilinxCoreLib.tcc_decoder_3gpp_utils_pkg.ALL;
--USE work.tcc_decoder_3gpp_const_pkg.ALL;
--USE work.tcc_decoder_3gpp_utils_pkg.ALL;

PACKAGE tcc_decoder_3gpp_v1_0_comp IS

FUNCTION bits_needed_to_represent(a_value : INTEGER) RETURN INTEGER;

-- These constants MUST match those in the main core's constants package
CONSTANT CONST_max_blk              : INTEGER := 5114;
CONSTANT CONST_tail_bits            : INTEGER := 3;
CONSTANT CONST_total_tail_bits      : INTEGER := 2*CONST_tail_bits;
CONSTANT CONST_block_size_width     : INTEGER := 13; 

CONSTANT CONST_iterations_sel_width : INTEGER := 4;
CONSTANT CONST_ft_count_width       : INTEGER := 3;
CONSTANT CONST_distmem              : INTEGER := 0;
CONSTANT CONST_blockmem             : INTEGER := 1;
CONSTANT CONST_automatic            : INTEGER := 2;
CONSTANT CONST_maximum              : INTEGER := 1;


--------------------------------------------------------------------------------
-- Component declaration
--------------------------------------------------------------------------------
COMPONENT tcc_decoder_3gpp_v1_0 IS
GENERIC (
    c_algorithm_type          : INTEGER;
    c_external_ram            : INTEGER;
    c_enable_rlocs            : INTEGER;
    c_ext_interleaver         : INTEGER;
    c_family		            : STRING := "virtex2";
    c_has_aclr                : INTEGER;
    c_has_ce                  : INTEGER;
    c_has_extrinsic_op        : INTEGER:=0;
    c_has_fast_term           : INTEGER;
    c_has_it_rdy              : INTEGER;
    c_has_nd                  : INTEGER;
    c_has_rdy                 : INTEGER:=1;
    c_has_rfd                 : INTEGER;
    c_has_rffd                : INTEGER:=1;
    c_has_sclr                : INTEGER;
    c_has_siso_count          : INTEGER:=0;
    c_has_siso_rdy            : INTEGER:=0;
    c_input_frac_bits         : INTEGER;
    c_input_int_bits          : INTEGER;
    c_intlv_latency           : INTEGER;
    c_max_block_size          : INTEGER := CONST_max_blk;
    c_mem_init_prefix         : STRING := "tccd3gpp";
    c_mem_unit                : INTEGER;
    c_memstyle                : INTEGER:= CONST_blockmem;
    c_metric_frac_bits        : INTEGER;
    c_metric_int_bits         : INTEGER;
    c_num_simultaneous_blocks : INTEGER:=1;
    c_optimization            : INTEGER;
    c_parity_per_rsc          : INTEGER;
    c_ram_latency             : INTEGER:=1;
    c_window_size             : INTEGER
    );
PORT (
    -- Mandatory input pins
    clk            : IN STD_LOGIC;
    fd             : IN STD_LOGIC;
    block_size     : IN STD_LOGIC_VECTOR(bits_needed_to_represent
                     (c_max_block_size)-1 DOWNTO 0);
    iterations     : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    d_in           : IN STD_LOGIC_VECTOR((2*c_parity_per_rsc+1)*
                     (c_input_int_bits+c_input_frac_bits)-1 DOWNTO 0);

    -- Optional input pins
    aclr           : IN STD_LOGIC;
    sclr           : IN STD_LOGIC;
    ce             : IN STD_LOGIC;
    nd             : IN STD_LOGIC;
    intlv_addr     : IN STD_LOGIC_VECTOR(bits_needed_to_represent
                     (c_max_block_size-1)-1 DOWNTO 0);
    rd_d_in        : IN STD_LOGIC_VECTOR((2*c_parity_per_rsc+1)*
                     (c_input_int_bits+c_input_frac_bits)-1 DOWNTO 0);
    ft_thresh      : IN STD_LOGIC_VECTOR(CONST_ft_count_width-1 DOWNTO 0);

    -- Mandatory output pins
    d_out          : OUT STD_LOGIC;

    -- Optional output pins
    intlv_fd       : OUT STD_LOGIC;
    intlv_ce       : OUT STD_LOGIC;
    rfd            : OUT STD_LOGIC;
    rffd           : OUT STD_LOGIC;
    rdy            : OUT STD_LOGIC;
    it_rdy         : OUT STD_LOGIC;                   
    siso_rdy       : OUT STD_LOGIC;
    ft_active      : OUT STD_LOGIC;
    siso_count     : OUT STD_LOGIC_VECTOR(CONST_iterations_sel_width DOWNTO 0);
    extrinsic_out  : OUT STD_LOGIC_VECTOR
                     (c_metric_int_bits+c_metric_frac_bits-2 DOWNTO 0);
    extrinsic_addr : OUT STD_LOGIC_VECTOR(bits_needed_to_represent
                     (c_max_block_size+CONST_total_tail_bits-1)-1 DOWNTO 0);
    extrinsic_we   : OUT STD_LOGIC;
    p_addr         : OUT STD_LOGIC_VECTOR(bits_needed_to_represent
                     ((c_max_block_size+CONST_total_tail_bits)
                     *c_num_simultaneous_blocks-1)-1 DOWNTO 0);
    s_addr         : OUT STD_LOGIC_VECTOR(bits_needed_to_represent
                     ((c_max_block_size+CONST_total_tail_bits)
                     *c_num_simultaneous_blocks-1)-1 DOWNTO 0);
    block_select   : OUT STD_LOGIC;
    we             : OUT STD_LOGIC;
    wr_d_out       : OUT STD_LOGIC_VECTOR((2*c_parity_per_rsc+1)*
                     (c_input_int_bits+c_input_frac_bits)-1 DOWNTO 0)
    );
    
END COMPONENT; -- tcc_decoder_3gpp_v1_0

-- The following tells XST that this core is a black box which 
-- should be generated by the command given by the value of this attribute.
-- Note the fully qualified SIM (JAVA class) name that forms the basis of the
-- core.
ATTRIBUTE box_type : STRING; 
ATTRIBUTE box_type OF TCC_DECODER_3GPP_V1_0 : COMPONENT IS "black_box"; 
ATTRIBUTE GENERATOR_DEFAULT : STRING; 
ATTRIBUTE GENERATOR_DEFAULT OF TCC_DECODER_3GPP_V1_0 : COMPONENT IS 
    "generatecore com.xilinx.ip.tcc_decoder_3gpp_v1_0.tcc_decoder_3gpp_v1_0";

END tcc_decoder_3gpp_v1_0_comp;


PACKAGE BODY tcc_decoder_3gpp_v1_0_comp IS

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


END tcc_decoder_3gpp_v1_0_comp;

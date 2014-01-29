-- $Revision: 1.9 $ $Date: 2008/09/08 20:07:47 $
----------------------------------------------------------------------
-- This file is owned and controlled by Xilinx and must be used     --
-- solely for design, simulation, implementation and creation of    --
-- design files limited to Xilinx devices or technologies. Use      --
-- with non-Xilinx devices or technologies is expressly prohibited  --
-- and immediately terminates your license.                         --
--                                                                  --
-- Xilinx products are not intended for use in life support         --
-- appliances, devices, or systems. Use in such applications are    --
-- expressly prohibited.                                            --
--                                                                  --
-- Copyright (C) 2004, Xilinx, Inc.  All Rights Reserved.           --
----------------------------------------------------------------------
--
--  Description:
--    DA FIR filter behavioral model
--
  
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- LIBRARY std;
-- USE std.textio.all;

LIBRARY xilinxcorelib;
--USE xilinxcorelib.dafir_pack_v9_0.ALL;
USE xilinxcorelib.ul_utils.ALL;
USE xilinxcorelib.c_da_fir_v9_0_comp.all;

ENTITY c_da_fir_v9_0_xst IS
  GENERIC( component_name       : STRING  := "dafir9";
           c_data_width         : INTEGER := 8;
           c_result_width       : INTEGER := 20;
           c_coeff_width        : INTEGER := 8;
           c_taps               : INTEGER := 16;
           c_response           : INTEGER := 0;
           c_data_type          : INTEGER := 1;
           c_coeff_type         : INTEGER := 1;
           c_channels           : INTEGER := 2;
           c_filter_type        : INTEGER := 0;
           c_saturate           : INTEGER := 0;
           c_has_sel_o          : INTEGER := 1;
           c_has_sel_i          : INTEGER := 1;
           c_has_reset          : INTEGER := 1;
           c_mem_init_file      : STRING;
           c_zpf                : INTEGER := 2;
           c_reg_output         : INTEGER := 1;
           c_baat               : INTEGER := 1;
           c_has_sin_f          : INTEGER := 0;
           c_has_sin_r          : INTEGER := 0;
           c_has_sout_r         : INTEGER := 0;
           c_has_sout_f         : INTEGER := 0;
           c_reload             : INTEGER := 0;
           c_reload_delay       : INTEGER := 5;
           c_reload_mem_type    : INTEGER := 0; -- ignored by model
           c_polyphase_factor   : INTEGER := 2;
           c_optimize           : INTEGER := 0; -- ignored by model
           c_enable_rlocs       : INTEGER := 1; -- ignored by model
           c_use_model_func     : INTEGER := 1; -- ignored by model
           c_latency            : INTEGER := 9;
           c_shape              : INTEGER := 0  -- ignored by model
  );
  PORT   ( din                  : IN  std_logic_vector( c_data_width-1 DOWNTO 0 ) := (OTHERS => '0');
           nd                   : IN  std_logic;
           clk                  : IN  std_logic;
           rst                  : IN  std_logic := '0';
           coef_ld              : IN  std_logic := '0';
           ld_din               : IN  std_logic_vector( c_coeff_width-1 DOWNTO 0) := (OTHERS => '0');
           ld_we                : IN  std_logic := '0';
           cas_f_in             : IN  std_logic_vector( c_baat-1 downto 0) := (OTHERS => '0');
           cas_r_in             : IN  std_logic_vector( c_baat-1 downto 0) := (OTHERS => '0');
           cas_f_out            : OUT std_logic_vector( c_baat-1 downto 0);
           cas_r_out            : OUT std_logic_vector( c_baat-1 downto 0);
           sel_i                : OUT std_logic_vector( bitsneededtorepresent(c_channels-1)-1 DOWNTO 0);
           sel_o                : OUT std_logic_vector( bitsneededtorepresent(c_channels-1)-1 DOWNTO 0);
           dout                 : OUT std_logic_vector( c_result_width-1 DOWNTO 0 );
           dout_q               : OUT std_logic_vector( c_result_width-1 DOWNTO 0 );
           dout_i               : OUT std_logic_vector( c_data_width-1 DOWNTO 0);
           rdy                  : OUT std_logic;
           rfd                  : OUT std_logic);
END c_da_fir_v9_0_xst;

ARCHITECTURE xilinx OF c_da_fir_v9_0_xst IS

BEGIN
  -- Instantiate the real C_DA_FIR_V9_0
  da9:  c_da_fir_v9_0 
  GENERIC MAP(
    component_name      => component_name    ,
    c_data_width        => c_data_width      ,
    c_result_width      => c_result_width    ,
    c_coeff_width       => c_coeff_width     ,
    c_taps              => c_taps            ,
    c_response          => c_response        ,
    c_data_type         => c_data_type       ,
    c_coeff_type        => c_coeff_type      ,
    c_channels          => c_channels        ,
    c_filter_type       => c_filter_type     ,
    c_saturate          => c_saturate        ,
    c_has_sel_o         => c_has_sel_o       ,
    c_has_sel_i         => c_has_sel_i       ,
    c_has_reset         => c_has_reset       ,
    c_mem_init_file     => c_mem_init_file   ,
    c_zpf               => c_zpf             ,
    c_baat              => c_baat            , 
    c_has_sin_f         => c_has_sin_f       , -- not supported 
    c_has_sin_r         => c_has_sin_r       , -- not supported 
    c_has_sout_r        => c_has_sout_r      , -- not supported
    c_has_sout_f        => c_has_sout_f      , -- not supported
    c_reload            => c_reload          , 
	  c_reload_delay      => c_reload_delay    ,
	  c_reload_mem_type   => c_reload_mem_type ,
    c_reg_output        => c_reg_output      , 
    c_polyphase_factor  => c_polyphase_factor, 
    c_optimize          => c_optimize        , -- ignored by model
    c_enable_rlocs      => c_enable_rlocs    , -- ignore by model
    c_use_model_func    => c_use_model_func  , 
    c_latency           => c_latency         , 
    c_shape             => c_shape             -- ignored by model
  )
  PORT MAP(
    din                 => din               ,
    nd                  => nd                ,
    clk                 => clk               ,
    rst                 => rst               ,
    coef_ld             => coef_ld           ,
    ld_din              => ld_din            ,
    ld_we               => ld_we             ,
    cas_f_in            => cas_f_in          ,
    cas_r_in            => cas_r_in          ,
    cas_f_out           => cas_f_out         ,
    cas_r_out           => cas_r_out         ,
    sel_i               => sel_i             ,
    sel_o               => sel_o             ,
    dout                => dout              ,
    dout_q              => dout_q            ,
    dout_i              => dout_i            ,
    rdy                 => rdy               ,
    rfd                 => rfd               
  );
  
END xilinx;


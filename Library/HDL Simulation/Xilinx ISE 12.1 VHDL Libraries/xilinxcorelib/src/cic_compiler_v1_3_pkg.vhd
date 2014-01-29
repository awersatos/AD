--------------------------------------------------------------------------------
-- $Header: /devl/xcs/repo/env/Databases/ip/src2/L/cic_compiler_v1_3/simulation/cic_compiler_v1_3_pkg.vhd,v 1.3 2009/12/04 11:46:36 akennedy Exp $
--------------------------------------------------------------------------------
-- Copyright (c) 2006 Xilinx, Inc.
-- All Rights Reserved
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor: Xilinx
-- \   \   \/    Version:
--  \   \        Filename: pkg_template.vhd
--  /   /        Date Created:
-- /___/   /\
-- \   \  /  \
--  \___\/\___\
--
--------------------------------------------------------------------------------
-- 
-- This text contains proprietary, confidential information of Xilinx, Inc.,
-- is distributed under license from Xilinx, Inc., and may be used, copied
-- and/or disclosed only pursuant to the terms of a valid license agreement
-- with Xilinx, Inc.
-- This copyright notice must be retained as part of this text at all times.
--
-------------------------------------------------------------------------------
-- Author   : *********** Auto created - DO NOT MODIFIY BY HAND ***************
-------------------------------------------------------------------------------
-- Description:
--     This file is to be populated by the gen_package.pl script
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.math_real.ALL;

library xilinxcorelib;
-- use xbip_utils_v2_0.bip_utils_pkg_v2_0.all;
use xilinxcorelib.bip_utils_pkg_v2_0.divroundup;
use xilinxcorelib.bip_utils_pkg_v2_0.log2roundup;
use xilinxcorelib.bip_utils_pkg_v2_0.get_min;
use xilinxcorelib.bip_utils_pkg_v2_0.get_max;
use xilinxcorelib.fir_compiler_v5_0_sim_pkg.all;

-------------------------------------------------------------------------------
package cic_compiler_v1_3_pkg is

--------------------------------------------------------------------------------
--From:  ../../hdl/cic_compiler_v1_3_pkg.vhd

  type stage_array is array(0 to 5) of integer;

  type LOG2_LUT_ARRAY is array (natural range <>) of integer;

  function number_of_digits(data_value : integer; radix : integer) return integer;

  function CICBMAX (INPUT_WIDTH : integer; RATE : integer; NUM_STAGES : integer; DIFF_DELAY : integer) return integer;

  function CHOOSE(n,k:integer) return integer;

  function VARERRGAIN(stage,RATE,NUM_STAGES,DIFF_DELAY : integer) return real;

  function BITSTOTRIM(stage,STAGE_TYPE,INPUT_WIDTH,OUTPUT_WIDTH,RATE,NUM_STAGES,DIFF_DELAY : integer) return integer;

  function MAX (LEFT, RIGHT: INTEGER) return INTEGER;

  function MIN (LEFT, RIGHT: INTEGER) return INTEGER;

  function INTERPSTAGEBITS (stage,STAGE_TYPE,INPUT_WIDTH,RATE,NUM_STAGES,DIFF_DELAY : integer) return integer;

  function DEC_SCALING_DELAY_CALC (RATE_TYPE, SCALE_BITS, BMAX, OUTPUT_WIDTH : integer) return integer;

  function SCALING_DELAY_CALC (RATE_TYPE, INT_BMAX, OUTPUT_WIDTH : integer) return integer;

  function W_comb(num_stages, rate, diff_delay, input_width, folding : integer) return stage_array;

  function W_integrator(num_stages, rate, diff_delay, input_width, folding : integer) return stage_array;

  function B_integrator(num_stages, min_rate, max_rate, diff_delay, input_width, output_width, folding : integer) return stage_array;

  function B_comb(num_stages, min_rate, max_rate, diff_delay, input_width, output_width, folding, rounding : integer) return stage_array;

  function CN1L2R_LUT (MIN_RATE,MAX_RATE,STAGES : integer) return LOG2_LUT_ARRAY;

  function DEC_SCALE_LUT_CALC (MIN_RATE,MAX_RATE,STAGES : integer) return LOG2_LUT_ARRAY;

  constant C_MAX_STAGES : integer:=6;

  constant C_INTEGRATOR : integer:=0;

  constant C_COMB       : integer:=1;

  constant C_FIXED_RATE : integer:=0;

  constant C_PROG_RATE  : integer:=1;

  constant C_MAX_STAGE_ADDSUBS : integer :=3;

  constant C_MAX_FABADD_WIDTH : integer := 12; --across all families just now ??

  type t_bool_array is array (integer range <>) of boolean;

  type t_int_comb_section_config is
  record
    latency : integer;
    
    num_physical_stages : integer;
    folded              : t_bool_array(C_MAX_STAGES-1 downto 0);
    stages              : t_int_array(C_MAX_STAGES-1 downto 0);
    split_accums        : t_int_array(C_MAX_STAGES-1 downto 0);--not needed for synth, resource est only
    split_fabric        : t_bool_array(C_MAX_STAGES-1 downto 0);--not needed for synth, resource est only
    actual_widths       : t_int_array(C_MAX_STAGES-1 downto 0);
    
    din_delay             : integer;
  end record;

  function get_int_comb_section_config(
                                  C_INT_OR_COMB : integer;  
                                  C_NUM_STAGES  : integer;
                                  C_DIFF_DELAY  : integer;
                                  C_NUM_CHANNELS: integer;  
                                  C_CLKS_PER_SAMP : integer;
                                  C_WIDTHS : t_int_array(C_MAX_STAGES-1 downto 0);  
                                  C_FAMILY_INFO   : t_family;
                                  C_USE_DSP       : integer ) return t_int_comb_section_config;

  constant c_carryout            : integer:=0;

  constant c_carrycascout        : integer:=1;

  constant c_dsp_to_fabric_carry : integer:=2;

  constant c_fabric_carry        : integer:=3;

  constant c_gated_msb_carry     : integer:=4;

  type t_int_comb_stage_folded_config is
  record
    latency : integer;
    num_split_accums : integer;
    split_accum_delay : t_int_array(C_MAX_STAGE_ADDSUBS downto 0);--integer;
    accum_widths      : t_int_array(C_MAX_STAGE_ADDSUBS-1 downto 0);
    carry_method      : t_int_array(C_MAX_STAGE_ADDSUBS-1 downto 0);--t_bool_array(C_MAX_STAGE_ADDSUBS-1 downto 0);--boolean;
    
    add_sub_cnfg : t_emb_calc_array(C_MAX_STAGE_ADDSUBS-1 downto 0);
    add_sub_dtls : t_emb_calc_details_array(C_MAX_STAGE_ADDSUBS-1 downto 0);
    sum_lat   : integer;
    
    mem_depth : integer;
    
    din_delay : integer;
    
  end record;

  function get_int_comb_stage_folded_config(
                                        C_INT_OR_COMB : integer;
                                        C_NUM_STAGES  : integer;
                                        C_DIFF_DELAY  : integer;
                                        C_NUM_CHANNELS: integer;
                                        C_FAMILY_INFO : t_family;
                                        C_USE_DSP       : integer;
                                        C_WIDTH         : integer;
                                        C_USE_RTL       : boolean;
                                        C_LAST_STAGE    : boolean;
                                        C_ALIGN_OPS     : boolean;
                                        C_IPS_ALIGNED   : boolean;
                                        C_PAD_TO_STAGES : integer ) return t_int_comb_stage_folded_config;

  type t_int_comb_stage_unfolded_config is
  record
    latency : integer;
    num_split_accums : integer;
    -- split_accum_delay : integer;
    split_accum_delay : t_int_array(C_MAX_STAGE_ADDSUBS downto 0);--integer;
    accum_widths      : t_int_array(C_MAX_STAGE_ADDSUBS-1 downto 0);
    carry_method      : t_int_array(C_MAX_STAGE_ADDSUBS-1 downto 0);
    
    add_sub_cnfg : t_emb_calc_array(C_MAX_STAGE_ADDSUBS-1 downto 0);
    add_sub_dtls : t_emb_calc_details_array(C_MAX_STAGE_ADDSUBS-1 downto 0);
    sum_lat   : integer;
    
    mem_depth : integer;
    
    din_delay : integer;
    
  end record;

  function get_int_comb_stage_unfolded_config(
                                        C_INT_OR_COMB : integer;
                                        C_DIFF_DELAY  : integer;
                                        C_NUM_CHANNELS: integer;
                                        C_FAMILY_INFO : t_family;
                                        C_USE_DSP       : integer;
                                        C_WIDTH         : integer;
                                        C_USE_RTL       : boolean;
                                        C_ALIGN_OPS     : boolean;
                                        C_IPS_ALIGNED   : boolean ) return t_int_comb_stage_unfolded_config;

  type t_interpolate_config is
  record
    latency : integer;
    family  : t_family;
    
    ip_rate_cnt : integer;
    px_cnt      : integer;
    
    integrator  : t_int_comb_section_config;
    comb        : t_int_comb_section_config;
    
    chan_buffer   : t_ram;
    chan_buffer_addr : t_twopage_address;
    
  end record;

  function get_interpolate_config(
                            C_NUM_STAGES : integer;
                            C_DIFF_DELAY : integer;
                            C_RATE : integer;
                            C_INPUT_WIDTH : integer;
                            C_OUTPUT_WIDTH : integer;
                            C_USE_DSP : integer;
                            C_HAS_ROUNDING : integer;
                            C_NUM_CHANNELS  : integer;
                            C_RATE_TYPE : integer;
                            C_MIN_RATE : integer;
                            C_MAX_RATE : integer;
                            C_SAMPLE_FREQ : integer;
                            C_CLK_FREQ : integer;
                            C_USE_STREAMING_INTERFACE : integer;
                            C_XDEVICEFAMILY : string ;
                            C_COMB_WIDTHS : t_int_array(C_MAX_STAGES-1 downto 0);
                            C_INT_WIDTHS : t_int_array(C_MAX_STAGES-1 downto 0)) return t_interpolate_config;

  type t_decimate_config is
  record
    latency : integer;
    family  : t_family;
    
    ip_rate_cnt : integer;
    px_cnt      : integer;
    
    integrator  : t_int_comb_section_config;
    comb        : t_int_comb_section_config;
    
    chan_buffer   : t_ram;
    chan_buffer_addr : t_twopage_address;
    
  end record;

  function get_decimate_config(
                            C_NUM_STAGES : integer;
                            C_DIFF_DELAY : integer;
                            C_RATE : integer;
                            C_INPUT_WIDTH : integer;
                            C_OUTPUT_WIDTH : integer;
                            C_USE_DSP : integer;
                            C_HAS_ROUNDING : integer;
                            C_NUM_CHANNELS  : integer;
                            C_RATE_TYPE : integer;
                            C_MIN_RATE : integer;
                            C_MAX_RATE : integer;
                            C_SAMPLE_FREQ : integer;
                            C_CLK_FREQ : integer;
                            C_USE_STREAMING_INTERFACE : integer;
                            C_XDEVICEFAMILY : string ;
                            C_COMB_WIDTHS : t_int_array(C_MAX_STAGES-1 downto 0);
                            C_INT_WIDTHS : t_int_array(C_MAX_STAGES-1 downto 0)) return t_decimate_config;


end cic_compiler_v1_3_pkg;

-------------------------------------------------------------------------------
package body cic_compiler_v1_3_pkg is

--------------------------------------------------------------------------------
--From:  ../../hdl/cic_compiler_v1_3_pkg.vhd

  function number_of_digits (data_value : integer; radix : integer) return integer is
    variable dwidth : integer := 0;
  begin
    while radix**dwidth-1 < data_value and data_value > 0 loop
      dwidth := dwidth + 1;
    end loop;
    return dwidth;
  end number_of_digits;

  function CICBMAX (INPUT_WIDTH : integer; RATE : integer; NUM_STAGES : integer; DIFF_DELAY : integer) RETURN integer is
	  variable max_bit_width : integer := 1;
  begin
	  max_bit_width := integer(ceil(real(NUM_STAGES) * LOG2(real(RATE*DIFF_DELAY)) + real(INPUT_WIDTH)));
	  return(max_bit_width);
  end function CICBMAX;

  function CHOOSE(n,k:integer) return integer is
	  variable num : real := 0.0;
	  variable den : real := 0.0;
	  variable result : integer := 0;
  begin
	  num := 1.0;
	  den := 1.0;
	  if k < n then
		  for j in (k+1) to n loop
			  num := num * real(j);
		  end loop;
		  for i in 1 to (n-k) loop
		  	den := den * real(i);
	  	  end loop;
	  end if;
	  result := integer(num/den);

	  return result;
  end function CHOOSE;

  function VARERRGAIN(stage,RATE,NUM_STAGES,DIFF_DELAY : integer) return real is
	  variable posneg : real := 1.0;
	  variable h_k,Fj,Fj2 : real := 0.0;
	  variable result : real := 0.0;
  begin
	  Fj2 := 0.0;
	  if stage > NUM_STAGES then
		  posneg := 1.0;		  
		  for k in 0 to (2*NUM_STAGES + 1 - stage) loop
			  h_k := posneg * real(CHOOSE(2*NUM_STAGES + 1 - stage, k));
			  Fj2 := Fj2 + h_k * h_k;
			  posneg := posneg*(-1.0);
		  end loop;

	  else
		  for k in 0 to ((RATE*DIFF_DELAY - 1)*NUM_STAGES + stage - 1) loop
			  posneg := 1.0;
			  h_k := 0.0;
			  for l in 0 to (k / (RATE * DIFF_DELAY)) loop
				  h_k := h_k + posneg * real(CHOOSE(NUM_STAGES,l)) * real(CHOOSE((NUM_STAGES-stage+k) - (RATE*DIFF_DELAY*l),k - (RATE*DIFF_DELAY*l)));

  				  posneg := posneg*(-1.0);
			  end loop;
			  Fj2 := Fj2 + h_k * h_k;
		  end loop;
	  end if;
	  result := Fj2;
	  return result;
  end function VARERRGAIN;

  function BITSTOTRIM(stage,STAGE_TYPE,INPUT_WIDTH,OUTPUT_WIDTH,RATE,NUM_STAGES,DIFF_DELAY : integer) return integer is
	  variable Bmax,Bmin,Bout,trim_bits,bits_tmp : real;
	  variable Bj : real;
	  variable Ej,sigma_sqrd_j,log2_sigma_j,Fj2 : real;
	  
  begin
	  Bmax := real(CICBMAX(INPUT_WIDTH,RATE,NUM_STAGES,DIFF_DELAY));

	  Bj := Bmax - real(OUTPUT_WIDTH);

	  if Bj > 0.0 then
		  Ej := 2.0**Bj;
		  sigma_sqrd_j := (1.0/12.0)* (Ej*Ej);
		  log2_sigma_j := (0.5)*LOG2(sigma_sqrd_j);
	  else
		  Ej := 0.0;
		  sigma_sqrd_j := 0.0;
		  log2_sigma_j := 0.0;
	  end if;

	  if stage > NUM_STAGES then
		  if STAGE_TYPE = 0 then
			  trim_bits := 0.0; -- no trimming for integrator registers beyond number of actual stages
		  else
			  trim_bits := Bmax - real(OUTPUT_WIDTH); -- peg trimming to maximum for comb stages beyond actual number
		  end if;
	  else
		  if STAGE_TYPE = 0 then
			  Fj2 := VARERRGAIN(stage,RATE,NUM_STAGES,DIFF_DELAY); -- integrator stage
		  else
			  Fj2 := VARERRGAIN((stage + NUM_STAGES),RATE,NUM_STAGES,DIFF_DELAY); -- comb stage - adjust stage number
		  end if;

		  -- if Fj2 > 0.0 then
		  if ((Fj2 > 0.0) and (Bj > 0.0)) then
		  	--trim_bits := floor((-0.5)*LOG2(Fj2) + log2_sigma_j + 0.5*log2(6.0/real(NUM_STAGES)));
			bits_tmp := floor((-0.5)*LOG2(Fj2) + log2_sigma_j + 0.5*log2(6.0/real(NUM_STAGES)));
			if bits_tmp < 0.0 then
				trim_bits := 0.0;
			else
				trim_bits := bits_tmp;
			end if;
		  else
		  	trim_bits := 0.0;
		  end if;
	  end if;

	  return integer(trim_bits);

  end function BITSTOTRIM;

  function MAX (LEFT, RIGHT: INTEGER) return INTEGER is
  begin
    if LEFT > RIGHT then return LEFT;
    else return RIGHT;
    end if;
  end MAX;

  function MIN (LEFT, RIGHT: INTEGER) return INTEGER is
  begin
    if LEFT < RIGHT then return LEFT;
    else return RIGHT;
    end if;
  end MIN;

  function INTERPSTAGEBITS (stage,STAGE_TYPE,INPUT_WIDTH,RATE,NUM_STAGES,DIFF_DELAY : integer) return integer is
	  variable bitwidth : integer;
	  variable tmp1 : real;
	  variable tmp0_0 : real;
	  variable tmp0_1 : real;
  begin

	  if STAGE_TYPE = 0 then
		  -- integrator stages
		  if stage > NUM_STAGES then
			  tmp0_0 := 2.0**(real(2*NUM_STAGES - (NUM_STAGES + stage)));
		  else
			  tmp0_0 := round(2.0**(real(2*NUM_STAGES - (NUM_STAGES + stage))));
		  end if;
		  tmp0_1 := round(real(RATE * DIFF_DELAY) ** (real(stage)));
		  tmp1 := (tmp0_0 * tmp0_1)/real(RATE);
		  --tmp1 := (2.0**(real(2*NUM_STAGES - (NUM_STAGES + stage))) * real(RATE * DIFF_DELAY) ** (real(stage))) / real(RATE);
		  bitwidth := INPUT_WIDTH + integer(ceil(log2(tmp1)));

	  else
		  -- comb stages
		  bitwidth := INPUT_WIDTH + stage;
		  -- special case for diff delay 1
		  if DIFF_DELAY = 1 then
			  if stage = NUM_STAGES then
				  bitwidth := INPUT_WIDTH + NUM_STAGES - 1;
			  end if;
		  end if;

	  end if;

	  return bitwidth;

  end INTERPSTAGEBITS;

  function W_comb(num_stages, rate, diff_delay, input_width, folding : integer) return stage_array is
    variable W : stage_array;
  begin
    for j in 1 to (num_stages) loop
	if folding = 0 then
		-- unfolded stages - use bit trimming register sizing
		W(j-1) := INTERPSTAGEBITS (j,1,input_width,rate,num_stages,diff_delay);
	else
		-- folded stages - use largest register size for all 
		W(j-1) := INTERPSTAGEBITS (num_stages,1,input_width,rate,num_stages,diff_delay);
	end if;
    end loop;

    for j in num_stages+1 to 6 loop
      W(j-1) := 0;
    end loop;

    return W;
  end W_comb;

  function W_integrator(num_stages, rate, diff_delay, input_width, folding : integer) return stage_array is
    variable W : stage_array;
  begin
    for k in 1 to (num_stages) loop
	    if folding = 0 then
		    -- unfolded stages - use bit trimming register sizing
		    W(k-1) := INTERPSTAGEBITS (k,0,input_width,rate,num_stages,diff_delay);
	    else
		    -- folded stages - use largets register size for all
		    W(k-1) := INTERPSTAGEBITS (num_stages,0,input_width,rate,num_stages,diff_delay);
	    end if;
    end loop;

    for k in num_stages+1 to 6 loop
      W(k-1) := 0;
    end loop;

    return W;
  end W_integrator;

 function B_integrator(num_stages, min_rate, max_rate, diff_delay, input_width, output_width, folding : integer) return stage_array is
    variable Bmax : integer := 1;
    variable j : integer := 1;
    variable Btrim : integer := 1;
    variable B : stage_array;
  begin
    Bmax := CICBMAX(input_width, max_rate, num_stages, diff_delay );
    for i in 0 to num_stages-1 loop
      j := i + 1;

      if folding = 0 then
	      -- no folding; set register sizes normally with possible bit trimming
	      Btrim := BITSTOTRIM(j, 0, input_width, output_width, max_rate, num_stages, diff_delay);
      else
	      -- folding; set register sizes all based on first stage
	      Btrim := BITSTOTRIM(1, 0, input_width, output_width, max_rate, num_stages, diff_delay);
      end if;
      B(i) := Bmax - Btrim;
    end loop;

    for k in num_stages to 5 loop
      B(k) := 0;
    end loop;
    return B;
  end B_integrator;

  function B_comb(num_stages, min_rate, max_rate, diff_delay, input_width, output_width, folding, rounding : integer) return stage_array is
    variable Bmax : integer := 1;
    variable j : integer := 1;
    variable Btrim, Bround : integer := 1;
    variable B : stage_array;
  begin

    Bmax := CICBMAX(input_width, max_rate, num_stages, diff_delay );

    for i in 0 to num_stages-1 loop
      j := i + 1;

      if folding = 0 then
	      -- no folding, set register sizes normally with possible bit trimming
	      Btrim := BITSTOTRIM(j, 1, input_width, output_width, max_rate, num_stages, diff_delay);
      else
     	      -- folding, set register sizes all based on first stage
	      Btrim := BITSTOTRIM(1, 1, input_width, output_width, max_rate, num_stages, diff_delay);
      end if;
      B(i) := Bmax - Btrim;
    end loop;

    -- adjust register sizes for rounding if necessary
    if rounding = 1 then
	    if ((folding = 0) and (B(num_stages-1) < Bmax)) then
		    -- no folding and limited precision; make size of last stage one more than that of previous stage to keep full precision in last comb
		    --B(num_stages-1) := B(num_stages-2) + 1;

	    elsif ((folding = 1) and (B(num_stages-1) < Bmax)) then
		    -- folding and limited precision
		    Bround := MAX(B(1), (Bmax - BITSTOTRIM(num_stages-1, 1, input_width, output_width, max_rate, num_stages, diff_delay) + 1));
		    for i in 1 to num_stages loop
		--    B(i) := Bround;
		    end loop;
	    end if;
    end if;

    for k in num_stages to 5 loop
      B(k) := 0;
    end loop;
    return B;
  end B_comb;

  function SCALING_DELAY_CALC (RATE_TYPE, INT_BMAX, OUTPUT_WIDTH : integer) return integer is
	  variable scaling_latency : integer;
  begin
	  scaling_latency := 0;

	  if RATE_TYPE = 1 then
	  	if OUTPUT_WIDTH < INT_BMAX then
			  scaling_latency := 2;	  
	  	end if;
	  end if;

	  return scaling_latency;

  end SCALING_DELAY_CALC;

  function DEC_SCALING_DELAY_CALC (RATE_TYPE, SCALE_BITS, BMAX, OUTPUT_WIDTH : integer) return integer is
	  variable scaling_latency : integer;
  begin
	  scaling_latency := 0;

	  if (RATE_TYPE = 1) and (SCALE_BITS > 0) and (OUTPUT_WIDTH < BMAX) then
		  scaling_latency := 2;
	  end if;

	  return scaling_latency;

  end DEC_SCALING_DELAY_CALC;

  function CN1L2R_LUT (MIN_RATE,MAX_RATE,STAGES : integer) return LOG2_LUT_ARRAY is 
	  variable lut_vals : LOG2_LUT_ARRAY (0 to MAX_RATE-MIN_RATE);
	  variable i : integer := 0;
	  variable tmp1,tmp2 : real;
  begin
	  i := 0;
	  for rate in MIN_RATE to MAX_RATE loop
		  tmp1 := ceil(real(STAGES-1)*log2(real(MAX_RATE)));
		  tmp2 := ceil(real(STAGES-1)*log2(real(rate)));
		  lut_vals(i) := integer(tmp1 - tmp2);
		  i := i + 1;
	  end loop;

	  return lut_vals;

  end CN1L2R_LUT;

  function DEC_SCALE_LUT_CALC (MIN_RATE,MAX_RATE,STAGES : integer) return LOG2_LUT_ARRAY is 
	  variable lut_vals : LOG2_LUT_ARRAY (0 to MAX_RATE-MIN_RATE);
	  variable i : integer := 0;
	  variable tmp1,tmp2 : real;
  begin
	  i := 0;
	  for rate in MIN_RATE to MAX_RATE loop
		  tmp1 := ceil(real(STAGES)*log2(real(rate)));
		  tmp2 := ceil(real(STAGES)*log2(real(MIN_RATE)));
		  lut_vals(i) := integer(tmp1 - tmp2);
		  i := i + 1;
	  end loop;

	  return lut_vals;

  end DEC_SCALE_LUT_CALC;

  function get_int_comb_section_config(
                                  C_INT_OR_COMB : integer;  
                                  C_NUM_STAGES  : integer;
                                  C_DIFF_DELAY  : integer;
                                  C_NUM_CHANNELS: integer;  
                                  C_CLKS_PER_SAMP : integer;
                                  C_WIDTHS : t_int_array(C_MAX_STAGES-1 downto 0);  
                                  C_FAMILY_INFO   : t_family;
                                  C_USE_DSP       : integer ) return t_int_comb_section_config is
    variable config : t_int_comb_section_config;
    variable full_stages:integer;
    variable stage_config_unfolded: t_int_comb_stage_unfolded_config;
    variable stage_config_folded: t_int_comb_stage_folded_config;
    variable curr_stage,
             max_accum : integer:=0;
  begin
    
    config.num_physical_stages:=divroundup(C_NUM_STAGES,C_CLKS_PER_SAMP);
    
    --parallel
    config.folded:=(others=>false);
    config.stages:=(others=>1);
    
    if C_NUM_STAGES>1 and C_CLKS_PER_SAMP>1 then
      --folded
      if config.num_physical_stages=1 then
        config.stages(0):=get_min(C_NUM_STAGES,C_CLKS_PER_SAMP);
        config.folded(0):=true;
      else
        full_stages:=C_NUM_STAGES/C_CLKS_PER_SAMP;
        -- gui trans_off
        config.stages(full_stages-1 downto 0):=(others=>get_min(C_NUM_STAGES,C_CLKS_PER_SAMP));
        config.folded(full_stages-1 downto 0):=(others=>true);
        -- gui trans_on
        -- gui insert_on
        -- for i in 0 to full_stages-1 loop
          -- config.stages(i):=get_min(C_NUM_STAGES,C_CLKS_PER_SAMP);
          -- config.folded(i):=true;
        -- end loop;
        -- gui insert_off
        if C_NUM_STAGES rem C_CLKS_PER_SAMP > 0 then
          --final stage partially utilized
          config.stages(full_stages):=C_NUM_STAGES rem C_CLKS_PER_SAMP;
          if C_NUM_STAGES rem C_CLKS_PER_SAMP = 1 then
            --last stage unfolded
            config.folded(full_stages):=false;
          else
            config.folded(full_stages):=true;
          end if;
        end if;
      end if;
    end if;
    
    --Determine if the input data needs to be delayed. Although this is being retrived via a function
    --both the comb and integrator stages should be the same regardless if they are folded or not so slightly
    --redundant call
    
    config.latency:=0;
    curr_stage:=0;
    -- gui trans_off
    config.actual_widths:=(others=>0);
    -- gui trans_on
    for stage in 0 to config.num_physical_stages-1 loop
      max_accum:=0;
      for i in curr_stage to curr_stage+config.stages(stage)-1 loop
        if C_WIDTHS(i)>max_accum then
          max_accum:=C_WIDTHS(i);
        end if;
      end loop;
      for i in curr_stage to curr_stage+config.stages(stage)-1 loop
        config.actual_widths(i):=max_accum;
      end loop;
      curr_stage:=curr_stage+config.stages(stage);
      
      if config.folded(stage) then
        stage_config_folded:=get_int_comb_stage_folded_config(
                                            C_INT_OR_COMB,
                                            config.stages(stage),
                                            C_DIFF_DELAY,
                                            C_NUM_CHANNELS,
                                            C_FAMILY_INFO,
                                            C_USE_DSP,
                                            config.actual_widths(curr_stage-1),--C_WIDTHS(curr_stage-1),
                                            false,--default
                                            (stage=config.num_physical_stages-1),
                                            true, --temp values********
                                            true,
                                            config.stages(get_max(0,stage-1)));
        if stage=0 then                                            
          config.din_delay:=stage_config_folded.din_delay;
        end if;
        config.latency:=config.latency+stage_config_folded.latency;
        --For resource estimate
        config.split_accums(stage):=stage_config_folded.num_split_accums;
        config.split_fabric(stage):=stage_config_folded.add_sub_cnfg(stage_config_folded.num_split_accums-1).family.has_fabric_dsp48 or
                                    stage_config_folded.add_sub_cnfg(0).family.has_fabric_dsp48;
      else
        stage_config_unfolded:=get_int_comb_stage_unfolded_config(
                                            C_INT_OR_COMB,
                                            C_DIFF_DELAY,
                                            C_NUM_CHANNELS,
                                            C_FAMILY_INFO,
                                            C_USE_DSP,
                                            config.actual_widths(curr_stage-1),--C_WIDTHS(curr_stage-1),
                                            false,--default
                                            true,--temp values********
                                            true);
        if stage=0 then                                            
          config.din_delay:=stage_config_unfolded.din_delay;
        end if;
        config.latency:=config.latency+stage_config_unfolded.latency;
        --For resource estimate
        config.split_accums(stage):=stage_config_unfolded.num_split_accums;
        config.split_fabric(stage):=stage_config_unfolded.add_sub_cnfg(stage_config_unfolded.num_split_accums-1).family.has_fabric_dsp48 or
                                    stage_config_unfolded.add_sub_cnfg(0).family.has_fabric_dsp48;
      end if;
    end loop;
    
    return config;
  end get_int_comb_section_config;

  function get_int_comb_stage_folded_config(
                                        C_INT_OR_COMB : integer;
                                        C_NUM_STAGES  : integer;
                                        C_DIFF_DELAY  : integer;
                                        C_NUM_CHANNELS: integer;
                                        C_FAMILY_INFO : t_family;
                                        C_USE_DSP       : integer;
                                        C_WIDTH         : integer;
                                        C_USE_RTL       : boolean;
                                        C_LAST_STAGE    : boolean;
                                        C_ALIGN_OPS     : boolean;
                                        C_IPS_ALIGNED   : boolean;
                                        C_PAD_TO_STAGES : integer ) return t_int_comb_stage_folded_config is
    variable config : t_int_comb_stage_folded_config;
    
    constant opcodes_used: t_calc_func_used := funcs_emb_calc((0=>C_add_A_concat_B,1=>P_add_A_concat_B,2=>NOP));
                                               
    variable remaining_width : integer:=C_WIDTH;
    variable accum_max,
             accum: integer;
  begin
    
    --Default configuration
    config.add_sub_cnfg(0):=(
      family         => C_FAMILY_INFO,
      implementation => 1,
      pre_add        => 0,
      pre_add_func   => c_preadd_add,
      pre_add_ipreg  => 0,
      pre_add_midreg => 0,
      a_delay        => select_integer(0,1,C_FAMILY_INFO.has_fabric_dsp48),--1 to balance opcode reg and 1 to balance opcode generation, 1 reg always enabled of dsp
      b_delay        => select_integer(0,1,C_FAMILY_INFO.has_fabric_dsp48),
      p_delay        => 0,--no extra p delay required
      a_src          => 0,--fabric
      a_sign         => c_signed,
      b_sign         => c_signed,
      d_sign         => c_signed,
      a_width        => 1,--only used for preadder calc
      b_width        => 1,
      reg_opcode     => select_integer(1,0,C_FAMILY_INFO.has_fabric_dsp48),
      enable_pat_det => false,
      pattern        => "000000000000000000000000000000000000000000000000",--gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
      mask           => "000000000000000000000000000000000000000000000000",--gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
      post_add_width => C_WIDTH,--config.accum_widths(0),
      calc_func_used => opcodes_used,
      split_post_adder => false,
      has_redundant => p_none
    );
    
    
    accum_max:=48;
    if C_FAMILY_INFO.emb_calc_prim=p_dsp48 then
      accum_max:=35;
    end if;
    
    config.num_split_accums:=0;
    config.split_accum_delay(0):=0;
    
    while remaining_width > 0 loop --accum_max loop
      --The structure arrays are indexes 0 to so use a local variable, rabassa wae unhappy with the sub -1 everywhere
      accum:=config.num_split_accums;
      config.num_split_accums:=config.num_split_accums+1;
      
      if C_FAMILY_INFO.has_fabric_dsp48 then
        --Don't split fabric implementation currently
        remaining_width:=0;
        config.carry_method(0):=c_carryout;
        config.accum_widths(0):=C_WIDTH;  
      elsif C_FAMILY_INFO.emb_calc_prim=p_dsp48 then
        config.accum_widths(accum):=get_min(35,remaining_width);
        remaining_width:=remaining_width-35;        
        config.carry_method(accum):=c_fabric_carry;
        if accum<C_MAX_STAGE_ADDSUBS then
          config.split_accum_delay(config.num_split_accums):=3;
        end if;
      else
        config.accum_widths(accum):=get_min(48,remaining_width);
        remaining_width:=remaining_width-48;
        --Use cascade carry by default
        config.carry_method(accum):=c_carrycascout;
        if accum<C_MAX_STAGE_ADDSUBS then
          if C_FAMILY_INFO.supports_dsp48e or C_FAMILY_INFO.emb_calc_prim=p_dsp48a then
            config.split_accum_delay(config.num_split_accums):=1;
          else
            config.split_accum_delay(config.num_split_accums):=2;
          end if;
        end if;
      end if;
      
      -- gui trans_off
      config.add_sub_cnfg(accum):=config.add_sub_cnfg(0);
      -- gui trans_on
      -- gui insert_on
      -- config.add_sub_cnfg(accum):=ret_emb_calc_dtls(config.add_sub_cnfg(0));
      -- gui insert_off
      config.add_sub_cnfg(accum).post_add_width:=config.accum_widths(accum);
      config.add_sub_dtls(accum):=dtls_emb_calc(config.add_sub_cnfg(accum));
      
    end loop;
    
    if config.accum_widths(accum) <= C_MAX_FABADD_WIDTH
       and config.num_split_accums > 1
       and not((C_FAMILY_INFO.emb_calc_prim=p_dsp48) and C_INT_OR_COMB=C_COMB) then
      
      if C_FAMILY_INFO.emb_calc_prim/=p_dsp48a then
        --Use a fabric adder for last adder
        config.add_sub_cnfg(accum).family.emb_calc_prim    :=p_mult18s;
        config.add_sub_cnfg(accum).family.treat_as_s3adsp  :=true;
        config.add_sub_cnfg(accum).family.has_fabric_dsp48 :=true;
        config.add_sub_cnfg(accum).a_delay:=1;
        config.add_sub_cnfg(accum).b_delay:=1;
      
        --Switch carry out method of previous adder, 2nd last
        if C_FAMILY_INFO.supports_dsp48e or (C_INT_OR_COMB=C_INTEGRATOR and C_FAMILY_INFO.emb_calc_prim/=p_dsp48) then
          --Carry out directly compatible with fabric
          config.carry_method(config.num_split_accums-2):=c_carryout;
          config.split_accum_delay(accum):=2;
        elsif C_FAMILY_INFO.emb_calc_prim/=p_dsp48 then
          --Spartan families need to have their dsp carry converted to a fabric format when subtract functionality, inversion (only S6 as can't drive fabric on s3adsp)
          config.carry_method(config.num_split_accums-2):=c_dsp_to_fabric_carry;
          config.split_accum_delay(accum):=3;
        end if;
        
        config.add_sub_dtls(accum):=dtls_emb_calc(config.add_sub_cnfg(accum));
      else
        --On Sandia put fabric adder on bottom
        
        --Swap accumulation widths
        config.add_sub_cnfg(accum).post_add_width:=config.accum_widths(0);
        config.add_sub_cnfg(0).post_add_width:=config.accum_widths(accum);
        config.accum_widths(0):=config.accum_widths(accum);
        config.accum_widths(accum):=config.add_sub_cnfg(accum).post_add_width;
        
        config.add_sub_cnfg(0).family.emb_calc_prim    :=p_mult18s;
        config.add_sub_cnfg(0).family.treat_as_s3adsp  :=true;
        config.add_sub_cnfg(0).family.has_fabric_dsp48 :=true;
        config.add_sub_cnfg(0).a_delay:=1;
        config.add_sub_cnfg(0).b_delay:=1;
        
        if C_INT_OR_COMB=C_COMB then
          config.split_accum_delay(1):=3;
          config.carry_method(0):=c_dsp_to_fabric_carry;
        else
          config.split_accum_delay(1):=2;
          config.carry_method(0):=c_carryout; --can use carry out directly as adding
        end if;
        
        config.add_sub_dtls(accum):=dtls_emb_calc(config.add_sub_cnfg(accum));
        config.add_sub_dtls(0):=dtls_emb_calc(config.add_sub_cnfg(0));
      
      end if;
      
    end if;
    
    
    if C_LAST_STAGE then
      if C_INT_OR_COMB = C_COMB then
        config.mem_depth := C_DIFF_DELAY * C_NUM_CHANNELS * C_PAD_TO_STAGES;
      else
        config.mem_depth := C_NUM_CHANNELS * C_PAD_TO_STAGES;
      end if;
    else
      if C_INT_OR_COMB = C_COMB then
        config.mem_depth := C_DIFF_DELAY * C_NUM_CHANNELS * C_NUM_STAGES;
      else
        config.mem_depth := C_NUM_CHANNELS * C_NUM_STAGES;
      end if;
    end if;
    
    if C_USE_RTL then
      config.sum_lat:=1;
      config.din_delay:=0;
    else
      config.sum_lat:=2;
      if C_FAMILY_INFO.has_fabric_dsp48 then
        config.din_delay:=0;
      else
        config.din_delay:=1;
      end if;
    end if;
    
    config.latency:=config.sum_lat+C_NUM_STAGES-1;
    
    if not C_USE_RTL and config.num_split_accums>1 then
      -- config.latency:=config.latency+((config.num_split_accums-1)*config.split_accum_delay);
      for i in 0 to config.num_split_accums-1 loop
        config.latency:=config.latency+config.split_accum_delay(i);
      end loop; 
    end if;
    
    return config;
  end get_int_comb_stage_folded_config;

  function get_int_comb_stage_unfolded_config(
                                        C_INT_OR_COMB : integer;
                                        C_DIFF_DELAY  : integer;
                                        C_NUM_CHANNELS: integer;
                                        C_FAMILY_INFO : t_family;
                                        C_USE_DSP       : integer;
                                        C_WIDTH         : integer;
                                        C_USE_RTL       : boolean;
                                        C_ALIGN_OPS     : boolean;
                                        C_IPS_ALIGNED   : boolean) return t_int_comb_stage_unfolded_config is
    variable config : t_int_comb_stage_unfolded_config;
    
    variable opcodes_used: t_calc_func_used;-- := funcs_emb_calc((0=>C_add_A_concat_B,1=>P_add_C,2=>NOP));
    
    variable remaining_width: integer:=C_WIDTH;
    variable accum_max,
             accum      : integer;
  begin
    
    if C_INT_OR_COMB = C_COMB then
      config.mem_depth := C_DIFF_DELAY * C_NUM_CHANNELS;
    else
      config.mem_depth := C_NUM_CHANNELS;
    end if;
    
    if C_INT_OR_COMB=C_INTEGRATOR and config.mem_depth-2 <0 then
      opcodes_used:=funcs_emb_calc((0=>P_add_C,1=>NOP));
    else
      opcodes_used:=funcs_emb_calc((0=>C_add_A_concat_B,1=>NOP));
    end if;
    
    --Default configuration
    config.add_sub_cnfg(0):=(
      family         => C_FAMILY_INFO,
      implementation => 1,
      pre_add        => 0,
      pre_add_func   => c_preadd_add,
      pre_add_ipreg  => 0,
      pre_add_midreg => 0,
      a_delay        => select_integer(0,1,C_FAMILY_INFO.has_fabric_dsp48),--1 to balance opcode reg and 1 to balance opcode generation, 1 reg always enabled of dsp
      b_delay        => select_integer(0,1,C_FAMILY_INFO.has_fabric_dsp48),
      p_delay        => 0,--no extra p delay required
      a_src          => 0,--fabric
      a_sign         => c_signed,
      b_sign         => c_signed,
      d_sign         => c_signed,
      a_width        => 1,--only used for preadder calc
      b_width        => 1,
      reg_opcode     => select_integer(1,0,C_FAMILY_INFO.has_fabric_dsp48),
      enable_pat_det => false,
      pattern        => "000000000000000000000000000000000000000000000000",--gen_pattern(reqs.round_mode,reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
      mask           => "000000000000000000000000000000000000000000000000",--gen_mask(reqs.path_reqs.accum_width(0),reqs.path_reqs.output_width(0),false,48),
      post_add_width => config.accum_widths(0),
      calc_func_used => opcodes_used,
      split_post_adder => false,
      has_redundant => p_none
    );
    
    accum_max:=48;
    if C_FAMILY_INFO.emb_calc_prim=p_dsp48 and opcodes_used(C_add_A_concat_B) then
      --fed back accum so need different boudary
      accum_max:=35;
    end if;
    
    config.num_split_accums:=0;
    config.split_accum_delay(0):=0;
    
    while remaining_width > 0 loop
      --The structure arrays are indexes 0 to so use a local variable, rabassa wae unhappy with the sub -1 everywhere
      accum:=config.num_split_accums;
      config.num_split_accums:=config.num_split_accums+1;
      
      if C_FAMILY_INFO.has_fabric_dsp48 then
        --Don't split fabric implementation currently
        remaining_width:=0;
        config.carry_method(0):=c_carryout;
        config.accum_widths(0):=C_WIDTH;  
      elsif C_FAMILY_INFO.emb_calc_prim=p_dsp48 then
        -- Note: V4 implementation will probably not work fro COMB(subtraction) but unfolded is not currently used. Would
        -- have to be for SIMO/MISO implementations
        config.accum_widths(accum):=get_min(35,remaining_width);
        remaining_width:=remaining_width-35;
        if opcodes_used(P_add_C) then
          --fabric carry
          config.carry_method(accum):=c_fabric_carry;
          if accum<C_MAX_STAGE_ADDSUBS then
            config.split_accum_delay(config.num_split_accums):=3;
          end if;
        else
          --use msb gated
          config.carry_method(accum):=c_gated_msb_carry;
          if accum<C_MAX_STAGE_ADDSUBS then
            config.split_accum_delay(config.num_split_accums):=3;--2;
          end if;
        end if;
      else
        config.accum_widths(accum):=get_min(48,remaining_width);
        remaining_width:=remaining_width-48;
        --Use cascade carry by default
        config.carry_method(accum):=c_carrycascout;
        if accum<C_MAX_STAGE_ADDSUBS then
          if C_FAMILY_INFO.supports_dsp48e or C_FAMILY_INFO.emb_calc_prim=p_dsp48a then
            config.split_accum_delay(config.num_split_accums):=1;
          else
            config.split_accum_delay(config.num_split_accums):=2;
          end if;
        end if;
      end if;
      
      -- gui trans_off
      config.add_sub_cnfg(accum):=config.add_sub_cnfg(0);
      -- gui trans_on
      -- gui insert_on
      -- config.add_sub_cnfg(accum):=ret_emb_calc_dtls(config.add_sub_cnfg(0));
      -- gui insert_off
      config.add_sub_cnfg(accum).post_add_width:=config.accum_widths(accum);
      config.add_sub_dtls(accum):=dtls_emb_calc(config.add_sub_cnfg(accum));
      
      
    end loop;
    
    if config.accum_widths(accum) <= C_MAX_FABADD_WIDTH
       and config.num_split_accums > 1
       and not((C_FAMILY_INFO.emb_calc_prim=p_dsp48) and C_INT_OR_COMB=C_COMB) then
      
      if C_FAMILY_INFO.emb_calc_prim/=p_dsp48a then
        --use a fabric adder for last adder
        config.add_sub_cnfg(accum).family.emb_calc_prim    :=p_mult18s;
        config.add_sub_cnfg(accum).family.treat_as_s3adsp  :=true;
        config.add_sub_cnfg(accum).family.has_fabric_dsp48 :=true;
        config.add_sub_cnfg(accum).a_delay:=1;
        config.add_sub_cnfg(accum).b_delay:=1;
        
        --Switch carry out method of previous adder
        if C_FAMILY_INFO.supports_dsp48e or (C_INT_OR_COMB=C_INTEGRATOR and C_FAMILY_INFO.emb_calc_prim/=p_dsp48) then
          --Carry out directly compatible with fabric
          config.carry_method(config.num_split_accums-2):=c_carryout;
          config.split_accum_delay(accum):=2;
        elsif C_FAMILY_INFO.emb_calc_prim/=p_dsp48 and C_INT_OR_COMB=C_COMB then
          --Spartan families need to have their dsp carry converted to a fabric format when subtract functionality, inversion
          config.carry_method(config.num_split_accums-2):=c_dsp_to_fabric_carry;
          config.split_accum_delay(accum):=3;
        end if;
        
        config.add_sub_dtls(accum):=dtls_emb_calc(config.add_sub_cnfg(accum));
      else
        --On Sandia put fabric adder on bottom
        
        --Swap accumulation widths
        config.add_sub_cnfg(accum).post_add_width:=config.accum_widths(0);
        config.add_sub_cnfg(0).post_add_width:=config.accum_widths(accum);
        config.accum_widths(0):=config.accum_widths(accum);
        config.accum_widths(accum):=config.add_sub_cnfg(accum).post_add_width;
        
        config.add_sub_cnfg(0).family.emb_calc_prim    :=p_mult18s;
        config.add_sub_cnfg(0).family.treat_as_s3adsp  :=true;
        config.add_sub_cnfg(0).family.has_fabric_dsp48 :=true;
        config.add_sub_cnfg(0).a_delay:=1;
        config.add_sub_cnfg(0).b_delay:=1;
        
        if C_INT_OR_COMB=C_COMB then
          config.split_accum_delay(1):=3;
          config.carry_method(0):=c_dsp_to_fabric_carry;
        else
          config.split_accum_delay(1):=2;
          config.carry_method(0):=c_carryout; --can use carry out directly as adding
        end if;
        
        config.add_sub_dtls(accum):=dtls_emb_calc(config.add_sub_cnfg(accum));
        config.add_sub_dtls(0):=dtls_emb_calc(config.add_sub_cnfg(0));
      
      end if;
      
    end if;
    
    if C_USE_RTL then
      config.sum_lat:=1;
      config.din_delay:=0;
    else
      config.sum_lat:=2;
      if C_FAMILY_INFO.has_fabric_dsp48 then
        config.din_delay:=0;
      else
        config.din_delay:=1;
      end if;
    end if;
    
    config.latency:=config.sum_lat;
    
    if not C_USE_RTL and config.num_split_accums>1 then
      -- config.latency:=config.latency+((config.num_split_accums-1)*config.split_accum_delay);
      for i in 0 to config.num_split_accums-1 loop
        config.latency:=config.latency+config.split_accum_delay(i);
      end loop;
    end if;
    
    return config;
  end get_int_comb_stage_unfolded_config;

  function get_interpolate_config(
                            C_NUM_STAGES : integer;
                            C_DIFF_DELAY : integer;
                            C_RATE : integer;
                            C_INPUT_WIDTH : integer;
                            C_OUTPUT_WIDTH : integer;
                            C_USE_DSP : integer;
                            C_HAS_ROUNDING : integer;
                            C_NUM_CHANNELS  : integer;
                            C_RATE_TYPE : integer;
                            C_MIN_RATE : integer;
                            C_MAX_RATE : integer;
                            C_SAMPLE_FREQ : integer;
                            C_CLK_FREQ : integer;
                            C_USE_STREAMING_INTERFACE : integer;
                            C_XDEVICEFAMILY : string ;
                            C_COMB_WIDTHS : t_int_array(C_MAX_STAGES-1 downto 0);
                            C_INT_WIDTHS : t_int_array(C_MAX_STAGES-1 downto 0)) return t_interpolate_config is
    variable config: t_interpolate_config;
    constant family_info: t_family := family_val(C_XDEVICEFAMILY);
    variable family_info_qual: t_family;
    variable last_stage_width: integer;
  begin
    family_info_qual:=family_info;
    if C_USE_DSP=0 then
      family_info_qual.emb_calc_prim   :=p_mult18s; --this will be usused and not generated given opcodes
      family_info_qual.treat_as_s3adsp  :=true;
      family_info_qual.has_fabric_dsp48:=true; --ensures fabric adder
    end if;
    config.family:=family_info_qual;
    
    -- C_SAMPLE_FREQ defines the highest frequency for the lower upsample rate.
    -- To obtain the output oversampling rate ip_rate_cnt should be divided by 
    -- C_MIN_RATE.
    config.ip_rate_cnt:=(C_CLK_FREQ/C_SAMPLE_FREQ)/C_NUM_CHANNELS;
    if C_RATE_TYPE=C_PROG_RATE then
      config.ip_rate_cnt:=(config.ip_rate_cnt/C_MIN_RATE)*C_MIN_RATE;
    end if;
    
    config.comb:=get_int_comb_section_config(
                              C_COMB,
                              C_NUM_STAGES,
                              C_DIFF_DELAY,
                              C_NUM_CHANNELS,
                              config.ip_rate_cnt,
                              C_COMB_WIDTHS,
                              family_info_qual,
                              C_USE_DSP);
                              
    config.px_cnt:=config.comb.stages(0);
    
    config.integrator:=get_int_comb_section_config(
                              C_INTEGRATOR,
                              C_NUM_STAGES,
                              C_DIFF_DELAY,
                              C_NUM_CHANNELS,
                              config.ip_rate_cnt/C_MIN_RATE,
                              C_INT_WIDTHS,
                              family_info_qual,
                              C_USE_DSP);
    
    config.chan_buffer:=(
            family              => family_info_qual,
            implementation      => 1,
            mem_type            => c_dram,--force DRAM just now                                   
            write_mode          => 0,--read first
            has_ce              => 1,--obsolete
            use_mif             => 0,
            resource_opt        => c_area,
            is_rom              => false);
    
    config.chan_buffer_addr:=(
            family => family_info_qual,
            implementation => 1,
            addr_width => get_max(1,log2roundup(2*C_NUM_CHANNELS)),
            page_size => C_NUM_CHANNELS,
            num_enables => 2 );
    
    -- Calc latency
    config.latency:=config.comb.din_delay;
    
    config.latency:=config.latency+select_integer(0,1,C_USE_STREAMING_INTERFACE=0 and C_NUM_CHANNELS>1);
    
    config.latency:=config.latency+config.comb.latency;
    
    if C_NUM_CHANNELS>1 then
      config.latency:=config.latency+4-config.integrator.din_delay;
    else
      config.latency:=config.latency+1;
    end if;
    
    config.latency:=config.latency+config.integrator.latency+config.integrator.din_delay;
    
    --Rabassa compatibility
    last_stage_width:=C_INT_WIDTHS(C_NUM_STAGES-1);
    
    if C_OUTPUT_WIDTH < last_stage_width and C_RATE_TYPE=C_PROG_RATE then
      --output scaling when prog rate
      config.latency:=config.latency+2;--fixed lat, should use function ****
    end if;
    
    config.latency:=config.latency+1;--output reg
    
    return config;
  end get_interpolate_config;

  function get_decimate_config(
                            C_NUM_STAGES : integer;
                            C_DIFF_DELAY : integer;
                            C_RATE : integer;
                            C_INPUT_WIDTH : integer;
                            C_OUTPUT_WIDTH : integer;
                            C_USE_DSP : integer;
                            C_HAS_ROUNDING : integer;
                            C_NUM_CHANNELS  : integer;
                            C_RATE_TYPE : integer;
                            C_MIN_RATE : integer;
                            C_MAX_RATE : integer;
                            C_SAMPLE_FREQ : integer;
                            C_CLK_FREQ : integer;
                            C_USE_STREAMING_INTERFACE : integer;
                            C_XDEVICEFAMILY : string ;
                            C_COMB_WIDTHS : t_int_array(C_MAX_STAGES-1 downto 0);
                            C_INT_WIDTHS : t_int_array(C_MAX_STAGES-1 downto 0)) return t_decimate_config is
    variable config: t_decimate_config;
    constant family_info: t_family := family_val(C_XDEVICEFAMILY);
    variable family_info_qual: t_family;
    
    constant Bmax : integer := CICBMAX(C_INPUT_WIDTH, C_MAX_RATE, C_NUM_STAGES, C_DIFF_DELAY);
    constant DYN_SCALE_BITS : integer := Bmax - CICBMAX(C_INPUT_WIDTH,C_MIN_RATE,C_NUM_STAGES,C_DIFF_DELAY);
  
  begin
    family_info_qual:=family_info;
    if C_USE_DSP=0 then
      family_info_qual.emb_calc_prim   :=p_mult18s; --this will be usused and not generated given opcodes
      family_info_qual.treat_as_s3adsp  :=true;
      family_info_qual.has_fabric_dsp48:=true; --ensures fabric adder
    end if;
    config.family:=family_info_qual;
    
    config.ip_rate_cnt:=(C_CLK_FREQ/C_SAMPLE_FREQ)/C_NUM_CHANNELS;
    
    config.integrator:=get_int_comb_section_config(
                              C_INTEGRATOR,
                              C_NUM_STAGES,
                              C_DIFF_DELAY,
                              C_NUM_CHANNELS,
                              config.ip_rate_cnt,
                              C_INT_WIDTHS,
                              family_info_qual,
                              C_USE_DSP);
    
    config.px_cnt:=config.integrator.stages(0);
    
    config.comb:=get_int_comb_section_config(
                              C_COMB,
                              C_NUM_STAGES,
                              C_DIFF_DELAY,
                              C_NUM_CHANNELS,
                              config.ip_rate_cnt*C_MIN_RATE,
                              C_COMB_WIDTHS,
                              family_info_qual,
                              C_USE_DSP);
                              
    config.chan_buffer:=(
            family              => family_info_qual,
            implementation      => 1,
            mem_type            => c_dram,--force DRAM just now                                   
            write_mode          => 0,--read first
            has_ce              => 1,--obsolete
            use_mif             => 0,
            resource_opt        => c_area,
            is_rom              => false);
    
    config.chan_buffer_addr:=(
            family => family_info_qual,
            implementation => 1,
            addr_width => get_max(1,log2roundup(2*C_NUM_CHANNELS)),
            page_size => C_NUM_CHANNELS,
            num_enables => 2 );
    
    -- Calc latency
    config.latency:=config.integrator.din_delay;
    
    if not(C_RATE_TYPE=C_FIXED_RATE or DYN_SCALE_BITS = 0 or C_OUTPUT_WIDTH >= Bmax) then
      config.latency:=config.latency+2-config.integrator.din_delay;--fixed lat should use function***
    end if;
    
    config.latency:=config.latency+config.integrator.latency;
    
    if C_NUM_CHANNELS>1 then
      config.latency:=config.latency+4-config.integrator.din_delay;--3;
    else
      config.latency:=config.latency+2;
    end if;
    
    config.latency:=config.latency+config.comb.latency+config.comb.din_delay;
    
    if C_USE_STREAMING_INTERFACE=0 and C_NUM_CHANNELS>1 then
      --output buffer
      config.latency:=config.latency+(C_NUM_CHANNELS-1)*config.comb.stages(0)
                                    +2;
    end if;
    
    config.latency:=config.latency+1;--output reg
    
    return config;
    
  end get_decimate_config;


end cic_compiler_v1_3_pkg;

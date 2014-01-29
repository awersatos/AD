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

library ieee;
use ieee.std_logic_1164.all;
USE ieee.math_real.ALL;

package cic_compiler_v1_2_pkg is
	
  -- GLOBAL CONSTANTS --
  ----------------------
 
  -- Constants that define the amount of fabric add that is allowed before another DSP block is used to implement an add or accum.
  -- For example, in V4 a 36 bit add can be done in one DSP.  36 bits + V4_FABRIC_DELTA bits will use fabric and 1 DSP.  Greater than that will use 2 DSPs.
  constant V4_FABRIC_DELTA : integer := 12;	
  constant V5_FABRIC_DELTA : integer := 12;	
  constant S3A_FABRIC_DELTA : integer := 12;	

  ----------------------
  type stage_array is array(0 to 5) of integer;
  type LOG2_LUT_ARRAY is array (natural range <>) of integer;

  function number_of_digits(data_value : integer; radix : integer) return integer;
  function two_comp(vect : std_logic_vector) return std_logic_vector;
  function int_to_slv(value, bitwidth : integer) return std_logic_vector;
  function get_max (a : integer; b : integer) return integer;
  function CICBMAX (INPUT_WIDTH : integer; RATE : integer; NUM_STAGES : integer; DIFF_DELAY : integer) return integer;
  function CHOOSE(n,k:integer) return integer;
  function VARERRGAIN(stage,RATE,NUM_STAGES,DIFF_DELAY : integer) return real;
  function BITSTOTRIM(stage,STAGE_TYPE,INPUT_WIDTH,OUTPUT_WIDTH,RATE,NUM_STAGES,DIFF_DELAY : integer) return integer;
  function MAX (LEFT, RIGHT: INTEGER) return INTEGER;
  function MIN (LEFT, RIGHT: INTEGER) return INTEGER;
  function INTERPSTAGEBITS (stage,STAGE_TYPE,INPUT_WIDTH,RATE,NUM_STAGES,DIFF_DELAY : integer) return integer;
  function INT_FOLDING_FACTOR (OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, FILTER_TYPE : integer) return integer;
  function COMB_FOLDING_FACTOR (OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, FILTER_TYPE, USE_DSP, PROCESSING_LATENCY : integer) return integer;
  function INTEGRATOR_STAGE_LATENCY (STAGE_NUM, RATE, NUM_CHANNELS, WIDTH, PIPE_SUBWORD_WIDTH, USE_DSP : integer; FAMILY : string) return integer;
  function INT_SECTION_LATENCY (OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, FILTER_TYPE, FOLDING_FACTOR, PIPE_SUBWORD_WIDTH, USE_DSP : integer; WIDTHS : stage_array; FAMILY : string) return integer;
  function COMB_STAGE_LATENCY (STAGE_NUM, RATE, NUM_CHANNELS, WIDTH, PIPE_SUBWORD_WIDTH, USE_DSP  : integer; FAMILY : string) return integer;
  function COMB_STAGE_PROCESSING_LATENCY (WIDTH, PIPE_SUBWORD_WIDTH, USE_DSP  : integer; FAMILY : string) return integer;
  --W function COMB_STAGE_PROCESSING_LATENCY (STAGE_NUM, RATE, NUM_CHANNELS, WIDTH, PIPE_SUBWORD_WIDTH, USE_DSP  : integer; FAMILY : string) return integer;
  function COMB_SECTION_LATENCY (OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, FILTER_TYPE, FOLDING_FACTOR, PIPE_SUBWORD_WIDTH, USE_DSP : integer; WIDTHS : stage_array; FAMILY : string) return integer;
  --W function COMB_SECTION_PROCESSING_LATENCY (OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, FILTER_TYPE, FOLDING_FACTOR, PIPE_SUBWORD_WIDTH, USE_DSP : integer; WIDTHS : stage_array; FAMILY : string) return integer;
  function COMB_SECTION_PROCESSING_LATENCY (NUM_STAGES, PIPE_SUBWORD_WIDTH, USE_DSP : integer; WIDTHS : stage_array; FAMILY : string) return integer;

  function DEC_SCALING_DELAY_CALC (RATE_TYPE, SCALE_BITS, BMAX, OUTPUT_WIDTH : integer) return integer;

  function DEC_LATENCY (C_LATENCY : string; RATE, MIN_RATE, NUM_STAGES, NUM_CHANNELS, OVERCLOCK, PIPE_SUBWORD_WIDTH, USE_DSP, INPUT_WIDTH, DIFF_DELAY, RATE_TYPE, OUTPUT_WIDTH : integer; WIDTHS_c, WIDTHS_i : stage_array; FAMILY : string) return integer; 

  function SCALING_DELAY_CALC (RATE_TYPE, INT_BMAX, OUTPUT_WIDTH : integer) return integer;

  function INT_LATENCY (C_LATENCY : string; RATE, MIN_RATE, RATE_TYPE, NUM_STAGES, NUM_CHANNELS, OVERCLOCK, PIPE_SUBWORD_WIDTH,USE_DSP, OUTPUT_WIDTH : integer; WIDTHS_c, WIDTHS_i : stage_array; FAMILY : string) return integer;

  function INT_UPSAMPLE_MUX_DEL (USE_DSP, COMB_FOLDING, NUM_CHANNELS : integer) return integer;
  function INT_INTEGRATOR_ENABLE_DEL (USE_DSP, COMB_FOLDING, NUM_CHANNELS : integer) return integer;

  function W_comb(num_stages, rate, diff_delay, input_width, folding : integer) return stage_array;
  function W_integrator(num_stages, rate, diff_delay, input_width, folding : integer) return stage_array;
  function B_integrator(num_stages, min_rate, max_rate, diff_delay, input_width, output_width, folding : integer) return stage_array;
  function B_comb(num_stages, min_rate, max_rate, diff_delay, input_width, output_width, folding, rounding : integer) return stage_array;
  function calc_dsp_widths(WIDTH : stage_array; C_FAMILY : string; FILTER_TYPE, NUM_CHANNELS, max_width : integer) return stage_array;
 function calc_dsp_widths_integrator(WIDTH : stage_array; C_FAMILY : string; FILTER_TYPE, NUM_CHANNELS, max_width : integer) return stage_array;
  function dsp_or_fabric_max (dsp : integer; fabric : integer; use_dsp : integer) return integer;

  function CALC_OVERCLOCK (CLK_FREQ, SAMPLE_FREQ : integer) return integer;

  function CN1L2R_LUT (MIN_RATE,MAX_RATE,STAGES : integer) return LOG2_LUT_ARRAY;

  function DEC_SCALE_LUT_CALC (MIN_RATE,MAX_RATE,STAGES : integer) return LOG2_LUT_ARRAY;

end cic_compiler_v1_2_pkg;

package body cic_compiler_v1_2_pkg is

  -- purpose: calculates the number of bits needed to represent the specified data_value
  -- based on the supplied radix
  function number_of_digits (data_value : integer; radix : integer) return integer is
    variable dwidth : integer := 0;
  begin
    while radix**dwidth-1 < data_value and data_value > 0 loop
      dwidth := dwidth + 1;
    end loop;
    return dwidth;
  end number_of_digits;

  -- purpose: returns two's complement of the input slv
  function two_comp(vect : std_logic_vector) return std_logic_vector is
    variable local_vect : std_logic_vector(vect'high downto 0);
    variable toggle : integer := 0;
  begin
    for i in 0 to vect'high loop
      if (toggle = 1) then
        if (vect(i) = '0') then
          local_vect(i) := '1';
        else
          local_vect(i) := '0';
        end if;
      else
        local_vect(i) := vect(i);
        if (vect(i) = '1') then
          toggle := 1;
        end if;
      end if;
    end loop;
    return local_vect;
  end two_comp;

  -- purpose: converts an integer value to a std_logic_vector
  function int_to_slv(value, bitwidth : integer) return std_logic_vector is
    variable running_value : integer := value;
    variable running_result : std_logic_vector(bitwidth-1 downto 0);
  begin
    
    if (value < 0) then
      running_value := -1 * value;
    end if;
    for i in 0 to bitwidth-1 loop
      if running_value mod 2 = 0 then
        running_result(i) := '0';
      else
        running_result(i) := '1';
      end if;
      running_value := running_value/2;
    end loop;
    if (value < 0) then                 -- find the 2s complement
      return two_comp(running_result);
    else
      return running_result;
    end if;
  end int_to_slv;
  
  -- purpose: Returns the max(a,b)                           
  FUNCTION get_max (a : INTEGER; b : INTEGER) RETURN INTEGER IS
    variable biggest : integer := 1;
  begin
    if (a > b) then
      biggest := a;
    else
      biggest := b;
    end if;
    return biggest;
  end get_max;

  function dsp_or_fabric_max (dsp : integer; fabric : integer; use_dsp : integer) return integer IS
  begin
    if (use_dsp > 0) then
      return dsp;
    else
      return fabric;
    end if;
  end dsp_or_fabric_max;

  --
  function calc_dsp_widths(WIDTH : stage_array; C_FAMILY : string; FILTER_TYPE, NUM_CHANNELS, max_width : integer) return stage_array is
    variable dsp_max_addwidth : integer := 1;
    variable new_width : stage_array := (0, 0, 0, 0, 0, 0);
  begin
    if (C_FAMILY = "virtex4") then
      dsp_max_addwidth := 36;
    elsif (C_FAMILY = "virtex5") then
      dsp_max_addwidth := 43;
    else
      dsp_max_addwidth := 36;
    end if;
      for jj in 0 to 5 loop
        if ((FILTER_TYPE=1) AND (NUM_CHANNELS=1) AND (max_width <= dsp_max_addwidth)) then
 	  new_width(jj) := max_width;
        else
	  new_width(jj) := WIDTH(jj);
        end if;
      end loop;
    return new_width;
  end calc_dsp_widths;

 -- purpose: To calculate what the bitwidths of the stages should be when DSP48s are used.
  --
  function calc_dsp_widths_integrator(WIDTH : stage_array; C_FAMILY : string; FILTER_TYPE, NUM_CHANNELS, max_width : integer) return stage_array is
    variable dsp_max_accumwidth : integer := 1;
    variable new_width : stage_array := (0, 0, 0, 0, 0, 0);
  begin
    if (C_FAMILY = "virtex4") then
      dsp_max_accumwidth := 48;
      
    elsif (C_FAMILY = "virtex5") then
      dsp_max_accumwidth := 48;
      
    else
      dsp_max_accumwidth := 48;
      
    end if;
      for jj in 0 to 5 loop
        if ((FILTER_TYPE=1) AND (NUM_CHANNELS=1) AND (max_width <= dsp_max_accumwidth)) then
 	  new_width(jj) := max_width;
        else
	  new_width(jj) := WIDTH(jj);
        end if;
      end loop;
    return new_width;
  end calc_dsp_widths_integrator;

  -- function to compute the maximum bit-width based on input bit-width, rate, stages, 
  -- and diff delay; based on Hogenauer paper equation (11) without '-1' to yield width instead of MSB number
  function CICBMAX (INPUT_WIDTH : integer; RATE : integer; NUM_STAGES : integer; DIFF_DELAY : integer) RETURN integer is
	  variable max_bit_width : integer := 1;
  begin
	  max_bit_width := integer(ceil(real(NUM_STAGES) * LOG2(real(RATE*DIFF_DELAY)) + real(INPUT_WIDTH)));
	  return(max_bit_width);
  end function CICBMAX;

  -- 'choose' function for bit trimming computations
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


  -- variance calculation for bit trimming
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


  -- calculation of number of bits to trim
  -- stage is stage number within integrators or comb sections; STAGE_TYPE indicates integrator (0) or comb (1)
  -- this is used to facilitate the definition of constants for bit trimming
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

  -- function to return max of two integers
  function MAX (LEFT, RIGHT: INTEGER) return INTEGER is
  begin
    if LEFT > RIGHT then return LEFT;
    else return RIGHT;
    end if;
  end MAX;

  -- function to return min of two integers
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

  -- calculate the maximum register growth for the comb section of an interpolation filter
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


  -- calculate the maximum register growth for the integrator section of an interpolation filter
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
  
  -- calculate stage register sizing for decimator filter integrator stages
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

  -- calculate stage register sizing for decimator filter comb stages
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


  -- function to compute the folding factor of the integrator section
  function INT_FOLDING_FACTOR (OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, FILTER_TYPE : integer) return integer is
	  variable folding_factor : integer;
  begin
	  if FILTER_TYPE = 0 then
		  -- interpolation filter
		  --folding_factor := 0; -- NO FOLDING FOR NOW
		  if OVERCLOCK >= NUM_STAGES then
			  --folding_factor := NUM_STAGES; -- FULLY FOLDED FOR NOW...
			  folding_factor := 0; -- NO FOLDING FOR NOW
		  else
			  folding_factor := 0; -- NO FOLDING FOR NOW
		  end if;
	  else
		  -- decimation filter
		  if OVERCLOCK >= NUM_STAGES then
			  folding_factor := NUM_STAGES; -- FULLY FOLDED FOR NOW...
		  else
			  folding_factor := 0; -- NO FOLDING FOR NOW
		  end if;
	  end if;

	  folding_factor := 0; -- NO FOLDING TO TEST WITH DSP MAPPING

 	  return folding_factor;
  end INT_FOLDING_FACTOR;


  -- function to compute the folding factor of the comb section
  function COMB_FOLDING_FACTOR (OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, FILTER_TYPE, USE_DSP, PROCESSING_LATENCY: integer) return integer is
	  variable folding_factor : integer;
  begin
	  if FILTER_TYPE = 0 then
		  -- interpolation filter
		  --if ((RATE >= NUM_STAGES) and (USE_DSP = 0)) then
		  --	  folding_factor := NUM_STAGES; -- fully folded, fabric-based only
		  if (OVERCLOCK*RATE >= NUM_STAGES+PROCESSING_LATENCY) then
			  folding_factor := NUM_STAGES; -- EXP with DSP FOLDED COMB
		  else
			  folding_factor := 0;
		  end if;
	  else
		  -- decimation filter
		  --if ((RATE >= NUM_STAGES) and (USE_DSP = 0)) then
		  --	  folding_factor := NUM_STAGES; -- fully folded, fabric-based only
		  if (OVERCLOCK*RATE >= NUM_STAGES+PROCESSING_LATENCY) then
			  folding_factor := NUM_STAGES;
		  else
			  folding_factor := 0;
		  end if;
	  end if;
--ww	  folding_factor := 0; -- no folding for testing purposes

 	  return folding_factor;
  end COMB_FOLDING_FACTOR;


  function INTEGRATOR_STAGE_LATENCY (STAGE_NUM, RATE, NUM_CHANNELS, WIDTH, PIPE_SUBWORD_WIDTH, USE_DSP : integer; FAMILY : STRING) return integer is
	  variable carry_chain_breaking_latency : integer := 0;  -- will pass this in as parameter for latency changes comb-stage due carry-chain breakin, multiple DSPs
	  variable latency : integer := 0;
	  variable add_lat : integer ;
	  variable fabric_acc_width : integer ;
  begin
	  -- the values are the same for now, but they will be changing in the future for input reg on dsp, multiple dsps, carry-chane breaking, etc
	  if(USE_DSP = 0) then
		  if (PIPE_SUBWORD_WIDTH > 0) then
			  if ( WIDTH mod PIPE_SUBWORD_WIDTH = 0) then
				  carry_chain_breaking_latency := WIDTH/PIPE_SUBWORD_WIDTH;
			  else
				  carry_chain_breaking_latency := WIDTH/PIPE_SUBWORD_WIDTH + 1;
			  end if;
		  end if;
		  latency := (NUM_CHANNELS+carry_chain_breaking_latency);
	  else
		  if (NUM_CHANNELS = 1) then
			if (FAMILY = "virtex4") then
				if (WIDTH <= 48) then
					latency := 2; --latency+1;
				elsif (WIDTH > 48) then
					latency := 3; --latency+1;
					fabric_acc_width := WIDTH-48;
				        if(fabric_acc_width MOD V4_FABRIC_DELTA = 0) then
						add_lat := fabric_acc_width/V4_FABRIC_DELTA;
					else
						add_lat := fabric_acc_width/V4_FABRIC_DELTA + 1;
					end if;
					latency := latency+add_lat;
				end if;
			elsif (FAMILY = "virtex5") then
				if (WIDTH <= 48) then
					latency := 2; --latency+1;
     				elsif (WIDTH > 48) and (WIDTH <= 48+V5_FABRIC_DELTA) then
					latency := 4;
				elsif (WIDTH > 48+V5_FABRIC_DELTA) and (WIDTH <= 96) then
					latency := 3;
				elsif (WIDTH > 96) and (WIDTH <= 96+V5_FABRIC_DELTA) then
					latency := 5;
				end if;
			elsif (FAMILY = "spartan3adsp") then
				if (WIDTH <= 48) then
					latency := 2; --latency+1;
     				elsif (WIDTH > 48) and (WIDTH <= 48+S3A_FABRIC_DELTA) then
					latency := 4;
				elsif (WIDTH > 48+S3A_FABRIC_DELTA) and (WIDTH <= 96) then
					latency := 3;
				elsif (WIDTH > 96) and (WIDTH <= 96+S3A_FABRIC_DELTA) then
					latency := 5;
				end if;

			end if;
		  else
			if (FAMILY = "virtex4") then
				latency := 0;
				if (WIDTH <= 36) then
					carry_chain_breaking_latency := 0;
				elsif ((WIDTH > 36) and (WIDTH <= 36+V4_FABRIC_DELTA)) then
					carry_chain_breaking_latency := 2;
				elsif ((WIDTH > 36+V4_FABRIC_DELTA) and (WIDTH <= 71)) then
					carry_chain_breaking_latency := 2;
				elsif ((WIDTH > 71) and (WIDTH <= 71+V4_FABRIC_DELTA)) then
					carry_chain_breaking_latency := 4;
				elsif ((WIDTH > 71+V4_FABRIC_DELTA) and (WIDTH <= 106)) then
					carry_chain_breaking_latency := 4;
				end if;


			elsif (FAMILY="virtex5") then
				latency := 0;
				if (WIDTH <= 48) then
			        	carry_chain_breaking_latency := 0;
			 	elsif (WIDTH > 48) and (WIDTH <= 48+V5_FABRIC_DELTA) then
			 		carry_chain_breaking_latency := 2;
				elsif (WIDTH > 48+V5_FABRIC_DELTA) and (WIDTH <= 96) then
					carry_chain_breaking_latency := 1;
				elsif (WIDTH > 96) and (WIDTH <= 96+V5_FABRIC_DELTA) then
					carry_chain_breaking_latency := 3;
				end if;

			elsif (FAMILY="spartan3adsp") then
				latency := 0;
				if (WIDTH <= 48) then
			        	carry_chain_breaking_latency := 0;
			 	elsif (WIDTH > 48) and (WIDTH <= 48+S3A_FABRIC_DELTA) then
			 		carry_chain_breaking_latency := 2;
				elsif (WIDTH > 48+S3A_FABRIC_DELTA) and (WIDTH <= 96) then
					carry_chain_breaking_latency := 1;
				elsif (WIDTH > 96) and (WIDTH <= 96+S3A_FABRIC_DELTA) then
					carry_chain_breaking_latency := 3;
				end if;			
			else
			end if;

		  latency := latency + NUM_CHANNELS + carry_chain_breaking_latency;

		  end if;

--		  latency := NUM_CHANNELS+carry_chain_breaking_latency;
		  if ((STAGE_NUM = 1) and (NUM_CHANNELS = 1)) then
			  latency := latency; --W + 1;
		  end if;
            
	  end if;
	  return latency;
  end INTEGRATOR_STAGE_LATENCY;

  -- function to compute latency of the integrator section
  function INT_SECTION_LATENCY (OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, FILTER_TYPE, FOLDING_FACTOR, PIPE_SUBWORD_WIDTH, USE_DSP : integer; WIDTHS : stage_array; FAMILY : string) return integer is
	  variable integrator_latency : integer;
  begin

	  integrator_latency := 0;
	  for j in 1 to (num_stages) loop
	 	integrator_latency := integrator_latency + INTEGRATOR_STAGE_LATENCY(j,RATE,NUM_CHANNELS,WIDTHS(j-1),PIPE_SUBWORD_WIDTH,USE_DSP,FAMILY);
	  end loop;

	  if FILTER_TYPE = 0 then
		  -- interpolation filter
		  integrator_latency := integrator_latency;
		  if USE_DSP = 0 then
			  integrator_latency := integrator_latency;
		  else
			  integrator_latency := integrator_latency; --wlm+2;
		  end if;
	  else
		  -- decimation filter
		  if USE_DSP = 0 then
			if NUM_CHANNELS = 1 then
				integrator_latency := integrator_latency;
		  	else
			--wlm	integrator_latency := integrator_latency - NUM_CHANNELS + 1;
				integrator_latency := integrator_latency ;--WLM WLM + 1;
		  	end if;
		  else
			integrator_latency := integrator_latency;
		  end if;

	  end if;

 	  return integrator_latency;
  end INT_SECTION_LATENCY;

  -- Latency that is due to the CIC functionality.  THis is the latency of at the "lower" sampling rate
  function COMB_STAGE_LATENCY (STAGE_NUM, RATE, NUM_CHANNELS, WIDTH, PIPE_SUBWORD_WIDTH, USE_DSP  : integer; FAMILY : string) return integer is
  begin
	  return NUM_CHANNELS;
  end COMB_STAGE_LATENCY;

  -- function to compute processing latency of single comb stage; this is the latency due to implementation of the subtraction. This is latency at the Clock Rate.
  --WLM function COMB_STAGE_PROCESSING_LATENCY (STAGE_NUM, RATE, NUM_CHANNELS, WIDTH, PIPE_SUBWORD_WIDTH, USE_DSP  : integer; FAMILY : string) return integer is
  function COMB_STAGE_PROCESSING_LATENCY (WIDTH, PIPE_SUBWORD_WIDTH, USE_DSP  : integer; FAMILY : string) return integer is
	  variable carry_chain_breaking_latency : integer := 0;  -- will pass this in as parameter for latency changes comb-stage due carry-chain breakin, multiple DSPs
	  variable latency : integer := 0;
  begin
	  if(USE_DSP = 0) then
		  if (PIPE_SUBWORD_WIDTH > 0) then
			  if ( WIDTH mod PIPE_SUBWORD_WIDTH = 0) then
				  carry_chain_breaking_latency := WIDTH/PIPE_SUBWORD_WIDTH + 1;
			  else
				  carry_chain_breaking_latency := WIDTH/PIPE_SUBWORD_WIDTH + 1 + 1;
			  end if;
		  end if;
		  latency := carry_chain_breaking_latency;
	  else
		  if (FAMILY = "virtex4") then
			  if (WIDTH <= 36) then
				  carry_chain_breaking_latency := 0;
			  elsif ((WIDTH > 36) and (WIDTH <= 36+V4_FABRIC_DELTA)) then
				  carry_chain_breaking_latency := 2;
			  elsif ((WIDTH > 36+V4_FABRIC_DELTA) and (WIDTH <= 71)) then
				  carry_chain_breaking_latency := 3;
			  elsif ((WIDTH > 71) and (WIDTH <= 71+V4_FABRIC_DELTA)) then
				  carry_chain_breaking_latency := 4;
			  elsif ((WIDTH > 71+V4_FABRIC_DELTA) and (WIDTH <= 106)) then
				  carry_chain_breaking_latency := 5;
			  end if;
		 
			elsif (FAMILY="virtex5") then   
			  if (WIDTH <= 48) then
				carry_chain_breaking_latency := 0;
			  elsif ((WIDTH > 48) and (WIDTH <= 48+V5_FABRIC_DELTA)) then
				carry_chain_breaking_latency := 2;
			  elsif ((WIDTH > 48+V5_FABRIC_DELTA) and (WIDTH <= 96)) then
				carry_chain_breaking_latency := 2;
			  elsif ((WIDTH > 96) and (WIDTH <= 96+V5_FABRIC_DELTA)) then
				carry_chain_breaking_latency := 3;
			  end if;

			elsif (FAMILY="spartan3adsp") then
			  if (WIDTH <= 48) then
				carry_chain_breaking_latency := 0;
			  elsif ((WIDTH > 48) and (WIDTH <= 48+S3A_FABRIC_DELTA)) then
				carry_chain_breaking_latency := 2;
			  elsif ((WIDTH > 48+S3A_FABRIC_DELTA) and (WIDTH <= 96)) then
				carry_chain_breaking_latency := 2;
			  elsif ((WIDTH > 96) and (WIDTH <= 96+S3A_FABRIC_DELTA)) then
				carry_chain_breaking_latency := 3; 
			  end if;
			end if;
		--	return latency;
		--  end function add_latency_calc;

 -- constant add_dsp_latency : integer := add_latency_calc(WIDTH,FAMILY,AREG);


		  latency := carry_chain_breaking_latency;
	  end if;
	  return latency;
  end COMB_STAGE_PROCESSING_LATENCY;

  -- function to compute latency of the comb section - this latency is at the
  -- "lower" sampling rate of the CIC filter
  function COMB_SECTION_LATENCY (OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, FILTER_TYPE, FOLDING_FACTOR, PIPE_SUBWORD_WIDTH, USE_DSP : integer; WIDTHS : stage_array; FAMILY : string) return integer is
	  variable comb_latency : integer;
  begin
	  comb_latency := 0;
          for j in 1 to (num_stages) loop
	 	comb_latency := comb_latency + COMB_STAGE_LATENCY(j,RATE,NUM_CHANNELS,WIDTHS(j-1),PIPE_SUBWORD_WIDTH,USE_DSP,FAMILY);
 	  end loop;

	  if FILTER_TYPE = 0 then
		  -- interpolation filter
		  if NUM_CHANNELS = 1 then
			  if FOLDING_FACTOR = 0 then
				  comb_latency := comb_latency;
			  else
				  --WLM comb_latency := comb_latency + 1;
				  comb_latency := comb_latency;-- + 1;
			  end if;
		  else
			  comb_latency := comb_latency;
		  end if;
	  else
		  -- decimation filter
		  comb_latency := comb_latency;
	  end if;

 	  return comb_latency;
  end COMB_SECTION_LATENCY;

  -- function to compute processing latency of the comb section - this latency is at the CLOCK Rate
  --WLM function COMB_SECTION_PROCESSING_LATENCY (OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, FILTER_TYPE, FOLDING_FACTOR, PIPE_SUBWORD_WIDTH, USE_DSP : integer; WIDTHS : stage_array; FAMILY : string) return integer is
  function COMB_SECTION_PROCESSING_LATENCY (NUM_STAGES, PIPE_SUBWORD_WIDTH, USE_DSP : integer; WIDTHS : stage_array; FAMILY : string) return integer is
	  variable comb_latency : integer;
  begin
	  comb_latency := 0;
          for j in 1 to (num_stages) loop
	 	comb_latency := comb_latency + COMB_STAGE_PROCESSING_LATENCY(WIDTHS(j-1),PIPE_SUBWORD_WIDTH,USE_DSP,FAMILY);
 	  end loop;
 	  return comb_latency;
  end COMB_SECTION_PROCESSING_LATENCY;

  -- function to determine the delay for the up-sampling MUX control in interpolator filter
  function INT_UPSAMPLE_MUX_DEL (USE_DSP, COMB_FOLDING, NUM_CHANNELS : integer) return integer is
	  variable delay_val : integer := 0;
  begin
	  if USE_DSP = 0 then
		  -- fabric-based implementation
		  if NUM_CHANNELS = 1 then
			  delay_val := 1;
		  else
			  if COMB_FOLDING = 0 then
				  delay_val := 0; 
			  else
				  delay_val := 1;
			  end if;
		  end if;
	  else
		  -- DSP-based implementation
		  if NUM_CHANNELS = 1 then
			  if COMB_FOLDING = 0 then 
				  delay_val := 1;
			  else
				  delay_val := 1;
			  end if;
		  else
			  if COMB_FOLDING = 0 then
				  delay_val := 0;
			  else
				  delay_val := 1;
			  end if;
		  end if;
	  end if;
	  return delay_val;
  end INT_UPSAMPLE_MUX_DEL;


  -- function to determine the delay for control signal that enables integrator section in interpolator filter
  function INT_INTEGRATOR_ENABLE_DEL (USE_DSP, COMB_FOLDING, NUM_CHANNELS : integer) return integer is
	  variable delay_val : integer := 0;
  begin
	  if USE_DSP = 0 then
		  if NUM_CHANNELS = 1 then
		  	delay_val := 2;
	  	  else
		  	if COMB_FOLDING = 0 then
			  	delay_val := 0;
		  	else
			  	delay_val := 1;
		  	end if;
	  	  end if;
	  else
		  if NUM_CHANNELS = 1 then
		  	delay_val := 2;
	  	  else
		  	if COMB_FOLDING = 0 then
			  	delay_val := 0;
		  	else
			  	delay_val := 0;
		  	end if;
	  	  end if;
	  end if;

	  return delay_val;
  end INT_INTEGRATOR_ENABLE_DEL;

  -- function to compute delay due to dynamic scaling in interpolator
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


  -- function to compute latency of interpolator filter
  function INT_LATENCY (C_LATENCY : string; RATE, MIN_RATE, RATE_TYPE, NUM_STAGES, NUM_CHANNELS, OVERCLOCK, PIPE_SUBWORD_WIDTH,USE_DSP, OUTPUT_WIDTH : integer; WIDTHS_c, WIDTHS_i : stage_array; FAMILY : string) return integer is 
	  variable latency, comb_latency, integrator_latency, comb_folding, integrator_folding : integer;
	  variable comb_processing_latency : integer;
	  variable comb_processing_stage_latency : integer;
	  variable max_WIDTH_c : integer;
  begin

	  if C_LATENCY = "zero_latency" then
		  latency := 0;
	  else
		  max_WIDTH_c := max(WIDTHS_c(0),WIDTHS_c(NUM_STAGES-1));
		  comb_processing_stage_latency := COMB_STAGE_PROCESSING_LATENCY(max_WIDTH_c,PIPE_SUBWORD_WIDTH,USE_DSP,FAMILY);
		  comb_folding := COMB_FOLDING_FACTOR(OVERCLOCK, MIN_RATE, NUM_STAGES, NUM_CHANNELS, 0, USE_DSP, comb_processing_stage_latency);
		  comb_latency := COMB_SECTION_LATENCY(OVERCLOCK,RATE,NUM_STAGES,NUM_CHANNELS,0,comb_folding,PIPE_SUBWORD_WIDTH,USE_DSP,WIDTHS_c,FAMILY);
		  comb_processing_latency := COMB_SECTION_PROCESSING_LATENCY(NUM_STAGES,PIPE_SUBWORD_WIDTH,USE_DSP,WIDTHS_c,FAMILY);

		  if OVERCLOCK > 1 then
		  	comb_latency := RATE*(comb_latency)*OVERCLOCK;
		  else
			comb_latency := RATE*(comb_latency);
		  end if;

		  integrator_latency := INT_SECTION_LATENCY(OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, 0, integrator_folding,PIPE_SUBWORD_WIDTH,USE_DSP,WIDTHS_i,FAMILY);

		  if USE_DSP = 0 then
			  if comb_folding = 0 then
				  latency := comb_latency + integrator_latency + comb_processing_latency;
			  else
				  --         comb_latency + integrator_latency + input register on folded comb
				  latency := comb_latency + integrator_latency + 1;
			  end if;
		  else
			  if comb_folding = 0 then
				  --         comb_latency + integrator_latency + comb_processing_latency + input register first DSP unfolded comb + Int_in_reg;
				  latency := comb_latency + integrator_latency + comb_processing_latency +2; 
			  else
				  --         comb_latency + integrator_latency + comb_processing_latency + input register on folded comb + Int_in_reg;
				  latency := comb_latency + integrator_latency + 2; 
			  end if;
		  end if;
		  
		  latency := latency + SCALING_DELAY_CALC(RATE_TYPE, WIDTHS_i(NUM_STAGES-1), OUTPUT_WIDTH); -- EXP adjust for latency in dynamic scaling

		  if NUM_CHANNELS = 1 then
		  else
			  -- WLM NOT SURE ABOUT THIS CODE YET
			  -- adjust for overclocking
		  	  if OVERCLOCK > 1 then
				latency := latency + (RATE*NUM_CHANNELS*OVERCLOCK) - (NUM_STAGES*NUM_CHANNELS) + NUM_STAGES + 1;  
		  	  end if;
		  end if;
	  end if;

	  return latency;

  end INT_LATENCY;

  -- function to compute delay due to dynamic scaling in decimator
  function DEC_SCALING_DELAY_CALC (RATE_TYPE, SCALE_BITS, BMAX, OUTPUT_WIDTH : integer) return integer is
	  variable scaling_latency : integer;
  begin
	  scaling_latency := 0;

	  if (RATE_TYPE = 1) and (SCALE_BITS > 0) and (OUTPUT_WIDTH < BMAX) then
		  scaling_latency := 2;
	  end if;

	  return scaling_latency;

  end DEC_SCALING_DELAY_CALC;

  -- function to compute latency of decimator filter; to be used by behavrioal model to compute the latency to be modeled
  -- for clock accurate verification. Latencies due to overclocking are handled here.
  function DEC_LATENCY (C_LATENCY : string; RATE, MIN_RATE, NUM_STAGES, NUM_CHANNELS, OVERCLOCK, PIPE_SUBWORD_WIDTH, USE_DSP, INPUT_WIDTH, DIFF_DELAY, RATE_TYPE, OUTPUT_WIDTH : integer; WIDTHS_c, WIDTHS_i : stage_array; FAMILY : string) return integer is 
	   variable latency, comb_latency, integrator_latency, comb_folding, integrator_folding : integer;
	   variable comb_processing_latency : integer;
	   variable comb_processing_stage_latency : integer;
	   variable max_WIDTH_c : integer;
	   variable BmaxRmin : integer;
  begin

	  if C_LATENCY = "zero_latency" then
		  latency := 0;
	  else
		  BmaxRmin := CICBMAX(INPUT_WIDTH, MIN_RATE, NUM_STAGES, DIFF_DELAY );
		  max_WIDTH_c := max(WIDTHS_c(0),WIDTHS_c(NUM_STAGES-1));
		  comb_processing_stage_latency := COMB_STAGE_PROCESSING_LATENCY(max_WIDTH_c,PIPE_SUBWORD_WIDTH,USE_DSP,FAMILY);
		  comb_folding := COMB_FOLDING_FACTOR(OVERCLOCK, MIN_RATE, NUM_STAGES, NUM_CHANNELS, 1, USE_DSP, comb_processing_stage_latency);
		  comb_latency := RATE*COMB_SECTION_LATENCY(OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, 1, comb_folding, PIPE_SUBWORD_WIDTH,USE_DSP,WIDTHS_c,FAMILY);
		  comb_processing_latency := COMB_SECTION_PROCESSING_LATENCY(NUM_STAGES,PIPE_SUBWORD_WIDTH,USE_DSP,WIDTHS_c,FAMILY);
		  -- adjust for overclocking
		  if OVERCLOCK > 1 then
			  comb_latency := comb_latency * OVERCLOCK;
		  end if;

		  integrator_folding := INT_FOLDING_FACTOR(OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, 1);
		  --integrator_latency := INT_SECTION_LATENCY (OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, 1, integrator_folding, USE_DSP);
		  integrator_latency := INT_SECTION_LATENCY(OVERCLOCK, RATE, NUM_STAGES, NUM_CHANNELS, 1, integrator_folding, PIPE_SUBWORD_WIDTH, USE_DSP,WIDTHS_i,FAMILY);
		  -- adjust for overclocking
		  if OVERCLOCK > 1 then
			  if integrator_folding = 0 then
				  integrator_latency := integrator_latency + NUM_CHANNELS*(NUM_STAGES-1)*(OVERCLOCK-1);  
			  else
				  integrator_latency := integrator_latency + NUM_CHANNELS*(NUM_STAGES-1)*(OVERCLOCK-1) + (integrator_folding - 1)*NUM_CHANNELS;
			  end if;
		  end if;

		  if USE_DSP = 0 then
		     if comb_folding = 0 then
			  latency := 2 + comb_latency + integrator_latency + comb_processing_latency;
		     else
			  latency := 3 + comb_latency + integrator_latency;
		     end if;
		  else
		     if comb_folding = 0 then
			  latency := 2 + comb_latency + integrator_latency + 1 + comb_processing_latency;
		     else
			  latency := 3 + comb_latency + integrator_latency;
		     end if;
		  end if;

		  latency := latency + DEC_SCALING_DELAY_CALC(RATE_TYPE, WIDTHS_i(0)-BmaxRmin, WIDTHS_i(0), OUTPUT_WIDTH); -- EXP adjust for latency in dynamic scaling

	  end if;

	  return latency;

  end DEC_LATENCY;


  -- function to compute the overclocking factor based on sampling and operating frequencies
  function CALC_OVERCLOCK (CLK_FREQ, SAMPLE_FREQ : integer) return integer is 
	  variable overclock : integer;
  begin
	  --overclock := CLK_FREQ/SAMPLE_FREQ;
	  overclock := 1; -- diable overclocking for now...

	  return overclock;

  end CALC_OVERCLOCK;

  -- function to compute ceil((N-1)log2(R)) table look-up values for dynamic scaling in CIC interpolator
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

  -- function to compute table look-up values for dynamic scaling in CIC decimator
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

end cic_compiler_v1_2_pkg;


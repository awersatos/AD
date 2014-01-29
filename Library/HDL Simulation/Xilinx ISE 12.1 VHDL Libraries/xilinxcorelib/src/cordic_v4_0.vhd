-- $RCSfile $ $Date: 2009/12/04 11:46:47 $ $Revision: 1.4 $
--
-- (c) Copyright 2006 - 2008 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES
--
-------------------------------------------------------------------------------
-- Behavioral Model
-------------------------------------------------------------------------------
  
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xilinxcorelib;
use xilinxcorelib.bip_utils_pkg_v2_0.all;
use xilinxcorelib.cordic_v4_0_pack.all;

--core_if on entity cordic_v4_0
entity cordic_v4_0 is
  generic (
    c_architecture	: integer := 1;--cordic_pack_wser_arch; 
    c_cordic_function : integer := 0;--cordic_pack_f_rotate;
    c_coarse_rotate : integer := 1;
    c_data_format : integer := 0;
    c_family : string  := "virtex4";
    c_xdevicefamily : string := "virtex4";
    c_has_ce : integer := 0;
    c_has_clk : integer := 1;
    c_has_nd : integer := 1;
    c_has_phase_in : integer := 0;
    c_has_phase_out : integer := 0;
    c_has_rdy : integer := 0;
    c_has_rfd : integer := 0;
    c_has_sclr : integer := 0;
    c_has_x_in : integer := 0;
    c_has_x_out : integer := 0;
    c_has_y_in : integer := 0;
    c_has_y_out : integer := 0;
    c_input_width : integer := 32;
    c_iterations : integer := 32;
    c_output_width : integer := 32;
    c_phase_format : integer := 0;--cordic_pack_format_rad;
    c_pipeline_mode : integer := -2;--cordic_pack_pipe_max;
    c_precision : integer := 0;
    c_reg_inputs : integer := 1;
    c_reg_outputs : integer := 1;
    c_round_mode : integer := 2;--cordic_pack_round_pos_neg_inf;
    c_scale_comp : integer := 0--cordic_pack_scale_none
  );
  port (
    X_IN        : in std_logic_vector(c_input_width-1 downto 0) := (others => '0');
    Y_IN        : in std_logic_vector(c_input_width-1 downto 0) := (others => '0');
    PHASE_IN    : in std_logic_vector(c_input_width-1 downto 0) := (others => '0');
    ND          : in std_logic := '0';
    X_OUT       : out std_logic_vector(c_output_width-1 downto 0);
    Y_OUT       : out std_logic_vector(c_output_width-1 downto 0);
    PHASE_OUT   : out std_logic_vector(c_output_width-1 downto 0);
    RDY         : out std_logic;
    RFD         : out std_logic;
    CLK         : in std_logic := '0';
    CE          : in std_logic := '1';
    SCLR        : in std_logic := '0'
  );          
--core_if off
end cordic_v4_0;

architecture behavioral of cordic_v4_0 is

CONSTANT behav_reg_delay : TIME := 100 ps;--2 ns;

  CONSTANT c_iterations_int : INTEGER := CORDIC_PACK_get_iterations_int(
                                              coarse_rotate=> c_coarse_rotate, 
                                              cordic_funct => c_cordic_function, 
                                              iterations   => c_iterations,
                                              output_width => c_output_width, 
                                              round_mode   => c_round_mode);
                                              
  CONSTANT c_precision_int : INTEGER := CORDIC_PACK_get_precision_int(
                                              cordic_funct   => c_cordic_function, 
                                              data_format    => c_data_format, 
                                              input_width    => c_input_width,
                                              iterations_int => c_iterations_int, 
                                              output_width   => c_output_width, 
                                              precision      => c_precision, 
                                              round_mode     => c_round_mode);

  -- CONSTANT c_scale_comp_int : INTEGER := c_scale_comp;--CORDIC_PACK_get_scale_comp_int(c_family, c_scale_comp);
  
  constant c_generics_ok: boolean:=check_generics(
                                      c_architecture   => c_architecture,
                                      c_cordic_function=> c_cordic_function,
                                      c_coarse_rotate  => c_coarse_rotate,
                                      c_data_format    => c_data_format,
                                      c_has_ce         => c_has_ce,
                                      c_has_clk        => c_has_clk,
                                      c_has_nd         => c_has_nd,
                                      c_has_phase_in   => c_has_phase_in,
                                      c_has_phase_out  => c_has_phase_out,
                                      c_has_rdy        => c_has_rdy,
                                      c_has_rfd        => c_has_rfd,
                                      c_has_sclr       => c_has_sclr,
                                      c_has_x_in       => c_has_x_in,
                                      c_has_x_out      => c_has_x_out,
                                      c_has_y_in       => c_has_y_in,
                                      c_has_y_out      => c_has_y_out,
                                      c_input_width    => c_input_width,
                                      c_iterations     => c_iterations,
                                      c_output_width   => c_output_width,
                                      c_phase_format   => c_phase_format,
                                      c_pipeline_mode  => c_pipeline_mode,
                                      c_precision      => c_precision,
                                      c_reg_inputs     => c_reg_inputs,
                                      c_reg_outputs    => c_reg_outputs,
                                      c_round_mode     => c_round_mode,
                                      c_scale_comp     => c_scale_comp);
  
  CONSTANT c_ctrl_width : INTEGER := CORDIC_PACK_gen_ctrl_width(c_coarse_rotate);
  
  CONSTANT c_inv_scale : STD_LOGIC_VECTOR := 
    CORDIC_PACK_inv_cordic_scale_slv(c_cordic_function,c_iterations_int,c_precision_int);
  SIGNAL s_inv_scale : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) :=
    CORDIC_PACK_inv_cordic_scale_slv(c_cordic_function,c_iterations_int,c_precision_int);

  -- Functions for input Configuration Stage.
  FUNCTION f_get_inp_data_latency(architecture_sel:INTEGER; nd_latency:INTEGER) RETURN INTEGER IS
    VARIABLE latency_v : INTEGER;
  BEGIN
    latency_v := nd_latency;
    IF (architecture_sel = CORDIC_PACK_wser_arch) THEN
      latency_v := nd_latency + 2;
    END IF;
    RETURN latency_v;
  END; -- FUNCTION f_get_inp_data_latency;

  CONSTANT c_inp_nd_latency : INTEGER := CORDIC_PACK_get_inp_config_latency(c_architecture, c_coarse_rotate, 
                                           c_cordic_function, c_pipeline_mode, c_reg_inputs);
  CONSTANT c_inp_data_latency : INTEGER := f_get_inp_data_latency(c_architecture, c_inp_nd_latency);

  CONSTANT c_neg_pi_int_const : STD_LOGIC_VECTOR(CORDIC_PACK_max_rom_width-1 DOWNTO 0) :=
             select_slv(CORDIC_PACK_neg_pi_rads_const,CORDIC_PACK_neg_pi_jrads_const, c_phase_format/=0); 
  CONSTANT c_neg_pi_const : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := 
             c_neg_pi_int_const(CORDIC_PACK_max_rom_width-1 DOWNTO CORDIC_PACK_max_rom_width-c_precision_int);
  CONSTANT c_neg_pi_3_4_int_const : STD_LOGIC_VECTOR(CORDIC_PACK_max_rom_width-1 DOWNTO 0) :=
             select_slv(CORDIC_PACK_neg_pi_3_4_rads_const,CORDIC_PACK_neg_pi_3_4_jrads_const, c_phase_format/=0); 
  CONSTANT c_neg_pi_3_4_const : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := 
             c_neg_pi_3_4_int_const(CORDIC_PACK_max_rom_width-1 DOWNTO CORDIC_PACK_max_rom_width-c_precision_int);
  CONSTANT c_neg_pi_2_4_int_const : STD_LOGIC_VECTOR(CORDIC_PACK_max_rom_width-1 DOWNTO 0) :=
             select_slv(CORDIC_PACK_neg_pi_2_4_rads_const,CORDIC_PACK_neg_pi_2_4_jrads_const, c_phase_format/=0); 
  CONSTANT c_neg_pi_2_4_const : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := 
             c_neg_pi_2_4_int_const(CORDIC_PACK_max_rom_width-1 DOWNTO CORDIC_PACK_max_rom_width-c_precision_int);
  CONSTANT c_neg_pi_1_4_int_const : STD_LOGIC_VECTOR(CORDIC_PACK_max_rom_width-1 DOWNTO 0) :=
             select_slv(CORDIC_PACK_neg_pi_1_4_rads_const,CORDIC_PACK_neg_pi_1_4_jrads_const, c_phase_format/=0); 
  CONSTANT c_neg_pi_1_4_const : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := 
             c_neg_pi_1_4_int_const(CORDIC_PACK_max_rom_width-1 DOWNTO CORDIC_PACK_max_rom_width-c_precision_int);

  --Functions, Types and Constants for the Cordic Engine
  SUBTYPE eng_data_type IS STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0);
  TYPE	eng_data_vect IS ARRAY (c_iterations_int DOWNTO 0) of eng_data_type;
  SUBTYPE eng_control_type IS STD_LOGIC_VECTOR(c_ctrl_width-1 DOWNTO 0); 
  TYPE eng_control_vect IS ARRAY (c_iterations_int DOWNTO 0) OF eng_control_type; 
  TYPE eng_add_nsub_vect_type IS ARRAY (c_iterations_int DOWNTO 0) OF STD_LOGIC_VECTOR(2 DOWNTO 0);

  CONSTANT c_eng_mode : STD_LOGIC := CORDIC_PACK_get_eng_mode(c_cordic_function);
  CONSTANT c_transform_type : INTEGER := CORDIC_PACK_get_transform_type(c_cordic_function);
  FUNCTION f_select_rom_source(cordic_function: INTEGER; phase_format : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE atan_rom_source_v : STD_LOGIC_VECTOR(CORDIC_PACK_max_rom_width*CORDIC_PACK_max_rom_length-1 DOWNTO 0);
  BEGIN
    atan_rom_source_v := (OTHERS=>'0');
    IF ( ((cordic_function /= CORDIC_PACK_f_sinh_cosh) AND (cordic_function /= CORDIC_PACK_f_atanh)) AND
         (c_phase_format = CORDIC_PACK_format_rad) ) THEN atan_rom_source_v := CORDIC_PACK_atan_rads; END IF;
    IF ( ((cordic_function /= CORDIC_PACK_f_sinh_cosh) AND (cordic_function /= CORDIC_PACK_f_atanh)) AND
         (c_phase_format = CORDIC_PACK_format_sca) ) THEN atan_rom_source_v := CORDIC_PACK_atan_jrads; END IF;
    IF ( ((cordic_function = CORDIC_PACK_f_sinh_cosh) OR (cordic_function = CORDIC_PACK_f_atanh)) AND
         (c_phase_format = CORDIC_PACK_format_rad) ) THEN atan_rom_source_v := CORDIC_PACK_atanh_rads; END IF;
    IF ( ((cordic_function = CORDIC_PACK_f_sinh_cosh) OR (cordic_function = CORDIC_PACK_f_atanh)) AND
         (c_phase_format = CORDIC_PACK_format_sca) ) THEN atan_rom_source_v := CORDIC_PACK_atanh_jrads; END IF;
    RETURN atan_rom_source_v;
  END; -- FUNCTION f_select_rom_source
  CONSTANT c_atan_rom_source : STD_LOGIC_VECTOR(CORDIC_PACK_max_rom_width*CORDIC_PACK_max_rom_length-1 DOWNTO 0) := 
             f_select_rom_source(c_cordic_function,c_phase_format);

  FUNCTION f_rom_data_int(iterations_int:INTEGER;precision_int:INTEGER) RETURN eng_data_vect IS
    VARIABLE atan_rom_slice_v : STD_LOGIC_VECTOR(CORDIC_PACK_max_rom_width -1 DOWNTO 0);
    VARIABLE rom_data_v : eng_data_vect;
  BEGIN
    FOR I IN 0 TO iterations_int-1 LOOP
      atan_rom_slice_v := c_atan_rom_source((I+1) * CORDIC_PACK_max_rom_width -1 DOWNTO I * CORDIC_PACK_max_rom_width);
      rom_data_v(I) := CORDIC_PACK_rnd_slv(atan_rom_slice_v,atan_rom_slice_v'LENGTH,CORDIC_PACK_round_nearest_even,precision_int);      
    END LOOP;
    RETURN rom_data_v;
  END;
  CONSTANT eng_rom_vect : eng_data_vect := f_rom_data_int(c_iterations_int,c_precision_int);
  
  CONSTANT c_eng_nd_latency   : INTEGER := CORDIC_PACK_get_engine_latency(c_architecture, c_iterations_int, c_pipeline_mode);
  CONSTANT c_eng_data_latency : INTEGER := CORDIC_PACK_get_engine_latency(c_architecture, c_iterations_int, c_pipeline_mode);
  
  --Output Configuration Functions, Constants
  FUNCTION f_get_outp_data_latency(architecture_sel:INTEGER; nd_latency:INTEGER) RETURN INTEGER IS
    VARIABLE latency_v : INTEGER;
  BEGIN
    latency_v := nd_latency;
    IF (architecture_sel = CORDIC_PACK_wser_arch) THEN
      latency_v := nd_latency - 2;
    END IF;
    RETURN latency_v;
  END; -- FUNCTION f_get_outp_data_latency;

  CONSTANT c_outp_nd_latency : INTEGER := CORDIC_PACK_get_out_config_latency(c_xdevicefamily,c_architecture, c_coarse_rotate,
                                            c_cordic_function, c_iterations_int, c_pipeline_mode, c_precision_int, 
                                            c_reg_outputs, c_round_mode, c_scale_comp);

  CONSTANT c_outp_data_latency : INTEGER := f_get_outp_data_latency(c_architecture, c_outp_nd_latency);

  --SQRT FUNCTIONS
  CONSTANT c_rnd_mode_int : INTEGER := CORDIC_PACK_get_rnd_mode_int(c_cordic_function, c_round_mode);

  -- Note this function includes the input register stage unlike struct model.
  FUNCTION get_sqrt_data_latency(data_format:INTEGER;input_width:INTEGER;output_width:INTEGER;pipeline_mode:INTEGER;
             precision:INTEGER;reg_inputs:INTEGER;reg_outputs:INTEGER;round_mode:INTEGER) RETURN INTEGER IS
    VARIABLE latency_sqrt_v : INTEGER; 
    VARIABLE latency_v : INTEGER; 
  BEGIN
    latency_sqrt_v := CORDIC_PACK_get_sqrt_latency(data_format,input_width,output_width,pipeline_mode,precision,
                     reg_inputs,reg_outputs,round_mode) - 1;
    latency_v := get_max(0,latency_sqrt_v);
    RETURN latency_v;
  END;
  CONSTANT c_sqrt_data_latency : INTEGER := get_sqrt_data_latency(c_data_format,c_input_width,c_output_width,
             c_pipeline_mode,c_precision_int,c_reg_inputs,c_reg_outputs,c_round_mode);

  FUNCTION sqrt_slv(data_in : IN STD_LOGIC_VECTOR; precision_int : IN INTEGER; data_format : IN INTEGER)
           RETURN STD_LOGIC_VECTOR IS
    CONSTANT data_width_even : INTEGER := data_in'length + (data_in'length MOD 2);
    VARIABLE data_even : STD_LOGIC_VECTOR(data_width_even-1 DOWNTO 0);
    VARIABLE data_int : STD_LOGIC_VECTOR(2*precision_int-1 DOWNTO 0);
    VARIABLE rem_int : STD_LOGIC_VECTOR(2*precision_int-1 DOWNTO 0);
    VARIABLE rem_next : STD_LOGIC_VECTOR(2*precision_int-1 DOWNTO 0);
    VARIABLE sqre_diff : STD_LOGIC_VECTOR(2*precision_int-1 DOWNTO 0);
    VARIABLE sqrt_int : STD_LOGIC_VECTOR(precision_int-1 DOWNTO 0);    
  BEGIN

    IF (data_format = CORDIC_PACK_format_usig_int) THEN
      FOR I IN 0 TO (2*precision_int-1) LOOP
        IF (I <= (1-(data_in'length MOD 2))) THEN
          data_int(2*precision_int-1 -I) := '0';
        ELSIF (I <= data_in'length+(1-(data_in'length MOD 2))) THEN
          data_int(2*precision_int-1 -I) := data_in(data_in'length-1-I+2-(data_in'length MOD 2));
        ELSE
          data_int(2*precision_int-1 -I) := '0';
        END IF;
      END LOOP;
    END IF;
    
    IF (data_format = CORDIC_PACK_format_usig_frac) THEN
      FOR I IN 0 TO (2*precision_int-1)  LOOP
        IF (I = 0) THEN
          data_int(2*precision_int-1 -I) := '0';
        ELSIF (I <= c_input_width) THEN
          data_int(2*precision_int-1 -I) := data_in(data_in'length-I);
        ELSE
          data_int(2*precision_int-1 -I) := '0';
        END IF;
      END LOOP;
    END IF;    
    
    --init variables    
    sqre_diff := (OTHERS=>'0');
    sqre_diff(1) := '0';
    sqre_diff(0) := '1';
    rem_int := (OTHERS=>'0');
    rem_next := (OTHERS=>'0');
    sqrt_int := (OTHERS=>'0');

    FOR I IN precision_int-1 DOWNTO 0 LOOP
      --left shift the existing remainder internal
      FOR J IN precision_int-2 DOWNTO 0 LOOP
        rem_int(J+2) := rem_int(J);
      END LOOP;
      rem_int(1) := data_int (2*I+1);
      rem_int(0) := data_int (2*I);
      --update the current difference in the Square Difference
      FOR J IN precision_int-3 DOWNTO 0 LOOP
        sqre_diff(J+2) := sqrt_int(J);
      END LOOP;
      rem_next := std_logic_vector(signed(rem_int) - signed(sqre_diff));
      --assign sqrt_int
      FOR J IN precision_int-2 DOWNTO 0 LOOP
        sqrt_int(J+1) := sqrt_int(J);
      END LOOP;
      sqrt_int(0) := '0';

      IF (rem_next(precision_int) = '0') THEN
        rem_int := rem_next;
        sqrt_int(0) := '1';
      END IF;
            
    END LOOP;
    RETURN sqrt_int;

  END; -- FUNCTION;
  
  --Global signals
  SIGNAL ce_int : STD_LOGIC := '1';
  SIGNAL sclr_int : STD_LOGIC := '0';
  SIGNAL nd_int : STD_LOGIC := '1';
  SIGNAL data_x_int : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL data_y_int : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL phase_int : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0)  := (OTHERS => '0');
  SIGNAL data_x_init : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL data_y_init : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL phase_init : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');

  SIGNAL inp_x_min_y : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_x_plus_y : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_data_sign_vect : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

  SIGNAL data_x_init_ext : STD_LOGIC_VECTOR(c_precision_int DOWNTO 0) := (OTHERS => '0');
  SIGNAL data_y_init_ext : STD_LOGIC_VECTOR(c_precision_int DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_x_min_y_ext : STD_LOGIC_VECTOR(c_precision_int DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_x_plus_y_ext : STD_LOGIC_VECTOR(c_precision_int DOWNTO 0) := (OTHERS => '0');

  SIGNAL inp_data_x_cr_async : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_data_y_cr_async : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_phase_cr_async : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_data_quad : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '1');
  SIGNAL inp_phase_sign_vect : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_phase_pi_3_rot : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_phase_pi_1_rot : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_phase_quad : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '1');
  SIGNAL inp_phase_data_quad : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '1');
  SIGNAL inp_ctrl_cr_async : STD_LOGIC_VECTOR(c_ctrl_width-1 DOWNTO 0) := (OTHERS => '0');

  SIGNAL inp_data_x_cr : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_data_y_cr : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_phase_cr  : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_ctrl_cr   : STD_LOGIC_VECTOR(c_ctrl_width-1 DOWNTO 0) := (OTHERS => '0');
 
  SIGNAL inp_data_x_fifo : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_data_y_fifo : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_phase_fifo  : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL inp_ctrl_fifo   : STD_LOGIC_VECTOR(c_ctrl_width-1 DOWNTO 0) := (OTHERS => '0');
    
  SIGNAL data_x_inp : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL data_y_inp : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL phase_inp  : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL ctrl_inp   : STD_LOGIC_VECTOR(c_ctrl_width-1 DOWNTO 0) := (OTHERS => '0');

  --Cordic Engine Signals
  SIGNAL eng_rfd_async : STD_LOGIC := '1';

  SIGNAL eng_data_x_async : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL eng_data_y_async : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL eng_phase_async  : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL eng_ctrl_async   : STD_LOGIC_VECTOR(c_ctrl_width-1 DOWNTO 0) := (OTHERS => '0');

  SIGNAL eng_data_x_fifo : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL eng_data_y_fifo : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL eng_phase_fifo  : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL eng_ctrl_fifo   : STD_LOGIC_VECTOR(c_ctrl_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL eng_rdy : STD_LOGIC := '0';
  SIGNAL eng_nd_reg : STD_LOGIC := '0';
  SIGNAL eng_rfd_reg : STD_LOGIC := '0';

  SIGNAL data_x_eng : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL data_y_eng : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL phase_eng  : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL ctrl_eng   : STD_LOGIC_VECTOR(c_ctrl_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL rfd_eng : STD_LOGIC := '1';

  --Output Config Signals
  SIGNAL outp_data_x_cr : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_data_y_cr : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_phase_cr  : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_cr_quad  : STD_LOGIC_VECTOR(2-1 DOWNTO 0) := (OTHERS => '1');

  SIGNAL outp_data_x_sca : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_data_y_sca : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_phase_sca  : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_data_x_sca_ext : STD_LOGIC_VECTOR(2*c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_data_y_sca_ext : STD_LOGIC_VECTOR(2*c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_phase_sca_ext  : STD_LOGIC_VECTOR(2*c_precision_int-1 DOWNTO 0) := (OTHERS => '0');

  SIGNAL outp_data_x_rnd : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_data_y_rnd : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_phase_rnd  : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_rdy_rnd : STD_LOGIC := '0';

  SIGNAL outp_data_x_fifo : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_data_y_fifo : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_phase_fifo  : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_rdy_fifo : STD_LOGIC := '0';

  SIGNAL outp_data_x_reg : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_data_y_reg : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_phase_reg  : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL outp_rdy_reg :STD_LOGIC := '0';

  SIGNAL outp_ce_and_rdy :STD_LOGIC := '0';
  
  SIGNAL data_x_outp :STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL data_y_outp :STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL phase_outp :STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL rdy_outp : STD_LOGIC := '0';
  SIGNAL rfd_outp : STD_LOGIC := '1';
  
  --SQRT signals
  SIGNAL sqrt_data_trunc_async : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL sqrt_data_trunc_async_ext : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL sqrt_data_round_async : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL sqrt_data_fifo : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL data_x_sqrt : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL sqrt_nd_fifo : STD_LOGIC := '0';
  SIGNAL sqrt_rdy_int : STD_LOGIC := '0';
  SIGNAL sqrt_ce_and_rdy : STD_LOGIC := '0';
  SIGNAL rdy_sqrt : STD_LOGIC := '0';
  SIGNAL sqrt_data_reg : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL sqrt_rdy_reg : STD_LOGIC := '0';
  
BEGIN
    
    -- Connect control signals
    gs2 : IF (c_has_ce = 0) GENERATE
      ce_int <= '1';
    END GENERATE;
    gs3 : IF (c_has_ce = 1) GENERATE
      ce_int <= ce;
    END GENERATE;
  
    gs4 : IF (c_has_nd = 0) GENERATE
      nd_int <= '1';
    END GENERATE;
    gs5 : IF (c_has_nd = 1) GENERATE
      nd_int <= nd;
    END GENERATE;
  
    gs6 : IF (c_has_sclr = 0) GENERATE
      sclr_int <= '0';
    END GENERATE;
    gs7 : IF (c_has_sclr = 1) GENERATE
      sclr_int <= sclr;
    END GENERATE;
    
    --Extend truncate/extend input data as required.
    gs8 : FOR I IN 0 TO c_precision_int-1 GENERATE
      gs9: IF (c_input_width -1 - I >= 0) GENERATE
        data_x_int(c_precision_int - 1 - I) <= x_in(x_in'high - I);
        data_y_int(c_precision_int - 1 - I) <= y_in(y_in'high - I);
        phase_int(c_precision_int - 1 - I) <= phase_in(phase_in'high - I);
      END GENERATE;
      gs10: IF (c_input_width -1 - I < 0) GENERATE
        data_x_int(c_precision_int - 1 - I) <= '0';
        data_y_int(c_precision_int - 1 - I) <= '0';
        phase_int(c_precision_int - 1 - I) <= '0';
      END GENERATE;
    END GENERATE;
  
    --Set up initial conditions for selected functional configuration.
    gs11_rotate : IF (c_cordic_function = CORDIC_PACK_f_rotate) GENERATE
      data_x_init <= data_x_int;
      data_y_init <= data_y_int;
      phase_init <= phase_int;
    END GENERATE;
    gs11_translate : IF (c_cordic_function = CORDIC_PACK_f_translate) GENERATE
      data_x_init <= data_x_int;
      data_y_init <= data_y_int;
      phase_init <= (OTHERS => '0');
    END GENERATE;
    gs11_sin_cos : IF ((c_cordic_function = CORDIC_PACK_f_sin_cos) OR
                       (c_cordic_function = CORDIC_PACK_f_sinh_cosh)) GENERATE
      data_x_init <= c_inv_scale;
      data_y_init <= (OTHERS => '0');
      phase_init <= phase_int;
    END GENERATE;
    gs11_atan : IF ((c_cordic_function = CORDIC_PACK_f_atan) OR
                    (c_cordic_function = CORDIC_PACK_f_atanh)) GENERATE
      data_x_init <= data_x_int;
      data_y_init <= data_y_int;
      phase_init <= (OTHERS => '0');
    END GENERATE;
    gs11_sqrt : IF (c_cordic_function = CORDIC_PACK_f_sqrt) GENERATE
      data_x_init <= data_x_int;
      data_y_init <= (OTHERS => '0');
      phase_init <= (OTHERS => '0');
    END GENERATE;
    
    --Check input values
    -- check_input_range: process(clk,data_x_init,data_y_init,phase_init)
      -- variable phase_in_real,
               -- x_in_real,
               -- y_in_real: real;
    -- begin
      -- if (rising_edge(clk) and ce_int='1' and nd_int='1' and sclr_int='0' and c_has_clk=1) or c_has_clk=0 then
        -- x_in_real := CORDIC_PACK_slv_to_real(data_x_init,data_x_init'LENGTH,1);
        -- y_in_real := CORDIC_PACK_slv_to_real(data_y_init,data_y_init'LENGTH,1);
        -- phase_in_real := CORDIC_PACK_slv_to_real(phase_init,phase_init'LENGTH,2);        
        -- if c_phase_format=CORDIC_PACK_format_sca then
          -- phase_in_real:=phase_in_real*MATH_PI;
        -- end if;
        -- 
        -- --Check phase_in
        -- if c_has_phase_in=1 then
          -- if c_coarse_rotate=0 then
            -- if phase_in_real>MATH_PI_OVER_4 or phase_in_real<-MATH_PI_OVER_4 then
              -- report "WARNING: CORDIC v4.0: PHASE_IN is out of supported range, -pi/4 <= PHASE_IN <= pi/4: "&real'image(phase_in_real)&"(RADS)" severity warning;
            -- end if;
          -- else
            -- if phase_in_real>MATH_PI or phase_in_real<-MATH_PI then
              -- report "WARNING: CORDIC v4.0: PHASE_IN is out of supported range, -pi <= PHASE_IN <= pi: "&real'image(phase_in_real)&"(RADS)" severity warning;
            -- end if;
          -- end if;
        -- end if;
        -- 
        -- if c_has_x_in=1 then
          -- --Check X
          -- if c_cordic_function=CORDIC_PACK_f_atanh then
            -- if x_in_real<0.0 or x_in_real>=2.0 then
              -- report "WARNING: CORDIC v4.0: X_IN is out of supported range, 0 < X_IN < 2: "&real'image(x_in_real);
            -- end if;
          -- elsif c_cordic_function/=CORDIC_PACK_f_sqrt then
            -- if x_in_real<-1.0 or x_in_real>1.0 then
              -- report "WARNING: CORDIC v4.0: X_IN is out of supported range, -1 <= X_IN <= 1: "&real'image(x_in_real);
            -- end if;
          -- end if;
        -- end if;
        -- 
        -- if c_has_y_in=1 then
          -- --Check Y
          -- if c_cordic_function=CORDIC_PACK_f_atanh then
            -- if y_in_real<2.0 or y_in_real>2.0 then
              -- report "WARNING: CORDIC v4.0: Y_IN is out of supported range, -2 <= Y_IN <= 2: "&real'image(y_in_real);
            -- end if;
          -- elsif c_cordic_function/=CORDIC_PACK_f_sqrt then
            -- if y_in_real<-1.0 or y_in_real>1.0 then
              -- report "WARNING: CORDIC v4.0: Y_IN is out of supported range, -1 <= Y_IN <= 1: "&real'image(y_in_real);
            -- end if;
          -- end if;
        -- end if;
        -- 
        -- --Could add further check to ensure the point specified by X and Y is within the support range
        -- 
      -- end if;
    -- end process;
    
    ---------------------------------------------------------------------------------------------
    --Instantiate CORDIC ENGINE
    gicor: IF (c_cordic_function /= CORDIC_PACK_f_sqrt) GENERATE
      ---------------------------------------------------------------------------------------------
      -- Implement Input Configuration Stage

      -- Generate Coarse Rotate
      gcr1: IF (c_coarse_rotate = 1) GENERATE

        data_x_init_ext <= (data_x_init(c_precision_int-1) & data_x_init);
        data_y_init_ext <= (data_y_init(c_precision_int-1) & data_y_init);
        -- Gen control for Data Coarse Rotate
        inp_x_min_y_ext <= std_logic_vector(signed(data_x_init_ext) - signed(data_y_init_ext));
        inp_x_plus_y_ext <= std_logic_vector(signed(data_x_init_ext) + signed(data_y_init_ext));
        inp_data_sign_vect <= (inp_x_min_y_ext(c_precision_int) & inp_x_plus_y_ext(c_precision_int) &
                           data_x_init_ext(c_precision_int) & data_y_init_ext(c_precision_int));
    
        -- Coarse Rotation of Data Vector
        rotate_xy_data : PROCESS(data_x_init,data_y_init,inp_data_sign_vect)
        BEGIN
          CASE inp_data_sign_vect IS
      	    WHEN "0000"|"0001" => 
              inp_data_x_cr_async <= data_x_init;
              inp_data_y_cr_async <= data_y_init;
              inp_data_quad <= "11";
      	    WHEN "1000"|"1010" => 
              inp_data_x_cr_async <= data_y_init;
              inp_data_y_cr_async <= std_logic_vector(signed(not(data_x_init))+1);--std_logic_vector(-1*signed(data_x_init))(c_precision_int-1 downto 0);
              inp_data_quad <= "01";
      	    WHEN "1110"|"1111" => 
              inp_data_x_cr_async <= std_logic_vector(signed(not(data_x_init))+1);--std_logic_vector(-1*signed(data_x_init))(c_precision_int-1 downto 0);
              inp_data_y_cr_async <= std_logic_vector(signed(not(data_y_init))+1);--std_logic_vector(-1*signed(data_y_init))(c_precision_int-1 downto 0);
              inp_data_quad <= "00";
      	    WHEN "0111"|"0101" => 
              inp_data_x_cr_async <= std_logic_vector(signed(not(data_y_init))+1);--std_logic_vector(-1*signed(data_y_init))(c_precision_int-1 downto 0);
              inp_data_y_cr_async <= data_x_init;
              inp_data_quad <= "10";
            WHEN OTHERS =>
              inp_data_x_cr_async <= (OTHERS=> 'X');
              inp_data_y_cr_async <= (OTHERS=> 'X');
              inp_data_quad <= "XX";
          END CASE;
        END PROCESS;
    
        -- Gen Control for Coarse Rotation of Input Phase
        inp_phase_sign_vect(2) <= phase_init(c_precision_int-1);
        inp_phase_sign_vect(1) <= inp_phase_pi_3_rot(c_precision_int -1);
        inp_phase_sign_vect(0) <= inp_phase_pi_1_rot(c_precision_int -1);

        gen_phase_pi_sigs : PROCESS(phase_init, inp_phase_sign_vect(2)) 
        BEGIN
          inp_phase_pi_3_rot <= std_logic_vector(signed(phase_init) - signed(c_neg_pi_3_4_const));
          inp_phase_pi_1_rot <= std_logic_vector(signed(phase_init) - signed(c_neg_pi_1_4_const));
          IF (inp_phase_sign_vect(2) = '0') THEN
            inp_phase_pi_3_rot <= std_logic_vector(signed(phase_init) + signed(c_neg_pi_3_4_const));
            inp_phase_pi_1_rot <= std_logic_vector(signed(phase_init) + signed(c_neg_pi_1_4_const));
          END IF;
        END PROCESS;
    
        -- Coarse Rotation of Input Phase Vector
        rotate_p_data : PROCESS(phase_init,inp_phase_sign_vect)
        BEGIN
          CASE inp_phase_sign_vect IS
      	    WHEN "011" => 
              inp_phase_cr_async <= phase_init;
              inp_phase_quad <= "11";
      	    WHEN "010" => 
              inp_phase_cr_async <= std_logic_vector(signed(phase_init) + signed(c_neg_pi_2_4_const));
              inp_phase_quad <= "01";
      	    WHEN "000" => 
              inp_phase_cr_async <= std_logic_vector(signed(phase_init) + signed(c_neg_pi_const));
              inp_phase_quad <= "00";
      	    WHEN "100" => 
              inp_phase_cr_async <= phase_init;
              inp_phase_quad <= "11";
      	    WHEN "101" => 
              inp_phase_cr_async <= std_logic_vector(signed(phase_init) - signed(c_neg_pi_2_4_const));
              inp_phase_quad <= "10";
      	    WHEN "111" => 
              inp_phase_cr_async <= std_logic_vector(signed(phase_init) - signed(c_neg_pi_const));
              inp_phase_quad <= "00";
            WHEN OTHERS =>
              inp_phase_cr_async <= (OTHERS => 'X');
              inp_phase_quad <= "XX";
          END CASE;
        END PROCESS;
    
        -- Combine Coarse Rotation from Phase and Data Inputs
        inp_phase_data_quad(3) <= inp_phase_quad(1);
        inp_phase_data_quad(2) <= inp_phase_quad(0);
        inp_phase_data_quad(1) <= inp_data_quad(1);
        inp_phase_data_quad(0) <= inp_data_quad(0);

        combine_phase_data_quad : PROCESS(inp_phase_data_quad)
        BEGIN
          CASE inp_phase_data_quad IS
      	    WHEN "0000"|"0110"|"1001"|"1111" => 
              inp_ctrl_cr_async(2) <= '1';
              inp_ctrl_cr_async(1) <= '1';
      	    WHEN "0001"|"0100"|"1011"|"1110" => 
              inp_ctrl_cr_async(2) <= '1';
              inp_ctrl_cr_async(1) <= '0';
      	    WHEN "0011"|"0101"|"1010"|"1100" => 
              inp_ctrl_cr_async(2) <= '0';
              inp_ctrl_cr_async(1) <= '0';
      	    WHEN "0010"|"0111"|"1000"|"1101" => 
              inp_ctrl_cr_async(2) <= '0';
              inp_ctrl_cr_async(1) <= '1';
            WHEN OTHERS =>
              inp_ctrl_cr_async(2) <= 'X';
              inp_ctrl_cr_async(1) <= 'X';
          END CASE;
        END PROCESS;

        inp_ctrl_cr_async(0) <= nd_int;

      END GENERATE; --IF (p_coarse_rotate = 1) GENERATE
        
      --Select between coarse rotate pass through input data.
      inp_data_x_cr <= data_x_init WHEN (c_coarse_rotate = 0) ELSE inp_data_x_cr_async;  
      inp_data_y_cr <= data_y_init WHEN (c_coarse_rotate = 0) ELSE inp_data_y_cr_async;  
      inp_phase_cr  <= phase_init  WHEN (c_coarse_rotate = 0) ELSE inp_phase_cr_async;  
      gen_inp_ctrl_cr : PROCESS(nd_int, inp_ctrl_cr_async)
      BEGIN
  	    IF (c_coarse_rotate = 1) THEN inp_ctrl_cr <= inp_ctrl_cr_async;
        ELSE inp_ctrl_cr <= (OTHERS => '0'); inp_ctrl_cr(0) <= nd_int; END IF;
      END PROCESS;
      
      --Delay for Input Config Stage
      inst_data_delay : PROCESS(inp_data_x_cr,inp_data_y_cr,inp_phase_cr,inp_ctrl_cr,clk)
        CONSTANT c_inp_latency : INTEGER := get_max(c_inp_data_latency,c_inp_nd_latency);
        TYPE inp_data_int_type IS ARRAY(c_inp_latency DOWNTO 0) OF STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0);
        TYPE inp_ctrl_int_type IS ARRAY(c_inp_latency DOWNTO 0) OF STD_LOGIC_VECTOR(c_ctrl_width-1 DOWNTO 0);
        VARIABLE data_x_int_v : inp_data_int_type := (OTHERS => (OTHERS => '0')); 
        VARIABLE data_y_int_v : inp_data_int_type := (OTHERS => (OTHERS => '0')); 
        VARIABLE phase_int_v : inp_data_int_type := (OTHERS => (OTHERS => '0')); 
        VARIABLE ctrl_int_v : inp_ctrl_int_type := (OTHERS => (OTHERS => '0'));
      BEGIN
        data_x_int_v(0) := inp_data_x_cr;
        data_y_int_v(0) := inp_data_y_cr;
        phase_int_v(0)  := inp_phase_cr;
        ctrl_int_v(0)   := inp_ctrl_cr;
        IF (clk'event AND clk = '1') THEN
          IF (ce_int = '1') THEN
            FOR I IN c_inp_latency DOWNTO 1 LOOP
              data_x_int_v(I) := data_x_int_v(I-1);
              data_y_int_v(I) := data_y_int_v(I-1);
              phase_int_v(I)  := phase_int_v(I-1);
              ctrl_int_v(I)   := ctrl_int_v(I-1);
            END LOOP;
          END IF;
          IF ( ((sclr_int = '1')) ) THEN
            FOR I IN c_inp_latency DOWNTO 1 LOOP
              data_x_int_v(I) := (OTHERS => '0');
              data_y_int_v(I) := (OTHERS => '0');
              phase_int_v(I)  := (OTHERS => '0');
              --ctrl_int_v(I)   := (OTHERS => '0');
            END LOOP;
            if c_inp_nd_latency=1 and c_reg_inputs=1 then
              --when the input stage latency is 1 and it is due to the input register the cntrl bus must be handled
              --differently. In the core the equivalent value is derived from the regsitered or not inputs so should not
              --really be delay but in the model the values are derived directly from the un-registered inputs and its
              --value delay to create equivalent delay. This causes problems when reset as in the corethe input values are
              --reset and the cntrl values derivied from those sero values where as here the control value is zero, 
              --this gives the wrong value. So to get round this reset the values to the same value in the core, this is not
              --ideal
              IF (c_ctrl_width > 1) THEN
                ctrl_int_v(1)   := "110";
              else
                ctrl_int_v(1)(0)   := '0';
              end if;
            else
              ctrl_int_v      := (OTHERS =>(OTHERS => '0'));
            end if;
          END IF;      
        END IF;
        inp_data_x_fifo <= data_x_int_v(c_inp_data_latency) AFTER behav_reg_delay;
        inp_data_y_fifo <= data_y_int_v(c_inp_data_latency)AFTER behav_reg_delay;
        inp_phase_fifo <= phase_int_v(c_inp_data_latency)AFTER behav_reg_delay;
        inp_ctrl_fifo(0) <= ctrl_int_v(c_inp_nd_latency)(0)AFTER behav_reg_delay;
        IF (c_ctrl_width > 1) THEN
          inp_ctrl_fifo(c_ctrl_width-1 DOWNTO 1) <= ctrl_int_v(c_inp_data_latency)(c_ctrl_width-1 DOWNTO 1) AFTER behav_reg_delay;
        END IF;
      END PROCESS;--inst_data_delay
    
      --Output from Input Configuaration Stage.
      data_x_inp <= inp_data_x_fifo; 
      data_y_inp <= inp_data_y_fifo; 
      phase_inp  <= inp_phase_fifo;  
      ctrl_inp   <= inp_ctrl_fifo;

      ---------------------------------------------------------------------------------------------
      -- Implement CORDIC engine stage
      gen_eng : PROCESS(data_x_inp,data_y_inp,phase_inp,ctrl_inp,nd_int,eng_rfd_async,eng_rfd_reg,eng_nd_reg,eng_rdy)
        VARIABLE data_x_int_v : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0);
        VARIABLE data_y_int_v : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0);
        VARIABLE phase_int_v : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0);
        VARIABLE ctrl_int_v : STD_LOGIC_VECTOR(c_ctrl_width-1 DOWNTO 0);
        VARIABLE data_x_hw_shift_v : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0);
        VARIABLE data_y_hw_shift_v : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0);
        VARIABLE data_x_add_v : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0);
        VARIABLE data_y_add_v : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0);
        VARIABLE phase_add_v : STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0);
        VARIABLE add_nsub_x_int_v : STD_LOGIC;
        VARIABLE add_nsub_y_int_v : STD_LOGIC;
        VARIABLE add_nsub_p_int_v : STD_LOGIC;
        VARIABLE transform_type_v : STD_LOGIC := CORDIC_PACK_int_to_sl(c_transform_type);
        VARIABLE I_int_v : INTEGER;
      BEGIN
    
        data_x_int_v := data_x_inp;
        data_y_int_v := data_y_inp;
        phase_int_v  := phase_inp;
        ctrl_int_v   := ctrl_inp;

        add_nsub_x_int_v := 
          ( ( ( ( (c_eng_mode) AND (data_y_int_v(c_precision_int-1)) ) OR
                ( (NOT c_eng_mode) AND (NOT phase_int_v(c_precision_int-1)) )
              ) AND transform_type_v ) OR
            ( ( ( (c_eng_mode) AND (NOT data_y_int_v(c_precision_int-1)) ) OR
                ( (NOT c_eng_mode) AND (phase_int_v(c_precision_int-1)) )   
              ) AND (NOT transform_type_v) )
          );
        add_nsub_y_int_v := 
            ( ( (c_eng_mode) AND (data_y_int_v(c_precision_int-1)) ) OR
              ( (NOT c_eng_mode) AND (NOT phase_int_v(c_precision_int-1)) )
            );
        add_nsub_p_int_v := 
            ( ( (c_eng_mode) AND (NOT data_y_int_v(c_precision_int-1)) ) OR
              ( (NOT c_eng_mode) AND (phase_int_v(c_precision_int-1)) )   
            );

        ctrl_int_v(0) := ctrl_inp(0) AND eng_rfd_async;
        IF (c_reg_inputs = 1) THEN ctrl_int_v(0) := ctrl_inp(0) AND eng_rfd_reg; END IF;
        eng_rfd_async <= '1';
        IF (c_architecture = CORDIC_PACK_wser_arch) THEN
          eng_rfd_async <= (eng_rfd_reg AND NOT(eng_nd_reg)) OR eng_rdy;
        END IF;
                        
        FOR I IN 0 TO c_iterations_int-1 LOOP
          I_int_v := CORDIC_PACK_get_current_iteration(I,c_transform_type);
          data_x_hw_shift_v := CORDIC_PACK_rshift_slv(data_x_int_v,I_int_v+1);
          data_y_hw_shift_v := CORDIC_PACK_rshift_slv(data_y_int_v,I_int_v+1);
          IF (add_nsub_x_int_v = '1') THEN
            data_x_int_v := std_logic_vector(signed(data_x_int_v(c_precision_int - 1 DOWNTO 0)) + signed(data_y_hw_shift_v(c_precision_int-1 DOWNTO 0)));
          ELSE
            data_x_int_v := std_logic_vector(signed(data_x_int_v(c_precision_int - 1 DOWNTO 0)) - signed(data_y_hw_shift_v(c_precision_int-1 DOWNTO 0)));
          END IF;
          IF (add_nsub_y_int_v = '1') THEN
            data_y_int_v := std_logic_vector(signed(data_y_int_v(c_precision_int - 1 DOWNTO 0)) + signed(data_x_hw_shift_v(c_precision_int-1 DOWNTO 0)));
          ELSE
            data_y_int_v := std_logic_vector(signed(data_y_int_v(c_precision_int - 1 DOWNTO 0)) - signed(data_x_hw_shift_v(c_precision_int-1 DOWNTO 0)));  	
          END IF;
          IF (add_nsub_p_int_v = '1') THEN
            phase_int_v  := std_logic_vector(signed(phase_int_v) + signed(eng_rom_vect(I_int_v)));
          ELSE
            phase_int_v  := std_logic_vector(signed(phase_int_v) - signed(eng_rom_vect(I_int_v)));
          END IF;
        add_nsub_x_int_v := 
          ( ( ( ( (c_eng_mode) AND (data_y_int_v(c_precision_int-1)) ) OR
                ( (NOT c_eng_mode) AND (NOT phase_int_v(c_precision_int-1)) )
              ) AND transform_type_v ) OR
            ( ( ( (c_eng_mode) AND (NOT data_y_int_v(c_precision_int-1)) ) OR
                ( (NOT c_eng_mode) AND (phase_int_v(c_precision_int-1)) )   
              ) AND (NOT transform_type_v) )
          );
        add_nsub_y_int_v := 
            ( ( (c_eng_mode) AND (data_y_int_v(c_precision_int-1)) ) OR
              ( (NOT c_eng_mode) AND (NOT phase_int_v(c_precision_int-1)) )
            );
        add_nsub_p_int_v := 
            ( ( (c_eng_mode) AND (NOT data_y_int_v(c_precision_int-1)) ) OR
              ( (NOT c_eng_mode) AND (phase_int_v(c_precision_int-1)) )   
            );
        END LOOP;
        eng_data_x_async <= data_x_int_v;
        eng_data_y_async <= data_y_int_v;
        eng_phase_async  <= phase_int_v;
        eng_ctrl_async   <= ctrl_int_v;
      END PROCESS;
    
      inst_eng_delay : PROCESS(eng_data_x_async,eng_data_y_async,eng_phase_async,eng_ctrl_async, clk)
        CONSTANT c_eng_latency : INTEGER := get_max(c_eng_data_latency,c_eng_nd_latency);
        TYPE data_int_type IS ARRAY(c_eng_latency DOWNTO 0) OF STD_LOGIC_VECTOR(c_precision_int-1 DOWNTO 0);
        TYPE ctrl_int_type IS ARRAY(c_eng_latency DOWNTO 0) OF STD_LOGIC_VECTOR(c_ctrl_width-1 DOWNTO 0);
        VARIABLE data_x_int_v : data_int_type := (OTHERS => (OTHERS => '0')); 
        VARIABLE data_y_int_v : data_int_type := (OTHERS => (OTHERS => '0')); 
        VARIABLE phase_int_v  : data_int_type := (OTHERS => (OTHERS => '0')); 
        VARIABLE ctrl_int_v   : ctrl_int_type := (OTHERS => (OTHERS => '0')); 
      BEGIN
        data_x_int_v(0) := eng_data_x_async;
        data_y_int_v(0) := eng_data_y_async;
        phase_int_v(0)  := eng_phase_async;
        ctrl_int_v(0)   := eng_ctrl_async;
        IF (clk'event AND clk = '1') THEN
          IF (ce_int = '1') THEN
            FOR I IN c_eng_latency DOWNTO 1 LOOP
              data_x_int_v(I) := data_x_int_v(I-1);
              data_y_int_v(I) := data_y_int_v(I-1);
              phase_int_v(I)  := phase_int_v(I-1);
              ctrl_int_v(I)   := ctrl_int_v(I-1);
            END LOOP;
          END IF;
          IF ( ((sclr_int = '1')) ) THEN
            FOR I IN c_eng_latency DOWNTO 1 LOOP
              data_x_int_v(I) := (OTHERS => '0');
              data_y_int_v(I) := (OTHERS => '0');
              phase_int_v(I)  := (OTHERS => '0');
              ctrl_int_v(I)   := (OTHERS => '0');
            END LOOP;
          END IF;      
        END IF;
        eng_data_x_fifo <= data_x_int_v(c_eng_data_latency) AFTER behav_reg_delay;
        eng_data_y_fifo <= data_y_int_v(c_eng_data_latency) AFTER behav_reg_delay;
        eng_phase_fifo <= phase_int_v(c_eng_data_latency) AFTER behav_reg_delay;
        eng_ctrl_fifo(0) <= ctrl_int_v(c_eng_nd_latency)(0) AFTER behav_reg_delay;
        IF (c_ctrl_width > 1) THEN
          eng_ctrl_fifo(c_ctrl_width-1 DOWNTO 1) <= ctrl_int_v(c_eng_data_latency)(c_ctrl_width-1 DOWNTO 1) AFTER behav_reg_delay;
        END IF;
        eng_rdy <= ctrl_int_v(c_eng_nd_latency)(0) AFTER behav_reg_delay;

      END PROCESS;--inst_eng_delay
    
        --Instantiate Registers
      inst_reg : PROCESS(clk)
        VARIABLE nd_v : STD_LOGIC := '0';
        VARIABLE rfd_v : STD_LOGIC := '1';
      BEGIN
        IF (clk'event AND clk = '1') THEN
          IF (ce_int = '1') THEN
            nd_v := nd_int;
            rfd_v := eng_rfd_async;
          END IF;
          IF ( ((sclr_int = '1')) ) THEN
            nd_v := '0';
            rfd_v := '1';
          END IF;      
        END IF;
        eng_nd_reg <= nd_v AFTER behav_reg_delay;
        eng_rfd_reg <= rfd_v AFTER behav_reg_delay;
      END PROCESS;--inst_data_reg

      data_x_eng <= eng_data_x_fifo;
      data_y_eng <= eng_data_y_fifo;
      phase_eng  <= eng_phase_fifo;
      ctrl_eng   <= eng_ctrl_fifo;
      rfd_eng    <= eng_rfd_async;
                
      -- If coarse rotate is turned off.
      gocr0: IF (c_coarse_rotate = 0) GENERATE
        outp_data_x_cr <= data_x_eng;
        outp_data_y_cr <= data_y_eng;
        outp_phase_cr <= phase_eng;
      END GENERATE;

      -- If Coarse Rotate is on Implement Coarse Rotation  
      gocr1: IF (c_coarse_rotate = 1) GENERATE

        outp_cr_quad(1) <= ctrl_eng(2);
        outp_cr_quad(0) <= ctrl_eng(1);

        -- Implement reverse rotation for a Rotate CORDIC Core
        gen_rotate_mode: IF (c_eng_mode = CORDIC_PACK_em_rotational) GENERATE

          rot_inv_coarse_rotate: PROCESS(outp_cr_quad,data_x_eng,data_y_eng)
          BEGIN
            CASE outp_cr_quad IS
        	    WHEN "11" => 
                outp_data_x_cr <= data_x_eng;
                outp_data_y_cr <= data_y_eng;
        	    WHEN "10" => 
                outp_data_x_cr <= data_y_eng;
                outp_data_y_cr <= std_logic_vector(signed(not(data_x_eng))+1);--std_logic_vector(-1*signed(data_x_eng))(c_precision_int-1 downto 0);
        	    WHEN "00" => 
                outp_data_x_cr <= std_logic_vector(signed(not(data_x_eng))+1);--std_logic_vector(-1*signed(data_x_eng))(c_precision_int-1 downto 0);
                outp_data_y_cr <= std_logic_vector(signed(not(data_y_eng))+1);--std_logic_vector(-1*signed(data_y_eng))(c_precision_int-1 downto 0);
        	    WHEN "01" => 
                outp_data_x_cr <= std_logic_vector(signed(not(data_y_eng))+1);--std_logic_vector(-1*signed(data_y_eng))(c_precision_int-1 downto 0);
                outp_data_y_cr <= data_x_eng;
              WHEN OTHERS =>
                outp_data_x_cr <= (OTHERS=> 'X');
                outp_data_y_cr <= (OTHERS=> 'X');
            END CASE;
          END PROCESS;--rot_inv_coarse_rotate
          outp_phase_cr <= phase_eng;
        END GENERATE;--gen_rotate_mode
    
        -- Implement reverse rotation for a Translate CORDIC Core
        gen_translate_mode: IF (c_eng_mode = CORDIC_PACK_em_translation) GENERATE

          outp_data_x_cr <= data_x_eng;
          outp_data_y_cr <= data_y_eng;
          trans_inv_coarse_rotate: PROCESS(outp_cr_quad,phase_eng)
          BEGIN
            CASE outp_cr_quad IS
              WHEN "11" => 
                outp_phase_cr <= phase_eng;
              WHEN "10" => 
                outp_phase_cr <= std_logic_vector(signed(phase_eng) + signed(c_neg_pi_2_4_const)) ;
              WHEN "00" => 
                IF (phase_eng(c_precision_int-1) = '0') THEN
                  outp_phase_cr <= std_logic_vector(signed(phase_eng) + signed(c_neg_pi_const)) ;
                ELSE	
                  outp_phase_cr <= std_logic_vector(signed(phase_eng) - signed(c_neg_pi_const)) ;
                END IF;
              WHEN "01" => 
                outp_phase_cr <= std_logic_vector(signed(phase_eng) - signed(c_neg_pi_2_4_const)) ;
              WHEN OTHERS =>
                outp_phase_cr <= (OTHERS=> 'X');
            END CASE;
          END PROCESS;--trans_inv_coarse_rotate
        END GENERATE;--gen_translate_mode

      END GENERATE;-- if Coarse Rotate = 1
  
      gsc0 : IF (c_scale_comp = CORDIC_PACK_scale_none) GENERATE

        gdx : IF (c_has_x_out = 1) GENERATE
          outp_data_x_sca <= outp_data_x_cr;
        END GENERATE;
        gdy : IF (c_has_y_out = 1) GENERATE
          outp_data_y_sca <= outp_data_y_cr;
        END GENERATE;
        gdp : IF (c_has_phase_out = 1) GENERATE
          outp_phase_sca <= outp_phase_cr;
        END GENERATE;
      END GENERATE;

      gsc1: IF (c_scale_comp /= CORDIC_PACK_scale_none) GENERATE

        gdx : IF (c_has_x_out = 1) GENERATE
          outp_data_x_sca_ext <= std_logic_vector(signed(outp_data_x_cr) * signed(c_inv_scale));
          outp_data_x_sca <= outp_data_x_sca_ext(2*c_precision_int-3 DOWNTO c_precision_int-2);
        END GENERATE; -- gen scale_x

        gdy : IF (c_has_y_out = 1) GENERATE
          outp_data_y_sca_ext <= std_logic_vector(signed(outp_data_y_cr) * signed(c_inv_scale));
          outp_data_y_sca <= outp_data_y_sca_ext(2*c_precision_int-3 DOWNTO c_precision_int-2);
        END GENERATE; -- Gen Scale y

        outp_phase_sca <= outp_phase_cr;

      END GENERATE; -- Gen Scale CCM
    
      outp_data_x_rnd <= CORDIC_PACK_rnd_slv(outp_data_x_sca, outp_data_x_sca'LENGTH, c_round_mode, c_output_width);
      outp_data_y_rnd <= CORDIC_PACK_rnd_slv(outp_data_y_sca, outp_data_y_sca'LENGTH, c_round_mode, c_output_width);
      outp_phase_rnd <= CORDIC_PACK_rnd_slv(outp_phase_sca, outp_phase_sca'LENGTH, c_round_mode, c_output_width);
      outp_rdy_rnd <= ctrl_eng(0);
        
      --Instantiate CORDIC Latency Fifo
      inst_outp_data_delay : PROCESS(outp_data_x_rnd,outp_data_y_rnd,outp_phase_rnd,outp_rdy_rnd, clk)
        CONSTANT c_outp_latency : INTEGER := get_max(c_outp_data_latency,c_outp_nd_latency);
        TYPE data_int_type IS ARRAY(c_outp_latency DOWNTO 0) OF STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0);
        VARIABLE data_x_int_v : data_int_type := (OTHERS => (OTHERS => '0')); 
        VARIABLE data_y_int_v : data_int_type := (OTHERS => (OTHERS => '0')); 
        VARIABLE phase_int_v : data_int_type := (OTHERS => (OTHERS => '0')); 
        VARIABLE rdy_int_v : STD_LOGIC_VECTOR(c_outp_latency DOWNTO 0) := (OTHERS => '0'); 

        VARIABLE test_c_outp_latency : INTEGER; 
      BEGIN
        data_x_int_v(0) := outp_data_x_rnd;
        data_y_int_v(0) := outp_data_y_rnd;
        phase_int_v(0)  := outp_phase_rnd;
        rdy_int_v(0)    := outp_rdy_rnd;
        IF (clk'event AND clk = '1') THEN
          IF (ce_int = '1') THEN
            FOR I IN c_outp_latency DOWNTO 1 LOOP
              data_x_int_v(I) := data_x_int_v(I-1);
              data_y_int_v(I) := data_y_int_v(I-1);
              phase_int_v(I)  := phase_int_v(I-1);
              rdy_int_v(I)    := rdy_int_v(I-1);
            END LOOP;
          test_c_outp_latency := get_max(c_outp_data_latency,c_outp_nd_latency);

          END IF;
          IF ( ((sclr_int = '1')) ) THEN
            FOR I IN c_outp_latency DOWNTO 1 LOOP
              data_x_int_v(I) := (OTHERS => '0');
              data_y_int_v(I) := (OTHERS => '0');
              phase_int_v(I)  := (OTHERS => '0');
              rdy_int_v(I)    := '0';
            END LOOP;
          END IF;      
        END IF;
        IF (c_outp_data_latency > 0) THEN
          outp_data_x_fifo <= data_x_int_v(c_outp_data_latency-1) AFTER behav_reg_delay;
          outp_data_y_fifo <= data_y_int_v(c_outp_data_latency-1) AFTER behav_reg_delay;
          outp_phase_fifo <= phase_int_v(c_outp_data_latency-1) AFTER behav_reg_delay;
        ELSE
          outp_data_x_fifo <= data_x_int_v(0);
          outp_data_y_fifo <= data_y_int_v(0);
          outp_phase_fifo <= phase_int_v(0);
        END IF;
        IF(c_outp_nd_latency > 0) THEN
          outp_rdy_fifo <= rdy_int_v(c_outp_nd_latency-1) AFTER behav_reg_delay;
        ELSE
          outp_rdy_fifo <= rdy_int_v(0);
        END IF;
      END PROCESS;--inst_data_delay
      
      --Instantiate Output Register
      inst_data_reg : PROCESS(clk)
        VARIABLE data_x_int_v : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0'); 
        VARIABLE data_y_int_v : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
        VARIABLE phase_int_v  : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS => '0');
        VARIABLE rdy_int_v    : STD_LOGIC := '0'; 
      BEGIN
        IF (clk'event AND clk = '1') THEN
          IF (outp_ce_and_rdy = '1') THEN
            data_x_int_v := outp_data_x_fifo;
            data_y_int_v := outp_data_y_fifo;
            phase_int_v  := outp_phase_fifo;
          END IF;
          IF (ce_int = '1') THEN
            rdy_int_v := outp_rdy_fifo;
          END IF;
          IF ( ((sclr_int = '1')) ) THEN
            data_x_int_v := (OTHERS => '0');
            data_y_int_v := (OTHERS => '0');
            phase_int_v  := (OTHERS => '0');
          END IF;
          IF ( ((sclr_int = '1')) ) THEN
            rdy_int_v    := '0';
          END IF;      
        END IF;

        outp_data_x_reg <= data_x_int_v AFTER behav_reg_delay;
        outp_data_y_reg <= data_y_int_v AFTER behav_reg_delay;
        outp_phase_reg  <= phase_int_v AFTER behav_reg_delay;
        outp_rdy_reg    <= rdy_int_v AFTER behav_reg_delay;

      END PROCESS;--inst_data_reg

      --Select Output Signals
      data_x_outp <= (others=>'Z') WHEN (c_has_x_out = 0) ELSE
                     outp_data_x_reg WHEN (c_outp_data_latency > 0) ELSE outp_data_x_fifo;
      data_y_outp <= (others=>'Z') WHEN (c_has_y_out = 0) ELSE
                     outp_data_y_reg WHEN (c_outp_data_latency > 0) ELSE outp_data_y_fifo;
      phase_outp <=  (others=>'Z') WHEN (c_has_phase_out = 0) ELSE
                     outp_phase_reg WHEN (c_outp_data_latency > 0) ELSE outp_phase_fifo;
      rdy_outp <= 'Z' WHEN (c_has_rdy = 0) ELSE
                     outp_rdy_reg WHEN (c_outp_data_latency > 0) ELSE outp_rdy_fifo;
      outp_ce_and_rdy <= (outp_rdy_fifo AND ce_int) OR (sclr_int AND ce_int);
      rfd_outp <= rfd_eng;
  
    END GENERATE;--Instantiate CORDIC core (Non Sqrt)

    --Instantiate SQRT Simplification to CORDIC core
    gisq: IF (c_cordic_function = CORDIC_PACK_f_sqrt) GENERATE

      gen_sqrt : PROCESS(x_in)--(data_x_init)
      BEGIN
        sqrt_data_trunc_async <= sqrt_slv(x_in, c_precision_int, c_data_format);
      END PROCESS;
      
      gen_sqrt_ext : PROCESS(sqrt_data_trunc_async)
      BEGIN
        sqrt_data_trunc_async_ext <= (OTHERS =>'0');
        sqrt_data_trunc_async_ext(c_precision_int-1 DOWNTO 0) <= sqrt_data_trunc_async;
      END PROCESS;

      gen_sqrt_round : PROCESS(sqrt_data_trunc_async_ext)
      BEGIN
        sqrt_data_round_async <= CORDIC_PACK_rnd_slv(sqrt_data_trunc_async_ext, sqrt_data_trunc_async_ext'LENGTH, c_rnd_mode_int, c_output_width);
      END PROCESS;
      
      --Instantiate Sqrt Latency Fifo to delay by c_sqrt_data_latency
      inst_data_delay : PROCESS(clk,sqrt_data_round_async,nd_int)
        TYPE data_int_type IS ARRAY(c_sqrt_data_latency DOWNTO 0) OF STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0);
        VARIABLE sqrt_data_v : data_int_type := (OTHERS => (OTHERS => '0')); 
        VARIABLE nd_v : STD_LOGIC_VECTOR(c_sqrt_data_latency DOWNTO 0) := (OTHERS => '0'); 
      BEGIN
        sqrt_data_v(0) := sqrt_data_round_async;
        nd_v(0) := nd_int; 
        IF (clk'event AND clk = '1') THEN
          IF (ce_int = '1') THEN
            FOR I IN c_sqrt_data_latency DOWNTO 1 LOOP
              sqrt_data_v(I) := sqrt_data_v(I-1);
              nd_v(I) := nd_v(I-1); 
            END LOOP;
          END IF;
          IF sclr_int = '1' then --( ((sclr_int = '1') AND (ce_int = '1')) ) THEN
            FOR I IN c_sqrt_data_latency DOWNTO 1 LOOP
              sqrt_data_v(I) := (OTHERS => '0');
              nd_v(I) := '0'; 
            END LOOP;
          END IF;      
        END IF;
        sqrt_data_fifo <= sqrt_data_v(c_sqrt_data_latency) AFTER behav_reg_delay;
        sqrt_nd_fifo <= nd_v(c_sqrt_data_latency) AFTER behav_reg_delay;
      END PROCESS;--inst_data_delay

      sqrt_rdy_int <= sqrt_nd_fifo;
      sqrt_ce_and_rdy <= ce_int AND sqrt_rdy_int;
  
      --Instantiate Output Registers
      inst_reg : PROCESS(clk)
        VARIABLE rdy_v : STD_LOGIC := '0';
        VARIABLE sqrt_v : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS=>'0'); 
      BEGIN
        IF (clk'event AND clk = '1') THEN
          IF (ce_int = '1') THEN
            rdy_v := sqrt_rdy_int;
          END IF;
          IF (sqrt_ce_and_rdy = '1') THEN
            sqrt_v := sqrt_data_fifo;
          END IF;
          IF sclr_int = '1' then --( ((sclr_int = '1') AND (ce_int = '1')) ) THEN
            rdy_v := '0';
          END IF;      
          IF sclr_int = '1' then --( ((sclr_int = '1') AND (sqrt_ce_and_rdy = '1')) ) THEN
            sqrt_v := (OTHERS=>'0');
          END IF;
        END IF;
        sqrt_rdy_reg <= rdy_v AFTER behav_reg_delay;
        sqrt_data_reg <= sqrt_v AFTER behav_reg_delay;
      END PROCESS;--inst_data_reg
  
      --Select between asynchronus and registered outputs.
      gen_tmp_sigs : PROCESS(sqrt_rdy_reg, sqrt_rdy_int, sqrt_data_reg, sqrt_data_fifo)
        VARIABLE rdy_v : STD_LOGIC := '0';
        VARIABLE sqrt_v : STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0) := (OTHERS=>'0'); 
      BEGIN
        rdy_v  := sqrt_rdy_reg;
        sqrt_v := sqrt_data_reg;
        IF (c_pipeline_mode=0 AND c_reg_outputs=0 AND c_reg_inputs=0) THEN
          rdy_v  := sqrt_rdy_int;
          sqrt_v := sqrt_data_fifo;
        END IF;
        rdy_sqrt  <= rdy_v;
        data_x_sqrt <= sqrt_v;
      END PROCESS;--inst_data_reg

    END GENERATE;
 
    g_no_buf0:IF(c_has_x_out = 1 ) GENERATE
      x_out <= data_x_sqrt WHEN (c_cordic_function = CORDIC_PACK_f_sqrt) ELSE data_x_outp;
    END GENERATE;
    -- y out
    g_no_buf1:IF(c_has_y_out = 1 ) GENERATE
      y_out <= (OTHERS=>'0') WHEN (c_cordic_function = CORDIC_PACK_f_sqrt) ELSE data_y_outp;
    END GENERATE;
    -- phase_out
    g_no_buf2:IF(c_has_phase_out = 1 ) GENERATE
      phase_out <= (OTHERS=>'0') WHEN (c_cordic_function = CORDIC_PACK_f_sqrt) ELSE phase_outp;
    END GENERATE;
    -- rfd out
    rfd_out: IF(c_has_rfd = 1) GENERATE
      rfd <= '1' WHEN (c_cordic_function = CORDIC_PACK_f_sqrt) ELSE rfd_outp;
    END GENERATE;
    -- ready out
    out_rdy: IF(c_has_rdy = 1 ) GENERATE
      rdy <= rdy_sqrt WHEN (c_cordic_function = CORDIC_PACK_f_sqrt) ELSE rdy_outp;
    END GENERATE;
  
end behavioral;


--------------------------------------------------------------------------------
-- $RCSfile: mac_fir_v5_1_xst.vhd,v $
--------------------------------------------------------------------------------
-- MAC FIR Filter : VHDL Behavioral Model wrapper
--------------------------------------------------------------------------------
--                                                                       
-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
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
-- "as is" solely for use in developing programs and
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
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 1995-2004 Xilinx, Inc.
-- All rights reserved.
--------------------------------------------------------------------------------
--
-- Simple wrapper for the mac_fir_v5_1 core simulation model.
-- A mapping is required from the integer clock and sample frequencies (in Hz)
-- to the real values (in MHz) for the Java-based core.
-- This file is for behavioral simulation, *NOT* for use by Coregen.
--
--


library IEEE;
use IEEE.STD_LOGIC_1164.all;

library XilinxCoreLib;
USE XilinxCoreLib.ul_utils.ALL;
library XilinxCoreLib;
use XilinxCoreLib.mac_fir_v5_1_comp.all ;

entity mac_fir_v5_1_xst is

		GENERIC( c_family             : string;
             component_name     : string;
             c_area_speed_optimization : INTEGER;
					   c_channels 					: INTEGER := 1;	
						 --c_coefficients				: INTEGER;
		      	 c_coef_buffer_type 	: INTEGER;		      	
		      	 c_coef_init_file 		: STRING;
		      	 c_coef_type 					: INTEGER;
		      	 c_coef_width 				: INTEGER := 16;
		      	 c_data_buffer_type 	: INTEGER;		      	
		      	 c_data_type 					: INTEGER;
				 		 c_data_width 				: INTEGER := 16;
		      	 c_decimate_factor 		: INTEGER; 
		      	 c_filter_type 				: INTEGER; 
				 		 --c_input_sample_rate 	: REAL;
				 		 c_input_sample_rate 	: integer;
		      	 c_interpolate_factor : INTEGER; 
		      	 c_latency 						: INTEGER;
				 		 c_num_coef_sets 			: INTEGER := 1;
		      	 c_reg_output 				: INTEGER; 
		      	 c_reload 						: INTEGER; 
		   	  	 c_reload_delay 			: INTEGER;
		      	 c_response 					: INTEGER;
		       	 c_result_width 			: INTEGER := 48; 
				 		 c_sel_i_dir 					: INTEGER;
				 		 --c_system_clock_rate 	: REAL;
				 		 c_system_clock_rate 	: integer;
		       	 c_taps 							: INTEGER;
		      	 c_use_model_func 		: INTEGER; 
					 	 c_shape							: INTEGER;
						 c_enable_rlocs				: INTEGER;
		      	 c_zpf 								: INTEGER );
			   
		PORT ( 	reset : IN  std_logic;
		       	 	 nd : IN  std_logic;
							din : IN  std_logic_vector( (c_data_width - 1) DOWNTO 0 );
		      		clk : IN  std_logic;
		     	   dout : OUT std_logic_vector( (c_result_width - 1) DOWNTO 0 );
		   		 dout_i : OUT std_logic_vector( (c_data_width - 1)   DOWNTO 0);
		   		 dout_q : OUT std_logic_vector( (c_result_width - 1) DOWNTO 0 ); 
							rfd : OUT std_logic;
		      		rdy : OUT std_logic;
		  		coef_ld : IN  std_logic;
		   	 	 ld_din : IN  std_logic_vector( (c_coef_width - 1) DOWNTO 0);
		    	  ld_we : IN  std_logic;
		   		  sel_i : OUT std_logic_vector( (bitsneededtorepresent(c_channels-1) - 1) DOWNTO 0);
		    	  sel_o : OUT std_logic_vector( (bitsneededtorepresent(c_channels-1) - 1) DOWNTO 0);
		     coef_sel : IN  std_logic_vector( (bitsneededtorepresent(c_num_coef_sets-1) - 1) DOWNTO 0)
         );

end mac_fir_v5_1_xst;

-----------------------------------------------------------------------------

architecture xilinx of mac_fir_v5_1_xst is

  -- Convert the integer clock rates in Hz to real values in MHz
  constant real_sample_rate : real := real(c_input_sample_rate)/1000000.0;
  constant real_clock_rate  : real := real(c_system_clock_rate)/1000000.0;

begin

  mf51 : c_mac_fir_v5_1
  GENERIC MAP(
		c_family                  => c_family                 ,
    component_name            => component_name           ,
    c_area_speed_optimization => c_area_speed_optimization,
		c_channels 					      => c_channels 					    ,
		--c_coefficients			      => c_coefficients			      ,
		c_coef_buffer_type 	      => c_coef_buffer_type 	    ,
		c_coef_init_file 		      => c_coef_init_file 		    ,
		c_coef_type 				      => c_coef_type 				      ,
		c_coef_width 				      => c_coef_width 				    ,
		c_data_buffer_type 	      => c_data_buffer_type 	    ,
		c_data_type 				      => c_data_type 				      ,
		c_data_width 				      => c_data_width 				    ,
		c_decimate_factor 	      => c_decimate_factor 	      ,
		c_filter_type 			      => c_filter_type 			      ,
		c_input_sample_rate       => real_sample_rate         , -- int->real
		c_interpolate_factor      => c_interpolate_factor     ,
		c_latency 					      => c_latency 					      ,
		c_num_coef_sets 		      => c_num_coef_sets 		      ,
		c_reg_output 				      => c_reg_output 				    ,
		c_reload 						      => c_reload 						    ,
		c_reload_delay 			      => c_reload_delay 			    ,
		c_response 					      => c_response 					    ,
		c_result_width 			      => c_result_width 			    ,
		c_sel_i_dir 				      => c_sel_i_dir 				      ,
		c_system_clock_rate       => real_clock_rate          , -- int->real
		c_taps 							      => c_taps 							    ,
		c_use_model_func 		      => c_use_model_func 		    ,
		c_shape							      => c_shape							    ,
		c_enable_rlocs			      => c_enable_rlocs			      ,
		c_zpf 							      => c_zpf 							     
  )
  PORT MAP(
		reset     => reset  ,
		nd        => nd     ,
		din       => din    ,
		clk       => clk    ,
		dout      => dout   ,
		dout_i    => dout_i ,
		dout_q    => dout_q ,
		rfd       => rfd    ,
		rdy       => rdy    ,
		coef_ld   => coef_ld,
		ld_din    => ld_din ,
		ld_we     => ld_we  ,
		sel_i     => sel_i  ,
		sel_o     => sel_o  ,
    coef_sel  => coef_sel
  ); 


end xilinx;

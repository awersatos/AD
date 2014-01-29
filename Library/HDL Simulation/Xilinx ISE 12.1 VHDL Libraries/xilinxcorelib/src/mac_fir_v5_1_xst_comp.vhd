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
--  of this text at all times. (c) Copyright 1995-2004 Xilinx, Inc.
--  All rights reserved.



-- $Id: mac_fir_v5_1_xst_comp.vhd,v 1.10 2008/09/08 20:09:05 akennedy Exp $
--
--  Description:
--   Compontent declaration
--   MAC FIR Simulation Model


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.ul_utils.ALL;

PACKAGE mac_fir_v5_1_xst_comp IS
	
	COMPONENT mac_fir_v5_1_xst 	
		
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
			 
	END COMPONENT;

  -- -- The following tells XST that this core is a black box which 
  -- -- should be generated with the command given by the value of this attribute. 
  -- -- Note the fully qualified SIM (JAVA class) name that forms the 
  -- -- basis of the core. 
  -- ATTRIBUTE box_type : string; 
  -- ATTRIBUTE box_type OF mac_fir_v5_1_xst : COMPONENT IS "black_box"; 
  -- ATTRIBUTE GENERATOR_DEFAULT : string; 
  -- ATTRIBUTE GENERATOR_DEFAULT OF mac_fir_v5_1_xst : COMPONENT IS "generatecore com.xilinx.ip.mac_fir_v5_1.mac_fir_v5_1_xst";

END mac_fir_v5_1_xst_comp;

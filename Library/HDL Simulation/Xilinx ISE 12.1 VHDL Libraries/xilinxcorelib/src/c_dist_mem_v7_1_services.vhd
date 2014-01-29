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
--
-------------------------------------------------------------------------------
-- Distmem v7 Intelligent Functions Package
-------------------------------------------------------------------------------
-- The purpose of this package, is to make
-- 'intelligent' functions available to VHDL
-- and XCC developers, that used to be available
-- to JAVA developers alone.
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
--  
LIBRARY xilinxcorelib;
USE xilinxcorelib.prims_constants_V7_0.all;
use xilinxcorelib.family.all;

package c_dist_mem_v7_1_services is

   -- See below for a description of each of these functions.

   type latency_array_type is array (natural range <>) of integer;
   function get_c_dist_mem_v7_1_available_latency(c_reg_a_d_inputs, c_has_spo, c_has_qspo : boolean; c_depth : integer; 
   													c_family : string; c_mux_type : integer; c_mem_type : integer) 
   													return latency_array_type;
   function get_c_dist_mem_v7_1_max_latency(c_reg_a_d_inputs, c_has_spo, c_has_qspo : boolean; c_depth : integer; 
   											c_family : string; c_mux_type : integer; c_mem_type : integer) return integer;
   
end c_dist_mem_v7_1_services;

package body c_dist_mem_v7_1_services is

-------------------------------------------------------------------------------
-- Function Name : get_c_dist_mem_v7_1_available_latency
-------------------------------------------------------------------------------
-- Purpose : Returns an array of integers that indicate the choice of latency
-- values available.
-------------------------------------------------------------------------------
-- Inputs:
-- c_reg_a_d_inputs : Boolean indicating the presence of input registers
	-- False: No input registers
	-- True: Input registers
-- c_has_spo : Boolean indicating the presence of a non-registered output
	-- False: No asynchronous output
	-- True: Asynchronous output active
-- c_has_qspo: Boolean indicating the presence of a registered output
	-- False: No synchronous output
	-- True: Synchronous output active
-- c_depth: Integer indicating depth of RAM (must be integer multiple of 16) (RANGE: 16 -> (4096 for Virtex derivatives) (65536 for Virtex2 derivatives))
-- c_family: String indicating family derivative (Virtex or Virtex2)
-- c_mux_type: Integer to choose how the multiplexers are built
	-- 0: using LUTs
	-- 1: usign BUFTs
-- c_mem_type: Integer to indicate chosen memory type
	-- 0: ROM
	-- 1: Single Port RAM
	-- 2: Dual Port RAM
	-- 3: SRL16 based RAM
-------------------------------------------------------------------------------

	function get_c_dist_mem_v7_1_available_latency(c_reg_a_d_inputs, c_has_spo, c_has_qspo : boolean; c_depth : integer; 
   													c_family : string; c_mux_type : integer; c_mem_type : integer) 
   													return latency_array_type is

		variable latencyList : latency_array_type(0 to 9);
		variable regInputs : integer := 0;
		variable regOutputs : integer := 0;
		variable numRAMs : integer := 1;
		variable primDepth : integer;
		variable muxLayers : integer := 0;
		constant muxBuses : integer := 32;
		variable temp : integer := numRAMs;
		variable maxPipeline : integer := 0;
	
	begin
		
		if (c_reg_a_d_inputs) then regInputs := 1;
		end if;
    	if (c_has_qspo) then regOutputs := 1;
		end if;
    	case c_mem_type is
			when 0 =>
				-- determine how many ROM primitives are required
    			if (derived(c_family, VIRTEX2)) then numRAMs := (c_depth + 255)/256;
				else numRAMs := (c_depth + 63)/64;
    			end if;
    			primDepth := 64;
    			if (derived(c_family, VIRTEX2)) then primDepth := 256;
				end if;
			 when 1 =>
				-- determine how many RAM primitives are required
   				if (derived(c_family, SPARTAN3)) then
					while ((numRAMs*64) < c_depth) loop
						numRAMs := numRAMs + 1;
					end loop;
   				elsif (derived(c_family, VIRTEX2)) then
   					 while ((numRAMs*128) < c_depth) loop
   					 	numRAMs := numRAMs + 1;
					 end loop;
   				else 
   				 	 while ((numRAMs*32) < c_depth) loop
   				 	 	numRAMs := numRAMs + 1;
					 end loop;
				end if;
   				primDepth := 32; --largest Virtex ram primitive
   				if (derived(c_family, SPARTAN3)) then primDepth := 64;	-- largest Spartan3 ram primitive
   				elsif (derived(c_family, VIRTEX2)) then primDepth := 128;    --largest Virtex2 ram primitive
				end if;
			 when 2 =>
				-- determine how many RAM primitives are required
   				if (derived(c_family, SPARTAN3)) then 
   					 while ((numRAMs*16) < c_depth) loop
   					 	numRAMs := numRAMs + 1;
					 end loop;
   				elsif (derived(c_family, VIRTEX2)) then
   					 while ((numRAMs*64) < c_depth) loop
   					 	numRAMs := numRAMs + 1;
				 	 end loop;
   				else 
   					 while ((numRAMs*16) < c_depth) loop
   					 	numRAMs := numRAMs + 1;
					 end loop;
				end if;
   				primDepth := 16; --largest Virtex ram primitive
   				if (derived(c_family, SPARTAN3)) then primDepth := 16;	-- largest Spartan3 ram primitive
   				elsif (derived(c_family, VIRTEX2)) then primDepth := 64;    --largest Virtex2 ram primitive
				end if;
			 when 3 =>
				-- determine how many RAM primitives are required
   				while ((numRAMs*16) < c_depth) loop
   					 numRAMs := numRAMs + 1;
				end loop;
   				primDepth := 16; --largest ram primitive
			 when others =>
				return latencyList; -- not a valid mem_type
		 end case;
		
   		 if (((not c_has_spo) or c_mux_type = c_buft_based) and c_depth > primDepth) then
   		     -- calculate how many muxes are required and how many layers of muxes
   		     temp := numRAMs;
   		     while (temp > 1) loop
   		         muxLayers := muxLayers + 1;
   		         temp := (temp+muxBuses-1)/muxBuses;
   		     end loop;
   		         
   		     if (c_mux_type = c_buft_based) then
   		         for i in 0 to 1 loop
   		         	latencyList(i) := i+regInputs;
   		      	 end loop;
		 	 	 return latencyList(0 to 1);
   		     else
   		         -- loop to create each level of muxes
   		         for i in 0 to muxLayers-1 loop
   		         	maxPipeline := maxPipeline + 1;
		 	 	 end loop;
   		                     
   		         for i in 0 to maxPipeline loop
   		            latencyList(i) := i+regInputs+regOutputs;
		 	 	 end loop;
		 	 	 return latencyList(0 to maxPipeline);
   		     end if;
   		 else
   		     if (c_mux_type = c_buft_based) then
   		     	latencyList(0) := regInputs;
   		     else 
   		     	latencyList(0) := regInputs + regOutputs;
		  	 end if;
		  	 return latencyList(0 to 0);
   		 end if;
	end get_c_dist_mem_v7_1_available_latency;

-------------------------------------------------------------------------------
-- Function Name : get_c_dist_mem_v7_1_max_latency
-------------------------------------------------------------------------------
-- Purpose : Returns the maximum latency value possible with the parameters
-------------------------------------------------------------------------------
-- Inputs:
-- c_reg_a_d_inputs : Boolean indicating the presence of input registers
	-- False: No input registers
	-- True: Input registers
-- c_has_spo : Boolean indicating the presence of a non-registered output
	-- False: No asynchronous output
	-- True: Asynchronous output active
-- c_has_qspo: Boolean indicating the presence of a registered output
	-- False: No synchronous output
	-- True: Synchronous output active
-- c_depth: Integer indicating depth of RAM (must be integer multiple of 16) (RANGE: 16 -> (4096 for Virtex derivatives) (65536 for Virtex2 derivatives))
-- c_family: String indicating family derivative (Virtex or Virtex2)
-- c_mux_type: Integer to choose how the multiplexers are built
	-- 0: using LUTs
	-- 1: usign BUFTs
-- c_mem_type: Integer to indicate chosen memory type
	-- 0: ROM
	-- 1: Single Port RAM
	-- 2: Dual Port RAM
	-- 3: SRL16 based RAM
-------------------------------------------------------------------------------
  	function get_c_dist_mem_v7_1_max_latency(c_reg_a_d_inputs, c_has_spo, c_has_qspo : boolean; c_depth : integer; 
   											c_family : string; c_mux_type : integer; c_mem_type : integer) return integer is

		variable regInputs : integer := 0;
		variable regOutputs : integer := 0;
		variable numRAMs : integer := 1;
		variable muxLayers : integer := 0;
		constant muxBuses : integer := 32;
		variable temp : integer;
		variable maxPipeline : integer := 0;
		variable primDepth : integer;
	
	begin
		if (c_reg_a_d_inputs) then regInputs := 1;
		end if;
    	if (c_has_qspo) then regOutputs := 1;
		end if;
        
    	if (c_mux_type = c_buft_based) then   --BUFT option does not allow ouput registering, but 1 pipeline stage can be added if more than one primitive
    	   	if (numRAMs > 1) then return regInputs+1;
        	else return regInputs;
			end if;
		else
			case c_mem_type is
				when 0 =>
    				-- calculate number of RAM primitives required
    				if (derived(c_family, VIRTEX2)) then numRAMs := (c_depth + 255)/256;
					else numRAMs := (c_depth + 63)/64;
    				end if;
    				primDepth := 64;
        			if (derived(c_family, VIRTEX2)) then primDepth := 256;
					end if;
				when 1 =>
				-- determine how many RAM primitives are required
   					if (derived(c_family, SPARTAN3)) then
						while ((numRAMs*64) < c_depth) loop
							numRAMs := numRAMs + 1;
						end loop;
   					elsif (derived(c_family, VIRTEX2)) then
   						while ((numRAMs*128) < c_depth) loop
   					 		numRAMs := numRAMs + 1;
					 	end loop;
   					else 
   				 	 	while ((numRAMs*32) < c_depth) loop
   				 	 		numRAMs := numRAMs + 1;
					 	end loop;
					end if;
   					primDepth := 32; --largest Virtex ram primitive
   					if (derived(c_family, SPARTAN3)) then primDepth := 64;	-- largest Spartan3 ram primitive
   					elsif (derived(c_family, VIRTEX2)) then primDepth := 128;    --largest Virtex2 ram primitive
					end if;
			 	when 2 =>
				-- determine how many RAM primitives are required
   					if (derived(c_family, SPARTAN3)) then 
   					 	while ((numRAMs*16) < c_depth) loop
   					 		numRAMs := numRAMs + 1;
					 	end loop;
   					elsif (derived(c_family, VIRTEX2)) then
   					 	while ((numRAMs*64) < c_depth) loop
   					 		numRAMs := numRAMs + 1;
				 	 	end loop;
   					else 
   					 	while ((numRAMs*16) < c_depth) loop
   					 		numRAMs := numRAMs + 1;
					 	end loop;
					end if;
   					primDepth := 16; --largest Virtex ram primitive
   					if (derived(c_family, SPARTAN3)) then primDepth := 16;	-- largest Spartan3 ram primitive
   					elsif (derived(c_family, VIRTEX2)) then primDepth := 64;    --largest Virtex2 ram primitive
					end if;
			 	when 3 =>
				-- determine how many RAM primitives are required
   					while ((numRAMs*16) < c_depth) loop
   					 	numRAMs := numRAMs + 1;
					end loop;
   					primDepth := 16; --largest ram primitive
        		when others =>
					return 0; -- invalid mem_type
			end case;
        
        	if ((not c_has_spo) and c_depth > primDepth) then   --pipelining can only be added when multiplexers are required
        		--calculate how many muxes are required and how many layers of muxes
            	temp := numRAMs;
            	while (temp > 1) loop
            	    muxLayers := muxLayers + 1;
                	temp := (temp+muxBuses-1)/muxBuses;
            	end loop;
                
            	--loop to create each level of muxes
            	for i in 0 to muxLayers-1 loop
            		maxPipeline := maxPipeline + 1;  --only 1 pipeline stage allowed for each mux layer, to allow for differing sizes of mux
				end loop;
                        
            	return maxPipeline+regInputs+regOutputs;
        	else return regInputs + regOutputs;
			end if;
		end if;
    end get_c_dist_mem_v7_1_max_latency;

-- end of c_dist_mem_v7_1 intelligent functions package.
   
end c_dist_mem_v7_1_services;


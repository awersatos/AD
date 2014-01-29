-------------------------------------------------------------------------------
-- Baseblox v5 Intelligent Functions Package
-------------------------------------------------------------------------------
-- The purpose of this package, is to make
-- 'intelligent' functions available to VHDL
-- and XCC developers, that used to be available
-- to JAVA developers alone.
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package baseblox_v5_0_services is

   -- See below for a description of each of these functions.

   function get_c_mux_bit_v5_0_max_latency(c_has_o, c_has_q, c_inputs : integer) return integer;
   type latency_array_type is array (0 to 2) of integer;
   function get_c_mux_bit_v5_0_latencies(c_has_o, c_has_q, c_inputs  : integer) return latency_array_type;

   function get_c_mux_bus_v5_0_max_latency(c_has_o, c_has_q, c_inputs, mux_type : integer) return integer;
   function get_c_mux_bus_v5_0_latencies(c_has_o, c_has_q, c_inputs, mux_type  : integer) return latency_array_type;

   function get_c_addsub_v5_0_latency (c_out_width : integer; c_has_q_ovfl : boolean) return integer;

end baseblox_v5_0_services;

package body baseblox_v5_0_services is

-- Mux Bit Functions
   
-------------------------------------------------------------------------------
-- Function Name : get_c_mux_bit_v5_0_max_latency
-------------------------------------------------------------------------------   
-- Purpose : Returns an integer, which indicates the maximum latency for the
-- mux bit core.
-------------------------------------------------------------------------------   
-- Inputs:
-- c_has_o : Integer indicating the presence of a non-registered output
   -- 0 Port not present
   -- 1 Port present
-- c_has_q : Integer indicating the presence of a registered output
   -- 0 Port not present
   -- 1 Port present
--c_inputs : Integer representing the number of bits being multiplexed
   -- c_inputs minimum value is 2, maximum value is 256
-------------------------------------------------------------------------------   
   
   function get_c_mux_bit_v5_0_max_latency(c_has_o, c_has_q, c_inputs : integer) return integer is

      variable maxLatency : integer := integer'high;
      
   begin

      if (c_inputs > 1) then

         if (c_has_o = 1) and (c_has_q = 0) then
            --output is non registered
            --maximum latency is zero.
            maxLatency := 0;
         elsif (c_has_o = 1) and (c_has_q = 1) then
            -- both outputs are used.
            -- maximum latency is one.
            maxLatency := 1;
         elsif (c_has_o = 0) and (c_has_q = 1) then

            if (c_inputs < 65) then
               -- Output is registered
               -- maximum latency is two.
               maxLatency := 2;
            else
               maxLatency := 3;
            end if;
         end if;
      end if;

      return maxLatency;

   end get_c_mux_bit_v5_0_max_latency;

-------------------------------------------------------------------------------
-- Function Name : get_c_mux_bit_v5_0_latencies
-------------------------------------------------------------------------------   
-- Purpose : Returns an array of integers, which indicate the latencies which
-- can be expected for a given implementation, based upon the following parameters
-------------------------------------------------------------------------------   
-- Inputs:
-- c_has_o : Integer indicating the presence of a non-registered output
   -- 0 Port not present
   -- 1 Port present
-- c_has_q : Integer indicating the presence of a registered output
   -- 0 Port not present
   -- 1 Port present
--c_inputs : Integer representing the number of bits being multiplexed
   -- c_inputs minimum value is 2, maximum value is 256
-------------------------------------------------------------------------------    

   function get_c_mux_bit_v5_0_latencies(c_has_o, c_has_q, c_inputs : integer) return latency_array_type is

      -- The purpose of this function is to return an array of available latencies
      -- for the bit multiplexer core

      variable latency_array : latency_array_type := (others => 0);
      
   begin

      if (c_has_o = 1) and (c_has_q = 0) then
         latency_array(0) := 0;
      elsif (c_has_o = 1) and (c_has_q = 1) then
         latency_array(0) := 1;
      else
         latency_array(0) := 1;
         if (c_inputs > 8) then
            latency_array(1) := 2;
         end if;
         if (c_inputs > 64) then
            latency_array(2) := 3;
         end if;
      end if;

      return latency_array;

   end get_c_mux_bit_v5_0_latencies;

   -- end of mux bit functions.

   -- mux bus functions

-------------------------------------------------------------------------------
-- Function Name : get_c_mux_bus_v5_0_max_latency
-------------------------------------------------------------------------------   
-- Purpose : Returns an integer, which indicates the maximum latency for a
-- given implementation of the mux bus core.
-------------------------------------------------------------------------------   
-- Inputs:
-- c_has_o : Integer indicating the presence of a non-registered output
   -- 0 Port not present
   -- 1 Port present
-- c_has_q : Integer indicating the presence of a registered output
   -- 0 Port not present
   -- 1 Port present
--c_inputs : Integer representing the number of busses being multiplexed
   -- c_inputs minimum value is 2, maximum value is 32
--mux_type : Integer which represents how the mux bus has been constructed:
   --0 : LUT based mux bus
   --1 : BUFT based mux bus
-------------------------------------------------------------------------------    

   function get_c_mux_bus_v5_0_max_latency (c_has_o, c_has_q, c_inputs, mux_type : integer) return integer is

      constant LOGIC_MUX : integer := 0;
      constant BUFT_MUX  : integer := 1;

      variable latency : integer := 0;
      
   begin

      if (mux_type = LOGIC_MUX) then
         -- Re-use the mux bit getMuxBitMaxLatency function.
         latency := get_c_mux_bit_v5_0_max_latency(c_has_o, c_has_q, c_inputs);
      elsif (c_has_q = 1) then
         -- mux is based on Tristate buffers,
         -- and is therefore non-pipelined.
         latency := 1;
      else
         latency := 0;
      end if;

      return latency;
      
   end get_c_mux_bus_v5_0_max_latency;

-------------------------------------------------------------------------------
-- Function Name : get_c_mux_bus_v5_0_latencies
-------------------------------------------------------------------------------   
-- Purpose : Returns an array of integers, which indicate the latencies available
-- for a given implementation of the mux bus core.
-------------------------------------------------------------------------------   
-- Inputs:
-- c_has_o : Integer indicating the presence of a non-registered output
   -- 0 Port not present
   -- 1 Port present
-- c_has_q : Integer indicating the presence of a registered output
   -- 0 Port not present
   -- 1 Port present
--c_inputs : Integer representing the number of busses being multiplexed
   -- c_inputs minimum value is 2, maximum value is 32
--mux_type : Integer which represents how the mux bus has been constructed:
   --0 : LUT based mux bus
   --1 : BUFT based mux bus
-------------------------------------------------------------------------------   

   function get_c_mux_bus_v5_0_latencies (c_has_o, c_has_q, c_inputs, mux_type : integer) return latency_array_type is   

      constant LOGIC_MUX : integer := 0;
      constant BUFT_MUX  : integer := 1;

      variable latency_array : latency_array_type := (others => 0);
      
   begin
      if (mux_type = LOGIC_MUX) then
         -- Re-use mux bit getMuxBitLatencies function.
         for i in 0 to 2 loop
            latency_array(i) := get_c_mux_bit_v5_0_latencies(c_has_o, c_has_q, c_inputs)(i);
         end loop;  -- i
      elsif (c_has_q = 1) then
         -- mux is based on Tristate buffers,
         -- and is therefore non pipelined.
         latency_array(0) := 1;
      else
         latency_array(0) := 0;
      end if;

      return latency_array;
      
   end get_c_mux_bus_v5_0_latencies;

   -- end of mux bus functions.

   -- Addsub functions

-------------------------------------------------------------------------------
-- Function Name : get_c_addsub_v5_0_latency
-------------------------------------------------------------------------------   
-- Purpose : Returns an integer, which indicates the maximum latency for a
-- given implementation of the addsub core.
-------------------------------------------------------------------------------   
-- Inputs:
-- c_out_width : Integer which represents the width of the output port, carrying
-- the result of the addsub operation. (Represents IP parameter c_out_width)
-- c_has_q_ovfl : Boolean which indicates if overflow is required
   -- False: No overflow
   -- True: Overflow required (if present, this reduces latency by 1) 
-------------------------------------------------------------------------------   

   function get_c_addsub_v5_0_latency (c_out_width : integer; c_has_q_ovfl : boolean) return integer is

      variable latency     : integer := 0;
      constant MAX_LATENCY : integer := 64;
      
   begin
      if (c_has_q_ovfl) then
         if ((c_out_width  - 1) < MAX_LATENCY) then
            latency := c_out_width - 1;
         else
            latency := MAX_LATENCY;
         end if;
      else
         if (c_out_width  < MAX_LATENCY) then
            latency := c_out_width ;
         else
            latency := MAX_LATENCY;
         end if;
      end if;

      return latency;
      
   end get_c_addsub_v5_0_latency;

   -- end of Addsub functions

-- end of baseblox_v5_0 intelligent functions package.
   
end baseblox_v5_0_services;


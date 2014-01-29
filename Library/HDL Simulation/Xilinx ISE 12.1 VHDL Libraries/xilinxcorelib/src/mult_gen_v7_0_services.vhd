-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc., is distributed
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
--
-------------------------------------------------------------------------------
-- mult_gen_v7_0 Intelligent Functions Package
-------------------------------------------------------------------------------
-- The purpose of this package, is to make
-- 'intelligent' functions available to VHDL
-- and XCC developers, that used to be available
-- to JAVA developers alone.
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.parm_v7_0_services.all;
use XilinxCoreLib.ccm_v7_0_services.all;
use XilinxCoreLib.sqm_v7_0_services.all;

package mult_gen_v7_0_services is

   -- See below for a description of each function

   function get_mult_gen_v7_0_latency(c_a_width        : integer;
                                      c_b_width        : integer;
                                      c_b_type         : integer;
                                      c_has_a_signed   : integer;
                                      c_reg_a_b_inputs : integer;
                                      c_mem_type       : integer;
                                      c_pipeline       : integer;
                                      c_mult_type      : integer;
                                      c_has_loadb      : integer;
                                      c_baat           : integer;
                                      c_b_value        : string;
                                      c_a_type         : integer;
                                      c_has_swapb      : integer;
                                      c_sqm_type       : integer;
                                      c_has_aclr       : integer;
                                      c_has_sclr       : integer;
                                      c_has_ce         : integer;
                                      c_sync_enable    : integer;
                                      c_has_nd         : integer;
                                      c_has_q          : integer;
                                      bram_addr_width  : integer) return integer;

   function get_mult_gen_v7_0_latency_q(c_a_width        : integer;
                                      c_b_width        : integer;
                                      c_b_type         : integer;
                                      c_has_a_signed   : integer;
                                      c_reg_a_b_inputs : integer;
                                      c_mem_type       : integer;
                                      c_pipeline       : integer;
                                      c_mult_type      : integer;
                                      c_has_loadb      : integer;
                                      c_baat           : integer;
                                      c_b_value        : string;
                                      c_a_type         : integer;
                                      c_has_swapb      : integer;
                                      c_sqm_type       : integer;
                                      c_has_aclr       : integer;
                                      c_has_sclr       : integer;
                                      c_has_ce         : integer;
                                      c_sync_enable    : integer;
                                      c_has_nd         : integer;
                                      bram_addr_width  : integer;
                                      c_has_q          : integer) return integer;

    
    function get_mult_gen_v7_0_registers(c_a_width        : integer;
                                      c_b_width        : integer;
                                      c_b_type         : integer;
                                      c_has_a_signed   : integer;
                                      c_reg_a_b_inputs : integer;
                                      c_mem_type       : integer;
                                      c_pipeline       : integer;
                                      c_mult_type      : integer;
                                      c_has_loadb      : integer;
                                      c_baat           : integer;
                                      c_b_value        : string;
                                      c_a_type         : integer;
                                      c_has_swapb      : integer;
                                      c_sqm_type       : integer;
                                      c_has_aclr       : integer;
                                      c_has_sclr       : integer;
                                      c_has_ce         : integer;
                                      c_sync_enable    : integer;
                                      c_has_nd         : integer;
                                      c_has_q          : integer;
                                      bram_addr_width  : integer
                                      ) return integer;
    
end mult_gen_v7_0_services;

package body mult_gen_v7_0_services is

-------------------------------------------------------------------------------
-- Calls calc_latency function, which is defined within the sqm_pack_v7_0 package.
-- Inputs:

   function get_mult_gen_v7_0_latency(c_a_width        : integer;
                                      c_b_width        : integer;
                                      c_b_type         : integer;
                                      c_has_a_signed   : integer;
                                      c_reg_a_b_inputs : integer;
                                      c_mem_type       : integer;
                                      c_pipeline       : integer;
                                      c_mult_type      : integer;
                                      c_has_loadb      : integer;
                                      c_baat           : integer;
                                      c_b_value        : string;
                                      c_a_type         : integer;
                                      c_has_swapb      : integer;
                                      c_sqm_type       : integer;
                                      c_has_aclr       : integer;
                                      c_has_sclr       : integer;
                                      c_has_ce         : integer;
                                      c_sync_enable    : integer;
                                      c_has_nd         : integer;
                                      c_has_q          : integer;
                                      bram_addr_width  : integer
                                      ) return integer is

      variable latency       : integer;
      variable c_b_constant  : integer;

   begin

      if (c_has_loadb = 0) then
         c_b_constant := 1;
      else
         c_b_constant := 0;
      end if;

      if (c_baat = c_a_width) then
         -- non sqm multiplier
         if (c_mult_type < 2 or c_mult_type = 5) then
            -- parm_v7_0 based multiplier
            latency := get_parm_v7_0_latency(c_mult_type, c_a_width, c_a_type, c_b_width,
                                             c_b_type, c_reg_a_b_inputs, c_pipeline, 
                                             c_has_aclr, c_has_sclr, c_has_ce, 
                                             c_sync_enable, c_has_a_signed, c_has_nd, c_has_q);
         else
            --ccm_v7_0 based multiplier
            latency :=
               get_ccm_v7_0_latency(c_a_width, c_has_a_signed, c_a_type, c_reg_a_b_inputs,
                                    c_has_swapb, c_mem_type, bram_addr_width, c_pipeline,
                                    c_b_constant, c_b_type, c_b_value, c_b_width);
         end if;

      else
         --sqm based multiplier
         
         latency := get_sqm_v7_0_latency(c_reg_a_b_inputs, c_sqm_type, c_baat, c_mult_type,
                                         c_pipeline, c_a_width, c_has_a_signed, c_a_type,
                                         c_has_swapb, c_mem_type, bram_addr_width, c_b_width,
                                         c_has_loadb, c_b_type, c_has_aclr, 
                                         c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, c_b_value); 
             
      end if;

      return latency;

   end get_mult_gen_v7_0_latency;

   -- Calls calc_latency function, which is defined within the sqm_pack_v7_0 package.
   -- This function differs from the one above in that it has a c_has_q input. This 
   -- adds an extra cycle of latency if the output is registered.
-- Inputs:

   function get_mult_gen_v7_0_latency_q(c_a_width        : integer;
                                      c_b_width        : integer;
                                      c_b_type         : integer;
                                      c_has_a_signed   : integer;
                                      c_reg_a_b_inputs : integer;
                                      c_mem_type       : integer;
                                      c_pipeline       : integer;
                                      c_mult_type      : integer;
                                      c_has_loadb      : integer;
                                      c_baat           : integer;
                                      c_b_value        : string;
                                      c_a_type         : integer;
                                      c_has_swapb      : integer;
                                      c_sqm_type       : integer;
                                      c_has_aclr       : integer;
                                      c_has_sclr       : integer;
                                      c_has_ce         : integer;
                                      c_sync_enable    : integer;
                                      c_has_nd         : integer;
                                      bram_addr_width  : integer;
                                      c_has_q          : integer
                                      ) return integer is

      variable latency       : integer;
      variable c_b_constant  : integer;

   begin

      if (c_has_loadb = 0) then
         c_b_constant := 1;
      else
         c_b_constant := 0;
      end if;

      if (c_baat = c_a_width) then
         -- non sqm multiplier
         if (c_mult_type < 2 or c_mult_type = 5) then
            -- parm_v7_0 based multiplier
            latency := get_parm_v7_0_latency(c_mult_type, c_a_width, c_a_type, c_b_width,
                                             c_b_type, c_reg_a_b_inputs, c_pipeline, 
                                             c_has_aclr, c_has_sclr, c_has_ce, 
                                             c_sync_enable, c_has_a_signed, c_has_nd, c_has_q);
         else
            --ccm_v7_0 based multiplier
            latency :=
               get_ccm_v7_0_latency(c_a_width, c_has_a_signed, c_a_type, c_reg_a_b_inputs,
                                    c_has_swapb, c_mem_type, bram_addr_width, c_pipeline,
                                    c_b_constant, c_b_type, c_b_value, c_b_width);
         end if;

      else
         --sqm based multiplier
         
         latency := get_sqm_v7_0_latency(c_reg_a_b_inputs, c_sqm_type, c_baat, c_mult_type,
                                         c_pipeline, c_a_width, c_has_a_signed, c_a_type,
                                         c_has_swapb, c_mem_type, bram_addr_width, c_b_width,
                                         c_has_loadb, c_b_type, c_has_aclr, 
                                         c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, c_b_value); 
         
      end if;

      if c_has_q = 1 then
        latency := latency+1;
      end if;

      return latency;

   end get_mult_gen_v7_0_latency_q;
   
    
   -- Latency function for the behavioural model. This returns the number of register 
   -- levels in the design.
   function get_mult_gen_v7_0_registers(c_a_width        : integer;
                                      c_b_width        : integer;
                                      c_b_type         : integer;
                                      c_has_a_signed   : integer;
                                      c_reg_a_b_inputs : integer;
                                      c_mem_type       : integer;
                                      c_pipeline       : integer;
                                      c_mult_type      : integer;
                                      c_has_loadb      : integer;
                                      c_baat           : integer;
                                      c_b_value        : string;
                                      c_a_type         : integer;
                                      c_has_swapb      : integer;
                                      c_sqm_type       : integer;
                                      c_has_aclr       : integer;
                                      c_has_sclr       : integer;
                                      c_has_ce         : integer;
                                      c_sync_enable    : integer;
                                      c_has_nd         : integer;
                                      c_has_q          : integer;
                                      bram_addr_width  : integer
                                      ) return integer is

      variable latency       : integer;
      variable c_b_constant  : integer;
      variable sqm_serial     : integer;

   begin

      if (c_has_loadb = 0) then
         c_b_constant := 1;
      else
         c_b_constant := 0;
      end if;

      if (c_reg_a_b_inputs = 1 and c_sqm_type = 1) then
         sqm_serial := 1;
      else
         sqm_serial := 0;
      end if;
      
      if (c_baat = c_a_width) then
         -- non sqm multiplier
         if (c_mult_type < 2 or c_mult_type = 5) then
            -- parm_v7_0 based multiplier
            latency := get_parm_v7_0_latency(c_mult_type, c_a_width, c_a_type, c_b_width,
                                             c_b_type, c_reg_a_b_inputs, c_pipeline, 
                                             c_has_aclr, c_has_sclr, c_has_ce, 
                                             c_sync_enable, c_has_a_signed, c_has_nd, c_has_q);
         else
            --ccm_v7_0 based multiplier
            latency :=
               get_ccm_v7_0_latency(c_a_width, c_has_a_signed, c_a_type, c_reg_a_b_inputs,
                                    c_has_swapb, c_mem_type, bram_addr_width, c_pipeline,
                                    c_b_constant, c_b_type, c_b_value, c_b_width);
         end if;

      else
         --sqm based multiplier
         
         latency := get_sqm_v7_0_latency(c_reg_a_b_inputs, c_sqm_type, c_baat, c_mult_type,
                                         c_pipeline, c_a_width, c_has_a_signed, c_a_type,
                                         c_has_swapb, c_mem_type, bram_addr_width, c_b_width,
                                         c_has_loadb, c_b_type, c_has_aclr, 
                                         c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, c_b_value)
                                         - sqm_serial - calc_clocks(c_a_width, c_baat) - 1;
         
      end if;

      return latency;

   end get_mult_gen_v7_0_registers;


end mult_gen_v7_0_services;

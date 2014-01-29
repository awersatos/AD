-- Copyright(C) 2002 by Xilinx, Inc. All rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc., is distributed
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
--
-------------------------------------------------------------------------------
-- sqm_v6_0 Intelligent Functions Package
-------------------------------------------------------------------------------
-- The purpose of this package, is to make
-- 'intelligent' functions available to VHDL
-- and XCC developers, that used to be available
-- to JAVA developers alone.
-------------------------------------------------------------------------------

library XilinxCoreLib;
use XilinxCoreLib.parm_v6_0_services.all;
use XilinxCoreLib.ccm_v6_0_services.all;
use XilinxCoreLib.mult_const_pkg_v6_0.all;

package sqm_v6_0_services is

-------------------------------------------------------------------------------
-- The get_sqm_v6_0_latency is intended for external use.
-- It will report the number of clock cycles required to complete a particular
-- multiplication.
-------------------------------------------------------------------------------

   function get_sqm_v6_0_latency(c_reg_a_b_inputs : integer;
                                 c_sqm_type       : integer;
                                 c_baat           : integer;
                                 c_mult_type      : integer;
                                 c_pipeline       : integer;
                                 c_a_width        : integer;
                                 c_has_a_signed   : integer;
                                 c_a_type         : integer;
                                 c_has_swapb      : integer;
                                 c_mem_type       : integer;
                                 bram_addr_width  : integer;
                                 c_b_width        : integer;
                                 c_loadb          : integer;
                                 c_b_type         : integer;
                                 c_has_aclr       : integer;
                                 c_has_sclr       : integer;
                                 c_has_ce         : integer;
                                 c_sync_enable    : integer;
                                 c_has_nd         : integer;
                                 c_has_q          : integer;
                                 c_b_value        : string) return integer;
----------------------------------------------------------------------------
-- The following functions are intended for the exclusive use of the ccm core alone
----------------------------------------------------------------------------

   function calc_mult_latency(c_mult_type      : integer;
                              c_a_width        : integer;
                              c_has_a_signed   : integer;
                              c_a_type         : integer;
                              c_reg_a_b_inputs : integer;
                              c_has_swapb      : integer;
                              c_mem_type       : integer;
                              bram_addr_width  : integer;
                              c_pipeline       : integer;
                              c_b_width        : integer;
                              c_b_constant     : integer;
                              c_b_type         : integer;
                              c_has_aclr       : integer;
                              c_has_sclr       : integer;
                              c_has_ce         : integer;
                              c_sync_enable    : integer;
                              c_has_nd         : integer;
                              c_has_q          : integer;
                              c_b_value        : string) return integer;

   function calc_clocks(c_a_width, c_baat : integer) return integer;

   function sq_serial(c_baat, c_sqm_type : integer) return integer;

   function multooverriderequired(c_pipeline, c_mult_type, c_mem_type, bram_addr_width, c_baat, mult_has_a_signed, c_b_constant : integer) return integer;

end sqm_v6_0_services;

package body sqm_v6_0_services is

   function get_sqm_v6_0_latency(c_reg_a_b_inputs : integer;
                                 c_sqm_type       : integer;
                                 c_baat           : integer;
                                 c_mult_type      : integer;
                                 c_pipeline       : integer;
                                 c_a_width        : integer;
                                 c_has_a_signed   : integer;
                                 c_a_type         : integer;
                                 c_has_swapb      : integer;
                                 c_mem_type       : integer;
                                 bram_addr_width  : integer;
                                 c_b_width        : integer;
                                 c_loadb          : integer;
                                 c_b_type         : integer;
                                 c_has_aclr       : integer;
                                 c_has_sclr       : integer;
                                 c_has_ce         : integer;
                                 c_sync_enable    : integer;
                                 c_has_nd         : integer;
                                 c_has_q          : integer;
                                 c_b_value        : string) return integer is

      
      constant number_clocks       : integer := calc_clocks(c_a_width, c_baat);
      constant serial              : integer := sq_serial(c_baat, c_sqm_type);
      variable mult_has_a_signed   : integer := 0;
      variable mult_reg_a_b_inputs : integer := 0;

      variable multo_override : integer := 0;
      variable not_c_loadb    : integer := 1;

      variable mult_latency : integer := 0;

      variable latency : integer := 0;
      variable mult_a_type : integer := 0;
      
   begin

      if (c_a_type = 0) or (c_has_a_signed = 1) then
         mult_has_a_signed := 1;
         mult_a_type := 2;
      else
         mult_has_a_signed := 0;
         mult_a_type := c_a_type;
      end if;

      if (c_reg_a_b_inputs = 1) and (serial = 1) then
         mult_reg_a_b_inputs := 1;
      else
         mult_reg_a_b_inputs := 0;
      end if;

      if c_loadb = 0 then
         not_c_loadb := 1;
      else
         not_c_loadb := 0;
      end if;

      multo_override := multooverriderequired(c_pipeline, c_mult_type, c_mem_type, bram_addr_width, c_baat, mult_has_a_signed, not_c_loadb);

      mult_latency := calc_mult_latency(c_mult_type, c_baat, mult_has_a_signed, mult_a_type, mult_reg_a_b_inputs,
                                        c_has_swapb, c_mem_type, bram_addr_width, c_pipeline, c_b_width,
                                        not_c_loadb, c_b_type, c_has_aclr, c_has_sclr, c_has_ce, c_sync_enable, c_has_nd, c_has_q, c_b_value) + c_pipeline + multo_override;

      latency := c_reg_a_b_inputs + mult_latency + number_clocks + 1;

      if (not((c_mult_type = ccm or c_mult_type = STATIC_RCCM or c_mult_type = DYNAMIC_RCCM) and serial = 1)) then
         latency := latency + 1;
      end if;

      return latency;

   end get_sqm_v6_0_latency;

   function calc_mult_latency(c_mult_type      : integer;
                              c_a_width        : integer;
                              c_has_a_signed   : integer;
                              c_a_type         : integer;
                              c_reg_a_b_inputs : integer;
                              c_has_swapb      : integer;
                              c_mem_type       : integer;
                              bram_addr_width  : integer;
                              c_pipeline       : integer;
                              c_b_width        : integer;
                              c_b_constant     : integer;
                              c_b_type         : integer;
                              c_has_aclr       : integer;
                              c_has_sclr       : integer;
                              c_has_ce         : integer;
                              c_sync_enable    : integer;
                              c_has_nd         : integer;
                              c_has_q          : integer;
                              c_b_value        : string) return integer is

      variable latency : integer := 0;
      
   begin
      if (c_mult_type = ccm or c_mult_type = STATIC_RCCM or c_mult_type = DYNAMIC_RCCM) then

         -- get latency for ccm multiplier, from ccm services package

         latency := get_ccm_v6_0_latency(c_a_width, c_has_a_signed, c_a_type, c_reg_a_b_inputs,
                                         c_has_swapb, c_mem_type, bram_addr_width, c_pipeline,
                                         c_b_constant, c_b_type, c_b_value, c_b_width);

      elsif (c_mult_type = parallel or c_mult_type = v2_parallel) then

         -- get latency for parm multiplier from parm services package

         latency := get_parm_v6_0_latency(c_mult_type, c_a_width, c_a_type, c_b_width,
                                          c_b_type, c_reg_a_b_inputs, c_pipeline, c_has_aclr, c_has_sclr, c_has_ce, c_sync_enable, c_has_a_signed, c_has_nd, c_has_q);

      else latency := 0;
      end if;

      return latency;
      
   end calc_mult_latency;

   function calc_clocks(c_a_width, c_baat : integer) return integer is
      variable width  : integer := c_a_width;
      variable clocks : integer := 0;
   begin
      for i in 0 to c_a_width loop
         if (width > 0) then
            width  := width-c_baat;
            clocks := clocks+1;
         end if;
      end loop;
      return clocks;
   end calc_clocks;

   function sq_serial(c_baat, c_sqm_type : integer) return integer is
   begin
      if (c_sqm_type = 1 and c_baat = 1) then return 1;
      else return 0;
      end if;
   end sq_serial;

    function multooverriderequired(c_pipeline, c_mult_type, c_mem_type, bram_addr_width, c_baat, mult_has_a_signed, c_b_constant : integer) return integer is
      constant rom_addr_width : integer := get_rom_addr_width(c_mem_type, bram_addr_width);
      constant a_input_width  : integer := calc_a_input_width(c_baat, mult_has_a_signed, rom_addr_width, c_b_constant);
      constant number_of_pps  : integer := calc_num_pps(a_input_width, rom_addr_width);
   begin
      if (c_pipeline = 0 and (c_mult_type = CCM or c_mult_type = STATIC_RCCM or c_mult_type = DYNAMIC_RCCM) and c_mem_type /= c_distributed) then
         if (number_of_pps = 1) then return 1;
         else return 0;
         end if;
      else return 0;
      end if;
   end multooverriderequired;

end sqm_v6_0_services;

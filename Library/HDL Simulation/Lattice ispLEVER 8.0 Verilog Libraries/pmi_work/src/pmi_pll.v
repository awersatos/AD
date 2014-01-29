// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005-2008 by Lattice Semiconductor Corporation
// --------------------------------------------------------------------
//
//
//                     Lattice Semiconductor Corporation
//                     5555 NE Moore Court
//                     Hillsboro, OR 97214
//                     U.S.A.
//
//                     TEL: 1-800-Lattice  (USA and Canada)
//                          1-408-826-6000 (other locations)
//
//                     web: http://www.latticesemi.com/
//                     email: techsupport@latticesemi.com
//
// --------------------------------------------------------------------
//
// Simulation Library File for PLL PMI
//
// Parameter Definition
//Name                       Value                                     Default
/*
------------------------------------------------------------------------------
 pmi_freq_clki              <integer>                                     100
 pmi_freq_clkfb             <integer>                                     100
 pmi_freq_clkop             <integer>                                     100
 pmi_freq_clkos             <integer>                                     100
 pmi_freq_clkok             <integer>                                      50
 pmi_phase_adj              <integer>                                       0
 pmi_duty_cycle             <integer>                                      50
 pmi_clkfb_source    "INTERNAL"|"CLKOP"|"USERCLOCK"|"CLKOS"            "CLKOP"
 pmi_fdel                   "on"|"off"                                   "off"
 pmi_fdel_val               <integer>                                       0
 pmi_family  "EC"|"XP"|"XP2"|"SC"|"SCM"|"ECP"|"ECP2"|"ECP2M"|"XO"|"ECP3"  "EC"
------------------------------------------------------------------------------
WARNING: Do not change the default parameters in this model. Parameter 
redefinition must be done using defparam or in-line (#) paramater 
redefinition in a top level file that instantiates this model.
*/
// $Header:

`timescale  1 ns / 1 ps

module pmi_pll
 #(parameter pmi_freq_clki = 100,
   parameter pmi_freq_clkfb = 100,
   parameter pmi_freq_clkop = 100,
   parameter pmi_freq_clkos = 100,  // SC/SCM only
   parameter pmi_freq_clkok = 50,   // non-SC/SCM
   parameter pmi_family = "EC",
   parameter pmi_phase_adj = 0,   // in degrees, ex: 45, 90 etc.
   parameter pmi_duty_cycle = 50, // in percentage
   parameter pmi_clkfb_source = "CLKOP",
   parameter pmi_fdel = "off",     // ECP2 Only
   parameter pmi_fdel_val = 0,     // -8 to 8
   parameter module_type = "pmi_pll")

  (input       CLKI,
   input       CLKFB,
   input       RESET,
   output      CLKOP,
   output      CLKOS,
   output      CLKOK,
   output      CLKOK2,
   output      LOCK)/*synthesis syn_black_box*/;

//pragma translate_off
real pmi_freq_clki_reg, pmi_freq_clkfb_reg;
real pmi_freq_clkop_reg, pmi_freq_clkos_reg;
real pmi_freq_clkok_reg, pmi_phase_adj_reg;
real pmi_duty_cycle_reg, pmi_fdel_val_reg;
realtime t_clki, t_clkop, t_clkos, t_clkok, t_clkok2;
reg int_clk, CLKOP_REG, CLKOS_REG, CLKOK_REG, CLKOK2_REG;
reg first_time1, first_time2, first_time3, first_time4, vir_sclk, final_sclk;
reg CLKOP_NEW, CLKOS_NEW, CLKOK_NEW;

initial 
begin
pmi_freq_clki_reg = pmi_freq_clki;
pmi_freq_clkfb_reg = pmi_freq_clkfb;
pmi_freq_clkop_reg = pmi_freq_clkop;
pmi_freq_clkok_reg = pmi_freq_clkok;
pmi_phase_adj_reg = pmi_phase_adj;
pmi_fdel_val_reg = (0.13 * pmi_fdel_val);

int_clk = 1'b0;
CLKOP_REG = 1'b0;
CLKOS_REG = 1'b0;
CLKOK_REG = 1'b0;
CLKOK2_REG = 1'b0;
CLKOP_NEW = 1'b0;
CLKOS_NEW = 1'b0;
CLKOK_NEW = 1'b0;
first_time1 = 1'b1;
first_time2 = 1'b1;
first_time3 = 1'b1;
first_time4 = 1'b1;
vir_sclk = 1'b0;
final_sclk = 1'b0;

   t_clki = (1000 / pmi_freq_clki_reg);
   t_clkop = (1000 / pmi_freq_clkop_reg);
   t_clkok = (1000 / pmi_freq_clkok_reg);
   t_clkok2 = (t_clkop * 3);
end

initial
begin
   if (pmi_family == "SC" || pmi_family == "SCM")
   begin
      pmi_freq_clkos_reg = pmi_freq_clkos;
      pmi_duty_cycle_reg = 50.0;
   end
   else
   begin
      pmi_freq_clkos_reg = pmi_freq_clkop;
      pmi_duty_cycle_reg = pmi_duty_cycle;
   end
   t_clkos = (1000 / pmi_freq_clkos_reg);
end

//always @ (pmi_freq_clki_reg)
//begin
//   t_clki = (1000 / pmi_freq_clki_reg);
//end

//always @ (pmi_freq_clkop_reg)
//begin
//   t_clkop = (1000 / pmi_freq_clkop_reg);
//end

//always @ (pmi_freq_clkos_reg)
//begin
//   t_clkos = (1000 / pmi_freq_clkos_reg);
//end

//always @ (pmi_freq_clkok_reg)
//begin
//   t_clkok = (1000 / pmi_freq_clkok_reg);
//end

//always @ (t_clkok)
//begin
//   t_clkok2 = (t_clkop * 3);
//end

always @ (posedge RESET or posedge CLKI)
begin
   if (RESET == 1'b1)
      int_clk <= 1'b0;
   else if (int_clk == 1'b0)
      int_clk <= 1'b1;
end 

always @ (int_clk or CLKOP_REG)
begin
   if (int_clk == 1'b0)
   begin
      CLKOP_REG <= 1'b0;
      first_time1 <= 1'b1;
   end
   else 
   begin
      if (first_time1 == 1'b1)
      begin
         CLKOP_REG <= 1'b1;
         first_time1 <= 1'b0;
      end
      else
      begin
         CLKOP_REG <= #(t_clkop/2) ~CLKOP_REG;
      end
   end
end 
      
always @ (int_clk or CLKOS_REG)
begin
   if (int_clk == 1'b0)
   begin
      CLKOS_REG <= 1'b0;
      first_time2 <= 1'b1;
   end
   else
   begin
      if (first_time2 == 1'b1)
      begin
         CLKOS_REG <= 1'b1;
         first_time2 <= 1'b0;
      end
      else
      begin
         CLKOS_REG <= #(t_clkos/2) ~CLKOS_REG;
      end
   end
end

always @ (int_clk or CLKOK_REG)
begin
   if (int_clk == 1'b0)
   begin
      CLKOK_REG <= 1'b0;
      first_time3 <= 1'b1;
   end
   else
   begin
      if (first_time3 == 1'b1)
      begin
         CLKOK_REG <= 1'b1;
         first_time3 <= 1'b0;
      end
      else
      begin
         CLKOK_REG <= #(t_clkok/2) ~CLKOK_REG;
      end
   end
end

always @ (int_clk or CLKOK2_REG)
begin
   if (pmi_family == "XP2" || pmi_family == "ECP3")
   begin 
      if (int_clk == 1'b0)
      begin
         CLKOK2_REG <= 1'b0;
         first_time4 <= 1'b1;
      end
      else
      begin
         if (first_time4 == 1'b1)
         begin
            CLKOK2_REG <= 1'b1;
            first_time4 <= 1'b0;
         end
         else
         begin
            CLKOK2_REG <= #(t_clkok2/2) ~CLKOK2_REG;
         end
      end
   end
end

always @ (posedge CLKOS_REG)
begin
   vir_sclk <= 1'b1;
   #((pmi_duty_cycle_reg / 100) * t_clkos)
   vir_sclk <= 1'b0;
  end

  always @(vir_sclk)
  begin
     final_sclk <= #((pmi_phase_adj_reg / 360) * t_clkos) vir_sclk;
  end

always @ (CLKOP_REG)
begin
   if ((pmi_family == "ECP2" || pmi_family == "ECP2M") && pmi_fdel == "on")
   begin
      if (pmi_fdel_val_reg >= 0)
         CLKOP_NEW <= #(pmi_fdel_val_reg) CLKOP_REG;
      else
         CLKOP_NEW <= #(t_clki + pmi_fdel_val_reg) CLKOP_REG;
   end
   else
      CLKOP_NEW <= CLKOP_REG; 
end

always @ (final_sclk)
begin
   if ((pmi_family == "ECP2" || pmi_family == "ECP2M") && pmi_fdel == "on")
   begin
      if (pmi_fdel_val_reg >= 0)
         CLKOS_NEW <= #(pmi_fdel_val_reg) final_sclk;
      else
         CLKOS_NEW <= #(t_clki + pmi_fdel_val_reg) final_sclk;
   end
   else
      CLKOS_NEW <= final_sclk;
end

always @ (CLKOK_REG)
begin
   if ((pmi_family == "ECP2" || pmi_family == "ECP2M") && pmi_fdel == "on")
   begin
      if (pmi_fdel_val_reg >= 0)
         CLKOK_NEW <= #(pmi_fdel_val_reg) CLKOK_REG;
      else
         CLKOK_NEW <= #(t_clki + pmi_fdel_val_reg) CLKOK_REG;
   end
   else if (pmi_family == "SC" || pmi_family == "SCM")
      CLKOK_NEW <= 1'b0;
   else
      CLKOK_NEW <= CLKOK_REG;
end

assign CLKOP = CLKOP_NEW;
assign CLKOS = CLKOS_NEW;
assign CLKOK = CLKOK_NEW;
assign CLKOK2 = CLKOK2_REG;
assign LOCK = int_clk;
//pragma translate_on

endmodule


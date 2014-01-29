// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005 by Lattice Semiconductor Corporation
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
// Simulation Library File for XP2
//
// $Header: /home/rel01/env5_1b.2/verilog/pkg/versclibs/data/orca5mj/RCS/EHXPLLC.v,v 1.5 2005/06/29 20:57:26 pradeep Exp $ 
//
`celldefine
`timescale 1 ns / 10 fs

module EHXPLLE(RST, RSTK, CLKI, CLKFB, WRDEL,
   DRPAI3, DRPAI2, DRPAI1, DRPAI0, DFPAI3, DFPAI2, DFPAI1, DFPAI0,
   CLKOP, CLKOK, CLKOK2, CLKOS, LOCK, CLKINTFB);

parameter FIN = "100.0000";
parameter CLKFB_DIV = 1;
parameter CLKI_DIV = 1;
parameter CLKOP_DIV = 8;
parameter CLKOK_DIV = 2;
parameter PHASE_CNTL = "STATIC";
parameter PHASEADJ = "0.0";
parameter DUTY = 8;
parameter CLKOP_BYPASS = "DISABLED";
parameter CLKOS_BYPASS = "DISABLED";
parameter CLKOK_BYPASS = "DISABLED";
parameter CLKOP_TRIM_POL = "FALLING";
parameter CLKOP_TRIM_DELAY = 6;
parameter CLKOS_TRIM_POL = "RISING";
parameter CLKOS_TRIM_DELAY = 0;

//parameter LOCK_CYC   = 2;
parameter LOCK_DELAY = 100;

input  CLKI, CLKFB, RST, RSTK;
input  WRDEL;
input  DRPAI3, DRPAI2, DRPAI1, DRPAI0;
input  DFPAI3, DFPAI2, DFPAI1, DFPAI0;
output CLKOP, CLKOK, CLKOK2, CLKOS, LOCK, CLKINTFB;

reg false_clk, false_clkok;

reg clkop_first_time;
reg first_time1, first_time4;
reg first_time5, first_time6, first_time7;
reg false_clk_first_time, fb_first_time;

reg clock_valid, clock_invalid, out_clk_valid;

reg vir_sclk, vir_kclk, vir_k2clk, vir_lock, vir_pclk, vir_intfb;
reg final_sclk;

reg intfb_out, lock_all;

realtime next_clock_edge, last_clock_edge;
realtime next_clock_edge1, last_clock_edge1;
realtime t_in_clk, t_in_clk1, t_in_clk2, t_in_clk3;
realtime t_vco, ha_vco1, ha_vco, duty_vco1, duty_vco;
realtime t_fb_clk;
realtime first_int_edge, first_fb_edge;
realtime total_fb_delay, virtual_delay1;
realtime real_delay1, real_delay2, phase_delay, lock_delay_reg;
reg CLKOKREG, CLKOKREG1, CLKOK2REG, CLKOSREG, CLKOPREG, LOCKREG, CLKINTFBREG;
wire [3:0] DRPAI, DFPAI;
wire WRDELB;
wire CLKINB_DEL;
reg d_lock, d1_lock, d2_lock, d3_lock, d4_lock, LOCKREG1;

real ext_divider, net_divide;
real pll_dly_value;
integer    duty_i;
integer    phase_shift_value;
integer    phase_shift_value_static;

integer fb_count, index_clkos, index_clkop, index_clkok, index1, index2, ratio1;

//following variables are added to compensate vco rounding error
integer ha_vco_xprec;
realtime ha_vco_sim, round_err;
real index=0.0;

buf U1 (CLKOS, CLKOSREG);
buf U2 (CLKOP, CLKOPREG);
buf U3 (CLKOK, CLKOKREG);
buf U20 (CLKOK2, CLKOK2REG);
buf U4 (LOCK, LOCKREG1);
buf U5 (CLKINTFB, CLKINTFBREG);
buf U6 (CLKINB, CLKI);
buf U7 (FBB, CLKFB);
buf U18 (RSTB, RST);
buf U19 (RSTKB, RSTK);
buf U8 (DRPAI[3], DRPAI3);
buf U9 (DRPAI[2], DRPAI2);
buf U10 (DRPAI[1], DRPAI1);
buf U11 (DRPAI[0], DRPAI0);
buf U12 (DFPAI[3], DFPAI3);
buf U13 (DFPAI[2], DFPAI2);
buf U14 (DFPAI[1], DFPAI1);
buf U15 (DFPAI[0], DFPAI0);
buf U17 (WRDELB, WRDEL);

  initial
   begin
   clkop_first_time = 1'b1;
  end

initial
begin
d3_lock = 1'b1;
d2_lock = 1'b1;
d1_lock = 1'b1;
d_lock = 1'b1;
pll_dly_value = 0.0;
fb_count = 0;
first_time7 = 1;
//first_time2 = 1;
ratio1 = 0;
out_clk_valid = 0;
lock_all = 0;
vir_kclk = 0;
vir_k2clk = 0;
vir_lock = 0;
clock_valid = 0;
clock_invalid = 1;
final_sclk = 0;
vir_sclk = 0;
vir_intfb = 0;
vir_pclk = 0;
intfb_out = 0;
false_clk = 0;
CLKOSREG = 0;
CLKOPREG = 0;
CLKOKREG = 0;
CLKOKREG1 = 0;
CLKOK2REG = 0;
CLKINTFBREG = 0;
LOCKREG = 0;
LOCKREG1 = 0;
end
// Generate False Clocks
initial begin
 false_clk = 1'b0;
 forever #5 false_clk = ~false_clk;
end

// Measure input clock period

  initial begin
   lock_delay_reg = 1.0;
   last_clock_edge = 0.0;
   next_clock_edge = 0.0;
   t_in_clk = 0.0;
   t_in_clk1 = 0.0;
   t_in_clk2 = 0.0;
   t_in_clk3 = 0.0;
  end


always @(WRDELB)
begin
  if (WRDELB===1'b1)
    pll_dly_value = 0.07;
  else
    pll_dly_value = 0.0;
end


// phase_shift_value
initial
begin
  case (PHASEADJ)
          "22.5" :    phase_shift_value_static = 1;
     "45.0"   :    phase_shift_value_static = 2;
          "67.5" :    phase_shift_value_static = 3;
     "90.0"   :    phase_shift_value_static = 4;
          "112.5":    phase_shift_value_static = 5;
     "135.0"  :    phase_shift_value_static = 6;
          "157.5":    phase_shift_value_static = 7;
     "180.0"  :    phase_shift_value_static = 8;
          "202.5":    phase_shift_value_static = 9;
     "225.0"  :    phase_shift_value_static = 10;
          "247.5":    phase_shift_value_static = 11;
     "270.0"  :    phase_shift_value_static = 12;
          "292.5":    phase_shift_value_static = 13;
     "315.0"  :    phase_shift_value_static = 14;
          "337.5":    phase_shift_value_static = 15;
     default:    phase_shift_value_static = 0;
  endcase
end


//always @ (DPAMODE or DRPAI or DFPAI or phase_shift_value_static)
always @ (DRPAI or DFPAI or phase_shift_value_static)
begin
   if (PHASE_CNTL == "DYNAMIC")
   begin
         phase_shift_value = DRPAI;
         if (DFPAI > DRPAI)
         begin
            duty_i = DFPAI - DRPAI;
         end
         else if (DFPAI < DRPAI)
         begin
            duty_i = 16 + DFPAI - DRPAI;
         end
         else 
         begin
            duty_i = 8;
         end
   end
   else 
   begin
      phase_shift_value= phase_shift_value_static;
      duty_i = DUTY;
   end
end


always @(pll_dly_value or phase_shift_value or duty_i or posedge RSTB)
begin
   d_lock <= 1'b0;
end

always @(posedge CLKINB_DEL)
begin
   if (d_lock == 1'b0 && RSTB == 1'b0)
   begin
       d_lock <= 1'b1;
   end
end

always @(posedge CLKINB_DEL)
begin
       d1_lock <= d_lock;
end

always @(posedge CLKINB_DEL)
begin
       d3_lock <= d1_lock;
end

always @(d1_lock or d_lock)
begin
       d2_lock <= d_lock & d1_lock;
end

always @(d1_lock or d_lock or d3_lock)
begin
       d4_lock <= d_lock & d1_lock & d3_lock;
end

  assign CLKINB_DEL = CLKINB;
  assign FBB_DEL = FBB;

// Generate false clkok

  initial
   begin
    first_time1 = 1'b0;
    #1;
    first_time1 = 1'b1;
    index_clkok = 1'b0;
   end

  always @(false_clk)
   begin
    if (first_time1 == 1 && false_clk == 1)
      begin
      false_clkok = 1;
      first_time1 = 0;
      index_clkok = 0;
      end
    else
    index_clkok = index_clkok + 1;
    if (index_clkok == CLKOK_DIV)
      begin
      false_clkok = ~false_clkok;
      index_clkok = 0;
      end
   end

  always @(posedge FBB_DEL)
  begin
     fb_count = fb_count + 1;
     if (fb_count == 3)
        clkop_first_time = 1'b0;
  end

  always @(posedge CLKINB_DEL)
   begin
   last_clock_edge=next_clock_edge;
   next_clock_edge=$realtime;

    if (last_clock_edge > 0)
        begin
        t_in_clk <= next_clock_edge - last_clock_edge;
        t_in_clk1 <= t_in_clk;
        t_in_clk2 <= t_in_clk1;
        t_in_clk3 <= t_in_clk2;
        end
    if (t_in_clk > 0)
        begin
         if ( ((t_in_clk - t_in_clk1) < 0.0001) && ((t_in_clk - t_in_clk1) > -0.0001) && ((t_in_clk1 - t_in_clk2) < 0.0001) && ((t_in_clk1 - t_in_clk2) > -0.0001) && ((t_in_clk2 - t_in_clk3) < 0.0001) && ((t_in_clk2 - t_in_clk3) > -0.0001))
           clock_valid <= 1;
         else
           clock_valid <= 0;
        end

    if (t_in_clk > 0)
        begin
         if ( ((t_in_clk - t_in_clk1) < 0.0001) && ((t_in_clk - t_in_clk1) > -0.0001))
           clock_invalid <= 0;
         else
           clock_invalid <= 1;
        end

    if (t_in_clk > 0)
        begin
           net_divide = (CLKFB_DIV * ext_divider);
           t_vco = ((t_in_clk * CLKI_DIV) / net_divide);
           ha_vco1 = (t_vco / 2);
           duty_vco1 = ((t_vco * duty_i) / 16);
           ha_vco_xprec = ha_vco1 * 100000; //convert to time precision (multiply by 1ns/10fs), take integer value
           ha_vco_sim = ha_vco_xprec / 100000.0; //time as it appears in simulation (with precision error)
           round_err = ((t_in_clk - ((ha_vco_sim * 2 * net_divide) / CLKI_DIV)) / 2);
           phase_delay = ((t_vco * phase_shift_value) / 16);
           real_delay2 = phase_delay + pll_dly_value;
        end
   end

  always @(ha_vco1)
  begin
    if (PHASE_CNTL == "STATIC")
      ha_vco <= ha_vco1;
	 else
	 begin
	   if (CLKOP_TRIM_POL == "RISING")
        ha_vco <= ha_vco1 - (0.05*CLKOP_TRIM_DELAY);
	   else
        ha_vco <= ha_vco1 + (0.05*CLKOP_TRIM_DELAY);
	 end
  end

  always @(duty_vco1)
  begin
    if (PHASE_CNTL == "STATIC")
      duty_vco <= duty_vco1;
	 else
	 begin
	   if (CLKOS_TRIM_POL == "RISING")
        duty_vco <= duty_vco1 - (0.05*CLKOS_TRIM_DELAY);
	   else
        duty_vco <= duty_vco1 + (0.05*CLKOS_TRIM_DELAY);
	 end
  end

  always @(duty_vco)
   begin
	  if (clock_valid == 1)
	  begin
      if (duty_vco < 1 )
         $display ("WARNING : Pulse width of CLKOS is less than 1 ns, which is illegal!");
      else if ((t_vco - duty_vco) < 1 )
         $display ("WARNING : Pulse width of CLKOS is less than 1 ns, which is illegal!");
	  end
   end

// Measure Feedback Clock Period

  initial begin
   last_clock_edge1 = 0.0;
   next_clock_edge1 = 0.0;
   first_time5 = 1'b1;
  end

  always @(posedge FBB_DEL)
   begin
    last_clock_edge1=next_clock_edge1;
    next_clock_edge1=$realtime;

     if (last_clock_edge1 > 0)
      begin
       if (first_time5 == 1)
       t_fb_clk = next_clock_edge1 - last_clock_edge1;
       first_time5 = 0;
      end

     if (t_fb_clk > 0)
     begin
        ext_divider = t_fb_clk / 10 ;
     end
   end

// Measure the feedback delay value

  initial
   begin
   first_int_edge = 0.0;
   first_fb_edge = 0.0;
   virtual_delay1 = 0.0;
    false_clk_first_time = 1'b0;
    fb_first_time = 1'b0;
    #1;
    false_clk_first_time = 1'b1;
    fb_first_time = 1'b1;
   end


always @(posedge false_clk)
  begin
  if (false_clk_first_time == 1)
  first_int_edge=$realtime;
  false_clk_first_time = 1'b0;
  end

always @(posedge FBB_DEL)
  begin
  if (fb_first_time == 1)
  first_fb_edge=$realtime;
  fb_first_time = 1'b0;
  end

always @(FBB_DEL or CLKINB_DEL)
  begin
     total_fb_delay = first_fb_edge - first_int_edge;

  if ( (total_fb_delay > 0) && (t_in_clk > 0) )
  begin
     ratio1 = total_fb_delay / t_in_clk;
     virtual_delay1 = total_fb_delay - (t_in_clk * ratio1);
     real_delay1 = t_in_clk - virtual_delay1;
  end
end


  always @(posedge CLKINB_DEL or posedge RSTB or negedge d_lock)
  begin
     if (RSTB == 1'b1 || d_lock == 1'b0)
        out_clk_valid <= 1'b0;
     else
        out_clk_valid <= clock_valid;
  end

// Generate all CLOCKs in DELAY MODE
// P8  oscillator clock

  always @(out_clk_valid or intfb_out)
  begin
     if (out_clk_valid == 1'b0)
     begin
        intfb_out <= 1'b0;
        first_time7 <= 1'b1;
        index = 0.0;
     end
     else
     begin
        if (first_time7 == 1'b1)
        begin
           intfb_out <= 1'b1;
           first_time7 <= 1'b0;
           index = 0.0;
        end
        else
        begin
           index = index + 1.0;
           if (index == net_divide)
           begin
              intfb_out <= #(ha_vco1 + round_err) ~intfb_out;
              index = 0.0;
           end
           else
              intfb_out <= #ha_vco1 ~intfb_out;
        end
     end
  end


// P11 internal feedback clockout

  always @(intfb_out)
  begin
      vir_intfb <= #real_delay1 intfb_out;
  end

  always @(d2_lock)
  begin
     if (d2_lock == 1'b0)
     begin
        assign vir_kclk = 1'b0;
		  assign vir_k2clk = 1'b0;
        assign vir_pclk = 1'b0;
		  assign vir_intfb = 1'b0;
        assign first_time6 = 1'b1;
		  assign first_time4 = 1'b1;
        assign vir_sclk = 1'b0;
        assign final_sclk = 1'b0;
     end
     else
     begin
        deassign vir_kclk;
		  deassign vir_k2clk;
        deassign vir_pclk;
		  deassign vir_intfb;
        deassign first_time6;
		  deassign first_time4;
        deassign vir_sclk;
        deassign final_sclk;
     end
  end


  always @(posedge vir_intfb)
  begin
     vir_pclk <= 1'b1;
     #ha_vco
     vir_pclk <= 1'b0;
  end


  always @(intfb_out)
  begin
     if (out_clk_valid == 1'b0)
        vir_lock <= 1'b0;
     else if (out_clk_valid == 1'b1)
        vir_lock <= 1'b1;
  end

// P9
  initial begin
   first_time6 = 1'b1;
   index1 = 1'b0;
  end

  always @(vir_pclk)
   begin
    if (first_time6 == 1)
     begin
       if (vir_pclk == 1)
        begin
        vir_kclk <= 1;
        first_time6 = 0;
        index1 = 0;
        end //vir_pclk
     end
   else
     begin
     index1 = index1+1;
       if (index1 == CLKOK_DIV)
        begin
        vir_kclk <= ~vir_kclk;
        index1 = 0;
        end
     end
   end


// Generate LOCK signal

  always @(RSTB or vir_lock or clock_invalid or out_clk_valid)
   begin
    if (RSTB == 1)
     lock_all <= 0;
    else
    begin
     if (clock_invalid == 1)
      lock_all <= 0;
     else
      if (out_clk_valid == 1)
      lock_all <= #(LOCK_DELAY * lock_delay_reg) vir_lock;
    end
   end

  always @(posedge vir_intfb)
  begin
     vir_sclk <= 1'b1;
     #duty_vco
     vir_sclk <= 1'b0;
  end


  always @(vir_sclk)
  begin
     final_sclk <= #(real_delay2) vir_sclk;
  end


// CLKOK2 = CLKOP / 3

  initial begin
    first_time4 = 1'b1;
    index2 = 1'b0;
  end

  always @(CLKOPREG)
  begin
    if (first_time4 == 1)
    begin
      if (CLKOPREG == 1)
      begin
        vir_k2clk <= 1;
        first_time4 = 0;
        index2 = 0;
      end //CLKOPREG
    end
    else
    begin
      index2 = index2+1;
      if (index2 == 3)
      begin
        vir_k2clk <= ~vir_k2clk;
        index2 = 0;
      end
    end
  end


  always @ (CLKINB or out_clk_valid or vir_pclk or vir_intfb or lock_all or vir_kclk or vir_k2clk or
            final_sclk or false_clk or false_clkok or RSTB or clkop_first_time)
  begin
     if (CLKOP_BYPASS == "ENABLED")
     begin
        CLKOPREG <= CLKINB;
     end
     else if (clkop_first_time == 1'b1)
     begin
        CLKOPREG <= false_clk;
     end
     else if (RSTB == 1'b1)
     begin
        CLKOPREG <= 1'b0;
     end
     else if (out_clk_valid == 1'b1)
     begin
        CLKOPREG <= vir_pclk;
     end


     if (RSTB == 1'b1)
        CLKOK2REG <= 1'b0;
     else
        CLKOK2REG <= vir_k2clk;


     if (CLKOS_BYPASS == "ENABLED")
     begin
        CLKOSREG <= CLKINB;
     end
     else if (clkop_first_time == 1'b1)
     begin
        CLKOSREG <= false_clk;
     end
     else if (RSTB == 1'b1)
     begin
        CLKOSREG <= 1'b0;
     end
     else if (out_clk_valid == 1'b1)
     begin
        CLKOSREG <= final_sclk;
     end


     if (CLKOK_BYPASS == "ENABLED")
     begin
        CLKOKREG1 <= CLKINB;
     end
     else if (clkop_first_time == 1'b1)
     begin
        CLKOKREG1 <= false_clkok;
     end
     else if (RSTB == 1'b1)
     begin
        CLKOKREG1 <= 1'b0;
     end
     else if (out_clk_valid == 1'b1)
     begin
        CLKOKREG1 <= vir_kclk;
     end


     if (clkop_first_time == 1'b1)
     begin
        CLKINTFBREG <= false_clk;
        LOCKREG <= 1'b0;
     end        
     else if (RSTB == 1'b1)
     begin
        CLKINTFBREG <= 1'b0;
        LOCKREG <= 1'b0;
     end
     else if (out_clk_valid == 1'b1)
     begin
        CLKINTFBREG <= vir_intfb;
        LOCKREG <= lock_all;
     end
  end

  always@(CLKOKREG1 or posedge RSTKB)
  begin
     if (CLKOK_BYPASS == "ENABLED")
     begin
        CLKOKREG <= CLKOKREG1; 
     end
     else 
     begin
        if (clkop_first_time == 1'b1)
           CLKOKREG <= CLKOKREG1;
        else if (RSTKB == 1'b1)
           CLKOKREG <= 1'b0;
        else
           CLKOKREG <= CLKOKREG1;
     end
  end

  always@(LOCKREG or d4_lock)
  begin
     LOCKREG1 <= LOCKREG & d4_lock;
  end
        
endmodule
`endcelldefine

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
// Simulation Library File for EC/XP
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mj/RCS/EHXPLLC.v,v 1.5 2005/06/29 20:57:26 pradeep Exp $ 
//
`celldefine
`timescale 1 ns / 10 fs

module EHXPLLB(RST, CLKI, CLKFB, DDAMODE, DDAIZR, DDAILAG, DDAIDEL0, DDAIDEL1, DDAIDEL2,
   CLKOP, CLKOK, CLKOS, LOCK, DDAOZR, DDAOLAG, DDAODEL0, DDAODEL1, DDAODEL2);

parameter FIN = "100.0000";
parameter CLKFB_DIV = "1";
parameter CLKI_DIV = "1";
parameter CLKOP_DIV = "8";
parameter CLKOK_DIV = "2";
parameter DELAY_CNTL = "STATIC";
parameter FDEL = "0";
parameter WAKE_ON_LOCK = "ON";
parameter PHASEADJ = "0";             //0, 45, 90, 135, 180, 225, 270, 315
parameter DUTY = "4";
parameter FB_MODE = "CLOCKTREE";

parameter   LOCK_CYC   = 2;
parameter LOCK_DELAY = 100;

input CLKI, CLKFB, RST;
input DDAMODE, DDAIZR, DDAILAG;
input DDAIDEL0, DDAIDEL1, DDAIDEL2;

output CLKOP, CLKOK, CLKOS, LOCK;
output DDAOZR, DDAOLAG;
output DDAODEL0;
output DDAODEL1;
output DDAODEL2;

buf INST1 (DDAOZR, DDAIZR);
buf INST2 (DDAOLAG, DDAILAG);
buf INST3 (DDAODEL0, DDAIDEL0);
buf INST4 (DDAODEL1, DDAIDEL1);
buf INST5 (DDAODEL2, DDAIDEL2);

reg false_clk, false_clkok, false_clkok_int;
integer    PHASEADJ_REG;

reg clkop_first_time, clkos_first_time, clkok_first_time;
reg first_time1, first_time2, first_time3;
reg first_time5, first_time6, first_time7;
reg false_clk_first_time, fb_first_time;

reg false_clkos, false_clkop;

reg clock_valid, clock_invalid, g_reset, out_clk_valid;
wire set_resetn;

reg vir_sclk, vir_pclk, vir_kclk, vir_lock, vir_intfb, vir_intfb1;
reg final_sclk, final_pclk, final_lock, final_intfb;

reg clkfb_per_valid, intfb_out, lock_all;

realtime next_clock_edge, last_clock_edge;
realtime next_clock_edge1, last_clock_edge1;
realtime t_in_clk, t_in_clk1, t_in_clk2, t_in_clk3;
realtime t_vco, ha_vco, duty_vco;
realtime t_fb_clk, t_intfb_clock, ha_intfb_clk;
realtime false_t_int, false_t1_int, mclock_delay, mnclock_duty;
realtime first_int_edge, first_fb_edge;
realtime total_fb_delay, virtual_delay1;
realtime real_delay, real_delay1, real_delay2, lock_delay_reg;
reg CLKOKREG, CLKOSREG, CLKOPREG, LOCKREG;
wire DDAMODEB, DDAIZRB, DDAILAGB;
wire [2:0] DDA_DLY;
wire CLKINB_DEL;
reg d_lock, d1_lock, d2_lock, d3_lock, d4_lock, LOCKREG1;

real ext_divider, net_divide;
real pll_dly_re;
real pll_dly_step;
real pll_dly_steps;
real pll_dly_stepd;
real pll_dly_value;

integer fb_count, index_clkos, index_clkop, index_clkok, index1, index2, ratio1;

//following variables are added to compensate vco rounding error
integer ha_vco_xprec;
realtime ha_vco_sim, round_err;
real index=0.0;

buf U1 (CLKOS, CLKOSREG);
buf U2 (CLKOP, CLKOPREG);
buf U3 (CLKOK, CLKOKREG);
buf U4 (LOCK, LOCKREG1);
buf U6 (CLKINB, CLKI);
buf U7 (FBB, CLKFB);
buf U8 (RSTB, RST);

  initial
   begin
   clkop_first_time = 1'b1;
   clkos_first_time = 1'b1;
   clkok_first_time = 1'b1;
  end

initial
begin
  if (PHASEADJ == "0")
    PHASEADJ_REG = 0;
  else if (PHASEADJ == "45")
    PHASEADJ_REG = 1;
  else if (PHASEADJ == "90")
    PHASEADJ_REG = 2;
  else if (PHASEADJ == "135")
    PHASEADJ_REG = 3;
  else if (PHASEADJ == "180")
    PHASEADJ_REG = 4;
  else if (PHASEADJ == "225")
    PHASEADJ_REG = 5;
  else if (PHASEADJ == "270")
    PHASEADJ_REG = 6;
  else if (PHASEADJ == "315")
    PHASEADJ_REG = 7;
end

//***********************************************************************
// function convert_int and convert_real;
//***********************************************************************

function integer convert_int;
input [7:0] int_str;
  begin

    if (int_str == "9")
      convert_int = 9;
    else if (int_str == "8")
      convert_int = 8;
    else if (int_str == "7")
      convert_int = 7;
    else if (int_str == "6")
      convert_int = 6;
    else if (int_str == "5")
      convert_int = 5;
    else if (int_str == "4")
      convert_int = 4;
    else if (int_str == "3")
      convert_int = 3;
    else if (int_str == "2")
      convert_int = 2;
    else if (int_str == "1")
      convert_int = 1;
    else if (int_str == "0")
      convert_int = 0;
    else if (int_str == "-")
      convert_int = -1;
    else
      convert_int = 0;

  end
endfunction


// --------- for real number convertion function ------------
function real convert_real;
input [7:0] real_str;
  begin

    if (real_str == "9")
      convert_real = 9.0;
    else if (real_str == "8")
      convert_real = 8.0;
    else if (real_str == "7")
      convert_real = 7.0;
    else if (real_str == "6")
      convert_real = 6.0;
    else if (real_str == "5")
      convert_real = 5.0;
    else if (real_str == "4")
      convert_real = 4.0;
    else if (real_str == "3")
      convert_real = 3.0;
    else if (real_str == "2")
      convert_real = 2.0;
    else if (real_str == "1")
      convert_real = 1.0;
    else if (real_str == "0")
      convert_real = 0.0;
    else if (real_str == "-")
      convert_real = -1.0;
    else
      convert_real = 1.0;

  end
endfunction

reg [23:0] mult_r;
integer mult_i;
initial mult_r = CLKFB_DIV;
initial mult_i = 100* convert_int(mult_r[23:16]) + 10 * convert_int(mult_r[15:8]) + convert_int(mult_r[7:0]);

reg [23:0] div_r;
integer div_i;
initial div_r = CLKI_DIV;
initial div_i = 100* convert_int(div_r[23:16]) + 10 * convert_int(div_r[15:8]) + convert_int(div_r[7:0]);

reg [23:0] secdiv_r;
integer secdiv_i;
initial secdiv_r = CLKOK_DIV;
initial secdiv_i = 100* convert_int(secdiv_r[23:16]) + 10 * convert_int(secdiv_r[15:8]) + convert_int(secdiv_r[7:0]);

reg [23:0] post_r;
integer post_i;
initial post_r = CLKOP_DIV;
initial post_i = 100* convert_int(post_r[23:16]) + 10 * convert_int(post_r[15:8]) + convert_int(post_r[7:0]);

integer duty_i;
reg [7:0] duty_r;
initial duty_r = DUTY;
initial duty_i = convert_int(duty_r[7:0]);

reg [15:0] pll_dly_r;
real pll_dly_re_temp;
initial pll_dly_r = FDEL;
initial
      pll_dly_re_temp = convert_int(pll_dly_r[15:8]) * convert_int(pll_dly_r[7:0]) *0.25;

initial
begin
      if(pll_dly_re_temp >= 0)
         pll_dly_re = 0.25 * convert_int(pll_dly_r[7:0]);
      else
         pll_dly_re = pll_dly_re_temp;
end

initial pll_dly_steps = pll_dly_re/0.25;

initial
begin
d3_lock = 1'b1;
d2_lock = 1'b1;
d1_lock = 1'b1;
d_lock = 1'b1;
pll_dly_step = 0;
pll_dly_stepd = 0;
pll_dly_value = 0.0;
fb_count = 0;
first_time7 = 1;
first_time2 = 1;
ratio1 = 0;
out_clk_valid = 0;
lock_all = 0;
vir_kclk = 0;
vir_lock = 0;
clock_valid = 0;
clock_invalid = 1;
final_sclk = 0;
vir_sclk = 0;
vir_lock = 0;
vir_intfb1 = 0;
vir_intfb = 0;
clkfb_per_valid = 0;
intfb_out = 0;
false_clk = 0;
false_clkos = 0;
false_clkop = 0;
CLKOSREG = 0;
CLKOPREG = 0;
CLKOKREG = 0;
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

buf (DDAMODEB, DDAMODE);
buf (DDAIZRB, DDAIZR);
buf (DDAILAGB, DDAILAG);
buf (DDA_DLY[0], DDAIDEL0);
buf (DDA_DLY[1], DDAIDEL1);
buf (DDA_DLY[2], DDAIDEL2);

// pll_dly_stepd
always @(DDAMODEB or DDAIZRB or DDAILAGB or DDA_DLY)
begin
   if (DDAMODEB == 1'b0)
      pll_dly_stepd = pll_dly_re/0.25;
   else if (DDAMODEB == 1'b1)
      if (DDAIZRB == 1'b1)
         pll_dly_stepd = 0;
      else if (DDAIZRB == 1'b0)
         if (DDAILAGB == 1'b1)
             case(DDA_DLY)
                 3'b111    : pll_dly_stepd = -8;
                 3'b110    : pll_dly_stepd = -7;
                 3'b101    : pll_dly_stepd = -6;
                 3'b100    : pll_dly_stepd = -5;
                 3'b011    : pll_dly_stepd = -4;
                 3'b010    : pll_dly_stepd = -3;
                 3'b001    : pll_dly_stepd = -2;
                 3'b000    : pll_dly_stepd = -1;
             endcase
         else if (DDAILAGB == 1'b0)
             case(DDA_DLY)
                 3'b111    : pll_dly_stepd = 8;
                 3'b110    : pll_dly_stepd = 7;
                 3'b101    : pll_dly_stepd = 6;
                 3'b100    : pll_dly_stepd = 5;
                 3'b011    : pll_dly_stepd = 4;
                 3'b010    : pll_dly_stepd = 3;
                 3'b001    : pll_dly_stepd = 2;
                 3'b000    : pll_dly_stepd = 1;
             endcase
end

always @(pll_dly_stepd or pll_dly_steps)
begin
      if (DELAY_CNTL == "STATIC")
         pll_dly_step = pll_dly_steps;
      else if (DELAY_CNTL == "DYNAMIC")
      begin
         pll_dly_step = pll_dly_stepd;
      end
end

always @(pll_dly_step)
begin
 pll_dly_value = 0.25 * pll_dly_step;
end

always @(pll_dly_value or posedge RSTB)
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
    if (index_clkok == secdiv_i)
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
           net_divide = (mult_i * ext_divider);
           t_vco = ((t_in_clk * div_i) / net_divide);
           ha_vco = (t_vco / 2);
           duty_vco = ((t_vco * duty_i) / 8);
           ha_vco_xprec = ha_vco * 100000; //convert to time precision (multiply by 1ns/10fs), take integer value
           ha_vco_sim = ha_vco_xprec / 100000.0; //time as it appears in simulation (with precision error)
           round_err = ((t_in_clk - ((ha_vco_sim * 2 * net_divide) / div_i)) / 2);
           real_delay2 = ((t_vco * PHASEADJ_REG) / 8);
           real_delay = real_delay1 + real_delay2;
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

     if (last_clock_edge1 > 0)
      begin
       clkfb_per_valid=1;
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
               intfb_out <= #(ha_vco + round_err) ~intfb_out;
               index = 0.0;
            end
            else
               intfb_out <= #ha_vco ~intfb_out;
        end
     end
  end


// P11 internal feedback clockout

  always @(intfb_out)
  begin
      vir_intfb1 <= #real_delay1 intfb_out;
  end

  always @(d2_lock)
  begin
     if (d2_lock == 1'b0)
     begin
        assign vir_kclk = 1'b0;
        assign vir_intfb = 1'b0;
        assign first_time6 = 1'b1;
        assign vir_sclk = 1'b0;
        assign final_sclk = 1'b0;
     end
     else
     begin
        deassign vir_kclk;
        deassign vir_intfb;
        deassign first_time6;
        deassign vir_sclk;
        deassign final_sclk;
     end
  end

  always @(vir_intfb1)
  begin
     if (pll_dly_value >= 0)
         vir_intfb <= #(pll_dly_value) vir_intfb1;
     else
         vir_intfb <= #(t_in_clk + pll_dly_value) vir_intfb1;
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

  always @(vir_intfb)
   begin
    if (first_time6 == 1)
     begin
       if (vir_intfb == 1)
        begin
        vir_kclk <= 1;
        first_time6 = 0;
        index1 = 0;
        end //vir_intfb
     end
   else
     begin
     index1 = index1+1;
       if (index1 == secdiv_i)
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


  always @ (out_clk_valid or vir_intfb or lock_all or vir_kclk or final_sclk or false_clk or false_clkok or RSTB or clkop_first_time)
  begin
     if (clkop_first_time == 1'b1)
     begin
        CLKOPREG <= false_clk;
        CLKOSREG <= false_clk;
        CLKOKREG <= false_clkok;
        LOCKREG <= 1'b0;
     end        
     else if (RSTB == 1'b1)
     begin
        CLKOPREG <= 1'b0;
        CLKOSREG <= 1'b0;
        CLKOKREG <= 1'b0;
        LOCKREG <= 1'b0;
     end
     else if (out_clk_valid == 1'b1)
     begin
        CLKOPREG <= vir_intfb;
        CLKOSREG <= final_sclk;
        CLKOKREG <= vir_kclk;
        LOCKREG <= lock_all;
     end
  end

  always@(LOCKREG or d4_lock)
  begin
     LOCKREG1 <= LOCKREG & d4_lock;
  end
        
endmodule
`endcelldefine

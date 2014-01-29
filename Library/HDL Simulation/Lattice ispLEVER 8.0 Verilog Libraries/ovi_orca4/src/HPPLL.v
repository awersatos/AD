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
// Simulation Library File for ORCA4
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/HPPLL.v,v 1.8 2005/05/19 19:01:29 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module HPPLL (CLKIN, FB, MCLK, NCLK, LOCK, INTFB);

input CLKIN, FB;

output MCLK, NCLK, LOCK, INTFB;

parameter DIV0=1, DIV1=1, DIV2=1, DIV3=1, DISABLED_GSR=1,
          MCLKMODE="BYPASS", NCLKMODE="BYPASS", VCOTAP=4;

wire CLKINB, FBB, MCLK, NCLK, LOCK, INTFB;

reg MCLKREG, NCLKREG, LOCKREG, INTFBREG;

reg first_time, first_time2, first_time3, first_time4; 
reg first_time5, first_time6, first_time7, first_time8;
reg new_int_first_time, fb_first_time;

reg false_int, false_mck, false_nck, new_int;

reg clock_valid, clock_invalid, set_reset;

reg mn_duty_clk, duty_mnclk, pshift_mclk, duty_lock;

reg vir_mclk, vir_nclk, vir_lock, vir_intfb;
reg final_mclk, final_nclk, final_lock, final_intfb;

reg clkfb_per_valid, intfb_out, intfb_du_out, lock_all; 

realtime next_clock_edge, last_clock_edge;
realtime next_clock_edge1, last_clock_edge1;
realtime t_in_clk, t_in_clk1, t_in_clk2, t_in_clk3;
realtime t_vco, ha_vco;
realtime t_fb_clk, t_intfb_clock, ha_intfb_clk;
realtime false_t_int, false_t1_int, mclock_delay, mnclock_duty;
realtime first_int_edge, first_fb_edge;
realtime total_fb_delay, virtual_delay1;
realtime real_delay, real_delay1, real_delay2;

real ext_divider, net_divide;

reg  mn_duty_clk1;
integer index_mclk, index_nclk, index1, index2, ratio1;


  tri1 GSR = GSR_INST.GSRNET;
  tri1 PUR = PUR_INST.PURNET;

  always @ (GSR or PUR ) begin
    if (DISABLED_GSR == 0) begin
      set_reset = GSR & PUR ;
    end
    else if (DISABLED_GSR == 1)
      set_reset = PUR;
  end

buf U1 (MCLK, MCLKREG);
buf U2 (NCLK, NCLKREG);
buf U3 (LOCK, LOCKREG);
buf U4 ( INTFB, INTFBREG);
buf U5 (CLKINB, CLKIN);
buf U6 (FBB, FB);

// INITIALIZE all the internal signals to 0 at the start
// of the simulation cycle.

initial begin
lock_all = 0;
vir_lock = 0;
clock_valid = 0;
clock_invalid = 1;
final_lock = 0;
final_mclk = 0;
final_nclk = 0;
vir_mclk = 0;
vir_nclk = 0;
vir_lock = 0;
vir_intfb = 0;
clkfb_per_valid = 0;
duty_lock = 0;
mn_duty_clk = 0;
duty_mnclk = 0;
intfb_out = 0;
intfb_du_out = 0;
false_mck = 0;
false_nck = 0;
false_int = 0;
MCLKREG = 0;
NCLKREG = 0;
INTFBREG = 0;
LOCKREG = 0;
end

// Generate False Clocks

  initial
   begin
    first_time = 1'b0;
    #1;
    first_time = 1'b1;
    false_int = 1'b0;
   end

  always @(first_time) 
   begin
   if (first_time == 1'b1)
     forever begin
     #5 false_int = ~false_int;
   end
   else
     forever begin
     #5 false_int = ~false_int;
     end 
   end	

// Generate false mclk and false nclk

  initial 
   begin
    first_time2 = 1'b0;
    #1;
    first_time2 = 1'b1;
    index_mclk = 1'b0;
   end

  always @(false_int) 
   begin
    if (first_time2 == 1 && false_int == 1)
      begin
      false_mck = 1;
      first_time2 = 0;
      index_mclk =0;
      end 
    else
    index_mclk = index_mclk + 1;
    if (index_mclk == DIV2)
      begin
      false_mck = ~false_mck;
      index_mclk = 0;
      end
   end


// P3

  initial 
   begin
    first_time3 = 1'b0;
    #1;
    first_time3 = 1'b1;
    index_nclk = 1'b0;
   end

  always @(false_int) 
   begin
    if (first_time3 == 1 && false_int == 1)
      begin
      false_nck = 1;
      first_time3 = 0;
      index_nclk=0;
      end
    else
    index_nclk = index_nclk + 1;
    if (index_nclk == DIV3)
      begin
      false_nck = ~false_nck;
      index_nclk = 0;
      end
   end

// P4 

  always @(set_reset or false_int) 
   begin
    if (set_reset == 0)
      begin
      new_int=0;
      end
    else if (first_time == 1 && false_int == 1)
      begin
      new_int = 1;
      first_time = 0;
      end
    else 
    new_int = false_int;
   end
  

// Measure input clock period

  initial begin
   last_clock_edge = 0.0;
   next_clock_edge = 0.0;
   t_in_clk = 0.0;
   t_in_clk1 = 0.0;
   t_in_clk2 = 0.0;
   t_in_clk3 = 0.0;

  end

  always @(posedge CLKINB)
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
	 if (t_in_clk == t_in_clk3)
	 clock_valid <= 1;
//         else
//         clock_valid <= 0;
        end

    if (t_in_clk > 0) 
        begin
	 if (t_in_clk == t_in_clk1)
         clock_invalid <= 0;
//         else
//         clock_invalid <= 1;
        end


    if (t_in_clk > 0) 
        begin
        t_vco = ((t_in_clk * DIV0) / DIV1);
        ha_vco = (t_vco / 2 );
        real_delay2 = ((t_in_clk * VCOTAP) / 8);
        real_delay = real_delay1 + real_delay2;
        end                
   end


// Measure Feedback Clock Period

  initial begin
   last_clock_edge1 = 0.0;
   next_clock_edge1 = 0.0;
   false_t1_int = 5.0;
   first_time5 = 1'b1;
   //#1;
   //first_time5 = 1'b1;
  end

  always @(posedge FBB)
   begin
    last_clock_edge1=next_clock_edge1;
    next_clock_edge1=$realtime;

     if (last_clock_edge1 > 0) 
      begin
       if (first_time5 == 1)
       t_fb_clk = next_clock_edge1 - last_clock_edge1;
       first_time5 = 0;
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
    new_int_first_time = 1'b0;
    fb_first_time = 1'b0;
    #1;
    new_int_first_time = 1'b1;
    fb_first_time = 1'b1;
   end

always @(posedge false_int)
  begin
  if (new_int_first_time == 1)
  first_int_edge=$realtime;
  new_int_first_time = 1'b0; 
  end

always @(posedge FBB)
  begin
  if (fb_first_time == 1)
  first_fb_edge=$realtime;
  fb_first_time = 1'b0;
  end

always @(FBB)
  begin
  total_fb_delay = first_fb_edge - first_int_edge;
//  end

if ( (total_fb_delay > 0) && (t_in_clk > 0) )
   begin
   ratio1 = total_fb_delay / t_in_clk;
   virtual_delay1 = total_fb_delay - (t_in_clk * ratio1);
   real_delay1 = t_in_clk - virtual_delay1 ; 
   end
end


// Assume Internal dedicated feedback
// Generate internal-feedback clock period

  always @(INTFB)
   begin
    false_t_int = (2 * false_t1_int);

    if (false_t_int > 0)
     begin
     ext_divider = t_fb_clk/false_t_int;
     net_divide = (DIV1 * ext_divider);
     end

    if (net_divide >0)
     begin
     t_intfb_clock = ((t_in_clk * DIV0) / (net_divide));
     ha_intfb_clk = t_intfb_clock / 2;
     end
   end

// Generate all CLOCKs in DELAY MODE
// P8

  initial begin
   first_time4 = 1'b0;
   #1;
   first_time4 = 1'b1;
  end

  always @(first_time4) 
   begin
    if (MCLKMODE == "DELAY" && NCLKMODE == "DELAY")
      begin
       if (first_time4 == 1)
        begin
        wait (clock_valid == 1) intfb_out <= 1;
	first_time4 <= 0;
	end
       else 
       if (clock_valid == 1)
         forever begin
         #ha_intfb_clk intfb_out = ~intfb_out;
         end
      end
   end
	

// P11

  always begin
   @(intfb_out)
   begin
   if (set_reset == 1)
     begin
     vir_intfb <= #real_delay intfb_out;
     end
   else
     begin
     vir_intfb <= 0;
     end
   end
  end

// P9
  initial begin
   first_time6 = 1'b1;
   index1 = 1'b0;
   index2 = 1'b0;
  end

  always @(vir_intfb) 
   begin
    if (first_time6 == 1)
     begin
       if (vir_intfb == 1)
  	begin
  	vir_mclk <= 1;
  	vir_nclk <= 1;
  	vir_lock <= 1;
  	first_time6 = 0;
  	index1 = 0;
  	index2 = 0;  
  	end //vir_intfb
     end
    else
     begin
     index1 = index1+1;
     index2 = index2+1;
       if (index1 == DIV2)
        begin
        vir_mclk <= ~vir_mclk;
        index1 = 0;
        end

     if (index2 == DIV3)
       begin
       vir_nclk <= ~vir_nclk;
       index2 = 0;
       end

     end
   end


// Generate all CLOCKs in DUTYCYCLE and PHSHIFT MODE
// P12

  initial begin
   first_time7 = 1'b0;
   #1;
   first_time7 = 1'b1;
  end

  always @(first_time7) 
   begin
   if (first_time7 == 1'b1)
    begin
     wait (clock_valid == 1) intfb_du_out <= 1;
     mn_duty_clk <= 1;
     first_time7 <= 0;
    end
   else
    if (clock_valid == 1) 
     forever begin
     #ha_vco intfb_du_out <= ~intfb_du_out;
     mn_duty_clk <= ~mn_duty_clk;
     end 
   end

  always @(mn_duty_clk)
  begin
     mn_duty_clk1 <= #real_delay1 mn_duty_clk;
  end


// Generate LOCK signal

  always @(set_reset or vir_lock or clock_invalid or clock_valid) 
   begin
    if (set_reset == 0) 
     lock_all <= 0;
    else
     if (clock_invalid == 1)
      lock_all <= 0;
     else
      if (clock_valid == 1)
      lock_all <= vir_lock;
   end
     
// Calculate DUTYCYCLE values and create clocks

  always @(posedge mn_duty_clk1) 
   begin
    if (VCOTAP > 0) 
     begin
     mnclock_duty = ((t_vco * VCOTAP) / 8);
     end

    if (mnclock_duty > 0) 
     begin
     duty_lock <= 1;
     duty_mnclk <= 1;
     duty_mnclk <= #mnclock_duty 0;
     end
   end


// Calculate DELAY values and create clocks
//Phaseshift

  always @(mn_duty_clk1)
   begin
    mclock_delay = ((t_vco * VCOTAP) / 8);
    pshift_mclk <= #mclock_delay mn_duty_clk1;
   end


// Select clocks with appropriate modes

//PHSHIFT Mode

  always @(pshift_mclk) 
   begin
   if (MCLKMODE == "PHSHIFT" && NCLKMODE == "PHSHIFT") 
    begin
    final_mclk <= pshift_mclk;
    end
   end

  always @(mn_duty_clk1) 
   begin
   if (MCLKMODE == "PHSHIFT" && NCLKMODE == "PHSHIFT") 
    begin
    final_nclk <= mn_duty_clk1;
    end
   end

  always @(duty_lock)
   begin
   if (MCLKMODE == "PHSHIFT" && NCLKMODE == "PHSHIFT")
    begin
    final_lock <= duty_lock;
    end
   end

  always @(intfb_du_out) 
   begin
   if (MCLKMODE == "PHSHIFT" && NCLKMODE == "PHSHIFT") 
    begin
    final_intfb <= intfb_du_out;
    end
   end

//BYPASS Mode

  always @(CLKINB) 
   begin
   if (MCLKMODE == "BYPASS" && NCLKMODE == "BYPASS") 
    begin
    //final_mclk <= CLKIN;
    //final_nclk <= CLKIN;
    MCLKREG <= CLKINB;
    NCLKREG <= CLKINB;
    INTFBREG <= CLKINB;
    LOCKREG <= 1;
    end
   end

// DELAY Mode 

  always @(vir_mclk) 
   begin
   if (MCLKMODE == "DELAY" && NCLKMODE == "DELAY")
    final_mclk <= vir_mclk;
   end

  always @(vir_nclk) 
   begin
   if (MCLKMODE == "DELAY" && NCLKMODE == "DELAY") 
    final_nclk <= vir_nclk;
   end

  always @(vir_intfb) 
   begin
   if (MCLKMODE == "DELAY" && NCLKMODE == "DELAY") 
    final_intfb <= vir_intfb;
   end

  always @(lock_all) 
   begin
   if (MCLKMODE == "DELAY" && NCLKMODE == "DELAY")
    final_lock = lock_all;
   end


// Duty Mode

  always @(duty_mnclk) 
   begin
    if (MCLKMODE == "DUTYCYCLE" && NCLKMODE == "DUTYCYCLE")
    begin
    final_mclk <= duty_mnclk;
    final_nclk <= duty_mnclk;
    end
   end

  always @(duty_lock)
   begin
    if (MCLKMODE == "DUTYCYCLE" && NCLKMODE == "DUTYCYCLE")
    final_lock <= duty_lock;
   end

  always @(intfb_du_out) 
   begin
    if (MCLKMODE == "DUTYCYCLE" && NCLKMODE == "DUTYCYCLE")
    final_intfb <= intfb_du_out;
   end 

  always @(duty_mnclk) 
   begin
    if (MCLKMODE == "DUTYCYCLE" && NCLKMODE == "DUTYCYCLE")
    final_mclk <= duty_mnclk;
   end


// Functionality Section

  initial begin
   first_time8=1'b0;
   #1;
   first_time8=1'b1;
  end 

  always @(first_time8 or set_reset) 
   begin
   if (first_time8 == 1'b1)
    begin
     if (set_reset == 0)
      begin
      MCLKREG = 0;
      NCLKREG = 0;
      LOCKREG = 0;
      INTFBREG = 0;
      end
    end
   end
/*
  always begin
   @(final_mclk)
    if (set_reset == 1 && clock_valid == 1)
    MCLKREG <= final_mclk;
  end

  always begin
   @(final_nclk)
    if (set_reset == 1 && clock_valid == 1)
    NCLKREG <= final_nclk;
  end

  always begin
   @(final_intfb)
    if (set_reset == 1 && clock_valid == 1)
    INTFBREG <= final_intfb;
  end
*/

  always begin
   @(false_mck or final_mclk or false_int)
    if (MCLKMODE == "DELAY" && NCLKMODE == "DELAY") 
     begin
      if (set_reset == 1 && clock_valid == 0) 
      MCLKREG <= false_mck;
      else if (set_reset == 1 && clock_valid == 1)
      MCLKREG <= final_mclk;
     end
    else if ((MCLKMODE == "PHSHIFT" && NCLKMODE == "PHSHIFT") | (MCLKMODE == "DUTYCYCLE" && NCLKMODE == "DUTYCYCLE"))
    begin
      if (set_reset == 1 && clock_valid == 0)
         MCLKREG <= false_int;
      else if (set_reset == 1 && clock_valid == 1)
         MCLKREG <= final_mclk;
    end
  end

  always begin
   @(false_nck or final_nclk or false_int)
    if (MCLKMODE == "DELAY" && NCLKMODE == "DELAY" ) 
     begin
      if (set_reset == 1 && clock_valid == 0) 
      NCLKREG <= false_nck;
      else if (set_reset == 1 && clock_valid == 1)
      NCLKREG <= final_nclk;
    end
    else if ((MCLKMODE == "PHSHIFT" && NCLKMODE == "PHSHIFT") | (MCLKMODE == "DUTYCYCLE" && NCLKMODE == "DUTYCYCLE"))
    begin
      if (set_reset == 1 && clock_valid == 0)
         NCLKREG <= false_int;
      else if (set_reset == 1 && clock_valid == 1)
         NCLKREG <= final_nclk;
    end
  end

  always @(false_int or final_intfb or CLKINB)
  begin
     if (MCLKMODE == "BYPASS" && NCLKMODE == "BYPASS")
        INTFBREG <= CLKINB;
     else
     if (set_reset == 1 && clock_valid == 0)
     begin
        INTFBREG <= false_int;
     end
     else if (set_reset == 1 && clock_valid == 1)
     begin
        INTFBREG <= final_intfb;
     end
  end

  always begin
   @(final_lock or clock_valid)
    if (clock_valid == 1)
    begin
     if (MCLKMODE != "BYPASS" && NCLKMODE != "BYPASS")
    LOCKREG <= final_lock;
    end
  end


endmodule

`endcelldefine


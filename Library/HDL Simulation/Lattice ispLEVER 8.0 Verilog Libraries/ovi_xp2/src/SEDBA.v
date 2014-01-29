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
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module SEDBA (SEDENABLE, SEDSTART, SEDFRCERRN, SEDERR, SEDDONE, SEDINPROG, SEDCLKOUT);
  input SEDENABLE, SEDSTART, SEDFRCERRN;
  output SEDERR, SEDDONE, SEDINPROG, SEDCLKOUT;

  parameter  OSC_DIV = 1;
  parameter  CHECKALWAYS = "DISABLED";
  parameter  AUTORECONFIG = "OFF";
  parameter  MCCLK_FREQ = "2.5";
  parameter  DEV_DENSITY = "17K";
  parameter  BOOT_OPTION = "INTERNAL";

  reg SEDCLKOUTB, start, done, inprog, err;
  real  clk_freq;
  realtime  osc_half_clk;
  reg clkout;
  integer count, sed_count;

initial
  begin
     clkout = 1'b0;
     SEDCLKOUTB = 1'b0;
     start = 1'b0;
     done = 1'b0;
     inprog = 1'b0;
     err = 1'b0;
     count = 0;

     $sscanf(MCCLK_FREQ, "%f", clk_freq);
     osc_half_clk = (500 / (clk_freq / OSC_DIV));

     forever begin
        #osc_half_clk clkout = ~clkout;
     end

  end

initial
  begin
     if (DEV_DENSITY == "5K")
        sed_count = 1255853;
     else if (DEV_DENSITY == "8K")
        sed_count = 1985117;
     else if (DEV_DENSITY == "17K")
        sed_count = 3647629;
//        sed_count = 20;
     else if (DEV_DENSITY == "30K")
        sed_count = 5981341;
     else if (DEV_DENSITY == "50K")
        sed_count = 8323997;
end

always @(SEDENABLE or clkout)
begin
  if (SEDENABLE == 1'b1)
     SEDCLKOUTB <= clkout;
  else
     SEDCLKOUTB <=  1'b0;
end

always @(posedge clkout)
begin
  if (clkout == 1'b1)
  begin
     if (SEDSTART == 1'b1)
        start <= 1'b1;
     else if (done == 1'b1)
        start <=  1'b0;
  end
end

always @(posedge clkout or posedge done)
begin
  if (clkout == 1'b1)
  begin
     if (start == 1'b1)
        inprog <= 1'b1;
     else if (done == 1'b1)
        inprog <=  1'b0;
  end
end

always @(SEDFRCERRN or SEDENABLE)
begin
  if (SEDFRCERRN == 1'b0 && SEDENABLE == 1'b1)
     err <= #10 1'b1;
  else 
     err <=  1'b0;
end

always @(posedge clkout)
begin
  if (count < sed_count)
  begin
     if (start == 1'b1)
        count <= count + 1;
  end
  else if (count == sed_count)
  begin
     done <= 1'b1;
//     inprog <= 1'b0;
     count <= 0;
     start <= 1'b0;
  end
end

always @(posedge clkout)
begin
  if (done == 1'b1)
  begin
     done <=  1'b0;
  end
end

 
  buf (SEDERR, err);
  buf (SEDDONE, done);
  buf (SEDINPROG, inprog);
  buf (SEDCLKOUT, SEDCLKOUTB);

endmodule 

`endcelldefine

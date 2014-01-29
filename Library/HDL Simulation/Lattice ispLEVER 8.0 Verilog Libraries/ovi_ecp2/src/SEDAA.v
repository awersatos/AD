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
// Simulation Library File for ECP2
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module SEDAA (SEDENABLE, SEDSTART, SEDFRCERR, SEDERR, SEDDONE, SEDINPROG, SEDCLKOUT);
  input SEDENABLE, SEDSTART, SEDFRCERR;
  output SEDERR, SEDDONE, SEDINPROG, SEDCLKOUT;

  parameter  OSC_DIV = 1;
  parameter  CHECKALWAYS = "DISABLED";
  parameter  AUTORECONFIG = "OFF";
  parameter  MCCLK_FREQ = "2.5";
  parameter  DEV_DENSITY = "35K";
  parameter  ENCRYPTION = "OFF";

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
     if (DEV_DENSITY == "6K")
        sed_count = 1471389;
     else if (DEV_DENSITY == "12K")
        sed_count = 2825709;
     else if (DEV_DENSITY == "20K")
        sed_count = 4415517;
     else if (DEV_DENSITY == "35K")
        sed_count = 6358205;
//        sed_count = 20;
     else if (DEV_DENSITY == "50K")
        sed_count = 9064029;
     else if (DEV_DENSITY == "70K")
        sed_count = 13643549;
     else if (DEV_DENSITY == "M20K")
        sed_count = 6041309;
     else if (DEV_DENSITY == "M35K")
        sed_count = 10051613;
     else if (DEV_DENSITY == "M50K")
        sed_count = 16216589;
     else if (DEV_DENSITY == "M70K")
        sed_count = 20453501;
     else if (DEV_DENSITY == "M100K")
        sed_count = 26500445;
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

always @(SEDFRCERR or SEDENABLE)
begin
  if (SEDFRCERR == 1'b1 && SEDENABLE == 1'b1)
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

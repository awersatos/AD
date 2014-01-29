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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/DQSDLL.v,v 1.4 2005/05/19 20:08:32 pradeep Exp $ 
//

`celldefine 
`timescale 1 ns / 1 ps
module DQSDLL (CLK, RST, UDDCNTL, DQSDEL, LOCK);

parameter DEL_ADJ = "PLUS";
parameter DEL_VAL = "0";
parameter LOCK_SENSITIVITY = "LOW";

parameter   LOCK_CYC   = 2;

input  CLK, RST, UDDCNTL;
output LOCK, DQSDEL;

wire RST_int, UDDCNTL_int, UDDCNTL_buf;
reg  LOCK_int, DQSDEL_int;
wire clkin_in;

buf buf_clkin (clkin_in, CLK);
buf buf_rst  (RST_int, RST);
buf buf_uddcntl (UDDCNTL_buf, UDDCNTL);

buf buf_lock (LOCK, LOCK_int);
buf buf_dqsdel (DQSDEL, DQSDEL_int);

integer clk_rising_edge_count;

assign UDDCNTL_int = ~UDDCNTL_buf;

initial
begin
        clk_rising_edge_count = 0;
end

always @(posedge clkin_in or posedge RST_int) 
begin
   if (RST_int)
       clk_rising_edge_count = 0;
   else
       clk_rising_edge_count = clk_rising_edge_count + 1;
end

always @(clk_rising_edge_count or RST_int)
begin
    if (RST_int)
         LOCK_int = 1'b0;
    else if (clk_rising_edge_count > LOCK_CYC)
         LOCK_int = 1'b1;
end

always @(LOCK_int or UDDCNTL_int or RST_int)
begin
  if (RST_int)
      DQSDEL_int = 1'b0;
  else if (UDDCNTL_int == 1'b1)
      DQSDEL_int = LOCK_int;
  else
      DQSDEL_int = DQSDEL_int;
end

specify 
 
(CLK => LOCK) =  0:0:0, 0:0:0;
(CLK => DQSDEL) =  0:0:0, 0:0:0;
(RST => LOCK) =  0:0:0, 0:0:0;
(RST => DQSDEL) =  0:0:0, 0:0:0;
(UDDCNTL => LOCK) =  0:0:0, 0:0:0;
(UDDCNTL => DQSDEL) =  0:0:0, 0:0:0;
 
endspecify 

endmodule

`endcelldefine 

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
// Simulation Library File for SC
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/CLKDIV.v,v 1.8 2005/05/19 19:06:22 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module CLKDIV(CLKI, LSR, CLKO, ELSR);
   input CLKI, LSR;
   output CLKO, ELSR;
   parameter DIV = 1;
   parameter GSR = "ENABLED";

   wire CLKIB;

   reg SCKB, DIVCLK;
   reg [3:0]DIVREG;
   reg UPDATE_q0, UPDATE_q1, UPDATE_q2, UPDATE_q3;
   reg LSR_q0, LSR_q1, LSR_q2;
   reg SRN;

   buf (CLKIB, CLKI);

   buf (CLKO, SCKB);
   buf (ELSR, LSR_q2);

   function [2:0] check_value;
   input [2:0] Divisor;
   begin
      if(Divisor == 1 || Divisor == 2 || Divisor ==4)
         check_value = Divisor;
      else
      begin
         $display("ERROR: PLL - DIV <%d> is not valid", Divisor);
         $finish;
      end // if (Divisor != 1, 2 or 4)
   end
   endfunction // check_value
initial
begin
   DIVREG = check_value(DIV);
   UPDATE_q3 = 1'b0;
   UPDATE_q2 = 1'b0;
   UPDATE_q1 = 1'b0;
   UPDATE_q0 = 1'b0;
   LSR_q2 = 1'b1;
   LSR_q1 = 1'b1;
   LSR_q0 = 1'b1;
end

  tri1 GSR_sig = GSR_INST.GSRNET;
  tri1 PUR_sig = PUR_INST.PURNET;

  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED") begin
      SRN = GSR_sig & PUR_sig ;
    end
    else if (GSR == "DISABLED")
      SRN = PUR_sig;
  end

  not (SR1, SRN);
  or INST1 (SR, LSR, SR1);

always @ (posedge CLKIB)
begin
   if (ELSR == 1'b0)
   begin
      UPDATE_q3 <= UPDATE_q2;
      UPDATE_q2 <= UPDATE_q1;
      UPDATE_q1 <= UPDATE_q0;
      UPDATE_q0 <= UPDATE_q3;
   end
   else if (ELSR == 1'b1)
      if (DIVREG == 2)
      begin
         UPDATE_q3 <= 0;
         UPDATE_q2 <= 1;
         UPDATE_q1 <= 0;
         UPDATE_q0 <= 1;
      end
      else if (DIVREG == 4)
      begin
         UPDATE_q3 <= 1;
         UPDATE_q2 <= 1;
         UPDATE_q1 <= 0;
         UPDATE_q0 <= 0;
      end
   begin
   end
end

always @ (UPDATE_q3)
begin
   DIVCLK = UPDATE_q3;
end

always @ (CLKIB or DIVCLK)
begin
   SCKB = (DIVREG == 1) ? CLKIB : DIVCLK;
end

always @ (posedge CLKIB)
begin
   LSR_q0 <= SR;
   LSR_q1 <= LSR_q0;
   LSR_q2 <= LSR_q1;
end

endmodule

`endcelldefine

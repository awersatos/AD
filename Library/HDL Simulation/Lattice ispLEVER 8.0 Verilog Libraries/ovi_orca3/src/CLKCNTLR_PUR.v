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
// Simulation Library File for ORCA3
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/CLKCNTLR_PUR.v,v 1.6 2005/05/19 18:29:31 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

module CLKCNTLR_PUR (CLKIN, SHUTOFF, PUR, CLKOUT);
  input  CLKIN, SHUTOFF, PUR;
  output CLKOUT;
  reg SHUTOFFr, SHUTr, CLKOUTr;
  wire CLKINb, SHUTOFFb, PURb;
  
  assign CLKINb = CLKIN;
  assign SHUTOFFb = SHUTOFF;
  assign PURb = PUR;
  assign CLKOUT = CLKOUTr;

  initial
    begin
     SHUTOFFr=0;
     SHUTr=0;
    end

  always @ (PURb) begin
   if (PURb === 1'b0)
   begin
     SHUTOFFr = 1'b0;
     SHUTr = 1'b0;
   end
  end

  always @ (negedge CLKINb) begin
   if (PURb === 1'b1)
    begin
     SHUTOFFr = SHUTr;
     SHUTr = SHUTOFFb;
    end
  end

  always @ (CLKINb) begin
   if (SHUTOFFr === 1'b1)
       CLKOUTr = 0;
   else if (SHUTOFFr == 1'b0)
            CLKOUTr = CLKINb;
   else 
       CLKOUTr= 1'bx;  
  end  

endmodule 

`endcelldefine

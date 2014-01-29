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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/SPR16X2B.v,v 1.3 2005/05/19 20:09:00 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module SPR16X2B ( DI0, DI1, AD0, AD1, AD2, AD3, WRE, CK, DO0, DO1);
 
  input AD0, AD1, AD2, AD3, DI0, DI1, CK, WRE;
  output DO0, DO1;


  integer i,j;
  reg wre_reg;
  reg [1:0] din_reg;
  reg [3:0] wadr_reg;
  reg [3:0] radr_reg;
  reg [31:0] MEM;
  reg [1:0] DOb;

  buf  (AD0b, AD0);
  buf  (AD1b, AD1);
  buf  (AD2b, AD2);
  buf  (AD3b, AD3);
  buf  (DI0b, DI0);
  buf  (DI1b, DI1);
  buf  (CKb, CK);
  buf  (WREb, WRE);

  buf  (DO0, DOb[0]);
  buf  (DO1, DOb[1]);


   // Latch the address and data in for writing
   // Registers are rising edge enabled
  always @ (posedge CKb) begin
       wre_reg = WREb;
       din_reg = {DI1b, DI0b};
       wadr_reg = {AD3b, AD2b, AD1b, AD0b};
  end

// always @ (posedge CKb) begin
 always @ (din_reg,wadr_reg,wre_reg) begin
     if (wre_reg === 1'b1) begin
         for (i = 0; i < 2; i = i + 1)
          begin
          MEM[2*wadr_reg+i] = din_reg[i];
          end
     end
   end

  always @ (AD3b or AD2b or AD1b or AD0b) begin
     radr_reg = {AD3b, AD2b, AD1b, AD0b};
  end

  always @ (radr_reg or MEM)
  begin
         for (i = 0; i < 2; i = i + 1)
            DOb[i] = MEM[2*radr_reg+i];
  end

endmodule

`endcelldefine


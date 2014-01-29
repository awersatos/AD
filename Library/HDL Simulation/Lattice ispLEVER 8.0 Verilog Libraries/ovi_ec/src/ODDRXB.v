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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/ODDRXB.v,v 1.3 2005/05/19 20:08:52 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module ODDRXB(DA, DB, LSR, CLK,Q);
   input DA, DB, LSR, CLK;
   output Q;

   parameter REGSET  = "RESET";

   reg Q_b;
   reg QP, QN;
   wire QN_sig;
   reg last_CLK;

   wire DAb, DBb, LSRB, CLKB;

   buf (DAb, DA);
   buf (DBb, DB);
   buf (LSRB, LSR);
   buf (CLKB, CLK);

   assign QN_sig = Q_b; 

   buf (Q, QN_sig);

      function DataSame;
        input a, b;
        begin
          if (a === b)
            DataSame = a;
          else
            DataSame = 1'bx;
        end
      endfunction

initial
begin
last_CLK = 1'b0;
end

always @ (CLKB)
begin
   last_CLK <= CLKB;
end

always @ (CLKB)
begin
   if (CLKB === 1'bX)
   begin
      if (QN != DBb)
         QN <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b1 && last_CLK === 1'b0)
         begin
            if ((LSRB == 1'b1) && (REGSET == "RESET"))
               QN <= 1'b0;
            else if ((LSRB == 1'b1) && (REGSET == "SET"))
               QN <= 1'b1; 
            else
               QN <= DBb;
         end
   end
end

always @ (CLKB or DAb)
begin
   if (CLKB == 1'b0)
      QP <= DAb;
   else
      QP <= QP;
end

always @ (QP or QN or CLKB)
begin
   case (CLKB)
        1'b0 :  Q_b = QN;
        1'b1 :  Q_b = QP;
        default Q_b = DataSame(QN, QP);
   endcase
end

endmodule

`endcelldefine

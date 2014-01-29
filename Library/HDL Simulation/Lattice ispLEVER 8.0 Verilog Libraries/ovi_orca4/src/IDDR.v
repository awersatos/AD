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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/IDDR.v,v 1.2 2005/05/19 19:01:32 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module IDDR (D, CK, QP, QN);  

input  D, CK;
output QP, QN;
reg  QPB, QNB;

   buf (DB, D);
   buf (CKB, CK);
   buf (QN, QNB);
   buf (QP, QPB);

initial
begin
QPB = 1'b0;
QNB = 1'b0;
end

   always @ (posedge CKB) 
   begin
          QPB <= DB;
   end

   always @ (negedge CKB) 
   begin
          QNB <= DB;
   end


endmodule

`endcelldefine


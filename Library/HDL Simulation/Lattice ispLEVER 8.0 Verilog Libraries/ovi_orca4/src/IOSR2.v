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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/IOSR2.v,v 1.8 2005/05/19 19:01:39 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module IOSR2 (IND, OUTD0, OUTD1, CK, UPDATE, INQ0, INQ1, OUTQ);

input  IND, OUTD0, OUTD1, CK, UPDATE;
output INQ0, INQ1, OUTQ;
reg q0_int, q1_int; 
reg Q1B, Q2B; 
reg INQ0B, INQ1B, OUTQB, q1; 
reg UPDATEB_INT, update_q2, update_q1;

   buf (INDB, IND);
   buf (OUTD0B, OUTD0);
   buf (OUTD1B, OUTD1);
   buf (CKB, CK);
   buf (UPDATEB, UPDATE);
   buf (INQ0, INQ0B);
   buf (INQ1, INQ1B);
   buf (OUTQ, OUTQB);

   always @ (posedge CKB)
   begin
      if (UPDATEB === 1'b1) begin
         update_q2 <= 1'b1;
         update_q1 <= 1'b0;
      end
      else
      if (UPDATEB === 1'b0) begin
         update_q2 <= update_q1;
         update_q1 <= update_q2;
      end
   end //end of the always loop

   always @ (update_q2) begin
          UPDATEB_INT <= ~update_q2;
   end

   always @ (posedge CKB) 
   begin
          q1_int <= INDB;
          q0_int <= q1_int;
          OUTQB <= Q1B;
          q1 <= Q2B;
   end //end of the always loop

   always @ (posedge CKB) begin
      if (UPDATEB_INT === 1'b1) begin
          INQ1B = q1_int;
          INQ0B = q0_int;
      end
   end

   always @ (UPDATEB_INT or q1 or OUTD0B or OUTD1B) begin
      if (UPDATEB_INT === 1'b1) begin
          Q2B = OUTD1B;
          Q1B = OUTD0B;
      end
      else begin
          Q1B = q1;
      end
   end


endmodule

`endcelldefine


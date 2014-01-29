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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/IOSR4.v,v 1.8 2005/05/19 19:01:39 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module IOSR4 (IND, OUTD0, OUTD1, OUTD2, OUTD3, CK, UPDATE, INQ0, INQ1, INQ2, INQ3, OUTQ);

input  IND, OUTD0, OUTD1, OUTD2, OUTD3, CK, UPDATE;
output INQ0, INQ1, INQ2, INQ3, OUTQ;
reg q1, q2, q3; 
reg OUTQB, Q1B, Q2B, Q3B; 
reg INQ0B, INQ1B, INQ2B, INQ3B;
reg q0_int, q1_int, q2_int, q3_int;
reg UPDATEB_INT, update_q4, update_q3, update_q2, update_q1;

   buf (INDB, IND);
   buf (OUTD0B, OUTD0);
   buf (OUTD1B, OUTD1);
   buf (OUTD2B, OUTD2);
   buf (OUTD3B, OUTD3);
   buf (CKB, CK);
   buf (UPDATEB, UPDATE);
   buf (INQ0, INQ0B);
   buf (INQ1, INQ1B);
   buf (INQ2, INQ2B);
   buf (INQ3, INQ3B);
   buf (OUTQ, OUTQB);

   always @ (posedge CKB)
   begin
      if (UPDATEB === 1'b1) begin
         update_q4 <= 1'b1;
         update_q3 <= 1'b1;
         update_q2 <= 1'b1;
         update_q1 <= 1'b0;
      end
      else 
      if (UPDATEB === 1'b0) begin
         update_q4 <= update_q3;
         update_q3 <= update_q2;
         update_q2 <= update_q1;
         update_q1 <= update_q4;
      end
   end //end of the always loop

   always @ (update_q4) begin
          UPDATEB_INT <= ~update_q4;
   end
 
   always @ (posedge CKB) 
   begin
          q3_int <= INDB;
          q2_int <= q3_int;
          q1_int <= q2_int;
          q0_int <= q1_int;
          q3 <= OUTD3B;
          q2 <= Q3B;
          q1 <= Q2B;
          OUTQB <= Q1B;
   end //end of the always loop

   always @ (UPDATEB_INT or q1 or q2 or q3 or OUTD0B or OUTD1B or OUTD2B) begin
      if (UPDATEB_INT === 1'b1) begin
          Q3B <= OUTD2B;
          Q2B <= OUTD1B;
          Q1B <= OUTD0B;
      end
      else begin
          Q3B <= q3;
          Q2B <= q2;
          Q1B <= q1;
      end 
   end

   always @ (posedge CKB) begin
      if (UPDATEB_INT === 1'b1) begin
          INQ3B <= q3_int;
          INQ2B <= q2_int;
          INQ1B <= q1_int;
          INQ0B <= q0_int;
      end
   end


endmodule

`endcelldefine


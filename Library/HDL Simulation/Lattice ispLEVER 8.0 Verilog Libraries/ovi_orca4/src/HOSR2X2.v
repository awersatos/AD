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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/HOSR2X2.v,v 1.4 2005/05/19 19:01:29 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module HOSR2X2 (D10, D11, D20, D21, CK, UPDATE, Q1, Q2);

input  D10, D11, D20, D21, CK, UPDATE;
output Q1, Q2;
reg Q10, Q20, Q1B, Q2B; 
reg Q10_MUX, Q20_MUX; 
reg UPDATEB_INT, update_q2, update_q1;
wire CK_INT;

   buf (D10B, D10);
   buf (D11B, D11);
   buf (D20B, D20);
   buf (D21B, D21);
   buf (CKB, CK);
   buf (UPDATEB, UPDATE);
   buf (Q1, Q1B);
   buf (Q2, Q2B);

assign CK_INT = ~CKB;

   always @ (posedge CK_INT)
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

   always @ (posedge CK_INT) 
   begin
          Q1B <= Q10_MUX;
          Q10 <= D11B;
          Q2B <= Q20_MUX;
          Q20 <= D21B;
   end //end of the always loop

   always @ (UPDATEB_INT or Q10 or Q20 or D10B or D20B) begin
      if (UPDATEB_INT === 1'b1) begin
          Q10_MUX = D10B;
          Q20_MUX = D20B;
      end
      else 
      if (UPDATEB_INT === 1'b0) begin
          Q10_MUX = Q10;
          Q20_MUX = Q20;
      end
   end

endmodule

`endcelldefine


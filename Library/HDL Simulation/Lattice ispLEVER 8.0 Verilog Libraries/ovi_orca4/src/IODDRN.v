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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/IODDRN.v,v 1.2 2005/05/19 19:01:39 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module IODDRN (IND0, IND1, IND2, IND3, OUT1D0, OUT1D1, OUT2D0, OUT2D1, 
              OUT3D0, OUT3D1, OUT4D0, OUT4D1, CK, IN1Q0, IN1Q1, IN2Q0, IN2Q1, 
              IN3Q0, IN3Q1, IN4Q0, IN4Q1, OUTQ0, OUTQ1, OUTQ2, OUTQ3);

input  IND0, IND1, IND2, IND3, OUT1D0, OUT1D1, OUT2D0, OUT2D1;
input  OUT3D0, OUT3D1, OUT4D0, OUT4D1, CK;
output IN1Q0, IN1Q1, IN2Q0, IN2Q1, IN3Q0, IN3Q1;
output IN4Q0, IN4Q1, OUTQ0, OUTQ1, OUTQ2, OUTQ3;
reg out1d0_int, out1d1_int, out2d0_int, out2d1_int, out3d0_int, out3d1_int, out4d0_int, out4d1_int;
reg IN1Q1B, IN2Q1B, IN3Q1B, IN4Q1B;
reg IN1Q0B, IN2Q0B, IN3Q0B, IN4Q0B;
reg OUTQ0B, OUTQ1B, OUTQ2B, OUTQ3B;

   buf (IND0B, IND0);
   buf (IND1B, IND1);
   buf (IND2B, IND2);
   buf (IND3B, IND3);
   buf (OUT1D0B, OUT1D0);
   buf (OUT1D1B, OUT1D1);
   buf (OUT2D0B, OUT2D0);
   buf (OUT2D1B, OUT2D1);
   buf (OUT3D0B, OUT3D0);
   buf (OUT3D1B, OUT3D1);
   buf (OUT4D0B, OUT4D0);
   buf (OUT4D1B, OUT4D1);
   buf (CKB, CK);
   buf (IN1Q0, IN1Q0B);
   buf (IN1Q1, IN1Q1B);
   buf (IN2Q0, IN2Q0B);
   buf (IN2Q1, IN2Q1B);
   buf (IN3Q0, IN3Q0B);
   buf (IN3Q1, IN3Q1B);
   buf (IN4Q0, IN4Q0B);
   buf (IN4Q1, IN4Q1B);
   buf (OUTQ0, OUTQ0B);
   buf (OUTQ1, OUTQ1B);
   buf (OUTQ2, OUTQ2B);
   buf (OUTQ3, OUTQ3B);

      function DataSame;
        input a, b;
        begin
          if (a === b)
            DataSame = a;
          else
            DataSame = 1'bx;
        end
      endfunction

    function mux21 ;
      input  din0, din1;
      input  dsel;
      begin
        case (dsel)
         1'b0 : mux21 = din0;
         1'b1 : mux21 = din1;
         default mux21 = DataSame(din0, din1);
        endcase
      end
      endfunction

   always @ (posedge CKB) 
   begin
          out1d1_int <= OUT1D1B;
          out2d1_int <= OUT2D1B;
          out3d1_int <= OUT3D1B;
          out4d1_int <= OUT4D1B;
   end //end of the always loop

   always @ (negedge CKB)
   begin
          out1d0_int <= OUT1D0B;
          out2d0_int <= OUT2D0B;
          out3d0_int <= OUT3D0B;
          out4d0_int <= OUT4D0B;
   end //end of the always loop

   always @ (CKB or out1d0_int or out1d1_int or out2d0_int or out2d1_int or out3d0_int or out3d1_int or out4d0_int or out4d1_int)
   begin
      OUTQ0B = mux21(out1d1_int, out1d0_int, CKB); 
      OUTQ1B = mux21(out2d1_int, out2d0_int, CKB); 
      OUTQ2B = mux21(out3d1_int, out3d0_int, CKB); 
      OUTQ3B = mux21(out4d1_int, out4d0_int, CKB); 
   end

   always @ (posedge CKB) 
   begin
          IN1Q1B <= IND0B;
          IN2Q1B <= IND1B;
          IN3Q1B <= IND2B;
          IN4Q1B <= IND3B;
   end

   always @ (negedge CKB) 
   begin
          IN1Q0B <= IND0B;
          IN2Q0B <= IND1B;
          IN3Q0B <= IND2B;
          IN4Q0B <= IND3B;
   end


endmodule

`endcelldefine


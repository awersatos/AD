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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/DCS.v,v 1.4 2005/05/19 19:06:22 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module DCS (CLK0, CLK1, SEL, DCSOUT);
  input  CLK0, CLK1, SEL;
  output DCSOUT;
  parameter DCSMODE = "NEG";
  reg    Zb, Z_int1, Z_int2, dcs_int;
  wire D0b, D1b, SDb;
  reg SDb_int1, SDb_int2, SDb_int3, SDb_int4;
  reg SDb_int5, SDb_int6, SDb_int7, SDb_int8;

   buf  (D0b, CLK0);
   buf  (D1b, CLK1);
   buf  (SDb, SEL);
   buf  (DCSOUT, Zb);

  initial 
  begin
     Zb = 1'b0;
     Z_int1 = 1'b0;
     Z_int2 = 1'b0;
     SDb_int1 = 1'b0;
     SDb_int2 = 1'b0;
     SDb_int3 = 1'b0;
     SDb_int4 = 1'b0;
     SDb_int5 = 1'b0;
     SDb_int6 = 1'b0;
     SDb_int7 = 1'b0;
     SDb_int8 = 1'b0;
  end

  always@ (negedge D0b)
  begin
     if (SDb == 1'b1)
        SDb_int1 <= SDb;
  end    

  always@ (negedge D1b)
  begin
     if (SDb == 1'b0)
        SDb_int1 <= SDb;
  end

  always@ (negedge D1b)
  begin
     if (SDb_int1 == 1'b1)
        SDb_int2 <= SDb_int1;    
  end

  always@ (negedge D0b)
  begin
     if (SDb_int1 == 1'b0)
        SDb_int2 <= SDb_int1;    
  end

  always@ (SDb_int1 or SDb_int2 or D0b or D1b)
  begin
     case ({SDb_int1, SDb_int2})
        2'b00 : Z_int1 = D0b;
        2'b01 : Z_int1 = 1'b0;
        2'b10 : Z_int1 = 1'b0;
        2'b11 : Z_int1 = D1b;
     endcase
  end
        
  always@ (posedge D0b)
  begin
     if (SDb == 1'b1)
        SDb_int3 <= SDb;
  end

  always@ (posedge D1b)
  begin
     if (SDb == 1'b0)
        SDb_int3 <= SDb;
  end

  always@ (posedge D1b)
  begin
     if (SDb_int3 == 1'b1)
        SDb_int4 <= SDb_int3;
  end

  always@ (posedge D0b)
  begin
     if (SDb_int3 == 1'b0)
        SDb_int4 <= SDb_int3;
  end

  always@ (SDb_int3 or SDb_int4 or D0b or D1b)
  begin
     case ({SDb_int3, SDb_int4})
        2'b00 : Z_int2 = D0b;
        2'b01 : Z_int2 = 1'b1;
        2'b10 : Z_int2 = 1'b1;
        2'b11 : Z_int2 = D1b;
     endcase
  end

  always@ (negedge D1b)
  begin
     SDb_int5 <= SDb;
  end

  always@ (negedge D0b)
  begin
     SDb_int6 <= SDb;
  end

  always@ (posedge D1b)
  begin
     SDb_int7 <= SDb;
  end

  always@ (posedge D0b)
  begin
     SDb_int8 <= SDb;
  end
 

  always@ (D0b or D1b or SDb_int5 or SDb_int6 or SDb_int7 or SDb_int8)
  begin
     if (DCSMODE == "HIGH_LOW")
     begin
        case (SDb_int5)
           1'b0 : dcs_int = 1'b0;
           1'b1 : dcs_int = D1b;
        endcase
     end
     else if (DCSMODE == "HIGH_HIGH")
     begin
        case (SDb_int7)
           1'b0 : dcs_int = 1'b1;
           1'b1 : dcs_int = D1b;
        endcase
     end
     else if (DCSMODE == "LOW_LOW")
     begin
        case (SDb_int6)
           1'b0 : dcs_int = D0b;
           1'b1 : dcs_int = 1'b0;
        endcase
     end
     else if (DCSMODE == "LOW_HIGH")
     begin
        case (SDb_int8)
           1'b0 : dcs_int = D0b;
           1'b1 : dcs_int = 1'b1;
        endcase
     end
     else if (DCSMODE == "CLK0")
     begin
        case (SDb)
           1'b0 : dcs_int = D0b;
           1'b1 : dcs_int = D0b;
        endcase
     end
     else if (DCSMODE == "CLK1")
     begin
        case (SDb)
           1'b0 : dcs_int = D1b;
           1'b1 : dcs_int = D1b;
        endcase
     end
  end

  always@ (Z_int1 or Z_int2 or dcs_int)
  begin
     if (DCSMODE == "NEG")
        Zb = Z_int1;
     else if (DCSMODE == "POS")
        Zb = Z_int2;
     else
        Zb = dcs_int;
  end 

endmodule

`endcelldefine

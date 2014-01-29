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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/CAM2X256X16.v,v 1.6 2005/05/19 19:00:53 pradeep Exp $ 
//
`timescale 1 ns / 1 ps

`celldefine

module CAM2X256X16 (DW17, DW16, DW15, DW14, DW13, DW12, DW11, DW10,
                    AD13, AD12, AD11, AD10, CD1, SM1, WRE1, CKW1,
                    DM17, DM16, DM15, DM14, DM13, DM12, DM11, DM10, RDE1, CKR1,
                    DW07, DW06, DW05, DW04, DW03, DW02, DW01, DW00,
                    AD03, AD02, AD01, AD00, CD0, SM0, WRE0, CKW0,
                    DM07, DM06, DM05, DM04, DM03, DM02, DM01, DM00, RDE0, CKR0,
                    Q115, Q114, Q113, Q112, Q111, Q110, Q19, Q18,
                    Q17, Q16, Q15, Q14, Q13, Q12, Q11, Q10,
                    Q015, Q014, Q013, Q012, Q011, Q010, Q09, Q08,
                    Q07, Q06, Q05, Q04, Q03, Q02, Q01, Q00);

// PARAMETERS
parameter CAMMODE0 = "NOREG";
parameter CAMMODE1 = "NOREG";

// INPUTS
input DW17, DW16, DW15, DW14, DW13, DW12, DW11, DW10;
input AD13, AD12, AD11, AD10, CD1, SM1, WRE1, CKW1;
input DM17, DM16, DM15, DM14, DM13, DM12, DM11, DM10, RDE1, CKR1;
input DW07, DW06, DW05, DW04, DW03, DW02, DW01, DW00;
input AD03, AD02, AD01, AD00, CD0, SM0, WRE0, CKW0;
input DM07, DM06, DM05, DM04, DM03, DM02, DM01, DM00, RDE0, CKR0;

// OUTPUTS
output Q115, Q114, Q113, Q112, Q111, Q110, Q19, Q18;
output Q17, Q16, Q15, Q14, Q13, Q12, Q11, Q10;
output Q015, Q014, Q013, Q012, Q011, Q010, Q09, Q08;
output Q07, Q06, Q05, Q04, Q03, Q02, Q01, Q00;

reg [15:0] MEM1 [255:0];
reg memchg0;
reg [4095:0] init_value1;
reg [15:0] MEM2 [255:0];
reg memchg1;
reg [4095:0] init_value2;
reg  [15:0] q0;
reg  [15:0] q1;
reg  [15:0] q0_int;
reg  [15:0] q1_int;
reg [7:0] aw0_int;
reg [7:0] aw1_int;
reg en0_reg;
reg en1_reg;
reg [15:0] data0;
reg [15:0] data1;
reg [7:0] rad_reg_0;
reg [7:0] rad_reg_1;
wire [7:0] ar0_int;
wire [7:0] ar1_int;
wire [7:0] aw0_tmp;
wire [7:0] aw1_tmp;
wire  [3:0] d0_int;
wire  [3:0] d1_int;
integer i;
integer d0_tmp;
integer d1_tmp;

  buf (ar0_int[7], DM07);
  buf (ar0_int[6], DM06);
  buf (ar0_int[5], DM05);
  buf (ar0_int[4], DM04);
  buf (ar0_int[3], DM03);
  buf (ar0_int[2], DM02);
  buf (ar0_int[1], DM01);
  buf (ar0_int[0], DM00);
  buf (ar1_int[7], DM17);
  buf (ar1_int[6], DM16);
  buf (ar1_int[5], DM15);
  buf (ar1_int[4], DM14);
  buf (ar1_int[3], DM13);
  buf (ar1_int[2], DM12);
  buf (ar1_int[1], DM11);
  buf (ar1_int[0], DM10);
  buf (aw0_tmp[7], DW07);
  buf (aw0_tmp[6], DW06);
  buf (aw0_tmp[5], DW05);
  buf (aw0_tmp[4], DW04);
  buf (aw0_tmp[3], DW03);
  buf (aw0_tmp[2], DW02);
  buf (aw0_tmp[1], DW01);
  buf (aw0_tmp[0], DW00);
  buf (aw1_tmp[7], DW17);
  buf (aw1_tmp[6], DW16);
  buf (aw1_tmp[5], DW15);
  buf (aw1_tmp[4], DW14);
  buf (aw1_tmp[3], DW13);
  buf (aw1_tmp[2], DW12);
  buf (aw1_tmp[1], DW11);
  buf (aw1_tmp[0], DW10);
  buf (d0_int[3], AD03);
  buf (d0_int[2], AD02);
  buf (d0_int[1], AD01);
  buf (d0_int[0], AD00);
  buf (d1_int[3], AD13);
  buf (d1_int[2], AD12);
  buf (d1_int[1], AD11);
  buf (d1_int[0], AD10);

  buf (CD0B, CD0);
  buf (SM0B, SM0);
  buf (WRE0B, WRE0);
  buf (CKW0B, CKW0);
  buf (RDE0B, RDE0);
  buf (CKR0B, CKR0);
  buf (CD1B, CD1);
  buf (SM1B, SM1);
  buf (WRE1B, WRE1);
  buf (CKW1B, CKW1);
  buf (RDE1B, RDE1);
  buf (CKR1B, CKR1);

  buf (Q015_OUT, q0[15]);
  buf (Q014_OUT, q0[14]);
  buf (Q013_OUT, q0[13]);
  buf (Q012_OUT, q0[12]);
  buf (Q011_OUT, q0[11]);
  buf (Q010_OUT, q0[10]);
  buf (Q09_OUT, q0[9]);
  buf (Q08_OUT, q0[8]);
  buf (Q07_OUT, q0[7]);
  buf (Q06_OUT, q0[6]);
  buf (Q05_OUT, q0[5]);
  buf (Q04_OUT, q0[4]);
  buf (Q03_OUT, q0[3]);
  buf (Q02_OUT, q0[2]);
  buf (Q01_OUT, q0[1]);
  buf (Q00_OUT, q0[0]);
  buf (Q015, Q015_OUT);
  buf (Q014, Q014_OUT);
  buf (Q013, Q013_OUT);
  buf (Q012, Q012_OUT);
  buf (Q011, Q011_OUT);
  buf (Q010, Q010_OUT);
  buf (Q09, Q09_OUT);
  buf (Q08, Q08_OUT);
  buf (Q07, Q07_OUT);
  buf (Q06, Q06_OUT);
  buf (Q05, Q05_OUT);
  buf (Q04, Q04_OUT);
  buf (Q03, Q03_OUT);
  buf (Q02, Q02_OUT);
  buf (Q01, Q01_OUT);
  buf (Q00, Q00_OUT);
  buf (Q115_OUT, q1[15]);
  buf (Q114_OUT, q1[14]);
  buf (Q113_OUT, q1[13]);
  buf (Q112_OUT, q1[12]);
  buf (Q111_OUT, q1[11]);
  buf (Q110_OUT, q1[10]);
  buf (Q19_OUT, q1[9]);
  buf (Q18_OUT, q1[8]);
  buf (Q17_OUT, q1[7]);
  buf (Q16_OUT, q1[6]);
  buf (Q15_OUT, q1[5]);
  buf (Q14_OUT, q1[4]);
  buf (Q13_OUT, q1[3]);
  buf (Q12_OUT, q1[2]);
  buf (Q11_OUT, q1[1]);
  buf (Q10_OUT, q1[0]);
  buf (Q115, Q115_OUT);
  buf (Q114, Q114_OUT);
  buf (Q113, Q113_OUT);
  buf (Q112, Q112_OUT);
  buf (Q111, Q111_OUT);
  buf (Q110, Q110_OUT);
  buf (Q19, Q19_OUT);
  buf (Q18, Q18_OUT);
  buf (Q17, Q17_OUT);
  buf (Q16, Q16_OUT);
  buf (Q15, Q15_OUT);
  buf (Q14, Q14_OUT);
  buf (Q13, Q13_OUT);
  buf (Q12, Q12_OUT);
  buf (Q11, Q11_OUT);
  buf (Q10, Q10_OUT);

  initial
  begin
    init_value1 = 4096'b0;
    init_value2 = 4096'b0;

    for (i = 0; i < 256; i = i+1)
    begin
        MEM1[i] = init_value1[15:0];
        init_value1 = (init_value1 >> 16);
        MEM2[i] = init_value2[15:0];
        init_value2 = (init_value2 >> 16);
    end
  memchg0 = 1'b0;
  memchg1 = 1'b0;
  end



//  Port0 and Port1 clear write-address and data
  always @(CD0B or CD1B or aw0_tmp or aw1_tmp) 
  begin
      if (CD0B == 1'b1)
      begin
         aw0_int = 8'b0;
      end
      else
      begin
         aw0_int = aw0_tmp;
      end
      if (CD1B == 1'b1)
      begin
         aw1_int = 8'b0;
      end
      else
      begin
         aw1_int = aw1_tmp;
      end
  end

// Port0 and Port1 write address and data latch and write

  always @(posedge CKW0B)
  begin
      if (WRE0B == 1'b1)
      begin
         d0_tmp = d0_int;
         data0 = 16'b0;
         data0[d0_tmp] = 1'b1;
         if (SM0B == 1'b0)
         begin
            MEM1[aw0_int] = ((MEM1[aw0_int]) | (data0));
         end
         else if (SM0B == 1'b1)
         begin
            MEM1[aw0_int] =  data0;
         end
         memchg0 = ~memchg0;
      end
  end // end always

  always @(posedge CKW1B)
  begin
      if (WRE1B == 1'b1)
      begin
         d1_tmp = d1_int;
         data1 = 16'b0;
         data1[d1_tmp] = 1'b1;
         if (SM1B == 1'b0)
         begin
            MEM2[aw1_int] = (MEM2[aw1_int] ^ (data1));
         end
         else if (SM1B == 1'b1)
         begin
            MEM2[aw1_int] =  data1;
         end
         memchg1 = ~memchg1;
      end
  end // end always

// Register Enable signal
  always @(posedge CKR0B)
  begin
      if (CAMMODE0 == "IOREG")
      begin
         en0_reg <= RDE0B;
      end
  end
  always @(posedge CKR1B)
  begin
      if (CAMMODE1 == "IOREG")
      begin
         en1_reg <= RDE1B;
      end
  end

// Read operation

  always @(rad_reg_0 or rad_reg_1 or memchg0 or memchg1)
  begin
     q0_int = MEM1[rad_reg_0];
     q1_int = MEM2[rad_reg_1];
  end

// INREG and IOREG read operation

  always @(posedge CKR0B)
  begin
       if (CAMMODE0 == "INREG" || CAMMODE0 == "IOREG")
       begin
          if (RDE0B == 1'b1)
          begin
             rad_reg_0 <= (ar0_int);
          end
       end
  end
  always @(posedge CKR1B)
  begin
       if (CAMMODE1 == "INREG" || CAMMODE1 == "IOREG")
       begin
          if (RDE1B == 1'b1)
          begin
             rad_reg_1 <= (ar1_int);
          end
       end
  end

  always @(ar0_int)
  begin
       if (CAMMODE0 == "NOREG" || CAMMODE0 == "OUTREG")
       begin
          rad_reg_0 <= (ar0_int);
       end
  end
  always @(ar1_int)
  begin
       if (CAMMODE1 == "NOREG" || CAMMODE1 == "OUTREG")
       begin
          rad_reg_1 <= (ar1_int);
       end
  end

// OUTREG and IOREG read operation

  always @(posedge CKR0B)
  begin
       if (CAMMODE0 == "IOREG")
       begin
          if (en0_reg == 1'b1)
          begin
             q0 <= q0_int;
          end
       end
       else if (CAMMODE0 == "OUTREG")
       begin
          if (RDE0B == 1'b1)
          begin
             q0 <= q0_int;
          end
       end
  end

  always @(posedge CKR1B)
  begin
       if (CAMMODE1 == "IOREG")
       begin
          if (en1_reg == 1'b1)
          begin
             q1 <= q1_int;
          end
       end
       else if (CAMMODE1 == "OUTREG")
       begin
          if (RDE1B == 1'b1)
          begin
             q1 <= q1_int;
          end
       end
  end

  always @(q0_int)
  begin
      if (CAMMODE0 == "NOREG" || CAMMODE0 == "INREG")
      begin
         q0 <= q0_int;
      end
  end
  always @(q1_int)
  begin
      if (CAMMODE1 == "NOREG" || CAMMODE1 == "INREG")
      begin
         q1 <= q1_int;
      end
  end



endmodule

`endcelldefine



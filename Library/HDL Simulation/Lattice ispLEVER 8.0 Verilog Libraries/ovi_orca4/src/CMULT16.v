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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/CMULT16.v,v 1.5 2005/05/19 19:01:02 pradeep Exp $ 
//
`timescale 1 ns / 1 ps

`celldefine

module CMULT16 (M15, M14, M13, M12, M11, M10, M9, M8,
                M7, M6, M5, M4, M3, M2, M1, M0, MCK, EN,
                AW08, AW07, AW06, AW05, AW04, AW03, AW02, AW01, AW00,
                D015, D014, D013, D012, D011, D010, D09, D08,
                D07, D06, D05, D04, D03, D02, D01, D00, CKW0, CSW0,
                AW18, AW17, AW16, AW15, AW14, AW13, AW12, AW11, AW10,
                D115, D114, D113, D112, D111, D110, D19, D18,
                D17, D16, D15, D14, D13, D12, D11, D10, CKW1, CSW1,
                P23, P22, P21, P20, P19, P18, P17, P16,
                P15, P14, P13, P12, P11, P10, P9, P8,
                P7, P6, P5, P4, P3, P2, P1, P0);
      
// PARAMETERS
parameter CMULTMODE = "NOREG";
parameter [255:0] INITVAL_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_10 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_11 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_12 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_13 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_14 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_15 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_16 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_17 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_18 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_19 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_1A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_1B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_1C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_1D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_1E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter [255:0] INITVAL_1F = 256'h0000000000000000000000000000000000000000000000000000000000000000;

// INPUTS
input M15, M14, M13, M12, M11, M10, M9, M8;
input M7, M6, M5, M4, M3, M2, M1, M0, MCK, EN;
input AW08, AW07, AW06, AW05, AW04, AW03, AW02, AW01, AW00;
input D015, D014, D013, D012, D011, D010, D09, D08;
input D07, D06, D05, D04, D03, D02, D01, D00, CKW0, CSW0;
input AW18, AW17, AW16, AW15, AW14, AW13, AW12, AW11, AW10;
input D115, D114, D113, D112, D111, D110, D19, D18;
input D17, D16, D15, D14, D13, D12, D11, D10, CKW1, CSW1;

// OUTPUTS
output P23, P22, P21, P20, P19, P18, P17, P16;
output P15, P14, P13, P12, P11, P10, P9, P8;
output P7, P6, P5, P4, P3, P2, P1, P0;

reg memchg0;
reg memchg1;
reg [15:0] MEM1 [255:0];
reg [15:0] MEM2 [255:0];
reg [4095:0] init_value1;
reg [4095:0] init_value2;

reg  en_reg;
reg  [23:0] p_reg;
reg  [7:0] rad_reg_0;
reg  [7:0] rad_reg_1;
reg  [7:0] q0_int;
reg  [15:0] q0_temp;
reg  [15:0] q1_int;
reg  [15:0] q2_int;
reg  [15:0] q_out;
wire [8:0] aw0_int;
wire [8:0] aw1_int;
wire [7:0] ar0_int;
wire [7:0] ar1_int;
wire [15:0] d0_int;
wire [15:0] d1_int;
wire [23:0] p_int;
integer i;

  buf (ar1_int[7], M15);
  buf (ar1_int[6], M14);
  buf (ar1_int[5], M13);
  buf (ar1_int[4], M12);
  buf (ar1_int[3], M11);
  buf (ar1_int[2], M10);
  buf (ar1_int[1], M9);
  buf (ar1_int[0], M8);
  buf (ar0_int[7], M7);
  buf (ar0_int[6], M6);
  buf (ar0_int[5], M5);
  buf (ar0_int[4], M4);
  buf (ar0_int[3], M3);
  buf (ar0_int[2], M2);
  buf (ar0_int[1], M1);
  buf (ar0_int[0], M0);

  buf (aw0_int[8], AW08);
  buf (aw0_int[7], AW07);
  buf (aw0_int[6], AW06);
  buf (aw0_int[5], AW05);
  buf (aw0_int[4], AW04);
  buf (aw0_int[3], AW03);
  buf (aw0_int[2], AW02);
  buf (aw0_int[1], AW01);
  buf (aw0_int[0], AW00);
  buf (d0_int[15], D015);
  buf (d0_int[14], D014);
  buf (d0_int[13], D013);
  buf (d0_int[12], D012);
  buf (d0_int[11], D011);
  buf (d0_int[10], D010);
  buf (d0_int[9], D09);
  buf (d0_int[8], D08);
  buf (d0_int[7], D07);
  buf (d0_int[6], D06);
  buf (d0_int[5], D05);
  buf (d0_int[4], D04);
  buf (d0_int[3], D03);
  buf (d0_int[2], D02);
  buf (d0_int[1], D01);
  buf (d0_int[0], D00);
  buf (ckw0_int, CKW0);
  buf (csw0_int, CSW0);
  buf (aw1_int[8], AW18);
  buf (aw1_int[7], AW17);
  buf (aw1_int[6], AW16);
  buf (aw1_int[5], AW15);
  buf (aw1_int[4], AW14);
  buf (aw1_int[3], AW13);
  buf (aw1_int[2], AW12);
  buf (aw1_int[1], AW11);
  buf (aw1_int[0], AW10);
  buf (d1_int[15], D115);
  buf (d1_int[14], D114);
  buf (d1_int[13], D113);
  buf (d1_int[12], D112);
  buf (d1_int[11], D111);
  buf (d1_int[10], D110);
  buf (d1_int[9], D19);
  buf (d1_int[8], D18);
  buf (d1_int[7], D17);
  buf (d1_int[6], D16);
  buf (d1_int[5], D15);
  buf (d1_int[4], D14);
  buf (d1_int[3], D13);
  buf (d1_int[2], D12);
  buf (d1_int[1], D11);
  buf (d1_int[0], D10);
  buf (ckw1_int, CKW1);
  buf (csw1_int, CSW1);


  buf (mck_int, MCK);
  buf (en_int, EN);

  buf (P23_OUT, p_reg[23]);
  buf (P22_OUT, p_reg[22]);
  buf (P21_OUT, p_reg[21]);
  buf (P20_OUT, p_reg[20]);
  buf (P19_OUT, p_reg[19]);
  buf (P18_OUT, p_reg[18]);
  buf (P17_OUT, p_reg[17]);
  buf (P16_OUT, p_reg[16]);
  buf (P15_OUT, p_reg[15]);
  buf (P14_OUT, p_reg[14]);
  buf (P13_OUT, p_reg[13]);
  buf (P12_OUT, p_reg[12]);
  buf (P11_OUT, p_reg[11]);
  buf (P10_OUT, p_reg[10]);
  buf (P9_OUT, p_reg[9]);
  buf (P8_OUT, p_reg[8]);
  buf (P7_OUT, p_reg[7]);
  buf (P6_OUT, p_reg[6]);
  buf (P5_OUT, p_reg[5]);
  buf (P4_OUT, p_reg[4]);
  buf (P3_OUT, p_reg[3]);
  buf (P2_OUT, p_reg[2]);
  buf (P1_OUT, p_reg[1]);
  buf (P0_OUT, p_reg[0]);
  buf (P23, P23_OUT);
  buf (P22, P22_OUT);
  buf (P21, P21_OUT);
  buf (P20, P20_OUT);
  buf (P19, P19_OUT);
  buf (P18, P18_OUT);
  buf (P17, P17_OUT);
  buf (P16, P16_OUT);
  buf (P15, P15_OUT);
  buf (P14, P14_OUT);
  buf (P13, P13_OUT);
  buf (P12, P12_OUT);
  buf (P11, P11_OUT);
  buf (P10, P10_OUT);
  buf (P9, P9_OUT);
  buf (P8, P8_OUT);
  buf (P7, P7_OUT);
  buf (P6, P6_OUT);
  buf (P5, P5_OUT);
  buf (P4, P4_OUT);
  buf (P3, P3_OUT);
  buf (P2, P2_OUT);
  buf (P1, P1_OUT);
  buf (P0, P0_OUT);

  initial
  begin
    init_value1 = {INITVAL_0F, INITVAL_0E, INITVAL_0D, INITVAL_0C, INITVAL_0B, INITVAL_0A,
    INITVAL_09, INITVAL_08, INITVAL_07, INITVAL_06, INITVAL_05, INITVAL_04, INITVAL_03,
    INITVAL_02, INITVAL_01, INITVAL_00};
    init_value2 = {INITVAL_1F, INITVAL_1E, INITVAL_1D, INITVAL_1C, INITVAL_1B, INITVAL_1A,
    INITVAL_19, INITVAL_18, INITVAL_17, INITVAL_16, INITVAL_15, INITVAL_14, INITVAL_13,
    INITVAL_12, INITVAL_11, INITVAL_10};

    for (i = 0; i < 256; i = i+1)
    begin
        MEM1[i] = init_value1[15:0];
        init_value1 = (init_value1 >> 16);
        MEM2[i] = init_value2[15:0];
        init_value2 = (init_value2 >> 16);
    end
  q1_int = 16'b0;
  memchg0 = 1'b0;
  memchg1 = 1'b0;
  end

// Port0 and Port1 write address and data latch and write

  always @(posedge ckw0_int)
  begin
       if (csw0_int == 1'b1)
       begin
          if (aw0_int[8] == 1'b0)
          begin
             MEM1[aw0_int] <= d0_int;
          end
          else if(aw0_int[8] == 1'b1)
          begin
             MEM2[aw0_int] <= d0_int;
          end
          memchg0 = ~memchg0;
       end
  end

  always @(posedge ckw1_int)
  begin
       if (csw1_int == 1'b1)
       begin
          if (aw1_int[8] == 1'b0)
          begin
             MEM1[aw1_int] <= d0_int;
          end
          else if(aw1_int[8] == 1'b1)
          begin
             MEM2[aw1_int] <= d0_int;
          end
          memchg1 = ~memchg1;
       end
  end

// Register Enable signal
  always @(posedge mck_int)
  begin
      if (CMULTMODE == "IOREG")  
         en_reg <= en_int;
  end

// INREG and IOREG read operation

  always @(posedge mck_int)
  begin
       if (CMULTMODE == "INREG" || CMULTMODE == "IOREG")
       begin
          if (en_int == 1'b1)
          begin
             rad_reg_0 <= (ar0_int);
             rad_reg_1 <= (ar1_int);
          end
       end
  end

  always @(ar0_int or ar1_int)
  begin
       if (CMULTMODE == "NOREG" || CMULTMODE == "OUTREG")
       begin
          rad_reg_0 <= (ar0_int);
          rad_reg_1 <= (ar1_int);
       end
  end

// Read operation

  always @(rad_reg_0 or rad_reg_1 or memchg0 or memchg1)
  begin
     q0_temp = MEM1[rad_reg_0];
     q0_int = q0_temp[7:0];
     q1_int[7:0] = q0_temp[15:8];
     q2_int = MEM2[rad_reg_1];
  end

  always @(q1_int or q2_int)
  begin
       q_out <= q1_int + q2_int;
  end


// OUTREG and IOREG read operation

  always @(posedge mck_int)
  begin
       if (CMULTMODE == "IOREG")
       begin
          if (en_reg == 1'b1)
          begin
             p_reg[7:0] <= q0_int;
             p_reg[23:8] <= q_out;
          end
       end
       else if (CMULTMODE == "OUTREG")
       begin
          if (en_int == 1'b1)
          begin
             p_reg[7:0] <= q0_int;
             p_reg[23:8] <= q_out;
          end
       end
  end 

  always @(q0_int or q_out)
  begin
      if (CMULTMODE == "NOREG" || CMULTMODE == "INREG")
      begin
         p_reg[7:0] <= q0_int;
         p_reg[23:8] <= q_out;
      end
  end




endmodule

`endcelldefine



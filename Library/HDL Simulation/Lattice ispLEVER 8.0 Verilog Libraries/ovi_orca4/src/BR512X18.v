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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/BR512X18.v,v 1.12 2005/05/19 19:00:48 pradeep Exp $ 
//
`timescale 1 ns / 1 ps

`celldefine

module BR512X18 (AW18, AW17, AW16, AW15, AW14, AW13, AW12, AW11, AW10,
                 AW08, AW07, AW06, AW05, AW04, AW03, AW02, AW01, AW00,
                 D117, D116, D115, D114, D113, D112, D111, D110, D19,
                 D18, D17, D16, D15, D14, D13, D12, D11, D10,
                 D017, D016, D015, D014, D013, D012, D011, D010, D09,
                 D08, D07, D06, D05, D04, D03, D02, D01, D00,
                 BW11, BW10, BW01, BW00,
                 AR18, AR17, AR16, AR15, AR14, AR13, AR12, AR11, AR10,
                 AR08, AR07, AR06, AR05, AR04, AR03, AR02, AR01, AR00,
                 CKW1, CKW0, CKR1, CKR0, CSW1, CSW0, CSR1, CSR0,
                 Q117, Q116, Q115, Q114, Q113, Q112, Q111, Q110, Q19,
                 Q18, Q17, Q16, Q15, Q14, Q13, Q12, Q11, Q10, 
                 Q017, Q016, Q015, Q014, Q013, Q012, Q011, Q010, Q09,
                 Q08, Q07, Q06, Q05, Q04, Q03, Q02, Q01, Q00, BUSY);


// PARAMETERS
parameter BRAMMODE0 = "NOREG";
parameter BRAMMODE1 = "NOREG";
parameter ARBITERMODE = "FALSE";
parameter [319:0] INITVAL_00 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_01 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_02 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_03 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_04 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_05 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_06 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_07 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_08 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_09 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_0A = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_0B = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_0C = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_0D = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_0E = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_0F = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_10 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_11 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_12 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_13 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_14 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_15 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_16 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_17 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_18 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_19 = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_1A = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_1B = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_1C = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_1D = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_1E = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 
parameter [319:0] INITVAL_1F = 320'hXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; 

// INPUTS
input AW08, AW07, AW06, AW05, AW04, AW03, AW02, AW01, AW00;
input AR08, AR07, AR06, AR05, AR04, AR03, AR02, AR01, AR00;
input AW18, AW17, AW16, AW15, AW14, AW13, AW12, AW11, AW10;
input AR18, AR17, AR16, AR15, AR14, AR13, AR12, AR11, AR10;
input D017, D016, D015, D014, D013, D012, D011, D010, D09;
input D08, D07, D06, D05, D04, D03, D02, D01, D00;
input D117, D116, D115, D114, D113, D112, D111, D110, D19;
input D18, D17, D16, D15, D14, D13, D12, D11, D10;
input BW00, BW01, CKW0, CKR0, CSW0, CSR0,BW10, BW11, CKW1, CKR1, CSW1, CSR1;

// OUTPUTS
output Q017, Q016, Q015, Q014, Q013, Q012, Q011, Q010, Q09, Q08, Q07, Q06;
output Q05, Q04, Q03, Q02, Q01, Q00, Q117, Q116, Q115, Q114, Q113, Q112, Q111;
output Q110, Q19, Q18, Q17, Q16, Q15, Q14, Q13, Q12, Q11, Q10, BUSY;

reg  port0_valid;
reg  first_time;
reg BUSYB, PORT0_SHUTOFF;
reg memchg0;
reg memchg1;
reg [17:0] MEM [511:0];
reg [10239:0] init_value;
reg [7:0] LD0_1;
reg [7:0] LD0_0;
reg LD0_17;
reg LD0_16;
reg [8:0] LAW_0;
reg [8:0] LAR_0;
reg [8:0] RADDR0;
reg [17:0] RQ_0;
reg [17:0] LQ_0;
reg LCSR0,LCSR1;
reg [7:0] LD1_1;
reg [7:0] LD1_0;
reg [8:0] LAW_1;
reg [8:0] LAR_1;
reg [8:0] RADDR1;
reg LD1_17;
reg LD1_16;
reg [17:0] temp1;
reg [17:0] temp2;
reg [17:0] temp3;
reg [17:0] temp4;
reg [17:0] RQ_1;
reg [17:0] LQ_1;
reg [17:0] Q0;
reg [17:0] Q1;

wire Q017_OUT, Q016_OUT, Q015_OUT, Q014_OUT, Q013_OUT, Q012_OUT, Q011_OUT, Q010_OUT, Q09_OUT, Q08_OUT, Q07_OUT, Q06_OUT, Q05_OUT, Q04_OUT, Q03_OUT, Q02_OUT, Q01_OUT, Q00_OUT;
wire Q117_OUT, Q116_OUT, Q115_OUT, Q114_OUT, Q113_OUT, Q112_OUT, Q111_OUT, Q110_OUT, Q19_OUT, Q18_OUT, Q17_OUT, Q16_OUT, Q15_OUT, Q14_OUT, Q13_OUT, Q12_OUT, Q11_OUT, Q10_OUT;
wire [8:0] AW0, AR0, AW1, AR1;
wire [17:0] D0, D1;
integer i;


  initial
  begin
    init_value = {INITVAL_1F, INITVAL_1E, INITVAL_1D, INITVAL_1C, INITVAL_1B, INITVAL_1A,
    INITVAL_19, INITVAL_18, INITVAL_17, INITVAL_16, INITVAL_15, INITVAL_14, INITVAL_13,
    INITVAL_12, INITVAL_11, INITVAL_10, INITVAL_0F, INITVAL_0E, INITVAL_0D, INITVAL_0C,
    INITVAL_0B, INITVAL_0A, INITVAL_09, INITVAL_08, INITVAL_07, INITVAL_06, INITVAL_05,
    INITVAL_04, INITVAL_03, INITVAL_02, INITVAL_01, INITVAL_00}; 
    
    for (i = 0; i < 512; i = i+1)
    begin
        MEM[i] = init_value[17:0];
        init_value = (init_value >> 20);
    end

  BUSYB = 1'b0;
  memchg0 = 1'b0;
  memchg1 = 1'b0;
  end

  buf (AW0[8], AW08);
  buf (AW0[7], AW07);
  buf (AW0[6], AW06);
  buf (AW0[5], AW05);
  buf (AW0[4], AW04);
  buf (AW0[3], AW03);
  buf (AW0[2], AW02);
  buf (AW0[1], AW01);
  buf (AW0[0], AW00);
  buf (AW1[8], AW18);
  buf (AW1[7], AW17);
  buf (AW1[6], AW16);
  buf (AW1[5], AW15);
  buf (AW1[4], AW14);
  buf (AW1[3], AW13);
  buf (AW1[2], AW12);
  buf (AW1[1], AW11);
  buf (AW1[0], AW10);
  buf (AR0[8], AR08);
  buf (AR0[7], AR07);
  buf (AR0[6], AR06);
  buf (AR0[5], AR05);
  buf (AR0[4], AR04);
  buf (AR0[3], AR03);
  buf (AR0[2], AR02);
  buf (AR0[1], AR01);
  buf (AR0[0], AR00);
  buf (AR1[8], AR18);
  buf (AR1[7], AR17);
  buf (AR1[6], AR16);
  buf (AR1[5], AR15);
  buf (AR1[4], AR14);
  buf (AR1[3], AR13);
  buf (AR1[2], AR12);
  buf (AR1[1], AR11);
  buf (AR1[0], AR10);
  buf (D0[17], D017);
  buf (D0[16], D016);
  buf (D0[15], D015);
  buf (D0[14], D014);
  buf (D0[13], D013);
  buf (D0[12], D012);
  buf (D0[11], D011);
  buf (D0[10], D010);
  buf (D0[9], D09);
  buf (D0[8], D08);
  buf (D0[7], D07);
  buf (D0[6], D06);
  buf (D0[5], D05);
  buf (D0[4], D04);
  buf (D0[3], D03);
  buf (D0[2], D02);
  buf (D0[1], D01);
  buf (D0[0], D00);
  buf (D1[17], D117);
  buf (D1[16], D116);
  buf (D1[15], D115);
  buf (D1[14], D114);
  buf (D1[13], D113);
  buf (D1[12], D112);
  buf (D1[11], D111);
  buf (D1[10], D110);
  buf (D1[9], D19);
  buf (D1[8], D18);
  buf (D1[7], D17);
  buf (D1[6], D16);
  buf (D1[5], D15);
  buf (D1[4], D14);
  buf (D1[3], D13);
  buf (D1[2], D12);
  buf (D1[1], D11);
  buf (D1[0], D10);
  buf (CKW0B, CKW0);
  buf (CKR0B, CKR0);
  buf (CSW0B, CSW0);
  buf (CSR0B, CSR0);
  buf (BW01B, BW01);
  buf (BW00B, BW00);
  buf (BW11B, BW11);
  buf (BW10B, BW10);
  buf (CKW1B, CKW1);
  buf (CKR1B, CKR1);
  buf (CSW1B, CSW1);
  buf (CSR1B, CSR1);

  buf (Q017_OUT, Q0[17]);
  buf (Q016_OUT, Q0[16]);
  buf (Q015_OUT, Q0[15]);
  buf (Q014_OUT, Q0[14]);
  buf (Q013_OUT, Q0[13]);
  buf (Q012_OUT, Q0[12]);
  buf (Q011_OUT, Q0[11]);
  buf (Q010_OUT, Q0[10]);
  buf (Q09_OUT, Q0[9]);
  buf (Q08_OUT, Q0[8]);
  buf (Q07_OUT, Q0[7]);
  buf (Q06_OUT, Q0[6]);
  buf (Q05_OUT, Q0[5]);
  buf (Q04_OUT, Q0[4]);
  buf (Q03_OUT, Q0[3]);
  buf (Q02_OUT, Q0[2]);
  buf (Q01_OUT, Q0[1]);
  buf (Q00_OUT, Q0[0]);
  buf (Q117_OUT, Q1[17]);
  buf (Q116_OUT, Q1[16]);
  buf (Q115_OUT, Q1[15]);
  buf (Q114_OUT, Q1[14]);
  buf (Q113_OUT, Q1[13]);
  buf (Q112_OUT, Q1[12]);
  buf (Q111_OUT, Q1[11]);
  buf (Q110_OUT, Q1[10]);
  buf (Q19_OUT, Q1[9]);
  buf (Q18_OUT, Q1[8]);
  buf (Q17_OUT, Q1[7]);
  buf (Q16_OUT, Q1[6]);
  buf (Q15_OUT, Q1[5]);
  buf (Q14_OUT, Q1[4]);
  buf (Q13_OUT, Q1[3]);
  buf (Q12_OUT, Q1[2]);
  buf (Q11_OUT, Q1[1]);
  buf (Q10_OUT, Q1[0]);
  buf (Q017, Q017_OUT);
  buf (Q016, Q016_OUT);
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
  buf (Q117, Q117_OUT);
  buf (Q116, Q116_OUT);
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
  buf (BUSY, BUSYB);

  initial
  begin
     first_time = 1'b1;
     port0_valid = 1'b0;
  end

always @(posedge CKR1B)
begin
   if (first_time == 1'b1)
   begin
      port0_valid <= 1'b1;
      first_time <= 1'b0;
   end
end

// arbiter mode

 always @(AW0 or AW1 or CSW1B or CSW0B)
 begin
  if ((AW0 == AW1) && (ARBITERMODE == "TRUE") && (CSW1B == 1) && (CSW0B == 1)) 
   begin
    PORT0_SHUTOFF = 1'b1;
    BUSYB = 1'b1;
   end
  else
   begin
    PORT0_SHUTOFF = 1'b0;
   end

 end

 always @(posedge CKW0B) begin
  if (PORT0_SHUTOFF == 1'b0)
  begin
     BUSYB <= 1'b0;
  end
 end

// latch port0 write addresses, byte wide data lines

 always @(posedge CKW0B) begin

  if (CSW0B == 1)
  begin

     LAW_0 = AW0;
     // $display("LAW_0 = %b",LAW_0);

    if (BW01B == 1)  // byte 1
    begin
       LD0_1 = D0[15:8];
       LD0_17 = D0[17];
       // $display("LDO_1 = %b",LD0_1);
    end

    if (BW00B == 1)  // byte 0
    begin
       LD0_0 = D0[7:0];
       LD0_16 = D0[16];
       // $display("LDO_0 = %b",LD0_0);
    end

    // write port0 data into memory

    if (BUSYB == 0)
    begin
       if ((BW00B == 1) && (BW01B == 1)) 
       begin
          MEM[LAW_0] = {LD0_17, LD0_16, LD0_1, LD0_0};
       end

       if ((BW00B == 1) && (BW01B == 0))  // byte 0
       begin
          temp1 = MEM[LAW_0];
          MEM[LAW_0] = {temp1[17], LD0_16, temp1[15:8], LD0_0};
       end

       if ((BW00B == 0) && (BW01B == 1)) // byte 0
       begin
          temp2 = MEM[LAW_0];
          MEM[LAW_0] = {LD0_17, temp2[16], LD0_1, temp2[7:0]};
       end
       memchg0 = ~memchg0;
    end
       // $display("MEM = %b",MEM[LAW_0]);

  end // end port0 CSW0 if

 end // end port0 write always

// latch port0 read addresses

 always @(posedge CKR0B) begin

  if (CSR0B == 1)
  begin

     LAR_0 <= AR0;

  end
 end

// port0 asynchronous read operation

  always @ (AR0) begin
     RADDR0 = AR0;
  end

// mux between latched and regular read address

always @(RADDR0 or LAR_0 or memchg0 or memchg1) begin

       if (BRAMMODE0 == "INREG" || BRAMMODE0 == "IOREG")
       begin
         RQ_0 = MEM[LAR_0];
       end
       else
       begin
         RQ_0 = MEM[RADDR0];
       end

       // $display("RQ_0 = %b",RQ_0);
end

// latch CSR0B signal

 always @(posedge CKR0B) begin
  LCSR0 <= CSR0B;
 end

// latch Data out of port0 memory

 always @(posedge CKR0B) begin

  if (BRAMMODE0 == "IOREG")
  begin
    if (LCSR0 == 1'b1)
    begin
      LQ_0 <= RQ_0;
    end
  end
  else
  begin
    if (CSR0B == 1'b1)
    begin
      LQ_0 <= RQ_0;
    end
  end

 end

// port0 Q mux

 always @(RQ_0 or LQ_0) begin

  if (BRAMMODE0 == "IOREG")
  begin
     if (port0_valid == 1'b1)
        Q0 = LQ_0;
  end
  else if (BRAMMODE0 == "OUTREG")
  begin
    Q0 = LQ_0;
  end
  else
  begin
    Q0 = RQ_0;
  end
       // $display("Q0 = %b",Q0);
 end

// latch port1 write addresses, byte wide data lines

 always @(posedge CKW1B) begin

  if (CSW1B == 1)
  begin

     LAW_1 = AW1;
     // $display("LAW_1 = %b",LAW_1);

    if (BW11B == 1)  // byte 1
    begin
       LD1_1 = D1[15:8];
       LD1_17 = D1[17];
       // $display("LD1_1 = %b",LD1_1);
    end

    if (BW10B == 1)  // byte 0
    begin
       LD1_0 = D1[7:0];
       LD1_16 = D1[16];
       // $display("LD1_0 = %b",LD1_0);
    end

    // write port1 data into memory

       if ((BW10B == 1) && (BW11B == 1))
       begin
          MEM[LAW_1] = {LD1_17, LD1_16, LD1_1, LD1_0};
       end

       if ((BW10B == 1) && (BW11B == 0))  // byte 0
       begin
          temp3 = MEM[LAW_1];
          MEM[LAW_1] = {temp3[17], LD1_16, temp3[15:8], LD1_0};
       end

       if ((BW10B == 0) && (BW11B == 1)) // byte 0
       begin
          temp4 = MEM[LAW_1];
          MEM[LAW_1] = {LD1_17, temp4[16], LD1_1, temp4[7:0]};
       end

       memchg1 = ~memchg1;
  end // end port1 CSW1 if

 end // end port1 write always

// latch port1 read addresses

 always @(posedge CKR1B) begin

  if (CSR1B == 1)
  begin

     LAR_1 <= AR1;

  end
 end

// port1 asynchronous read operation

  always @ (AR1) begin
     RADDR1 = AR1;
  end

// mux between latched and regular read address

always @(RADDR1 or LAR_1 or memchg1 or memchg0) begin

       if (BRAMMODE1 == "INREG" || BRAMMODE1 == "IOREG")
       begin
         RQ_1 = MEM[LAR_1];
       end
       else
       begin
         RQ_1 = MEM[RADDR1];
       end

       // $display("RQ_1 = %b",RQ_1);
end

// latch CSR1B signal

 always @(posedge CKR1B) begin
  LCSR1 <= CSR1B;
 end

// latch Data out of port1 memory

 always @(posedge CKR1B) begin

  if (BRAMMODE1 == "IOREG")
  begin
    if (LCSR1 == 1'b1)
    begin
      LQ_1 <= RQ_1;
    end
  end
  else
  begin
    if (CSR1B == 1'b1)
    begin
      LQ_1 <= RQ_1;
    end
  end
 end

// port1 Q mux

 always @(RQ_1 or LQ_1) begin

  if (BRAMMODE1 == "OUTREG" || BRAMMODE1 == "IOREG")
  begin
    Q1 = LQ_1;
  end
  else
  begin
    Q1 = RQ_1;
  end
       // $display("Q1 = %b",Q1);
 end


endmodule

`endcelldefine



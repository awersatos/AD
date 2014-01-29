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
// Simulation Library File for XO
//
// $Header: /home/rlp/Orfdry/env_rcs/verilog/pkg/versclibs/data/orca5mj/RCS/DP8KB.v,v 1.6 2005/09/23 19:00:01 pradeep Exp $ 
//
`timescale 1ns / 1ps
module DP8KB (CEA,CLKA,WEA,CSA0,CSA1,CSA2,RSTA,
              CEB,CLKB,WEB,CSB0,CSB1,CSB2,RSTB,
              DIA0,DIA1,DIA2,DIA3,DIA4,DIA5,DIA6,DIA7,DIA8,
              DIA9,DIA10,DIA11,DIA12,DIA13,DIA14,DIA15,DIA16,DIA17,
              ADA0,ADA1,ADA2,ADA3,ADA4,ADA5,ADA6,ADA7,ADA8,ADA9,ADA10,ADA11,ADA12,
              DIB0,DIB1,DIB2,DIB3,DIB4,DIB5,DIB6,DIB7,DIB8,
              DIB9,DIB10,DIB11,DIB12,DIB13,DIB14,DIB15,DIB16,DIB17,
              ADB0,ADB1,ADB2,ADB3,ADB4,ADB5,ADB6,ADB7,ADB8,ADB9,ADB10,ADB11,ADB12,
              DOA0,DOA1,DOA2,DOA3,DOA4,DOA5,DOA6,DOA7,DOA8,
              DOA9,DOA10,DOA11,DOA12,DOA13,DOA14,DOA15,DOA16,DOA17,
              DOB0,DOB1,DOB2,DOB3,DOB4,DOB5,DOB6,DOB7,DOB8,
              DOB9,DOB10,DOB11,DOB12,DOB13,DOB14,DOB15,DOB16,DOB17);


   parameter  DATA_WIDTH_A = 18;            //1, 2, 4, 9, 18, 36
   parameter  DATA_WIDTH_B = 18;            //1, 2, 4, 9, 18, 36
   parameter  REGMODE_A = "NOREG";          // "NOREG", "OUTREG"
   parameter  REGMODE_B = "NOREG";          // "NOREG", "OUTREG"
   parameter  RESETMODE = "SYNC";          // "ASYNC", "SYNC"
   parameter  CSDECODE_A = 3'b000;          // 3'b000, 3'b001, 3'b010.......3'b111
   parameter  CSDECODE_B = 3'b000;          // 3'b000, 3'b001, 3'b010.......3'b111
   parameter  WRITEMODE_A = "NORMAL";       // "NORMAL", "READBEFOREWRITE", "WRITETHROUGH"
   parameter  WRITEMODE_B = "NORMAL";       // "NORMAL", "READBEFOREWRITE", "WRITETHROUGH"
   parameter  ARRAY_SIZE = 9216;            // Not used
   parameter  GSR = "DISABLED";             // "ENABLED", "DISABLED" 

parameter INITVAL_00 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_01 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_02 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_03 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_04 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_05 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_06 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_07 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_08 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_09 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_0A = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_0B = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_0C = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_0D = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_0E = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_0F = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_10 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_11 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_12 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_13 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_14 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_15 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_16 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_17 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_18 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_19 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_1A = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_1B = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_1C = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_1D = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_1E = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter INITVAL_1F = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;

input    DIA0, DIA1, DIA2, DIA3, DIA4, DIA5, DIA6, DIA7, DIA8,
         DIA9, DIA10, DIA11, DIA12, DIA13, DIA14, DIA15, DIA16, DIA17,
         ADA0, ADA1, ADA2, ADA3, ADA4, ADA5, ADA6, ADA7, ADA8,
         ADA9,  ADA10,  ADA11, ADA12, 
         CEA, CLKA, WEA, CSA0, CSA1, CSA2, RSTA, 
         DIB0, DIB1, DIB2, DIB3, DIB4, DIB5, DIB6, DIB7, DIB8,
         DIB9, DIB10, DIB11, DIB12, DIB13, DIB14, DIB15, DIB16, DIB17,
         ADB0, ADB1, ADB2, ADB3, ADB4, ADB5, ADB6, ADB7, ADB8,
         ADB9,  ADB10,  ADB11, ADB12, 
         CEB, CLKB, WEB, CSB0, CSB1, CSB2, RSTB; 
output   DOA0, DOA1, DOA2, DOA3, DOA4, DOA5, DOA6, DOA7, DOA8,
         DOA9, DOA10, DOA11, DOA12, DOA13, DOA14, DOA15, DOA16, DOA17,
         DOB0, DOB1, DOB2, DOB3, DOB4, DOB5, DOB6, DOB7, DOB8,
         DOB9, DOB10, DOB11, DOB12, DOB13, DOB14, DOB15, DOB16, DOB17;

   parameter ADDR_WIDTH_A = (DATA_WIDTH_A == 1) ? 13 : (DATA_WIDTH_A == 2) ? 12 :
                       (DATA_WIDTH_A == 4) ? 11 : (DATA_WIDTH_A == 9) ? 10 : 
                       (DATA_WIDTH_A == 18) ? 9 : 8 ;
   parameter ADDR_WIDTH_B = (DATA_WIDTH_B == 1) ? 13 : (DATA_WIDTH_B == 2) ? 12 :
                       (DATA_WIDTH_B == 4) ? 11 : (DATA_WIDTH_B == 9) ? 10 : 
                       (DATA_WIDTH_B == 18) ? 9 : 8;
   parameter data_width__a = (DATA_WIDTH_A == 1) ? 1 : (DATA_WIDTH_A == 2) ? 2 :
                       (DATA_WIDTH_A == 4) ? 4 : (DATA_WIDTH_A == 9) ? 9 : 18 ;
   parameter data_width__b = (DATA_WIDTH_B == 1) ? 1 : (DATA_WIDTH_B == 2) ? 2 :
                       (DATA_WIDTH_B == 4) ? 4 : (DATA_WIDTH_B == 9) ? 9 : 18;

   parameter div_a = (DATA_WIDTH_A == 1) ? 8 : (DATA_WIDTH_A == 2) ? 4 :
                       (DATA_WIDTH_A == 4) ? 2 : (DATA_WIDTH_A == 9) ? 9216 : 9216 ;
   parameter div_b = (DATA_WIDTH_B == 1) ? 8 : (DATA_WIDTH_B == 2) ? 4 :
                       (DATA_WIDTH_B == 4) ? 2 : (DATA_WIDTH_B == 9) ? 9216 : 9216;

  tri1 GSR_sig = GSR_INST.GSRNET;
  tri1 PUR_sig = PUR_INST.PURNET;

reg [10239:0] init_value;
reg v_MEM[ARRAY_SIZE - 1:0];
integer i, j;
wire [17:0] DIA;
wire [17:0] DIB;
wire [17:0] DIA_node;
wire [17:0] DIB_node;
wire [17:0] DOA;
wire [17:0] DOB;
wire [12:0] ADA;
wire [12:0] ADB;
wire [2:0] CSA;
wire [2:0] CSB;
wire CEA_node;
wire CEB_node;
wire CLKA_node;
wire CLKB_node;
wire WREA_node;
wire WREB_node;
wire RSTA_node;
wire RSTB_node;
reg         SRN;
reg [17:0] DOA_node;
reg [17:0] DOA_node_tr;
reg [17:0] DOA_node_wt;
reg [17:0] DOA_node_rbr;
reg [17:0] DOB_node;
reg [17:0] DOB_node_tr;
reg [17:0] DOB_node_wt;
reg [17:0] DOB_node_rbr;
reg [35:0] DO_node_tr;
reg [35:0] DO_node_wt;
reg [35:0] DO_node_rbr;
reg CSA_EN;
reg CSB_EN;
wire [ADDR_WIDTH_A-1:0] ADA_node;
wire [ADDR_WIDTH_B-1:0] ADB_node;
assign ADA_node = ADA[12:(13 - ADDR_WIDTH_A)];
assign ADB_node = ADB[12:(13 - ADDR_WIDTH_B)];
wire [35:0] DIAB_node;
reg [35:0] DIAB_reg;
reg [35:0] DIAB_reg_sync;
reg [35:0] DIAB_reg_async;
reg [data_width__a-1:0] DIA_reg;
reg [data_width__a-1:0] DIA_reg_async;
reg [data_width__a-1:0] DIA_reg_sync;
reg [data_width__b-1:0] DIB_reg;
reg [data_width__b-1:0] DIB_reg_async;
reg [data_width__b-1:0] DIB_reg_sync;
reg [ADDR_WIDTH_A-1:0] ADA_reg;
reg [ADDR_WIDTH_A-1:0] ADA_reg_sync;
reg [ADDR_WIDTH_A-1:0] ADA_reg_async;
reg [ADDR_WIDTH_B-1:0] ADB_reg;
reg [ADDR_WIDTH_B-1:0] ADB_reg_sync;
reg [ADDR_WIDTH_B-1:0] ADB_reg_async;
reg [ADDR_WIDTH_A-1:0] ADA_out;
reg [ADDR_WIDTH_B-1:0] ADB_out;
reg [17:0] DOAB_reg;
reg [17:0] DOAB_reg_sync;
reg [17:0] DOAB_reg_async;
reg [17:0] DOA_reg;
reg [17:0] DOA_reg_sync;
reg [17:0] DOA_reg_async;
reg [17:0] DOB_reg;
reg [17:0] DOB_reg_sync;
reg [17:0] DOB_reg_async;
reg [17:0] DOA_out;
reg [17:0] DOB_out;
reg WRENA_reg;
reg WRENA_reg_async;
reg WRENA_reg_sync;
reg WRENB_reg;
reg WRENB_reg_sync;
reg WRENB_reg_async;
reg [ADDR_WIDTH_B-1:0] ADB_read_reg;
reg RENA_reg;
reg RENA_reg_async;
reg RENA_reg_sync;
reg RENB_reg;
reg RENB_reg_sync;
reg RENB_reg_async;
reg CLKA_valid;
reg CLKA_valid_new1;
reg CLKA_valid_new2;
reg CLKA_valid_new3;
reg last_CLKA_valid1;
reg last_CLKA_valid;
reg CLKB_valid;
reg CLKB_valid_new1;
reg CLKB_valid_new2;
reg CLKB_valid_new3;
reg last_CLKB_valid1;
reg last_CLKB_valid;
reg memchg0;
reg memchg1;
reg memchga;
reg memchgb;
integer v_WADDR_A,v_RADDR_A,v_WADDR_B,v_RADDR_B, v_RADDR_RBR_A, v_RADDR_RBR_B;
integer ADDR_A, ADDR_B, DN_ADDR_A, UP_ADDR_A, DN_ADDR_B, UP_ADDR_B;
wire DIA_0, DIB_0;

reg wr_a_wr_b_coll, wr_a_rd_b_coll, rd_a_wr_b_coll; //write & read/write collision flags
integer dn_coll_addr, up_coll_addr; //lower & upper collision addresses

  buf (DIA[0], DIA_0);
  buf (DIA[1], DIA1);
  buf (DIA[2], DIA2);
  buf (DIA[3], DIA3);
  buf (DIA[4], DIA4);
  buf (DIA[5], DIA5);
  buf (DIA[6], DIA6);
  buf (DIA[7], DIA7);
  buf (DIA[8], DIA8);
  buf (DIA[9], DIA9);
  buf (DIA[10], DIA10);
  buf (DIA[11], DIA11);
  buf (DIA[12], DIA12);
  buf (DIA[13], DIA13);
  buf (DIA[14], DIA14);
  buf (DIA[15], DIA15);
  buf (DIA[16], DIA16);
  buf (DIA[17], DIA17);
  buf (DIB[0], DIB_0);
  buf (DIB[1], DIB1);
  buf (DIB[2], DIB2);
  buf (DIB[3], DIB3);
  buf (DIB[4], DIB4);
  buf (DIB[5], DIB5);
  buf (DIB[6], DIB6);
  buf (DIB[7], DIB7);
  buf (DIB[8], DIB8);
  buf (DIB[9], DIB9);
  buf (DIB[10], DIB10);
  buf (DIB[11], DIB11);
  buf (DIB[12], DIB12);
  buf (DIB[13], DIB13);
  buf (DIB[14], DIB14);
  buf (DIB[15], DIB15);
  buf (DIB[16], DIB16);
  buf (DIB[17], DIB17);
  buf (ADA[0], ADA0);
  buf (ADA[1], ADA1);
  buf (ADA[2], ADA2);
  buf (ADA[3], ADA3);
  buf (ADA[4], ADA4);
  buf (ADA[5], ADA5);
  buf (ADA[6], ADA6);
  buf (ADA[7], ADA7);
  buf (ADA[8], ADA8);
  buf (ADA[9], ADA9);
  buf (ADA[10], ADA10);
  buf (ADA[11], ADA11);
  buf (ADA[12], ADA12);
  buf (ADB[0], ADB0);
  buf (ADB[1], ADB1);
  buf (ADB[2], ADB2);
  buf (ADB[3], ADB3);
  buf (ADB[4], ADB4);
  buf (ADB[5], ADB5);
  buf (ADB[6], ADB6);
  buf (ADB[7], ADB7);
  buf (ADB[8], ADB8);
  buf (ADB[9], ADB9);
  buf (ADB[10], ADB10);
  buf (ADB[11], ADB11);
  buf (ADB[12], ADB12);
  buf (CSA[0], CSA0);
  buf (CSA[1], CSA1);
  buf (CSA[2], CSA2);
  buf (CSB[0], CSB0);
  buf (CSB[1], CSB1);
  buf (CSB[2], CSB2);
  buf (CEA_node, CEA);
  buf (CEB_node, CEB);
  buf (CLKA_node, CLKA);
  buf (CLKB_node, CLKB);
  buf (WREA_node, WEA);
  buf (WREB_node, WEB);
  buf (RSTA_node, RSTA);
  buf (RSTB_node, RSTB);
  buf (DOA0, DOA_out[0]);
  buf (DOA1, DOA_out[1]);
  buf (DOA2, DOA_out[2]);
  buf (DOA3, DOA_out[3]);
  buf (DOA4, DOA_out[4]);
  buf (DOA5, DOA_out[5]);
  buf (DOA6, DOA_out[6]);
  buf (DOA7, DOA_out[7]);
  buf (DOA8, DOA_out[8]);
  buf (DOA9, DOA_out[9]);
  buf (DOA10, DOA_out[10]);
  buf (DOA11, DOA_out[11]);
  buf (DOA12, DOA_out[12]);
  buf (DOA13, DOA_out[13]);
  buf (DOA14, DOA_out[14]);
  buf (DOA15, DOA_out[15]);
  buf (DOA16, DOA_out[16]);
  buf (DOA17, DOA_out[17]);
  buf (DOB0, DOB_out[0]);
  buf (DOB1, DOB_out[1]);
  buf (DOB2, DOB_out[2]);
  buf (DOB3, DOB_out[3]);
  buf (DOB4, DOB_out[4]);
  buf (DOB5, DOB_out[5]);
  buf (DOB6, DOB_out[6]);
  buf (DOB7, DOB_out[7]);
  buf (DOB8, DOB_out[8]);
  buf (DOB9, DOB_out[9]);
  buf (DOB10, DOB_out[10]);
  buf (DOB11, DOB_out[11]);
  buf (DOB12, DOB_out[12]);
  buf (DOB13, DOB_out[13]);
  buf (DOB14, DOB_out[14]);
  buf (DOB15, DOB_out[15]);
  buf (DOB16, DOB_out[16]);
  buf (DOB17, DOB_out[17]);

  initial
  begin
    init_value = {INITVAL_1F, INITVAL_1E, INITVAL_1D, INITVAL_1C, INITVAL_1B, INITVAL_1A,
    INITVAL_19, INITVAL_18, INITVAL_17,
    INITVAL_16, INITVAL_15, INITVAL_14, INITVAL_13, INITVAL_12, INITVAL_11, INITVAL_10,
    INITVAL_0F, INITVAL_0E, INITVAL_0D, INITVAL_0C, INITVAL_0B, INITVAL_0A, INITVAL_09,
    INITVAL_08, INITVAL_07, INITVAL_06, INITVAL_05, INITVAL_04, INITVAL_03, INITVAL_02,
    INITVAL_01, INITVAL_00};

    for (j = 0; j < 512; j = j+1)
    begin
       for (i = 0; i < 18; i = i+1)
       begin
           v_MEM[(18 * j) + i] = init_value[(20 * j) + i]; 
       end
    end
  end

  initial
  begin
     DOA_node = 0;
     DOA_node_tr = 0;
     DOA_node_wt = 0;
     DOA_node_rbr = 0;
     DOB_node = 0;
     DOB_node_tr = 0;
     DOB_node_wt = 0;
     DOB_node_rbr = 0;
     DO_node_tr = 0;
     DO_node_wt = 0;
     DO_node_rbr = 0;

     DIA_reg = 0;
     DIAB_reg = 0;
     ADA_reg = 0;
     WRENA_reg = 0;
     RENA_reg = 0;
     DIB_reg = 0;
     ADB_reg = 0;
     WRENB_reg = 0;
     RENB_reg = 0;
  end

  initial
  begin
     wr_a_wr_b_coll = 1'b0;
     wr_a_rd_b_coll = 1'b0;
     rd_a_wr_b_coll = 1'b0;
     memchg0 = 1'b0;
     memchg1 = 1'b0;
     memchga = 1'b0;
     memchgb = 1'b0;
     CLKA_valid = 1'b0;
     CLKA_valid_new1 = 1'b0;
     CLKA_valid_new2 = 1'b0;
     CLKA_valid_new3 = 1'b0;
     CLKB_valid = 1'b0;
     CLKB_valid_new1 = 1'b0;
     CLKB_valid_new2 = 1'b0;
     CLKB_valid_new3 = 1'b0;
     last_CLKA_valid = 1'b0;
     last_CLKA_valid1 = 1'b0;
     last_CLKB_valid = 1'b0;
     last_CLKB_valid1 = 1'b0;
  end

always @ (CLKA_valid, CLKB_valid, last_CLKA_valid1, last_CLKB_valid1)
begin
   last_CLKA_valid1 <= CLKA_valid;
   last_CLKB_valid1 <= CLKB_valid;
   last_CLKA_valid <= last_CLKA_valid1;
   last_CLKB_valid <= last_CLKB_valid1;
end

  assign DIA_0 = (DATA_WIDTH_A == 1) ? DIA11 : (DATA_WIDTH_A == 2) ? DIA11 : DIA0;
  assign DIB_0 = (DATA_WIDTH_A < 36 & DATA_WIDTH_B == 1) ? DIB11 : (DATA_WIDTH_A < 36 & DATA_WIDTH_B == 2) ? DIB11 : DIB0;

  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED") begin
      SRN = GSR_sig & PUR_sig ;
    end
    else if (GSR == "DISABLED")
      SRN = PUR_sig;
  end

  always @ (CSA)
  begin
     if (CSA == 3'b0 && CSDECODE_A == 3'b000)
        CSA_EN = 1'b1;
     else if (CSA == 3'b001 && CSDECODE_A == 3'b001)
        CSA_EN = 1'b1;
     else if (CSA == 3'b010 && CSDECODE_A == 3'b010)
        CSA_EN = 1'b1;
     else if (CSA == 3'b011 && CSDECODE_A == 3'b011)
        CSA_EN = 1'b1;
     else if (CSA == 3'b100 && CSDECODE_A == 3'b100)
        CSA_EN = 1'b1;
     else if (CSA == 3'b101 && CSDECODE_A == 3'b101)
        CSA_EN = 1'b1;
     else if (CSA == 3'b110 && CSDECODE_A == 3'b110)
        CSA_EN = 1'b1;
     else if (CSA == 3'b111 && CSDECODE_A == 3'b111)
        CSA_EN = 1'b1;
     else
        CSA_EN = 1'b0;
  end

  always @ (CSB)
  begin
     if (CSB == 3'b0 && CSDECODE_B == 3'b000)
        CSB_EN = 1'b1;
     else if (CSB == 3'b001 && CSDECODE_B == 3'b001)
        CSB_EN = 1'b1;
     else if (CSB == 3'b010 && CSDECODE_B == 3'b010)
        CSB_EN = 1'b1;
     else if (CSB == 3'b011 && CSDECODE_B == 3'b011)
        CSB_EN = 1'b1;
     else if (CSB == 3'b100 && CSDECODE_B == 3'b100)
        CSB_EN = 1'b1;
     else if (CSB == 3'b101 && CSDECODE_B == 3'b101)
        CSB_EN = 1'b1;
     else if (CSB == 3'b110 && CSDECODE_B == 3'b110)
        CSB_EN = 1'b1;
     else if (CSB == 3'b111 && CSDECODE_B == 3'b111)
        CSB_EN = 1'b1;
     else
        CSB_EN = 1'b0;
  end

assign DIA_node = (data_width__a == 1) ? DIA[0] :
             (data_width__a == 2) ? DIA[1:0] :
             (data_width__a == 4) ? DIA[3:0] :
             (data_width__a == 9) ? DIA[8:0] : DIA[17:0];
assign DIB_node = (data_width__b == 1) ? DIB[0] :
             (data_width__b == 2) ? DIB[1:0] :
             (data_width__b == 4) ? DIB[3:0] :
             (data_width__b == 9) ? DIB[8:0] : DIB[17:0];

assign DIAB_node = {DIB, DIA};


   not (SR1, SRN);
   or INST1 (RSTA_sig, RSTA_node, SR1);
   or INST2 (RSTB_sig, RSTB_node, SR1);

   always @ (SR1 or DIA_node or ADA or WREA_node or CSA_EN) 
   begin
      if (SR1 == 1)
      begin
         assign DIA_reg = 0;
         assign DIAB_reg = 0;
         assign ADA_reg = 0;
         assign WRENA_reg = 0;
         assign RENA_reg = 0;
      end
      else
      begin
         deassign DIA_reg;
         deassign DIAB_reg;
         deassign ADA_reg;
         deassign WRENA_reg;
         deassign RENA_reg;
      end
   end

   always @(posedge RSTA_sig or posedge CLKA_node)
   begin
      if (RSTA_sig == 1)
      begin
         DIA_reg_async <= 0;
         DIAB_reg_async <= 0;
         ADA_reg_async <= 0;
         WRENA_reg_async <= 0;
         RENA_reg_async <= 0;
      end
      else
      begin
         if (CEA_node == 1)
         begin
            DIA_reg_async <= DIA_node[data_width__a-1:0];
            DIAB_reg_async <= DIAB_node;
            ADA_reg_async <= ADA_node;
            WRENA_reg_async <= WREA_node & CSA_EN;
            RENA_reg_async <= ~WREA_node & CSA_EN;
         end
      end
   end
 
   always @(posedge CLKA_node)
   begin   
      if (RSTA_sig == 1)
      begin
         DIA_reg_sync <= 0;
         DIAB_reg_sync <= 0;
         ADA_reg_sync <= 0;
         WRENA_reg_sync <= 0;
         RENA_reg_sync <= 0;
      end
      else
      begin
         if (CEA_node == 1)
         begin
            DIA_reg_sync <= DIA_node[data_width__a-1:0];
            DIAB_reg_sync <= DIAB_node;
            ADA_reg_sync <= ADA_node;
            WRENA_reg_sync <= WREA_node & CSA_EN;
            RENA_reg_sync <= ~WREA_node & CSA_EN;
         end
      end
   end

   always @(DIA_reg_sync or DIAB_reg_sync or  ADA_reg_sync or
   WRENA_reg_sync or RENA_reg_sync or DIA_reg_async or DIAB_reg_async or  
   ADA_reg_async or WRENA_reg_async or RENA_reg_async)
   begin
      if (RESETMODE == "ASYNC")
      begin
         DIA_reg <= DIA_reg_async;
         DIAB_reg <= DIAB_reg_async;
         ADA_reg <= ADA_reg_async;
         WRENA_reg <= WRENA_reg_async;
         RENA_reg <= RENA_reg_async;
      end
      else
      begin
         DIA_reg <= DIA_reg_sync;
         DIAB_reg <= DIAB_reg_sync;
         ADA_reg <= ADA_reg_sync;
         WRENA_reg <= WRENA_reg_sync;
         RENA_reg <= RENA_reg_sync;
      end
   end

   always @ (SR1 or DIB_node or ADB or WREB_node or CSB_EN) 
   begin
      if (SR1 == 1)
      begin
         assign DIB_reg = 0;
         assign ADB_reg = 0;
         assign WRENB_reg = 0;
         assign RENB_reg = 0;
      end
      else
      begin
         deassign DIB_reg;
         deassign ADB_reg;
         deassign WRENB_reg;
         deassign RENB_reg;
      end
   end

   always @(posedge RSTB_sig or posedge CLKB_node)
   begin
      if (RSTB_sig == 1)
      begin
         DIB_reg_async <= 0;
         ADB_reg_async <= 0;
         WRENB_reg_async <= 0;
         RENB_reg_async <= 0;
      end
      else
      begin
         if (CEB_node == 1)
         begin
            DIB_reg_async <= DIB_node[data_width__b-1:0];
            ADB_reg_async <= ADB_node;
            WRENB_reg_async <= WREB_node & CSB_EN;
            RENB_reg_async <= ~WREB_node & CSB_EN;
         end
      end
   end

   always @(posedge CLKA_node)
   begin
      if (RSTA_sig == 1)
         CLKA_valid_new1 <= 0;
      else
         begin
         if (CEA_node == 1)
         begin
            if (CSA_EN == 1)
            begin
               CLKA_valid_new1 <= 1;
               #0.2 CLKA_valid_new1 = 0;
            end
            else
               CLKA_valid_new1 <= 0;
         end
         else
            CLKA_valid_new1 <= 0;
      end
   end

   always @(posedge CLKB_node)
   begin
      if (RSTB_sig == 1)
         CLKB_valid_new1 <= 0;
      else
      begin
         if (CEB_node == 1)
         begin
            if (CSB_EN == 1)
            begin
               CLKB_valid_new1 <= 1;
               #0.2 CLKB_valid_new1 = 0;
            end
            else
               CLKB_valid_new1 <= 0;
         end
         else
            CLKB_valid_new1 <= 0;
      end
   end

   always @(CLKA_valid_new1 or CLKA_valid_new2 or CLKA_valid_new3)
   begin
      CLKA_valid_new2 <= CLKA_valid_new1;
      CLKA_valid_new3 <= CLKA_valid_new2;
      CLKA_valid <= CLKA_valid_new3;
   end

   always @(CLKB_valid_new1 or CLKB_valid_new2 or CLKB_valid_new3)
   begin
      CLKB_valid_new2 <= CLKB_valid_new1;
      CLKB_valid_new3 <= CLKB_valid_new2;
      CLKB_valid <= CLKB_valid_new3;
   end
 
   always @(posedge CLKB_node)
   begin   
      if (RSTB_sig == 1)
      begin
         DIB_reg_sync <= 0;
         ADB_reg_sync <= 0;
         WRENB_reg_sync <= 0;
         RENB_reg_sync <= 0;
      end
      else
      begin
         if (CEB_node == 1)
         begin
            DIB_reg_sync <= DIB_node[data_width__b-1:0];
            ADB_reg_sync <= ADB_node;
            WRENB_reg_sync <= WREB_node & CSB_EN;
            RENB_reg_sync <= ~WREB_node & CSB_EN;
         end
      end
   end

   always @(DIB_reg_sync or ADB_reg_sync or WRENB_reg_sync or RENB_reg_sync or
   DIB_reg_async or ADB_reg_async or WRENB_reg_async or RENB_reg_async) 
   begin
      if (RESETMODE == "ASYNC")
      begin
         DIB_reg <= DIB_reg_async;
         ADB_reg <= ADB_reg_async;
         WRENB_reg <= WRENB_reg_async;
         RENB_reg <= RENB_reg_async;
      end
      else
      begin
         DIB_reg <= DIB_reg_sync;
         ADB_reg <= ADB_reg_sync;
         WRENB_reg <= WRENB_reg_sync;
         RENB_reg <= RENB_reg_sync;
      end
   end

//----------------------------

   always @(ADA_reg or ADB_reg or WRENA_reg or WRENB_reg or CLKA_valid_new2 or CLKB_valid_new2 or
   RENA_reg or RENB_reg)
   begin
      ADDR_A = ADA_reg;
      ADDR_B = ADB_reg;
      //DN_ADDR_A = ADDR_A * DATA_WIDTH_A;
      //UP_ADDR_A = (((ADDR_A + 1) * DATA_WIDTH_A) - 1);
      //DN_ADDR_B = ADDR_B * DATA_WIDTH_B;
      //UP_ADDR_B = (((ADDR_B + 1) * DATA_WIDTH_B) - 1);

		DN_ADDR_A = (ADDR_A * DATA_WIDTH_A) + (ADDR_A / div_a);
		UP_ADDR_A = DN_ADDR_A + (DATA_WIDTH_A - 1);
		DN_ADDR_B = (ADDR_B * DATA_WIDTH_B) + (ADDR_B / div_b);
		UP_ADDR_B = DN_ADDR_B + (DATA_WIDTH_B - 1);

                if (~((UP_ADDR_B < DN_ADDR_A) || (DN_ADDR_B > UP_ADDR_A)))
                begin
                   if (wr_a_wr_b_coll == 1'b1)
                   begin
                      if (CLKA_valid_new2 == 1'b0 && CLKB_valid_new2 == 1'b0)
                         wr_a_wr_b_coll = 1'b0;
                   end
                end
                else
                begin
                   wr_a_wr_b_coll = 1'b0;
                end

                if (~((UP_ADDR_B < DN_ADDR_A) || (DN_ADDR_B > UP_ADDR_A)))
                begin
                   if (wr_a_rd_b_coll == 1'b1)
                   begin
                      if (CLKA_valid_new2 == 1'b0 && CLKB_valid_new2 == 1'b0)
                         wr_a_rd_b_coll = 1'b0;
                   end
                end
                else
                begin
                   wr_a_rd_b_coll = 1'b0;
                end

                if (~((UP_ADDR_A < DN_ADDR_B) || (DN_ADDR_A > UP_ADDR_B)))
                begin
                   if (rd_a_wr_b_coll == 1'b1)
                   begin
                      if (CLKA_valid_new2 == 1'b0 && CLKB_valid_new2 == 1'b0)
                         rd_a_wr_b_coll = 1'b0;
                   end
                end
                else
                begin
                   rd_a_wr_b_coll = 1'b0;
                end

		if (~((UP_ADDR_B < DN_ADDR_A) || (DN_ADDR_B > UP_ADDR_A)))
		begin
			if ((DN_ADDR_A > DN_ADDR_B) && (UP_ADDR_A < UP_ADDR_B))
			begin
				dn_coll_addr = DN_ADDR_A;
				up_coll_addr = UP_ADDR_A;
			end
			else if ((DN_ADDR_B > DN_ADDR_A) && (UP_ADDR_B < UP_ADDR_A))
			begin
				dn_coll_addr = DN_ADDR_B;
				up_coll_addr = UP_ADDR_B;
			end
			else if ((UP_ADDR_A - DN_ADDR_B) <= (UP_ADDR_B - DN_ADDR_A))
			begin
				dn_coll_addr = DN_ADDR_B;
				up_coll_addr = UP_ADDR_A;
			end
			else
			begin
				dn_coll_addr = DN_ADDR_A;
				up_coll_addr = UP_ADDR_B;
			end
		end

// Write collision

      if ((WRENA_reg == 1 && CLKA_valid_new2 == 1) && (WRENB_reg == 1 && CLKB_valid_new2 == 1))
      begin
         if (~((UP_ADDR_B < DN_ADDR_A) || (DN_ADDR_B > UP_ADDR_A)))
         begin
//            $display ("Warning! Block-Ram instance, %m:",
//                      "\n\t simulation time:",$time,
//                      "\n\t has possible write address collision.");
				wr_a_wr_b_coll = 1;
         end
      end

      if ((WRENA_reg == 1 && CLKA_valid_new2 == 1) && (RENB_reg == 1 && CLKB_valid_new2 == 1))
      begin
         if (~((UP_ADDR_B < DN_ADDR_A) || (DN_ADDR_B > UP_ADDR_A)))
         begin
//            $display ("Warning! Block-Ram instance, %m:",
//                      "\n\t simulation time:",$time,
//                      "\n\t has possible write (Port A) and read (Port B) address collision.");
				wr_a_rd_b_coll = 1;
         end
      end

      if ((RENA_reg == 1 && CLKA_valid_new2 == 1) && (WRENB_reg == 1 && CLKB_valid_new2 == 1))
      begin
         if (~((UP_ADDR_A < DN_ADDR_B) || (DN_ADDR_A > UP_ADDR_B)))
         begin
//            $display ("Warning! Block-Ram instance, %m:",
//                      "\n\t simulation time:",$time,
//                      "\n\t has possible write (Port B) and read (Port A) address collision.");
				rd_a_wr_b_coll = 1;
         end
      end

   end

//----------------------------

   always @(posedge CLKA_valid or posedge CLKB_valid) 
   begin
      v_WADDR_A = ADA_reg;
      v_WADDR_B = ADB_reg;
      memchg0 <= ~memchg0;
 
      if (DATA_WIDTH_A == 36)
      begin
         if (WRENA_reg == 1 && CLKA_valid == 1)
         begin
            for (i = 0; i < DATA_WIDTH_A; i = i+1)
            begin
                 DO_node_rbr[i] = v_MEM[v_WADDR_A * DATA_WIDTH_A + i];
            end
            DOA_node_rbr = DO_node_rbr[17:0];
            DOB_node_rbr = DO_node_rbr[35:18];

               for (i = 0; i < 9; i = i+1)
               begin
                  v_MEM[v_WADDR_A * DATA_WIDTH_A + i] = DIAB_reg[i];
               end
               for (i = 0; i < 9; i = i+1)
               begin
                  v_MEM[v_WADDR_A * DATA_WIDTH_A + i + 9] = DIAB_reg[i + 9];
               end
               for (i = 0; i < 9; i = i+1)
               begin
                  v_MEM[v_WADDR_A * DATA_WIDTH_A + i + 18] = DIAB_reg[i + 18];
               end
               for (i = 0; i < 9; i = i+1)
               begin
                  v_MEM[v_WADDR_A * DATA_WIDTH_A + i + 27] = DIAB_reg[i + 27];
               end
            memchga <= ~memchga;
         end
      end
      else
      begin
         if (DATA_WIDTH_A == 18)
         begin
            if (WRENA_reg == 1 && CLKA_valid == 1)
            begin
               for (i = 0; i < DATA_WIDTH_A; i = i+1)
               begin
                  DOA_node_rbr[i] = v_MEM[(v_WADDR_A * DATA_WIDTH_A) + (v_WADDR_A / div_a) + i];
               end

                  for (i = 0; i < 9; i = i+1)
                  begin
                       v_MEM[v_WADDR_A * data_width__a + i] = DIA_reg[i];
							  if ( (wr_a_wr_b_coll == 1) &&
								   ((v_WADDR_A * data_width__a + i) >= dn_coll_addr) &&
								   ((v_WADDR_A * data_width__a + i) <= up_coll_addr) )
								 v_MEM[v_WADDR_A * data_width__a + i] = 1'bX;
                  end
                  for (i = 0; i < 9; i = i+1)
                  begin
                       v_MEM[v_WADDR_A * data_width__a + i + 9] = DIA_reg[i + 9];
							  if ( (wr_a_wr_b_coll == 1) &&
								   ((v_WADDR_A * data_width__a + i + 9) >= dn_coll_addr) &&
								   ((v_WADDR_A * data_width__a + i + 9) <= up_coll_addr) )
								 v_MEM[v_WADDR_A * data_width__a + i + 9] = 1'bX;
                  end
               memchga <= ~memchga;
            end
         end
         else if (DATA_WIDTH_A == 9)
         begin
            if (WRENA_reg == 1 && CLKA_valid == 1)
            begin
               for (i = 0; i < DATA_WIDTH_A; i = i+1)
               begin
                  DOA_node_rbr[i] = v_MEM[(v_WADDR_A * DATA_WIDTH_A) + (v_WADDR_A / div_a) + i];
               end

               for (i = 0; i < data_width__a; i = i+1)
                 begin
                      v_MEM[(v_WADDR_A * data_width__a) + i] = DIA_reg[i];
							 if ( (wr_a_wr_b_coll == 1) &&
							      (((v_WADDR_A * data_width__a) + i) >= dn_coll_addr) &&
							      (((v_WADDR_A * data_width__a) + i) <= up_coll_addr) )
							    v_MEM[(v_WADDR_A * data_width__a) + i] = 1'bX;
                 end
               memchga <= ~memchga;
            end
         end
         else
         begin
            if (WRENA_reg == 1 && CLKA_valid == 1)
            begin
               for (i = 0; i < DATA_WIDTH_A; i = i+1)
               begin
                  DOA_node_rbr[i] = v_MEM[(v_WADDR_A * DATA_WIDTH_A) + (v_WADDR_A / div_a) + i];
               end
               for (i = 0; i < data_width__a; i = i+1)
                 begin
                      v_MEM[(v_WADDR_A * data_width__a) + (v_WADDR_A / div_a) + i] = DIA_reg[i];
							 if ( (wr_a_wr_b_coll == 1) &&
							      (((v_WADDR_A * data_width__a) + (v_WADDR_A / div_a) + i) >= dn_coll_addr) &&
							      (((v_WADDR_A * data_width__a) + (v_WADDR_A / div_a) + i) <= up_coll_addr) )
							    v_MEM[(v_WADDR_A * data_width__a) + (v_WADDR_A / div_a) + i] = 1'bX;
                 end
               memchga <= ~memchga;
            end
         end

         if (DATA_WIDTH_B == 18)
         begin
            if (WRENB_reg == 1 && CLKB_valid == 1)
            begin
               for (i = 0; i < DATA_WIDTH_B; i = i+1)
               begin
                  DOB_node_rbr[i] = v_MEM[(v_WADDR_B * DATA_WIDTH_B) + (v_WADDR_B / div_b) + i];
               end

                  for (i = 0; i < 9; i = i+1)
                  begin
                      v_MEM[v_WADDR_B * data_width__b + i] = DIB_reg[i];
							 if ( (wr_a_wr_b_coll == 1) &&
							      ((v_WADDR_B * data_width__b + i) >= dn_coll_addr) &&
							      ((v_WADDR_B * data_width__b + i) <= up_coll_addr) )
							    v_MEM[v_WADDR_B * data_width__b + i] = 1'bX;
                  end
                  for (i = 0; i < 9; i = i+1)
                  begin
                       v_MEM[v_WADDR_B * data_width__b + i + 9] = DIB_reg[i + 9];
							  if ( (wr_a_wr_b_coll == 1) &&
							      ((v_WADDR_B * data_width__b + i + 9) >= dn_coll_addr) &&
							      ((v_WADDR_B * data_width__b + i + 9) <= up_coll_addr) )
							    v_MEM[v_WADDR_B * data_width__b + i + 9] = 1'bX;
                  end
               memchgb <= ~memchgb;
            end
         end
         else if (DATA_WIDTH_B == 9)
         begin
            if (WRENB_reg == 1 && CLKB_valid == 1)
            begin
               for (i = 0; i < DATA_WIDTH_B; i = i+1)
               begin
                  DOB_node_rbr[i] = v_MEM[(v_WADDR_B * DATA_WIDTH_B) + (v_WADDR_B / div_b) + i];
               end

               for (i = 0; i < data_width__b; i = i+1)
                 begin
                      v_MEM[(v_WADDR_B * data_width__b) + i] = DIB_reg[i];
							 if ( (wr_a_wr_b_coll == 1) &&
							      (((v_WADDR_B * data_width__b) + i) >= dn_coll_addr) &&
							      (((v_WADDR_B * data_width__b) + i) <= up_coll_addr) )
							    v_MEM[(v_WADDR_B * data_width__b) + i] = 1'bX;
                 end
               memchgb <= ~memchgb;
            end
         end
         else
         begin
            if (WRENB_reg == 1 && CLKB_valid == 1)
            begin
               for (i = 0; i < DATA_WIDTH_B; i = i+1)
               begin
                  DOB_node_rbr[i] = v_MEM[(v_WADDR_B * DATA_WIDTH_B) + (v_WADDR_B / div_b) + i];
               end

               for (i = 0; i < data_width__b; i = i+1)
               begin
                    v_MEM[(v_WADDR_B * data_width__b) + (v_WADDR_B / div_b) + i] = DIB_reg[i];
						  if ( (wr_a_wr_b_coll == 1) &&
							      (((v_WADDR_B * data_width__b) + (v_WADDR_B / div_b) + i) >= dn_coll_addr) &&
							      (((v_WADDR_B * data_width__b) + (v_WADDR_B / div_b) + i) <= up_coll_addr) )
							    v_MEM[(v_WADDR_B * data_width__b) + (v_WADDR_B / div_b) + i] = 1'bX;
               end
               memchgb <= ~memchgb;
            end
         end
      end
   end

// Read operation
   always @(RENA_reg or RENB_reg or ADA_reg or ADB_reg or memchg0 or CLKA_valid or CLKB_valid or  posedge RSTA_sig or posedge RSTB_sig) 
   begin
      v_RADDR_A = ADA_reg;
      v_RADDR_B = ADB_reg;

      if (DATA_WIDTH_B == 36)
      begin
         if (RSTB_sig == 1'b1)
         begin
            if (RESETMODE == "SYNC")
            begin
               if (CLKB_node ==  1'b1)
               begin
                  DOA_node <= 0;
                  DOB_node <= 0;
               end
            end
            else
            begin
               DOA_node <= 0;
               DOB_node <= 0;
            end
         end
         else if (CLKB_valid === 1'b1 && last_CLKB_valid === 1'b0)
         begin
            if (RENB_reg == 1)
            begin

               for (i = 0; i < DATA_WIDTH_B; i = i+1)
               begin
                    DO_node_tr[i] = v_MEM[v_RADDR_B * DATA_WIDTH_B + i];
						  if ( (wr_a_rd_b_coll == 1) &&
							    ((v_RADDR_B * DATA_WIDTH_B + i) >= dn_coll_addr) &&
							    ((v_RADDR_B * DATA_WIDTH_B + i) <= up_coll_addr) )
							  DO_node_tr[i] = 1'bX;
               end
               DOB_node <= DO_node_tr[35:18];
               DOA_node <= DO_node_tr[17:0];
            end
            else if (RENB_reg == 0)
            begin
               if (WRITEMODE_B == "WRITETHROUGH")
               begin
                  for (i = 0; i < DATA_WIDTH_B; i = i+1)
                  begin
                     DO_node_wt[i] = v_MEM[v_RADDR_B * DATA_WIDTH_B + i];
                  end
                  DOB_node <= DO_node_wt[35:18];
                  DOA_node <= DO_node_wt[17:0];
               end
               else if (WRITEMODE_B == "READBEFOREWRITE")
               begin
                  DOB_node <= DO_node_rbr[35:18];
                  DOA_node <= DO_node_rbr[17:0];
               end
            end
         end
      end
      else
      begin
         if (RSTA_sig == 1'b1)
         begin
            if (RESETMODE == "SYNC")
            begin
               if (CLKA_node ==  1'b1)
               begin
                  DOA_node <= 0;
               end
            end
            else
            begin
               DOA_node <= 0;
            end
         end
         else if (CLKA_valid == 1'b1)
         begin
            if (RENA_reg == 1)
            begin
               if (last_CLKA_valid == 1'b0)
               begin
                  for (i = 0; i < DATA_WIDTH_A; i = i+1)
                  begin
                  //DOA_node[i] <= v_MEM[(v_RADDR_A * DATA_WIDTH_A) + (v_RADDR_A / div_a) + i];
						if ( (rd_a_wr_b_coll == 1) &&
							  (((v_RADDR_A * DATA_WIDTH_A) + (v_RADDR_A / div_a) + i) >= dn_coll_addr) &&
							  (((v_RADDR_A * DATA_WIDTH_A) + (v_RADDR_A / div_a) + i) <= up_coll_addr) )
							DOA_node[i] <= 1'bX;
						else
							DOA_node[i] <= v_MEM[(v_RADDR_A * DATA_WIDTH_A) + (v_RADDR_A / div_a) + i];
                  end
               end
            end
            else if (RENA_reg == 0)
            begin
               if (WRITEMODE_A == "WRITETHROUGH")
               begin
                  for (i = 0; i < DATA_WIDTH_A; i = i+1)
                  begin
                     DOA_node[i] <= v_MEM[(v_RADDR_A * DATA_WIDTH_A) + (v_RADDR_A / div_a) + i];
                  end
               end
               else if (WRITEMODE_A == "READBEFOREWRITE")
               begin
                  if (last_CLKA_valid == 1'b0)
                  begin
                     DOA_node <= DOA_node_rbr;
                  end
               end
            end
         end

         if (RSTB_sig == 1'b1)
         begin
            if (RESETMODE == "SYNC")
            begin
               if (CLKB_node ==  1'b1)
               begin
                  DOB_node <= 0;
               end
            end
            else
            begin
               DOB_node <= 0;
            end
         end
         else if (CLKB_valid == 1'b1)
         begin
            if (RENB_reg == 1)
            begin
               if (last_CLKB_valid == 1'b0)
               begin
                  for (i = 0; i < DATA_WIDTH_B; i = i+1)
                  begin
                  //DOB_node[i] <= v_MEM[(v_RADDR_B * DATA_WIDTH_B) + (v_RADDR_B / div_b) + i];
						if ( (wr_a_rd_b_coll == 1) &&
							  (((v_RADDR_B * DATA_WIDTH_B) + (v_RADDR_B / div_b) + i) >= dn_coll_addr) &&
							  (((v_RADDR_B * DATA_WIDTH_B) + (v_RADDR_B / div_b) + i) <= up_coll_addr) )
							DOB_node[i] <= 1'bX;
						else
							DOB_node[i] <= v_MEM[(v_RADDR_B * DATA_WIDTH_B) + (v_RADDR_B / div_b) + i];
                  end
               end
            end
            else if (RENB_reg == 0)
            begin
               if (WRITEMODE_B == "WRITETHROUGH")
               begin
                  for (i = 0; i < DATA_WIDTH_B; i = i+1)
                  begin
                     DOB_node[i] <= v_MEM[(v_RADDR_B * DATA_WIDTH_B) + (v_RADDR_B / div_b) + i];
                  end
               end
               else if (WRITEMODE_B == "READBEFOREWRITE")
               begin
                  if (last_CLKB_valid == 1'b0)
                  begin
                     DOB_node <= DOB_node_rbr;
                  end
               end
            end
         end
      end
   end

   always @ (SR1 or DOB_node or DOA_node)
   begin
      if (SR1 == 1)
      begin
         assign DOA_reg = 0;
         assign DOAB_reg = 0;
         assign DOB_reg = 0;
      end
      else
      begin
         deassign DOA_reg;
         deassign DOAB_reg;
         deassign DOB_reg;
      end
   end

   always @(posedge RSTA_sig or posedge CLKA_node)
   begin
      if (RSTA_sig == 1)
         DOA_reg_async <= 0;
      else
      begin
         if (CEA_node == 1)
            DOA_reg_async <= DOA_node;
      end
   end

   always @(posedge CLKA_node)
   begin
      if (CEA_node == 1)
      begin
         if (RSTA_sig == 1)
            DOA_reg_sync <= 0;
         else
            DOA_reg_sync <= DOA_node;
      end
   end

   always @(posedge RSTB_sig or posedge CLKB_node)
   begin
      if (RSTB_sig == 1)
      begin
         DOB_reg_async <= 0;
         DOAB_reg_async <= 0;
      end
      else
      begin
         if (CEB_node == 1)
         begin
            DOB_reg_async <= DOB_node;
            DOAB_reg_async <= DOA_node;
         end
      end
   end

   always @(posedge CLKB_node)
   begin
      if (CEB_node == 1)
      begin
         if (RSTB_sig == 1)
         begin
            DOB_reg_sync <= 0;
            DOAB_reg_sync <= 0;
         end
         else
         begin
            DOB_reg_sync <= DOB_node;
            DOAB_reg_sync <= DOA_node;
         end
      end
   end

   always @(DOA_reg_sync or DOA_reg_async or DOB_reg_sync or DOB_reg_async or DOAB_reg_sync or
   DOAB_reg_async)
   begin
      if (RESETMODE == "ASYNC")
      begin
         DOB_reg <= DOB_reg_async;
         DOA_reg <= DOA_reg_async;
         DOAB_reg <= DOAB_reg_async;
      end
      else
      begin
         DOB_reg <= DOB_reg_sync;
         DOA_reg <= DOA_reg_sync;
         DOAB_reg <= DOAB_reg_sync;
      end
   end

   always @(DOA_reg or DOB_reg or DOAB_reg or DOA_node or DOB_node)
   begin
      if (REGMODE_A == "OUTREG") 
      begin
         if (DATA_WIDTH_B == 36)
            DOA_out <= DOAB_reg;
         else
            DOA_out <= DOA_reg;
      end
      else
      begin
         DOA_out <= DOA_node;
      end

      if (REGMODE_B == "OUTREG") 
         DOB_out <= DOB_reg;
      else
         DOB_out <= DOB_node;
   end


   
endmodule


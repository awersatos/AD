// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_RAMB16_S36.v,v 1.7 2005/03/14 23:01:02 wloo Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  16K-Bit Data and 2K-Bit Parity Single Port Block RAM
// /___/   /\     Filename : X_RAMB16_S36.v
// \   \  /  \    Timestamp : Thu Mar 10 16:44:00 PST 2005
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/10/05 - Added LOC parameter, removed GSR port
// End Revision

`ifdef legacy_model

`timescale 1 ps/1 ps

module X_RAMB16_S36 (DO, DOP, ADDR, CLK, DI, DIP, EN, SSR, WE);

    parameter INIT = 36'h0;
    parameter SRVAL = 36'h0;
    parameter WRITE_MODE = "WRITE_FIRST";

    parameter LOC = "UNPLACED";
    parameter INIT_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_10 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_11 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_12 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_13 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_14 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_15 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_16 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_17 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_18 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_19 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_20 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_21 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_22 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_23 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_24 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_25 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_26 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_27 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_28 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_29 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_30 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_31 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_32 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_33 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_34 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_35 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_36 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_37 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_38 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_39 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;

    output [31:0] DO;
    output [3:0] DOP;
    reg do0_out, do1_out, do2_out, do3_out, do4_out, do5_out, do6_out, do7_out, do8_out, do9_out, do10_out, do11_out, do12_out, do13_out, do14_out, do15_out, do16_out, do17_out, do18_out, do19_out, do20_out, do21_out, do22_out, do23_out, do24_out, do25_out, do26_out, do27_out, do28_out, do29_out, do30_out, do31_out;
    reg dop0_out, dop1_out, dop2_out, dop3_out;

    input [8:0] ADDR;
    input [31:0] DI;
    input [3:0] DIP;
    input EN, CLK, WE, SSR;

    reg [18431:0] mem;
    reg [8:0] count;
    reg [1:0] wr_mode;

    wire [8:0] addr_int;
    wire [31:0] di_int;
    wire [3:0] dip_int;
    wire en_int, clk_int, we_int, sr_int;
    wire di_enable;
    reg notifier;

    and (di_enable, EN, WE);

    tri0 GSR = glbl.GSR;
    wire gsr_int;

    always @(gsr_int)
	if (gsr_int) begin
	    assign do0_out = INIT[0];
	    assign do1_out = INIT[1];
	    assign do2_out = INIT[2];
	    assign do3_out = INIT[3];
	    assign do4_out = INIT[4];
	    assign do5_out = INIT[5];
	    assign do6_out = INIT[6];
	    assign do7_out = INIT[7];
	    assign do8_out = INIT[8];
	    assign do9_out = INIT[9];
	    assign do10_out = INIT[10];
	    assign do11_out = INIT[11];
	    assign do12_out = INIT[12];
	    assign do13_out = INIT[13];
	    assign do14_out = INIT[14];
	    assign do15_out = INIT[15];
	    assign do16_out = INIT[16];
	    assign do17_out = INIT[17];
	    assign do18_out = INIT[18];
	    assign do19_out = INIT[19];
	    assign do20_out = INIT[20];
	    assign do21_out = INIT[21];
	    assign do22_out = INIT[22];
	    assign do23_out = INIT[23];
	    assign do24_out = INIT[24];
	    assign do25_out = INIT[25];
	    assign do26_out = INIT[26];
	    assign do27_out = INIT[27];
	    assign do28_out = INIT[28];
	    assign do29_out = INIT[29];
	    assign do30_out = INIT[30];
	    assign do31_out = INIT[31];
	    assign dop0_out = INIT[32];
	    assign dop1_out = INIT[33];
	    assign dop2_out = INIT[34];
	    assign dop3_out = INIT[35];
	end
	else begin
	    deassign do0_out;
	    deassign do1_out;
	    deassign do2_out;
	    deassign do3_out;
	    deassign do4_out;
	    deassign do5_out;
	    deassign do6_out;
	    deassign do7_out;
	    deassign do8_out;
	    deassign do9_out;
	    deassign do10_out;
	    deassign do11_out;
	    deassign do12_out;
	    deassign do13_out;
	    deassign do14_out;
	    deassign do15_out;
	    deassign do16_out;
	    deassign do17_out;
	    deassign do18_out;
	    deassign do19_out;
	    deassign do20_out;
	    deassign do21_out;
	    deassign do22_out;
	    deassign do23_out;
	    deassign do24_out;
	    deassign do25_out;
	    deassign do26_out;
	    deassign do27_out;
	    deassign do28_out;
	    deassign do29_out;
	    deassign do30_out;
	    deassign do31_out;
	    deassign dop0_out;
	    deassign dop1_out;
	    deassign dop2_out;
	    deassign dop3_out;
	end

    buf b_gsr (gsr_int, GSR);
    buf b_do_out0 (DO[0], do0_out);
    buf b_do_out1 (DO[1], do1_out);
    buf b_do_out2 (DO[2], do2_out);
    buf b_do_out3 (DO[3], do3_out);
    buf b_do_out4 (DO[4], do4_out);
    buf b_do_out5 (DO[5], do5_out);
    buf b_do_out6 (DO[6], do6_out);
    buf b_do_out7 (DO[7], do7_out);
    buf b_do_out8 (DO[8], do8_out);
    buf b_do_out9 (DO[9], do9_out);
    buf b_do_out10 (DO[10], do10_out);
    buf b_do_out11 (DO[11], do11_out);
    buf b_do_out12 (DO[12], do12_out);
    buf b_do_out13 (DO[13], do13_out);
    buf b_do_out14 (DO[14], do14_out);
    buf b_do_out15 (DO[15], do15_out);
    buf b_do_out16 (DO[16], do16_out);
    buf b_do_out17 (DO[17], do17_out);
    buf b_do_out18 (DO[18], do18_out);
    buf b_do_out19 (DO[19], do19_out);
    buf b_do_out20 (DO[20], do20_out);
    buf b_do_out21 (DO[21], do21_out);
    buf b_do_out22 (DO[22], do22_out);
    buf b_do_out23 (DO[23], do23_out);
    buf b_do_out24 (DO[24], do24_out);
    buf b_do_out25 (DO[25], do25_out);
    buf b_do_out26 (DO[26], do26_out);
    buf b_do_out27 (DO[27], do27_out);
    buf b_do_out28 (DO[28], do28_out);
    buf b_do_out29 (DO[29], do29_out);
    buf b_do_out30 (DO[30], do30_out);
    buf b_do_out31 (DO[31], do31_out);
    buf b_dop_out0 (DOP[0], dop0_out);
    buf b_dop_out1 (DOP[1], dop1_out);
    buf b_dop_out2 (DOP[2], dop2_out);
    buf b_dop_out3 (DOP[3], dop3_out);
    buf b_addr_0 (addr_int[0], ADDR[0]);
    buf b_addr_1 (addr_int[1], ADDR[1]);
    buf b_addr_2 (addr_int[2], ADDR[2]);
    buf b_addr_3 (addr_int[3], ADDR[3]);
    buf b_addr_4 (addr_int[4], ADDR[4]);
    buf b_addr_5 (addr_int[5], ADDR[5]);
    buf b_addr_6 (addr_int[6], ADDR[6]);
    buf b_addr_7 (addr_int[7], ADDR[7]);
    buf b_addr_8 (addr_int[8], ADDR[8]);
    buf b_di_0 (di_int[0], DI[0]);
    buf b_di_1 (di_int[1], DI[1]);
    buf b_di_2 (di_int[2], DI[2]);
    buf b_di_3 (di_int[3], DI[3]);
    buf b_di_4 (di_int[4], DI[4]);
    buf b_di_5 (di_int[5], DI[5]);
    buf b_di_6 (di_int[6], DI[6]);
    buf b_di_7 (di_int[7], DI[7]);
    buf b_di_8 (di_int[8], DI[8]);
    buf b_di_9 (di_int[9], DI[9]);
    buf b_di_10 (di_int[10], DI[10]);
    buf b_di_11 (di_int[11], DI[11]);
    buf b_di_12 (di_int[12], DI[12]);
    buf b_di_13 (di_int[13], DI[13]);
    buf b_di_14 (di_int[14], DI[14]);
    buf b_di_15 (di_int[15], DI[15]);
    buf b_di_16 (di_int[16], DI[16]);
    buf b_di_17 (di_int[17], DI[17]);
    buf b_di_18 (di_int[18], DI[18]);
    buf b_di_19 (di_int[19], DI[19]);
    buf b_di_20 (di_int[20], DI[20]);
    buf b_di_21 (di_int[21], DI[21]);
    buf b_di_22 (di_int[22], DI[22]);
    buf b_di_23 (di_int[23], DI[23]);
    buf b_di_24 (di_int[24], DI[24]);
    buf b_di_25 (di_int[25], DI[25]);
    buf b_di_26 (di_int[26], DI[26]);
    buf b_di_27 (di_int[27], DI[27]);
    buf b_di_28 (di_int[28], DI[28]);
    buf b_di_29 (di_int[29], DI[29]);
    buf b_di_30 (di_int[30], DI[30]);
    buf b_di_31 (di_int[31], DI[31]);
    buf b_dip_0 (dip_int[0], DIP[0]);
    buf b_dip_1 (dip_int[1], DIP[1]);
    buf b_dip_2 (dip_int[2], DIP[2]);
    buf b_dip_3 (dip_int[3], DIP[3]);
    buf b_en (en_int, EN);
    buf b_clk (clk_int, CLK);
    buf b_we (we_int, WE);
    buf b_sr (sr_int, SSR);

    initial begin
	for (count = 0; count < 256; count = count + 1) begin
	    mem[count]		  <= INIT_00[count];
	    mem[256 * 1 + count]  <= INIT_01[count];
	    mem[256 * 2 + count]  <= INIT_02[count];
	    mem[256 * 3 + count]  <= INIT_03[count];
	    mem[256 * 4 + count]  <= INIT_04[count];
	    mem[256 * 5 + count]  <= INIT_05[count];
	    mem[256 * 6 + count]  <= INIT_06[count];
	    mem[256 * 7 + count]  <= INIT_07[count];
	    mem[256 * 8 + count]  <= INIT_08[count];
	    mem[256 * 9 + count]  <= INIT_09[count];
	    mem[256 * 10 + count] <= INIT_0A[count];
	    mem[256 * 11 + count] <= INIT_0B[count];
	    mem[256 * 12 + count] <= INIT_0C[count];
	    mem[256 * 13 + count] <= INIT_0D[count];
	    mem[256 * 14 + count] <= INIT_0E[count];
	    mem[256 * 15 + count] <= INIT_0F[count];
	    mem[256 * 16 + count] <= INIT_10[count];
	    mem[256 * 17 + count] <= INIT_11[count];
	    mem[256 * 18 + count] <= INIT_12[count];
	    mem[256 * 19 + count] <= INIT_13[count];
	    mem[256 * 20 + count] <= INIT_14[count];
	    mem[256 * 21 + count] <= INIT_15[count];
	    mem[256 * 22 + count] <= INIT_16[count];
	    mem[256 * 23 + count] <= INIT_17[count];
	    mem[256 * 24 + count] <= INIT_18[count];
	    mem[256 * 25 + count] <= INIT_19[count];
	    mem[256 * 26 + count] <= INIT_1A[count];
	    mem[256 * 27 + count] <= INIT_1B[count];
	    mem[256 * 28 + count] <= INIT_1C[count];
	    mem[256 * 29 + count] <= INIT_1D[count];
	    mem[256 * 30 + count] <= INIT_1E[count];
	    mem[256 * 31 + count] <= INIT_1F[count];
	    mem[256 * 32 + count] <= INIT_20[count];
	    mem[256 * 33 + count] <= INIT_21[count];
	    mem[256 * 34 + count] <= INIT_22[count];
	    mem[256 * 35 + count] <= INIT_23[count];
	    mem[256 * 36 + count] <= INIT_24[count];
	    mem[256 * 37 + count] <= INIT_25[count];
	    mem[256 * 38 + count] <= INIT_26[count];
	    mem[256 * 39 + count] <= INIT_27[count];
	    mem[256 * 40 + count] <= INIT_28[count];
	    mem[256 * 41 + count] <= INIT_29[count];
	    mem[256 * 42 + count] <= INIT_2A[count];
	    mem[256 * 43 + count] <= INIT_2B[count];
	    mem[256 * 44 + count] <= INIT_2C[count];
	    mem[256 * 45 + count] <= INIT_2D[count];
	    mem[256 * 46 + count] <= INIT_2E[count];
	    mem[256 * 47 + count] <= INIT_2F[count];
	    mem[256 * 48 + count] <= INIT_30[count];
	    mem[256 * 49 + count] <= INIT_31[count];
	    mem[256 * 50 + count] <= INIT_32[count];
	    mem[256 * 51 + count] <= INIT_33[count];
	    mem[256 * 52 + count] <= INIT_34[count];
	    mem[256 * 53 + count] <= INIT_35[count];
	    mem[256 * 54 + count] <= INIT_36[count];
	    mem[256 * 55 + count] <= INIT_37[count];
	    mem[256 * 56 + count] <= INIT_38[count];
	    mem[256 * 57 + count] <= INIT_39[count];
	    mem[256 * 58 + count] <= INIT_3A[count];
	    mem[256 * 59 + count] <= INIT_3B[count];
	    mem[256 * 60 + count] <= INIT_3C[count];
	    mem[256 * 61 + count] <= INIT_3D[count];
	    mem[256 * 62 + count] <= INIT_3E[count];
	    mem[256 * 63 + count] <= INIT_3F[count];
	    mem[256 * 64 + count] <= INITP_00[count];
	    mem[256 * 65 + count] <= INITP_01[count];
	    mem[256 * 66 + count] <= INITP_02[count];
	    mem[256 * 67 + count] <= INITP_03[count];
	    mem[256 * 68 + count] <= INITP_04[count];
	    mem[256 * 69 + count] <= INITP_05[count];
	    mem[256 * 70 + count] <= INITP_06[count];
	    mem[256 * 71 + count] <= INITP_07[count];
	end
    end

    initial begin
	case (WRITE_MODE)
	    "WRITE_FIRST" : wr_mode <= 2'b00;
	    "READ_FIRST"  : wr_mode <= 2'b01;
	    "NO_CHANGE"   : wr_mode <= 2'b10;
	    default       : begin
				$display("Attribute Syntax Error : The attribute WRITE_MODE on X_RAMB16_S36 instance %m is set to %s.  The legal values for this attribute are WRITE_FIRST, READ_FIRST or NO_CHANGE.", WRITE_MODE);
				$finish;
			    end
	endcase
    end

    always @(posedge clk_int) begin
	if (en_int == 1'b1) begin
	    if (sr_int == 1'b1) begin
		do0_out <= SRVAL[0];
		do1_out <= SRVAL[1];
		do2_out <= SRVAL[2];
		do3_out <= SRVAL[3];
		do4_out <= SRVAL[4];
		do5_out <= SRVAL[5];
		do6_out <= SRVAL[6];
		do7_out <= SRVAL[7];
		do8_out <= SRVAL[8];
		do9_out <= SRVAL[9];
		do10_out <= SRVAL[10];
		do11_out <= SRVAL[11];
		do12_out <= SRVAL[12];
		do13_out <= SRVAL[13];
		do14_out <= SRVAL[14];
		do15_out <= SRVAL[15];
		do16_out <= SRVAL[16];
		do17_out <= SRVAL[17];
		do18_out <= SRVAL[18];
		do19_out <= SRVAL[19];
		do20_out <= SRVAL[20];
		do21_out <= SRVAL[21];
		do22_out <= SRVAL[22];
		do23_out <= SRVAL[23];
		do24_out <= SRVAL[24];
		do25_out <= SRVAL[25];
		do26_out <= SRVAL[26];
		do27_out <= SRVAL[27];
		do28_out <= SRVAL[28];
		do29_out <= SRVAL[29];
		do30_out <= SRVAL[30];
		do31_out <= SRVAL[31];
		dop0_out <= SRVAL[32];
		dop1_out <= SRVAL[33];
		dop2_out <= SRVAL[34];
		dop3_out <= SRVAL[35];
	    end
	    else begin
		if (we_int == 1'b1) begin
		    if (wr_mode == 2'b00) begin
			do0_out <= di_int[0];
			do1_out <= di_int[1];
			do2_out <= di_int[2];
			do3_out <= di_int[3];
			do4_out <= di_int[4];
			do5_out <= di_int[5];
			do6_out <= di_int[6];
			do7_out <= di_int[7];
			do8_out <= di_int[8];
			do9_out <= di_int[9];
			do10_out <= di_int[10];
			do11_out <= di_int[11];
			do12_out <= di_int[12];
			do13_out <= di_int[13];
			do14_out <= di_int[14];
			do15_out <= di_int[15];
			do16_out <= di_int[16];
			do17_out <= di_int[17];
			do18_out <= di_int[18];
			do19_out <= di_int[19];
			do20_out <= di_int[20];
			do21_out <= di_int[21];
			do22_out <= di_int[22];
			do23_out <= di_int[23];
			do24_out <= di_int[24];
			do25_out <= di_int[25];
			do26_out <= di_int[26];
			do27_out <= di_int[27];
			do28_out <= di_int[28];
			do29_out <= di_int[29];
			do30_out <= di_int[30];
			do31_out <= di_int[31];
			dop0_out <= dip_int[0];
			dop1_out <= dip_int[1];
			dop2_out <= dip_int[2];
			dop3_out <= dip_int[3];
		    end
		    else if (wr_mode == 2'b01) begin
			do0_out <= mem[addr_int * 32 + 0];
			do1_out <= mem[addr_int * 32 + 1];
			do2_out <= mem[addr_int * 32 + 2];
			do3_out <= mem[addr_int * 32 + 3];
			do4_out <= mem[addr_int * 32 + 4];
			do5_out <= mem[addr_int * 32 + 5];
			do6_out <= mem[addr_int * 32 + 6];
			do7_out <= mem[addr_int * 32 + 7];
			do8_out <= mem[addr_int * 32 + 8];
			do9_out <= mem[addr_int * 32 + 9];
			do10_out <= mem[addr_int * 32 + 10];
			do11_out <= mem[addr_int * 32 + 11];
			do12_out <= mem[addr_int * 32 + 12];
			do13_out <= mem[addr_int * 32 + 13];
			do14_out <= mem[addr_int * 32 + 14];
			do15_out <= mem[addr_int * 32 + 15];
			do16_out <= mem[addr_int * 32 + 16];
			do17_out <= mem[addr_int * 32 + 17];
			do18_out <= mem[addr_int * 32 + 18];
			do19_out <= mem[addr_int * 32 + 19];
			do20_out <= mem[addr_int * 32 + 20];
			do21_out <= mem[addr_int * 32 + 21];
			do22_out <= mem[addr_int * 32 + 22];
			do23_out <= mem[addr_int * 32 + 23];
			do24_out <= mem[addr_int * 32 + 24];
			do25_out <= mem[addr_int * 32 + 25];
			do26_out <= mem[addr_int * 32 + 26];
			do27_out <= mem[addr_int * 32 + 27];
			do28_out <= mem[addr_int * 32 + 28];
			do29_out <= mem[addr_int * 32 + 29];
			do30_out <= mem[addr_int * 32 + 30];
			do31_out <= mem[addr_int * 32 + 31];
			dop0_out <= mem[16384 + addr_int * 4 + 0];
			dop1_out <= mem[16384 + addr_int * 4 + 1];
			dop2_out <= mem[16384 + addr_int * 4 + 2];
			dop3_out <= mem[16384 + addr_int * 4 + 3];
		    end
		    else begin
			do0_out <= do0_out;
			do1_out <= do1_out;
			do2_out <= do2_out;
			do3_out <= do3_out;
			do4_out <= do4_out;
			do5_out <= do5_out;
			do6_out <= do6_out;
			do7_out <= do7_out;
			do8_out <= do8_out;
			do9_out <= do9_out;
			do10_out <= do10_out;
			do11_out <= do11_out;
			do12_out <= do12_out;
			do13_out <= do13_out;
			do14_out <= do14_out;
			do15_out <= do15_out;
			do16_out <= do16_out;
			do17_out <= do17_out;
			do18_out <= do18_out;
			do19_out <= do19_out;
			do20_out <= do20_out;
			do21_out <= do21_out;
			do22_out <= do22_out;
			do23_out <= do23_out;
			do24_out <= do24_out;
			do25_out <= do25_out;
			do26_out <= do26_out;
			do27_out <= do27_out;
			do28_out <= do28_out;
			do29_out <= do29_out;
			do30_out <= do30_out;
			do31_out <= do31_out;
			dop0_out <= dop0_out;
			dop1_out <= dop1_out;
			dop2_out <= dop2_out;
			dop3_out <= dop3_out;
		    end
		end
		else begin
		    do0_out <= mem[addr_int * 32 + 0];
		    do1_out <= mem[addr_int * 32 + 1];
		    do2_out <= mem[addr_int * 32 + 2];
		    do3_out <= mem[addr_int * 32 + 3];
		    do4_out <= mem[addr_int * 32 + 4];
		    do5_out <= mem[addr_int * 32 + 5];
		    do6_out <= mem[addr_int * 32 + 6];
		    do7_out <= mem[addr_int * 32 + 7];
		    do8_out <= mem[addr_int * 32 + 8];
		    do9_out <= mem[addr_int * 32 + 9];
		    do10_out <= mem[addr_int * 32 + 10];
		    do11_out <= mem[addr_int * 32 + 11];
		    do12_out <= mem[addr_int * 32 + 12];
		    do13_out <= mem[addr_int * 32 + 13];
		    do14_out <= mem[addr_int * 32 + 14];
		    do15_out <= mem[addr_int * 32 + 15];
		    do16_out <= mem[addr_int * 32 + 16];
		    do17_out <= mem[addr_int * 32 + 17];
		    do18_out <= mem[addr_int * 32 + 18];
		    do19_out <= mem[addr_int * 32 + 19];
		    do20_out <= mem[addr_int * 32 + 20];
		    do21_out <= mem[addr_int * 32 + 21];
		    do22_out <= mem[addr_int * 32 + 22];
		    do23_out <= mem[addr_int * 32 + 23];
		    do24_out <= mem[addr_int * 32 + 24];
		    do25_out <= mem[addr_int * 32 + 25];
		    do26_out <= mem[addr_int * 32 + 26];
		    do27_out <= mem[addr_int * 32 + 27];
		    do28_out <= mem[addr_int * 32 + 28];
		    do29_out <= mem[addr_int * 32 + 29];
		    do30_out <= mem[addr_int * 32 + 30];
		    do31_out <= mem[addr_int * 32 + 31];
		    dop0_out <= mem[16384 + addr_int * 4 + 0];
		    dop1_out <= mem[16384 + addr_int * 4 + 1];
		    dop2_out <= mem[16384 + addr_int * 4 + 2];
		    dop3_out <= mem[16384 + addr_int * 4 + 3];
		end
	    end
	end
    end

    always @(posedge clk_int) begin
	if (en_int == 1'b1 && we_int == 1'b1) begin
	    mem[addr_int * 32 + 0] <= di_int[0];
	    mem[addr_int * 32 + 1] <= di_int[1];
	    mem[addr_int * 32 + 2] <= di_int[2];
	    mem[addr_int * 32 + 3] <= di_int[3];
	    mem[addr_int * 32 + 4] <= di_int[4];
	    mem[addr_int * 32 + 5] <= di_int[5];
	    mem[addr_int * 32 + 6] <= di_int[6];
	    mem[addr_int * 32 + 7] <= di_int[7];
	    mem[addr_int * 32 + 8] <= di_int[8];
	    mem[addr_int * 32 + 9] <= di_int[9];
	    mem[addr_int * 32 + 10] <= di_int[10];
	    mem[addr_int * 32 + 11] <= di_int[11];
	    mem[addr_int * 32 + 12] <= di_int[12];
	    mem[addr_int * 32 + 13] <= di_int[13];
	    mem[addr_int * 32 + 14] <= di_int[14];
	    mem[addr_int * 32 + 15] <= di_int[15];
	    mem[addr_int * 32 + 16] <= di_int[16];
	    mem[addr_int * 32 + 17] <= di_int[17];
	    mem[addr_int * 32 + 18] <= di_int[18];
	    mem[addr_int * 32 + 19] <= di_int[19];
	    mem[addr_int * 32 + 20] <= di_int[20];
	    mem[addr_int * 32 + 21] <= di_int[21];
	    mem[addr_int * 32 + 22] <= di_int[22];
	    mem[addr_int * 32 + 23] <= di_int[23];
	    mem[addr_int * 32 + 24] <= di_int[24];
	    mem[addr_int * 32 + 25] <= di_int[25];
	    mem[addr_int * 32 + 26] <= di_int[26];
	    mem[addr_int * 32 + 27] <= di_int[27];
	    mem[addr_int * 32 + 28] <= di_int[28];
	    mem[addr_int * 32 + 29] <= di_int[29];
	    mem[addr_int * 32 + 30] <= di_int[30];
	    mem[addr_int * 32 + 31] <= di_int[31];
	    mem[16384 + addr_int * 4 + 0] <= dip_int[0];
	    mem[16384 + addr_int * 4 + 1] <= dip_int[1];
	    mem[16384 + addr_int * 4 + 2] <= dip_int[2];
	    mem[16384 + addr_int * 4 + 3] <= dip_int[3];
	end
    end

    always @(notifier) begin
	do0_out <= 1'bx;
	do1_out <= 1'bx;
	do2_out <= 1'bx;
	do3_out <= 1'bx;
	do4_out <= 1'bx;
	do5_out <= 1'bx;
	do6_out <= 1'bx;
	do7_out <= 1'bx;
	do8_out <= 1'bx;
	do9_out <= 1'bx;
	do10_out <= 1'bx;
	do11_out <= 1'bx;
	do12_out <= 1'bx;
	do13_out <= 1'bx;
	do14_out <= 1'bx;
	do15_out <= 1'bx;
	do16_out <= 1'bx;
	do17_out <= 1'bx;
	do18_out <= 1'bx;
	do19_out <= 1'bx;
	do20_out <= 1'bx;
	do21_out <= 1'bx;
	do22_out <= 1'bx;
	do23_out <= 1'bx;
	do24_out <= 1'bx;
	do25_out <= 1'bx;
	do26_out <= 1'bx;
	do27_out <= 1'bx;
	do28_out <= 1'bx;
	do29_out <= 1'bx;
	do30_out <= 1'bx;
	do31_out <= 1'bx;
	dop0_out <= 1'bx;
	dop1_out <= 1'bx;
	dop2_out <= 1'bx;
	dop3_out <= 1'bx;
    end

    specify

  	(CLK => DO[0]) = (100:100:100, 100:100:100);
  	(CLK => DO[1]) = (100:100:100, 100:100:100);
  	(CLK => DO[2]) = (100:100:100, 100:100:100);
  	(CLK => DO[3]) = (100:100:100, 100:100:100);
  	(CLK => DO[4]) = (100:100:100, 100:100:100);
  	(CLK => DO[5]) = (100:100:100, 100:100:100);
  	(CLK => DO[6]) = (100:100:100, 100:100:100);
  	(CLK => DO[7]) = (100:100:100, 100:100:100);
  	(CLK => DO[8]) = (100:100:100, 100:100:100);
  	(CLK => DO[9]) = (100:100:100, 100:100:100);
  	(CLK => DO[10]) = (100:100:100, 100:100:100);
  	(CLK => DO[11]) = (100:100:100, 100:100:100);
  	(CLK => DO[12]) = (100:100:100, 100:100:100);
  	(CLK => DO[13]) = (100:100:100, 100:100:100);
  	(CLK => DO[14]) = (100:100:100, 100:100:100);
  	(CLK => DO[15]) = (100:100:100, 100:100:100);
  	(CLK => DO[16]) = (100:100:100, 100:100:100);
  	(CLK => DO[17]) = (100:100:100, 100:100:100);
  	(CLK => DO[18]) = (100:100:100, 100:100:100);
  	(CLK => DO[19]) = (100:100:100, 100:100:100);
  	(CLK => DO[20]) = (100:100:100, 100:100:100);
  	(CLK => DO[21]) = (100:100:100, 100:100:100);
  	(CLK => DO[22]) = (100:100:100, 100:100:100);
  	(CLK => DO[23]) = (100:100:100, 100:100:100);
  	(CLK => DO[24]) = (100:100:100, 100:100:100);
  	(CLK => DO[25]) = (100:100:100, 100:100:100);
  	(CLK => DO[26]) = (100:100:100, 100:100:100);
  	(CLK => DO[27]) = (100:100:100, 100:100:100);
  	(CLK => DO[28]) = (100:100:100, 100:100:100);
  	(CLK => DO[29]) = (100:100:100, 100:100:100);
  	(CLK => DO[30]) = (100:100:100, 100:100:100);
  	(CLK => DO[31]) = (100:100:100, 100:100:100);
  	(CLK => DOP[0]) = (100:100:100, 100:100:100);
  	(CLK => DOP[1]) = (100:100:100, 100:100:100);
  	(CLK => DOP[2]) = (100:100:100, 100:100:100);
  	(CLK => DOP[3]) = (100:100:100, 100:100:100);

       	$setuphold (posedge CLK, posedge ADDR[0] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[0] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[1] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[1] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[2] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[2] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[3] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[3] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[4] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[4] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[5] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[5] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[6] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[6] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[7] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[7] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[8] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[8] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[0] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[0] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[1] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[1] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[2] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[2] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[3] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[3] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[4] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[4] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[5] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[5] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[6] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[6] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[7] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[7] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[8] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[8] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[9] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[9] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[10] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[10] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[11] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[11] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[12] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[12] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[13] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[13] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[14] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[14] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[15] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[15] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[16] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[16] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[17] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[17] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[18] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[18] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[19] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[19] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[20] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[20] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[21] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[21] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[22] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[22] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[23] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[23] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[24] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[24] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[25] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[25] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[26] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[26] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[27] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[27] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[28] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[28] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[29] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[29] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[30] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[30] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[31] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[31] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DIP[0] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DIP[0] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DIP[1] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DIP[1] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DIP[2] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DIP[2] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DIP[3] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DIP[3] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge SSR &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge SSR &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge WE &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge WE &&& EN, 0:0:0, 0:0:0, notifier);

  	$width (posedge CLK, 0:0:0, 0, notifier);
  	$width (negedge CLK, 0:0:0, 0, notifier);

	specparam PATHPULSE$ = 0;

    endspecify

endmodule

`else

// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_RAMB16_S36.v,v 1.7 2005/03/14 23:01:02 wloo Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  16K-Bit Data and 2K-Bit Parity Single Port Block RAM
// /___/   /\     Filename : X_RAMB16_S36.v
// \   \  /  \    Timestamp : Thu Mar 10 16:44:01 PST 2005
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/10/05 - Added LOC parameter, removed GSR port and initialized outputs.
// End Revision

`timescale 1 ps/1 ps

module X_RAMB16_S36 (DO, DOP, ADDR, CLK, DI, DIP, EN, SSR, WE);

    parameter INIT = 36'h0;
    parameter LOC = "UNPLACED";
    parameter SRVAL = 36'h0;
    parameter WRITE_MODE = "WRITE_FIRST";

    parameter INIT_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_10 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_11 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_12 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_13 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_14 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_15 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_16 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_17 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_18 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_19 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_20 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_21 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_22 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_23 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_24 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_25 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_26 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_27 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_28 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_29 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_30 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_31 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_32 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_33 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_34 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_35 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_36 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_37 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_38 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_39 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    
    output [31:0] DO;
    output [3:0] DOP;

    input [8:0] ADDR;
    input [31:0] DI;
    input [3:0] DIP;
    input EN, CLK, WE, SSR;

    reg [31:0] do_out = INIT[31:0];
    reg [3:0] dop_out = INIT[35:32];
    
    reg [31:0] mem [511:0];
    reg [3:0] memp [511:0];
    
    reg [8:0] count, countp;
    reg [1:0] wr_mode;

    wire [8:0] addr_int;
    wire [31:0] di_int;
    wire [3:0] dip_int;
    wire en_int, clk_int, we_int, ssr_int;

    wire di_enable = en_int && we_int;
    reg notifier;
    
    tri0 GSR = glbl.GSR;
    wire gsr_int;

    buf b_gsr (gsr_int, GSR);

    buf b_do [31:0] (DO, do_out);
    buf b_dop [3:0] (DOP, dop_out);
    buf b_addr [8:0] (addr_int, ADDR);
    buf b_di [31:0] (di_int, DI);
    buf b_dip [3:0] (dip_int, DIP);
    buf b_en (en_int, EN);
    buf b_clk (clk_int, CLK);
    buf b_ssr (ssr_int, SSR);
    buf b_we (we_int, WE);

    
    always @(gsr_int)
	if (gsr_int) begin
	    assign {dop_out, do_out} = INIT;
	end
	else begin
	    deassign do_out;
	    deassign dop_out;
	end

    
    initial begin

	for (count = 0; count < 8; count = count + 1) begin
	    mem[count]          = INIT_00[(count * 32) +: 32];
	    mem[8 * 1 + count]  = INIT_01[(count * 32) +: 32];
	    mem[8 * 2 + count]  = INIT_02[(count * 32) +: 32];
	    mem[8 * 3 + count]  = INIT_03[(count * 32) +: 32];
	    mem[8 * 4 + count]  = INIT_04[(count * 32) +: 32];
	    mem[8 * 5 + count]  = INIT_05[(count * 32) +: 32];
	    mem[8 * 6 + count]  = INIT_06[(count * 32) +: 32];
	    mem[8 * 7 + count]  = INIT_07[(count * 32) +: 32];
	    mem[8 * 8 + count]  = INIT_08[(count * 32) +: 32];
	    mem[8 * 9 + count]  = INIT_09[(count * 32) +: 32];
	    mem[8 * 10 + count] = INIT_0A[(count * 32) +: 32];
	    mem[8 * 11 + count] = INIT_0B[(count * 32) +: 32];
	    mem[8 * 12 + count] = INIT_0C[(count * 32) +: 32];
	    mem[8 * 13 + count] = INIT_0D[(count * 32) +: 32];
	    mem[8 * 14 + count] = INIT_0E[(count * 32) +: 32];
	    mem[8 * 15 + count] = INIT_0F[(count * 32) +: 32];
	    mem[8 * 16 + count] = INIT_10[(count * 32) +: 32];
	    mem[8 * 17 + count] = INIT_11[(count * 32) +: 32];
	    mem[8 * 18 + count] = INIT_12[(count * 32) +: 32];
	    mem[8 * 19 + count] = INIT_13[(count * 32) +: 32];
	    mem[8 * 20 + count] = INIT_14[(count * 32) +: 32];
	    mem[8 * 21 + count] = INIT_15[(count * 32) +: 32];
	    mem[8 * 22 + count] = INIT_16[(count * 32) +: 32];
	    mem[8 * 23 + count] = INIT_17[(count * 32) +: 32];
	    mem[8 * 24 + count] = INIT_18[(count * 32) +: 32];
	    mem[8 * 25 + count] = INIT_19[(count * 32) +: 32];
	    mem[8 * 26 + count] = INIT_1A[(count * 32) +: 32];
	    mem[8 * 27 + count] = INIT_1B[(count * 32) +: 32];
	    mem[8 * 28 + count] = INIT_1C[(count * 32) +: 32];
	    mem[8 * 29 + count] = INIT_1D[(count * 32) +: 32];
	    mem[8 * 30 + count] = INIT_1E[(count * 32) +: 32];
	    mem[8 * 31 + count] = INIT_1F[(count * 32) +: 32];
	    mem[8 * 32 + count] = INIT_20[(count * 32) +: 32];
	    mem[8 * 33 + count] = INIT_21[(count * 32) +: 32];
	    mem[8 * 34 + count] = INIT_22[(count * 32) +: 32];
	    mem[8 * 35 + count] = INIT_23[(count * 32) +: 32];
	    mem[8 * 36 + count] = INIT_24[(count * 32) +: 32];
	    mem[8 * 37 + count] = INIT_25[(count * 32) +: 32];
	    mem[8 * 38 + count] = INIT_26[(count * 32) +: 32];
	    mem[8 * 39 + count] = INIT_27[(count * 32) +: 32];
	    mem[8 * 40 + count] = INIT_28[(count * 32) +: 32];
	    mem[8 * 41 + count] = INIT_29[(count * 32) +: 32];
	    mem[8 * 42 + count] = INIT_2A[(count * 32) +: 32];
	    mem[8 * 43 + count] = INIT_2B[(count * 32) +: 32];
	    mem[8 * 44 + count] = INIT_2C[(count * 32) +: 32];
	    mem[8 * 45 + count] = INIT_2D[(count * 32) +: 32];
	    mem[8 * 46 + count] = INIT_2E[(count * 32) +: 32];
	    mem[8 * 47 + count] = INIT_2F[(count * 32) +: 32];
	    mem[8 * 48 + count] = INIT_30[(count * 32) +: 32];
	    mem[8 * 49 + count] = INIT_31[(count * 32) +: 32];
	    mem[8 * 50 + count] = INIT_32[(count * 32) +: 32];
	    mem[8 * 51 + count] = INIT_33[(count * 32) +: 32];
	    mem[8 * 52 + count] = INIT_34[(count * 32) +: 32];
	    mem[8 * 53 + count] = INIT_35[(count * 32) +: 32];
	    mem[8 * 54 + count] = INIT_36[(count * 32) +: 32];
	    mem[8 * 55 + count] = INIT_37[(count * 32) +: 32];
	    mem[8 * 56 + count] = INIT_38[(count * 32) +: 32];
	    mem[8 * 57 + count] = INIT_39[(count * 32) +: 32];
	    mem[8 * 58 + count] = INIT_3A[(count * 32) +: 32];
	    mem[8 * 59 + count] = INIT_3B[(count * 32) +: 32];
	    mem[8 * 60 + count] = INIT_3C[(count * 32) +: 32];
	    mem[8 * 61 + count] = INIT_3D[(count * 32) +: 32];
	    mem[8 * 62 + count] = INIT_3E[(count * 32) +: 32];
	    mem[8 * 63 + count] = INIT_3F[(count * 32) +: 32];
	end

// initiate parity start
	for (countp = 0; countp < 64; countp = countp + 1) begin
	    memp[countp]          = INITP_00[(countp * 4) +: 4];
	    memp[64 * 1 + countp] = INITP_01[(countp * 4) +: 4];
	    memp[64 * 2 + countp] = INITP_02[(countp * 4) +: 4];
	    memp[64 * 3 + countp] = INITP_03[(countp * 4) +: 4];
	    memp[64 * 4 + countp] = INITP_04[(countp * 4) +: 4];
	    memp[64 * 5 + countp] = INITP_05[(countp * 4) +: 4];
	    memp[64 * 6 + countp] = INITP_06[(countp * 4) +: 4];
	    memp[64 * 7 + countp] = INITP_07[(countp * 4) +: 4];
	end
// initiate parity end
    end // initial begin
	

    initial begin
	case (WRITE_MODE)
	    "WRITE_FIRST" : wr_mode <= 2'b00;
	    "READ_FIRST"  : wr_mode <= 2'b01;
	    "NO_CHANGE"   : wr_mode <= 2'b10;
	    default       : begin
				$display("Attribute Syntax Error : The Attribute WRITE_MODE on X_RAMB16_S36 instance %m is set to %s.  Legal values for this attribute are WRITE_FIRST, READ_FIRST or NO_CHANGE.", WRITE_MODE);
				$finish;
			    end
	endcase
    end


    always @(posedge clk_int) begin

	if (en_int == 1'b1) begin

	    if (ssr_int == 1'b1) begin
		{dop_out, do_out} <= SRVAL;
	    end
	    else begin
		if (we_int == 1'b1) begin
		    if (wr_mode == 2'b00) begin
			do_out <= di_int;
			dop_out <= dip_int;
		    end
		    else if (wr_mode == 2'b01) begin
			do_out <= mem[addr_int];
			dop_out <= memp[addr_int];
		    end
		end
		else begin
		    do_out <= mem[addr_int];
		    dop_out <= memp[addr_int];
		end
	    end

	    // memory
	    if (we_int == 1'b1) begin
		mem[addr_int] <= di_int;
		memp[addr_int] <= dip_int;
	    end

	end
    end

//*** Timing Checks Start here
    always @(notifier) begin
	do_out <= 32'bx;
	dop_out <= 4'bx;
    end

    specify

        (CLK => DO[0]) = (100:100:100, 100:100:100);
        (CLK => DO[1]) = (100:100:100, 100:100:100);
        (CLK => DO[2]) = (100:100:100, 100:100:100);
        (CLK => DO[3]) = (100:100:100, 100:100:100);
        (CLK => DO[4]) = (100:100:100, 100:100:100);
        (CLK => DO[5]) = (100:100:100, 100:100:100);
        (CLK => DO[6]) = (100:100:100, 100:100:100);
        (CLK => DO[7]) = (100:100:100, 100:100:100);
        (CLK => DO[8]) = (100:100:100, 100:100:100);
        (CLK => DO[9]) = (100:100:100, 100:100:100);
        (CLK => DO[10]) = (100:100:100, 100:100:100);
        (CLK => DO[11]) = (100:100:100, 100:100:100);
        (CLK => DO[12]) = (100:100:100, 100:100:100);
        (CLK => DO[13]) = (100:100:100, 100:100:100);
        (CLK => DO[14]) = (100:100:100, 100:100:100);
        (CLK => DO[15]) = (100:100:100, 100:100:100);
        (CLK => DO[16]) = (100:100:100, 100:100:100);
        (CLK => DO[17]) = (100:100:100, 100:100:100);
        (CLK => DO[18]) = (100:100:100, 100:100:100);
        (CLK => DO[19]) = (100:100:100, 100:100:100);
        (CLK => DO[20]) = (100:100:100, 100:100:100);
        (CLK => DO[21]) = (100:100:100, 100:100:100);
        (CLK => DO[22]) = (100:100:100, 100:100:100);
        (CLK => DO[23]) = (100:100:100, 100:100:100);
        (CLK => DO[24]) = (100:100:100, 100:100:100);
        (CLK => DO[25]) = (100:100:100, 100:100:100);
        (CLK => DO[26]) = (100:100:100, 100:100:100);
        (CLK => DO[27]) = (100:100:100, 100:100:100);
        (CLK => DO[28]) = (100:100:100, 100:100:100);
        (CLK => DO[29]) = (100:100:100, 100:100:100);
        (CLK => DO[30]) = (100:100:100, 100:100:100);
        (CLK => DO[31]) = (100:100:100, 100:100:100);
        (CLK => DOP[0]) = (100:100:100, 100:100:100);
        (CLK => DOP[1]) = (100:100:100, 100:100:100);
        (CLK => DOP[2]) = (100:100:100, 100:100:100);
        (CLK => DOP[3]) = (100:100:100, 100:100:100);

       	$setuphold (posedge CLK, posedge ADDR[0] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[0] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[1] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[1] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[2] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[2] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[3] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[3] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[4] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[4] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[5] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[5] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[6] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[6] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[7] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[7] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge ADDR[8] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge ADDR[8] &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[0] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[0] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[1] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[1] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[2] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[2] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[3] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[3] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[4] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[4] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[5] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[5] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[6] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[6] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[7] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[7] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[8] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[8] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[9] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[9] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[10] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[10] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[11] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[11] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[12] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[12] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[13] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[13] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[14] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[14] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[15] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[15] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[16] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[16] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[17] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[17] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[18] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[18] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[19] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[19] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[20] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[20] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[21] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[21] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[22] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[22] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[23] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[23] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[24] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[24] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[25] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[25] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[26] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[26] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[27] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[27] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[28] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[28] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[29] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[29] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[30] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[30] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DI[31] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DI[31] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DIP[0] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DIP[0] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DIP[1] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DIP[1] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DIP[2] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DIP[2] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge DIP[3] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge DIP[3] &&& di_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge SSR &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge SSR &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, posedge WE &&& EN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge CLK, negedge WE &&& EN, 0:0:0, 0:0:0, notifier);

        $width (posedge CLK &&& EN, 0:0:0, 0, notifier);
        $width (negedge CLK &&& EN, 0:0:0, 0, notifier);

	specparam PATHPULSE$ = 0;

    endspecify

endmodule

`endif

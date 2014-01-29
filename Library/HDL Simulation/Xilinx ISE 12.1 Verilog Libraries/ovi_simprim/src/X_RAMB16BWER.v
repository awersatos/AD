// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/sandia/X_RAMB16BWER.v,v 1.29.36.1 2010/03/29 22:46:41 wloo Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2008 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1
//  \   \         Description : Xilinx Timing Simulation Library Component 16K-Bit Data and
//  /   /                       2K-Bit Parity Dual Port Block RAM.
// /___/   /\     Filename : X_RAMB16BWER.v
// \   \  /  \    Timestamp : Wed Dec 24 14:38:27 PST 2008
//  \___\/\___\
//
// Revision:
//    12/24/08 - Initial version.
//    01/26/09 - Update reset behavior (IR 500935).
//    02/11/09 - Update address mapping for spartan6 (IR 506186).
//    02/19/09 - Fix asychronous reset in register mode (IR 506208).
//    03/10/09 - Remove address mapping for spartan6 (CR 508325).
//             - X's the unused bits of outputs (CR 511363).
//    03/20/09 - Fix unusual behavior of X's in the unused bits of outputs (CR 513167). 
//    03/15/10 - Updated address collision for asynchronous clocks and read first mode (CR 547447).
// End Revision

`timescale 1 ps/1 ps

module X_RAMB16BWER (DOA, DOB, DOPA, DOPB, 
		     ADDRA, ADDRB, CLKA, CLKB, DIA, DIB, DIPA, DIPB, ENA, ENB, REGCEA, REGCEB, RSTA, RSTB, WEA, WEB);

    output [31:0] DOA;
    output [31:0] DOB;
    output [3:0] DOPA;
    output [3:0] DOPB;

    input [13:0] ADDRA;
    input [13:0] ADDRB;
    input CLKA;
    input CLKB;
    input [31:0] DIA;
    input [31:0] DIB;
    input [3:0] DIPA;
    input [3:0] DIPB;
    input ENA;
    input ENB;
    input REGCEA;
    input REGCEB;
    input RSTA;
    input RSTB;
    input [3:0] WEA;
    input [3:0] WEB;
    
    parameter integer DATA_WIDTH_A = 0;
    parameter integer DATA_WIDTH_B = 0;
    parameter integer DOA_REG = 0;
    parameter integer DOB_REG = 0;
    parameter EN_RSTRAM_A = "TRUE";
    parameter EN_RSTRAM_B = "TRUE";
    parameter INITP_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
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
    parameter INIT_A = 36'h0;
    parameter INIT_B = 36'h0;
    parameter INIT_FILE = "NONE";
    parameter LOC = "UNPLACED";
    parameter RSTTYPE = "SYNC";
    parameter RST_PRIORITY_A = "CE";
    parameter RST_PRIORITY_B = "CE";
    parameter SETUP_ALL = 1000;
    parameter SETUP_READ_FIRST = 3000;
    parameter SIM_DEVICE = "SPARTAN3ADSP";
    parameter SIM_COLLISION_CHECK = "ALL";
    parameter SRVAL_A = 36'h0;
    parameter SRVAL_B = 36'h0;
    parameter WRITE_MODE_A = "WRITE_FIRST";
    parameter WRITE_MODE_B = "WRITE_FIRST";

    
    wire [15:0] addrawraddr_in, addrbrdaddr_in;
    wire [13:0] col_addra_reconstruct, col_addrb_reconstruct;
    reg [13:0] 	col_addra_reconstruct_reg, col_addrb_reconstruct_reg;
    
    localparam widest_width = (DATA_WIDTH_A >= DATA_WIDTH_B) ? DATA_WIDTH_A : DATA_WIDTH_B;

    localparam a_width = (DATA_WIDTH_A == 1) ? 1 : (DATA_WIDTH_A == 2) ? 2 : (DATA_WIDTH_A == 4) ? 4 :
			 (DATA_WIDTH_A == 9) ? 8 : (DATA_WIDTH_A == 18) ? 16 : (DATA_WIDTH_A == 36) ? 32 : 32;
    
    localparam b_width = (DATA_WIDTH_B == 1) ? 1 : (DATA_WIDTH_B == 2) ? 2 : (DATA_WIDTH_B == 4) ? 4 :
			 (DATA_WIDTH_B == 9) ? 8 : (DATA_WIDTH_B == 18) ? 16 : (DATA_WIDTH_B == 36) ? 32 : 32;

    localparam a_widthp = (DATA_WIDTH_A == 9) ? 1 : (DATA_WIDTH_A == 18) ? 2 : (DATA_WIDTH_A == 36) ? 4 : 4;
    
    localparam b_widthp = (DATA_WIDTH_B == 9) ? 1 : (DATA_WIDTH_B == 18) ? 2 : (DATA_WIDTH_B == 36) ? 4 : 4;
    
    localparam col_addr_lsb = (widest_width == 1) ? 0 : (widest_width == 2) ? 1 : (widest_width == 4) ? 2 :
			      (widest_width == 9) ? 3 : (widest_width == 18) ? 4 : (widest_width == 36) ? 5 : 0;
    
    assign col_addra_reconstruct[13:0] = (SIM_DEVICE == "SPARTAN6" && (WRITE_MODE_A == "READ_FIRST" || WRITE_MODE_B == "READ_FIRST")) ? 
					 ((DATA_WIDTH_A <= 18 && DATA_WIDTH_B <= 18) ? {addrawraddr_in[13:6],1'b0,addrawraddr_in[4],4'b0} :
    					 (DATA_WIDTH_A == 36 || DATA_WIDTH_B == 36) ? {addrawraddr_in[13:7],1'b0,addrawraddr_in[5],5'b0} : addrawraddr_in[13:0]) : 
					  addrawraddr_in[13:0];

    assign col_addrb_reconstruct[13:0] = (SIM_DEVICE == "SPARTAN6" && (WRITE_MODE_A == "READ_FIRST" || WRITE_MODE_B == "READ_FIRST")) ? 
					 ((DATA_WIDTH_A <= 18 && DATA_WIDTH_B <= 18) ? {addrbrdaddr_in[13:6],1'b0,addrbrdaddr_in[4],4'b0} :
    					 (DATA_WIDTH_A == 36 || DATA_WIDTH_B == 36) ? {addrbrdaddr_in[13:7],1'b0,addrbrdaddr_in[5],5'b0} : addrbrdaddr_in[13:0]) :
					  addrbrdaddr_in[13:0];
    
    localparam width = (widest_width == 1) ? 1 : (widest_width == 2) ? 2 : (widest_width == 4) ? 4 :
		       (widest_width == 9) ? 8 : (widest_width == 18) ? 16 : (widest_width == 36) ? 32 : 32;
    
    localparam widthp = (widest_width == 9) ? 1 : (widest_width == 18) ? 2 : (widest_width == 36) ? 4 : 4;

    localparam addrawraddr_lbit_124 = (DATA_WIDTH_A == 1) ? 0 : (DATA_WIDTH_A == 2) ? 1 : 
				(DATA_WIDTH_A == 4) ? 2 : (DATA_WIDTH_A == 9) ? 3 : 
				(DATA_WIDTH_A == 18) ? 4 : (DATA_WIDTH_A == 36) ? 5 : 5;
    
    localparam addrbrdaddr_lbit_124 = (DATA_WIDTH_B == 1) ? 0 : (DATA_WIDTH_B == 2) ? 1 : 
				(DATA_WIDTH_B == 4) ? 2 : (DATA_WIDTH_B == 9) ? 3 : 
				(DATA_WIDTH_B == 18) ? 4 : (DATA_WIDTH_B == 36) ? 5 : 5;

    localparam addrawraddr_bit_124 = (DATA_WIDTH_A == 1 && widest_width == 2) ? 0 : (DATA_WIDTH_A == 1 && widest_width == 4) ? 1 : 
			       (DATA_WIDTH_A == 1 && widest_width == 9) ? 2 : (DATA_WIDTH_A == 1 && widest_width == 18) ? 3 :
			       (DATA_WIDTH_A == 1 && widest_width == 36) ? 4 : (DATA_WIDTH_A == 2 && widest_width == 4) ? 1 : 
			       (DATA_WIDTH_A == 2 && widest_width == 9) ? 2 : (DATA_WIDTH_A == 2 && widest_width == 18) ? 3 : 
			       (DATA_WIDTH_A == 2 && widest_width == 36) ? 4 : (DATA_WIDTH_A == 4 && widest_width == 9) ? 2 :
			       (DATA_WIDTH_A == 4 && widest_width == 18) ? 3 : (DATA_WIDTH_A == 4 && widest_width == 36) ? 4 : 5;
    
    localparam addrbrdaddr_bit_124 = (DATA_WIDTH_B == 1 && widest_width == 2) ? 0 : (DATA_WIDTH_B == 1 && widest_width == 4) ? 1 : 
			       (DATA_WIDTH_B == 1 && widest_width == 9) ? 2 : (DATA_WIDTH_B == 1 && widest_width == 18) ? 3 :
			       (DATA_WIDTH_B == 1 && widest_width == 36) ? 4 : (DATA_WIDTH_B == 2 && widest_width == 4) ? 1 : 
			       (DATA_WIDTH_B == 2 && widest_width == 9) ? 2 : (DATA_WIDTH_B == 2 && widest_width == 18) ? 3 : 
			       (DATA_WIDTH_B == 2 && widest_width == 36) ? 4 : (DATA_WIDTH_B == 4 && widest_width == 9) ? 2 :
			       (DATA_WIDTH_B == 4 && widest_width == 18) ? 3 : (DATA_WIDTH_B == 4 && widest_width == 36) ? 4 : 5;
    
    localparam addrawraddr_bit_8 = (DATA_WIDTH_A == 9 && widest_width == 18) ? 3 : (DATA_WIDTH_A == 9 && widest_width == 36) ? 4 : 4;
    
    localparam addrawraddr_bit_16 = 4; // There is only 36 larger than 18

    localparam addrbrdaddr_bit_8 = (DATA_WIDTH_B == 9 && widest_width == 18) ? 3 : (DATA_WIDTH_B == 9 && widest_width == 36) ? 4 : 4;
    
    localparam addrbrdaddr_bit_16 = 4; // There is only 36 larger than 18


    localparam mem_depth = (widest_width == 1) ? 16384 : (widest_width == 2) ? 8192 : (widest_width == 4) ? 4096 : (widest_width == 9) ? 2048 : 
			   (widest_width == 18) ? 1024 :(widest_width == 36) ? 512 : 16384;
		
    localparam memp_depth = (widest_width == 9) ? 2048 : (widest_width == 18) ? 1024 : (widest_width == 36) ? 512 : 2048;

    reg [widest_width-1:0] tmp_mem [mem_depth-1:0];
    
    reg [width-1:0] mem [mem_depth-1:0];
    reg [widthp-1:0] memp [memp_depth-1:0];

    integer count, countp, init_mult, initp_mult, large_width;
    integer count1, countp1, i, i1, i_p, i_mem;

    reg tmp1;
    reg [1:0] wr_mode_a, wr_mode_b;

    reg [31:0] doado_out, doado_buf, doado_outreg, doado_out_out;
    reg [31:0] dobdo_out, dobdo_buf, dobdo_outreg, dobdo_out_out;
    reg [3:0] dopbdop_out, dopbdop_buf, dopbdop_outreg, dopbdop_out_out;
    reg [3:0] dopadop_out, dopadop_buf, dopadop_outreg, dopadop_out_out;
    
    reg [63:0] di_x = 64'bx;

    reg [7:0] weawel_reg;
    reg enbrden_reg;
    reg [7:0] webweu_reg, webweu_tmp;
    reg rising_clkawrclk = 1'b0, rising_clkbrdclk = 1'b0;
    reg [15:0] addrawraddr_reg, addrbrdaddr_reg, addrawraddr_tmp, addrbrdaddr_tmp;

    reg [63:0] diadi_reg, dibdi_reg;
    reg [3:0] dipadip_reg;
    reg [7:0] dipbdip_reg;
    reg [1:0] viol_type = 2'b00, seq = 2'b00;
    reg [15:0] addr_tmp;
    reg [7:0] we_tmp;
    integer viol_time = 0;
    reg col_wr_wr_msg = 1, col_wra_rdb_msg = 1, col_wrb_rda_msg = 1;
    reg finish_error = 0;
    
    time curr_time, prev_time;

    wire clkawrclk_in, clkbrdclk_in;

    wire enawren_in, enbrden_in, regcea_in, regcebregce_in, rsta_in, rstbrst_in;

    wire [a_width-1:0] diadi_int;
    wire [b_width-1:0] dibdi_int;
    wire [a_widthp-1:0] dipadip_int;
    wire [b_widthp-1:0] dipbdip_int;
    wire [3:0] weawel_int, webweu_int;
    
    reg notifier, notifier_a, notifier_b;
    reg notifier_addra0, notifier_addra1, notifier_addra2, notifier_addra3, notifier_addra4;
    reg notifier_addra5, notifier_addra6, notifier_addra7, notifier_addra8, notifier_addra9;
    reg notifier_addra10, notifier_addra11, notifier_addra12, notifier_addra13;
    reg notifier_addrb0, notifier_addrb1, notifier_addrb2, notifier_addrb3, notifier_addrb4;
    reg notifier_addrb5, notifier_addrb6, notifier_addrb7, notifier_addrb8, notifier_addrb9;
    reg notifier_addrb10, notifier_addrb11, notifier_addrb12, notifier_addrb13;

    
    tri0 gsr_in = glbl.GSR;
    
    assign clkawrclk_in = CLKA;
    assign clkbrdclk_in = CLKB;
    
    assign diadi_int = DIA;
    assign dibdi_int = DIB;
    assign dipadip_int = DIPA;
    assign dipbdip_int = DIPB;
    assign DOA = doado_out_out;
    assign DOPA = dopadop_out_out;
    assign DOB = dobdo_out_out;
    assign DOPB = dopbdop_out_out;

    assign enawren_in = ENA;
    assign enbrden_in = ENB;
    assign regcea_in = REGCEA;
    assign regcebregce_in = REGCEB;
    assign rsta_in = RSTA;
    assign rstbrst_in = RSTB;
    assign weawel_int = WEA;
    assign webweu_int = WEB;

    assign addrawraddr_in = {2'b00,ADDRA};	
    assign addrbrdaddr_in = {2'b00,ADDRB};
    

    initial begin

	if (INIT_FILE == "NONE") begin
	
	    init_mult = 256/width;
	    
	    for (count = 0; count < init_mult; count = count + 1) begin
		for (count1 = 0; count1 < width; count1 = count1 + 1) begin
		    
		    mem[count][count1]                    = INIT_00[(count * width) + count1];
		    mem[count + (init_mult * 1)][count1]  = INIT_01[(count * width) + count1];
		    mem[count + (init_mult * 2)][count1]  = INIT_02[(count * width) + count1];
		    mem[count + (init_mult * 3)][count1]  = INIT_03[(count * width) + count1];
		    mem[count + (init_mult * 4)][count1]  = INIT_04[(count * width) + count1];
		    mem[count + (init_mult * 5)][count1]  = INIT_05[(count * width) + count1];
		    mem[count + (init_mult * 6)][count1]  = INIT_06[(count * width) + count1];
		    mem[count + (init_mult * 7)][count1]  = INIT_07[(count * width) + count1];
		    mem[count + (init_mult * 8)][count1]  = INIT_08[(count * width) + count1];
		    mem[count + (init_mult * 9)][count1]  = INIT_09[(count * width) + count1];
		    mem[count + (init_mult * 10)][count1] = INIT_0A[(count * width) + count1];
		    mem[count + (init_mult * 11)][count1] = INIT_0B[(count * width) + count1];
		    mem[count + (init_mult * 12)][count1] = INIT_0C[(count * width) + count1];
		    mem[count + (init_mult * 13)][count1] = INIT_0D[(count * width) + count1];
		    mem[count + (init_mult * 14)][count1] = INIT_0E[(count * width) + count1];
		    mem[count + (init_mult * 15)][count1] = INIT_0F[(count * width) + count1];
		    mem[count + (init_mult * 16)][count1] = INIT_10[(count * width) + count1];
		    mem[count + (init_mult * 17)][count1] = INIT_11[(count * width) + count1];
		    mem[count + (init_mult * 18)][count1] = INIT_12[(count * width) + count1];
		    mem[count + (init_mult * 19)][count1] = INIT_13[(count * width) + count1];
		    mem[count + (init_mult * 20)][count1] = INIT_14[(count * width) + count1];
		    mem[count + (init_mult * 21)][count1] = INIT_15[(count * width) + count1];
		    mem[count + (init_mult * 22)][count1] = INIT_16[(count * width) + count1];
		    mem[count + (init_mult * 23)][count1] = INIT_17[(count * width) + count1];
		    mem[count + (init_mult * 24)][count1] = INIT_18[(count * width) + count1];
		    mem[count + (init_mult * 25)][count1] = INIT_19[(count * width) + count1];
		    mem[count + (init_mult * 26)][count1] = INIT_1A[(count * width) + count1];
		    mem[count + (init_mult * 27)][count1] = INIT_1B[(count * width) + count1];
		    mem[count + (init_mult * 28)][count1] = INIT_1C[(count * width) + count1];
		    mem[count + (init_mult * 29)][count1] = INIT_1D[(count * width) + count1];
		    mem[count + (init_mult * 30)][count1] = INIT_1E[(count * width) + count1];
		    mem[count + (init_mult * 31)][count1] = INIT_1F[(count * width) + count1];
		    mem[count + (init_mult * 32)][count1] = INIT_20[(count * width) + count1];
		    mem[count + (init_mult * 33)][count1] = INIT_21[(count * width) + count1];
		    mem[count + (init_mult * 34)][count1] = INIT_22[(count * width) + count1];
		    mem[count + (init_mult * 35)][count1] = INIT_23[(count * width) + count1];
		    mem[count + (init_mult * 36)][count1] = INIT_24[(count * width) + count1];
		    mem[count + (init_mult * 37)][count1] = INIT_25[(count * width) + count1];
		    mem[count + (init_mult * 38)][count1] = INIT_26[(count * width) + count1];
		    mem[count + (init_mult * 39)][count1] = INIT_27[(count * width) + count1];
		    mem[count + (init_mult * 40)][count1] = INIT_28[(count * width) + count1];
		    mem[count + (init_mult * 41)][count1] = INIT_29[(count * width) + count1];
		    mem[count + (init_mult * 42)][count1] = INIT_2A[(count * width) + count1];
		    mem[count + (init_mult * 43)][count1] = INIT_2B[(count * width) + count1];
		    mem[count + (init_mult * 44)][count1] = INIT_2C[(count * width) + count1];
		    mem[count + (init_mult * 45)][count1] = INIT_2D[(count * width) + count1];
		    mem[count + (init_mult * 46)][count1] = INIT_2E[(count * width) + count1];
		    mem[count + (init_mult * 47)][count1] = INIT_2F[(count * width) + count1];
		    mem[count + (init_mult * 48)][count1] = INIT_30[(count * width) + count1];
		    mem[count + (init_mult * 49)][count1] = INIT_31[(count * width) + count1];
		    mem[count + (init_mult * 50)][count1] = INIT_32[(count * width) + count1];
		    mem[count + (init_mult * 51)][count1] = INIT_33[(count * width) + count1];
		    mem[count + (init_mult * 52)][count1] = INIT_34[(count * width) + count1];
		    mem[count + (init_mult * 53)][count1] = INIT_35[(count * width) + count1];
		    mem[count + (init_mult * 54)][count1] = INIT_36[(count * width) + count1];
		    mem[count + (init_mult * 55)][count1] = INIT_37[(count * width) + count1];
		    mem[count + (init_mult * 56)][count1] = INIT_38[(count * width) + count1];
		    mem[count + (init_mult * 57)][count1] = INIT_39[(count * width) + count1];
		    mem[count + (init_mult * 58)][count1] = INIT_3A[(count * width) + count1];
		    mem[count + (init_mult * 59)][count1] = INIT_3B[(count * width) + count1];
		    mem[count + (init_mult * 60)][count1] = INIT_3C[(count * width) + count1];
		    mem[count + (init_mult * 61)][count1] = INIT_3D[(count * width) + count1];
		    mem[count + (init_mult * 62)][count1] = INIT_3E[(count * width) + count1];
		    mem[count + (init_mult * 63)][count1] = INIT_3F[(count * width) + count1];
		end // for (count1 = 0; count1 < width; count1 = count1 + 1)
	    end // for (count = 0; count < init_mult; count = count + 1)

	    
	    if (width >= 8) begin
	    
		initp_mult = 256/widthp;
		
		for (countp = 0; countp < initp_mult; countp = countp + 1) begin
		    for (countp1 = 0; countp1 < widthp; countp1 = countp1 + 1) begin
			
			memp[countp][countp1]                     = INITP_00[(countp * widthp) + countp1];
			memp[countp + (initp_mult * 1)][countp1]  = INITP_01[(countp * widthp) + countp1];
			memp[countp + (initp_mult * 2)][countp1]  = INITP_02[(countp * widthp) + countp1];
			memp[countp + (initp_mult * 3)][countp1]  = INITP_03[(countp * widthp) + countp1];
			memp[countp + (initp_mult * 4)][countp1]  = INITP_04[(countp * widthp) + countp1];
			memp[countp + (initp_mult * 5)][countp1]  = INITP_05[(countp * widthp) + countp1];
			memp[countp + (initp_mult * 6)][countp1]  = INITP_06[(countp * widthp) + countp1];
			memp[countp + (initp_mult * 7)][countp1]  = INITP_07[(countp * widthp) + countp1];
			
		    end // for (countp1 = 0; countp1 < widthp; countp1 = countp1 + 1)
		end // for (countp = 0; countp < initp_mult; countp = countp + 1)
		
	    end // if (width >= 8)
	    
	end // if (INIT_FILE == "NONE")
	
	else begin

	    $readmemh (INIT_FILE, tmp_mem);

	    case (widest_width)

		1, 2, 4 : for (i_mem = 0; i_mem <= mem_depth; i_mem = i_mem + 1)
		              mem[i_mem] = tmp_mem [i_mem];
		
		9 : for (i_mem = 0; i_mem <= mem_depth; i_mem = i_mem + 1) begin
		        mem[i_mem] = tmp_mem[i_mem][0 +: 8];
		        memp[i_mem] = tmp_mem[i_mem][8 +: 1];
	            end

		18 : for (i_mem = 0; i_mem <= mem_depth; i_mem = i_mem + 1) begin
		         mem[i_mem] = tmp_mem[i_mem][0 +: 16];
		         memp[i_mem] = tmp_mem[i_mem][16 +: 2];
	             end
	    
		36 : for (i_mem = 0; i_mem <= mem_depth; i_mem = i_mem + 1) begin
		         mem[i_mem] = tmp_mem[i_mem][0 +: 32];
		         memp[i_mem] = tmp_mem[i_mem][32 +: 4];
	             end

	    endcase // case(widest_width)
	    
	end // else: !if(INIT_FILE == "NONE")
	
	
	case (DATA_WIDTH_A)

	    0, 1, 2, 4, 9, 18, 36: ;

	    default : begin
		          $display("Attribute Syntax Error : The attribute DATA_WIDTH_A on X_RAMB16BWER instance %m is set to %d.  Legal values for this attribute are 0, 1, 2, 4, 9, 18 or 36.", DATA_WIDTH_A);
		          finish_error = 1;
	              end

	endcase // case(DATA_WIDTH_A)

	
	case (DATA_WIDTH_B)

	    0, 1, 2, 4, 9, 18, 36: ;

	    default : begin
		          $display("Attribute Syntax Error : The attribute DATA_WIDTH_B on X_RAMB16BWER instance %m is set to %d.  Legal values for this attribute are 0, 1, 2, 4, 9, 18 or 36.", DATA_WIDTH_B);
		          finish_error = 1;
	              end

	endcase // case(DATA_WIDTH_B)


	if (DATA_WIDTH_A == 0 && DATA_WIDTH_B == 0) begin
	    $display("Attribute Syntax Error : Attributes DATA_WIDTH_A and DATA_WIDTH_B on X_RAMB16BWER instance %m, both can not be 0.");
	    finish_error = 1;
	end

	       
	case (WRITE_MODE_A)
	    "WRITE_FIRST" : wr_mode_a <= 2'b00;
	    "READ_FIRST"  : wr_mode_a <= 2'b01;
	    "NO_CHANGE"   : wr_mode_a <= 2'b10;
	    default       : begin
				$display("Attribute Syntax Error : The Attribute WRITE_MODE_A on X_RAMB16BWER instance %m is set to %s.  Legal values for this attribute are WRITE_FIRST, READ_FIRST or NO_CHANGE.", WRITE_MODE_A);
				finish_error = 1;
			    end
	endcase


	case (WRITE_MODE_B)
	    "WRITE_FIRST" : wr_mode_b <= 2'b00;
	    "READ_FIRST"  : wr_mode_b <= 2'b01;
	    "NO_CHANGE"   : wr_mode_b <= 2'b10;
	    default       : begin
				$display("Attribute Syntax Error : The Attribute WRITE_MODE_B on X_RAMB16BWER instance %m is set to %s.  Legal values for this attribute are WRITE_FIRST, READ_FIRST or NO_CHANGE.", WRITE_MODE_B);
				finish_error = 1;
			    end
	endcase

	
	if ((SIM_COLLISION_CHECK != "ALL") && (SIM_COLLISION_CHECK != "NONE") && (SIM_COLLISION_CHECK != "WARNING_ONLY") && (SIM_COLLISION_CHECK != "GENERATE_X_ONLY")) begin
	    
	    $display("Attribute Syntax Error : The attribute SIM_COLLISION_CHECK on X_RAMB16BWER instance %m is set to %s.  Legal values for this attribute are ALL, NONE, WARNING_ONLY or GENERATE_X_ONLY.", SIM_COLLISION_CHECK);
	    finish_error = 1;

	end


	if ((EN_RSTRAM_A != "TRUE") && (EN_RSTRAM_A != "FALSE")) begin
	    $display("Attribute Syntax Error : The attribute EN_RSTRAM_A on X_RAMB16BWER instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", EN_RSTRAM_A);
	    finish_error = 1;
	end
	

	if ((EN_RSTRAM_B != "TRUE") && (EN_RSTRAM_B != "FALSE")) begin
	    $display("Attribute Syntax Error : The attribute EN_RSTRAM_B on X_RAMB16BWER instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", EN_RSTRAM_B);
	    finish_error = 1;
	end
	
	
	if ((RST_PRIORITY_A != "SR") && (RST_PRIORITY_A != "CE")) begin
	    $display("Attribute Syntax Error : The attribute RST_PRIORITY_A on X_RAMB16BWER instance %m is set to %s.  Legal values for this attribute are CE or SR.", RST_PRIORITY_A);
	    finish_error = 1;
	end
	
	
	if ((RST_PRIORITY_B != "SR") && (RST_PRIORITY_B != "CE")) begin
	    $display("Attribute Syntax Error : The attribute RST_PRIORITY_B on X_RAMB16BWER instance %m is set to %s.  Legal values for this attribute are CE or SR.", RST_PRIORITY_B);
	    finish_error = 1;
	end

	
	if (finish_error == 1)
	    $finish;

	
    end // initial begin


    always @(gsr_in)
	if (gsr_in) begin
	    
	    assign doado_out = INIT_A[0 +: a_width];
	    
	    if (a_width >= 8) begin
		assign dopadop_out = INIT_A[a_width +: a_widthp];
	    end

	    assign dobdo_out = INIT_B[0 +: b_width];
		
	    if (b_width >= 8) begin
		assign dopbdop_out = INIT_B[b_width +: b_widthp];
	    end

	end
	else begin
	    deassign doado_out;
	    deassign dopadop_out;
	    deassign dobdo_out;
	    deassign dopbdop_out;
	end


    always @(rsta_in or enawren_in or regcea_in) begin

	if (RSTTYPE == "ASYNC" && gsr_in == 1'b0 && rsta_in === 1'b1) begin // async reset

	    // reset latch regardless DOA_REG
	    if (((enawren_in == 1'b1 && RST_PRIORITY_A == "CE") || RST_PRIORITY_A == "SR") && EN_RSTRAM_A == "TRUE") begin		    
		    
		assign doado_buf = SRVAL_A[0 +: a_width];
		assign doado_out = SRVAL_A[0 +: a_width];
		    
		if (a_width >= 8) begin
		    assign dopadop_buf = SRVAL_A[a_width +: a_widthp];
		    assign dopadop_out = SRVAL_A[a_width +: a_widthp];
		end
	    end


	    if (DOA_REG == 1) begin

		if (SIM_DEVICE == "SPARTAN3ADSP") begin
		    
		    if ((enawren_in == 1'b1 && RST_PRIORITY_A == "CE") || RST_PRIORITY_A == "SR") begin
			assign doado_outreg = SRVAL_A[0 +: a_width];
		    
			if (a_width >= 8)
			    assign dopadop_outreg = SRVAL_A[a_width +: a_widthp];
		    
		    end
		end // if (SIM_DEVICE == "SPARTAN3ADSP")
		else if (SIM_DEVICE == "SPARTAN6") begin
		    
		    if ((regcea_in == 1'b1 && RST_PRIORITY_A == "CE") || RST_PRIORITY_A == "SR") begin
			assign doado_outreg = SRVAL_A[0 +: a_width];
		    
			if (a_width >= 8)
			    assign dopadop_outreg = SRVAL_A[a_width +: a_widthp];
		    
		    end
		end
	    end // if (DOA_REG == 1)
	end // if (RSTTYPE == "ASYNC" && gsr_in == 1'b0 && rsta_in === 1'b1)
	else if (rsta_in === 1'b0) begin
		    
		deassign doado_buf;
		deassign doado_out;
		deassign dopadop_buf;
		deassign dopadop_out;
		deassign doado_outreg;
		deassign dopadop_outreg;
		
	end

    end // always @ (rsta_in or enawren_in or regcea_in)
        
	    
    always @(rstbrst_in or enbrden_in or regcebregce_in) begin

	if (RSTTYPE == "ASYNC" && gsr_in == 1'b0 && rstbrst_in == 1'b1) begin

	    // reset latch regardless DOB_REG
	    if (((enbrden_in == 1'b1 && RST_PRIORITY_B == "CE") || RST_PRIORITY_B == "SR") && EN_RSTRAM_B == "TRUE") begin		    
		
		assign dobdo_buf = SRVAL_B[0 +: b_width];
		assign dobdo_out = SRVAL_B[0 +: b_width];
		
		if (b_width >= 8) begin
		    assign dopbdop_buf = SRVAL_B[b_width +: b_widthp];
		    assign dopbdop_out = SRVAL_B[b_width +: b_widthp];
		end
	    end
		

	    if (DOB_REG == 1) begin

		if (SIM_DEVICE == "SPARTAN3ADSP") begin
		    
		    if ((enbrden_in == 1'b1 && RST_PRIORITY_B == "CE") || RST_PRIORITY_B == "SR") begin
			assign dobdo_outreg = SRVAL_B[0 +: b_width];
		    
			if (b_width >= 8)
			    assign dopbdop_outreg = SRVAL_B[b_width +: b_widthp];
		    
		    end
		end // if (SIM_DEVICE == "SPARTAN3ADSP")
		else if (SIM_DEVICE == "SPARTAN6") begin
		    
		    if ((regcebregce_in == 1'b1 && RST_PRIORITY_B == "CE") || RST_PRIORITY_B == "SR") begin
			assign 	   dobdo_outreg = SRVAL_B[0 +: b_width];
		    
			if (b_width >= 8)
			    assign dopbdop_outreg = SRVAL_B[b_width +: b_widthp];
		    
		    end
		end
	    end // if (DOB_REG == 1)
	end // if (RSTTYPE == "ASYNC" && gsr_in == 1'b0 && rstbrst_in == 1'b1)
	else if (rstbrst_in == 1'b0) begin
		
		deassign dobdo_buf;
		deassign dobdo_out;
		deassign dopbdop_buf;
		deassign dopbdop_out;
		deassign dobdo_outreg;
		deassign dopbdop_outreg;
		
	end
	
    end // always @ (rstbrst_in or enbrden_in or regcebregce_in)

    
    always @(posedge clkawrclk_in) begin

	rising_clkawrclk = 1;
	
	if (enawren_in === 1'b1) begin
	    prev_time = curr_time;
	    curr_time = $time;
	    addrawraddr_reg = addrawraddr_in;
	    weawel_reg = weawel_int;
	    diadi_reg = diadi_int;
	    dipadip_reg = dipadip_int;
	    col_addra_reconstruct_reg = col_addra_reconstruct;
	end

    end

    always @(posedge clkbrdclk_in) begin

	rising_clkbrdclk = 1;
	
	if (enbrden_in === 1'b1) begin
	    prev_time = curr_time;
	    curr_time = $time;
	    addrbrdaddr_reg = addrbrdaddr_in;
	    webweu_reg = webweu_int;
	    enbrden_reg = enbrden_in;
	    dibdi_reg = dibdi_int;
	    dipbdip_reg = dipbdip_int;
	    col_addrb_reconstruct_reg = col_addrb_reconstruct;
	end

    end // always @ (posedge clkbrdclk_in)
    

    always @(posedge rising_clkawrclk or posedge rising_clkbrdclk) begin

	
/************************************* Collision starts *****************************************/

	  if (SIM_COLLISION_CHECK != "NONE") begin
	    
	    if (gsr_in === 1'b0) begin
		if (curr_time - prev_time <= 100) begin
		    viol_time = 1;
		end
		else if (curr_time - prev_time <= SETUP_READ_FIRST) begin
		    viol_time = 2;
		end

		
		if (enawren_in === 1'b0 || enbrden_in === 1'b0)
		    viol_time = 0;

		
		if ((DATA_WIDTH_A <= 9 && weawel_int[0] === 1'b0) || (DATA_WIDTH_A == 18 && weawel_int[1:0] === 2'b00) || (DATA_WIDTH_A == 36 && weawel_int[3:0] === 4'b0000))
		    if ((DATA_WIDTH_B <= 9 && webweu_int[0] === 1'b0) || (DATA_WIDTH_B == 18 && webweu_int[1:0] === 2'b00) || (DATA_WIDTH_B == 36 && webweu_int[3:0] === 4'b0000))
			viol_time = 0;
		 
		
		if (viol_time != 0) begin
		    
		    if ((rising_clkawrclk && rising_clkbrdclk) || viol_time == 1) begin
			if (addrawraddr_in[13:col_addr_lsb] === addrbrdaddr_in[13:col_addr_lsb]) begin
			    
			    viol_type = 2'b01;

			    task_rd_ram_a (addrawraddr_in, doado_buf, dopadop_buf);
			    task_rd_ram_b (addrbrdaddr_in, dobdo_buf, dopbdop_buf);

			    task_col_wr_ram_a (2'b00, webweu_int, weawel_int, di_x, di_x[7:0], addrbrdaddr_in, addrawraddr_in);
			    task_col_wr_ram_b (2'b00, weawel_int, webweu_int, di_x, di_x[7:0], addrawraddr_in, addrbrdaddr_in);

			    task_col_rd_ram_a (2'b01, webweu_int, weawel_int, addrawraddr_in, doado_buf, dopadop_buf);
			    task_col_rd_ram_b (2'b01, weawel_int, webweu_int, addrbrdaddr_in, dobdo_buf, dopbdop_buf);

			    task_col_wr_ram_a (2'b10, webweu_int, weawel_int, diadi_int, dipadip_int, addrbrdaddr_in, addrawraddr_in);
			    task_col_wr_ram_b (2'b10, weawel_int, webweu_int, dibdi_int, dipbdip_int, addrawraddr_in, addrbrdaddr_in);
			    
			    if (wr_mode_a != 2'b01)
				task_col_rd_ram_a (2'b11, webweu_int, weawel_int, addrawraddr_in, doado_buf, dopadop_buf);
			    if (wr_mode_b != 2'b01)
				task_col_rd_ram_b (2'b11, weawel_int, webweu_int, addrbrdaddr_in, dobdo_buf, dopbdop_buf);

			end // if (addrawraddr_in[13:col_addr_lsb] === addrbrdaddr_in[13:col_addr_lsb])
			else
			    viol_time = 0;
			
		    end
		    else if (rising_clkawrclk && !rising_clkbrdclk) begin
			if (col_addra_reconstruct[13:col_addr_lsb] === col_addrb_reconstruct_reg[13:col_addr_lsb]) begin  
			
			    viol_type = 2'b10;

			    task_rd_ram_a (addrawraddr_in, doado_buf, dopadop_buf);
			    
			    task_col_wr_ram_a (2'b00, webweu_reg, weawel_int, di_x, di_x[7:0], addrbrdaddr_reg, addrawraddr_in);
			    task_col_wr_ram_b (2'b00, weawel_int, webweu_reg, di_x, di_x[7:0], addrawraddr_in, addrbrdaddr_reg);
			    
			    task_col_rd_ram_a (2'b01, webweu_reg, weawel_int, addrawraddr_in, doado_buf, dopadop_buf);
			    task_col_rd_ram_b (2'b01, weawel_int, webweu_reg, addrbrdaddr_reg, dobdo_buf, dopbdop_buf);
			    
			    task_col_wr_ram_a (2'b10, webweu_reg, weawel_int, diadi_int, dipadip_int, addrbrdaddr_reg, addrawraddr_in);
			    task_col_wr_ram_b (2'b10, weawel_int, webweu_reg, dibdi_reg, dipbdip_reg, addrawraddr_in, addrbrdaddr_reg);

			    if (wr_mode_a != 2'b01)
				task_col_rd_ram_a (2'b11, webweu_reg, weawel_int, addrawraddr_in, doado_buf, dopadop_buf);
			    if (wr_mode_b != 2'b01)
				task_col_rd_ram_b (2'b11, weawel_int, webweu_reg, addrbrdaddr_reg, dobdo_buf, dopbdop_buf);

			    if (wr_mode_a == 2'b01 || wr_mode_b == 2'b01) begin
				task_col_wr_ram_a (2'b10, webweu_reg, weawel_int, di_x, di_x[7:0], addrbrdaddr_reg, addrawraddr_in);
				task_col_wr_ram_b (2'b10, weawel_int, webweu_reg, di_x, di_x[7:0], addrawraddr_in, addrbrdaddr_reg);
			    end
			    
			end // if (addrawraddr_in[13:col_addr_lsb] === addrbrdaddr_reg[13:col_addr_lsb])
			else
			    viol_time = 0;
			
		    end
		    else if (!rising_clkawrclk && rising_clkbrdclk) begin
			if (col_addra_reconstruct_reg[13:col_addr_lsb] === col_addrb_reconstruct[13:col_addr_lsb]) begin
						    
			    viol_type = 2'b11;

			    task_rd_ram_b (addrbrdaddr_in, dobdo_buf, dopbdop_buf);

			    task_col_wr_ram_a (2'b00, webweu_int, weawel_reg, di_x, di_x[7:0], addrbrdaddr_in, addrawraddr_reg);
			    task_col_wr_ram_b (2'b00, weawel_reg, webweu_int, di_x, di_x[7:0], addrawraddr_reg, addrbrdaddr_in);
			    
			    task_col_rd_ram_a (2'b01, webweu_int, weawel_reg, addrawraddr_reg, doado_buf, dopadop_buf);
			    task_col_rd_ram_b (2'b01, weawel_reg, webweu_int, addrbrdaddr_in, dobdo_buf, dopbdop_buf);

			    task_col_wr_ram_a (2'b10, webweu_int, weawel_reg, diadi_reg, dipadip_reg, addrbrdaddr_in, addrawraddr_reg);
			    task_col_wr_ram_b (2'b10, weawel_reg, webweu_int, dibdi_int, dipbdip_int, addrawraddr_reg, addrbrdaddr_in);
			    
			    if (wr_mode_a != 2'b01)			    
				task_col_rd_ram_a (2'b11, webweu_int, weawel_reg, addrawraddr_reg, doado_buf, dopadop_buf);
			    if (wr_mode_b != 2'b01)
				task_col_rd_ram_b (2'b11, weawel_reg, webweu_int, addrbrdaddr_in, dobdo_buf, dopbdop_buf);

			    if (wr_mode_a == 2'b01 || wr_mode_b == 2'b01) begin
				task_col_wr_ram_a (2'b10, webweu_int, weawel_reg, di_x, di_x[7:0], addrbrdaddr_in, addrawraddr_reg);
				task_col_wr_ram_b (2'b10, weawel_reg, webweu_int, di_x, di_x[7:0], addrawraddr_reg, addrbrdaddr_in);
			    end
			    
			end // if (addrawraddr_reg[13:col_addr_lsb] === addrbrdaddr_in[13:col_addr_lsb])
			else
			    viol_time = 0;
			
		    end
		    
		end // if (viol_time != 0)
	    end // if (gsr_in === 1'b0)
	      
	    if (SIM_COLLISION_CHECK == "WARNING_ONLY")
		viol_time = 0;
	    
	  end // if (SIM_COLLISION_CHECK != "NONE")

	
/*************************************** end collision ********************************/


	if (gsr_in == 1'b0) begin

/**************************** Port A ****************************************/
	    if (rising_clkawrclk) begin

		if ((enawren_in == 1'b1 && RST_PRIORITY_A == "CE") || RST_PRIORITY_A == "SR") begin
		
		    if (rsta_in == 1'b1 && EN_RSTRAM_A == "TRUE") begin // sync reset
			doado_buf = SRVAL_A[0 +: a_width];
			doado_out = SRVAL_A[0 +: a_width];
			
			if (a_width >= 8) begin
			    dopadop_buf = SRVAL_A[a_width +: a_widthp];
			    dopadop_out = SRVAL_A[a_width +: a_widthp];
			end
		    end
		    

		    if (viol_time == 0) begin
			
			if (wr_mode_a == 2'b01 && (rsta_in === 1'b0 || EN_RSTRAM_A == "FALSE")) // read_first
			    task_rd_ram_a (addrawraddr_in, doado_buf, dopadop_buf);
			
			
			if (enawren_in == 1'b1)
			    task_wr_ram_a (weawel_int, diadi_int, dipadip_int, addrawraddr_in); // write
			
			
			if (wr_mode_a != 2'b01 && (rsta_in === 1'b0 || EN_RSTRAM_A == "FALSE")) // !read_first
			    task_rd_ram_a (addrawraddr_in, doado_buf, dopadop_buf);
			
		    end // if (viol_time == 0)
		    
		end // if ((enawren_in == 1'b1 && RST_PRIORITY_A == "CE") || RST_PRIORITY_A == "SR")
		
	    end // if (rising_clkawrclk)
	    // end of port A
	    

/************************************** port B ***************************************************************/	
	    if (rising_clkbrdclk) begin

		if ((enbrden_in == 1'b1 && RST_PRIORITY_B == "CE") || RST_PRIORITY_B == "SR") begin
		    if (rstbrst_in == 1'b1 && EN_RSTRAM_B == "TRUE") begin
			
			dobdo_buf = SRVAL_B[0 +: b_width];
			dobdo_out = SRVAL_B[0 +: b_width];
			
			if (b_width >= 8) begin
			    dopbdop_buf = SRVAL_B[b_width +: b_widthp];
			    dopbdop_out = SRVAL_B[b_width +: b_widthp];
			end
			
		    end
		    

		    if (viol_time == 0) begin
			
			if (wr_mode_b == 2'b01 && (rstbrst_in === 1'b0 || EN_RSTRAM_B == "FALSE")) // read_first
			    task_rd_ram_b (addrbrdaddr_in, dobdo_buf, dopbdop_buf);		
			
			
			if (enbrden_in == 1'b1)
			    task_wr_ram_b (webweu_int, dibdi_int, dipbdip_int, addrbrdaddr_in); // write
			
			
			if (wr_mode_b != 2'b01 && (rstbrst_in === 1'b0 || EN_RSTRAM_B == "FALSE")) // !read_first
			    task_rd_ram_b (addrbrdaddr_in, dobdo_buf, dopbdop_buf);
			
		    end // if (viol_time == 0)

		
		end // if ((enbrden_in == 1'b1 && RST_PRIORITY_B == "CE") || RST_PRIORITY_B == "SR")

	    end // if (rising_clkbrdclk)
	    // end of port B
		
	
	    // writing outputs of port A	
	    if (enawren_in && (rising_clkawrclk || viol_time != 0)) begin
		
		if ((rsta_in === 1'b0 || EN_RSTRAM_A == "FALSE") && (wr_mode_a != 2'b10 || (DATA_WIDTH_A <= 9 && weawel_int[0] === 1'b0) || (DATA_WIDTH_A == 18 && weawel_int[1:0] === 2'b00) || (DATA_WIDTH_A == 36 && weawel_int[3:0] === 4'b0000))) begin
		    
		    doado_out <= doado_buf;
		    
		    if (a_width >= 8)	
			dopadop_out <= dopadop_buf;
		    
		end
		
	    end
	    
	    
	    // writing outputs of port B	
	    if (enbrden_in && (rising_clkbrdclk || viol_time != 0)) begin
		
		if ((rstbrst_in === 1'b0 || EN_RSTRAM_B == "FALSE") && (wr_mode_b != 2'b10 || (DATA_WIDTH_B <= 9 && webweu_int[0] === 1'b0) || (DATA_WIDTH_B == 18 && webweu_int[1:0] === 2'b00) || (DATA_WIDTH_B == 36 && webweu_int[3:0] === 4'b0000))) begin
			
		    dobdo_out <= dobdo_buf;
			
		    if (b_width >= 8)
			    dopbdop_out <= dopbdop_buf;
		    
		end
		
	    end
	    
	end // if (gsr_in == 1'b0)
	
	
	viol_time = 0;
	rising_clkawrclk = 0;
	rising_clkbrdclk = 0;
	viol_type = 2'b00;
	col_wr_wr_msg = 1;
	col_wra_rdb_msg = 1;
	col_wrb_rda_msg = 1;

	
    end // always @ (posedge rising_clkawrclk or posedge rising_clkbrdclk)

    
    // ***** Output Registers **** Port A *****
    always @(posedge clkawrclk_in or posedge gsr_in) begin
	
	if (DOA_REG == 1) begin

	    if (gsr_in == 1'b1) begin
		
		doado_outreg <= INIT_A[0 +: a_width];

		if (a_width >= 8)
		    dopadop_outreg <= INIT_A[a_width +: a_widthp];
		
	    end
	    else if (gsr_in == 1'b0) begin

		if (RST_PRIORITY_A == "CE") begin

		    if (SIM_DEVICE == "SPARTAN6") begin
			
			if (regcea_in == 1'b1) begin
		    
 			    if (rsta_in === 1'b1) begin
			    
				doado_outreg <= SRVAL_A[0 +: a_width];
			    
				if (a_width >= 8)
				    dopadop_outreg <= SRVAL_A[a_width +: a_widthp];
				
			    end
			    else if (rsta_in === 1'b0) begin
				
				doado_outreg <= doado_out;
				
				if (a_width >= 8)
				    dopadop_outreg <= dopadop_out;
			    end
			    
			end // if (regcea_in == 1'b1)

		    end // if (SIM_DEVICE == "SPARTAN6")
		    else if (SIM_DEVICE == "SPARTAN3ADSP") begin

 			if (rsta_in === 1'b1 && enawren_in == 1'b1) begin
			    
			    doado_outreg <= SRVAL_A[0 +: a_width];
			    
			    if (a_width >= 8)
				dopadop_outreg <= SRVAL_A[a_width +: a_widthp];
			    
			end
			else if (rsta_in === 1'b0 && regcea_in == 1'b1) begin
			    
			    doado_outreg <= doado_out;

			    if (a_width >= 8)
				dopadop_outreg <= dopadop_out;
			
			end
		    end // if (SIM_DEVICE == "SPARTAN3ADSP")
			
		end // if (RST_PRIORITY_A == "CE")
		else begin

 		    if (rsta_in === 1'b1) begin
			
			doado_outreg <= SRVAL_A[0 +: a_width];
			
			if (a_width >= 8)
			    dopadop_outreg <= SRVAL_A[a_width +: a_widthp];
			
		    end
		    else if (rsta_in === 1'b0) begin
			
			if (regcea_in == 1'b1) begin
			    
			    doado_outreg <= doado_out;
			    
			    if (a_width >= 8)
				dopadop_outreg <= dopadop_out;
			
			end
			
		    end
		    
		end
		
	    end // if (gsr_in == 1'b0)

	end // if (DOA_REG == 1)

    end // always @ (posedge clkawrclk_in or posedge gsr_in)
    

    always @(doado_out or dopadop_out or doado_outreg or dopadop_outreg) begin

	case (DOA_REG)

	    0 : begin
	            doado_out_out[0 +: a_width] = doado_out[0 +: a_width];
		
		    if (a_width >= 8)
			dopadop_out_out[0 +: a_widthp] = dopadop_out[0 +: a_widthp];

	        end
	    1 : begin
	            doado_out_out[0 +: a_width] = doado_outreg[0 +: a_width];

		    if (a_width >= 8)
			dopadop_out_out[0 +: a_widthp] = dopadop_outreg[0 +: a_widthp];

	        end
	    default : begin
	                  $display("Attribute Syntax Error : The attribute DOA_REG on X_RAMB16BWER instance %m is set to %2d.  Legal values for this attribute are 0 or 1.", DOA_REG);
	                  $finish;
	              end

	endcase

    end // always @ (doado_out or dopadop_out or doado_outreg or dopadop_outreg)
    
    
// ***** Output Registers **** Port B *****
    always @(posedge clkbrdclk_in or posedge gsr_in) begin

	if (DOB_REG == 1) begin
	
	    if (gsr_in == 1'b1) begin

		dobdo_outreg <= INIT_B[0 +: b_width];
		
		if (b_width >= 8)
		    dopbdop_outreg <= INIT_B[b_width +: b_widthp];
		
	    end
	    else if (gsr_in == 1'b0) begin

		if (RST_PRIORITY_B == "CE") begin

		    if (SIM_DEVICE == "SPARTAN6") begin
			
			if (regcebregce_in == 1'b1) begin
		    
 			    if (rstbrst_in === 1'b1) begin
			    
				dobdo_outreg <= SRVAL_B[0 +: b_width];
			    
				if (b_width >= 8)
				    dopbdop_outreg <= SRVAL_B[b_width +: b_widthp];
				
			    end
			    else if (rstbrst_in === 1'b0) begin
				
				dobdo_outreg <= dobdo_out;

				if (b_width >= 8)
				    dopbdop_outreg <= dopbdop_out;

			    end
			    
			end // if (regcebregce_in == 1'b1)

		    end // if (SIM_DEVICE == "SPARTAN6")
		    else if (SIM_DEVICE == "SPARTAN3ADSP") begin

 			if (rstbrst_in === 1'b1 && enbrden_in == 1'b1) begin
			    
			    dobdo_outreg <= SRVAL_B[0 +: b_width];
			    
			    if (b_width >= 8)
				dopbdop_outreg <= SRVAL_B[b_width +: b_widthp];
			    
			end
			else if (rstbrst_in === 1'b0 && regcebregce_in == 1'b1) begin
			    
			    dobdo_outreg <= dobdo_out;

			    if (b_width >= 8)
				dopbdop_outreg <= dopbdop_out;
			
			end
		    end // if (SIM_DEVICE == "SPARTAN3ADSP")
			
		end // if (RST_PRIORITY_B == "CE")
		else begin
		    
 		    if (rstbrst_in === 1'b1) begin
			
			dobdo_outreg <= SRVAL_B[0 +: b_width];
			
			if (b_width >= 8)
			    dopbdop_outreg <= SRVAL_B[b_width +: b_widthp];
			
		    end
		    else if (rstbrst_in === 1'b0) begin
			
			if (regcebregce_in == 1'b1) begin		
			    
			    dobdo_outreg <= dobdo_out;

			    if (b_width >= 8)
				dopbdop_outreg <= dopbdop_out;

			end
			
		    end

		end // else: !if(RST_PRIORITY_B == "CE")
		
	    end // if (gsr_in == 1'b0)

	end // if (DOB_REG == 1)

    end // always @ (posedge clkbrdclk_in or posedge gsr_in)
    

    always @(dobdo_out or dopbdop_out or dobdo_outreg or dopbdop_outreg) begin

	case (DOB_REG)
	    
	    0 : begin
                    dobdo_out_out[0 +: b_width] = dobdo_out[0 +: b_width];

		    if (b_width >= 8)
			dopbdop_out_out[0 +: b_widthp] = dopbdop_out[0 +: b_widthp];

	        end
	    1 : begin
	            dobdo_out_out[0 +: b_width] = dobdo_outreg[0 +: b_width];
		
		    if (b_width >= 8)
			dopbdop_out_out[0 +: b_widthp] = dopbdop_outreg[0 +: b_widthp];

	        end
	    default : begin
	                  $display("Attribute Syntax Error : The attribute DOB_REG on X_RAMB16BWER instance %m is set to %2d.  Legal values for this attribute are 0 or 1.", DOB_REG);
	                  $finish;
	              end

	endcase

    end // always @ (dobdo_out or dopbdop_out or dobdo_outreg or dopbdop_outreg)

    
/******************************************** task and function **************************************/
	
    task task_ram;

	input we;
	input [7:0] di;
	input dip;
	inout [7:0] mem_task;
	inout memp_task;

	begin

	    if (we == 1'b1) begin

		mem_task = di;
		
		if (width >= 8)
		    memp_task = dip;
	    end
	end

    endtask // task_ram

    
    task task_ram_col;

	input we_o;
	input we;
	input [7:0] di;
	input dip;
	inout [7:0] mem_task;
	inout memp_task;
	integer i;
	
	begin

	    if (we == 1'b1) begin

		for (i = 0; i < 8; i = i + 1)
		    if (mem_task[i] !== 1'bx || !(we === we_o && we === 1'b1))
			mem_task[i] = di[i];
		
		if (width >= 8 && (memp_task !== 1'bx || !(we === we_o && we === 1'b1)))
		    memp_task = dip;
		
	    end
	end

    endtask // task_ram_col
    

    task task_x_buf;
	input [1:0] wr_rd_mode;
	input integer do_uindex;
	input integer do_lindex;
	input integer dop_index;	
	input [63:0] do_ltmp;
	inout [63:0] do_tmp;
	input [7:0] dop_ltmp;
	inout [7:0] dop_tmp;
	integer i;

	begin

	    if (wr_rd_mode == 2'b01) begin
		for (i = do_lindex; i <= do_uindex; i = i + 1) begin
		    if (do_ltmp[i] === 1'bx)
			do_tmp[i] = 1'bx;
		end
		
		if (dop_ltmp[dop_index] === 1'bx)
		    dop_tmp[dop_index] = 1'bx;
		
	    end // if (wr_rd_mode == 2'b01)
	    else begin
		do_tmp[do_lindex +: 8] = do_ltmp[do_lindex +: 8];
		dop_tmp[dop_index] = dop_ltmp[dop_index];

	    end // else: !if(wr_rd_mode == 2'b01)
	end
	
    endtask // task_x_buf
    
    
    task task_col_wr_ram_a;

	input [1:0] seq;
	input [7:0] webweu_tmp;
	input [7:0] weawel_tmp;
	input [63:0] diadi_tmp;
	input [7:0] dipadip_tmp;
	input [15:0] addrbrdaddr_tmp;
	input [15:0] addrawraddr_tmp;

	begin
	    
	    case (a_width)

		1, 2, 4 : begin
		              if (!(weawel_tmp[0] === 1'b1 && webweu_tmp[0] === 1'b1 && a_width > b_width) || seq == 2'b10) begin				  
				  if (a_width >= width)
				      task_ram_col (webweu_tmp[0], weawel_tmp[0], diadi_tmp[a_width-1:0], 1'b0, mem[addrawraddr_tmp[14:addrawraddr_lbit_124]], tmp1);
				  else
				      task_ram_col (webweu_tmp[0], weawel_tmp[0], diadi_tmp[a_width-1:0], 1'b0, mem[addrawraddr_tmp[14:addrawraddr_bit_124+1]][(addrawraddr_tmp[addrawraddr_bit_124:addrawraddr_lbit_124] * a_width) +: a_width], tmp1);				      

				  if (seq == 2'b00)
				      chk_for_col_msg (weawel_tmp[0], webweu_tmp[0], addrawraddr_tmp, addrbrdaddr_tmp);
		  
			      end // if (!(weawel_tmp[0] === 1'b1 && webweu_tmp[0] === 1'b1 && a_width > b_width) || seq == 2'b10)
		          end // case: 1, 2, 4
		8 : begin
		        if (!(weawel_tmp[0] === 1'b1 && webweu_tmp[0] === 1'b1 && a_width > b_width) || seq == 2'b10) begin				  
			    if (a_width >= width)
				task_ram_col (webweu_tmp[0], weawel_tmp[0], diadi_tmp[7:0], dipadip_tmp[0], mem[addrawraddr_tmp[14:3]], memp[addrawraddr_tmp[14:3]]);
			    else
				task_ram_col (webweu_tmp[0], weawel_tmp[0], diadi_tmp[7:0], dipadip_tmp[0], mem[addrawraddr_tmp[14:addrawraddr_bit_8+1]][(addrawraddr_tmp[addrawraddr_bit_8:3] * 8) +: 8], memp[addrawraddr_tmp[14:addrawraddr_bit_8+1]][(addrawraddr_tmp[addrawraddr_bit_8:3] * 1) +: 1]);
			    
			    if (seq == 2'b00)
				chk_for_col_msg (weawel_tmp[0], webweu_tmp[0], addrawraddr_tmp, addrbrdaddr_tmp);
				
			end // if (a_width <= b_width)
		     end // case: 8
		16 : begin
		         if (!(weawel_tmp[0] === 1'b1 && webweu_tmp[0] === 1'b1 && a_width > b_width) || seq == 2'b10) begin				  
			     if (a_width >= width)
				 task_ram_col (webweu_tmp[0], weawel_tmp[0], diadi_tmp[7:0], dipadip_tmp[0], mem[addrawraddr_tmp[14:4]][0 +: 8], memp[addrawraddr_tmp[14:4]][0]);
			     else
				 task_ram_col (webweu_tmp[0], weawel_tmp[0], diadi_tmp[7:0], dipadip_tmp[0], mem[addrawraddr_tmp[14:addrawraddr_bit_16+1]][(addrawraddr_tmp[addrawraddr_bit_16:4] * 16) +: 8], memp[addrawraddr_tmp[14:addrawraddr_bit_16+1]][(addrawraddr_tmp[addrawraddr_bit_16:4] * 2) +: 1]);				     
			     
			     if (seq == 2'b00)
				 chk_for_col_msg (weawel_tmp[0], webweu_tmp[0], addrawraddr_tmp, addrbrdaddr_tmp);

			     if (a_width >= width)
				     task_ram_col (webweu_tmp[1], weawel_tmp[1], diadi_tmp[15:8], dipadip_tmp[1], mem[addrawraddr_tmp[14:4]][8 +: 8], memp[addrawraddr_tmp[14:4]][1]);
			     else
				 task_ram_col (webweu_tmp[1], weawel_tmp[1], diadi_tmp[15:8], dipadip_tmp[1], mem[addrawraddr_tmp[14:addrawraddr_bit_16+1]][((addrawraddr_tmp[addrawraddr_bit_16:4] * 16) + 8) +: 8], memp[addrawraddr_tmp[14:addrawraddr_bit_16+1]][((addrawraddr_tmp[addrawraddr_bit_16:4] * 2) + 1) +: 1]);

			     if (seq == 2'b00)
				 chk_for_col_msg (weawel_tmp[1], webweu_tmp[1], addrawraddr_tmp, addrbrdaddr_tmp);
			     
			 end // if (a_width <= b_width)
		     end // case: 16
		32 : begin
		         if (!(weawel_tmp[0] === 1'b1 && webweu_tmp[0] === 1'b1 && a_width > b_width) || seq == 2'b10) begin				  
			     task_ram_col (webweu_tmp[0], weawel_tmp[0], diadi_tmp[7:0], dipadip_tmp[0], mem[addrawraddr_tmp[14:5]][0 +: 8], memp[addrawraddr_tmp[14:5]][0]);
			     if (seq == 2'b00)
				 chk_for_col_msg (weawel_tmp[0], webweu_tmp[0], addrawraddr_tmp, addrbrdaddr_tmp);
			     
			     task_ram_col (webweu_tmp[1], weawel_tmp[1], diadi_tmp[15:8], dipadip_tmp[1], mem[addrawraddr_tmp[14:5]][8 +: 8], memp[addrawraddr_tmp[14:5]][1]);
			     if (seq == 2'b00)
				 chk_for_col_msg (weawel_tmp[1], webweu_tmp[1], addrawraddr_tmp, addrbrdaddr_tmp);

			     task_ram_col (webweu_tmp[2], weawel_tmp[2], diadi_tmp[23:16], dipadip_tmp[2], mem[addrawraddr_tmp[14:5]][16 +: 8], memp[addrawraddr_tmp[14:5]][2]);
			     if (seq == 2'b00)
				 chk_for_col_msg (weawel_tmp[2], webweu_tmp[2], addrawraddr_tmp, addrbrdaddr_tmp);
			     
			     task_ram_col (webweu_tmp[3], weawel_tmp[3], diadi_tmp[31:24], dipadip_tmp[3], mem[addrawraddr_tmp[14:5]][24 +: 8], memp[addrawraddr_tmp[14:5]][3]);
			     if (seq == 2'b00)
				 chk_for_col_msg (weawel_tmp[3], webweu_tmp[3], addrawraddr_tmp, addrbrdaddr_tmp);
			     
			 end // if (a_width <= b_width)
		     end // case: 32
		
	    endcase // case(a_width)

	end
	
    endtask // task_col_wr_ram_a

    
    task task_col_wr_ram_b;

	input [1:0] seq;
	input [7:0] weawel_tmp;
	input [7:0] webweu_tmp;
	input [63:0] dibdi_tmp;
	input [7:0] dipbdip_tmp;
	input [15:0] addrawraddr_tmp;
	input [15:0] addrbrdaddr_tmp;

	begin

	    case (b_width)

		1, 2, 4 : begin
		              if (!(weawel_tmp[0] === 1'b1 && webweu_tmp[0] === 1'b1 && b_width > a_width) || seq == 2'b10) begin				  
				  if (b_width >= width)
				      task_ram_col (weawel_tmp[0], webweu_tmp[0], dibdi_tmp[b_width-1:0], 1'b0, mem[addrbrdaddr_tmp[14:addrbrdaddr_lbit_124]], tmp1);
				  else
				      task_ram_col (weawel_tmp[0], webweu_tmp[0], dibdi_tmp[b_width-1:0], 1'b0, mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_124+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_124:addrbrdaddr_lbit_124] * b_width) +: b_width], tmp1);				      
				  
				  if (seq == 2'b00)
				      chk_for_col_msg (weawel_tmp[0], webweu_tmp[0], addrawraddr_tmp, addrbrdaddr_tmp);
		    
			      end // if (b_width <= a_width)
		          end // case: 1, 2, 4
		8 : begin
       	                if (!(weawel_tmp[0] === 1'b1 && webweu_tmp[0] === 1'b1 && b_width > a_width) || seq == 2'b10) begin				  
			    if (b_width >= width)
				task_ram_col (weawel_tmp[0], webweu_tmp[0], dibdi_tmp[7:0], dipbdip_tmp[0], mem[addrbrdaddr_tmp[14:3]], memp[addrbrdaddr_tmp[14:3]]);
			    else
				task_ram_col (weawel_tmp[0], webweu_tmp[0], dibdi_tmp[7:0], dipbdip_tmp[0], mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_8+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_8:3] * 8) +: 8], memp[addrbrdaddr_tmp[14:addrbrdaddr_bit_8+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_8:3] * 1) +: 1]);
			    
			    if (seq == 2'b00)
				chk_for_col_msg (weawel_tmp[0], webweu_tmp[0], addrawraddr_tmp, addrbrdaddr_tmp);
				
			end // if (b_width <= a_width)
		     end // case: 8
		16 : begin
	                 if (!(weawel_tmp[0] === 1'b1 && webweu_tmp[0] === 1'b1 && b_width > a_width) || seq == 2'b10) begin				  
			     if (b_width >= width)
				 task_ram_col (weawel_tmp[0], webweu_tmp[0], dibdi_tmp[7:0], dipbdip_tmp[0], mem[addrbrdaddr_tmp[14:4]][0 +: 8], memp[addrbrdaddr_tmp[14:4]][0:0]);
			     else
				 task_ram_col (weawel_tmp[0], webweu_tmp[0], dibdi_tmp[7:0], dipbdip_tmp[0], mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_16+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_16:4] * 16) +: 8], memp[addrbrdaddr_tmp[14:addrbrdaddr_bit_16+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_16:4] * 2) +: 1]);				     
			     
			     if (seq == 2'b00)
				 chk_for_col_msg (weawel_tmp[0], webweu_tmp[0], addrawraddr_tmp, addrbrdaddr_tmp);


			     if (b_width >= width)
				 task_ram_col (weawel_tmp[1], webweu_tmp[1], dibdi_tmp[15:8], dipbdip_tmp[1], mem[addrbrdaddr_tmp[14:4]][8 +: 8], memp[addrbrdaddr_tmp[14:4]][1:1]);
			     else
				 task_ram_col (weawel_tmp[1], webweu_tmp[1], dibdi_tmp[15:8], dipbdip_tmp[1], mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_16+1]][((addrbrdaddr_tmp[addrbrdaddr_bit_16:4] * 16) + 8) +: 8], memp[addrbrdaddr_tmp[14:addrbrdaddr_bit_16+1]][((addrbrdaddr_tmp[addrbrdaddr_bit_16:4] * 2) + 1) +: 1]);
			     
			     if (seq == 2'b00)
				 chk_for_col_msg (weawel_tmp[1], webweu_tmp[1], addrawraddr_tmp, addrbrdaddr_tmp);

			 end // if (!(weawel_tmp[0] === 1'b1 && webweu_tmp[0] === 1'b1 && b_width > a_width) || seq == 2'b10)
		     end // case: 16
		32 : begin
		         if (!(weawel_tmp[0] === 1'b1 && webweu_tmp[0] === 1'b1 && b_width > a_width) || seq == 2'b10) begin				  
			     task_ram_col (weawel_tmp[0], webweu_tmp[0], dibdi_tmp[7:0], dipbdip_tmp[0], mem[addrbrdaddr_tmp[14:5]][0 +: 8], memp[addrbrdaddr_tmp[14:5]][0:0]);
			     if (seq == 2'b00)
				 chk_for_col_msg (weawel_tmp[0], webweu_tmp[0], addrawraddr_tmp, addrbrdaddr_tmp);

			     task_ram_col (weawel_tmp[1], webweu_tmp[1], dibdi_tmp[15:8], dipbdip_tmp[1], mem[addrbrdaddr_tmp[14:5]][8 +: 8], memp[addrbrdaddr_tmp[14:5]][1:1]);
			     if (seq == 2'b00)
				 chk_for_col_msg (weawel_tmp[1], webweu_tmp[1], addrawraddr_tmp, addrbrdaddr_tmp);

			     task_ram_col (weawel_tmp[2], webweu_tmp[2], dibdi_tmp[23:16], dipbdip_tmp[2], mem[addrbrdaddr_tmp[14:5]][16 +: 8], memp[addrbrdaddr_tmp[14:5]][2:2]);
			     if (seq == 2'b00)
				 chk_for_col_msg (weawel_tmp[2], webweu_tmp[2], addrawraddr_tmp, addrbrdaddr_tmp);

			     task_ram_col (weawel_tmp[3], webweu_tmp[3], dibdi_tmp[31:24], dipbdip_tmp[3], mem[addrbrdaddr_tmp[14:5]][24 +: 8], memp[addrbrdaddr_tmp[14:5]][3:3]);
			     if (seq == 2'b00)
				 chk_for_col_msg (weawel_tmp[3], webweu_tmp[3], addrawraddr_tmp, addrbrdaddr_tmp);
			     
			 end // if (b_width <= a_width)
		     end // case: 32
		
	    endcase // case(b_width)

	end
	
    endtask // task_col_wr_ram_b

    
    task task_wr_ram_a;

	input [7:0] weawel_tmp;
	input [63:0] diadi_tmp;
	input [7:0] dipadip_tmp;
	input [15:0] addrawraddr_tmp;

	begin
	    
	    case (a_width)

		1, 2, 4 : begin

		              if (a_width >= width)
				  task_ram (weawel_tmp[0], diadi_tmp[a_width-1:0], 1'b0, mem[addrawraddr_tmp[14:addrawraddr_lbit_124]], tmp1);
			      else
				  task_ram (weawel_tmp[0], diadi_tmp[a_width-1:0], 1'b0, mem[addrawraddr_tmp[14:addrawraddr_bit_124+1]][(addrawraddr_tmp[addrawraddr_bit_124:addrawraddr_lbit_124] * a_width) +: a_width], tmp1);

		          end
		8 : begin

		        if (a_width >= width)
			    task_ram (weawel_tmp[0], diadi_tmp[7:0], dipadip_tmp[0], mem[addrawraddr_tmp[14:3]], memp[addrawraddr_tmp[14:3]]);
			else
			    task_ram (weawel_tmp[0], diadi_tmp[7:0], dipadip_tmp[0], mem[addrawraddr_tmp[14:addrawraddr_bit_8+1]][(addrawraddr_tmp[addrawraddr_bit_8:3] * 8) +: 8], memp[addrawraddr_tmp[14:addrawraddr_bit_8+1]][(addrawraddr_tmp[addrawraddr_bit_8:3] * 1) +: 1]);

		    end
		16 : begin

		         if (a_width >= width) begin
				 task_ram (weawel_tmp[0], diadi_tmp[7:0], dipadip_tmp[0], mem[addrawraddr_tmp[14:4]][0 +: 8], memp[addrawraddr_tmp[14:4]][0:0]);
				 task_ram (weawel_tmp[1], diadi_tmp[15:8], dipadip_tmp[1], mem[addrawraddr_tmp[14:4]][8 +: 8], memp[addrawraddr_tmp[14:4]][1:1]);
			 end 
			 else begin
				 task_ram (weawel_tmp[0], diadi_tmp[7:0], dipadip_tmp[0], mem[addrawraddr_tmp[14:addrawraddr_bit_16+1]][(addrawraddr_tmp[addrawraddr_bit_16:4] * 16) +: 8], memp[addrawraddr_tmp[14:addrawraddr_bit_16+1]][(addrawraddr_tmp[addrawraddr_bit_16:4] * 2) +: 1]);
				 task_ram (weawel_tmp[1], diadi_tmp[15:8], dipadip_tmp[1], mem[addrawraddr_tmp[14:addrawraddr_bit_16+1]][((addrawraddr_tmp[addrawraddr_bit_16:4] * 16) + 8) +: 8], memp[addrawraddr_tmp[14:addrawraddr_bit_16+1]][((addrawraddr_tmp[addrawraddr_bit_16:4] * 2) + 1) +: 1]);
			 end // else: !if(a_width >= b_width)

		    end // case: 16
		32 : begin

		         task_ram (weawel_tmp[0], diadi_tmp[7:0], dipadip_tmp[0], mem[addrawraddr_tmp[14:5]][0 +: 8], memp[addrawraddr_tmp[14:5]][0:0]);
		         task_ram (weawel_tmp[1], diadi_tmp[15:8], dipadip_tmp[1], mem[addrawraddr_tmp[14:5]][8 +: 8], memp[addrawraddr_tmp[14:5]][1:1]);
		         task_ram (weawel_tmp[2], diadi_tmp[23:16], dipadip_tmp[2], mem[addrawraddr_tmp[14:5]][16 +: 8], memp[addrawraddr_tmp[14:5]][2:2]);
		         task_ram (weawel_tmp[3], diadi_tmp[31:24], dipadip_tmp[3], mem[addrawraddr_tmp[14:5]][24 +: 8], memp[addrawraddr_tmp[14:5]][3:3]);
		    
		     end // case: 32
	    endcase // case(a_width)
	end
	
    endtask // task_wr_ram_a
    
    
    task task_wr_ram_b;

	input [7:0] webweu_tmp;
	input [63:0] dibdi_tmp;
	input [7:0] dipbdip_tmp;
	input [15:0] addrbrdaddr_tmp;

	begin
	    
	    case (b_width)

		1, 2, 4 : begin

		              if (b_width >= width)
				  task_ram (webweu_tmp[0], dibdi_tmp[b_width-1:0], 1'b0, mem[addrbrdaddr_tmp[14:addrbrdaddr_lbit_124]], tmp1);
			      else
				  task_ram (webweu_tmp[0], dibdi_tmp[b_width-1:0], 1'b0, mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_124+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_124:addrbrdaddr_lbit_124] * b_width) +: b_width], tmp1);
		          end
		8 : begin

		        if (b_width >= width)
			    task_ram (webweu_tmp[0], dibdi_tmp[7:0], dipbdip_tmp[0], mem[addrbrdaddr_tmp[14:3]], memp[addrbrdaddr_tmp[14:3]]);
			else
			    task_ram (webweu_tmp[0], dibdi_tmp[7:0], dipbdip_tmp[0], mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_8+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_8:3] * 8) +: 8], memp[addrbrdaddr_tmp[14:addrbrdaddr_bit_8+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_8:3] * 1) +: 1]);

		    end
		16 : begin

		         if (b_width >= width) begin
			     task_ram (webweu_tmp[0], dibdi_tmp[7:0], dipbdip_tmp[0], mem[addrbrdaddr_tmp[14:4]][0 +: 8], memp[addrbrdaddr_tmp[14:4]][0:0]);
			     task_ram (webweu_tmp[1], dibdi_tmp[15:8], dipbdip_tmp[1], mem[addrbrdaddr_tmp[14:4]][8 +: 8], memp[addrbrdaddr_tmp[14:4]][1:1]);
			 end 
			 else begin
			     task_ram (webweu_tmp[0], dibdi_tmp[7:0], dipbdip_tmp[0], mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_16+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_16:4] * 16) +: 8], memp[addrbrdaddr_tmp[14:addrbrdaddr_bit_16+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_16:4] * 2) +: 1]);
			     task_ram (webweu_tmp[1], dibdi_tmp[15:8], dipbdip_tmp[1], mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_16+1]][((addrbrdaddr_tmp[addrbrdaddr_bit_16:4] * 16) + 8) +: 8], memp[addrbrdaddr_tmp[14:addrbrdaddr_bit_16+1]][((addrbrdaddr_tmp[addrbrdaddr_bit_16:4] * 2) + 1) +: 1]);
			 end

 		     end // case: 16
		32 : begin

		         task_ram (webweu_tmp[0], dibdi_tmp[7:0], dipbdip_tmp[0], mem[addrbrdaddr_tmp[14:5]][0 +: 8], memp[addrbrdaddr_tmp[14:5]][0:0]);
		         task_ram (webweu_tmp[1], dibdi_tmp[15:8], dipbdip_tmp[1], mem[addrbrdaddr_tmp[14:5]][8 +: 8], memp[addrbrdaddr_tmp[14:5]][1:1]);
		         task_ram (webweu_tmp[2], dibdi_tmp[23:16], dipbdip_tmp[2], mem[addrbrdaddr_tmp[14:5]][16 +: 8], memp[addrbrdaddr_tmp[14:5]][2:2]);
		         task_ram (webweu_tmp[3], dibdi_tmp[31:24], dipbdip_tmp[3], mem[addrbrdaddr_tmp[14:5]][24 +: 8], memp[addrbrdaddr_tmp[14:5]][3:3]);
		    
		     end // case: 32
	    endcase // case(b_width)
	end
	
    endtask // task_wr_ram_b

    
    task task_col_rd_ram_a;

	input [1:0] seq;   // 1 is bypass
	input [7:0] webweu_tmp;
	input [7:0] weawel_tmp;
	input [15:0] addrawraddr_tmp;
	inout [63:0] doado_tmp;
	inout [7:0] dopadop_tmp;
	reg [63:0] doado_ltmp;
	reg [7:0] dopadop_ltmp;
	
	begin

	    doado_ltmp= 64'b0;
	    dopadop_ltmp= 8'b0;
	    
	    case (a_width)
		1, 2, 4 : begin

		              if ((webweu_tmp[0] === 1'b1 && weawel_tmp[0] === 1'b1) || (seq == 2'b01 && webweu_tmp[0] === 1'b1 && weawel_tmp[0] === 1'b0 && viol_type == 2'b10) || (seq == 2'b01 && wr_mode_a != 2'b01 && wr_mode_b != 2'b01) || (seq == 2'b01 && wr_mode_a == 2'b01 && wr_mode_b != 2'b01 && webweu_tmp[0] === 1'b1) || (seq == 2'b11 && wr_mode_a == 2'b00 && webweu_tmp[0] !== 1'b1)) begin
				  if (a_width >= width)
				      doado_ltmp = mem[addrawraddr_tmp[14:addrawraddr_lbit_124]];
				  else
				      doado_ltmp = mem[addrawraddr_tmp[14:addrawraddr_bit_124+1]][(addrawraddr_tmp[addrawraddr_bit_124:addrawraddr_lbit_124] * a_width) +: a_width];
				  task_x_buf (wr_mode_a, 3, 0, 0, doado_ltmp, doado_tmp, dopadop_ltmp, dopadop_tmp);			  
			      end
 		          end // case: 1, 2, 4
		8 : begin

		        if ((webweu_tmp[0] === 1'b1 && weawel_tmp[0] === 1'b1) || (seq == 2'b01 && webweu_tmp[0] === 1'b1 && weawel_tmp[0] === 1'b0 && viol_type == 2'b10) || (seq == 2'b01 && wr_mode_a != 2'b01 && wr_mode_b != 2'b01) || (seq == 2'b01 && wr_mode_a == 2'b01 && wr_mode_b != 2'b01 && webweu_tmp[0] === 1'b1) || (seq == 2'b11 && wr_mode_a == 2'b00 && webweu_tmp[0] !== 1'b1)) begin
		            if (a_width >= width) begin
				doado_ltmp = mem[addrawraddr_tmp[14:3]];
				dopadop_ltmp =  memp[addrawraddr_tmp[14:3]];
			    end
			    else begin
				doado_ltmp = mem[addrawraddr_tmp[14:addrawraddr_bit_8+1]][(addrawraddr_tmp[addrawraddr_bit_8:3] * 8) +: 8];
				dopadop_ltmp = memp[addrawraddr_tmp[14:addrawraddr_bit_8+1]][(addrawraddr_tmp[addrawraddr_bit_8:3] * 1) +: 1];
			    end
			    
			    task_x_buf (wr_mode_a, 7, 0, 0, doado_ltmp, doado_tmp, dopadop_ltmp, dopadop_tmp);			  

			end
		     end // case: 8
		16 : begin

		         if ((webweu_tmp[0] === 1'b1 && weawel_tmp[0] === 1'b1) || (seq == 2'b01 && webweu_tmp[0] === 1'b1 && weawel_tmp[0] === 1'b0 && viol_type == 2'b10) || (seq == 2'b01 && wr_mode_a != 2'b01 && wr_mode_b != 2'b01) || (seq == 2'b01 && wr_mode_a == 2'b01 && wr_mode_b != 2'b01 && webweu_tmp[0] === 1'b1) || (seq == 2'b11 && wr_mode_a == 2'b00 && webweu_tmp[0] !== 1'b1)) begin
		             if (a_width >= width) begin
				 doado_ltmp[7:0] = mem[addrawraddr_tmp[14:4]][7:0];
				 dopadop_ltmp[0:0] = memp[addrawraddr_tmp[14:4]][0:0];
			     end
			     else begin
				 doado_ltmp[7:0] = mem[addrawraddr_tmp[14:addrawraddr_bit_16+1]][(addrawraddr_tmp[addrawraddr_bit_16:4] * 16) +: 8];
				 dopadop_ltmp[0:0] = memp[addrawraddr_tmp[14:addrawraddr_bit_16+1]][(addrawraddr_tmp[addrawraddr_bit_16:4] * 2) +: 1];
			     end
			     task_x_buf (wr_mode_a, 7, 0, 0, doado_ltmp, doado_tmp, dopadop_ltmp, dopadop_tmp);
			 end

		         if ((webweu_tmp[1] === 1'b1 && weawel_tmp[1] === 1'b1) || (seq == 2'b01 && webweu_tmp[1] === 1'b1 && weawel_tmp[1] === 1'b0 && viol_type == 2'b10) || (seq == 2'b01 && wr_mode_a != 2'b01 && wr_mode_b != 2'b01) || (seq == 2'b01 && wr_mode_a == 2'b01 && wr_mode_b != 2'b01 && webweu_tmp[1] === 1'b1) || (seq == 2'b11 && wr_mode_a == 2'b00 && webweu_tmp[1] !== 1'b1)) begin
			     if (a_width >= width) begin
				 doado_ltmp[15:8] = mem[addrawraddr_tmp[14:4]][15:8];
				 dopadop_ltmp[1:1] = memp[addrawraddr_tmp[14:4]][1:1];
			     end 
			     else begin
				 doado_ltmp[15:8] = mem[addrawraddr_tmp[14:addrawraddr_bit_16+1]][((addrawraddr_tmp[addrawraddr_bit_16:4] * 16) + 8) +: 8];
				 dopadop_ltmp[1:1] = memp[addrawraddr_tmp[14:addrawraddr_bit_16+1]][((addrawraddr_tmp[addrawraddr_bit_16:4] * 2) + 1) +: 1];
			     end
			     task_x_buf (wr_mode_a, 15, 8, 1, doado_ltmp, doado_tmp, dopadop_ltmp, dopadop_tmp);
			 end
		    
		     end
		32 : begin
		         if (a_width >= width) begin

			     if ((webweu_tmp[0] === 1'b1 && weawel_tmp[0] === 1'b1) || (seq == 2'b01 && webweu_tmp[0] === 1'b1 && weawel_tmp[0] === 1'b0 && viol_type == 2'b10) || (seq == 2'b01 && wr_mode_a != 2'b01 && wr_mode_b != 2'b01) || (seq == 2'b01 && wr_mode_a == 2'b01 && wr_mode_b != 2'b01 && webweu_tmp[0] === 1'b1) || (seq == 2'b11 && wr_mode_a == 2'b00 && webweu_tmp[0] !== 1'b1)) begin
				 doado_ltmp[7:0] = mem[addrawraddr_tmp[14:5]][7:0];
				 dopadop_ltmp[0:0] = memp[addrawraddr_tmp[14:5]][0:0];
				 task_x_buf (wr_mode_a, 7, 0, 0, doado_ltmp, doado_tmp, dopadop_ltmp, dopadop_tmp);
			     end

			     if ((webweu_tmp[1] === 1'b1 && weawel_tmp[1] === 1'b1) || (seq == 2'b01 && webweu_tmp[1] === 1'b1 && weawel_tmp[1] === 1'b0 && viol_type == 2'b10) || (seq == 2'b01 && wr_mode_a != 2'b01 && wr_mode_b != 2'b01) || (seq == 2'b01 && wr_mode_a == 2'b01 && wr_mode_b != 2'b01 && webweu_tmp[1] === 1'b1) || (seq == 2'b11 && wr_mode_a == 2'b00 && webweu_tmp[1] !== 1'b1)) begin
				 doado_ltmp[15:8] = mem[addrawraddr_tmp[14:5]][15:8];
				 dopadop_ltmp[1:1] = memp[addrawraddr_tmp[14:5]][1:1];
				 task_x_buf (wr_mode_a, 15, 8, 1, doado_ltmp, doado_tmp, dopadop_ltmp, dopadop_tmp);
			     end

			     if ((webweu_tmp[2] === 1'b1 && weawel_tmp[2] === 1'b1) || (seq == 2'b01 && webweu_tmp[2] === 1'b1 && weawel_tmp[2] === 1'b0 && viol_type == 2'b10) || (seq == 2'b01 && wr_mode_a != 2'b01 && wr_mode_b != 2'b01) || (seq == 2'b01 && wr_mode_a == 2'b01 && wr_mode_b != 2'b01 && webweu_tmp[2] === 1'b1) || (seq == 2'b11 && wr_mode_a == 2'b00 && webweu_tmp[2] !== 1'b1)) begin
				 doado_ltmp[23:16] = mem[addrawraddr_tmp[14:5]][23:16];
				 dopadop_ltmp[2:2] = memp[addrawraddr_tmp[14:5]][2:2];
				 task_x_buf (wr_mode_a, 23, 16, 2, doado_ltmp, doado_tmp, dopadop_ltmp, dopadop_tmp);
			     end

			     if ((webweu_tmp[3] === 1'b1 && weawel_tmp[3] === 1'b1) || (seq == 2'b01 && webweu_tmp[3] === 1'b1 && weawel_tmp[3] === 1'b0 && viol_type == 2'b10) || (seq == 2'b01 && wr_mode_a != 2'b01 && wr_mode_b != 2'b01) || (seq == 2'b01 && wr_mode_a == 2'b01 && wr_mode_b != 2'b01 && webweu_tmp[3] === 1'b1) || (seq == 2'b11 && wr_mode_a == 2'b00 && webweu_tmp[3] !== 1'b1)) begin
				 doado_ltmp[31:24] = mem[addrawraddr_tmp[14:5]][31:24];
				 dopadop_ltmp[3:3] = memp[addrawraddr_tmp[14:5]][3:3];
				 task_x_buf (wr_mode_a, 31, 24, 3, doado_ltmp, doado_tmp, dopadop_ltmp, dopadop_tmp);
			     end

			 end // if (a_width >= width)
		     end

	    endcase // case(a_width)
	end
    endtask // task_col_rd_ram_a


    task task_col_rd_ram_b;

	input [1:0] seq;   // 1 is bypass
	input [7:0] weawel_tmp;
	input [7:0] webweu_tmp;
	input [15:0] addrbrdaddr_tmp;
	inout [63:0] dobdo_tmp;
	inout [7:0] dopbdop_tmp;
	reg [63:0] dobdo_ltmp;
	reg [7:0] dopbdop_ltmp;
	
	begin

	    dobdo_ltmp= 64'b0;
	    dopbdop_ltmp= 8'b0;
	    
	    case (b_width)
		1, 2, 4 : begin

		              if ((webweu_tmp[0] === 1'b1 && weawel_tmp[0] === 1'b1) || (seq == 2'b01 && weawel_tmp[0] === 1'b1 && webweu_tmp[0] === 1'b0 && viol_type == 2'b11) || (seq == 2'b01 && wr_mode_b != 2'b01 && wr_mode_a != 2'b01) || (seq == 2'b01 && wr_mode_b == 2'b01 && wr_mode_a != 2'b01 && weawel_tmp[0] === 1'b1) || (seq == 2'b11 && wr_mode_b == 2'b00 && weawel_tmp[0] !== 1'b1)) begin
				  if (b_width >= width)
				      dobdo_ltmp = mem[addrbrdaddr_tmp[14:addrbrdaddr_lbit_124]];
				  else
				      dobdo_ltmp = mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_124+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_124:addrbrdaddr_lbit_124] * b_width) +: b_width];

				  task_x_buf (wr_mode_b, 3, 0, 0, dobdo_ltmp, dobdo_tmp, dopbdop_ltmp, dopbdop_tmp);

			      end
		          end // case: 1, 2, 4
		8 : begin

		        if ((webweu_tmp[0] === 1'b1 && weawel_tmp[0] === 1'b1) || (seq == 2'b01 && weawel_tmp[0] === 1'b1 && webweu_tmp[0] === 1'b0 && viol_type == 2'b11) || (seq == 2'b01 && wr_mode_b != 2'b01 && wr_mode_a != 2'b01) || (seq == 2'b01 && wr_mode_b == 2'b01 && wr_mode_a != 2'b01 && weawel_tmp[0] === 1'b1) || (seq == 2'b11 && wr_mode_b == 2'b00 && weawel_tmp[0] !== 1'b1)) begin
		    
		            if (b_width >= width) begin
				dobdo_ltmp = mem[addrbrdaddr_tmp[14:3]];
				dopbdop_ltmp =  memp[addrbrdaddr_tmp[14:3]];
			    end
			    else begin
				dobdo_ltmp = mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_8+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_8:3] * 8) +: 8];
				dopbdop_ltmp = memp[addrbrdaddr_tmp[14:addrbrdaddr_bit_8+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_8:3] * 1) +: 1];
			    end
			    
			    task_x_buf (wr_mode_b, 7, 0, 0, dobdo_ltmp, dobdo_tmp, dopbdop_ltmp, dopbdop_tmp);

			end
		     end // case: 8
		16 : begin
		    
		         if ((webweu_tmp[0] === 1'b1 && weawel_tmp[0] === 1'b1) || (seq == 2'b01 && weawel_tmp[0] === 1'b1 && webweu_tmp[0] === 1'b0 && viol_type == 2'b11) || (seq == 2'b01 && wr_mode_b != 2'b01 && wr_mode_a != 2'b01) || (seq == 2'b01 && wr_mode_b == 2'b01 && wr_mode_a != 2'b01 && weawel_tmp[0] === 1'b1) || (seq == 2'b11 && wr_mode_b == 2'b00 && weawel_tmp[0] !== 1'b1)) begin
		             if (b_width >= width) begin
				 dobdo_ltmp[7:0] = mem[addrbrdaddr_tmp[14:4]][7:0];
				 dopbdop_ltmp[0:0] = memp[addrbrdaddr_tmp[14:4]][0:0];
			     end
			     else begin
				 dobdo_ltmp[7:0] = mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_16+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_16:4] * 16) +: 8];
				 dopbdop_ltmp[0:0] = memp[addrbrdaddr_tmp[14:addrbrdaddr_bit_16+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_16:4] * 2) +: 1];
			     end
			     task_x_buf (wr_mode_b, 7, 0, 0, dobdo_ltmp, dobdo_tmp, dopbdop_ltmp, dopbdop_tmp);
			 end
		    

		         if ((webweu_tmp[1] === 1'b1 && weawel_tmp[1] === 1'b1) || (seq == 2'b01 && weawel_tmp[1] === 1'b1 && webweu_tmp[1] === 1'b0 && viol_type == 2'b11) || (seq == 2'b01 && wr_mode_b != 2'b01 && wr_mode_a != 2'b01) || (seq == 2'b01 && wr_mode_b == 2'b01 && wr_mode_a != 2'b01 && weawel_tmp[1] === 1'b1) || (seq == 2'b11 && wr_mode_b == 2'b00 && weawel_tmp[1] !== 1'b1)) begin	    

		             if (b_width >= width) begin
				 dobdo_ltmp[15:8] = mem[addrbrdaddr_tmp[14:4]][15:8];
				 dopbdop_ltmp[1:1] = memp[addrbrdaddr_tmp[14:4]][1:1];
			     end 
			     else begin
				 dobdo_ltmp[15:8] = mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_16+1]][((addrbrdaddr_tmp[addrbrdaddr_bit_16:4] * 16) + 8) +: 8];
				 dopbdop_ltmp[1:1] = memp[addrbrdaddr_tmp[14:addrbrdaddr_bit_16+1]][((addrbrdaddr_tmp[addrbrdaddr_bit_16:4] * 2) + 1) +: 1];
			     end
			     task_x_buf (wr_mode_b, 15, 8, 1, dobdo_ltmp, dobdo_tmp, dopbdop_ltmp, dopbdop_tmp);
			 end

		     end
		32 : begin
		         if (b_width >= width) begin
			     
		             if ((webweu_tmp[0] === 1'b1 && weawel_tmp[0] === 1'b1) || (seq == 2'b01 && weawel_tmp[0] === 1'b1 && webweu_tmp[0] === 1'b0 && viol_type == 2'b11) || (seq == 2'b01 && wr_mode_b != 2'b01 && wr_mode_a != 2'b01) || (seq == 2'b01 && wr_mode_b == 2'b01 && wr_mode_a != 2'b01 && weawel_tmp[0] === 1'b1) || (seq == 2'b11 && wr_mode_b == 2'b00 && weawel_tmp[0] !== 1'b1)) begin
				 dobdo_ltmp[7:0] = mem[addrbrdaddr_tmp[14:5]][7:0];
				 dopbdop_ltmp[0:0] = memp[addrbrdaddr_tmp[14:5]][0:0];
				 task_x_buf (wr_mode_b, 7, 0, 0, dobdo_ltmp, dobdo_tmp, dopbdop_ltmp, dopbdop_tmp);
			     end
			     
			     if ((webweu_tmp[1] === 1'b1 && weawel_tmp[1] === 1'b1) || (seq == 2'b01 && weawel_tmp[1] === 1'b1 && webweu_tmp[1] === 1'b0 && viol_type == 2'b11) || (seq == 2'b01 && wr_mode_b != 2'b01 && wr_mode_a != 2'b01) || (seq == 2'b01 && wr_mode_b == 2'b01 && wr_mode_a != 2'b01 && weawel_tmp[1] === 1'b1) || (seq == 2'b11 && wr_mode_b == 2'b00 && weawel_tmp[1] !== 1'b1)) begin		    
				 dobdo_ltmp[15:8] = mem[addrbrdaddr_tmp[14:5]][15:8];
				 dopbdop_ltmp[1:1] = memp[addrbrdaddr_tmp[14:5]][1:1];
				 task_x_buf (wr_mode_b, 15, 8, 1, dobdo_ltmp, dobdo_tmp, dopbdop_ltmp, dopbdop_tmp);
			     end

			     if ((webweu_tmp[2] === 1'b1 && weawel_tmp[2] === 1'b1) || (seq == 2'b01 && weawel_tmp[2] === 1'b1 && webweu_tmp[2] === 1'b0 && viol_type == 2'b11) || (seq == 2'b01 && wr_mode_b != 2'b01 && wr_mode_a != 2'b01) || (seq == 2'b01 && wr_mode_b == 2'b01 && wr_mode_a != 2'b01 && weawel_tmp[2] === 1'b1) || (seq == 2'b11 && wr_mode_b == 2'b00 && weawel_tmp[2] !== 1'b1)) begin		    
				 dobdo_ltmp[23:16] = mem[addrbrdaddr_tmp[14:5]][23:16];
				 dopbdop_ltmp[2:2] = memp[addrbrdaddr_tmp[14:5]][2:2];
				 task_x_buf (wr_mode_b, 23, 16, 2, dobdo_ltmp, dobdo_tmp, dopbdop_ltmp, dopbdop_tmp);
			     end

			     if ((webweu_tmp[3] === 1'b1 && weawel_tmp[3] === 1'b1) || (seq == 2'b01 && weawel_tmp[3] === 1'b1 && webweu_tmp[3] === 1'b0 && viol_type == 2'b11) || (seq == 2'b01 && wr_mode_b != 2'b01 && wr_mode_a != 2'b01) || (seq == 2'b01 && wr_mode_b == 2'b01 && wr_mode_a != 2'b01 && weawel_tmp[3] === 1'b1) || (seq == 2'b11 && wr_mode_b == 2'b00 && weawel_tmp[3] !== 1'b1)) begin		    
				 dobdo_ltmp[31:24] = mem[addrbrdaddr_tmp[14:5]][31:24];
				 dopbdop_ltmp[3:3] = memp[addrbrdaddr_tmp[14:5]][3:3];
				 task_x_buf (wr_mode_b, 31, 24, 3, dobdo_ltmp, dobdo_tmp, dopbdop_ltmp, dopbdop_tmp);
			     end

			 end // if (b_width >= width)
		     end

	    endcase // case(b_width)
	end
    endtask // task_col_rd_ram_b

    
    task task_rd_ram_a;

	input [15:0] addrawraddr_tmp;
	inout [63:0] doado_tmp;
	inout [7:0] dopadop_tmp;

	begin

	    case (a_width)
		1, 2, 4 : begin
		              if (a_width >= width)
				  doado_tmp = mem[addrawraddr_tmp[14:addrawraddr_lbit_124]];

			      else
				  doado_tmp = mem[addrawraddr_tmp[14:addrawraddr_bit_124+1]][(addrawraddr_tmp[addrawraddr_bit_124:addrawraddr_lbit_124] * a_width) +: a_width];
		          end
		8 : begin
		        if (a_width >= width) begin
			    doado_tmp = mem[addrawraddr_tmp[14:3]];
			    dopadop_tmp =  memp[addrawraddr_tmp[14:3]];
			end
			else begin
			    doado_tmp = mem[addrawraddr_tmp[14:addrawraddr_bit_8+1]][(addrawraddr_tmp[addrawraddr_bit_8:3] * 8) +: 8];
			    dopadop_tmp = memp[addrawraddr_tmp[14:addrawraddr_bit_8+1]][(addrawraddr_tmp[addrawraddr_bit_8:3] * 1) +: 1];
			end
		    end
		16 : begin
		         if (a_width >= width) begin
			     doado_tmp = mem[addrawraddr_tmp[14:4]];
			     dopadop_tmp = memp[addrawraddr_tmp[14:4]];
			 end 
			 else begin
			     doado_tmp = mem[addrawraddr_tmp[14:addrawraddr_bit_16+1]][(addrawraddr_tmp[addrawraddr_bit_16:4] * 16) +: 16];
			     dopadop_tmp = memp[addrawraddr_tmp[14:addrawraddr_bit_16+1]][(addrawraddr_tmp[addrawraddr_bit_16:4] * 2) +: 2];
			 end
		     end
		32 : begin
		         if (a_width >= width) begin
			     doado_tmp = mem[addrawraddr_tmp[14:5]];
			     dopadop_tmp = memp[addrawraddr_tmp[14:5]];
			 end 
		     end

	    endcase // case(a_width)

	end
    endtask // task_rd_ram_a
    

    task task_rd_ram_b;

	input [15:0] addrbrdaddr_tmp;
	inout [31:0] dobdo_tmp;
	inout [3:0] dopbdop_tmp;

	begin
	    
	    case (b_width)
		1, 2, 4 : begin
		              if (b_width >= width)
				  dobdo_tmp = mem[addrbrdaddr_tmp[14:addrbrdaddr_lbit_124]];
			      else
				  dobdo_tmp = mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_124+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_124:addrbrdaddr_lbit_124] * b_width) +: b_width];
               	          end
		8 : begin
		        if (b_width >= width) begin
			    dobdo_tmp = mem[addrbrdaddr_tmp[14:3]];
			    dopbdop_tmp =  memp[addrbrdaddr_tmp[14:3]];
			end
			else begin
			    dobdo_tmp = mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_8+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_8:3] * 8) +: 8];
			    dopbdop_tmp = memp[addrbrdaddr_tmp[14:addrbrdaddr_bit_8+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_8:3] * 1) +: 1];
			end
		    end
		16 : begin
		         if (b_width >= width) begin
			     dobdo_tmp = mem[addrbrdaddr_tmp[14:4]];
			     dopbdop_tmp = memp[addrbrdaddr_tmp[14:4]];
			 end 
			 else begin
			     dobdo_tmp = mem[addrbrdaddr_tmp[14:addrbrdaddr_bit_16+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_16:4] * 16) +: 16];
			     dopbdop_tmp = memp[addrbrdaddr_tmp[14:addrbrdaddr_bit_16+1]][(addrbrdaddr_tmp[addrbrdaddr_bit_16:4] * 2) +: 2];
			 end
		      end
		32 : begin
		         dobdo_tmp = mem[addrbrdaddr_tmp[14:5]];
		         dopbdop_tmp = memp[addrbrdaddr_tmp[14:5]];
		     end
		
	    endcase
	end
    endtask // task_rd_ram_b    


    task chk_for_col_msg;

	input weawel_tmp;
	input webweu_tmp;
	input [15:0] addrawraddr_tmp;
	input [15:0] addrbrdaddr_tmp;
	
	begin

	    if ((SIM_COLLISION_CHECK == "ALL" || SIM_COLLISION_CHECK == "WARNING_ONLY") && !(((wr_mode_b == 2'b01 && webweu_tmp === 1'b1 && weawel_tmp === 1'b0) && viol_time == 1) || ((wr_mode_a == 2'b01 && weawel_tmp === 1'b1 && webweu_tmp === 1'b0) && viol_time == 1)))
		
		if (weawel_tmp === 1'b1 && webweu_tmp === 1'b1 && col_wr_wr_msg == 1) begin
		    $display("Memory Collision Error on X_RAMB16BWER : %m at simulation time %.3f ns.\nA write was requested to the same address simultaneously at both port A and port B of the RAM. The contents written to the RAM at address location %h (hex) of port A and address location %h (hex) of port B are unknown.", $time/1000.0, addrawraddr_tmp, addrbrdaddr_tmp);
		    col_wr_wr_msg = 0;
		end
	    
		else if (weawel_tmp === 1'b1 && webweu_tmp === 1'b0 && col_wra_rdb_msg == 1) begin

		    if ((wr_mode_a == 2'b01 || wr_mode_b == 2'b01) && viol_time == 2 && SIM_DEVICE == "SPARTAN6")
			$display("Memory Collision Error on X_RAMB16BWER : %m at simulation time %.3f ns.\nA read was performed on address %h (hex) of port B while a write was requested to the same address on port A. The write will be unsuccessful and the content of the RAM at address location %h (hex) of port A became unknown.", $time/1000.0, addrbrdaddr_tmp, addrawraddr_tmp);
		    else
			$display("Memory Collision Error on X_RAMB16BWER : %m at simulation time %.3f ns.\nA read was performed on address %h (hex) of port B while a write was requested to the same address on port A. The write will be successful however the read value on port B is unknown until the next CLKBRDCLK cycle.", $time/1000.0, addrbrdaddr_tmp);
		    col_wra_rdb_msg = 0;
		end
	    
		else if (weawel_tmp === 1'b0 && webweu_tmp === 1'b1 && col_wrb_rda_msg == 1) begin

		    if ((wr_mode_a == 2'b01 || wr_mode_b == 2'b01) && viol_time == 2 && SIM_DEVICE == "SPARTAN6")
			$display("Memory Collision Error on X_RAMB16BWER : %m at simulation time %.3f ns.\nA read was performed on address %h (hex) of port A while a write was requested to the same address on port B. The write will be unsuccessful and the content of the RAM at address location %h (hex) of port B became unknown.", $time/1000.0, addrawraddr_tmp, addrbrdaddr_tmp);
		    else
		    	$display("Memory Collision Error on X_RAMB16BWER : %m at simulation time %.3f ns.\nA read was performed on address %h (hex) of port A while a write was requested to the same address on port B. The write will be successful however the read value on port A is unknown until the next CLKAWRCLK cycle.", $time/1000.0, addrawraddr_tmp);
		    col_wrb_rda_msg = 0;
		end
	    
	end

    endtask // chk_for_col_msg   

    
//*** Timing Checks Start here
    
    wire dia0_enable = enawren_in && weawel_int[0];
    wire dia1_enable = enawren_in && weawel_int[1];
    wire dia2_enable = enawren_in && weawel_int[2];
    wire dia3_enable = enawren_in && weawel_int[3];
    wire dib0_enable = enbrden_in && webweu_int[0];
    wire dib1_enable = enbrden_in && webweu_int[1];
    wire dib2_enable = enbrden_in && webweu_int[2];
    wire dib3_enable = enbrden_in && webweu_int[3];
    
    always @(notifier or notifier_a or notifier_addra0 or notifier_addra1 or notifier_addra2 or notifier_addra3 or notifier_addra4 or
             notifier_addra5 or notifier_addra6 or notifier_addra7 or notifier_addra8 or notifier_addra9 or notifier_addra10 or 
             notifier_addra11 or notifier_addra12 or notifier_addra13) begin    
	doado_out_out <= 32'hxxxxxxxx;
	dopadop_out_out <= 4'hx;
    end

    always @(notifier or notifier_b or notifier_addrb0 or notifier_addrb1 or notifier_addrb2 or notifier_addrb3 or notifier_addrb4 or
             notifier_addrb5 or notifier_addrb6 or notifier_addrb7 or notifier_addrb8 or notifier_addrb9 or notifier_addrb10 or 
             notifier_addrb11 or notifier_addrb12 or notifier_addrb13) begin
	dobdo_out_out <= 32'hxxxxxxxx;
	dopbdop_out_out <= 4'hx;
    end


    always @(notifier_addra0) begin
	task_warn_msg ("ADDRA[0]", "CLKA");
    end

    always @(notifier_addra1) begin
	task_warn_msg ("ADDRA[1]", "CLKA");
    end
    
    always @(notifier_addra2) begin
	task_warn_msg ("ADDRA[2]", "CLKA");
    end
    
    always @(notifier_addra3) begin
	task_warn_msg ("ADDRA[3]", "CLKA");
    end
    
    always @(notifier_addra4) begin
	task_warn_msg ("ADDRA[4]", "CLKA");
    end

    always @(notifier_addra5) begin
	task_warn_msg ("ADDRA[5]", "CLKA");
    end
    
    always @(notifier_addra6) begin
	task_warn_msg ("ADDRA[6]", "CLKA");
    end
    
    always @(notifier_addra7) begin
	task_warn_msg ("ADDRA[7]", "CLKA");
    end   

    always @(notifier_addra8) begin
	task_warn_msg ("ADDRA[8]", "CLKA");
    end

    always @(notifier_addra9) begin
	task_warn_msg ("ADDRA[9]", "CLKA");
    end
    
    always @(notifier_addra10) begin
	task_warn_msg ("ADDRA[10]", "CLKA");
    end
    
    always @(notifier_addra11) begin
	task_warn_msg ("ADDRA[11]", "CLKA");
    end
    
    always @(notifier_addra12) begin
	task_warn_msg ("ADDRA[12]", "CLKA");
    end

    always @(notifier_addra13) begin
	task_warn_msg ("ADDRA[13]", "CLKA");
    end

    
    always @(notifier_addrb0) begin
	task_warn_msg ("ADDRB[0]", "CLKB");
    end

    always @(notifier_addrb1) begin
	task_warn_msg ("ADDRB[1]", "CLKB");
    end
    
    always @(notifier_addrb2) begin
	task_warn_msg ("ADDRB[2]", "CLKB");
    end
    
    always @(notifier_addrb3) begin
	task_warn_msg ("ADDRB[3]", "CLKB");
    end
    
    always @(notifier_addrb4) begin
	task_warn_msg ("ADDRB[4]", "CLKB");
    end

    always @(notifier_addrb5) begin
	task_warn_msg ("ADDRB[5]", "CLKB");
    end
    
    always @(notifier_addrb6) begin
	task_warn_msg ("ADDRB[6]", "CLKB");
    end
    
    always @(notifier_addrb7) begin
	task_warn_msg ("ADDRB[7]", "CLKB");
    end   

    always @(notifier_addrb8) begin
	task_warn_msg ("ADDRB[8]", "CLKB");
    end

    always @(notifier_addrb9) begin
	task_warn_msg ("ADDRB[9]", "CLKB");
    end
    
    always @(notifier_addrb10) begin
	task_warn_msg ("ADDRB[10]", "CLKB");
    end
    
    always @(notifier_addrb11) begin
	task_warn_msg ("ADDRB[11]", "CLKB");
    end
    
    always @(notifier_addrb12) begin
	task_warn_msg ("ADDRB[12]", "CLKB");
    end
    
    always @(notifier_addrb13) begin
	task_warn_msg ("ADDRB[13]", "CLKB");
    end
    
    
    task task_warn_msg;

        input [8*9:1] addr_str;
	input [8*4:1] clk_str;
	
	begin

	    $display("Error: Setup/Hold Violation on %s with respect to %s when memory has been enabled. The memory contents at %s of the RAM can be corrupted. This corruption is not modeled in this simulation model. Please take the necessary steps to recover from this data corruption in hardware.", addr_str, clk_str, addr_str);

	end
	
    endtask // task_warn_msg

    
    specify

        (CLKA => DOA[0]) = (100:100:100, 100:100:100);
        (CLKA => DOA[1]) = (100:100:100, 100:100:100);
        (CLKA => DOA[2]) = (100:100:100, 100:100:100);
        (CLKA => DOA[3]) = (100:100:100, 100:100:100);
        (CLKA => DOA[4]) = (100:100:100, 100:100:100);
        (CLKA => DOA[5]) = (100:100:100, 100:100:100);
        (CLKA => DOA[6]) = (100:100:100, 100:100:100);
        (CLKA => DOA[7]) = (100:100:100, 100:100:100);
        (CLKA => DOA[8]) = (100:100:100, 100:100:100);
        (CLKA => DOA[9]) = (100:100:100, 100:100:100);
        (CLKA => DOA[10]) = (100:100:100, 100:100:100);
        (CLKA => DOA[11]) = (100:100:100, 100:100:100);
        (CLKA => DOA[12]) = (100:100:100, 100:100:100);
        (CLKA => DOA[13]) = (100:100:100, 100:100:100);
        (CLKA => DOA[14]) = (100:100:100, 100:100:100);
        (CLKA => DOA[15]) = (100:100:100, 100:100:100);
        (CLKA => DOA[16]) = (100:100:100, 100:100:100);
        (CLKA => DOA[17]) = (100:100:100, 100:100:100);
        (CLKA => DOA[18]) = (100:100:100, 100:100:100);
        (CLKA => DOA[19]) = (100:100:100, 100:100:100);
        (CLKA => DOA[20]) = (100:100:100, 100:100:100);
        (CLKA => DOA[21]) = (100:100:100, 100:100:100);
        (CLKA => DOA[22]) = (100:100:100, 100:100:100);
        (CLKA => DOA[23]) = (100:100:100, 100:100:100);
        (CLKA => DOA[24]) = (100:100:100, 100:100:100);
        (CLKA => DOA[25]) = (100:100:100, 100:100:100);
        (CLKA => DOA[26]) = (100:100:100, 100:100:100);
        (CLKA => DOA[27]) = (100:100:100, 100:100:100);
        (CLKA => DOA[28]) = (100:100:100, 100:100:100);
        (CLKA => DOA[29]) = (100:100:100, 100:100:100);
        (CLKA => DOA[30]) = (100:100:100, 100:100:100);
        (CLKA => DOA[31]) = (100:100:100, 100:100:100);
        (CLKA => DOPA[0]) = (100:100:100, 100:100:100);
        (CLKA => DOPA[1]) = (100:100:100, 100:100:100);
        (CLKA => DOPA[2]) = (100:100:100, 100:100:100);
        (CLKA => DOPA[3]) = (100:100:100, 100:100:100);
        (CLKB => DOB[0]) = (100:100:100, 100:100:100);
        (CLKB => DOB[1]) = (100:100:100, 100:100:100);
        (CLKB => DOB[2]) = (100:100:100, 100:100:100);
        (CLKB => DOB[3]) = (100:100:100, 100:100:100);
        (CLKB => DOB[4]) = (100:100:100, 100:100:100);
        (CLKB => DOB[5]) = (100:100:100, 100:100:100);
        (CLKB => DOB[6]) = (100:100:100, 100:100:100);
        (CLKB => DOB[7]) = (100:100:100, 100:100:100);
        (CLKB => DOB[8]) = (100:100:100, 100:100:100);
        (CLKB => DOB[9]) = (100:100:100, 100:100:100);
        (CLKB => DOB[10]) = (100:100:100, 100:100:100);
        (CLKB => DOB[11]) = (100:100:100, 100:100:100);
        (CLKB => DOB[12]) = (100:100:100, 100:100:100);
        (CLKB => DOB[13]) = (100:100:100, 100:100:100);
        (CLKB => DOB[14]) = (100:100:100, 100:100:100);
        (CLKB => DOB[15]) = (100:100:100, 100:100:100);
        (CLKB => DOB[16]) = (100:100:100, 100:100:100);
        (CLKB => DOB[17]) = (100:100:100, 100:100:100);
        (CLKB => DOB[18]) = (100:100:100, 100:100:100);
        (CLKB => DOB[19]) = (100:100:100, 100:100:100);
        (CLKB => DOB[20]) = (100:100:100, 100:100:100);
        (CLKB => DOB[21]) = (100:100:100, 100:100:100);
        (CLKB => DOB[22]) = (100:100:100, 100:100:100);
        (CLKB => DOB[23]) = (100:100:100, 100:100:100);
        (CLKB => DOB[24]) = (100:100:100, 100:100:100);
        (CLKB => DOB[25]) = (100:100:100, 100:100:100);
        (CLKB => DOB[26]) = (100:100:100, 100:100:100);
        (CLKB => DOB[27]) = (100:100:100, 100:100:100);
        (CLKB => DOB[28]) = (100:100:100, 100:100:100);
        (CLKB => DOB[29]) = (100:100:100, 100:100:100);
        (CLKB => DOB[30]) = (100:100:100, 100:100:100);
        (CLKB => DOB[31]) = (100:100:100, 100:100:100);
        (CLKB => DOPB[0]) = (100:100:100, 100:100:100);
        (CLKB => DOPB[1]) = (100:100:100, 100:100:100);
        (CLKB => DOPB[2]) = (100:100:100, 100:100:100);
        (CLKB => DOPB[3]) = (100:100:100, 100:100:100);

        (RSTA => DOA[0]) = (0:0:0, 0:0:0);
        (RSTA => DOA[1]) = (0:0:0, 0:0:0);
        (RSTA => DOA[2]) = (0:0:0, 0:0:0);
        (RSTA => DOA[3]) = (0:0:0, 0:0:0);
        (RSTA => DOA[4]) = (0:0:0, 0:0:0);
        (RSTA => DOA[5]) = (0:0:0, 0:0:0);
        (RSTA => DOA[6]) = (0:0:0, 0:0:0);
        (RSTA => DOA[7]) = (0:0:0, 0:0:0);
        (RSTA => DOA[8]) = (0:0:0, 0:0:0);
        (RSTA => DOA[9]) = (0:0:0, 0:0:0);
        (RSTA => DOA[10]) = (0:0:0, 0:0:0);
        (RSTA => DOA[11]) = (0:0:0, 0:0:0);
        (RSTA => DOA[12]) = (0:0:0, 0:0:0);
        (RSTA => DOA[13]) = (0:0:0, 0:0:0);
        (RSTA => DOA[14]) = (0:0:0, 0:0:0);
        (RSTA => DOA[15]) = (0:0:0, 0:0:0);
        (RSTA => DOA[16]) = (0:0:0, 0:0:0);
        (RSTA => DOA[17]) = (0:0:0, 0:0:0);
        (RSTA => DOA[18]) = (0:0:0, 0:0:0);
        (RSTA => DOA[19]) = (0:0:0, 0:0:0);
        (RSTA => DOA[20]) = (0:0:0, 0:0:0);
        (RSTA => DOA[21]) = (0:0:0, 0:0:0);
        (RSTA => DOA[22]) = (0:0:0, 0:0:0);
        (RSTA => DOA[23]) = (0:0:0, 0:0:0);
        (RSTA => DOA[24]) = (0:0:0, 0:0:0);
        (RSTA => DOA[25]) = (0:0:0, 0:0:0);
        (RSTA => DOA[26]) = (0:0:0, 0:0:0);
        (RSTA => DOA[27]) = (0:0:0, 0:0:0);
        (RSTA => DOA[28]) = (0:0:0, 0:0:0);
        (RSTA => DOA[29]) = (0:0:0, 0:0:0);
        (RSTA => DOA[30]) = (0:0:0, 0:0:0);
        (RSTA => DOA[31]) = (0:0:0, 0:0:0);
        (RSTA => DOPA[0]) = (0:0:0, 0:0:0);
        (RSTA => DOPA[1]) = (0:0:0, 0:0:0);
        (RSTA => DOPA[2]) = (0:0:0, 0:0:0);
        (RSTA => DOPA[3]) = (0:0:0, 0:0:0);
        (RSTB => DOB[0]) = (0:0:0, 0:0:0);
        (RSTB => DOB[1]) = (0:0:0, 0:0:0);
        (RSTB => DOB[2]) = (0:0:0, 0:0:0);
        (RSTB => DOB[3]) = (0:0:0, 0:0:0);
        (RSTB => DOB[4]) = (0:0:0, 0:0:0);
        (RSTB => DOB[5]) = (0:0:0, 0:0:0);
        (RSTB => DOB[6]) = (0:0:0, 0:0:0);
        (RSTB => DOB[7]) = (0:0:0, 0:0:0);
        (RSTB => DOB[8]) = (0:0:0, 0:0:0);
        (RSTB => DOB[9]) = (0:0:0, 0:0:0);
        (RSTB => DOB[10]) = (0:0:0, 0:0:0);
        (RSTB => DOB[11]) = (0:0:0, 0:0:0);
        (RSTB => DOB[12]) = (0:0:0, 0:0:0);
        (RSTB => DOB[13]) = (0:0:0, 0:0:0);
        (RSTB => DOB[14]) = (0:0:0, 0:0:0);
        (RSTB => DOB[15]) = (0:0:0, 0:0:0);
        (RSTB => DOB[16]) = (0:0:0, 0:0:0);
        (RSTB => DOB[17]) = (0:0:0, 0:0:0);
        (RSTB => DOB[18]) = (0:0:0, 0:0:0);
        (RSTB => DOB[19]) = (0:0:0, 0:0:0);
        (RSTB => DOB[20]) = (0:0:0, 0:0:0);
        (RSTB => DOB[21]) = (0:0:0, 0:0:0);
        (RSTB => DOB[22]) = (0:0:0, 0:0:0);
        (RSTB => DOB[23]) = (0:0:0, 0:0:0);
        (RSTB => DOB[24]) = (0:0:0, 0:0:0);
        (RSTB => DOB[25]) = (0:0:0, 0:0:0);
        (RSTB => DOB[26]) = (0:0:0, 0:0:0);
        (RSTB => DOB[27]) = (0:0:0, 0:0:0);
        (RSTB => DOB[28]) = (0:0:0, 0:0:0);
        (RSTB => DOB[29]) = (0:0:0, 0:0:0);
        (RSTB => DOB[30]) = (0:0:0, 0:0:0);
        (RSTB => DOB[31]) = (0:0:0, 0:0:0);
        (RSTB => DOPB[0]) = (0:0:0, 0:0:0);
        (RSTB => DOPB[1]) = (0:0:0, 0:0:0);
        (RSTB => DOPB[2]) = (0:0:0, 0:0:0);
        (RSTB => DOPB[3]) = (0:0:0, 0:0:0);
	
	$setuphold (posedge CLKB, posedge ADDRB[0] &&& ENB, 0:0:0, 0:0:0, notifier_addrb0);
       	$setuphold (posedge CLKB, negedge ADDRB[0] &&& ENB, 0:0:0, 0:0:0, notifier_addrb0);
       	$setuphold (posedge CLKB, posedge ADDRB[1] &&& ENB, 0:0:0, 0:0:0, notifier_addrb1);
       	$setuphold (posedge CLKB, negedge ADDRB[1] &&& ENB, 0:0:0, 0:0:0, notifier_addrb1);
       	$setuphold (posedge CLKB, posedge ADDRB[2] &&& ENB, 0:0:0, 0:0:0, notifier_addrb2);
       	$setuphold (posedge CLKB, negedge ADDRB[2] &&& ENB, 0:0:0, 0:0:0, notifier_addrb2);
       	$setuphold (posedge CLKB, posedge ADDRB[3] &&& ENB, 0:0:0, 0:0:0, notifier_addrb3);
       	$setuphold (posedge CLKB, negedge ADDRB[3] &&& ENB, 0:0:0, 0:0:0, notifier_addrb3);
       	$setuphold (posedge CLKB, posedge ADDRB[4] &&& ENB, 0:0:0, 0:0:0, notifier_addrb4);
       	$setuphold (posedge CLKB, negedge ADDRB[4] &&& ENB, 0:0:0, 0:0:0, notifier_addrb4);
       	$setuphold (posedge CLKB, posedge ADDRB[5] &&& ENB, 0:0:0, 0:0:0, notifier_addrb5);
       	$setuphold (posedge CLKB, negedge ADDRB[5] &&& ENB, 0:0:0, 0:0:0, notifier_addrb5);
       	$setuphold (posedge CLKB, posedge ADDRB[6] &&& ENB, 0:0:0, 0:0:0, notifier_addrb6);
       	$setuphold (posedge CLKB, negedge ADDRB[6] &&& ENB, 0:0:0, 0:0:0, notifier_addrb6);
       	$setuphold (posedge CLKB, posedge ADDRB[7] &&& ENB, 0:0:0, 0:0:0, notifier_addrb7);
       	$setuphold (posedge CLKB, negedge ADDRB[7] &&& ENB, 0:0:0, 0:0:0, notifier_addrb7);
       	$setuphold (posedge CLKB, posedge ADDRB[8] &&& ENB, 0:0:0, 0:0:0, notifier_addrb8);
       	$setuphold (posedge CLKB, negedge ADDRB[8] &&& ENB, 0:0:0, 0:0:0, notifier_addrb8);
       	$setuphold (posedge CLKB, posedge ADDRB[9] &&& ENB, 0:0:0, 0:0:0, notifier_addrb9);
       	$setuphold (posedge CLKB, negedge ADDRB[9] &&& ENB, 0:0:0, 0:0:0, notifier_addrb9);
       	$setuphold (posedge CLKB, posedge ADDRB[10] &&& ENB, 0:0:0, 0:0:0, notifier_addrb10);
       	$setuphold (posedge CLKB, negedge ADDRB[10] &&& ENB, 0:0:0, 0:0:0, notifier_addrb10);
       	$setuphold (posedge CLKB, posedge ADDRB[11] &&& ENB, 0:0:0, 0:0:0, notifier_addrb11);
       	$setuphold (posedge CLKB, negedge ADDRB[11] &&& ENB, 0:0:0, 0:0:0, notifier_addrb11);
       	$setuphold (posedge CLKB, posedge ADDRB[12] &&& ENB, 0:0:0, 0:0:0, notifier_addrb12);
       	$setuphold (posedge CLKB, negedge ADDRB[12] &&& ENB, 0:0:0, 0:0:0, notifier_addrb12);
       	$setuphold (posedge CLKB, posedge ADDRB[13] &&& ENB, 0:0:0, 0:0:0, notifier_addrb13);
       	$setuphold (posedge CLKB, negedge ADDRB[13] &&& ENB, 0:0:0, 0:0:0, notifier_addrb13);
	$setuphold (posedge CLKB, posedge DIB[0] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[0] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[1] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[1] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[2] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[2] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[3] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[3] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[4] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[4] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[5] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[5] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[6] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[6] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[7] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[7] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[8] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[8] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[9] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[9] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[10] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[10] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[11] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[11] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[12] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[12] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[13] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[13] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[14] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[14] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[15] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[15] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[16] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[16] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[17] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[17] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[18] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[18] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[19] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[19] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[20] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[20] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[21] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[21] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[22] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[22] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[23] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[23] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[24] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[24] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[25] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[25] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[26] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[26] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[27] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[27] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[28] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[28] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[29] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[29] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[30] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[30] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIB[31] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIB[31] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIPB[0] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIPB[0] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIPB[1] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIPB[1] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIPB[2] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIPB[2] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIPB[3] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIPB[3] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge REGCEB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge REGCEB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge RSTB &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge RSTB &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge WEB[0] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge WEB[0] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge WEB[1] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge WEB[1] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge WEB[2] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge WEB[2] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge WEB[3] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge WEB[3] &&& ENB, 0:0:0, 0:0:0, notifier_b);
	
	$setuphold (posedge CLKA, posedge ADDRA[0] &&& ENA, 0:0:0, 0:0:0, notifier_addra0);
       	$setuphold (posedge CLKA, negedge ADDRA[0] &&& ENA, 0:0:0, 0:0:0, notifier_addra0);
       	$setuphold (posedge CLKA, posedge ADDRA[1] &&& ENA, 0:0:0, 0:0:0, notifier_addra1);
       	$setuphold (posedge CLKA, negedge ADDRA[1] &&& ENA, 0:0:0, 0:0:0, notifier_addra1);
       	$setuphold (posedge CLKA, posedge ADDRA[2] &&& ENA, 0:0:0, 0:0:0, notifier_addra2);
       	$setuphold (posedge CLKA, negedge ADDRA[2] &&& ENA, 0:0:0, 0:0:0, notifier_addra2);
       	$setuphold (posedge CLKA, posedge ADDRA[3] &&& ENA, 0:0:0, 0:0:0, notifier_addra3);
       	$setuphold (posedge CLKA, negedge ADDRA[3] &&& ENA, 0:0:0, 0:0:0, notifier_addra3);
       	$setuphold (posedge CLKA, posedge ADDRA[4] &&& ENA, 0:0:0, 0:0:0, notifier_addra4);
       	$setuphold (posedge CLKA, negedge ADDRA[4] &&& ENA, 0:0:0, 0:0:0, notifier_addra4);
       	$setuphold (posedge CLKA, posedge ADDRA[5] &&& ENA, 0:0:0, 0:0:0, notifier_addra5);
       	$setuphold (posedge CLKA, negedge ADDRA[5] &&& ENA, 0:0:0, 0:0:0, notifier_addra5);
       	$setuphold (posedge CLKA, posedge ADDRA[6] &&& ENA, 0:0:0, 0:0:0, notifier_addra6);
       	$setuphold (posedge CLKA, negedge ADDRA[6] &&& ENA, 0:0:0, 0:0:0, notifier_addra6);
       	$setuphold (posedge CLKA, posedge ADDRA[7] &&& ENA, 0:0:0, 0:0:0, notifier_addra7);
       	$setuphold (posedge CLKA, negedge ADDRA[7] &&& ENA, 0:0:0, 0:0:0, notifier_addra7);
       	$setuphold (posedge CLKA, posedge ADDRA[8] &&& ENA, 0:0:0, 0:0:0, notifier_addra8);
       	$setuphold (posedge CLKA, negedge ADDRA[8] &&& ENA, 0:0:0, 0:0:0, notifier_addra8);
       	$setuphold (posedge CLKA, posedge ADDRA[9] &&& ENA, 0:0:0, 0:0:0, notifier_addra9);
       	$setuphold (posedge CLKA, negedge ADDRA[9] &&& ENA, 0:0:0, 0:0:0, notifier_addra9);
       	$setuphold (posedge CLKA, posedge ADDRA[10] &&& ENA, 0:0:0, 0:0:0, notifier_addra10);
       	$setuphold (posedge CLKA, negedge ADDRA[10] &&& ENA, 0:0:0, 0:0:0, notifier_addra10);
       	$setuphold (posedge CLKA, posedge ADDRA[11] &&& ENA, 0:0:0, 0:0:0, notifier_addra11);
       	$setuphold (posedge CLKA, negedge ADDRA[11] &&& ENA, 0:0:0, 0:0:0, notifier_addra11);
       	$setuphold (posedge CLKA, posedge ADDRA[12] &&& ENA, 0:0:0, 0:0:0, notifier_addra12);
       	$setuphold (posedge CLKA, negedge ADDRA[12] &&& ENA, 0:0:0, 0:0:0, notifier_addra12);
       	$setuphold (posedge CLKA, posedge ADDRA[13] &&& ENA, 0:0:0, 0:0:0, notifier_addra13);
       	$setuphold (posedge CLKA, negedge ADDRA[13] &&& ENA, 0:0:0, 0:0:0, notifier_addra13);
       	$setuphold (posedge CLKA, posedge DIA[0] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[0] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[1] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[1] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[2] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[2] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[3] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[3] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[4] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[4] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[5] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[5] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[6] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[6] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[7] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[7] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[8] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[8] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[9] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[9] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[10] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[10] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[11] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[11] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[12] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[12] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[13] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[13] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[14] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[14] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[15] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[15] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[16] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[16] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[17] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[17] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[18] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[18] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[19] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[19] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[20] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[20] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[21] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[21] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[22] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[22] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[23] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[23] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[24] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[24] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[25] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[25] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[26] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[26] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[27] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[27] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[28] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[28] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[29] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[29] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[30] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[30] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIA[31] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIA[31] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIPA[0] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIPA[0] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIPA[1] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIPA[1] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIPA[2] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIPA[2] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIPA[3] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIPA[3] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge REGCEA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge REGCEA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge RSTA &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge RSTA &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge WEA[0] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge WEA[0] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge WEA[1] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge WEA[1] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge WEA[2] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge WEA[2] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge WEA[3] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge WEA[3] &&& ENA, 0:0:0, 0:0:0, notifier_a);

       	$recrem (negedge RSTA, posedge CLKA, 0:0:0, 0:0:0, notifier_a);
       	$recrem (negedge gsr_in, posedge CLKA, 0:0:0, 0:0:0, notifier_a);
	
	$recrem (negedge RSTB, posedge CLKB, 0:0:0, 0:0:0, notifier_b);
       	$recrem (negedge gsr_in, posedge CLKB, 0:0:0, 0:0:0, notifier_b);

	$period (posedge CLKA, 0:0:0, notifier_a);
	$period (posedge CLKB, 0:0:0, notifier_b);

        $width (posedge RSTA, 0:0:0, 0, notifier_a);
        $width (posedge RSTB, 0:0:0, 0, notifier_b);

        $width (posedge CLKA &&& ENA, 0:0:0, 0, notifier_a);
        $width (negedge CLKA &&& ENA, 0:0:0, 0, notifier_a);
        $width (posedge CLKB &&& ENB, 0:0:0, 0, notifier_b);
        $width (negedge CLKB &&& ENB, 0:0:0, 0, notifier_b);

	specparam PATHPULSE$ = 0;

    endspecify

    
endmodule // X_RAMB16BWER

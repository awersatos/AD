// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/stan/X_RAMB8BWER.v,v 1.16.4.1.4.1 2010/03/29 22:46:41 wloo Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2008 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
 //  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1
//  \   \         Description : Xilinx Timing Simulation Library Component 8K-Bit Data and
//  /   /                       1K-Bit Parity Dual Port Block RAM.
// /___/   /\     Filename : X_RAMB8BWER.v
// \   \  /  \    Timestamp : Tue Apr 29 17:59:57 PDT 2008
//  \___\/\___\
//
// Revision:
//    04/29/08 - Initial version.
//    11/04/08 - Fixed incorrect output during first clock cycle (CR 470964).
//    11/13/08 - Added missing timing check (CR 496666).
//    11/19/08 - Fixed EN_RSTRAM_A/B = FALSE. (IR 497199)
//    12/10/08 - Fixed REGCE in output register (IR 499078). Fixed problem caused by IR 497199.
//    01/26/09 - Update reset behavior (IR 500935).
//    02/19/09 - Fixed asychronous reset in register mode (IR 506208).
//    03/10/09 - X's the unused bits of outputs (CR 511363).
//    03/12/09 - Removed parameter from specify block (CR 503821).
//    03/24/09 - Fixed unusual behavior of X's in the unused bits of outputs (CR 513167).
//    09/22/09 - Fixed SRVAL in SDP mode (CR 532416).
//    12/16/09 - Enhanced memory initialization (CR 540764).
//    02/25/10 - Added DRC of DATA_WIDTH_A/B = 36 is required for SDP mode (CR 550329).
//    03/15/10 - Updated address collision for asynchronous clocks and read first mode (CR 547447).
//             - Fixed DRC for SDP mode (CR 552920).
//    03/17/10 - Removed INIT_FILE support (CR 553511).
// End Revision

`timescale 1 ps/1 ps

module X_RAMB8BWER (DOADO, DOBDO, DOPADOP, DOPBDOP, 
		  ADDRAWRADDR, ADDRBRDADDR, CLKAWRCLK, CLKBRDCLK, DIADI, DIBDI, DIPADIP, DIPBDIP, ENAWREN, ENBRDEN, REGCEA, REGCEBREGCE, RSTA, RSTBRST, WEAWEL, WEBWEU);

    output [15:0] DOADO;
    output [15:0] DOBDO;
    output [1:0] DOPADOP;
    output [1:0] DOPBDOP;
  
    input [12:0] ADDRAWRADDR;
    input [12:0] ADDRBRDADDR;
    input CLKAWRCLK;
    input CLKBRDCLK;
    input [15:0] DIADI;
    input [15:0] DIBDI;
    input [1:0] DIPADIP;
    input [1:0] DIPBDIP;
    input ENAWREN;
    input ENBRDEN;
    input REGCEA;
    input REGCEBREGCE;
    input RSTA;
    input RSTBRST;
    input [1:0] WEAWEL;
    input [1:0] WEBWEU;

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
    parameter INIT_A = 18'h0;
    parameter INIT_B = 18'h0;
    parameter INIT_FILE = "NONE";
    parameter LOC = "UNPLACED";
    parameter RAM_MODE = "TDP";
    parameter RSTTYPE = "SYNC";
    parameter RST_PRIORITY_A = "SR";
    parameter RST_PRIORITY_B = "SR";
    parameter SETUP_ALL = 1000;
    parameter SETUP_READ_FIRST = 3000;
    parameter SIM_COLLISION_CHECK = "ALL";
    parameter SRVAL_A = 18'h0;
    parameter SRVAL_B = 18'h0;
    parameter WRITE_MODE_A = "WRITE_FIRST";
    parameter WRITE_MODE_B = "WRITE_FIRST";

    
    wire [15:0] addrawraddr_in, addrbrdaddr_in;
    wire [12:0] col_addra_reconstruct, col_addrb_reconstruct;
    reg [12:0] 	col_addra_reconstruct_reg, col_addrb_reconstruct_reg;
    
    localparam widest_width = (DATA_WIDTH_A >= DATA_WIDTH_B) ? DATA_WIDTH_A : DATA_WIDTH_B;

    localparam a_width = (DATA_WIDTH_A == 1) ? 1 : (DATA_WIDTH_A == 2) ? 2 : (DATA_WIDTH_A == 4) ? 4 :
			 (DATA_WIDTH_A == 9) ? 8 : (DATA_WIDTH_A == 18) ? 16 : (DATA_WIDTH_A == 36) ? 32 : 32;
    
    localparam b_width = (DATA_WIDTH_B == 1) ? 1 : (DATA_WIDTH_B == 2) ? 2 : (DATA_WIDTH_B == 4) ? 4 :
			 (DATA_WIDTH_B == 9) ? 8 : (DATA_WIDTH_B == 18) ? 16 : (DATA_WIDTH_B == 36) ? 32 : 32;

    localparam a_widthp = (DATA_WIDTH_A == 9) ? 1 : (DATA_WIDTH_A == 18) ? 2 : (DATA_WIDTH_A == 36) ? 4 : 4;
    
    localparam b_widthp = (DATA_WIDTH_B == 9) ? 1 : (DATA_WIDTH_B == 18) ? 2 : (DATA_WIDTH_B == 36) ? 4 : 4;
    
    localparam col_addr_lsb = (widest_width == 1) ? 0 : (widest_width == 2) ? 1 : (widest_width == 4) ? 2 :
			      (widest_width == 9) ? 3 : (widest_width == 18) ? 4 : (widest_width == 36) ? 5 : 0;

    assign col_addra_reconstruct[12:0] = (WRITE_MODE_A == "READ_FIRST" || WRITE_MODE_B == "READ_FIRST") ? 
					 ({addrawraddr_in[12:6],1'b0,addrawraddr_in[4],4'b0}) : addrawraddr_in[12:0];

    assign col_addrb_reconstruct[12:0] = (WRITE_MODE_A == "READ_FIRST" || WRITE_MODE_B == "READ_FIRST") ?
					 ({addrbrdaddr_in[12:6],1'b0,addrbrdaddr_in[4],4'b0}) : addrbrdaddr_in[12:0];
 
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


    localparam mem_depth = (widest_width == 1) ? 8192 : (widest_width == 2) ? 4096 : (widest_width == 4) ? 2048 : 
			   (widest_width == 9) ? 1024 :(widest_width == 18) ? 512 : (widest_width == 36) ? 256 : 8192;
		
    localparam memp_depth = (widest_width == 9) ? 1024 :(widest_width == 18) ? 512 : (widest_width == 36) ? 256 : 1024;

    localparam INIT_A_int = (RAM_MODE == "SDP" && DATA_WIDTH_A == 36) ? 
			    {INIT_B[17:16],INIT_A[17:16],INIT_B[15:0],INIT_A[15:0]} : INIT_A;
    localparam INIT_B_int = (RAM_MODE == "SDP" && DATA_WIDTH_B == 36) ? 
			    {INIT_B[17:16],INIT_A[17:16],INIT_B[15:0],INIT_A[15:0]} : INIT_B;
    localparam SRVAL_A_int = (RAM_MODE == "SDP" && DATA_WIDTH_A == 36) ? 
			     {SRVAL_B[17:16],SRVAL_A[17:16],SRVAL_B[15:0],SRVAL_A[15:0]} : SRVAL_A;
    localparam SRVAL_B_int = (RAM_MODE == "SDP" && DATA_WIDTH_B == 36) ? 
			     {SRVAL_B[17:16],SRVAL_A[17:16],SRVAL_B[15:0],SRVAL_A[15:0]} : SRVAL_B;
    
    reg [widest_width-1:0] tmp_mem [mem_depth-1:0];
    
    reg [width-1:0] mem [mem_depth-1:0];
    reg [widthp-1:0] memp [memp_depth-1:0];

    integer count, countp, init_mult, initp_mult, large_width;
    integer count1, countp1, i, i1, i_p, i_mem, init_offset, initp_offset;

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

    wire [15:0] dibdi_in;
    wire [15:0] diadi_in;
    wire clkawrclk_in, clkbrdclk_in;

    wire [1:0] dipbdip_in;
    wire [1:0] dipadip_in;
    wire enawren_in, enbrden_in, regcea_in, regcebregce_in, rsta_in, rstbrst_in;
    wire [1:0] weawel_in;
    wire [1:0] webweu_in;

    wire [a_width-1:0] diadi_int;
    wire [b_width-1:0] dibdi_int;
    wire [a_widthp-1:0] dipadip_int;
    wire [b_widthp-1:0] dipbdip_int;
    wire [3:0] weawel_int, webweu_int;
    
    wire [15:0] doado_out_port, dobdo_out_port;
    wire [1:0] dopadop_out_port, dopbdop_out_port;
    
    integer ram_mode_int = 0, rsttype_int = 0;
    
    tri0 gsr_in = glbl.GSR;
    
    assign addrawraddr_in = {3'b000, ADDRAWRADDR};
    assign addrbrdaddr_in = {3'b000, ADDRBRDADDR};
    assign clkawrclk_in = CLKAWRCLK;
    assign clkbrdclk_in = CLKBRDCLK;
    
    assign diadi_in = DIADI;
    assign dibdi_in = DIBDI;
    assign dipadip_in = DIPADIP;
    assign dipbdip_in = DIPBDIP;
    assign DOADO = doado_out_port;
    assign DOPADOP = dopadop_out_port;
    assign DOBDO = dobdo_out_port;
    assign DOPBDOP = dopbdop_out_port;

    assign enawren_in = ENAWREN;
    assign enbrden_in = ENBRDEN;
    assign regcea_in = REGCEA;
    assign regcebregce_in = REGCEBREGCE;
    assign rsta_in = RSTA;
    assign rstbrst_in = RSTBRST;
    assign weawel_in = WEAWEL;
    assign webweu_in = WEBWEU;

    
    generate
        case (RAM_MODE)
	    "TDP" : begin
		        assign dibdi_int = dibdi_in;
		        assign diadi_int = diadi_in;  // 16
		        assign dipbdip_int = dipbdip_in; // 2
		        assign dipadip_int = dipadip_in;
		        assign doado_out_port = doado_out_out;
		        assign dobdo_out_port = dobdo_out_out;
		        assign dopadop_out_port = dopadop_out_out;
		        assign dopbdop_out_port = dopbdop_out_out;
		        assign webweu_int = webweu_in;
		        assign weawel_int = weawel_in;  //2
	            end
	    "SDP" : begin
		        assign dibdi_int = 32'b0;
		        assign diadi_int = {dibdi_in, diadi_in};  // 32
		        assign dipbdip_int = 4'b0;
		        assign dipadip_int = {dipbdip_in, dipadip_in}; // 4
		        assign doado_out_port = dobdo_out_out[15:0];
		        assign dobdo_out_port = dobdo_out_out[31:16];
		        assign dopadop_out_port = dopbdop_out_out[1:0];
		        assign dopbdop_out_port = dopbdop_out_out[3:2];
		        assign webweu_int = 4'b0;
		        assign weawel_int = {webweu_in, weawel_in}; // 4
	            end

	endcase
    endgenerate

    
    initial begin

	if (INIT_FILE == "NONE") begin

	    init_mult = 256/width;
	    
	    for (count = 0; count < init_mult; count = count + 1) begin

		init_offset = count * width;
		
		mem[count] = INIT_00[init_offset +:width];
		mem[count + (init_mult * 1)] = INIT_01[init_offset +:width];
		mem[count + (init_mult * 2)] = INIT_02[init_offset +:width];
		mem[count + (init_mult * 3)] = INIT_03[init_offset +:width];
		mem[count + (init_mult * 4)] = INIT_04[init_offset +:width];
		mem[count + (init_mult * 5)] = INIT_05[init_offset +:width];
		mem[count + (init_mult * 6)] = INIT_06[init_offset +:width];
		mem[count + (init_mult * 7)] = INIT_07[init_offset +:width];
		mem[count + (init_mult * 8)] = INIT_08[init_offset +:width];
		mem[count + (init_mult * 9)] = INIT_09[init_offset +:width];
		mem[count + (init_mult * 10)] = INIT_0A[init_offset +:width];
		mem[count + (init_mult * 11)] = INIT_0B[init_offset +:width];
		mem[count + (init_mult * 12)] = INIT_0C[init_offset +:width];
		mem[count + (init_mult * 13)] = INIT_0D[init_offset +:width];
		mem[count + (init_mult * 14)] = INIT_0E[init_offset +:width];
		mem[count + (init_mult * 15)] = INIT_0F[init_offset +:width];
		mem[count + (init_mult * 16)] = INIT_10[init_offset +:width];
		mem[count + (init_mult * 17)] = INIT_11[init_offset +:width];
		mem[count + (init_mult * 18)] = INIT_12[init_offset +:width];
		mem[count + (init_mult * 19)] = INIT_13[init_offset +:width];
		mem[count + (init_mult * 20)] = INIT_14[init_offset +:width];
		mem[count + (init_mult * 21)] = INIT_15[init_offset +:width];
		mem[count + (init_mult * 22)] = INIT_16[init_offset +:width];
		mem[count + (init_mult * 23)] = INIT_17[init_offset +:width];
		mem[count + (init_mult * 24)] = INIT_18[init_offset +:width];
		mem[count + (init_mult * 25)] = INIT_19[init_offset +:width];
		mem[count + (init_mult * 26)] = INIT_1A[init_offset +:width];
		mem[count + (init_mult * 27)] = INIT_1B[init_offset +:width];
		mem[count + (init_mult * 28)] = INIT_1C[init_offset +:width];
		mem[count + (init_mult * 29)] = INIT_1D[init_offset +:width];
		mem[count + (init_mult * 30)] = INIT_1E[init_offset +:width];
		mem[count + (init_mult * 31)] = INIT_1F[init_offset +:width];
	    end // for (count = 0; count < init_mult; count = count + 1)
		
	    
	    if (width >= 8) begin
	    	
		initp_mult = 256/widthp;
		
		for (countp = 0; countp < initp_mult; countp = countp + 1) begin

		    initp_offset = countp * widthp;

		    memp[countp]                    = INITP_00[initp_offset +:widthp];
		    memp[countp + (initp_mult * 1)] = INITP_01[initp_offset +:widthp];
		    memp[countp + (initp_mult * 2)] = INITP_02[initp_offset +:widthp];
		    memp[countp + (initp_mult * 3)] = INITP_03[initp_offset +:widthp];
		    
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


	if (INIT_FILE != "NONE") begin
	    $display("DRC Error : The INIT_FILE attribute on X_RAMB8BWER instance %m is set to %s.  Currently, initializing memory contents of this component via an external file is not supported.  Please set this attribute to the default value of NONE and specify any initialization of this component via the INIT_xx attributes.", INIT_FILE);
	    finish_error = 1;
	end

	
	case (DATA_WIDTH_A)

	    0, 1, 2, 4, 9, 18: ;
	    36: begin
		    if (RAM_MODE != "SDP") begin
			$display("DRC error : The attribute DATA_WIDTH_A = 36 requires RAM_MODE set to SDP on X_RAMB8BWER instance %m.");
			finish_error = 1;
		    end
	        end 
	    default : begin
		          $display("Attribute Syntax Error : The attribute DATA_WIDTH_A on X_RAMB8BWER instance %m is set to %d.  Legal values for this attribute are 0, 1, 2, 4, 9, 18 or 36.", DATA_WIDTH_A);
		          finish_error = 1;
	              end

	endcase // case(DATA_WIDTH_A)

	
	case (DATA_WIDTH_B)

	    0, 1, 2, 4, 9, 18: ;
	    36: begin
		    if (RAM_MODE != "SDP") begin
			$display("DRC error : The attribute DATA_WIDTH_B = 36 requires RAM_MODE set to SDP on X_RAMB8BWER instance %m.");
			finish_error = 1;
		    end
	        end 
	    default : begin
		          $display("Attribute Syntax Error : The attribute DATA_WIDTH_B on X_RAMB8BWER instance %m is set to %d.  Legal values for this attribute are 0, 1, 2, 4, 9, 18 or 36.", DATA_WIDTH_B);
		          finish_error = 1;
	              end

	endcase // case(DATA_WIDTH_B)


	if (DATA_WIDTH_A == 0 && DATA_WIDTH_B == 0) begin
	    $display("Attribute Syntax Error : Attributes DATA_WIDTH_A and DATA_WIDTH_B on X_RAMB8BWER instance %m, both can not be 0.");
	    finish_error = 1;
	end

	       
	case (WRITE_MODE_A)
	    "WRITE_FIRST" : wr_mode_a <= 2'b00;
	    "READ_FIRST"  : wr_mode_a <= 2'b01;
	    "NO_CHANGE"   : wr_mode_a <= 2'b10;
	    default       : begin
				$display("Attribute Syntax Error : The Attribute WRITE_MODE_A on X_RAMB8BWER instance %m is set to %s.  Legal values for this attribute are WRITE_FIRST, READ_FIRST or NO_CHANGE.", WRITE_MODE_A);
				finish_error = 1;
			    end
	endcase


	case (WRITE_MODE_B)
	    "WRITE_FIRST" : wr_mode_b <= 2'b00;
	    "READ_FIRST"  : wr_mode_b <= 2'b01;
	    "NO_CHANGE"   : wr_mode_b <= 2'b10;
	    default       : begin
				$display("Attribute Syntax Error : The Attribute WRITE_MODE_B on X_RAMB8BWER instance %m is set to %s.  Legal values for this attribute are WRITE_FIRST, READ_FIRST or NO_CHANGE.", WRITE_MODE_B);
				finish_error = 1;
			    end
	endcase

	
	if ((SIM_COLLISION_CHECK != "ALL") && (SIM_COLLISION_CHECK != "NONE") && (SIM_COLLISION_CHECK != "WARNING_ONLY") && (SIM_COLLISION_CHECK != "GENERATE_X_ONLY")) begin
	    
	    $display("Attribute Syntax Error : The attribute SIM_COLLISION_CHECK on X_RAMB8BWER instance %m is set to %s.  Legal values for this attribute are ALL, NONE, WARNING_ONLY or GENERATE_X_ONLY.", SIM_COLLISION_CHECK);
	    finish_error = 1;

	end

	
	case (RAM_MODE)
	    "TDP" : ram_mode_int <= 0;
	    "SDP" : begin
		         ram_mode_int <= 1;

		         if (DATA_WIDTH_A != 36 || DATA_WIDTH_B != 36) begin
			     $display("DRC error : DATA_WIDTH_A is set to %d and DATA_WIDTH_B is set to %d when RAM_MODE is set to SDP.  DATA_WIDTH_A and DATA_WIDTH_B are required to be set to 36 in simple dual port mode on RAMB8BWER instance %m.", DATA_WIDTH_A, DATA_WIDTH_B);
			     finish_error = 1;
			 end
	             end
	    default : begin
			        $display("Attribute Syntax Error : The attribute RAM_MODE on X_RAMB8BWER instance %m is set to %s.  Legal values for this attribute are SDP or TDP.", RAM_MODE);
				finish_error = 1;
			    end
	endcase // case(RAM_MODE)
		

	case (RSTTYPE)
	    "SYNC" : rsttype_int <= 0;
	    "ASYNC" : rsttype_int <= 1;
	    default       : begin
			        $display("Attribute Syntax Error : The attribute RSTTYPE on X_RAMB8BWER instance %m is set to %s.  Legal values for this attribute are ASYNC or SYNC.", RSTTYPE);
				finish_error = 1;
			    end
	endcase // case(RSTTYPE)

	
	if (RAM_MODE == "SDP" && WRITE_MODE_A != "READ_FIRST") begin
	    $display("DRC Error : The attribute WRITE_MODE_A must set to READ_FIRST when RAM_MODE = SDP on X_RAMB8BWER instance %m.");
	    finish_error = 1;
	end

	
	if (RAM_MODE == "SDP" && WRITE_MODE_B != "READ_FIRST") begin
	    $display("DRC Error : The attribute WRITE_MODE_B must set to READ_FIRST when RAM_MODE = SDP on X_RAMB8BWER instance %m.");
	    finish_error = 1;
	end

	
	if ((EN_RSTRAM_A != "TRUE") && (EN_RSTRAM_A != "FALSE")) begin
	    $display("Attribute Syntax Error : The attribute EN_RSTRAM_A on X_RAMB8BWER instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", EN_RSTRAM_A);
	    finish_error = 1;
	end
	

	if ((EN_RSTRAM_B != "TRUE") && (EN_RSTRAM_B != "FALSE")) begin
	    $display("Attribute Syntax Error : The attribute EN_RSTRAM_B on X_RAMB8BWER instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", EN_RSTRAM_B);
	    finish_error = 1;
	end
	
	
	if ((RST_PRIORITY_A != "SR") && (RST_PRIORITY_A != "CE")) begin
	    $display("Attribute Syntax Error : The attribute RST_PRIORITY_A on X_RAMB8BWER instance %m is set to %s.  Legal values for this attribute are CE or SR.", RST_PRIORITY_A);
	    finish_error = 1;
	end
	
	
	if ((RST_PRIORITY_A != "SR") && (RST_PRIORITY_A != "CE")) begin
	    $display("Attribute Syntax Error : The attribute RST_PRIORITY_A on X_RAMB8BWER instance %m is set to %s.  Legal values for this attribute are CE or SR.", RST_PRIORITY_A);
	    finish_error = 1;
	end

	
	if (finish_error == 1)
	    $finish;

	
    end // initial begin


    always @(gsr_in)
	if (gsr_in) begin
	    
	    assign doado_out = INIT_A_int[0 +: a_width];
		
	    if (a_width >= 8) begin
		assign dopadop_out = INIT_A_int[a_width +: a_widthp];
	    end

	    assign dobdo_out = INIT_B_int[0 +: b_width];
		
	    if (b_width >= 8) begin
		assign dopbdop_out = INIT_B_int[b_width +: b_widthp];
	    end

	end
	else begin
	    deassign doado_out;
	    deassign dopadop_out;
	    deassign dobdo_out;
	    deassign dopbdop_out;
	end

    
    always @(rsta_in or enawren_in or regcea_in) begin

	if (rsttype_int == 1 && gsr_in == 1'b0 && rsta_in === 1'b1) begin // async reset

	    // reset latch regardless DOA_REG
	    if (((enawren_in == 1'b1 && RST_PRIORITY_A == "CE") || RST_PRIORITY_A == "SR") && EN_RSTRAM_A == "TRUE") begin		    
		    
		assign doado_buf = SRVAL_A_int[0 +: a_width];
		assign doado_out = SRVAL_A_int[0 +: a_width];
		    
		if (a_width >= 8) begin
		    assign dopadop_buf = SRVAL_A_int[a_width +: a_widthp];
		    assign dopadop_out = SRVAL_A_int[a_width +: a_widthp];
		end
	    end


	    if (DOA_REG == 1) begin

		if ((regcea_in == 1'b1 && RST_PRIORITY_A == "CE") || RST_PRIORITY_A == "SR") begin
		    assign doado_outreg = SRVAL_A_int[0 +: a_width];
		    
		    if (a_width >= 8)
			assign dopadop_outreg = SRVAL_A_int[a_width +: a_widthp];
		    
		end
	    end
	end // if (rsttype_int == 1 && gsr_in == 1'b0 && rsta_in === 1'b1)
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

	if (rsttype_int == 1 && gsr_in == 1'b0 && rstbrst_in === 1'b1) begin

	    // reset latch regardless DOB_REG
	    if (((enbrden_in == 1'b1 && RST_PRIORITY_B == "CE") || RST_PRIORITY_B == "SR") && EN_RSTRAM_B == "TRUE") begin		    
		
		assign dobdo_buf = SRVAL_B_int[0 +: b_width];
		assign dobdo_out = SRVAL_B_int[0 +: b_width];
		
		if (b_width >= 8) begin
		    assign dopbdop_buf = SRVAL_B_int[b_width +: b_widthp];
		    assign dopbdop_out = SRVAL_B_int[b_width +: b_widthp];
		end
	    end
		

	    if (DOB_REG == 1) begin

		if ((regcebregce_in == 1'b1 && RST_PRIORITY_B == "CE") || RST_PRIORITY_B == "SR") begin
		    assign 	   dobdo_outreg = SRVAL_B_int[0 +: b_width];
		    
		    if (b_width >= 8)
			assign dopbdop_outreg = SRVAL_B_int[b_width +: b_widthp];
		    
		end
	    end
	end // if (rsttype_int == 1 && gsr_in == 1'b0 && rstbrst_in === 1'b1)
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
			if (addrawraddr_in[12:col_addr_lsb] === addrbrdaddr_in[12:col_addr_lsb]) begin
			    
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

			end // if (addrawraddr_in[12:col_addr_lsb] === addrbrdaddr_in[12:col_addr_lsb])
			else
			    viol_time = 0;
			
		    end
		    else if (rising_clkawrclk && !rising_clkbrdclk) begin
			if (col_addra_reconstruct[12:col_addr_lsb] === col_addrb_reconstruct_reg[12:col_addr_lsb]) begin
			    
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
			    
			end // if (addrawraddr_in[12:col_addr_lsb] === addrbrdaddr_reg[12:col_addr_lsb])
			else
			    viol_time = 0;
			
		    end
		    else if (!rising_clkawrclk && rising_clkbrdclk) begin
			if (col_addra_reconstruct_reg[12:col_addr_lsb] === col_addrb_reconstruct[12:col_addr_lsb]) begin
		    
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
			    
			    
			end // if (addrawraddr_reg[12:col_addr_lsb] === addrbrdaddr_in[12:col_addr_lsb])
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
			doado_buf = SRVAL_A_int[0 +: a_width];
			doado_out = SRVAL_A_int[0 +: a_width];
			
			if (a_width >= 8) begin
			    dopadop_buf = SRVAL_A_int[a_width +: a_widthp];
			    dopadop_out = SRVAL_A_int[a_width +: a_widthp];
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
			
			dobdo_buf = SRVAL_B_int[0 +: b_width];
			dobdo_out = SRVAL_B_int[0 +: b_width];
			
			if (b_width >= 8) begin
			    dopbdop_buf = SRVAL_B_int[b_width +: b_widthp];
			    dopbdop_out = SRVAL_B_int[b_width +: b_widthp];
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
		
		doado_outreg <= INIT_A_int[0 +: a_width];

		if (a_width >= 8)
		    dopadop_outreg <= INIT_A_int[a_width +: a_widthp];
		
	    end
	    else if (gsr_in == 1'b0) begin

		if (RST_PRIORITY_A == "CE") begin
		    if (regcea_in == 1'b1) begin
		    
 			if (rsta_in === 1'b1) begin
			    
			    doado_outreg <= SRVAL_A_int[0 +: a_width];
			    
			    if (a_width >= 8)
				dopadop_outreg <= SRVAL_A_int[a_width +: a_widthp];
			    
			end
			else if (rsta_in === 1'b0) begin
			
			    doado_outreg <= doado_out;

			    if (a_width >= 8)
				dopadop_outreg <= dopadop_out;
			    
			end
			
		    end
		end // if (RST_PRIORITY_A == "CE")
		else begin

 		    if (rsta_in === 1'b1) begin
			
			doado_outreg <= SRVAL_A_int[0 +: a_width];
			
			if (a_width >= 8)
			    dopadop_outreg <= SRVAL_A_int[a_width +: a_widthp];
			
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
	                  $display("Attribute Syntax Error : The attribute DOA_REG on X_RAMB8BWER instance %m is set to %2d.  Legal values for this attribute are 0 or 1.", DOA_REG);
	                  $finish;
	              end

	endcase

    end // always @ (doado_out or dopadop_out or doado_outreg or dopadop_outreg)
    
    
// ***** Output Registers **** Port B *****
    always @(posedge clkbrdclk_in or posedge gsr_in) begin

	if (DOB_REG == 1) begin
	
	    if (gsr_in == 1'b1) begin

		dobdo_outreg <= INIT_B_int[0 +: b_width];
		
		if (b_width >= 8)
		    dopbdop_outreg <= INIT_B_int[b_width +: b_widthp];
		
	    end
	    else if (gsr_in == 1'b0) begin

		if (RST_PRIORITY_B == "CE") begin

		    if (regcebregce_in == 1'b1) begin		 		    
			if (rstbrst_in === 1'b1) begin
			    
			    dobdo_outreg <= SRVAL_B_int[0 +: b_width];
			    
			    if (b_width >= 8)
				dopbdop_outreg <= SRVAL_B_int[b_width +: b_widthp];
			    
			end
			else if (rstbrst_in === 1'b0) begin
		
			    dobdo_outreg <= dobdo_out;

			    if (b_width >= 8)
				dopbdop_outreg <= dopbdop_out;
			    
			end
			
		    end

		end // if (RST_PRIORITY_B == "CE")
		else begin
		    
 		    if (rstbrst_in === 1'b1) begin
			
			dobdo_outreg <= SRVAL_B_int[0 +: b_width];
			
			if (b_width >= 8)
			    dopbdop_outreg <= SRVAL_B_int[b_width +: b_widthp];
			
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
	                  $display("Attribute Syntax Error : The attribute DOB_REG on X_RAMB8BWER instance %m is set to %2d.  Legal values for this attribute are 0 or 1.", DOB_REG);
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
		    $display("Memory Collision Error on X_RAMB8BWER : %m at simulation time %.3f ns.\nA write was requested to the same address simultaneously at both port A and port B of the RAM. The contents written to the RAM at address location %h (hex) of port A and address location %h (hex) of port B are unknown.", $time/1000.0, addrawraddr_tmp, addrbrdaddr_tmp);
		    col_wr_wr_msg = 0;
		end
	    
		else if (weawel_tmp === 1'b1 && webweu_tmp === 1'b0 && col_wra_rdb_msg == 1) begin

		    if ((wr_mode_a == 2'b01 || wr_mode_b == 2'b01) && viol_time == 2)
			$display("Memory Collision Error on X_RAMB8BWER : %m at simulation time %.3f ns.\nA read was performed on address %h (hex) of port B while a write was requested to the same address on port A. The write will be unsuccessful and the content of the RAM at address location %h (hex) of port A became unknown.", $time/1000.0, addrbrdaddr_tmp, addrawraddr_tmp);
		    else
			$display("Memory Collision Error on X_RAMB8BWER : %m at simulation time %.3f ns.\nA read was performed on address %h (hex) of port B while a write was requested to the same address on port A. The write will be successful however the read value on port B is unknown until the next CLKBRDCLK cycle.", $time/1000.0, addrbrdaddr_tmp);
		    col_wra_rdb_msg = 0;
		end
	    
		else if (weawel_tmp === 1'b0 && webweu_tmp === 1'b1 && col_wrb_rda_msg == 1) begin

		    if ((wr_mode_a == 2'b01 || wr_mode_b == 2'b01) && viol_time == 2)
			$display("Memory Collision Error on X_RAMB8BWER : %m at simulation time %.3f ns.\nA read was performed on address %h (hex) of port A while a write was requested to the same address on port B. The write will be unsuccessful and the content of the RAM at address location %h (hex) of port B became unknown.", $time/1000.0, addrawraddr_tmp, addrbrdaddr_tmp);
		    else
		    	$display("Memory Collision Error on X_RAMB8BWER : %m at simulation time %.3f ns.\nA read was performed on address %h (hex) of port A while a write was requested to the same address on port B. The write will be successful however the read value on port A is unknown until the next CLKAWRCLK cycle.", $time/1000.0, addrawraddr_tmp);
		    col_wrb_rda_msg = 0;
		end
	    
	end

    endtask // chk_for_col_msg
//*** Timing Checks Start here

    reg notifier, notifier_a, notifier_b;
    reg notifier_addra0, notifier_addra1, notifier_addra2, notifier_addra3, notifier_addra4;
    reg notifier_addra5, notifier_addra6, notifier_addra7, notifier_addra8, notifier_addra9;
    reg notifier_addra10, notifier_addra11, notifier_addra12;
    reg notifier_addrb0, notifier_addrb1, notifier_addrb2, notifier_addrb3, notifier_addrb4;
    reg notifier_addrb5, notifier_addrb6, notifier_addrb7, notifier_addrb8, notifier_addrb9;
    reg notifier_addrb10, notifier_addrb11, notifier_addrb12;

    wire diadi0_enable = ENAWREN && WEAWEL[0];
    wire diadi1_enable = ENAWREN && WEAWEL[1];
    
    wire sdp_dib0_clkwr = (ram_mode_int == 1) && ENAWREN && WEBWEU[0];
    wire sdp_dib1_clkwr = (ram_mode_int == 1) && ENAWREN && WEBWEU[1];
    
    wire dibdi0_enable = (ram_mode_int == 0) && ENBRDEN && WEBWEU[0];
    wire dibdi1_enable = (ram_mode_int == 0) && ENBRDEN && WEBWEU[1];

    wire sdp_webweu_clkwr = (ram_mode_int == 1) && ENAWREN;
    
    
    always @(notifier or notifier_a or notifier_addra0 or notifier_addra1 or notifier_addra2 or notifier_addra3 or notifier_addra4 or
             notifier_addra5 or notifier_addra6 or notifier_addra7 or notifier_addra8 or notifier_addra9 or notifier_addra10 or 
             notifier_addra11 or notifier_addra12) begin    
	doado_out_out <= 32'hxxxxxxxx;
	dopadop_out_out <= 4'hx;
    end

    always @(notifier or notifier_b or notifier_addrb0 or notifier_addrb1 or notifier_addrb2 or notifier_addrb3 or notifier_addrb4 or
             notifier_addrb5 or notifier_addrb6 or notifier_addrb7 or notifier_addrb8 or notifier_addrb9 or notifier_addrb10 or 
             notifier_addrb11 or notifier_addrb12) begin
	dobdo_out_out <= 32'hxxxxxxxx;
	dopbdop_out_out <= 4'hx;
    end


    always @(notifier_addra0) begin
	task_warn_msg ("ADDRAWRADDR[0]", "CLKAWRCLK");
    end

    always @(notifier_addra1) begin
	task_warn_msg ("ADDRAWRADDR[1]", "CLKAWRCLK");
    end
    
    always @(notifier_addra2) begin
	task_warn_msg ("ADDRAWRADDR[2]", "CLKAWRCLK");
    end
    
    always @(notifier_addra3) begin
	task_warn_msg ("ADDRAWRADDR[3]", "CLKAWRCLK");
    end
    
    always @(notifier_addra4) begin
	task_warn_msg ("ADDRAWRADDR[4]", "CLKAWRCLK");
    end

    always @(notifier_addra5) begin
	task_warn_msg ("ADDRAWRADDR[5]", "CLKAWRCLK");
    end
    
    always @(notifier_addra6) begin
	task_warn_msg ("ADDRAWRADDR[6]", "CLKAWRCLK");
    end
    
    always @(notifier_addra7) begin
	task_warn_msg ("ADDRAWRADDR[7]", "CLKAWRCLK");
    end   

    always @(notifier_addra8) begin
	task_warn_msg ("ADDRAWRADDR[8]", "CLKAWRCLK");
    end

    always @(notifier_addra9) begin
	task_warn_msg ("ADDRAWRADDR[9]", "CLKAWRCLK");
    end
    
    always @(notifier_addra10) begin
	task_warn_msg ("ADDRAWRADDR[10]", "CLKAWRCLK");
    end
    
    always @(notifier_addra11) begin
	task_warn_msg ("ADDRAWRADDR[11]", "CLKAWRCLK");
    end
    
     always @(notifier_addra12) begin
	task_warn_msg ("ADDRAWRADDR[12]", "CLKAWRCLK");
    end


    always @(notifier_addrb0) begin
	task_warn_msg ("ADDRBRDADDR[0]", "CLKBRDCLK");
    end

    always @(notifier_addrb1) begin
	task_warn_msg ("ADDRBRDADDR[1]", "CLKBRDCLK");
    end
    
    always @(notifier_addrb2) begin
	task_warn_msg ("ADDRBRDADDR[2]", "CLKBRDCLK");
    end
    
    always @(notifier_addrb3) begin
	task_warn_msg ("ADDRBRDADDR[3]", "CLKBRDCLK");
    end
    
    always @(notifier_addrb4) begin
	task_warn_msg ("ADDRBRDADDR[4]", "CLKBRDCLK");
    end

    always @(notifier_addrb5) begin
	task_warn_msg ("ADDRBRDADDR[5]", "CLKBRDCLK");
    end
    
    always @(notifier_addrb6) begin
	task_warn_msg ("ADDRBRDADDR[6]", "CLKBRDCLK");
    end
    
    always @(notifier_addrb7) begin
	task_warn_msg ("ADDRBRDADDR[7]", "CLKBRDCLK");
    end   

    always @(notifier_addrb8) begin
	task_warn_msg ("ADDRBRDADDR[8]", "CLKBRDCLK");
    end

    always @(notifier_addrb9) begin
	task_warn_msg ("ADDRBRDADDR[9]", "CLKBRDCLK");
    end
    
    always @(notifier_addrb10) begin
	task_warn_msg ("ADDRBRDADDR[10]", "CLKBRDCLK");
    end
    
    always @(notifier_addrb11) begin
	task_warn_msg ("ADDRBRDADDR[11]", "CLKBRDCLK");
    end
    
     always @(notifier_addrb12) begin
	task_warn_msg ("ADDRBRDADDR[12]", "CLKBRDCLK");
    end

    
    task task_warn_msg;

        input [8*15:1] addr_str;
	input [8*9:1] clk_str;
	
	begin

	    $display("Error: Setup/Hold Violation on %s with respect to %s when memory has been enabled. The memory contents at %s of the RAM can be corrupted. This corruption is not modeled in this simulation model. Please take the necessary steps to recover from this data corruption in hardware.", addr_str, clk_str, addr_str);

	end
	
    endtask // task_warn_msg

    
    specify

        (CLKBRDCLK => DOBDO[0]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[1]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[2]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[3]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[4]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[5]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[6]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[7]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[8]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[9]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[10]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[11]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[12]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[13]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[14]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOBDO[15]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOPBDOP[0]) = (100:100:100, 100:100:100);
        (CLKBRDCLK => DOPBDOP[1]) = (100:100:100, 100:100:100);
       	if (ram_mode_int == 1) (CLKBRDCLK => DOADO[0]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[1]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[2]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[3]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[4]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[5]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[6]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[7]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[8]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[9]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[10]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[11]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[12]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[13]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[14]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOADO[15]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOPADOP[0]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 1) (CLKBRDCLK => DOPADOP[1]) = (100:100:100, 100:100:100);

	if (ram_mode_int == 0) (CLKAWRCLK => DOADO[0]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[1]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[2]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[3]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[4]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[5]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[6]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[7]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[8]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[9]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[10]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[11]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[12]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[13]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[14]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOADO[15]) = (100:100:100, 100:100:100);
	if (ram_mode_int == 0) (CLKAWRCLK => DOPADOP[0]) = (100:100:100, 100:100:100);
        if (ram_mode_int == 0) (CLKAWRCLK => DOPADOP[1]) = (100:100:100, 100:100:100);

        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[0]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[10]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[11]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[12]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[13]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[14]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[15]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[1]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[2]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[3]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[4]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[5]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[6]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[7]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[8]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOADO[9]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOPADOP[0]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 0) (RSTA => DOPADOP[1]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[0]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[10]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[11]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[12]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[13]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[14]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[15]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[1]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[2]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[3]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[4]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[5]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[6]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[7]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[8]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOADO[9]) = (0:0:0, 0:0:0);
	if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOPADOP[0]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1 && ram_mode_int == 1) (RSTBRST => DOPADOP[1]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[0]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[10]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[11]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[12]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[13]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[14]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[15]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[1]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[2]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[3]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[4]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[5]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[6]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[7]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[8]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOBDO[9]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOPBDOP[0]) = (0:0:0, 0:0:0);
        if (rsttype_int == 1) (RSTBRST => DOPBDOP[1]) = (0:0:0, 0:0:0);


	
	$setuphold (posedge CLKBRDCLK, posedge ADDRBRDADDR[0] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb0);
       	$setuphold (posedge CLKBRDCLK, negedge ADDRBRDADDR[0] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb0);
       	$setuphold (posedge CLKBRDCLK, posedge ADDRBRDADDR[1] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb1);
       	$setuphold (posedge CLKBRDCLK, negedge ADDRBRDADDR[1] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb1);
       	$setuphold (posedge CLKBRDCLK, posedge ADDRBRDADDR[2] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb2);
       	$setuphold (posedge CLKBRDCLK, negedge ADDRBRDADDR[2] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb2);
       	$setuphold (posedge CLKBRDCLK, posedge ADDRBRDADDR[3] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb3);
       	$setuphold (posedge CLKBRDCLK, negedge ADDRBRDADDR[3] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb3);
       	$setuphold (posedge CLKBRDCLK, posedge ADDRBRDADDR[4] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb4);
       	$setuphold (posedge CLKBRDCLK, negedge ADDRBRDADDR[4] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb4);
       	$setuphold (posedge CLKBRDCLK, posedge ADDRBRDADDR[5] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb5);
       	$setuphold (posedge CLKBRDCLK, negedge ADDRBRDADDR[5] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb5);
       	$setuphold (posedge CLKBRDCLK, posedge ADDRBRDADDR[6] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb6);
       	$setuphold (posedge CLKBRDCLK, negedge ADDRBRDADDR[6] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb6);
       	$setuphold (posedge CLKBRDCLK, posedge ADDRBRDADDR[7] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb7);
       	$setuphold (posedge CLKBRDCLK, negedge ADDRBRDADDR[7] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb7);
       	$setuphold (posedge CLKBRDCLK, posedge ADDRBRDADDR[8] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb8);
       	$setuphold (posedge CLKBRDCLK, negedge ADDRBRDADDR[8] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb8);
       	$setuphold (posedge CLKBRDCLK, posedge ADDRBRDADDR[9] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb9);
       	$setuphold (posedge CLKBRDCLK, negedge ADDRBRDADDR[9] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb9);
       	$setuphold (posedge CLKBRDCLK, posedge ADDRBRDADDR[10] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb10);
       	$setuphold (posedge CLKBRDCLK, negedge ADDRBRDADDR[10] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb10);
       	$setuphold (posedge CLKBRDCLK, posedge ADDRBRDADDR[11] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb11);
       	$setuphold (posedge CLKBRDCLK, negedge ADDRBRDADDR[11] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb11);
       	$setuphold (posedge CLKBRDCLK, posedge ADDRBRDADDR[12] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb12);
       	$setuphold (posedge CLKBRDCLK, negedge ADDRBRDADDR[12] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_addrb12);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[0] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[0] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[1] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[1] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[2] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[2] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[3] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[3] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[4] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[4] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[5] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[5] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[6] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[6] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[7] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[7] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[8] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[8] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[9] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[9] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[10] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[10] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[11] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[11] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[12] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[12] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[13] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[13] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[14] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[14] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIBDI[15] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIBDI[15] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIPBDIP[0] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIPBDIP[0] &&& dibdi0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge DIPBDIP[1] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge DIPBDIP[1] &&& dibdi1_enable, 0:0:0, 0:0:0, notifier_b);
	$setuphold (posedge CLKBRDCLK, posedge ENBRDEN, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge ENBRDEN, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge RSTBRST &&& ENBRDEN, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge RSTBRST &&& ENBRDEN, 0:0:0, 0:0:0, notifier_b);
	$setuphold (posedge CLKBRDCLK, posedge REGCEBREGCE, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge REGCEBREGCE, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge WEBWEU[0] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge WEBWEU[0] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, posedge WEBWEU[1] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBRDCLK, negedge WEBWEU[1] &&& ENBRDEN, 0:0:0, 0:0:0, notifier_b);
	
	$setuphold (posedge CLKAWRCLK, posedge ADDRAWRADDR[0] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra0);
       	$setuphold (posedge CLKAWRCLK, negedge ADDRAWRADDR[0] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra0);
       	$setuphold (posedge CLKAWRCLK, posedge ADDRAWRADDR[1] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra1);
       	$setuphold (posedge CLKAWRCLK, negedge ADDRAWRADDR[1] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra1);
       	$setuphold (posedge CLKAWRCLK, posedge ADDRAWRADDR[2] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra2);
       	$setuphold (posedge CLKAWRCLK, negedge ADDRAWRADDR[2] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra2);
       	$setuphold (posedge CLKAWRCLK, posedge ADDRAWRADDR[3] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra3);
       	$setuphold (posedge CLKAWRCLK, negedge ADDRAWRADDR[3] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra3);
       	$setuphold (posedge CLKAWRCLK, posedge ADDRAWRADDR[4] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra4);
       	$setuphold (posedge CLKAWRCLK, negedge ADDRAWRADDR[4] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra4);
       	$setuphold (posedge CLKAWRCLK, posedge ADDRAWRADDR[5] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra5);
       	$setuphold (posedge CLKAWRCLK, negedge ADDRAWRADDR[5] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra5);
       	$setuphold (posedge CLKAWRCLK, posedge ADDRAWRADDR[6] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra6);
       	$setuphold (posedge CLKAWRCLK, negedge ADDRAWRADDR[6] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra6);
       	$setuphold (posedge CLKAWRCLK, posedge ADDRAWRADDR[7] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra7);
       	$setuphold (posedge CLKAWRCLK, negedge ADDRAWRADDR[7] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra7);
       	$setuphold (posedge CLKAWRCLK, posedge ADDRAWRADDR[8] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra8);
       	$setuphold (posedge CLKAWRCLK, negedge ADDRAWRADDR[8] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra8);
       	$setuphold (posedge CLKAWRCLK, posedge ADDRAWRADDR[9] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra9);
       	$setuphold (posedge CLKAWRCLK, negedge ADDRAWRADDR[9] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra9);
       	$setuphold (posedge CLKAWRCLK, posedge ADDRAWRADDR[10] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra10);
       	$setuphold (posedge CLKAWRCLK, negedge ADDRAWRADDR[10] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra10);
       	$setuphold (posedge CLKAWRCLK, posedge ADDRAWRADDR[11] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra11);
       	$setuphold (posedge CLKAWRCLK, negedge ADDRAWRADDR[11] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra11);
       	$setuphold (posedge CLKAWRCLK, posedge ADDRAWRADDR[12] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra12);
       	$setuphold (posedge CLKAWRCLK, negedge ADDRAWRADDR[12] &&& ENAWREN, 0:0:0, 0:0:0, notifier_addra12);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[0] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[0] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[1] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[1] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[2] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[2] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[3] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[3] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[4] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[4] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[5] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[5] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[6] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[6] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[7] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[7] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[8] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[8] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[9] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[9] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[10] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[10] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[11] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[11] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[12] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[12] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[13] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[13] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[14] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[14] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIBDI[15] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIBDI[15] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIPBDIP[0] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIPBDIP[0] &&& sdp_dib0_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIPBDIP[1] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIPBDIP[1] &&& sdp_dib1_clkwr, 0:0:0, 0:0:0, notifier_a);
	$setuphold (posedge CLKAWRCLK, posedge DIADI[0] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
	$setuphold (posedge CLKAWRCLK, negedge DIADI[0] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[1] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[1] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[2] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[2] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[3] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[3] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[4] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[4] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[5] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[5] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[6] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[6] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[7] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[7] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[8] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[8] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[9] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[9] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[10] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[10] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[11] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[11] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[12] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[12] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[13] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[13] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[14] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[14] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIADI[15] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIADI[15] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
	$setuphold (posedge CLKAWRCLK, posedge DIPADIP[0] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIPADIP[0] &&& diadi0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge DIPADIP[1] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge DIPADIP[1] &&& diadi1_enable, 0:0:0, 0:0:0, notifier_a);
	$setuphold (posedge CLKAWRCLK, posedge ENAWREN, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge ENAWREN, 0:0:0, 0:0:0, notifier_a);
	$setuphold (posedge CLKAWRCLK, posedge REGCEA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge REGCEA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge RSTA &&& ENAWREN, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge RSTA &&& ENAWREN, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge WEAWEL[0] &&& ENAWREN, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge WEAWEL[0] &&& ENAWREN, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge WEAWEL[1] &&& ENAWREN, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge WEAWEL[1] &&& ENAWREN, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge WEBWEU[0] &&& sdp_webweu_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge WEBWEU[0] &&& sdp_webweu_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, posedge WEBWEU[1] &&& sdp_webweu_clkwr, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAWRCLK, negedge WEBWEU[1] &&& sdp_webweu_clkwr, 0:0:0, 0:0:0, notifier_a);

	$recrem (negedge RSTA, posedge CLKAWRCLK, 0:0:0, 0:0:0, notifier_a);
	$recrem (negedge RSTBRST, posedge CLKBRDCLK, 0:0:0, 0:0:0, notifier_b);
	
	$period (posedge CLKBRDCLK, 0:0:0, notifier_b);
	$period (posedge CLKAWRCLK, 0:0:0, notifier_a);
	$width (posedge CLKBRDCLK &&& ENBRDEN, 0:0:0, 0, notifier_b);
        $width (negedge CLKBRDCLK &&& ENBRDEN, 0:0:0, 0, notifier_b);
        $width (posedge CLKAWRCLK &&& ENAWREN, 0:0:0, 0, notifier_a);
        $width (negedge CLKAWRCLK &&& ENAWREN, 0:0:0, 0, notifier_a);
	
	specparam PATHPULSE$ = 0;

    endspecify

    
endmodule // X_RAMB8BWER

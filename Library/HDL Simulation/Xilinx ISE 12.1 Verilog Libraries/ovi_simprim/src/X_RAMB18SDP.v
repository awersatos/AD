// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/rainier/X_RAMB18SDP.v,v 1.19 2008/01/04 01:15:11 wloo Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.23)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  16K-Bit Data and 2K-Bit Parity Block RAM
// /___/   /\     Filename : X_RAMB18SDP.v
// \   \  /  \    Timestamp : Tues July 26 16:43:59 PST 2005
//  \___\/\___\
//
// Revision:
//    07/26/05 - Initial version.
//    12/06/06 - Added setup/hold checks for REGCE (CR 429753).
//    12/07/06 - Fixed data output (CR 426370).
//    01/04/07 - Added support of memory file to initialize memory and parity (CR 431584).
//    03/14/07 - Removed attribute INITP_FILE (CR 436003).
//    04/03/07 - Changed INIT_FILE = "NONE" as default (CR 436812).
//    06/01/07 - Added wire declaration for internal signals.    
//    08/17/07 - Added setup/hold violation message on address w.r.t. clock (CR 436931).
//    01/03/08 - Fixed problem introduced by CR 436931 (CR 455893).
// End Revision

`timescale 1 ps/1 ps

module X_RAMB18SDP (DO, DOP, 
		    DI, DIP, RDADDR, RDCLK, RDEN, REGCE, SSR, WE, WRADDR, WRCLK, WREN);

    output [31:0] DO;
    output [3:0] DOP;

    input RDCLK;
    input RDEN;
    input REGCE;
    input SSR;
    input WRCLK;
    input WREN;
    input [8:0] WRADDR;
    input [8:0] RDADDR;
    input [31:0] DI;
    input [3:0] DIP;
    input [3:0] WE;

    parameter integer DO_REG = 0;
    parameter INIT = 36'h0;
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
    parameter INIT_FILE = "NONE";
    parameter LOC = "UNPLACED";
    parameter SETUP_ALL = 1000;
    parameter SETUP_READ_FIRST = 3000;
    parameter SIM_COLLISION_CHECK = "ALL";
    parameter SRVAL = 36'h0;

    tri0 GSR = glbl.GSR;

    wire [7:0] dangle_out8;
    wire dangle_out;
    wire [3:0] dangle_out4, dip_in;
    wire [31:0] dangle_out32, di_in, do_wire;
    wire [3:0] we_in, dop_wire;
    wire [8:0] rdaddr_in, wraddr_in;
    wire rdclk_in, wrclk_in, rden_in, wren_in;
    wire regce_in, ssr_in;
      
    reg notifier;
    reg notifier_addr0, notifier_addr1, notifier_addr2, notifier_addr3, notifier_addr4;
    reg notifier_addr5, notifier_addr6, notifier_addr7, notifier_addr8;

    reg [31:0] do_out;
    reg [3:0] dop_out;


    buf b_rdaddr[8:0] (rdaddr_in, RDADDR);
    buf b_wraddr[8:0] (wraddr_in, WRADDR);
    buf b_rdclk (rdclk_in, RDCLK);
    buf b_wrclk (wrclk_in, WRCLK);
    
    buf b_di[31:0] (di_in, DI);
    buf b_dip[3:0] (dip_in, DIP);
    buf b_do[31:0] (DO, do_out);
    buf b_dop[3:0] (DOP, dop_out);

    buf b_rden (rden_in, RDEN);
    buf b_wren (wren_in, WREN);
    buf b_regce (regce_in, REGCE);
    buf b_ssr (ssr_in, SSR);
    buf b_we[3:0] (we_in, WE);

    always @(do_wire or rdclk_in) do_out = do_wire;
    always @(dop_wire or rdclk_in) dop_out = dop_wire;
    
    X_ARAMB36_INTERNAL INT_RAMB (.DIA(64'b0), .ENA(rden_in), .WEA(8'b0), .SSRA(ssr_in), .ADDRA({2'b0, rdaddr_in, 5'b0}), .CLKA(rdclk_in), .DOA({dangle_out32,do_wire}), .DIB({32'b0,di_in}), .ENB(wren_in), .WEB({2{we_in}}), .SSRB(1'b0), .ADDRB({2'b0, wraddr_in, 5'b0}), .CLKB(wrclk_in), .DOB(dangle_out32), .GSR(GSR), .DOPA({dangle_out4,dop_wire}), .DOPB(dangle_out4), .DIPA(4'b0), .DIPB({4'b0,dip_in}), .CASCADEOUTLATA(dangle_out), .CASCADEOUTLATB(dangle_out), .CASCADEOUTREGA(dangle_out), .CASCADEOUTREGB(dangle_out), .CASCADEINLATA(1'b0), .CASCADEINLATB(1'b0), .CASCADEINREGA(1'b0), .CASCADEINREGB(1'b0), .REGCEA(regce_in), .REGCEB(1'b0), .REGCLKA(rdclk_in), .REGCLKB(wrclk_in), .DBITERR(dangle_out), .ECCPARITY(dangle_out8), .SBITERR(dangle_out));

    defparam INT_RAMB.BRAM_MODE = "SIMPLE_DUAL_PORT";
    defparam INT_RAMB.BRAM_SIZE = 18;
    defparam INT_RAMB.INIT_A = INIT;
    defparam INT_RAMB.INIT_B = INIT;
    defparam INT_RAMB.INIT_FILE = INIT_FILE;
    defparam INT_RAMB.SRVAL_A = SRVAL;
    defparam INT_RAMB.SRVAL_B = SRVAL;
    defparam INT_RAMB.READ_WIDTH_A = 36;
    defparam INT_RAMB.READ_WIDTH_B = 36;
    defparam INT_RAMB.WRITE_WIDTH_A = 36;
    defparam INT_RAMB.WRITE_WIDTH_B = 36;
    defparam INT_RAMB.WRITE_MODE_A = "READ_FIRST";
    defparam INT_RAMB.WRITE_MODE_B = "READ_FIRST";
    defparam INT_RAMB.SETUP_ALL = SETUP_ALL;
    defparam INT_RAMB.SETUP_READ_FIRST = SETUP_READ_FIRST;
    defparam INT_RAMB.SIM_COLLISION_CHECK = SIM_COLLISION_CHECK;
    defparam INT_RAMB.DOA_REG = DO_REG;
    defparam INT_RAMB.DOB_REG = DO_REG;
    defparam INT_RAMB.INIT_00 = INIT_00;
    defparam INT_RAMB.INIT_01 = INIT_01;
    defparam INT_RAMB.INIT_02 = INIT_02;
    defparam INT_RAMB.INIT_03 = INIT_03;
    defparam INT_RAMB.INIT_04 = INIT_04;
    defparam INT_RAMB.INIT_05 = INIT_05;
    defparam INT_RAMB.INIT_06 = INIT_06;
    defparam INT_RAMB.INIT_07 = INIT_07;
    defparam INT_RAMB.INIT_08 = INIT_08;
    defparam INT_RAMB.INIT_09 = INIT_09;
    defparam INT_RAMB.INIT_0A = INIT_0A;
    defparam INT_RAMB.INIT_0B = INIT_0B;
    defparam INT_RAMB.INIT_0C = INIT_0C;
    defparam INT_RAMB.INIT_0D = INIT_0D;
    defparam INT_RAMB.INIT_0E = INIT_0E;
    defparam INT_RAMB.INIT_0F = INIT_0F;
    defparam INT_RAMB.INIT_10 = INIT_10;
    defparam INT_RAMB.INIT_11 = INIT_11;
    defparam INT_RAMB.INIT_12 = INIT_12;
    defparam INT_RAMB.INIT_13 = INIT_13;
    defparam INT_RAMB.INIT_14 = INIT_14;
    defparam INT_RAMB.INIT_15 = INIT_15;
    defparam INT_RAMB.INIT_16 = INIT_16;
    defparam INT_RAMB.INIT_17 = INIT_17;
    defparam INT_RAMB.INIT_18 = INIT_18;
    defparam INT_RAMB.INIT_19 = INIT_19;
    defparam INT_RAMB.INIT_1A = INIT_1A;
    defparam INT_RAMB.INIT_1B = INIT_1B;
    defparam INT_RAMB.INIT_1C = INIT_1C;
    defparam INT_RAMB.INIT_1D = INIT_1D;
    defparam INT_RAMB.INIT_1E = INIT_1E;
    defparam INT_RAMB.INIT_1F = INIT_1F;
    defparam INT_RAMB.INIT_20 = INIT_20;
    defparam INT_RAMB.INIT_21 = INIT_21;
    defparam INT_RAMB.INIT_22 = INIT_22;
    defparam INT_RAMB.INIT_23 = INIT_23;
    defparam INT_RAMB.INIT_24 = INIT_24;
    defparam INT_RAMB.INIT_25 = INIT_25;
    defparam INT_RAMB.INIT_26 = INIT_26;
    defparam INT_RAMB.INIT_27 = INIT_27;
    defparam INT_RAMB.INIT_28 = INIT_28;
    defparam INT_RAMB.INIT_29 = INIT_29;
    defparam INT_RAMB.INIT_2A = INIT_2A;
    defparam INT_RAMB.INIT_2B = INIT_2B;
    defparam INT_RAMB.INIT_2C = INIT_2C;
    defparam INT_RAMB.INIT_2D = INIT_2D;
    defparam INT_RAMB.INIT_2E = INIT_2E;
    defparam INT_RAMB.INIT_2F = INIT_2F;
    defparam INT_RAMB.INIT_30 = INIT_30;
    defparam INT_RAMB.INIT_31 = INIT_31;
    defparam INT_RAMB.INIT_32 = INIT_32;
    defparam INT_RAMB.INIT_33 = INIT_33;
    defparam INT_RAMB.INIT_34 = INIT_34;
    defparam INT_RAMB.INIT_35 = INIT_35;
    defparam INT_RAMB.INIT_36 = INIT_36;
    defparam INT_RAMB.INIT_37 = INIT_37;
    defparam INT_RAMB.INIT_38 = INIT_38;
    defparam INT_RAMB.INIT_39 = INIT_39;
    defparam INT_RAMB.INIT_3A = INIT_3A;
    defparam INT_RAMB.INIT_3B = INIT_3B;
    defparam INT_RAMB.INIT_3C = INIT_3C;
    defparam INT_RAMB.INIT_3D = INIT_3D;
    defparam INT_RAMB.INIT_3E = INIT_3E;
    defparam INT_RAMB.INIT_3F = INIT_3F;
    defparam INT_RAMB.INITP_00 = INITP_00;
    defparam INT_RAMB.INITP_01 = INITP_01;
    defparam INT_RAMB.INITP_02 = INITP_02;
    defparam INT_RAMB.INITP_03 = INITP_03;
    defparam INT_RAMB.INITP_04 = INITP_04;
    defparam INT_RAMB.INITP_05 = INITP_05;
    defparam INT_RAMB.INITP_06 = INITP_06;
    defparam INT_RAMB.INITP_07 = INITP_07;

    //*** Timing Checks Start here
    wire di0_enable = wren_in && we_in[0];
    wire di1_enable = wren_in && we_in[1];
    wire di2_enable = wren_in && we_in[2];
    wire di3_enable = wren_in && we_in[3];
    
    always @(notifier or notifier_addr0 or notifier_addr1 or notifier_addr2 or notifier_addr3 or notifier_addr4 or
             notifier_addr5 or notifier_addr6 or notifier_addr7 or notifier_addr8) begin
	do_out <= 32'hxxxxxxxx;
	dop_out <= 4'hx;
    end


    always @(notifier_addr0) begin
	task_warn_msg ("WRADDR[0]", "WRCLK");
    end

    always @(notifier_addr1) begin
	task_warn_msg ("WRADDR[1]", "WRCLK");
    end
    
    always @(notifier_addr2) begin
	task_warn_msg ("WRADDR[2]", "WRCLK");
    end
    
    always @(notifier_addr3) begin
	task_warn_msg ("WRADDR[3]", "WRCLK");
    end
    
    always @(notifier_addr4) begin
	task_warn_msg ("WRADDR[4]", "WRCLK");
    end

    always @(notifier_addr5) begin
	task_warn_msg ("WRADDR[5]", "WRCLK");
    end
    
    always @(notifier_addr6) begin
	task_warn_msg ("WRADDR[6]", "WRCLK");
    end
    
    always @(notifier_addr7) begin
	task_warn_msg ("WRADDR[7]", "WRCLK");
    end   

    always @(notifier_addr8) begin
	task_warn_msg ("WRADDR[8]", "WRCLK");
    end

    
    task task_warn_msg;

        input [8*9:1] addr_str;
	input [8*5:1] clk_str;
	
	begin

	    $display("Error: Setup/Hold Violation on %s with respect to %s when memory has been enabled. The memory contents at %s of the RAM can be corrupted. This corruption is not modeled in this simulation model. Please take the necessary steps to recover from this data corruption in hardware.", addr_str, clk_str, addr_str);

	end
	
    endtask // task_warn_msg

    
    specify

        (RDCLK => DO[0]) = (100:100:100, 100:100:100);
        (RDCLK => DO[1]) = (100:100:100, 100:100:100);
        (RDCLK => DO[2]) = (100:100:100, 100:100:100);
        (RDCLK => DO[3]) = (100:100:100, 100:100:100);
        (RDCLK => DO[4]) = (100:100:100, 100:100:100);
        (RDCLK => DO[5]) = (100:100:100, 100:100:100);
        (RDCLK => DO[6]) = (100:100:100, 100:100:100);
        (RDCLK => DO[7]) = (100:100:100, 100:100:100);
        (RDCLK => DO[8]) = (100:100:100, 100:100:100);
        (RDCLK => DO[9]) = (100:100:100, 100:100:100);
        (RDCLK => DO[10]) = (100:100:100, 100:100:100);
        (RDCLK => DO[11]) = (100:100:100, 100:100:100);
        (RDCLK => DO[12]) = (100:100:100, 100:100:100);
        (RDCLK => DO[13]) = (100:100:100, 100:100:100);
        (RDCLK => DO[14]) = (100:100:100, 100:100:100);
        (RDCLK => DO[15]) = (100:100:100, 100:100:100);
        (RDCLK => DO[16]) = (100:100:100, 100:100:100);
        (RDCLK => DO[17]) = (100:100:100, 100:100:100);
        (RDCLK => DO[18]) = (100:100:100, 100:100:100);
        (RDCLK => DO[19]) = (100:100:100, 100:100:100);
        (RDCLK => DO[20]) = (100:100:100, 100:100:100);
        (RDCLK => DO[21]) = (100:100:100, 100:100:100);
        (RDCLK => DO[22]) = (100:100:100, 100:100:100);
        (RDCLK => DO[23]) = (100:100:100, 100:100:100);
        (RDCLK => DO[24]) = (100:100:100, 100:100:100);
        (RDCLK => DO[25]) = (100:100:100, 100:100:100);
        (RDCLK => DO[26]) = (100:100:100, 100:100:100);
        (RDCLK => DO[27]) = (100:100:100, 100:100:100);
        (RDCLK => DO[28]) = (100:100:100, 100:100:100);
        (RDCLK => DO[29]) = (100:100:100, 100:100:100);
        (RDCLK => DO[30]) = (100:100:100, 100:100:100);
        (RDCLK => DO[31]) = (100:100:100, 100:100:100);
        (RDCLK => DOP[0]) = (100:100:100, 100:100:100);
        (RDCLK => DOP[1]) = (100:100:100, 100:100:100);
        (RDCLK => DOP[2]) = (100:100:100, 100:100:100);
        (RDCLK => DOP[3]) = (100:100:100, 100:100:100);

       	$setuphold (posedge WRCLK, posedge WRADDR[0] &&& WREN, 0:0:0, 0:0:0, notifier_addr0);
       	$setuphold (posedge WRCLK, negedge WRADDR[0] &&& WREN, 0:0:0, 0:0:0, notifier_addr0);
       	$setuphold (posedge WRCLK, posedge WRADDR[1] &&& WREN, 0:0:0, 0:0:0, notifier_addr1);
       	$setuphold (posedge WRCLK, negedge WRADDR[1] &&& WREN, 0:0:0, 0:0:0, notifier_addr1);
       	$setuphold (posedge WRCLK, posedge WRADDR[2] &&& WREN, 0:0:0, 0:0:0, notifier_addr2);
       	$setuphold (posedge WRCLK, negedge WRADDR[2] &&& WREN, 0:0:0, 0:0:0, notifier_addr2);
       	$setuphold (posedge WRCLK, posedge WRADDR[3] &&& WREN, 0:0:0, 0:0:0, notifier_addr3);
       	$setuphold (posedge WRCLK, negedge WRADDR[3] &&& WREN, 0:0:0, 0:0:0, notifier_addr3);
       	$setuphold (posedge WRCLK, posedge WRADDR[4] &&& WREN, 0:0:0, 0:0:0, notifier_addr4);
       	$setuphold (posedge WRCLK, negedge WRADDR[4] &&& WREN, 0:0:0, 0:0:0, notifier_addr4);
       	$setuphold (posedge WRCLK, posedge WRADDR[5] &&& WREN, 0:0:0, 0:0:0, notifier_addr5);
       	$setuphold (posedge WRCLK, negedge WRADDR[5] &&& WREN, 0:0:0, 0:0:0, notifier_addr5);
       	$setuphold (posedge WRCLK, posedge WRADDR[6] &&& WREN, 0:0:0, 0:0:0, notifier_addr6);
       	$setuphold (posedge WRCLK, negedge WRADDR[6] &&& WREN, 0:0:0, 0:0:0, notifier_addr6);
       	$setuphold (posedge WRCLK, posedge WRADDR[7] &&& WREN, 0:0:0, 0:0:0, notifier_addr7);
       	$setuphold (posedge WRCLK, negedge WRADDR[7] &&& WREN, 0:0:0, 0:0:0, notifier_addr7);
       	$setuphold (posedge WRCLK, posedge WRADDR[8] &&& WREN, 0:0:0, 0:0:0, notifier_addr8);
       	$setuphold (posedge WRCLK, negedge WRADDR[8] &&& WREN, 0:0:0, 0:0:0, notifier_addr8);
	
	$setuphold (posedge RDCLK, posedge RDADDR[0] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, negedge RDADDR[0] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, posedge RDADDR[1] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, negedge RDADDR[1] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, posedge RDADDR[2] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, negedge RDADDR[2] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, posedge RDADDR[3] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, negedge RDADDR[3] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, posedge RDADDR[4] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, negedge RDADDR[4] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, posedge RDADDR[5] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, negedge RDADDR[5] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, posedge RDADDR[6] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, negedge RDADDR[6] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, posedge RDADDR[7] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, negedge RDADDR[7] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, posedge RDADDR[8] &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, negedge RDADDR[8] &&& RDEN, 0:0:0, 0:0:0, notifier);
	
       	$setuphold (posedge WRCLK, posedge DI[0] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[0] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[1] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[1] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[2] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[2] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[3] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[3] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[4] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[4] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[5] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[5] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[6] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[6] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[7] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[7] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[8] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[8] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[9] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[9] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[10] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[10] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[11] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[11] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[12] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[12] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[13] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[13] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[14] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[14] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[15] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[15] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[16] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[16] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[17] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[17] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[18] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[18] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[19] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[19] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[20] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[20] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[21] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[21] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[22] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[22] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[23] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[23] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[24] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[24] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[25] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[25] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[26] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[26] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[27] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[27] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[28] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[28] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[29] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[29] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[30] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[30] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DI[31] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DI[31] &&& di3_enable, 0:0:0, 0:0:0, notifier);

       	$setuphold (posedge WRCLK, posedge DIP[0] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DIP[0] &&& di0_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DIP[1] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DIP[1] &&& di1_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DIP[2] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DIP[2] &&& di2_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge DIP[3] &&& di3_enable, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge DIP[3] &&& di3_enable, 0:0:0, 0:0:0, notifier);
	
       	$setuphold (posedge WRCLK, posedge WREN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge WREN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge SSR &&& WREN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge SSR &&& WREN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, posedge RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, negedge RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, posedge SSR &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, negedge SSR &&& RDEN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, posedge REGCE, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge RDCLK, negedge REGCE, 0:0:0, 0:0:0, notifier);
	
       	$setuphold (posedge WRCLK, posedge WE[0] &&& WREN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge WE[0] &&& WREN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge WE[1] &&& WREN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge WE[1] &&& WREN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge WE[2] &&& WREN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge WE[2] &&& WREN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, posedge WE[3] &&& WREN, 0:0:0, 0:0:0, notifier);
       	$setuphold (posedge WRCLK, negedge WE[3] &&& WREN, 0:0:0, 0:0:0, notifier);

	$period (posedge WRCLK, 0:0:0, notifier);
	$period (posedge RDCLK, 0:0:0, notifier);

        $width (posedge RDCLK &&& RDEN, 0:0:0, 0, notifier);
        $width (negedge RDCLK &&& RDEN, 0:0:0, 0, notifier);
        $width (posedge WRCLK &&& WREN, 0:0:0, 0, notifier);
        $width (negedge WRCLK &&& WREN, 0:0:0, 0, notifier);

	specparam PATHPULSE$ = 0;

    endspecify

endmodule // X_RAMB18SDP

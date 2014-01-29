// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/rainier/X_RAMB18.v,v 1.21 2008/01/04 01:15:11 wloo Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.23)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  16K-Bit Data and 2K-Bit Parity Dual Port Block RAM
// /___/   /\     Filename : X_RAMB18.v
// \   \  /  \    Timestamp : Tues July 26 16:43:59 PST 2005
//  \___\/\___\
//
// Revision:
//    07/26/05 - Initial version.
//    06/15/06 - Removed extra buffer that caused error with NCSim (CR 232775).
//    12/07/06 - Fixed data output (CR 426370).
//    01/04/07 - Added support of memory file to initialize memory and parity (CR 431584).
//    03/14/07 - Removed attribute INITP_FILE (CR 436003).
//    04/03/07 - Changed INIT_FILE = "NONE" as default (CR 436812).
//    06/01/07 - Added wire declaration for internal signals.
//    08/17/07 - Added setup/hold violation message on address w.r.t. clock (CR 436931).
//    01/03/08 - Fixed problem introduced by CR 436931 (CR 455893).
// End Revision

`timescale 1 ps/1 ps

module X_RAMB18 (DOA, DOB, DOPA, DOPB,
		 ADDRA, ADDRB, CLKA, CLKB, DIA, DIB, DIPA, DIPB, ENA, ENB, REGCEA, REGCEB, SSRA, SSRB, WEA, WEB);

    output [15:0] DOA;
    output [15:0] DOB;
    output [1:0] DOPA;
    output [1:0] DOPB;
    
    input ENA, CLKA, SSRA, REGCEA;
    input ENB, CLKB, SSRB, REGCEB;
    input [13:0] ADDRA;
    input [13:0] ADDRB;
    input [15:0] DIA;
    input [15:0] DIB;
    input [1:0] DIPA;
    input [1:0] DIPB;
    input [1:0] WEA;
    input [1:0] WEB;

    parameter integer DOA_REG = 0;
    parameter integer DOB_REG = 0;
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
    parameter INIT_A = 18'h0;
    parameter INIT_B = 18'h0;
    parameter INIT_FILE = "NONE";
    parameter LOC = "UNPLACED";
    parameter integer READ_WIDTH_A = 0;
    parameter integer READ_WIDTH_B = 0;
    parameter SETUP_ALL = 1000;
    parameter SETUP_READ_FIRST = 3000;
    parameter SIM_COLLISION_CHECK = "ALL";
    parameter SRVAL_A = 18'h0;
    parameter SRVAL_B = 18'h0;
    parameter WRITE_MODE_A = "WRITE_FIRST";
    parameter WRITE_MODE_B = "WRITE_FIRST";
    parameter integer WRITE_WIDTH_A = 0;
    parameter integer WRITE_WIDTH_B = 0;

    tri0 GSR = glbl.GSR;

    wire [7:0] dangle_out8;
    wire dangle_out;
    wire [1:0] dangle_out2;
    wire [5:0] dangle_out6;
    wire [15:0] dangle_out16;
    wire [47:0] dangle_out48;
    wire [13:0] addra_in, addrb_in;
    wire [1:0] wea_in, web_in, dipa_in, dipb_in, dopa_wire, dopb_wire;
    wire [15:0] dia_in, dib_in, doa_wire, dob_wire;
    wire clka_in, clkb_in, ena_in, enb_in, regcea_in, regceb_in;
    wire ssra_in, ssrb_in;
    
    reg [15:0] doa_out, dob_out;
    reg [1:0] dopa_out, dopb_out;

    reg notifier, notifier_a, notifier_b;
    reg notifier_addra0, notifier_addra1, notifier_addra2, notifier_addra3, notifier_addra4;
    reg notifier_addra5, notifier_addra6, notifier_addra7, notifier_addra8, notifier_addra9;
    reg notifier_addra10, notifier_addra11, notifier_addra12, notifier_addra13;
    reg notifier_addrb0, notifier_addrb1, notifier_addrb2, notifier_addrb3, notifier_addrb4;
    reg notifier_addrb5, notifier_addrb6, notifier_addrb7, notifier_addrb8, notifier_addrb9;
    reg notifier_addrb10, notifier_addrb11, notifier_addrb12, notifier_addrb13;

    
    buf b_addra[13:0] (addra_in, ADDRA);
    buf b_addrb[13:0] (addrb_in, ADDRB);
    buf b_clka (clka_in, CLKA);
    buf b_clkb (clkb_in, CLKB);
    
    buf b_dia[15:0] (dia_in, DIA);
    buf b_dib[15:0] (dib_in, DIB);
    buf b_dipa[1:0] (dipa_in, DIPA);
    buf b_dipb[1:0] (dipb_in, DIPB);
    buf b_doa[15:0] (DOA, doa_out);
    buf b_dopa[1:0] (DOPA, dopa_out);
    buf b_dob[15:0] (DOB, dob_out);
    buf b_dopb[1:0] (DOPB, dopb_out);

    buf b_ena (ena_in, ENA);
    buf b_enb (enb_in, ENB);
    buf b_regcea (regcea_in, REGCEA);
    buf b_regceb (regceb_in, REGCEB);
    buf b_ssra (ssra_in, SSRA);
    buf b_ssrb (ssrb_in, SSRB);
    buf b_wea[1:0] (wea_in, WEA);
    buf b_web[1:0] (web_in, WEB);

    always @(doa_wire or clka_in) doa_out = doa_wire;
    always @(dopa_wire or clka_in) dopa_out = dopa_wire;
    always @(dob_wire or clkb_in) dob_out = dob_wire;
    always @(dopb_wire or clkb_in) dopb_out = dopb_wire;
    
    X_ARAMB36_INTERNAL INT_RAMB (.DIA({48'b0,dia_in}), .ENA(ena_in), .WEA({4{wea_in}}), .SSRA(ssra_in), .ADDRA({2'b0,addra_in[13:0]}), .CLKA(clka_in), .DOA({dangle_out48,doa_wire}), .DIB({48'b0,dib_in}), .ENB(enb_in), .WEB({4{web_in}}), .SSRB(ssrb_in), .ADDRB({2'b0,addrb_in[13:0]}), .CLKB(clkb_in), .DOB({dangle_out16,dob_wire}), .GSR(GSR), .DOPA({dangle_out6,dopa_wire}), .DOPB({dangle_out2,dopb_wire}), .DIPA({2'b0,dipa_in}), .DIPB({6'b0,dipb_in}), .CASCADEOUTLATA(dangle_out), .CASCADEOUTLATB(dangle_out), .CASCADEOUTREGA(dangle_out), .CASCADEOUTREGB(dangle_out), .CASCADEINLATA(1'b0), .CASCADEINLATB(1'b0), .CASCADEINREGA(1'b0), .CASCADEINREGB(1'b0), .REGCEA(regcea_in), .REGCEB(regceb_in), .REGCLKA(clka_in), .REGCLKB(clkb_in), .DBITERR(dangle_out), .ECCPARITY(dangle_out8), .SBITERR(dangle_out));

    defparam INT_RAMB.BRAM_SIZE = 18;
    defparam INT_RAMB.BRAM_MODE = "TRUE_DUAL_PORT";
    defparam INT_RAMB.INIT_A = INIT_A;
    defparam INT_RAMB.INIT_B = INIT_B;
    defparam INT_RAMB.INIT_FILE = INIT_FILE;
    defparam INT_RAMB.SRVAL_A = SRVAL_A;
    defparam INT_RAMB.SRVAL_B = SRVAL_B;
    defparam INT_RAMB.READ_WIDTH_A = READ_WIDTH_A;
    defparam INT_RAMB.READ_WIDTH_B = READ_WIDTH_B;
    defparam INT_RAMB.WRITE_WIDTH_A = WRITE_WIDTH_A;
    defparam INT_RAMB.WRITE_WIDTH_B = WRITE_WIDTH_B;
    defparam INT_RAMB.WRITE_MODE_A = WRITE_MODE_A;
    defparam INT_RAMB.WRITE_MODE_B = WRITE_MODE_B;
    defparam INT_RAMB.SETUP_ALL = SETUP_ALL;
    defparam INT_RAMB.SETUP_READ_FIRST = SETUP_READ_FIRST;
    defparam INT_RAMB.SIM_COLLISION_CHECK = SIM_COLLISION_CHECK;
    defparam INT_RAMB.EN_ECC_READ = "FALSE";
    defparam INT_RAMB.EN_ECC_SCRUB = "FALSE";
    defparam INT_RAMB.EN_ECC_WRITE = "FALSE";
    defparam INT_RAMB.DOA_REG = DOA_REG;
    defparam INT_RAMB.DOB_REG = DOB_REG;
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
    wire dia0_enable = ena_in && wea_in[0];
    wire dia1_enable = ena_in && wea_in[1];
    wire dib0_enable = enb_in && web_in[0];
    wire dib1_enable = enb_in && web_in[1];
    
    always @(notifier or notifier_a or notifier_addra0 or notifier_addra1 or notifier_addra2 or notifier_addra3 or notifier_addra4 or
             notifier_addra5 or notifier_addra6 or notifier_addra7 or notifier_addra8 or notifier_addra9 or notifier_addra10 or 
             notifier_addra11 or notifier_addra12 or notifier_addra13) begin
	doa_out <= 16'hxxxx;
	dopa_out <= 2'bxx;
    end

    always @(notifier or notifier_b or notifier_addrb0 or notifier_addrb1 or notifier_addrb2 or notifier_addrb3 or notifier_addrb4 or
             notifier_addrb5 or notifier_addrb6 or notifier_addrb7 or notifier_addrb8 or notifier_addrb9 or notifier_addrb10 or 
             notifier_addrb11 or notifier_addrb12 or notifier_addrb13) begin
	dob_out <= 16'hxxxx;
	dopb_out <= 2'bxx;
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
        (CLKA => DOPA[0]) = (100:100:100, 100:100:100);
        (CLKA => DOPA[1]) = (100:100:100, 100:100:100);
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
        (CLKB => DOPB[0]) = (100:100:100, 100:100:100);
        (CLKB => DOPB[1]) = (100:100:100, 100:100:100);
	
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
       	$setuphold (posedge CLKA, posedge DIPA[0] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIPA[0] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge DIPA[1] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge DIPA[1] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge SSRA &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge SSRA &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge WEA[0] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge WEA[0] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge WEA[1] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge WEA[1] &&& ENA, 0:0:0, 0:0:0, notifier_a);
	$setuphold (posedge CLKA, posedge REGCEA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge REGCEA, 0:0:0, 0:0:0, notifier_a);
	$setuphold (posedge CLKA, posedge SSRA &&& REGCEA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge SSRA &&& REGCEA, 0:0:0, 0:0:0, notifier_a);

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
       	$setuphold (posedge CLKB, posedge DIPB[0] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIPB[0] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge DIPB[1] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge DIPB[1] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge SSRB &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge SSRB &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge WEB[0] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge WEB[0] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge WEB[1] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge WEB[1] &&& ENB, 0:0:0, 0:0:0, notifier_b);
	$setuphold (posedge CLKB, posedge REGCEB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge REGCEB, 0:0:0, 0:0:0, notifier_b);
	$setuphold (posedge CLKB, posedge SSRB &&& REGCEB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge SSRB &&& REGCEB, 0:0:0, 0:0:0, notifier_b);

	$period (posedge CLKA, 0:0:0, notifier_a);
	$period (posedge CLKB, 0:0:0, notifier_b);
	
        $width (posedge CLKA &&& ENA, 0:0:0, 0, notifier_a);
        $width (negedge CLKA &&& ENA, 0:0:0, 0, notifier_a);
        $width (posedge CLKB &&& ENB, 0:0:0, 0, notifier_b);
        $width (negedge CLKB &&& ENB, 0:0:0, 0, notifier_b);
	
	specparam PATHPULSE$ = 0;

    endspecify

endmodule // X_RAMB18

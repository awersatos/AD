// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/rainier/X_RAMB36_EXP.v,v 1.20 2008/01/04 01:15:11 wloo Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.23)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  32K-Bit Data and 4K-Bit Parity Dual Port Block RAM
// /___/   /\     Filename : X_RAMB36_EXP.v
// \   \  /  \    Timestamp : Tues July 26 16:43:59 PST 2005
//  \___\/\___\
//
// Revision:
//    07/26/05 - Initial version.
//    06/14/06 - Fixed unconnected cascade signals. (CR 231964)
//    12/07/06 - Fixed data output (CR 426370).
//    01/04/07 - Added support of memory file to initialize memory and parity (CR 431584).
//    03/14/07 - Removed attribute INITP_FILE (CR 436003).
//    04/03/07 - Changed INIT_FILE = "NONE" as default (CR 436812).
//    06/01/07 - Added wire declaration for internal signals.
//    08/17/07 - Added setup/hold violation message on address w.r.t. clock (CR 436931).
//    01/03/08 - Fixed problem introduced by CR 436931 (CR 455893).
// End Revision

`timescale 1 ps / 1 ps 

module X_RAMB36_EXP (CASCADEOUTLATA, CASCADEOUTLATB, CASCADEOUTREGA, CASCADEOUTREGB, DOA, DOB, DOPA, DOPB,
		     ADDRAL, ADDRAU, ADDRBL, ADDRBU, CASCADEINLATA, CASCADEINLATB, CASCADEINREGA, CASCADEINREGB, CLKAL, CLKAU, CLKBL, CLKBU, DIA, DIB, DIPA, DIPB, ENAL, ENAU, ENBL, ENBU, REGCEAL, REGCEAU, REGCEBL, REGCEBU, REGCLKAL, REGCLKAU, REGCLKBL, REGCLKBU, SSRAL, SSRAU, SSRBL, SSRBU, WEAL, WEAU, WEBL, WEBU);

    output CASCADEOUTLATA;
    output CASCADEOUTLATB;
    output CASCADEOUTREGA;
    output CASCADEOUTREGB;
    output [31:0] DOA;
    output [31:0] DOB;
    output [3:0] DOPA;
    output [3:0] DOPB;
    
    input [14:0] ADDRAU;
    input [14:0] ADDRBU;
    input [15:0] ADDRAL;
    input [15:0] ADDRBL;
    input CASCADEINLATA;
    input CASCADEINLATB;
    input CASCADEINREGA;
    input CASCADEINREGB;
    input CLKAL;
    input CLKAU;
    input CLKBL;
    input CLKBU;
    input [31:0] DIA;
    input [31:0] DIB;
    input [3:0] DIPA;
    input [3:0] DIPB;
    input ENAL;
    input ENAU;
    input ENBL;
    input ENBU;
    input REGCEAL;
    input REGCEAU;
    input REGCEBL;
    input REGCEBU;
    input REGCLKAL;
    input REGCLKAU;
    input REGCLKBL;
    input REGCLKBU;
    input SSRAL;
    input SSRAU;
    input SSRBL;
    input SSRBU;
    input [3:0] WEAL;
    input [3:0] WEAU;
    input [7:0] WEBL;
    input [7:0] WEBU;

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
    parameter INITP_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
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
    parameter INIT_40 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_41 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_42 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_43 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_44 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_45 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_46 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_47 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_48 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_49 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_4A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_4B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_4C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_4D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_4E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_4F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_50 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_51 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_52 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_53 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_54 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_55 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_56 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_57 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_58 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_59 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_5A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_5B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_5C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_5D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_5E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_5F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_60 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_61 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_62 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_63 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_64 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_65 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_66 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_67 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_68 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_69 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_6A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_6B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_6C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_6D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_6E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_6F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_70 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_71 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_72 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_73 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_74 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_75 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_76 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_77 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_78 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_79 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_7A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_7B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_7C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_7D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_7E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_7F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_A = 36'h0;
    parameter INIT_B = 36'h0;
    parameter INIT_FILE = "NONE";
    parameter LOC = "UNPLACED";
    parameter RAM_EXTENSION_A = "NONE";
    parameter RAM_EXTENSION_B = "NONE";
    parameter integer READ_WIDTH_A = 0;
    parameter integer READ_WIDTH_B = 0;
    parameter SETUP_ALL = 1000;
    parameter SETUP_READ_FIRST = 3000;
    parameter SIM_COLLISION_CHECK = "ALL";
    parameter SRVAL_A = 36'h0;
    parameter SRVAL_B = 36'h0;
    parameter WRITE_MODE_A = "WRITE_FIRST";
    parameter WRITE_MODE_B = "WRITE_FIRST";
    parameter integer WRITE_WIDTH_A = 0;
    parameter integer WRITE_WIDTH_B = 0;

    tri0 GSR = glbl.GSR;
    wire [3:0] weal_in;
    wire [7:0] webl_in;
    wire [7:0] dangle_out8;
    wire dangle_out;
    wire [3:0] dangle_out4, dipa_in, dipb_in, dopa_wire, dopb_wire;
    wire [31:0] dangle_out32, dia_in, dib_in, doa_wire, dob_wire;
    wire [15:0] addral_in, addrbl_in;
    wire cascadeoutlata_wire, cascadeoutrega_wire, cascadeoutlatb_wire, cascadeoutregb_wire;
    wire clkal_in, clkbl_in, regclkal_in, regclkbl_in, enal_in, enbl_in;
    wire regceal_in, regcebl_in, ssral_in, ssrbl_in;
    wire cascadeinlata_in, cascadeinlatb_in, cascadeinrega_in, cascadeinregb_in;
    
    reg [31:0] doa_out, dob_out;
    reg [3:0] dopa_out, dopb_out;
    reg cascadeoutlata_out, cascadeoutrega_out, cascadeoutlatb_out, cascadeoutregb_out;
    reg notifier, notifier_a, notifier_b;
    reg notifier_addra0, notifier_addra1, notifier_addra2, notifier_addra3, notifier_addra4;
    reg notifier_addra5, notifier_addra6, notifier_addra7, notifier_addra8, notifier_addra9;
    reg notifier_addra10, notifier_addra11, notifier_addra12, notifier_addra13, notifier_addra14;
    reg notifier_addra15;
    reg notifier_addrb0, notifier_addrb1, notifier_addrb2, notifier_addrb3, notifier_addrb4;
    reg notifier_addrb5, notifier_addrb6, notifier_addrb7, notifier_addrb8, notifier_addrb9;
    reg notifier_addrb10, notifier_addrb11, notifier_addrb12, notifier_addrb13, notifier_addrb14;
    reg notifier_addrb15;
   
    buf b_addral[15:0] (addral_in, ADDRAL);
    buf b_addrbl[15:0] (addrbl_in, ADDRBL);
    buf b_clkal (clkal_in, CLKAL);
    buf b_clkbl (clkbl_in, CLKBL);
    buf b_regclkal (regclkal_in, REGCLKAL);
    buf b_regclkbl (regclkbl_in, REGCLKBL);
    
    buf b_dia[31:0] (dia_in, DIA);
    buf b_dib[31:0] (dib_in, DIB);
    buf b_dipa[3:0] (dipa_in, DIPA);
    buf b_dipb[3:0] (dipb_in, DIPB);
    buf b_doa[31:0] (DOA, doa_out);
    buf b_dopa[3:0] (DOPA, dopa_out);
    buf b_dob[31:0] (DOB, dob_out);
    buf b_dopb[3:0] (DOPB, dopb_out);

    buf b_enal (enal_in, ENAL);
    buf b_enbl (enbl_in, ENBL);
    buf b_regceal (regceal_in, REGCEAL);
    buf b_regcebl (regcebl_in, REGCEBL);
    buf b_ssral (ssral_in, SSRAL);
    buf b_ssrbl (ssrbl_in, SSRBL);
    buf b_weal[3:0] (weal_in, WEAL);
    buf b_webl[7:0] (webl_in, WEBL);
    buf b_cascadeinlata (cascadeinlata_in, CASCADEINLATA);
    buf b_cascadeinlatb (cascadeinlatb_in, CASCADEINLATB);
    buf b_cascadeoutlata (CASCADEOUTLATA, cascadeoutlata_out);
    buf b_cascadeoutlatb (CASCADEOUTLATB, cascadeoutlatb_out);
    buf b_cascadeinrega (cascadeinrega_in, CASCADEINREGA);
    buf b_cascadeinregb (cascadeinregb_in, CASCADEINREGB);
    buf b_cascadeoutrega (CASCADEOUTREGA, cascadeoutrega_out);
    buf b_cascadeoutregb (CASCADEOUTREGB, cascadeoutregb_out);

    always @(doa_wire or clkal_in) doa_out = doa_wire;
    always @(dopa_wire or clkal_in) dopa_out = dopa_wire;
    always @(dob_wire or clkbl_in) dob_out = dob_wire;
    always @(dopb_wire or clkbl_in) dopb_out = dopb_wire;
    always @(cascadeoutlata_wire or clkal_in) cascadeoutlata_out = cascadeoutlata_wire;
    always @(cascadeoutlatb_wire or clkbl_in) cascadeoutlatb_out = cascadeoutlatb_wire;
    always @(cascadeoutrega_wire or clkal_in) cascadeoutrega_out = cascadeoutrega_wire;
    always @(cascadeoutregb_wire or clkbl_in) cascadeoutregb_out = cascadeoutregb_wire;
    
    X_ARAMB36_INTERNAL INT_RAMB (.DIA({32'b0,dia_in}), .ENA(enal_in), .WEA({4'b0,weal_in}), .SSRA(ssral_in), .ADDRA(addral_in), .CLKA(clkal_in), .DOA({dangle_out32,doa_wire}), .DIB({32'b0,dib_in}), .ENB(enbl_in), .WEB(webl_in), .SSRB(ssrbl_in), .ADDRB(addrbl_in), .CLKB(clkbl_in), .DOB(dob_wire), .GSR(GSR), .DOPA({dangle_out4,dopa_wire}), .DOPB(dopb_wire), .DIPA(dipa_in), .DIPB({4'b0,dipb_in}), .CASCADEOUTLATA(cascadeoutlata_wire), .CASCADEOUTLATB(cascadeoutlatb_wire), .CASCADEOUTREGA(cascadeoutrega_wire), .CASCADEOUTREGB(cascadeoutregb_wire), .CASCADEINLATA(cascadeinlata_in), .CASCADEINLATB(cascadeinlatb_in), .CASCADEINREGA(cascadeinrega_in), .CASCADEINREGB(cascadeinregb_in), .REGCEA(regceal_in), .REGCEB(regcebl_in), .REGCLKA(regclkal_in), .REGCLKB(regclkbl_in), .DBITERR(dangle_out), .ECCPARITY(dangle_out8), .SBITERR(dangle_out));

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
    defparam INT_RAMB.RAM_EXTENSION_A = RAM_EXTENSION_A;
    defparam INT_RAMB.RAM_EXTENSION_B = RAM_EXTENSION_B;
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
    defparam INT_RAMB.INIT_40 = INIT_40;
    defparam INT_RAMB.INIT_41 = INIT_41;
    defparam INT_RAMB.INIT_42 = INIT_42;
    defparam INT_RAMB.INIT_43 = INIT_43;
    defparam INT_RAMB.INIT_44 = INIT_44;
    defparam INT_RAMB.INIT_45 = INIT_45;
    defparam INT_RAMB.INIT_46 = INIT_46;
    defparam INT_RAMB.INIT_47 = INIT_47;
    defparam INT_RAMB.INIT_48 = INIT_48;
    defparam INT_RAMB.INIT_49 = INIT_49;
    defparam INT_RAMB.INIT_4A = INIT_4A;
    defparam INT_RAMB.INIT_4B = INIT_4B;
    defparam INT_RAMB.INIT_4C = INIT_4C;
    defparam INT_RAMB.INIT_4D = INIT_4D;
    defparam INT_RAMB.INIT_4E = INIT_4E;
    defparam INT_RAMB.INIT_4F = INIT_4F;
    defparam INT_RAMB.INIT_50 = INIT_50;
    defparam INT_RAMB.INIT_51 = INIT_51;
    defparam INT_RAMB.INIT_52 = INIT_52;
    defparam INT_RAMB.INIT_53 = INIT_53;
    defparam INT_RAMB.INIT_54 = INIT_54;
    defparam INT_RAMB.INIT_55 = INIT_55;
    defparam INT_RAMB.INIT_56 = INIT_56;
    defparam INT_RAMB.INIT_57 = INIT_57;
    defparam INT_RAMB.INIT_58 = INIT_58;
    defparam INT_RAMB.INIT_59 = INIT_59;
    defparam INT_RAMB.INIT_5A = INIT_5A;
    defparam INT_RAMB.INIT_5B = INIT_5B;
    defparam INT_RAMB.INIT_5C = INIT_5C;
    defparam INT_RAMB.INIT_5D = INIT_5D;
    defparam INT_RAMB.INIT_5E = INIT_5E;
    defparam INT_RAMB.INIT_5F = INIT_5F;
    defparam INT_RAMB.INIT_60 = INIT_60;
    defparam INT_RAMB.INIT_61 = INIT_61;
    defparam INT_RAMB.INIT_62 = INIT_62;
    defparam INT_RAMB.INIT_63 = INIT_63;
    defparam INT_RAMB.INIT_64 = INIT_64;
    defparam INT_RAMB.INIT_65 = INIT_65;
    defparam INT_RAMB.INIT_66 = INIT_66;
    defparam INT_RAMB.INIT_67 = INIT_67;
    defparam INT_RAMB.INIT_68 = INIT_68;
    defparam INT_RAMB.INIT_69 = INIT_69;
    defparam INT_RAMB.INIT_6A = INIT_6A;
    defparam INT_RAMB.INIT_6B = INIT_6B;
    defparam INT_RAMB.INIT_6C = INIT_6C;
    defparam INT_RAMB.INIT_6D = INIT_6D;
    defparam INT_RAMB.INIT_6E = INIT_6E;
    defparam INT_RAMB.INIT_6F = INIT_6F;
    defparam INT_RAMB.INIT_70 = INIT_70;
    defparam INT_RAMB.INIT_71 = INIT_71;
    defparam INT_RAMB.INIT_72 = INIT_72;
    defparam INT_RAMB.INIT_73 = INIT_73;
    defparam INT_RAMB.INIT_74 = INIT_74;
    defparam INT_RAMB.INIT_75 = INIT_75;
    defparam INT_RAMB.INIT_76 = INIT_76;
    defparam INT_RAMB.INIT_77 = INIT_77;
    defparam INT_RAMB.INIT_78 = INIT_78;
    defparam INT_RAMB.INIT_79 = INIT_79;
    defparam INT_RAMB.INIT_7A = INIT_7A;
    defparam INT_RAMB.INIT_7B = INIT_7B;
    defparam INT_RAMB.INIT_7C = INIT_7C;
    defparam INT_RAMB.INIT_7D = INIT_7D;
    defparam INT_RAMB.INIT_7E = INIT_7E;
    defparam INT_RAMB.INIT_7F = INIT_7F;
    defparam INT_RAMB.INITP_00 = INITP_00;
    defparam INT_RAMB.INITP_01 = INITP_01;
    defparam INT_RAMB.INITP_02 = INITP_02;
    defparam INT_RAMB.INITP_03 = INITP_03;
    defparam INT_RAMB.INITP_04 = INITP_04;
    defparam INT_RAMB.INITP_05 = INITP_05;
    defparam INT_RAMB.INITP_06 = INITP_06;
    defparam INT_RAMB.INITP_07 = INITP_07;
    defparam INT_RAMB.INITP_08 = INITP_08;
    defparam INT_RAMB.INITP_09 = INITP_09;
    defparam INT_RAMB.INITP_0A = INITP_0A;
    defparam INT_RAMB.INITP_0B = INITP_0B;
    defparam INT_RAMB.INITP_0C = INITP_0C;
    defparam INT_RAMB.INITP_0D = INITP_0D;
    defparam INT_RAMB.INITP_0E = INITP_0E;
    defparam INT_RAMB.INITP_0F = INITP_0F;

    
//*** Timing Checks Start here
    wire dia0_enable = enal_in && weal_in[0];
    wire dia1_enable = enal_in && weal_in[1];
    wire dia2_enable = enal_in && weal_in[2];
    wire dia3_enable = enal_in && weal_in[3];
    wire dib0_enable = enbl_in && webl_in[0];
    wire dib1_enable = enbl_in && webl_in[1];
    wire dib2_enable = enbl_in && webl_in[2];
    wire dib3_enable = enbl_in && webl_in[3];
    
    always @(notifier or notifier_a or notifier_addra0 or notifier_addra1 or notifier_addra2 or notifier_addra3 or notifier_addra4 or
             notifier_addra5 or notifier_addra6 or notifier_addra7 or notifier_addra8 or notifier_addra9 or notifier_addra10 or 
             notifier_addra11 or notifier_addra12 or notifier_addra13 or notifier_addra14 or notifier_addra15) begin    
	doa_out <= 32'hxxxxxxxx;
	dopa_out <= 4'hx;
	cascadeoutlata_out <= 1'bx;
	cascadeoutrega_out <= 1'bx;
    end

    always @(notifier or notifier_b or notifier_addrb0 or notifier_addrb1 or notifier_addrb2 or notifier_addrb3 or notifier_addrb4 or
             notifier_addrb5 or notifier_addrb6 or notifier_addrb7 or notifier_addrb8 or notifier_addrb9 or notifier_addrb10 or 
             notifier_addrb11 or notifier_addrb12 or notifier_addrb13 or notifier_addrb14 or notifier_addrb15) begin
	dob_out <= 32'hxxxxxxxx;
	dopb_out <= 4'hx;
	cascadeoutlatb_out <= 1'bx;
	cascadeoutregb_out <= 1'bx;
    end


    always @(notifier_addra0) begin
	task_warn_msg ("ADDRAL[0]", "CLKAL");
    end

    always @(notifier_addra1) begin
	task_warn_msg ("ADDRAL[1]", "CLKAL");
    end
    
    always @(notifier_addra2) begin
	task_warn_msg ("ADDRAL[2]", "CLKAL");
    end
    
    always @(notifier_addra3) begin
	task_warn_msg ("ADDRAL[3]", "CLKAL");
    end
    
    always @(notifier_addra4) begin
	task_warn_msg ("ADDRAL[4]", "CLKAL");
    end

    always @(notifier_addra5) begin
	task_warn_msg ("ADDRAL[5]", "CLKAL");
    end
    
    always @(notifier_addra6) begin
	task_warn_msg ("ADDRAL[6]", "CLKAL");
    end
    
    always @(notifier_addra7) begin
	task_warn_msg ("ADDRAL[7]", "CLKAL");
    end   

    always @(notifier_addra8) begin
	task_warn_msg ("ADDRAL[8]", "CLKAL");
    end

    always @(notifier_addra9) begin
	task_warn_msg ("ADDRAL[9]", "CLKAL");
    end
    
    always @(notifier_addra10) begin
	task_warn_msg ("ADDRAL[10]", "CLKAL");
    end
    
    always @(notifier_addra11) begin
	task_warn_msg ("ADDRAL[11]", "CLKAL");
    end
    
     always @(notifier_addra12) begin
	task_warn_msg ("ADDRAL[12]", "CLKAL");
    end

    always @(notifier_addra13) begin
	task_warn_msg ("ADDRAL[13]", "CLKAL");
    end
    
    always @(notifier_addra14) begin
	task_warn_msg ("ADDRAL[14]", "CLKAL");
    end
    
    always @(notifier_addra15) begin
	task_warn_msg ("ADDRAL[15]", "CLKAL");
    end


    always @(notifier_addrb0) begin
	task_warn_msg ("ADDRBL[0]", "CLKBL");
    end

    always @(notifier_addrb1) begin
	task_warn_msg ("ADDRBL[1]", "CLKBL");
    end
    
    always @(notifier_addrb2) begin
	task_warn_msg ("ADDRBL[2]", "CLKBL");
    end
    
    always @(notifier_addrb3) begin
	task_warn_msg ("ADDRBL[3]", "CLKBL");
    end
    
    always @(notifier_addrb4) begin
	task_warn_msg ("ADDRBL[4]", "CLKBL");
    end

    always @(notifier_addrb5) begin
	task_warn_msg ("ADDRBL[5]", "CLKBL");
    end
    
    always @(notifier_addrb6) begin
	task_warn_msg ("ADDRBL[6]", "CLKBL");
    end
    
    always @(notifier_addrb7) begin
	task_warn_msg ("ADDRBL[7]", "CLKBL");
    end   

    always @(notifier_addrb8) begin
	task_warn_msg ("ADDRBL[8]", "CLKBL");
    end

    always @(notifier_addrb9) begin
	task_warn_msg ("ADDRBL[9]", "CLKBL");
    end
    
    always @(notifier_addrb10) begin
	task_warn_msg ("ADDRBL[10]", "CLKBL");
    end
    
    always @(notifier_addrb11) begin
	task_warn_msg ("ADDRBL[11]", "CLKBL");
    end
    
     always @(notifier_addrb12) begin
	task_warn_msg ("ADDRBL[12]", "CLKBL");
    end

    always @(notifier_addrb13) begin
	task_warn_msg ("ADDRBL[13]", "CLKBL");
    end
    
    always @(notifier_addrb14) begin
	task_warn_msg ("ADDRBL[14]", "CLKBL");
    end
    
    always @(notifier_addrb15) begin
	task_warn_msg ("ADDRBL[15]", "CLKBL");
    end

    
    task task_warn_msg;

        input [8*10:1] addr_str;
	input [8*5:1] clk_str;
	
	begin

	    $display("Error: Setup/Hold Violation on %s with respect to %s when memory has been enabled. The memory contents at %s of the RAM can be corrupted. This corruption is not modeled in this simulation model. Please take the necessary steps to recover from this data corruption in hardware.", addr_str, clk_str, addr_str);

	end
	
    endtask // task_warn_msg
    
	    

    
    specify

	(CASCADEINLATA => DOA[0]) = (0:0:0, 0:0:0);
	(CASCADEINREGA => DOA[0]) = (0:0:0, 0:0:0);
        (CLKAL => DOA[0]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[1]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[2]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[3]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[4]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[5]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[6]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[7]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[8]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[9]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[10]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[11]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[12]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[13]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[14]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[15]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[16]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[17]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[18]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[19]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[20]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[21]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[22]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[23]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[24]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[25]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[26]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[27]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[28]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[29]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[30]) = (100:100:100, 100:100:100);
        (CLKAL => DOA[31]) = (100:100:100, 100:100:100);
        (CLKAL => DOPA[0]) = (100:100:100, 100:100:100);
        (CLKAL => DOPA[1]) = (100:100:100, 100:100:100);
        (CLKAL => DOPA[2]) = (100:100:100, 100:100:100);
        (CLKAL => DOPA[3]) = (100:100:100, 100:100:100);
	(CLKAL => CASCADEOUTLATA) = (100:100:100, 100:100:100);
	(REGCLKAL => DOA[0]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[1]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[2]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[3]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[4]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[5]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[6]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[7]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[8]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[9]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[10]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[11]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[12]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[13]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[14]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[15]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[16]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[17]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[18]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[19]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[20]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[21]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[22]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[23]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[24]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[25]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[26]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[27]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[28]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[29]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[30]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOA[31]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOPA[0]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOPA[1]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOPA[2]) = (100:100:100, 100:100:100);
        (REGCLKAL => DOPA[3]) = (100:100:100, 100:100:100);
        (REGCLKAL => CASCADEOUTREGA) = (100:100:100, 100:100:100);

	(CASCADEINLATB => DOB[0]) = (0:0:0, 0:0:0);
	(CASCADEINREGB => DOB[0]) = (0:0:0, 0:0:0);
        (CLKBL => DOB[0]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[1]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[2]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[3]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[4]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[5]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[6]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[7]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[8]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[9]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[10]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[11]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[12]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[13]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[14]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[15]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[16]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[17]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[18]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[19]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[20]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[21]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[22]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[23]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[24]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[25]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[26]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[27]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[28]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[29]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[30]) = (100:100:100, 100:100:100);
        (CLKBL => DOB[31]) = (100:100:100, 100:100:100);
        (CLKBL => DOPB[0]) = (100:100:100, 100:100:100);
        (CLKBL => DOPB[1]) = (100:100:100, 100:100:100);
        (CLKBL => DOPB[2]) = (100:100:100, 100:100:100);
        (CLKBL => DOPB[3]) = (100:100:100, 100:100:100);
	(CLKBL => CASCADEOUTLATB) = (100:100:100, 100:100:100);
	(REGCLKBL => DOB[0]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[1]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[2]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[3]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[4]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[5]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[6]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[7]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[8]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[9]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[10]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[11]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[12]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[13]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[14]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[15]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[16]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[17]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[18]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[19]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[20]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[21]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[22]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[23]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[24]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[25]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[26]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[27]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[28]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[29]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[30]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOB[31]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOPB[0]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOPB[1]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOPB[2]) = (100:100:100, 100:100:100);
        (REGCLKBL => DOPB[3]) = (100:100:100, 100:100:100);
        (REGCLKBL => CASCADEOUTREGB) = (100:100:100, 100:100:100);
	
       	$setuphold (posedge CLKAL, posedge ADDRAL[0] &&& ENAL, 0:0:0, 0:0:0, notifier_addra0);
       	$setuphold (posedge CLKAL, negedge ADDRAL[0] &&& ENAL, 0:0:0, 0:0:0, notifier_addra0);
       	$setuphold (posedge CLKAL, posedge ADDRAL[1] &&& ENAL, 0:0:0, 0:0:0, notifier_addra1);
       	$setuphold (posedge CLKAL, negedge ADDRAL[1] &&& ENAL, 0:0:0, 0:0:0, notifier_addra1);
       	$setuphold (posedge CLKAL, posedge ADDRAL[2] &&& ENAL, 0:0:0, 0:0:0, notifier_addra2);
       	$setuphold (posedge CLKAL, negedge ADDRAL[2] &&& ENAL, 0:0:0, 0:0:0, notifier_addra2);
       	$setuphold (posedge CLKAL, posedge ADDRAL[3] &&& ENAL, 0:0:0, 0:0:0, notifier_addra3);
       	$setuphold (posedge CLKAL, negedge ADDRAL[3] &&& ENAL, 0:0:0, 0:0:0, notifier_addra3);
       	$setuphold (posedge CLKAL, posedge ADDRAL[4] &&& ENAL, 0:0:0, 0:0:0, notifier_addra4);
       	$setuphold (posedge CLKAL, negedge ADDRAL[4] &&& ENAL, 0:0:0, 0:0:0, notifier_addra4);
       	$setuphold (posedge CLKAL, posedge ADDRAL[5] &&& ENAL, 0:0:0, 0:0:0, notifier_addra5);
       	$setuphold (posedge CLKAL, negedge ADDRAL[5] &&& ENAL, 0:0:0, 0:0:0, notifier_addra5);
       	$setuphold (posedge CLKAL, posedge ADDRAL[6] &&& ENAL, 0:0:0, 0:0:0, notifier_addra6);
       	$setuphold (posedge CLKAL, negedge ADDRAL[6] &&& ENAL, 0:0:0, 0:0:0, notifier_addra6);
       	$setuphold (posedge CLKAL, posedge ADDRAL[7] &&& ENAL, 0:0:0, 0:0:0, notifier_addra7);
       	$setuphold (posedge CLKAL, negedge ADDRAL[7] &&& ENAL, 0:0:0, 0:0:0, notifier_addra7);
       	$setuphold (posedge CLKAL, posedge ADDRAL[8] &&& ENAL, 0:0:0, 0:0:0, notifier_addra8);
       	$setuphold (posedge CLKAL, negedge ADDRAL[8] &&& ENAL, 0:0:0, 0:0:0, notifier_addra8);
       	$setuphold (posedge CLKAL, posedge ADDRAL[9] &&& ENAL, 0:0:0, 0:0:0, notifier_addra9);
       	$setuphold (posedge CLKAL, negedge ADDRAL[9] &&& ENAL, 0:0:0, 0:0:0, notifier_addra9);
       	$setuphold (posedge CLKAL, posedge ADDRAL[10] &&& ENAL, 0:0:0, 0:0:0, notifier_addra10);
       	$setuphold (posedge CLKAL, negedge ADDRAL[10] &&& ENAL, 0:0:0, 0:0:0, notifier_addra10);
       	$setuphold (posedge CLKAL, posedge ADDRAL[11] &&& ENAL, 0:0:0, 0:0:0, notifier_addra11);
       	$setuphold (posedge CLKAL, negedge ADDRAL[11] &&& ENAL, 0:0:0, 0:0:0, notifier_addra11);
       	$setuphold (posedge CLKAL, posedge ADDRAL[12] &&& ENAL, 0:0:0, 0:0:0, notifier_addra12);
       	$setuphold (posedge CLKAL, negedge ADDRAL[12] &&& ENAL, 0:0:0, 0:0:0, notifier_addra12);
       	$setuphold (posedge CLKAL, posedge ADDRAL[13] &&& ENAL, 0:0:0, 0:0:0, notifier_addra13);
       	$setuphold (posedge CLKAL, negedge ADDRAL[13] &&& ENAL, 0:0:0, 0:0:0, notifier_addra13);
       	$setuphold (posedge CLKAL, posedge ADDRAL[14] &&& ENAL, 0:0:0, 0:0:0, notifier_addra14);
       	$setuphold (posedge CLKAL, negedge ADDRAL[14] &&& ENAL, 0:0:0, 0:0:0, notifier_addra14);
	$setuphold (posedge CLKAL, posedge ADDRAL[15] &&& ENAL, 0:0:0, 0:0:0, notifier_addra15);
       	$setuphold (posedge CLKAL, negedge ADDRAL[15] &&& ENAL, 0:0:0, 0:0:0, notifier_addra15);
       	$setuphold (posedge CLKAL, posedge DIA[0] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[0] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[1] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[1] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[2] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[2] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[3] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[3] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[4] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[4] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[5] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[5] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[6] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[6] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[7] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[7] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[8] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[8] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[9] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[9] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[10] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[10] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[11] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[11] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[12] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[12] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[13] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[13] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[14] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[14] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[15] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[15] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[16] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[16] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[17] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[17] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[18] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[18] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[19] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[19] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[20] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[20] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[21] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[21] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[22] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[22] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[23] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[23] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[24] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[24] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[25] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[25] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[26] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[26] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[27] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[27] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[28] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[28] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[29] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[29] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[30] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[30] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIA[31] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIA[31] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIPA[0] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIPA[0] &&& dia0_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIPA[1] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIPA[1] &&& dia1_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIPA[2] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIPA[2] &&& dia2_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge DIPA[3] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge DIPA[3] &&& dia3_enable, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge ENAL, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge ENAL, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge SSRAL &&& ENAL, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge SSRAL &&& ENAL, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge WEAL[0] &&& ENAL, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge WEAL[0] &&& ENAL, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge WEAL[1] &&& ENAL, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge WEAL[1] &&& ENAL, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge WEAL[2] &&& ENAL, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge WEAL[2] &&& ENAL, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, posedge WEAL[3] &&& ENAL, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKAL, negedge WEAL[3] &&& ENAL, 0:0:0, 0:0:0, notifier_a);
	$setuphold (posedge REGCLKAL, posedge REGCEAL, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge REGCLKAL, negedge REGCEAL, 0:0:0, 0:0:0, notifier_a);
	$setuphold (posedge REGCLKAL, posedge SSRAL &&& REGCEAL, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge REGCLKAL, negedge SSRAL &&& REGCEAL, 0:0:0, 0:0:0, notifier_a);

       	$setuphold (posedge CLKBL, posedge ADDRBL[0] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb0);
       	$setuphold (posedge CLKBL, negedge ADDRBL[0] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb0);
       	$setuphold (posedge CLKBL, posedge ADDRBL[1] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb1);
       	$setuphold (posedge CLKBL, negedge ADDRBL[1] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb1);
       	$setuphold (posedge CLKBL, posedge ADDRBL[2] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb2);
       	$setuphold (posedge CLKBL, negedge ADDRBL[2] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb2);
       	$setuphold (posedge CLKBL, posedge ADDRBL[3] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb3);
       	$setuphold (posedge CLKBL, negedge ADDRBL[3] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb3);
       	$setuphold (posedge CLKBL, posedge ADDRBL[4] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb4);
       	$setuphold (posedge CLKBL, negedge ADDRBL[4] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb4);
       	$setuphold (posedge CLKBL, posedge ADDRBL[5] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb5);
       	$setuphold (posedge CLKBL, negedge ADDRBL[5] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb5);
       	$setuphold (posedge CLKBL, posedge ADDRBL[6] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb6);
       	$setuphold (posedge CLKBL, negedge ADDRBL[6] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb6);
       	$setuphold (posedge CLKBL, posedge ADDRBL[7] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb7);
       	$setuphold (posedge CLKBL, negedge ADDRBL[7] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb7);
       	$setuphold (posedge CLKBL, posedge ADDRBL[8] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb8);
       	$setuphold (posedge CLKBL, negedge ADDRBL[8] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb8);
       	$setuphold (posedge CLKBL, posedge ADDRBL[9] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb9);
       	$setuphold (posedge CLKBL, negedge ADDRBL[9] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb9);
       	$setuphold (posedge CLKBL, posedge ADDRBL[10] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb10);
       	$setuphold (posedge CLKBL, negedge ADDRBL[10] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb10);
       	$setuphold (posedge CLKBL, posedge ADDRBL[11] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb11);
       	$setuphold (posedge CLKBL, negedge ADDRBL[11] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb11);
       	$setuphold (posedge CLKBL, posedge ADDRBL[12] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb12);
       	$setuphold (posedge CLKBL, negedge ADDRBL[12] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb12);
       	$setuphold (posedge CLKBL, posedge ADDRBL[13] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb13);
       	$setuphold (posedge CLKBL, negedge ADDRBL[13] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb13);
       	$setuphold (posedge CLKBL, posedge ADDRBL[14] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb14);
       	$setuphold (posedge CLKBL, negedge ADDRBL[14] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb14);
	$setuphold (posedge CLKBL, posedge ADDRBL[15] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb15);
       	$setuphold (posedge CLKBL, negedge ADDRBL[15] &&& ENBL, 0:0:0, 0:0:0, notifier_addrb15);
	
       	$setuphold (posedge CLKBL, posedge DIB[0] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[0] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[1] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[1] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[2] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[2] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[3] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[3] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[4] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[4] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[5] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[5] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[6] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[6] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[7] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[7] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[8] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[8] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[9] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[9] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[10] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[10] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[11] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[11] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[12] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[12] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[13] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[13] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[14] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[14] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[15] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[15] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[16] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[16] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[17] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[17] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[18] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[18] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[19] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[19] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[20] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[20] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[21] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[21] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[22] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[22] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[23] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[23] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[24] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[24] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[25] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[25] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[26] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[26] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[27] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[27] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[28] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[28] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[29] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[29] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[30] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[30] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIB[31] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIB[31] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIPB[0] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIPB[0] &&& dib0_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIPB[1] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIPB[1] &&& dib1_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIPB[2] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIPB[2] &&& dib2_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge DIPB[3] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge DIPB[3] &&& dib3_enable, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge SSRBL &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge SSRBL &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge WEBL[0] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge WEBL[0] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge WEBL[1] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge WEBL[1] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge WEBL[2] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge WEBL[2] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge WEBL[3] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge WEBL[3] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge WEBL[4] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge WEBL[4] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge WEBL[5] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge WEBL[5] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge WEBL[6] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge WEBL[6] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, posedge WEBL[7] &&& ENBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKBL, negedge WEBL[7] &&& ENBL, 0:0:0, 0:0:0, notifier_b);	
	$setuphold (posedge REGCLKBL, posedge REGCEBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge REGCLKBL, negedge REGCEBL, 0:0:0, 0:0:0, notifier_b);
	$setuphold (posedge REGCLKBL, posedge SSRBL &&& REGCEBL, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge REGCLKBL, negedge SSRBL &&& REGCEBL, 0:0:0, 0:0:0, notifier_b);

	$period (posedge CLKAL, 0:0:0, notifier_a);
	$period (posedge CLKBL, 0:0:0, notifier_b);
	$period (posedge REGCLKAL, 0:0:0, notifier_a);
	$period (posedge REGCLKBL, 0:0:0, notifier_b);
	
        $width (posedge CLKAL &&& ENAL, 0:0:0, 0, notifier_a);
        $width (negedge CLKAL &&& ENAL, 0:0:0, 0, notifier_a);
        $width (posedge CLKBL &&& ENBL, 0:0:0, 0, notifier_b);
        $width (negedge CLKBL &&& ENBL, 0:0:0, 0, notifier_b);
        $width (posedge REGCLKAL &&& REGCEAL, 0:0:0, 0, notifier_a);
        $width (negedge REGCLKAL &&& REGCEAL, 0:0:0, 0, notifier_a);
        $width (posedge REGCLKBL &&& REGCEBL, 0:0:0, 0, notifier_b);
        $width (negedge REGCLKBL &&& REGCEBL, 0:0:0, 0, notifier_b);
	
	specparam PATHPULSE$ = 0;

    endspecify

endmodule

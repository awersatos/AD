// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/virtex4/X_RAMB16.v,v 1.31 2007/06/06 22:12:04 wloo Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  16K-Bit Data and 2K-Bit Parity Dual Port Block RAM
// /___/   /\     Filename : X_RAMB16.v
// \   \  /  \    Timestamp : Thu Mar 11 16:43:59 PST 2005
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Added LOC parameter, removed GSR ports and initialized outputs.
//    03/18/05 - Added output register for ECC.
//    06/20/05 - Removed LOC from unisims.
//    07/11/05 - Fixed output to clear from X's, when GSR deasserted and SSR was high.
//    09/14/05 - Fixed EN_ECC_* parameters.
//    02/06/06 - Fixed CR 223097 -- CASCADE/NO_CHANGE message.
//    05/19/06 - Added path delay for cascadein to do outputs (CR 231750).
//    06/27/06 - Added 2 dimensional memory array feature.
//    07/05/06 - Added timing checks for cascadeins to clocks (CR 231750).
//    01/24/07 - Added support of memory file to initialize memory and parity (CR 431584).
//    02/13/07 - Fixed register output in cascaded mode (CR 433819).
//    03/14/07 - Removed attribute INITP_FILE (CR 436003).
//    03/26/07 - Fixed register output in cascaded mode (CR 433812).
//    04/03/07 - Changed INIT_FILE = "NONE" as default (CR 436812). 
//    06/06/07 - Added wire declaration for internal signals.
// End Revision

`timescale 1 ps/1 ps
module X_RAMB16 (CASCADEOUTA, CASCADEOUTB, DOA, DOB, DOPA, DOPB, 
		 ADDRA, ADDRB, CASCADEINA, CASCADEINB, CLKA, CLKB, DIA, DIB, DIPA, DIPB, ENA, ENB, REGCEA, REGCEB, SSRA, SSRB, WEA, WEB);

    parameter integer DOA_REG = 0;
    parameter integer DOB_REG = 0;
    parameter EN_ECC_READ = "FALSE";
    parameter EN_ECC_WRITE = "FALSE";
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
    parameter INVERT_CLK_DOA_REG = "FALSE";
    parameter INVERT_CLK_DOB_REG = "FALSE";
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

    output CASCADEOUTA;
    output CASCADEOUTB;
    output [31:0] DOA;
    output [31:0] DOB;
    output [3:0] DOPA;
    output [3:0] DOPB;

    input ENA, CLKA, SSRA, CASCADEINA, REGCEA;
    input ENB, CLKB, SSRB, CASCADEINB, REGCEB;
    input [14:0] ADDRA;
    input [14:0] ADDRB;
    input [31:0] DIA;
    input [31:0] DIB;
    input [3:0] DIPA;
    input [3:0] DIPB;
    input [3:0] WEA;
    input [3:0] WEB;
    
    tri0 GSR = glbl.GSR;

    reg [31:0] doa_out = 32'b0, dob_out = 32'b0, doa_outreg = 32'b0, dob_outreg = 32'b0;
    reg [3:0] dopa_out = 4'b0, dopb_out = 4'b0, dopa_outreg = 4'b0, dopb_outreg = 4'b0;
    reg cascadeouta_out, cascadeoutb_out;
    reg notifier, notifier_a, notifier_b;
    wire [14:0] addra_in, addrb_in;
    wire [31:0] dangle_out32;
    wire [31:0] dia_in, dib_in, doa_wire, dob_wire;
    wire [3:0] dangle_out4;
    wire [3:0] wea_in, web_in, dipa_in, dipb_in, dopa_wire, dopb_wire;
    wire [7:0] dangle_out8;
    wire cascadeoutlata_wire, cascadeoutlatb_wire, cascadeoutrega_wire, cascadeoutregb_wire;
    wire dangle_out;
    wire clka_in, clkb_in, clka_wire, clkb_wire;
    wire cascadeina_in, cascadeinb_in, ena_in, enb_in;
    wire regcea_in, regceb_in, ssra_in, ssrb_in;
    
    
    buf b_addra[14:0] (addra_in, ADDRA);
    buf b_addrb[14:0] (addrb_in, ADDRB);
    buf b_clka (clka_in, CLKA);
    buf b_clkb (clkb_in, CLKB);
    
    buf b_dia[31:0] (dia_in, DIA);
    buf b_dib[31:0] (dib_in, DIB);
    buf b_dipa[3:0] (dipa_in, DIPA);
    buf b_dipb[3:0] (dipb_in, DIPB);
    buf b_doa[31:0] (DOA, doa_out);
    buf b_dopa[3:0] (DOPA, dopa_out);
    buf b_dob[31:0] (DOB, dob_out);
    buf b_dopb[3:0] (DOPB, dopb_out);
    buf b_cascadeina (cascadeina_in, CASCADEINA);
    buf b_cascadeinb (cascadeinb_in, CASCADEINB);
    buf b_cascadeouta (CASCADEOUTA, cascadeouta_out);
    buf b_cascadeoutb (CASCADEOUTB, cascadeoutb_out);

    buf b_ena (ena_in, ENA);
    buf b_enb (enb_in, ENB);
    buf b_regcea (regcea_in, REGCEA);
    buf b_regceb (regceb_in, REGCEB);
    buf b_ssra (ssra_in, SSRA);
    buf b_ssrb (ssrb_in, SSRB);
    buf b_wea[3:0] (wea_in, WEA);
    buf b_web[3:0] (web_in, WEB);

    assign clka_wire = (DOA_REG == 1 && INVERT_CLK_DOA_REG == "TRUE") ? ~clka_in : clka_in;
    assign clkb_wire = (DOB_REG == 1 && INVERT_CLK_DOB_REG == "TRUE") ? ~clkb_in : clkb_in;
    

    always @(cascadeoutrega_wire or cascadeoutlata_wire)
	if (DOA_REG == 1)
	    cascadeouta_out = cascadeoutrega_wire;
	else
	    cascadeouta_out = cascadeoutlata_wire;
    
    
    always @(cascadeoutregb_wire or cascadeoutlatb_wire)
	if (DOB_REG == 1)
	    cascadeoutb_out = cascadeoutregb_wire;
	else
	    cascadeoutb_out = cascadeoutlatb_wire;
    
    
    initial begin

	if ((INVERT_CLK_DOA_REG == "TRUE") && (DOA_REG != 1)) begin
            $display("Attribute Syntax Error : When INVERT_CLK_DOA_REG is set to TRUE, then DOA_REG has to be set to 1.");
            $finish;
        end

	if ((INVERT_CLK_DOB_REG == "TRUE") && (DOB_REG != 1)) begin
            $display("Attribute Syntax Error : When INVERT_CLK_DOB_REG is set to TRUE, then DOB_REG has to be set to 1.");
            $finish;
        end

	if ((INVERT_CLK_DOA_REG != "FALSE") && (INVERT_CLK_DOA_REG != "TRUE")) begin
            $display("Attribute Syntax Error : The attribute INVERT_CLK_DOA_REG on X_RAMB16 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", INVERT_CLK_DOA_REG);
            $finish;
        end

	if ((INVERT_CLK_DOB_REG != "FALSE") && (INVERT_CLK_DOB_REG != "TRUE")) begin
            $display("Attribute Syntax Error : The attribute INVERT_CLK_DOB_REG on X_RAMB16 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", INVERT_CLK_DOB_REG);
            $finish;
        end

    end
    
    
    always @(posedge clka_in or doa_wire or dopa_wire) begin

	if (!(DOA_REG == 1 && INVERT_CLK_DOA_REG == "TRUE")) begin
	
	    if (EN_ECC_READ == "TRUE") begin
		
		doa_outreg <= doa_wire;
		doa_out <= doa_outreg;
		dopa_outreg <= dopa_wire;
		dopa_out <= dopa_outreg;
		
	    end
	    else begin
		doa_out <= doa_wire;
		dopa_out <= dopa_wire;
	    end
	    
	end // if (!(DOA_REG == 1 && INVERT_CLK_DOA_REG == "TRUE"))

    end // always @ (posedge clka_in or doa_wire or dopa_wire)
    

    always @(negedge clka_in or doa_wire or dopa_wire) begin

	if (DOA_REG == 1 && INVERT_CLK_DOA_REG == "TRUE") begin
	
	    if (EN_ECC_READ == "TRUE") begin
		
		doa_outreg <= doa_wire;
		doa_out <= doa_outreg;
		dopa_outreg <= dopa_wire;
		dopa_out <= dopa_outreg;
		
	    end
	    else begin
		doa_out <= doa_wire;
		dopa_out <= dopa_wire;
	    end
	    
	end // if (DOA_REG == 1 && INVERT_CLK_DOA_REG == "TRUE")

    end // always @ (negedge clka_in or doa_wire or dopa_wire)


    always @(posedge clkb_in or dob_wire or dopb_wire) begin

	if (!(DOB_REG == 1 && INVERT_CLK_DOB_REG == "TRUE")) begin
	
	    if (EN_ECC_READ == "TRUE") begin
		
		dob_outreg <= dob_wire;
		dob_out <= dob_outreg;
		dopb_outreg <= dopb_wire;
		dopb_out <= dopb_outreg;
		
	    end
	    else begin
		dob_out <= dob_wire;
		dopb_out <= dopb_wire;
	    end
	    
	end // if (!(DOB_REG == 1 && INVERT_CLK_DOB_REG == "TRUE"))

    end // always @ (posedge clkb_in or dob_wire or dopb_wire)
    

    always @(negedge clkb_in or dob_wire or dopb_wire) begin

	if (DOB_REG == 1 && INVERT_CLK_DOB_REG == "TRUE") begin
	
	    if (EN_ECC_READ == "TRUE") begin
		
		dob_outreg <= dob_wire;
		dob_out <= dob_outreg;
		dopb_outreg <= dopb_wire;
		dopb_out <= dopb_outreg;
		
	    end
	    else begin
		dob_out <= dob_wire;
		dopb_out <= dopb_wire;
	    end
	    
	end // if (DOB_REG == 1 && INVERT_CLK_DOB_REG == "TRUE")

    end // always @ (negedge clkb_in or dob_wire or dopb_wire)

    
    X_ARAMB36_INTERNAL INT_RAMB (.DIA({32'b0,dia_in}), .ENA(ena_in), .WEA({2{wea_in}}), .SSRA(ssra_in), .ADDRA({addra_in[14],1'b0,addra_in[13:0]}), .CLKA(clka_in), .DOA({dangle_out32,doa_wire}), .DIB({32'b0,dib_in}), .ENB(enb_in), .WEB({2{web_in}}), .SSRB(ssrb_in), .ADDRB({addrb_in[14],1'b0,addrb_in[13:0]}), .CLKB(clkb_in), .DOB(dob_wire), .GSR(GSR), .DOPA({dangle_out4,dopa_wire}), .DOPB(dopb_wire), .DIPA(dipa_in), .DIPB({4'b0,dipb_in}), .CASCADEOUTLATA(cascadeoutlata_wire), .CASCADEOUTLATB(cascadeoutlatb_wire), .CASCADEOUTREGA(cascadeoutrega_wire), .CASCADEOUTREGB(cascadeoutregb_wire), .CASCADEINLATA(cascadeina_in), .CASCADEINLATB(cascadeinb_in), .CASCADEINREGA(cascadeina_in), .CASCADEINREGB(cascadeinb_in), .REGCEA(regcea_in), .REGCEB(regceb_in), .REGCLKA(clka_wire), .REGCLKB(clkb_wire), .DBITERR(dangle_out), .ECCPARITY(dangle_out8), .SBITERR(dangle_out));

    defparam INT_RAMB.BRAM_SIZE = 16;
    defparam INT_RAMB.BRAM_MODE = "TRUE_DUAL_PORT";
    defparam INT_RAMB.INIT_A = INIT_A;
    defparam INT_RAMB.INIT_B = INIT_B;
    defparam INT_RAMB.INIT_FILE = INIT_FILE;
    defparam INT_RAMB.SRVAL_A = SRVAL_A;
    defparam INT_RAMB.SRVAL_B = SRVAL_B;
    defparam INT_RAMB.RAM_EXTENSION_A = RAM_EXTENSION_A;
    defparam INT_RAMB.RAM_EXTENSION_B = RAM_EXTENSION_B;
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
    wire dia2_enable = ena_in && wea_in[2];
    wire dia3_enable = ena_in && wea_in[3];
    wire dib0_enable = enb_in && web_in[0];
    wire dib1_enable = enb_in && web_in[1];
    wire dib2_enable = enb_in && web_in[2];
    wire dib3_enable = enb_in && web_in[3];
    
    always @(notifier or notifier_a) begin
	doa_out <= 32'bx;
	dopa_out <= 4'bx;
	cascadeouta_out <= 1'bx;
    end

    always @(notifier or notifier_b) begin
	dob_out <= 32'bx;
	dopb_out <= 4'bx;
	cascadeoutb_out <= 1'bx;
    end
    
    specify

	(CASCADEINA => DOA[0]) = (0:0:0, 0:0:0);
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
	(CLKA => CASCADEOUTA) = (100:100:100, 100:100:100);

	(CASCADEINB => DOB[0]) = (0:0:0, 0:0:0);
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
	(CLKB => CASCADEOUTB) = (100:100:100, 100:100:100);
	
       	$setuphold (posedge CLKA, posedge ADDRA[0] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[0] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ADDRA[1] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[1] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ADDRA[2] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[2] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ADDRA[3] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[3] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ADDRA[4] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[4] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ADDRA[5] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[5] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ADDRA[6] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[6] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ADDRA[7] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[7] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ADDRA[8] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[8] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ADDRA[9] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[9] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ADDRA[10] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[10] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ADDRA[11] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[11] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ADDRA[12] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[12] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ADDRA[13] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[13] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge ADDRA[14] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge ADDRA[14] &&& ENA, 0:0:0, 0:0:0, notifier_a);
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
       	$setuphold (negedge CLKA, posedge REGCEA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (negedge CLKA, negedge REGCEA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge SSRA &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge SSRA &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge WEA[0] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge WEA[0] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge WEA[1] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge WEA[1] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge WEA[2] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge WEA[2] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, posedge WEA[3] &&& ENA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge WEA[3] &&& ENA, 0:0:0, 0:0:0, notifier_a);
	$setuphold (posedge CLKA, posedge CASCADEINA, 0:0:0, 0:0:0, notifier_a);
       	$setuphold (posedge CLKA, negedge CASCADEINA, 0:0:0, 0:0:0, notifier_a);
	
       	$setuphold (posedge CLKB, posedge ADDRB[0] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[0] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ADDRB[1] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[1] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ADDRB[2] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[2] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ADDRB[3] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[3] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ADDRB[4] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[4] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ADDRB[5] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[5] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ADDRB[6] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[6] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ADDRB[7] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[7] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ADDRB[8] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[8] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ADDRB[9] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[9] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ADDRB[10] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[10] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ADDRB[11] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[11] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ADDRB[12] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[12] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ADDRB[13] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[13] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge ADDRB[14] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge ADDRB[14] &&& ENB, 0:0:0, 0:0:0, notifier_b);
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
       	$setuphold (negedge CLKB, posedge REGCEB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (negedge CLKB, negedge REGCEB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge SSRB &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge SSRB &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge WEB[0] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge WEB[0] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge WEB[1] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge WEB[1] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge WEB[2] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge WEB[2] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, posedge WEB[3] &&& ENB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge WEB[3] &&& ENB, 0:0:0, 0:0:0, notifier_b);
	$setuphold (posedge CLKB, posedge CASCADEINB, 0:0:0, 0:0:0, notifier_b);
       	$setuphold (posedge CLKB, negedge CASCADEINB, 0:0:0, 0:0:0, notifier_b);
	
	$period (posedge CLKA, 0:0:0, notifier_a);
	$period (posedge CLKB, 0:0:0, notifier_b);
	
        $width (posedge CLKA &&& ENA, 0:0:0, 0, notifier_a);
        $width (negedge CLKA &&& ENA, 0:0:0, 0, notifier_a);
        $width (posedge CLKB &&& ENB, 0:0:0, 0, notifier_b);
        $width (negedge CLKB &&& ENB, 0:0:0, 0, notifier_b);
	
	specparam PATHPULSE$ = 0;

    endspecify

endmodule // X_RAMB16

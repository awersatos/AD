// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2007 by Lattice Semiconductor Corporation
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
// Simulation Library File for ECP3
//
// $Header:
//

`celldefine
`timescale  1 ns / 1 ps

module ALU54A (A35,A34,A33,A32,A31,A30,A29,A28,A27,A26,A25,A24,A23,A22,A21,A20,A19,A18,
A17,A16,A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0,
B35,B34,B33,B32,B31,B30,B29,B28,B27,B26,B25,B24,B23,B22,B21,B20,B19,B18,
B17,B16,B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0,
CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3,SIGNEDIA, SIGNEDIB, SIGNEDCIN,
C53,C52,C51,C50,C49,C48,C47,C46,C45,C44,C43,C42,C41,C40,C39,C38,C37,C36,
C35,C34,C33,C32,C31,C30,C29,C28,C27,C26,C25,C24,C23,C22,C21,C20,C19,C18,
C17,C16,C15,C14,C13,C12,C11,C10,C9,C8,C7,C6,C5,C4,C3,C2,C1,C0,
MA35,MA34,MA33,MA32,MA31,MA30,MA29,MA28,MA27,MA26,MA25,MA24,MA23,MA22,MA21,MA20,MA19,MA18,
MA17,MA16,MA15,MA14,MA13,MA12,MA11,MA10,MA9,MA8,MA7,MA6,MA5,MA4,MA3,MA2,MA1,MA0,
MB35,MB34,MB33,MB32,MB31,MB30,MB29,MB28,MB27,MB26,MB25,MB24,MB23,MB22,MB21,MB20,MB19,MB18,
MB17,MB16,MB15,MB14,MB13,MB12,MB11,MB10,MB9,MB8,MB7,MB6,MB5,MB4,MB3,MB2,MB1,MB0,
CIN53,CIN52,CIN51,CIN50,CIN49,CIN48,CIN47,CIN46,CIN45,CIN44,CIN43,CIN42,CIN41,CIN40,CIN39,
CIN38,CIN37,CIN36,CIN35,CIN34,CIN33,CIN32,CIN31,CIN30,CIN29,CIN28,
CIN27,CIN26,CIN25,CIN24,CIN23,CIN22,CIN21,CIN20,CIN19,CIN18,CIN17,CIN16,CIN15,CIN14,
CIN13,CIN12,CIN11,CIN10,CIN9,CIN8,CIN7,CIN6,CIN5,CIN4,CIN3,CIN2,CIN1,CIN0,
OP10,OP9,OP8,OP7,OP6,OP5,OP4,OP3,OP2,OP1,OP0,
R53,R52,R51,R50,R49,R48,R47,R46,R45,R44,R43,R42,R41,R40,R39,R38,R37,R36,
R35,R34,R33,R32,R31,R30,R29,R28,R27,R26,R25,R24,R23,R22,R21,R20,R19,R18,
R17,R16,R15,R14,R13,R12,R11,R10,R9,R8,R7,R6,R5,R4,R3,R2,R1,R0,
EQZ,EQZM,EQOM,EQPAT,EQPATB,OVER,UNDER,OVERUNDER,SIGNEDR);

input A35,A34,A33,A32,A31,A30,A29,A28,A27,A26,A25,A24,A23,A22,A21,A20,A19,A18;
input A17,A16,A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0;
input B35,B34,B33,B32,B31,B30,B29,B28,B27,B26,B25,B24,B23,B22,B21,B20,B19,B18;
input B17,B16,B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0;
input CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3,SIGNEDIA, SIGNEDIB, SIGNEDCIN;
input C53,C52,C51,C50,C49,C48,C47,C46,C45,C44,C43,C42,C41,C40,C39,C38,C37,C36;
input C35,C34,C33,C32,C31,C30,C29,C28,C27,C26,C25,C24,C23,C22,C21,C20,C19,C18;
input C17,C16,C15,C14,C13,C12,C11,C10,C9,C8,C7,C6,C5,C4,C3,C2,C1,C0;
input MA35,MA34,MA33,MA32,MA31,MA30,MA29,MA28,MA27,MA26,MA25,MA24,MA23,MA22,MA21,MA20,MA19,MA18;
input MA17,MA16,MA15,MA14,MA13,MA12,MA11,MA10,MA9,MA8,MA7,MA6,MA5,MA4,MA3,MA2,MA1,MA0;
input MB35,MB34,MB33,MB32,MB31,MB30,MB29,MB28,MB27,MB26,MB25,MB24,MB23,MB22,MB21,MB20,MB19,MB18;
input MB17,MB16,MB15,MB14,MB13,MB12,MB11,MB10,MB9,MB8,MB7,MB6,MB5,MB4,MB3,MB2,MB1,MB0;
input CIN53,CIN52,CIN51,CIN50,CIN49,CIN48,CIN47,CIN46,CIN45,CIN44,CIN43,CIN42,CIN41,CIN40,CIN39;
input CIN38,CIN37,CIN36,CIN35,CIN34,CIN33,CIN32,CIN31,CIN30,CIN29,CIN28;
input CIN27,CIN26,CIN25,CIN24,CIN23,CIN22,CIN21,CIN20,CIN19,CIN18,CIN17,CIN16,CIN15,CIN14;
input CIN13,CIN12,CIN11,CIN10,CIN9,CIN8,CIN7,CIN6,CIN5,CIN4,CIN3,CIN2,CIN1,CIN0;
input OP10,OP9,OP8,OP7,OP6,OP5,OP4,OP3,OP2,OP1,OP0;
output R53,R52,R51,R50,R49,R48,R47,R46,R45,R44,R43,R42,R41,R40,R39,R38,R37,R36;
output R35,R34,R33,R32,R31,R30,R29,R28,R27,R26,R25,R24,R23,R22,R21,R20,R19,R18;
output R17,R16,R15,R14,R13,R12,R11,R10,R9,R8,R7,R6,R5,R4,R3,R2,R1,R0;
output EQZ,EQZM,EQOM,EQPAT,EQPATB,OVER,UNDER,OVERUNDER,SIGNEDR;

parameter REG_INPUTC0_CLK = "NONE";
parameter REG_INPUTC0_CE = "CE0";
parameter REG_INPUTC0_RST = "RST0";
parameter REG_INPUTC1_CLK = "NONE";
parameter REG_INPUTC1_CE = "CE0";
parameter REG_INPUTC1_RST = "RST0";
parameter REG_OPCODEOP0_0_CLK = "NONE";
parameter REG_OPCODEOP0_0_CE = "CE0";
parameter REG_OPCODEOP0_0_RST = "RST0";
parameter REG_OPCODEOP1_0_CLK = "NONE";
//parameter REG_OPCODEOP1_0_CE = "CE0";
//parameter REG_OPCODEOP1_0_RST = "RST0";
parameter REG_OPCODEOP0_1_CLK = "NONE";
parameter REG_OPCODEOP0_1_CE = "CE0";
parameter REG_OPCODEOP0_1_RST = "RST0";
parameter REG_OPCODEOP1_1_CLK = "NONE";
//parameter REG_OPCODEOP1_1_CE = "CE0";
//parameter REG_OPCODEOP1_1_RST = "RST0";
parameter REG_OPCODEIN_0_CLK = "NONE";
parameter REG_OPCODEIN_0_CE = "CE0";
parameter REG_OPCODEIN_0_RST = "RST0";
parameter REG_OPCODEIN_1_CLK = "NONE";
parameter REG_OPCODEIN_1_CE = "CE0";
parameter REG_OPCODEIN_1_RST = "RST0";
parameter REG_OUTPUT0_CLK = "NONE";
parameter REG_OUTPUT0_CE = "CE0";
parameter REG_OUTPUT0_RST = "RST0";
parameter REG_OUTPUT1_CLK = "NONE";
parameter REG_OUTPUT1_CE = "CE0";
parameter REG_OUTPUT1_RST = "RST0";
parameter REG_FLAG_CLK = "NONE";
parameter REG_FLAG_CE = "CE0";
parameter REG_FLAG_RST = "RST0";
parameter MCPAT_SOURCE = "STATIC";
parameter MASKPAT_SOURCE = "STATIC";
parameter MASK01 = "0x00000000000000";
parameter MCPAT = "0x00000000000000";
parameter MASKPAT = "0x00000000000000";
parameter RNDPAT = "0x00000000000000";
parameter GSR = "ENABLED";
parameter RESETMODE = "SYNC";
parameter MULT9_MODE = "DISABLED";
parameter LEGACY = "DISABLED";

    wire CE0b,CE1b,CE2b,CE3b,CLK0b,CLK1b,CLK2b,CLK3b,RST0b,RST1b,RST2b,RST3b;
    wire [35:0] a_sig, b_sig, ma_sig, mb_sig;
    wire [53:0] c_sig, cin_sig;
    wire [10:0] op_sig;
    wire [53:0] rnd_pattern_m1;
    wire eqnor_sig, eqz_sig, eqzm_sig, eqom_sig, eqpatb_sig, eqpat_sig, over_sig, under_sig;
    wire signedr_sig, signedcin_sig;
    reg over_under_sel, overunder_sig;
    
    reg eqz_async, eqzm_async, eqom_async, eqpatb_async, eqpat_async, over_async;
    reg under_async, overunder_async;
    reg eqz_sync, eqzm_sync, eqom_sync, eqpatb_sync, eqpat_sync, over_sync;
    reg under_sync, overunder_sync;
    reg eqz_reg, eqzm_reg, eqom_reg, eqpatb_reg, eqpat_reg, over_reg;
    reg under_reg, overunder_reg;
    reg eqz_gen, eqzm_gen, eqom_gen, eqpatb_gen, eqpat_gen, over_gen;
    reg under_gen, overunder_gen;
 
    reg [53:0] mcpat_sel, maskpat_sel;
    reg input_c_clk_sig0, input_c_ce_sig0, input_c_rst_sig0;
    reg input_c_clk_sig1, input_c_ce_sig1, input_c_rst_sig1;
    reg output0_clk_sig, output0_ce_sig, output0_rst_sig;
    reg output1_clk_sig, output1_ce_sig, output1_rst_sig;
    reg flag_clk_sig, flag_ce_sig, flag_rst_sig;
    reg opcodein_0_clk_sig, opcodein_0_ce_sig, opcodein_0_rst_sig;
    reg opcodein_1_clk_sig, opcodein_1_ce_sig, opcodein_1_rst_sig;
    reg opcodeop0_0_clk_sig, opcodeop0_0_ce_sig, opcodeop0_0_rst_sig;
    reg opcodeop0_1_clk_sig, opcodeop0_1_ce_sig, opcodeop0_1_rst_sig;
    reg opcodeop1_0_clk_sig, opcodeop1_0_ce_sig, opcodeop1_0_rst_sig;
    reg opcodeop1_1_clk_sig, opcodeop1_1_ce_sig, opcodeop1_1_rst_sig;

    wire [10:0] op_sig_gen_new;
    reg [6:0] opin_sig_0_reg, opin_sig_1_reg, opin_sig_0_async, opin_sig_0_sync;
    reg [6:0] opin_sig_1_async, opin_sig_1_sync, opin_sig_gen_0, opin_sig_gen_1;
    reg  op7_sig_0_reg, op7_sig_1_reg, op7_sig_0_async, op7_sig_0_sync;
    reg  op7_sig_1_async, op7_sig_1_sync, op7_sig_gen_0, op7_sig_gen_1;
    reg [2:0] op10_sig_0_reg, op10_sig_1_reg, op10_sig_0_async, op10_sig_0_sync;
    reg [2:0] op10_sig_1_async, op10_sig_1_sync, op10_sig_gen_0, op10_sig_gen_1;
    reg [26:0] c_sig_reg0, c_sig_async0, c_sig_sync0, c_sig_gen0;
    reg [26:0] c_sig_reg1, c_sig_async1, c_sig_sync1, c_sig_gen1;
    wire [53:0] c_sig_gen_new;
    reg [53:0] ma_sig_m, mb_sig_m, mb_shift_sig;
    reg [17:0] r_out_lsb, r_out_lsb_async, r_out_lsb_sync, r_out_lsb_gen;
    reg [53:18] r_out_msb, r_out_msb_async, r_out_msb_sync, r_out_msb_gen;
    reg [53:0] cin_shift_sig, a_mux, b_mux, c_mux, r_sig;

    reg [52:0] r_out1;
    reg [53:0] r_out;
    reg [53:0] mask01_sig;
    reg [53:0] mcpat_sig;
    reg [53:0] maskpat_sig;
    reg [53:0] rnd_pattern;
    reg [128:0] mask01_sig0;
    reg [128:0] mcpat_sig0;
    reg [128:0] maskpat_sig0;
    reg [128:0] rnd_pattern0;
    integer i;

initial
begin
r_out = 54'b0;
end

function [3:0] convert_hex;
input [7:0] int_str;
  begin

    if (int_str == "0")
      convert_hex = 4'b0000;
    else if (int_str == "1")
      convert_hex = 4'b0001;
    else if (int_str == "2")
      convert_hex = 4'b0010;
    else if (int_str == "3")
      convert_hex = 4'b0011;
    else if (int_str == "4")
      convert_hex = 4'b0100;
    else if (int_str == "5")
      convert_hex = 4'b0101;
    else if (int_str == "6")
      convert_hex = 4'b0110;
    else if (int_str == "7")
      convert_hex = 4'b0111;
    else if (int_str == "8")
      convert_hex = 4'b1000;
    else if (int_str == "9")
      convert_hex = 4'b1001;
    else if (int_str == "a" || int_str == "A")
      convert_hex = 4'b1010;
    else if (int_str == "b" || int_str == "B")
      convert_hex = 4'b1011;
    else if (int_str == "c" || int_str == "C")
      convert_hex = 4'b1100;
    else if (int_str == "d" || int_str == "D")
      convert_hex = 4'b1101;
    else if (int_str == "e" || int_str == "E")
      convert_hex = 4'b1110;
    else if (int_str == "f" || int_str == "F")
      convert_hex = 4'b1111;
    else
      convert_hex = 4'b0000;

  end
endfunction

initial
begin
mask01_sig0 = MASK01;
mcpat_sig0 = MCPAT;
maskpat_sig0 = MASKPAT;
rnd_pattern0 = RNDPAT;

   for (i = 0; i < 14; i = i+1)
   begin
      {mask01_sig[(i*4)+3], mask01_sig[(i*4)+2], mask01_sig[(i*4)+1], mask01_sig[i*4]} = convert_hex(mask01_sig0[7:0]);
      {mcpat_sig[(i*4)+3], mcpat_sig[(i*4)+2], mcpat_sig[(i*4)+1], mcpat_sig[i*4]} = convert_hex(mcpat_sig0[7:0]);
      {maskpat_sig[(i*4)+3], maskpat_sig[(i*4)+2], maskpat_sig[(i*4)+1], maskpat_sig[i*4]} = convert_hex(maskpat_sig0[7:0]);
      {rnd_pattern[(i*4)+3], rnd_pattern[(i*4)+2], rnd_pattern[(i*4)+1], rnd_pattern[i*4]} = convert_hex(rnd_pattern0[7:0]);
      mask01_sig0 = (mask01_sig0 >> 8);
      mcpat_sig0 = (mcpat_sig0 >> 8);
      maskpat_sig0 = (maskpat_sig0 >> 8);
      rnd_pattern0 = (rnd_pattern0 >> 8);
   end
end



    buf (CE0b, CE0);
    buf (CE1b, CE1);
    buf (CE2b, CE2);
    buf (CE3b, CE3);
    buf (CLK0b, CLK0);
    buf (CLK1b, CLK1);
    buf (CLK2b, CLK2);
    buf (CLK3b, CLK3);
    buf (RST0b, RST0);
    buf (RST1b, RST1);
    buf (RST2b, RST2);
    buf (RST3b, RST3);
    buf inst_s_SIGNEDA (signed1a_sig, SIGNEDIA);
    buf inst_s_SIGNEDB (signed1b_sig, SIGNEDIB);
    buf inst_s_SIGNEDCIN (signedcin_sig, SIGNEDCIN);

    buf inst_A0 (a_sig[0], A0);
    buf inst_A1 (a_sig[1], A1);
    buf inst_A2 (a_sig[2], A2);
    buf inst_A3 (a_sig[3], A3);
    buf inst_A4 (a_sig[4], A4);
    buf inst_A5 (a_sig[5], A5);
    buf inst_A6 (a_sig[6], A6);
    buf inst_A7 (a_sig[7], A7);
    buf inst_A8 (a_sig[8], A8);
    buf inst_A9 (a_sig[9], A9);
    buf inst_A10 (a_sig[10], A10);
    buf inst_A11 (a_sig[11], A11);
    buf inst_A12 (a_sig[12], A12);
    buf inst_A13 (a_sig[13], A13);
    buf inst_A14 (a_sig[14], A14);
    buf inst_A15 (a_sig[15], A15);
    buf inst_A16 (a_sig[16], A16);
    buf inst_A17 (a_sig[17], A17);
    buf inst_A18 (a_sig[18], A18);
    buf inst_A19 (a_sig[19], A19);
    buf inst_A20 (a_sig[20], A20);
    buf inst_A21 (a_sig[21], A21);
    buf inst_A22 (a_sig[22], A22);
    buf inst_A23 (a_sig[23], A23);
    buf inst_A24 (a_sig[24], A24);
    buf inst_A25 (a_sig[25], A25);
    buf inst_A26 (a_sig[26], A26);
    buf inst_A27 (a_sig[27], A27);
    buf inst_A28 (a_sig[28], A28);
    buf inst_A29 (a_sig[29], A29);
    buf inst_A30 (a_sig[30], A30);
    buf inst_A31 (a_sig[31], A31);
    buf inst_A32 (a_sig[32], A32);
    buf inst_A33 (a_sig[33], A33);
    buf inst_A34 (a_sig[34], A34);
    buf inst_A35 (a_sig[35], A35);

    buf inst_B0 (b_sig[0], B0);
    buf inst_B1 (b_sig[1], B1);
    buf inst_B2 (b_sig[2], B2);
    buf inst_B3 (b_sig[3], B3);
    buf inst_B4 (b_sig[4], B4);
    buf inst_B5 (b_sig[5], B5);
    buf inst_B6 (b_sig[6], B6);
    buf inst_B7 (b_sig[7], B7);
    buf inst_B8 (b_sig[8], B8);
    buf inst_B9 (b_sig[9], B9);
    buf inst_B10 (b_sig[10], B10);
    buf inst_B11 (b_sig[11], B11);
    buf inst_B12 (b_sig[12], B12);
    buf inst_B13 (b_sig[13], B13);
    buf inst_B14 (b_sig[14], B14);
    buf inst_B15 (b_sig[15], B15);
    buf inst_B16 (b_sig[16], B16);
    buf inst_B17 (b_sig[17], B17);
    buf inst_B18 (b_sig[18], B18);
    buf inst_B19 (b_sig[19], B19);
    buf inst_B20 (b_sig[20], B20);
    buf inst_B21 (b_sig[21], B21);
    buf inst_B22 (b_sig[22], B22);
    buf inst_B23 (b_sig[23], B23);
    buf inst_B24 (b_sig[24], B24);
    buf inst_B25 (b_sig[25], B25);
    buf inst_B26 (b_sig[26], B26);
    buf inst_B27 (b_sig[27], B27);
    buf inst_B28 (b_sig[28], B28);
    buf inst_B29 (b_sig[29], B29);
    buf inst_B30 (b_sig[30], B30);
    buf inst_B31 (b_sig[31], B31);
    buf inst_B32 (b_sig[32], B32);
    buf inst_B33 (b_sig[33], B33);
    buf inst_B34 (b_sig[34], B34);
    buf inst_B35 (b_sig[35], B35);

    buf inst_C0 (c_sig[0], C0);
    buf inst_C1 (c_sig[1], C1);
    buf inst_C2 (c_sig[2], C2);
    buf inst_C3 (c_sig[3], C3);
    buf inst_C4 (c_sig[4], C4);
    buf inst_C5 (c_sig[5], C5);
    buf inst_C6 (c_sig[6], C6);
    buf inst_C7 (c_sig[7], C7);
    buf inst_C8 (c_sig[8], C8);
    buf inst_C9 (c_sig[9], C9);
    buf inst_C10 (c_sig[10], C10);
    buf inst_C11 (c_sig[11], C11);
    buf inst_C12 (c_sig[12], C12);
    buf inst_C13 (c_sig[13], C13);
    buf inst_C14 (c_sig[14], C14);
    buf inst_C15 (c_sig[15], C15);
    buf inst_C16 (c_sig[16], C16);
    buf inst_C17 (c_sig[17], C17);
    buf inst_C18 (c_sig[18], C18);
    buf inst_C19 (c_sig[19], C19);
    buf inst_C20 (c_sig[20], C20);
    buf inst_C21 (c_sig[21], C21);
    buf inst_C22 (c_sig[22], C22);
    buf inst_C23 (c_sig[23], C23);
    buf inst_C24 (c_sig[24], C24);
    buf inst_C25 (c_sig[25], C25);
    buf inst_C26 (c_sig[26], C26);
    buf inst_C27 (c_sig[27], C27);
    buf inst_C28 (c_sig[28], C28);
    buf inst_C29 (c_sig[29], C29);
    buf inst_C30 (c_sig[30], C30);
    buf inst_C31 (c_sig[31], C31);
    buf inst_C32 (c_sig[32], C32);
    buf inst_C33 (c_sig[33], C33);
    buf inst_C34 (c_sig[34], C34);
    buf inst_C35 (c_sig[35], C35);
    buf inst_C36 (c_sig[36], C36);
    buf inst_C37 (c_sig[37], C37);
    buf inst_C38 (c_sig[38], C38);
    buf inst_C39 (c_sig[39], C39);
    buf inst_C40 (c_sig[40], C40);
    buf inst_C41 (c_sig[41], C41);
    buf inst_C42 (c_sig[42], C42);
    buf inst_C43 (c_sig[43], C43);
    buf inst_C44 (c_sig[44], C44);
    buf inst_C45 (c_sig[45], C45);
    buf inst_C46 (c_sig[46], C46);
    buf inst_C47 (c_sig[47], C47);
    buf inst_C48 (c_sig[48], C48);
    buf inst_C49 (c_sig[49], C49);
    buf inst_C50 (c_sig[50], C50);
    buf inst_C51 (c_sig[51], C51);
    buf inst_C52 (c_sig[52], C52);
    buf inst_C53 (c_sig[53], C53);

    buf inst_MA0 (ma_sig[0], MA0);
    buf inst_MA1 (ma_sig[1], MA1);
    buf inst_MA2 (ma_sig[2], MA2);
    buf inst_MA3 (ma_sig[3], MA3);
    buf inst_MA4 (ma_sig[4], MA4);
    buf inst_MA5 (ma_sig[5], MA5);
    buf inst_MA6 (ma_sig[6], MA6);
    buf inst_MA7 (ma_sig[7], MA7);
    buf inst_MA8 (ma_sig[8], MA8);
    buf inst_MA9 (ma_sig[9], MA9);
    buf inst_MA10 (ma_sig[10], MA10);
    buf inst_MA11 (ma_sig[11], MA11);
    buf inst_MA12 (ma_sig[12], MA12);
    buf inst_MA13 (ma_sig[13], MA13);
    buf inst_MA14 (ma_sig[14], MA14);
    buf inst_MA15 (ma_sig[15], MA15);
    buf inst_MA16 (ma_sig[16], MA16);
    buf inst_MA17 (ma_sig[17], MA17);
    buf inst_MA18 (ma_sig[18], MA18);
    buf inst_MA19 (ma_sig[19], MA19);
    buf inst_MA20 (ma_sig[20], MA20);
    buf inst_MA21 (ma_sig[21], MA21);
    buf inst_MA22 (ma_sig[22], MA22);
    buf inst_MA23 (ma_sig[23], MA23);
    buf inst_MA24 (ma_sig[24], MA24);
    buf inst_MA25 (ma_sig[25], MA25);
    buf inst_MA26 (ma_sig[26], MA26);
    buf inst_MA27 (ma_sig[27], MA27);
    buf inst_MA28 (ma_sig[28], MA28);
    buf inst_MA29 (ma_sig[29], MA29);
    buf inst_MA30 (ma_sig[30], MA30);
    buf inst_MA31 (ma_sig[31], MA31);
    buf inst_MA32 (ma_sig[32], MA32);
    buf inst_MA33 (ma_sig[33], MA33);
    buf inst_MA34 (ma_sig[34], MA34);
    buf inst_MA35 (ma_sig[35], MA35);

    buf inst_MB0 (mb_sig[0], MB0);
    buf inst_MB1 (mb_sig[1], MB1);
    buf inst_MB2 (mb_sig[2], MB2);
    buf inst_MB3 (mb_sig[3], MB3);
    buf inst_MB4 (mb_sig[4], MB4);
    buf inst_MB5 (mb_sig[5], MB5);
    buf inst_MB6 (mb_sig[6], MB6);
    buf inst_MB7 (mb_sig[7], MB7);
    buf inst_MB8 (mb_sig[8], MB8);
    buf inst_MB9 (mb_sig[9], MB9);
    buf inst_MB10 (mb_sig[10], MB10);
    buf inst_MB11 (mb_sig[11], MB11);
    buf inst_MB12 (mb_sig[12], MB12);
    buf inst_MB13 (mb_sig[13], MB13);
    buf inst_MB14 (mb_sig[14], MB14);
    buf inst_MB15 (mb_sig[15], MB15);
    buf inst_MB16 (mb_sig[16], MB16);
    buf inst_MB17 (mb_sig[17], MB17);
    buf inst_MB18 (mb_sig[18], MB18);
    buf inst_MB19 (mb_sig[19], MB19);
    buf inst_MB20 (mb_sig[20], MB20);
    buf inst_MB21 (mb_sig[21], MB21);
    buf inst_MB22 (mb_sig[22], MB22);
    buf inst_MB23 (mb_sig[23], MB23);
    buf inst_MB24 (mb_sig[24], MB24);
    buf inst_MB25 (mb_sig[25], MB25);
    buf inst_MB26 (mb_sig[26], MB26);
    buf inst_MB27 (mb_sig[27], MB27);
    buf inst_MB28 (mb_sig[28], MB28);
    buf inst_MB29 (mb_sig[29], MB29);
    buf inst_MB30 (mb_sig[30], MB30);
    buf inst_MB31 (mb_sig[31], MB31);
    buf inst_MB32 (mb_sig[32], MB32);
    buf inst_MB33 (mb_sig[33], MB33);
    buf inst_MB34 (mb_sig[34], MB34);
    buf inst_MB35 (mb_sig[35], MB35);

    buf inst_CIN0 (cin_sig[0], CIN0);
    buf inst_CIN1 (cin_sig[1], CIN1);
    buf inst_CIN2 (cin_sig[2], CIN2);
    buf inst_CIN3 (cin_sig[3], CIN3);
    buf inst_CIN4 (cin_sig[4], CIN4);
    buf inst_CIN5 (cin_sig[5], CIN5);
    buf inst_CIN6 (cin_sig[6], CIN6);
    buf inst_CIN7 (cin_sig[7], CIN7);
    buf inst_CIN8 (cin_sig[8], CIN8);
    buf inst_CIN9 (cin_sig[9], CIN9);
    buf inst_CIN10 (cin_sig[10], CIN10);
    buf inst_CIN11 (cin_sig[11], CIN11);
    buf inst_CIN12 (cin_sig[12], CIN12);
    buf inst_CIN13 (cin_sig[13], CIN13);
    buf inst_CIN14 (cin_sig[14], CIN14);
    buf inst_CIN15 (cin_sig[15], CIN15);
    buf inst_CIN16 (cin_sig[16], CIN16);
    buf inst_CIN17 (cin_sig[17], CIN17);
    buf inst_CIN18 (cin_sig[18], CIN18);
    buf inst_CIN19 (cin_sig[19], CIN19);
    buf inst_CIN20 (cin_sig[20], CIN20);
    buf inst_CIN21 (cin_sig[21], CIN21);
    buf inst_CIN22 (cin_sig[22], CIN22);
    buf inst_CIN23 (cin_sig[23], CIN23);
    buf inst_CIN24 (cin_sig[24], CIN24);
    buf inst_CIN25 (cin_sig[25], CIN25);
    buf inst_CIN26 (cin_sig[26], CIN26);
    buf inst_CIN27 (cin_sig[27], CIN27);
    buf inst_CIN28 (cin_sig[28], CIN28);
    buf inst_CIN29 (cin_sig[29], CIN29);
    buf inst_CIN30 (cin_sig[30], CIN30);
    buf inst_CIN31 (cin_sig[31], CIN31);
    buf inst_CIN32 (cin_sig[32], CIN32);
    buf inst_CIN33 (cin_sig[33], CIN33);
    buf inst_CIN34 (cin_sig[34], CIN34);
    buf inst_CIN35 (cin_sig[35], CIN35);
    buf inst_CIN36 (cin_sig[36], CIN36);
    buf inst_CIN37 (cin_sig[37], CIN37);
    buf inst_CIN38 (cin_sig[38], CIN38);
    buf inst_CIN39 (cin_sig[39], CIN39);
    buf inst_CIN40 (cin_sig[40], CIN40);
    buf inst_CIN41 (cin_sig[41], CIN41);
    buf inst_CIN42 (cin_sig[42], CIN42);
    buf inst_CIN43 (cin_sig[43], CIN43);
    buf inst_CIN44 (cin_sig[44], CIN44);
    buf inst_CIN45 (cin_sig[45], CIN45);
    buf inst_CIN46 (cin_sig[46], CIN46);
    buf inst_CIN47 (cin_sig[47], CIN47);
    buf inst_CIN48 (cin_sig[48], CIN48);
    buf inst_CIN49 (cin_sig[49], CIN49);
    buf inst_CIN50 (cin_sig[50], CIN50);
    buf inst_CIN51 (cin_sig[51], CIN51);
    buf inst_CIN52 (cin_sig[52], CIN52);
    buf inst_CIN53 (cin_sig[53], CIN53);

    buf inst_OP0 (op_sig[0], OP0);
    buf inst_OP1 (op_sig[1], OP1);
    buf inst_OP2 (op_sig[2], OP2);
    buf inst_OP3 (op_sig[3], OP3);
    buf inst_OP4 (op_sig[4], OP4);
    buf inst_OP5 (op_sig[5], OP5);
    buf inst_OP6 (op_sig[6], OP6);
    buf inst_OP7 (op_sig[7], OP7);
    buf inst_OP8 (op_sig[8], OP8);
    buf inst_OP9 (op_sig[9], OP9);
    buf inst_OP10 (op_sig[10], OP10);

    buf inst_R0 (R0, r_sig[0]);
    buf inst_R1 (R1, r_sig[1]);
    buf inst_R2 (R2, r_sig[2]);
    buf inst_R3 (R3, r_sig[3]);
    buf inst_R4 (R4, r_sig[4]);
    buf inst_R5 (R5, r_sig[5]);
    buf inst_R6 (R6, r_sig[6]);
    buf inst_R7 (R7, r_sig[7]);
    buf inst_R8 (R8, r_sig[8]);
    buf inst_R9 (R9, r_sig[9]);
    buf inst_R10 (R10, r_sig[10]);
    buf inst_R11 (R11, r_sig[11]);
    buf inst_R12 (R12, r_sig[12]);
    buf inst_R13 (R13, r_sig[13]);
    buf inst_R14 (R14, r_sig[14]);
    buf inst_R15 (R15, r_sig[15]);
    buf inst_R16 (R16, r_sig[16]);
    buf inst_R17 (R17, r_sig[17]);
    buf inst_R18 (R18, r_sig[18]);
    buf inst_R19 (R19, r_sig[19]);
    buf inst_R20 (R20, r_sig[20]);
    buf inst_R21 (R21, r_sig[21]);
    buf inst_R22 (R22, r_sig[22]);
    buf inst_R23 (R23, r_sig[23]);
    buf inst_R24 (R24, r_sig[24]);
    buf inst_R25 (R25, r_sig[25]);
    buf inst_R26 (R26, r_sig[26]);
    buf inst_R27 (R27, r_sig[27]);
    buf inst_R28 (R28, r_sig[28]);
    buf inst_R29 (R29, r_sig[29]);
    buf inst_R30 (R30, r_sig[30]);
    buf inst_R31 (R31, r_sig[31]);
    buf inst_R32 (R32, r_sig[32]);
    buf inst_R33 (R33, r_sig[33]);
    buf inst_R34 (R34, r_sig[34]);
    buf inst_R35 (R35, r_sig[35]);
    buf inst_R36 (R36, r_sig[36]);
    buf inst_R37 (R37, r_sig[37]);
    buf inst_R38 (R38, r_sig[38]);
    buf inst_R39 (R39, r_sig[39]);
    buf inst_R40 (R40, r_sig[40]);
    buf inst_R41 (R41, r_sig[41]);
    buf inst_R42 (R42, r_sig[42]);
    buf inst_R43 (R43, r_sig[43]);
    buf inst_R44 (R44, r_sig[44]);
    buf inst_R45 (R45, r_sig[45]);
    buf inst_R46 (R46, r_sig[46]);
    buf inst_R47 (R47, r_sig[47]);
    buf inst_R48 (R48, r_sig[48]);
    buf inst_R49 (R49, r_sig[49]);
    buf inst_R50 (R50, r_sig[50]);
    buf inst_R51 (R51, r_sig[51]);
    buf inst_R52 (R52, r_sig[52]);
    buf inst_R53 (R53, r_sig[53]);

    buf inst_F0 (EQZ, eqz_gen);
    buf inst_F1 (EQZM, eqzm_gen);
    buf inst_F2 (EQOM, eqom_gen);
    buf inst_F3 (EQPAT, eqpat_gen);
    buf inst_F4 (EQPATB, eqpatb_gen);
    buf inst_F5 (OVER, over_gen);
    buf inst_F6 (UNDER, under_gen);
    buf inst_F7 (OVERUNDER, overunder_gen);
    buf inst_F8 (SIGNEDR, signedr_sig);

    reg SRN;
    assign rnd_pattern_m1 = rnd_pattern - 1;

    tri1 GSR_sig = GSR_INST.GSRNET;
    tri1 PUR_sig = PUR_INST.PURNET;
    not (SR1, SRN);

    always @ (GSR_sig or PUR_sig )
    begin
      if (GSR == "ENABLED")
        begin
         SRN = GSR_sig & PUR_sig ;
        end
      else if (GSR == "DISABLED")
        SRN = PUR_sig;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTC0_CLK == "CLK0")
          input_c_clk_sig0 = CLK0b;
      else if (REG_INPUTC0_CLK == "CLK1")
          input_c_clk_sig0 = CLK1b;
      else if (REG_INPUTC0_CLK == "CLK2")
          input_c_clk_sig0 = CLK2b;
      else if (REG_INPUTC0_CLK == "CLK3")
          input_c_clk_sig0 = CLK3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_INPUTC0_CE == "CE0")
          input_c_ce_sig0 = CE0b;
      else if (REG_INPUTC0_CE == "CE1")
          input_c_ce_sig0 = CE1b;
      else if (REG_INPUTC0_CE == "CE2")
          input_c_ce_sig0 = CE2b;
      else if (REG_INPUTC0_CE == "CE3")
          input_c_ce_sig0 = CE3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTC0_RST == "RST0")
          input_c_rst_sig0 = RST0b;
      else if (REG_INPUTC0_RST == "RST1")
          input_c_rst_sig0 = RST1b;
      else if (REG_INPUTC0_RST == "RST2")
          input_c_rst_sig0 = RST2b;
      else if (REG_INPUTC0_RST == "RST3")
          input_c_rst_sig0 = RST3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTC1_CLK == "CLK0")
          input_c_clk_sig1 = CLK0b;
      else if (REG_INPUTC1_CLK == "CLK1")
          input_c_clk_sig1 = CLK1b;
      else if (REG_INPUTC1_CLK == "CLK2")
          input_c_clk_sig1 = CLK2b;
      else if (REG_INPUTC1_CLK == "CLK3")
          input_c_clk_sig1 = CLK3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_INPUTC1_CE == "CE0")
          input_c_ce_sig1 = CE0b;
      else if (REG_INPUTC1_CE == "CE1")
          input_c_ce_sig1 = CE1b;
      else if (REG_INPUTC1_CE == "CE2")
          input_c_ce_sig1 = CE2b;
      else if (REG_INPUTC1_CE == "CE3")
          input_c_ce_sig1 = CE3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTC1_RST == "RST0")
          input_c_rst_sig1 = RST0b;
      else if (REG_INPUTC1_RST == "RST1")
          input_c_rst_sig1 = RST1b;
      else if (REG_INPUTC1_RST == "RST2")
          input_c_rst_sig1 = RST2b;
      else if (REG_INPUTC1_RST == "RST3")
          input_c_rst_sig1 = RST3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_OUTPUT0_CLK == "CLK0")
          output0_clk_sig = CLK0b;
      else if (REG_OUTPUT0_CLK == "CLK1")
          output0_clk_sig = CLK1b;
      else if (REG_OUTPUT0_CLK == "CLK2")
          output0_clk_sig = CLK2b;
      else if (REG_OUTPUT0_CLK == "CLK3")
          output0_clk_sig = CLK3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_OUTPUT0_CE == "CE0")
          output0_ce_sig = CE0b;
      else if (REG_OUTPUT0_CE == "CE1")
          output0_ce_sig = CE1b;
      else if (REG_OUTPUT0_CE == "CE2")
          output0_ce_sig = CE2b;
      else if (REG_OUTPUT0_CE == "CE3")
          output0_ce_sig = CE3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_OUTPUT0_RST == "RST0")
          output0_rst_sig = RST0b;
      else if (REG_OUTPUT0_RST == "RST1")
          output0_rst_sig = RST1b;
      else if (REG_OUTPUT0_RST == "RST2")
          output0_rst_sig = RST2b;
      else if (REG_OUTPUT0_RST == "RST3")
          output0_rst_sig = RST3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_OUTPUT1_CLK == "CLK0")
          output1_clk_sig = CLK0b;
      else if (REG_OUTPUT1_CLK == "CLK1")
          output1_clk_sig = CLK1b;
      else if (REG_OUTPUT1_CLK == "CLK2")
          output1_clk_sig = CLK2b;
      else if (REG_OUTPUT1_CLK == "CLK3")
          output1_clk_sig = CLK3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_OUTPUT1_CE == "CE0")
          output1_ce_sig = CE0b;
      else if (REG_OUTPUT1_CE == "CE1")
          output1_ce_sig = CE1b;
      else if (REG_OUTPUT1_CE == "CE2")
          output1_ce_sig = CE2b;
      else if (REG_OUTPUT1_CE == "CE3")
          output1_ce_sig = CE3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_OUTPUT1_RST == "RST0")
          output1_rst_sig = RST0b;
      else if (REG_OUTPUT1_RST == "RST1")
          output1_rst_sig = RST1b;
      else if (REG_OUTPUT1_RST == "RST2")
          output1_rst_sig = RST2b;
      else if (REG_OUTPUT1_RST == "RST3")
          output1_rst_sig = RST3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_FLAG_CLK == "CLK0")
          flag_clk_sig = CLK0b;
      else if (REG_FLAG_CLK == "CLK1")
          flag_clk_sig = CLK1b;
      else if (REG_FLAG_CLK == "CLK2")
          flag_clk_sig = CLK2b;
      else if (REG_FLAG_CLK == "CLK3")
          flag_clk_sig = CLK3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_FLAG_CE == "CE0")
          flag_ce_sig = CE0b;
      else if (REG_FLAG_CE == "CE1")
          flag_ce_sig = CE1b;
      else if (REG_FLAG_CE == "CE2")
          flag_ce_sig = CE2b;
      else if (REG_FLAG_CE == "CE3")
          flag_ce_sig = CE3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_FLAG_RST == "RST0")
          flag_rst_sig = RST0b;
      else if (REG_FLAG_RST == "RST1")
          flag_rst_sig = RST1b;
      else if (REG_FLAG_RST == "RST2")
          flag_rst_sig = RST2b;
      else if (REG_FLAG_RST == "RST3")
          flag_rst_sig = RST3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_OPCODEIN_0_CLK == "CLK0")
          opcodein_0_clk_sig = CLK0b;
      else if (REG_OPCODEIN_0_CLK == "CLK1")
          opcodein_0_clk_sig = CLK1b;
      else if (REG_OPCODEIN_0_CLK == "CLK2")
          opcodein_0_clk_sig = CLK2b;
      else if (REG_OPCODEIN_0_CLK == "CLK3")
          opcodein_0_clk_sig = CLK3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_OPCODEIN_0_CE == "CE0")
          opcodein_0_ce_sig = CE0b;
      else if (REG_OPCODEIN_0_CE == "CE1")
          opcodein_0_ce_sig = CE1b;
      else if (REG_OPCODEIN_0_CE == "CE2")
          opcodein_0_ce_sig = CE2b;
      else if (REG_OPCODEIN_0_CE == "CE3")
          opcodein_0_ce_sig = CE3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_OPCODEIN_0_RST == "RST0")
          opcodein_0_rst_sig = RST0b;
      else if (REG_OPCODEIN_0_RST == "RST1")
          opcodein_0_rst_sig = RST1b;
      else if (REG_OPCODEIN_0_RST == "RST2")
          opcodein_0_rst_sig = RST2b;
      else if (REG_OPCODEIN_0_RST == "RST3")
          opcodein_0_rst_sig = RST3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_OPCODEOP0_0_CLK == "CLK0")
          opcodeop0_0_clk_sig = CLK0b;
      else if (REG_OPCODEOP0_0_CLK == "CLK1")
          opcodeop0_0_clk_sig = CLK1b;
      else if (REG_OPCODEOP0_0_CLK == "CLK2")
          opcodeop0_0_clk_sig = CLK2b;
      else if (REG_OPCODEOP0_0_CLK == "CLK3")
          opcodeop0_0_clk_sig = CLK3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_OPCODEOP0_0_CE == "CE0")
          opcodeop0_0_ce_sig = CE0b;
      else if (REG_OPCODEOP0_0_CE == "CE1")
          opcodeop0_0_ce_sig = CE1b;
      else if (REG_OPCODEOP0_0_CE == "CE2")
          opcodeop0_0_ce_sig = CE2b;
      else if (REG_OPCODEOP0_0_CE == "CE3")
          opcodeop0_0_ce_sig = CE3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_OPCODEOP0_0_RST == "RST0")
          opcodeop0_0_rst_sig = RST0b;
      else if (REG_OPCODEOP0_0_RST == "RST1")
          opcodeop0_0_rst_sig = RST1b;
      else if (REG_OPCODEOP0_0_RST == "RST2")
          opcodeop0_0_rst_sig = RST2b;
      else if (REG_OPCODEOP0_0_RST == "RST3")
          opcodeop0_0_rst_sig = RST3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_OPCODEOP1_0_CLK == "CLK0")
          opcodeop1_0_clk_sig = CLK0b;
      else if (REG_OPCODEOP1_0_CLK == "CLK1")
          opcodeop1_0_clk_sig = CLK1b;
      else if (REG_OPCODEOP1_0_CLK == "CLK2")
          opcodeop1_0_clk_sig = CLK2b;
      else if (REG_OPCODEOP1_0_CLK == "CLK3")
          opcodeop1_0_clk_sig = CLK3b;
    end

//    always @(CE0b or CE1b or CE2b or CE3b)
//    begin
//      if (REG_OPCODEOP1_0_CE == "CE0")
//          opcodeop1_0_ce_sig = CE0b;
//      else if (REG_OPCODEOP1_0_CE == "CE1")
//          opcodeop1_0_ce_sig = CE1b;
//      else if (REG_OPCODEOP1_0_CE == "CE2")
//          opcodeop1_0_ce_sig = CE2b;
//      else if (REG_OPCODEOP1_0_CE == "CE3")
//          opcodeop1_0_ce_sig = CE3b;
//    end

//    always @(RST0b or RST1b or RST2b or RST3b)
//    begin
//      if (REG_OPCODEOP1_0_RST == "RST0")
//          opcodeop1_0_rst_sig = RST0b;
//      else if (REG_OPCODEOP1_0_RST == "RST1")
//          opcodeop1_0_rst_sig = RST1b;
//      else if (REG_OPCODEOP1_0_RST == "RST2")
//          opcodeop1_0_rst_sig = RST2b;
//      else if (REG_OPCODEOP1_0_RST == "RST3")
//          opcodeop1_0_rst_sig = RST3b;
//    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_OPCODEIN_1_CLK == "CLK0")
          opcodein_1_clk_sig = CLK0b;
      else if (REG_OPCODEIN_1_CLK == "CLK1")
          opcodein_1_clk_sig = CLK1b;
      else if (REG_OPCODEIN_1_CLK == "CLK2")
          opcodein_1_clk_sig = CLK2b;
      else if (REG_OPCODEIN_1_CLK == "CLK3")
          opcodein_1_clk_sig = CLK3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_OPCODEIN_1_CE == "CE0")
          opcodein_1_ce_sig = CE0b;
      else if (REG_OPCODEIN_1_CE == "CE1")
          opcodein_1_ce_sig = CE1b;
      else if (REG_OPCODEIN_1_CE == "CE2")
          opcodein_1_ce_sig = CE2b;
      else if (REG_OPCODEIN_1_CE == "CE3")
          opcodein_1_ce_sig = CE3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_OPCODEIN_1_RST == "RST0")
          opcodein_1_rst_sig = RST0b;
      else if (REG_OPCODEIN_1_RST == "RST1")
          opcodein_1_rst_sig = RST1b;
      else if (REG_OPCODEIN_1_RST == "RST2")
          opcodein_1_rst_sig = RST2b;
      else if (REG_OPCODEIN_1_RST == "RST3")
          opcodein_1_rst_sig = RST3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_OPCODEOP0_1_CLK == "CLK0")
          opcodeop0_1_clk_sig = CLK0b;
      else if (REG_OPCODEOP0_1_CLK == "CLK1")
          opcodeop0_1_clk_sig = CLK1b;
      else if (REG_OPCODEOP0_1_CLK == "CLK2")
          opcodeop0_1_clk_sig = CLK2b;
      else if (REG_OPCODEOP0_1_CLK == "CLK3")
          opcodeop0_1_clk_sig = CLK3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_OPCODEOP0_1_CE == "CE0")
          opcodeop0_1_ce_sig = CE0b;
      else if (REG_OPCODEOP0_1_CE == "CE1")
          opcodeop0_1_ce_sig = CE1b;
      else if (REG_OPCODEOP0_1_CE == "CE2")
          opcodeop0_1_ce_sig = CE2b;
      else if (REG_OPCODEOP0_1_CE == "CE3")
          opcodeop0_1_ce_sig = CE3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_OPCODEOP0_1_RST == "RST0")
          opcodeop0_1_rst_sig = RST0b;
      else if (REG_OPCODEOP0_1_RST == "RST1")
          opcodeop0_1_rst_sig = RST1b;
      else if (REG_OPCODEOP0_1_RST == "RST2")
          opcodeop0_1_rst_sig = RST2b;
      else if (REG_OPCODEOP0_1_RST == "RST3")
          opcodeop0_1_rst_sig = RST3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_OPCODEOP1_1_CLK == "CLK0")
          opcodeop1_1_clk_sig = CLK0b;
      else if (REG_OPCODEOP1_1_CLK == "CLK1")
          opcodeop1_1_clk_sig = CLK1b;
      else if (REG_OPCODEOP1_1_CLK == "CLK2")
          opcodeop1_1_clk_sig = CLK2b;
      else if (REG_OPCODEOP1_1_CLK == "CLK3")
          opcodeop1_1_clk_sig = CLK3b;
    end

//    always @(CE0b or CE1b or CE2b or CE3b)
//    begin
//      if (REG_OPCODEOP1_1_CE == "CE0")
//          opcodeop1_1_ce_sig = CE0b;
//      else if (REG_OPCODEOP1_1_CE == "CE1")
//          opcodeop1_1_ce_sig = CE1b;
//      else if (REG_OPCODEOP1_1_CE == "CE2")
//          opcodeop1_1_ce_sig = CE2b;
//      else if (REG_OPCODEOP1_1_CE == "CE3")
//          opcodeop1_1_ce_sig = CE3b;
//    end

//    always @(RST0b or RST1b or RST2b or RST3b)
//    begin
//      if (REG_OPCODEOP0_1_RST == "RST0")
//          opcodeop1_1_rst_sig = RST0b;
//      else if (REG_OPCODEOP1_1_RST == "RST1")
//          opcodeop1_1_rst_sig = RST1b;
//      else if (REG_OPCODEOP1_1_RST == "RST2")
//          opcodeop1_1_rst_sig = RST2b;
//      else if (REG_OPCODEOP1_1_RST == "RST3")
//          opcodeop1_1_rst_sig = RST3b;
//    end

    always @ (SR1)
    begin
       if (SR1 == 1)
       begin
          assign c_sig_reg0 = 0;
          assign c_sig_reg1 = 0;
          assign opin_sig_0_reg = 0;
          assign opin_sig_1_reg = 0;
          assign r_out_lsb = 0;
          assign r_out_msb = 0;
          assign eqz_reg = 0;
          assign eqzm_reg = 0;
          assign eqom_reg = 0;
          assign eqpatb_reg = 0;
          assign eqpat_reg = 0;
          assign over_reg = 0;
          assign under_reg = 0;
          assign overunder_reg = 0;
       end
       else
       begin
          deassign c_sig_reg0;
          deassign c_sig_reg1;
          deassign opin_sig_0_reg;
          deassign opin_sig_1_reg;
          deassign r_out_lsb;
          deassign r_out_msb;
          deassign eqz_reg;
          deassign eqzm_reg;
          deassign eqom_reg;
          deassign eqpatb_reg;
          deassign eqpat_reg;
          deassign over_reg;
          deassign under_reg;
          deassign overunder_reg;
       end
    end

    always @(posedge input_c_clk_sig0 or posedge input_c_rst_sig0)
    begin
      if (input_c_rst_sig0 == 1'b1)
        begin
          c_sig_async0 <= 0;
        end
      else if (input_c_ce_sig0 == 1'b1)
        begin
          c_sig_async0 <= c_sig[26:0];
        end
    end

    always @(posedge input_c_clk_sig0)
    begin
      if (input_c_rst_sig0 == 1'b1)
        begin
          c_sig_sync0 <= 0;
        end
      else if (input_c_ce_sig0 == 1'b1)
        begin
          c_sig_sync0 <= c_sig[26:0];
        end
    end

    always @(posedge input_c_clk_sig1 or posedge input_c_rst_sig1)
    begin
      if (input_c_rst_sig1 == 1'b1)
        begin
          c_sig_async1 <= 0;
        end
      else if (input_c_ce_sig1 == 1'b1)
        begin
          c_sig_async1 <= c_sig[53:27];
        end
    end

    always @(posedge input_c_clk_sig1)
    begin
      if (input_c_rst_sig1 == 1'b1)
        begin
          c_sig_sync1 <= 0;
        end
      else if (input_c_ce_sig1 == 1'b1)
        begin
          c_sig_sync1 <= c_sig[53:27];
        end
    end

    always @(posedge opcodein_0_clk_sig or posedge opcodein_0_rst_sig)
    begin
      if (opcodein_0_rst_sig == 1'b1)
        begin
          opin_sig_0_async <= 0;
        end
      else if (opcodein_0_ce_sig == 1'b1)
        begin
          opin_sig_0_async <= op_sig[6:0];
        end
    end

    always @(posedge opcodein_0_clk_sig)
    begin
      if (opcodein_0_rst_sig == 1'b1)
        begin
          opin_sig_0_sync <= 0;
        end
      else if (opcodein_0_ce_sig == 1'b1)
        begin
          opin_sig_0_sync <= op_sig[6:0];
        end
    end

    always @(posedge opcodeop0_0_clk_sig or posedge opcodeop0_0_rst_sig)
    begin
      if (opcodeop0_0_rst_sig == 1'b1)
        begin
          op7_sig_0_async <= 0;
        end
      else if (opcodeop0_0_ce_sig == 1'b1)
        begin
          op7_sig_0_async <= op_sig[7];
        end
    end

    always @(posedge opcodeop0_0_clk_sig)
    begin
      if (opcodeop0_0_rst_sig == 1'b1)
        begin
          op7_sig_0_sync <= 0;
        end
      else if (opcodeop0_0_ce_sig == 1'b1)
        begin
          op7_sig_0_sync <= op_sig[7];
        end
    end

    always @(posedge opcodeop1_0_clk_sig or posedge opcodeop0_0_rst_sig)
    begin
      if (opcodeop0_0_rst_sig == 1'b1)
        begin
          op10_sig_0_async <= 0;
        end
      else if (opcodeop0_0_ce_sig == 1'b1)
        begin
          op10_sig_0_async <= op_sig[10:8];
        end
    end

    always @(posedge opcodeop1_0_clk_sig)
    begin
      if (opcodeop0_0_rst_sig == 1'b1)
        begin
          op10_sig_0_sync <= 0;
        end
      else if (opcodeop0_0_ce_sig == 1'b1)
        begin
          op10_sig_0_sync <= op_sig[10:8];
        end
    end

    always @(opin_sig_0_async or opin_sig_0_sync or op7_sig_0_async or op7_sig_0_sync or op10_sig_0_async or op10_sig_0_sync or opin_sig_1_async or opin_sig_1_sync or op7_sig_1_async or op7_sig_1_sync or op10_sig_1_async or op10_sig_1_sync or c_sig_async0 or c_sig_sync0 or c_sig_async1 or c_sig_sync1 or r_out_lsb_async or r_out_lsb_sync or r_out_msb_async or r_out_msb_sync)
    begin
      if (RESETMODE == "ASYNC")
      begin
         opin_sig_0_reg <= opin_sig_0_async;
         opin_sig_1_reg <= opin_sig_1_async;
         op7_sig_0_reg <= op7_sig_0_async;
         op7_sig_1_reg <= op7_sig_1_async;
         op10_sig_0_reg <= op10_sig_0_async;
         op10_sig_1_reg <= op10_sig_1_async;
         c_sig_reg0 <= c_sig_async0;
         c_sig_reg1 <= c_sig_async1;
         r_out_lsb <= r_out_lsb_async;
         r_out_msb <= r_out_msb_async;
      end
      else if (RESETMODE == "SYNC")
      begin
         opin_sig_0_reg <= opin_sig_0_sync;
         opin_sig_1_reg <= opin_sig_1_sync;
         op7_sig_0_reg <= op7_sig_0_sync;
         op7_sig_1_reg <= op7_sig_1_sync;
         op10_sig_0_reg <= op10_sig_0_sync;
         op10_sig_1_reg <= op10_sig_1_sync;
         c_sig_reg0 <= c_sig_sync0;
         c_sig_reg1 <= c_sig_sync1;
         r_out_lsb <= r_out_lsb_sync;
         r_out_msb <= r_out_msb_sync;
      end
    end

    always @(opin_sig_0_reg or op_sig)
    begin
      if (REG_OPCODEIN_0_CLK == "NONE")
      begin
          opin_sig_gen_0 <= op_sig[6:0];
      end
      else
      begin
          opin_sig_gen_0 <= opin_sig_0_reg;
      end
    end

    always @(op7_sig_0_reg or op_sig)
    begin
      if (REG_OPCODEOP0_0_CLK == "NONE")
      begin
          op7_sig_gen_0 <= op_sig[7];
      end
      else
      begin
          op7_sig_gen_0 <= op7_sig_0_reg;
      end
    end

    always @(op10_sig_0_reg or op_sig)
    begin
      if (REG_OPCODEOP1_0_CLK == "NONE")
      begin
          op10_sig_gen_0 <= op_sig[10:8];
      end
      else
      begin
          op10_sig_gen_0 <= op10_sig_0_reg;
      end
    end

    always @(posedge opcodein_1_clk_sig or posedge opcodein_1_rst_sig)
    begin
      if (opcodein_1_rst_sig == 1'b1)
        begin
          opin_sig_1_async <= 0;
        end
      else if (opcodein_1_ce_sig == 1'b1)
        begin
          opin_sig_1_async <= opin_sig_gen_0;
        end
    end

    always @(posedge opcodein_1_clk_sig)
    begin
      if (opcodein_1_rst_sig == 1'b1)
        begin
          opin_sig_1_sync <= 0;
        end
      else if (opcodein_1_ce_sig == 1'b1)
        begin
          opin_sig_1_sync <= opin_sig_gen_0;
        end
    end

    always @(posedge opcodeop0_1_clk_sig or posedge opcodeop0_1_rst_sig)
    begin
      if (opcodeop0_1_rst_sig == 1'b1)
        begin
          op7_sig_1_async <= 0;
        end
      else if (opcodeop0_1_ce_sig == 1'b1)
        begin
          op7_sig_1_async <= op7_sig_gen_0;
        end
    end

    always @(posedge opcodeop0_1_clk_sig)
    begin
      if (opcodeop0_1_rst_sig == 1'b1)
        begin
          op7_sig_1_sync <= 0;
        end
      else if (opcodeop0_1_ce_sig == 1'b1)
        begin
          op7_sig_1_sync <= op7_sig_gen_0;
        end
    end

    always @(posedge opcodeop1_1_clk_sig or posedge opcodeop0_1_rst_sig)
    begin
      if (opcodeop0_1_rst_sig == 1'b1)
        begin
          op10_sig_1_async <= 0;
        end
      else if (opcodeop0_1_ce_sig == 1'b1)
        begin
          op10_sig_1_async <= op10_sig_gen_0;
        end
    end

    always @(posedge opcodeop1_1_clk_sig)
    begin
      if (opcodeop0_1_rst_sig == 1'b1)
        begin
          op10_sig_1_sync <= 0;
        end
      else if (opcodeop0_1_ce_sig == 1'b1)
        begin
          op10_sig_1_sync <= op10_sig_gen_0;
        end
    end

    always @(opin_sig_1_reg or opin_sig_gen_0)
    begin
      if (REG_OPCODEIN_1_CLK == "NONE")
      begin
          opin_sig_gen_1 <= opin_sig_gen_0;
      end
      else
      begin
          opin_sig_gen_1 <= opin_sig_1_reg;
      end
    end

    always @(op7_sig_1_reg or op7_sig_gen_0)
    begin
      if (REG_OPCODEOP0_1_CLK == "NONE")
      begin
          op7_sig_gen_1 <= op7_sig_gen_0;
      end
      else
      begin
          op7_sig_gen_1 <= op7_sig_1_reg;
      end
    end

    always @(op10_sig_1_reg or op10_sig_gen_0)
    begin
      if (REG_OPCODEOP1_1_CLK == "NONE")
      begin
          op10_sig_gen_1 <= op10_sig_gen_0;
      end
      else
      begin
          op10_sig_gen_1 <= op10_sig_1_reg;
      end
    end

    assign op_sig_gen_new = {op10_sig_gen_1, op7_sig_gen_1, opin_sig_gen_1};

    always @(c_sig_reg0 or c_sig)
    begin
      if (REG_INPUTC0_CLK == "NONE")
      begin
          c_sig_gen0 <= c_sig[26:0];
      end
      else
      begin
          c_sig_gen0 <= c_sig_reg0;
      end
    end

    always @(c_sig_reg1 or c_sig)
    begin
      if (REG_INPUTC1_CLK == "NONE")
      begin
          c_sig_gen1 <= c_sig[53:27];
      end
      else
      begin
          c_sig_gen1 <= c_sig_reg1;
      end
    end

    assign c_sig_gen_new = {c_sig_gen1, c_sig_gen0};

    always @(ma_sig or signed1a_sig or op7_sig_gen_1)
    begin
      if (MULT9_MODE == "ENABLED")
      begin
         if (signed1a_sig == 1'b1)
         begin
            ma_sig_m [17:0] = ma_sig[17:0];
            ma_sig_m [24:18] = {ma_sig[17],
                                ma_sig[17],
                                ma_sig[17],
                                ma_sig[17],
                                ma_sig[17],
                                ma_sig[17],
                                ma_sig[17],
                                ma_sig[17]};
            ma_sig_m [26:25] = 2'b00;
            ma_sig_m [27] = op7_sig_gen_1;
            ma_sig_m [45:28] = ma_sig[35:18];
            ma_sig_m [53:46] = {ma_sig[35],
                                ma_sig[35],
                                ma_sig[35],
                                ma_sig[35],
                                ma_sig[35],
                                ma_sig[35],
                                ma_sig[35],
                                ma_sig[35],
                                ma_sig[35]};
         end
         else
         begin
            ma_sig_m [17:0] = ma_sig[17:0];
            ma_sig_m [26:18] = 0;
            ma_sig_m [27] = op7_sig_gen_1;
            ma_sig_m [45:28] = ma_sig[35:18];
            ma_sig_m [53:46] = 0;
         end
      end
      else
      begin
         if (signed1a_sig == 1'b1)
         begin
            ma_sig_m[35:0] = ma_sig[35:0];
            ma_sig_m[53:36] = { ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35],
                            ma_sig[35]};
         end
         else
         begin
            ma_sig_m [35:0] = ma_sig[35:0];
            ma_sig_m [53:36] = 0;
         end
      end
    end

    always @(mb_sig or signed1b_sig or op7_sig_gen_1)
    begin
      if (MULT9_MODE == "ENABLED")
      begin
         if (signed1b_sig == 1'b1)
         begin
            mb_sig_m [17:0] = mb_sig[17:0];
            mb_sig_m [24:18] = {mb_sig[17],
                                mb_sig[17],
                                mb_sig[17],
                                mb_sig[17],
                                mb_sig[17],
                                mb_sig[17],
                                mb_sig[17],
                                mb_sig[17]};
            mb_sig_m [26:25] = {op7_sig_gen_1, op7_sig_gen_1};
            mb_sig_m [27] = 1'b0;
            mb_sig_m [45:28] = mb_sig[35:18];
            mb_sig_m [53:46] = {mb_sig[35],
                                mb_sig[35],
                                mb_sig[35],
                                mb_sig[35],
                                mb_sig[35],
                                mb_sig[35],
                                mb_sig[35],
                                mb_sig[35],
                                mb_sig[35]};
         end
         else
         begin
            mb_sig_m [17:0] = mb_sig[17:0];
            mb_sig_m [24:18] = 0;
            mb_sig_m [26:25] = {op7_sig_gen_1, op7_sig_gen_1};
            mb_sig_m [27] = 1'b0;
            mb_sig_m [45:28] = mb_sig[35:18];
            mb_sig_m [53:46] = 0;
         end
      end
      else
      begin
         if (signed1b_sig == 1'b1)
         begin
            mb_sig_m[35:0] = mb_sig[35:0];
            mb_sig_m[53:36] = { mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35],
                            mb_sig[35]};
         end
         else
         begin
            mb_sig_m [35:0] = mb_sig[35:0];
            mb_sig_m [53:36] = 0;
         end
      end
    end

    always @(mb_sig)
    begin
       mb_shift_sig = mb_sig << 18;
    end
 
    always @ (op_sig_gen_new or ma_sig_m or r_sig or c_sig_gen_new or a_sig)
    begin
       case (op_sig_gen_new[1:0])
          2'b00 : a_mux = {r_sig[51], r_sig[51], r_sig[51:0]};
          2'b01 : a_mux = ma_sig_m;
          2'b10 : a_mux = {c_sig_gen_new[17:0], a_sig};
          2'b11 : a_mux = 0;
       endcase
    end

    always @ (op_sig_gen_new or mb_sig_m or c_sig_gen_new or b_sig or mb_shift_sig)
    begin
       case (op_sig_gen_new[3:2])
          2'b00 : b_mux = mb_shift_sig;
          2'b01 : b_mux = mb_sig_m;
          2'b10 : b_mux = {c_sig_gen_new[44:27], b_sig};
          2'b11 : b_mux = 0;
       endcase 
    end

    always @(cin_sig or signedcin_sig)
    begin
      if (signedcin_sig == 1'b1)
        begin
           cin_shift_sig[35:0] = cin_sig[53:18];
           cin_shift_sig[53:36] = { cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53],
                            cin_sig[53]};
        end
      else
        begin
           cin_shift_sig[35:0] =  cin_sig[53:18];
           cin_shift_sig[53:36] = 0;
        end
    end
 
    always @ (op_sig_gen_new or cin_sig or cin_shift_sig or c_sig_gen_new or a_sig or r_sig)
    begin
       case (op_sig_gen_new[6:4])
          3'b000 : c_mux = 0;
          3'b001 : c_mux = cin_shift_sig;
          3'b010 : c_mux = cin_sig;
          3'b011 : c_mux = c_sig_gen_new;
          3'b100 : c_mux = {c_sig_gen_new[17:0], a_sig};
          3'b101 : c_mux = {r_sig[51], r_sig[51], r_sig[51:0]};
          3'b110 : c_mux = rnd_pattern;
          3'b111 : c_mux = rnd_pattern_m1;
       endcase
    end

    always @ (a_mux or b_mux or c_mux or op_sig_gen_new)
    begin
       case (op_sig_gen_new[10:7])
          4'b0000 : r_out = ~(b_mux & c_mux);                 // nand
          4'b0100 : begin 
                       r_out = (a_mux + b_mux + c_mux);
                       r_out1 = (a_mux[51:0] + b_mux[51:0] + c_mux[51:0]);
                    end
          4'b0101 : begin
                       r_out = (a_mux - b_mux + c_mux);
                       r_out1 = (a_mux[51:0] - b_mux[51:0] + c_mux[51:0]);
                    end
          4'b0110 : begin
                       r_out = (a_mux + b_mux - c_mux);
                       r_out1 = (a_mux[51:0] + b_mux[51:0] - c_mux[51:0]);
                    end
          4'b0111 : begin
                       r_out = (a_mux - b_mux - c_mux);
                       r_out1 = (a_mux[51:0] - b_mux[51:0] - c_mux[51:0]);
                    end
          4'b1100 : r_out = (b_mux ^~ c_mux);                 // xnor
          4'b1110 : r_out = (b_mux ^ c_mux);                  // xor
          4'b1000 : r_out = (b_mux & c_mux);                  // and
          4'b0011 : r_out = (b_mux | c_mux);                  // or
          4'b1011 : r_out = ~(b_mux | c_mux);                 // nor
       endcase
    end

    always @(posedge output0_clk_sig or posedge output0_rst_sig)
    begin
      if (output0_rst_sig == 1'b1)
        begin
          r_out_lsb_async <= 0;
        end
      else if (output0_ce_sig == 1'b1)
        begin
          r_out_lsb_async <= r_out[17:0];
        end
    end

    always @(posedge output0_clk_sig)
    begin
      if (output0_rst_sig == 1'b1)
        begin
          r_out_lsb_sync <= 0;
        end
      else if (output0_ce_sig == 1'b1)
        begin
          r_out_lsb_sync <= r_out[17:0];
        end
    end

    always @(r_out_lsb or r_out)
    begin
      if (REG_OUTPUT0_CLK == "NONE")
      begin
          r_out_lsb_gen = r_out[17:0];
      end
      else
      begin
          r_out_lsb_gen = r_out_lsb;
      end
    end

    always @(posedge output1_clk_sig or posedge output1_rst_sig)
    begin
      if (output1_rst_sig == 1'b1)
        begin
          r_out_msb_async <= 0;
        end
      else if (output1_ce_sig == 1'b1)
        begin
          r_out_msb_async <= r_out[53:18];
        end
    end

    always @(posedge output1_clk_sig)
    begin
      if (output1_rst_sig == 1'b1)
        begin
          r_out_msb_sync <= 0;
        end
      else if (output1_ce_sig == 1'b1)
        begin
          r_out_msb_sync <= r_out[53:18];
        end
    end

    always @(r_out_msb or r_out)
    begin
      if (REG_OUTPUT1_CLK == "NONE")
      begin
          r_out_msb_gen = r_out[53:18];
      end
      else
      begin
          r_out_msb_gen = r_out_msb;
      end
    end

    always @(r_out_msb_gen or r_out_lsb_gen)
    begin
       r_sig = {r_out_msb_gen, r_out_lsb_gen};
    end

    wire  [53:0] eqom_sig_new;
    wire  [53:0] eqzm_sig_new;
    assign eqz_sig = ~|r_out;
    assign eqzm_sig = &((~r_out) | mask01_sig);
    assign eqzm_sig_new = ((~r_out) | mask01_sig);
    assign eqom_sig_new = (r_out | mask01_sig);
    assign eqom_sig = &(r_out | mask01_sig);

    always @(mcpat_sig or c_sig_gen_new)
    begin
      if (MCPAT_SOURCE == "STATIC")
      begin
          mcpat_sel = mcpat_sig;
      end
      else
      begin
          mcpat_sel = c_sig_gen_new;
      end
    end

    always @(c_sig_gen_new or maskpat_sig)
    begin
      if (MASKPAT_SOURCE == "STATIC")
      begin
          maskpat_sel = maskpat_sig;
      end
      else
      begin
          maskpat_sel = c_sig_gen_new;
      end
    end

    assign eqpatb_sig = &((r_out ^ mcpat_sel) | maskpat_sel);
    assign eqpat_sig = &(~(r_out ^ mcpat_sel) | maskpat_sel);

    assign eqnor_sig = ~(eqzm_sig | eqom_sig);
    assign over_sig = (eqzm_gen & eqnor_sig);
    assign under_sig = (eqom_gen & eqnor_sig);
    assign signedab_sig = ~(signed1a_sig & signed1b_sig);
    assign signedr_sig = (signed1a_sig | signed1b_sig);

    always @(signedab_sig)
    begin
      if (LEGACY == "DISABLED")
      begin
          over_under_sel = 1'b0;
      end
      else
      begin
          over_under_sel = signedab_sig;
      end
    end

    always @(over_under_sel or eqnor_sig or r_out1)   
    begin
      if (over_under_sel == 1'b1)
      begin
          overunder_sig = r_out1[52];
      end
      else
      begin
          overunder_sig = eqnor_sig;
      end
    end

    always @(posedge flag_clk_sig or posedge flag_rst_sig)
    begin
      if (flag_rst_sig == 1'b1)
        begin
          eqz_async <= 0;
          eqzm_async <= 0;
          eqom_async <= 0;
          eqpatb_async <= 0;
          eqpat_async <= 0;
          over_async <= 0;
          under_async <= 0;
          overunder_async <= 0;
        end
      else if (flag_ce_sig == 1'b1)
        begin
          eqz_async <= eqz_sig;
          eqzm_async <= eqzm_sig;
          eqom_async <= eqom_sig;
          eqpatb_async <= eqpatb_sig;
          eqpat_async <= eqpat_sig;
          over_async <= over_sig;
          under_async <= under_sig;
          overunder_async <= overunder_sig;
        end
    end
    
    always @(posedge flag_clk_sig)
    begin
      if (flag_rst_sig == 1'b1)
        begin
          eqz_sync <= 0;
          eqzm_sync <= 0;
          eqom_sync <= 0;
          eqpatb_sync <= 0;
          eqpat_sync <= 0;
          over_sync <= 0;
          under_sync <= 0;
          overunder_sync <= 0;
        end
      else if (flag_ce_sig == 1'b1)
        begin
          eqz_sync <= eqz_sig;
          eqzm_sync <= eqzm_sig;
          eqom_sync <= eqom_sig;
          eqpatb_sync <= eqpatb_sig;
          eqpat_sync <= eqpat_sig;
          over_sync <= over_sig;
          under_sync <= under_sig;
          overunder_sync <= overunder_sig;
        end
    end

    always @(eqz_sync or eqz_async or eqzm_sync or eqzm_async or eqom_sync or eqom_async or eqpatb_sync or eqpatb_async or eqpat_sync or eqpat_async  or over_sync or over_async or under_sync or under_async or overunder_async or overunder_async)
    begin
      if (RESETMODE == "ASYNC")
      begin
         eqz_reg <= eqz_async;
         eqzm_reg <= eqzm_async;
         eqom_reg <= eqom_async;
         eqpatb_reg <= eqpatb_async;
         eqpat_reg <= eqpat_async;
         over_reg <= over_async;
         under_reg <= under_async;
         overunder_reg <= overunder_async;
      end
      else if (RESETMODE == "SYNC")
      begin
         eqz_reg <= eqz_sync;
         eqzm_reg <= eqzm_sync;
         eqom_reg <= eqom_sync;
         eqpatb_reg <= eqpatb_sync;
         eqpat_reg <= eqpat_sync;
         over_reg <= over_sync;
         under_reg <= under_sync;
         overunder_reg <= overunder_sync;
      end
    end

    always @(eqz_reg or eqz_sig or eqzm_reg or eqzm_sig or eqom_reg or eqom_sig or eqpatb_reg or eqpatb_sig or eqpat_reg or eqpat_sig or over_reg or over_sig or under_reg or under_sig or overunder_reg or overunder_sig)
    begin
      if (REG_OUTPUT1_CLK == "NONE")
      begin
          eqz_gen = eqz_sig;
          eqzm_gen = eqzm_sig;
          eqom_gen = eqom_sig;
          eqpatb_gen = eqpatb_sig;
          eqpat_gen = eqpat_sig;
          over_gen = over_sig;
          under_gen = under_sig;
          overunder_gen = overunder_sig;
      end
      else
      begin
          eqz_gen = eqz_reg;
          eqzm_gen = eqzm_reg;
          eqom_gen = eqom_reg;
          eqpatb_gen = eqpatb_reg;
          eqpat_gen = eqpat_reg;
          over_gen = over_reg;
          under_gen = under_reg;
          overunder_gen = overunder_reg;
      end
    end

endmodule

`endcelldefine


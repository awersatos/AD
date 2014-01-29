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

module ALU24A (CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3,SIGNEDIA, SIGNEDIB,
MA17,MA16,MA15,MA14,MA13,MA12,MA11,MA10,MA9,MA8,MA7,MA6,MA5,MA4,MA3,MA2,MA1,MA0,
MB17,MB16,MB15,MB14,MB13,MB12,MB11,MB10,MB9,MB8,MB7,MB6,MB5,MB4,MB3,MB2,MB1,MB0,
CIN23,CIN22,CIN21,CIN20,CIN19,CIN18,CIN17,CIN16,CIN15,CIN14,
CIN13,CIN12,CIN11,CIN10,CIN9,CIN8,CIN7,CIN6,CIN5,CIN4,CIN3,CIN2,CIN1,CIN0,
OPADDNSUB, OPCINSEL, R23,R22,R21,R20,R19,R18,
R17,R16,R15,R14,R13,R12,R11,R10,R9,R8,R7,R6,R5,R4,R3,R2,R1,R0);

input CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3,SIGNEDIA, SIGNEDIB;
input MA17,MA16,MA15,MA14,MA13,MA12,MA11,MA10,MA9,MA8,MA7,MA6,MA5,MA4,MA3,MA2,MA1,MA0;
input MB17,MB16,MB15,MB14,MB13,MB12,MB11,MB10,MB9,MB8,MB7,MB6,MB5,MB4,MB3,MB2,MB1,MB0;
input CIN23,CIN22,CIN21,CIN20,CIN19,CIN18,CIN17,CIN16,CIN15,CIN14;
input CIN13,CIN12,CIN11,CIN10,CIN9,CIN8,CIN7,CIN6,CIN5,CIN4,CIN3,CIN2,CIN1,CIN0;
input OPADDNSUB,OPCINSEL;
output R23,R22,R21,R20,R19,R18;
output R17,R16,R15,R14,R13,R12,R11,R10,R9,R8,R7,R6,R5,R4,R3,R2,R1,R0;

parameter REG_OUTPUT_CLK = "NONE";
parameter REG_OUTPUT_CE = "CE0";
parameter REG_OUTPUT_RST = "RST0";
parameter REG_OPCODE_0_CLK = "NONE";
parameter REG_OPCODE_0_CE = "CE0";
parameter REG_OPCODE_0_RST = "RST0";
parameter REG_OPCODE_1_CLK = "NONE";
parameter REG_OPCODE_1_CE = "CE0";
parameter REG_OPCODE_1_RST = "RST0";
parameter GSR = "ENABLED";
parameter RESETMODE = "SYNC";

    wire CE0b,CE1b,CE2b,CE3b,CLK0b,CLK1b,CLK2b,CLK3b,RST0b,RST1b,RST2b,RST3b;
    wire [17:0] ma_sig, mb_sig;
    wire [23:0] cin_sig, r_sig;

    reg output_clk_sig, output_ce_sig, output_rst_sig;
    reg opcode_0_clk_sig, opcode_0_ce_sig, opcode_0_rst_sig;
    reg opcode_1_clk_sig, opcode_1_ce_sig, opcode_1_rst_sig;
    reg addnsub0_reg, addnsub1_reg, cinsel0_reg, cinsel1_reg;
    reg addnsub0_async, cinsel0_async, addnsub1_async, cinsel1_async;
    reg addnsub0_sync, cinsel0_sync, addnsub1_sync, cinsel1_sync;
    reg addnsub0_gen, cinsel0_gen, addnsub1_gen, cinsel1_gen;

    reg [23:0] ma_sig_m, mb_sig_m, c_mux;
    reg [23:0] r_out, r_out_async, r_out_sync, r_out_gen, r_out_reg;


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

    buf inst_OP0 (addnsub, OPADDNSUB);
    buf inst_OP1 (cinsel, OPCINSEL);

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

    reg SRN;

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
      if (REG_OUTPUT_CLK == "CLK0")
          output_clk_sig = CLK0b;
      else if (REG_OUTPUT_CLK == "CLK1")
          output_clk_sig = CLK1b;
      else if (REG_OUTPUT_CLK == "CLK2")
          output_clk_sig = CLK2b;
      else if (REG_OUTPUT_CLK == "CLK3")
          output_clk_sig = CLK3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_OUTPUT_CE == "CE0")
          output_ce_sig = CE0b;
      else if (REG_OUTPUT_CE == "CE1")
          output_ce_sig = CE1b;
      else if (REG_OUTPUT_CE == "CE2")
          output_ce_sig = CE2b;
      else if (REG_OUTPUT_CE == "CE3")
          output_ce_sig = CE3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_OUTPUT_RST == "RST0")
          output_rst_sig = RST0b;
      else if (REG_OUTPUT_RST == "RST1")
          output_rst_sig = RST1b;
      else if (REG_OUTPUT_RST == "RST2")
          output_rst_sig = RST2b;
      else if (REG_OUTPUT_RST == "RST3")
          output_rst_sig = RST3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_OPCODE_0_CLK == "CLK0")
          opcode_0_clk_sig = CLK0b;
      else if (REG_OPCODE_0_CLK == "CLK1")
          opcode_0_clk_sig = CLK1b;
      else if (REG_OPCODE_0_CLK == "CLK2")
          opcode_0_clk_sig = CLK2b;
      else if (REG_OPCODE_0_CLK == "CLK3")
          opcode_0_clk_sig = CLK3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_OPCODE_0_CE == "CE0")
          opcode_0_ce_sig = CE0b;
      else if (REG_OPCODE_0_CE == "CE1")
          opcode_0_ce_sig = CE1b;
      else if (REG_OPCODE_0_CE == "CE2")
          opcode_0_ce_sig = CE2b;
      else if (REG_OPCODE_0_CE == "CE3")
          opcode_0_ce_sig = CE3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_OPCODE_0_RST == "RST0")
          opcode_0_rst_sig = RST0b;
      else if (REG_OPCODE_0_RST == "RST1")
          opcode_0_rst_sig = RST1b;
      else if (REG_OPCODE_0_RST == "RST2")
          opcode_0_rst_sig = RST2b;
      else if (REG_OPCODE_0_RST == "RST3")
          opcode_0_rst_sig = RST3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_OPCODE_1_CLK == "CLK0")
          opcode_1_clk_sig = CLK0b;
      else if (REG_OPCODE_1_CLK == "CLK1")
          opcode_1_clk_sig = CLK1b;
      else if (REG_OPCODE_1_CLK == "CLK2")
          opcode_1_clk_sig = CLK2b;
      else if (REG_OPCODE_1_CLK == "CLK3")
          opcode_1_clk_sig = CLK3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_OPCODE_1_CE == "CE0")
          opcode_1_ce_sig = CE0b;
      else if (REG_OPCODE_1_CE == "CE1")
          opcode_1_ce_sig = CE1b;
      else if (REG_OPCODE_1_CE == "CE2")
          opcode_1_ce_sig = CE2b;
      else if (REG_OPCODE_1_CE == "CE3")
          opcode_1_ce_sig = CE3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_OPCODE_1_RST == "RST0")
          opcode_1_rst_sig = RST0b;
      else if (REG_OPCODE_1_RST == "RST1")
          opcode_1_rst_sig = RST1b;
      else if (REG_OPCODE_1_RST == "RST2")
          opcode_1_rst_sig = RST2b;
      else if (REG_OPCODE_1_RST == "RST3")
          opcode_1_rst_sig = RST3b;
    end

    always @ (SR1)
    begin
       if (SR1 == 1)
       begin
          assign addnsub0_reg = 0;
          assign cinsel0_reg = 0;
          assign addnsub1_reg = 0;
          assign cinsel1_reg = 0;
          assign r_out_reg = 0;
       end
       else
       begin
          deassign addnsub0_reg;
          deassign cinsel0_reg;
          deassign addnsub1_reg;
          deassign cinsel1_reg;
          deassign r_out_reg;
       end
    end

    always @(posedge opcode_0_clk_sig or posedge opcode_0_rst_sig)
    begin
      if (opcode_0_rst_sig == 1'b1)
        begin
          addnsub0_async <= 0;
          cinsel0_async <= 0;
        end
      else if (opcode_0_ce_sig == 1'b1)
        begin
          addnsub0_async <= addnsub;
          cinsel0_async <= cinsel;
        end
    end

    always @(posedge opcode_0_clk_sig)
    begin
      if (opcode_0_rst_sig == 1'b1)
        begin
          addnsub0_sync <= 0; 
          cinsel0_sync <= 0; 
        end
      else if (opcode_0_ce_sig == 1'b1)
        begin
          addnsub0_sync <= addnsub;
          cinsel0_sync <= cinsel;
        end
    end

    always @(addnsub0_async or cinsel0_async or addnsub0_sync or cinsel0_sync or addnsub1_async or addnsub1_sync or r_out_async or r_out_sync or cinsel1_async or cinsel1_sync)
    begin
      if (RESETMODE == "ASYNC")
      begin
         addnsub0_reg <= addnsub0_async;
         addnsub1_reg <= addnsub1_async;
         cinsel0_reg <= cinsel0_async;
         cinsel1_reg <= cinsel1_async;
         r_out_reg <= r_out_async;
      end
      else if (RESETMODE == "SYNC")
      begin
         addnsub0_reg <= addnsub0_sync;
         addnsub1_reg <= addnsub1_sync;
         cinsel0_reg <= cinsel0_sync;
         cinsel1_reg <= cinsel1_sync;
         r_out_reg <= r_out_sync;
      end
    end

    always @(addnsub0_reg or addnsub or cinsel or cinsel0_reg)
    begin
      if (REG_OPCODE_0_CLK == "NONE")
      begin
          addnsub0_gen <= addnsub;
          cinsel0_gen <= cinsel;
      end
      else
      begin
          addnsub0_gen <= addnsub0_reg;
          cinsel0_gen <= cinsel0_reg;
      end
    end

    always @(posedge opcode_1_clk_sig or posedge opcode_1_rst_sig)
    begin
      if (opcode_1_rst_sig == 1'b1)
        begin
          addnsub1_async <= 0;
          cinsel1_async <= 0;
        end
      else if (opcode_1_ce_sig == 1'b1)
        begin
          addnsub1_async <= addnsub0_gen;
          cinsel1_async <= cinsel0_gen;
        end
    end

    always @(posedge opcode_1_clk_sig)
    begin
      if (opcode_1_rst_sig == 1'b1)
        begin
          addnsub1_sync <= 0;
          cinsel1_sync <= 0;
        end
      else if (opcode_1_ce_sig == 1'b1)
        begin
          addnsub1_sync <= addnsub0_gen;
          cinsel1_sync <= cinsel0_gen;
        end
    end

    always @(addnsub1_reg or addnsub0_gen or cinsel0_gen or cinsel1_reg)
    begin
      if (REG_OPCODE_1_CLK == "NONE")
      begin
          addnsub1_gen <= addnsub0_gen;
          cinsel1_gen <= cinsel0_gen;
      end
      else
      begin
          addnsub1_gen <= addnsub1_reg;
          cinsel1_gen <= cinsel1_reg;
      end
    end

    always @(ma_sig or signed1a_sig)
    begin
      if (signed1a_sig == 1'b1)
        begin
          ma_sig_m[17:0] = ma_sig[17:0];
          ma_sig_m[23:18] = { ma_sig[17],
                            ma_sig[17],
                            ma_sig[17],
                            ma_sig[17],
                            ma_sig[17],
                            ma_sig[17]};
        end
      else
        begin
          ma_sig_m[17:0] =  ma_sig[17:0];
          ma_sig_m[23:18] = 0;
        end
    end

    always @(mb_sig or signed1b_sig)
    begin
      if (signed1b_sig == 1'b1)
        begin
          mb_sig_m[17:0] = mb_sig[17:0];
          mb_sig_m[23:18] = { mb_sig[17],
                            mb_sig[17],
                            mb_sig[17],
                            mb_sig[17],
                            mb_sig[17],
                            mb_sig[17]};
        end
      else
        begin
          mb_sig_m[17:0] =  mb_sig[17:0];
          mb_sig_m[23:18] = 0;
        end
    end

    always @(cinsel1_gen or cin_sig)
    begin
      if (cinsel1_gen == 1'b1)
        begin
          c_mux = cin_sig;
        end
      else
        begin
          c_mux = 24'b000000000000000000000000;
        end
    end

    always @ (ma_sig_m or mb_sig_m or c_mux or addnsub1_gen)
    begin
       case (addnsub1_gen)
          1'b0 : r_out = (ma_sig_m + mb_sig_m + c_mux);
          1'b1 : r_out = (ma_sig_m - mb_sig_m + c_mux);
       endcase
    end

    always @(posedge output_clk_sig or posedge output_rst_sig)
    begin
      if (output_rst_sig == 1'b1)
        begin
          r_out_async <= 0;
        end
      else if (output_ce_sig == 1'b1)
        begin
          r_out_async <= r_out;
        end
    end

    always @(posedge output_clk_sig)
    begin
      if (output_rst_sig == 1'b1)
        begin
          r_out_sync <= 0;
        end
      else if (output_ce_sig == 1'b1)
        begin
          r_out_sync <= r_out;
        end
    end

    always @(r_out_reg or r_out)
    begin
      if (REG_OUTPUT_CLK == "NONE")
      begin
          r_out_gen = r_out;
      end
      else
      begin
          r_out_gen = r_out_reg;
      end
    end

    assign r_sig = r_out_gen;

endmodule

`endcelldefine


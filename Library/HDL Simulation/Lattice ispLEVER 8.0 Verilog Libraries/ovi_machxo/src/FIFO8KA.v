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
// $Header: /home/rlp/Orfdry/env_rcs/verilog/pkg/versclibs/data/orca5mj/RCS/FIFO8KA.v,v 1.5 2005/09/30 20:15:52 pradeep Exp $
//
`timescale 1ns / 1ps
module FIFO8KA (DI0, DI1, DI2, DI3, DI4, DI5, DI6, DI7, DI8,
         DI9, DI10, DI11, DI12, DI13, DI14, DI15, DI16, DI17,
         DI18, DI19, DI20, DI21, DI22, DI23, DI24, DI25, DI26,
         DI27, DI28, DI29, DI30, DI31, DI32, DI33, DI34, DI35,
         FULLI, CSW0, CSW1, EMPTYI, CSR0, CSR1, WE, RE, CLKW, CLKR, RST, RPRST,  
         DO0, DO1, DO2, DO3, DO4, DO5, DO6, DO7, DO8,
         DO9, DO10, DO11, DO12, DO13, DO14, DO15, DO16, DO17,
         DO18, DO19, DO20, DO21, DO22, DO23, DO24, DO25, DO26,
         DO27, DO28, DO29, DO30, DO31, DO32, DO33, DO34, DO35,
         EF, AEF, AFF, FF);

   parameter  DATA_WIDTH_W = 18;
   parameter  DATA_WIDTH_R = 18;
   parameter  REGMODE = "NOREG";
   parameter  RESETMODE = "ASYNC";
   parameter  CSDECODE_W = 2'b00;
   parameter  CSDECODE_R = 2'b00;
   parameter  AEPOINTER = 14'b00000000000000;
   parameter  AEPOINTER1 = 14'b00000000000000;
   parameter  AFPOINTER = 14'b00000000000000;
   parameter  AFPOINTER1 = 14'b00000000000000;
   parameter  FULLPOINTER = 14'b00000000000000;
   parameter  FULLPOINTER1 = 14'b00000000000000;
   parameter GSR = "DISABLED";

input    DI0, DI1, DI2, DI3, DI4, DI5, DI6, DI7, DI8,
         DI9, DI10, DI11, DI12, DI13, DI14, DI15, DI16, DI17,
         DI18, DI19, DI20, DI21, DI22, DI23, DI24, DI25, DI26,
         DI27, DI28, DI29, DI30, DI31, DI32, DI33, DI34, DI35,
         FULLI, CSW0, CSW1, EMPTYI, CSR0, CSR1, WE, RE, CLKW, CLKR, RST, RPRST;
output   DO0, DO1, DO2, DO3, DO4, DO5, DO6, DO7, DO8,
         DO9, DO10, DO11, DO12, DO13, DO14, DO15, DO16, DO17,
         DO18, DO19, DO20, DO21, DO22, DO23, DO24, DO25, DO26,
         DO27, DO28, DO29, DO30, DO31, DO32, DO33, DO34, DO35,
         EF, AEF, AFF, FF;

   parameter ADDR_WIDTH_W = (DATA_WIDTH_W == 1) ? 13 : (DATA_WIDTH_W == 2) ? 12 :
                       (DATA_WIDTH_W == 4) ? 11 : (DATA_WIDTH_W == 9) ? 10 : 
                       (DATA_WIDTH_W == 18) ? 9 : 8 ;
   parameter ADDR_WIDTH_R = (DATA_WIDTH_R == 1) ? 13 : (DATA_WIDTH_R == 2) ? 12 :
                       (DATA_WIDTH_R == 4) ? 11 : (DATA_WIDTH_R == 9) ? 10 : 
                       (DATA_WIDTH_R == 18) ? 9 : 8;

   parameter div_a = (DATA_WIDTH_W == 1) ? 8 : (DATA_WIDTH_W == 2) ? 4 :
                       (DATA_WIDTH_W == 4) ? 2 : (DATA_WIDTH_W == 9) ? 18432 : 18432 ;
   parameter div_b = (DATA_WIDTH_R == 1) ? 8 : (DATA_WIDTH_R == 2) ? 4 :
                       (DATA_WIDTH_R == 4) ? 2 : (DATA_WIDTH_R == 9) ? 18432 : 18432;

  tri1 GSR_sig = GSR_INST.GSRNET;
  tri1 PUR_sig = PUR_INST.PURNET;
// reg GSR_sig, PUR_sig;
integer i;
wire [13:0] pe_ptr;
wire [13:0] empty_ptr;
wire [35:0] DI;
wire [2:0]  CSW;
wire [2:0]  CSR;
reg  [35:0] DO_out;
reg  [DATA_WIDTH_R - 1:0] DO_reg;
reg  [DATA_WIDTH_R - 1:0] DO_reg_sync;
reg  [DATA_WIDTH_R - 1:0] DO_reg_async;
reg  [DATA_WIDTH_R - 1:0] DO_node;
reg  [DATA_WIDTH_R - 1:0] DO_int;
reg  [35:0] DO_intb;
wire        WRE_node, RDE_node, WCLK_node, RCLK_node, RST_node, RPRST_node;
reg         SRN;
wire  [DATA_WIDTH_W-1:0] DI_node;
reg   [DATA_WIDTH_W-1:0] DI_reg;
reg   [DATA_WIDTH_W-1:0] DI_reg_sync;
reg   [DATA_WIDTH_W-1:0] DI_reg_async;
reg   [ADDR_WIDTH_W:0] ADW_node;
reg   [ADDR_WIDTH_W:0] ADW_node_syncb;
reg   [ADDR_WIDTH_W:0] ADW_var;
reg   [ADDR_WIDTH_W:0] ADW_var_syncb;
reg   [ADDR_WIDTH_R:0] ADR_node;
reg   [ADDR_WIDTH_R:0] ADR_node_syncb;
reg   [ADDR_WIDTH_R:0] ADR_var;
reg   [ADDR_WIDTH_R:0] ADR_var_syncb;
reg   [13:0] ADWF_node;
reg   [13:0] ADWF_node_syncb;
reg   [13:0] ADRF_node;
reg   [13:0] ADRF_node_syncb;
wire [13:0] fifo_words_used_syncw;
wire [13:0] fifo_words_used_syncr;
reg   [18431:0] MEM;
wire  RST_sig, RPRST_sig;
reg   CSW_EN, CSR_EN;
integer WADDR, RADDR;
wire  DI_0;
wire  ef_int, pef_int, pff_int, ff_int;
reg   RPRST_reg1, RPRST_reg2;

  buf (DI[0], DI_0);
  buf (DI[1], DI1);
  buf (DI[2], DI2);
  buf (DI[3], DI3);
  buf (DI[4], DI4);
  buf (DI[5], DI5);
  buf (DI[6], DI6);
  buf (DI[7], DI7);
  buf (DI[8], DI8);
  buf (DI[9], DI9);
  buf (DI[10], DI10);
  buf (DI[11], DI11);
  buf (DI[12], DI12);
  buf (DI[13], DI13);
  buf (DI[14], DI14);
  buf (DI[15], DI15);
  buf (DI[16], DI16);
  buf (DI[17], DI17);
  buf (DI[18], DI18);
  buf (DI[19], DI19);
  buf (DI[20], DI20);
  buf (DI[21], DI21);
  buf (DI[22], DI22);
  buf (DI[23], DI23);
  buf (DI[24], DI24);
  buf (DI[25], DI25);
  buf (DI[26], DI26);
  buf (DI[27], DI27);
  buf (DI[28], DI28);
  buf (DI[29], DI29);
  buf (DI[30], DI30);
  buf (DI[31], DI31);
  buf (DI[32], DI32);
  buf (DI[33], DI33);
  buf (DI[34], DI34);
  buf (DI[35], DI35);
  buf (CSW[0], CSW0);
  buf (CSW[1], CSW1);
  buf (CSW[2], FULLI);
  buf (CSR[0], CSR0);
  buf (CSR[1], CSR1);
  buf (CSR[2], EMPTYI);
  buf (WCLK_node, CLKW);
  buf (RCLK_node, CLKR);
  buf (WRE_node, WE);
  buf (RDE_node, RE);
  buf (RST_node, RST);
  buf (RPRST_node, RPRST);
  buf (DO0, DO_out[0]);
  buf (DO1, DO_out[1]);
  buf (DO2, DO_out[2]);
  buf (DO3, DO_out[3]);
  buf (DO4, DO_out[4]);
  buf (DO5, DO_out[5]);
  buf (DO6, DO_out[6]);
  buf (DO7, DO_out[7]);
  buf (DO8, DO_out[8]);
  buf (DO9, DO_out[9]);
  buf (DO10, DO_out[10]);
  buf (DO11, DO_out[11]);
  buf (DO12, DO_out[12]);
  buf (DO13, DO_out[13]);
  buf (DO14, DO_out[14]);
  buf (DO15, DO_out[15]);
  buf (DO16, DO_out[16]);
  buf (DO17, DO_out[17]);
  buf (DO18, DO_out[18]);
  buf (DO19, DO_out[19]);
  buf (DO20, DO_out[20]);
  buf (DO21, DO_out[21]);
  buf (DO22, DO_out[22]);
  buf (DO23, DO_out[23]);
  buf (DO24, DO_out[24]);
  buf (DO25, DO_out[25]);
  buf (DO26, DO_out[26]);
  buf (DO27, DO_out[27]);
  buf (DO28, DO_out[28]);
  buf (DO29, DO_out[29]);
  buf (DO30, DO_out[30]);
  buf (DO31, DO_out[31]);
  buf (DO32, DO_out[32]);
  buf (DO33, DO_out[33]);
  buf (DO34, DO_out[34]);
  buf (DO35, DO_out[35]);

  assign DI_0 = (DATA_WIDTH_W == 1) ? DI11 : (DATA_WIDTH_W == 2) ? DI11 : DI0;


  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED") begin
      SRN = GSR_sig & PUR_sig ;
    end
    else if (GSR == "DISABLED")
      SRN = PUR_sig;
  end

  initial
  begin
     MEM = 0;
     DI_reg = 0;
     DO_reg = 0;
     DO_out = 0;
     DO_reg_sync = 0;
     DO_reg_async = 0;
     DO_node = 0;
     DO_int = 0;
     DI_reg_sync = 0;
     DI_reg_async = 0;
     ADW_node = 0;
     ADW_node_syncb = 0;
     ADW_var = 0;
     ADW_var_syncb = 0;
     ADR_node = 0;
     ADR_node_syncb = 0;
     ADR_var = 0;
     ADR_var_syncb = 0;
     RPRST_reg1 = 0;
     RPRST_reg2 = 0;
  end

// chip select W decode
  always @ (CSW)
  begin
     if (CSW == 3'b0 && CSDECODE_W == 2'b00)
        CSW_EN = 1'b1;
     else if (CSW == 3'b001 && CSDECODE_W == 2'b01)
        CSW_EN = 1'b1;
     else if (CSW == 3'b010 && CSDECODE_W == 2'b10)
        CSW_EN = 1'b1;
     else if (CSW == 3'b011 && CSDECODE_W == 2'b11)
        CSW_EN = 1'b1;
     else
        CSW_EN = 1'b0;
  end

// chip select R decode
  always @ (CSR)
  begin
     if (CSR == 3'b0 && CSDECODE_R == 2'b00)
        CSR_EN = 1'b1;
     else if (CSR == 3'b001 && CSDECODE_R == 2'b01)
        CSR_EN = 1'b1;
     else if (CSR == 3'b010 && CSDECODE_R == 2'b10)
        CSR_EN = 1'b1;
     else if (CSR == 3'b011 && CSDECODE_R == 2'b11)
        CSR_EN = 1'b1;
     else
        CSR_EN = 1'b0;
  end

assign DI_node = (DATA_WIDTH_W == 1) ? DI[0] :
             (DATA_WIDTH_W == 2) ? DI[1:0] :
             (DATA_WIDTH_W == 4) ? DI[3:0] :
             (DATA_WIDTH_W == 9) ? DI[8:0] :
             (DATA_WIDTH_W == 18) ? DI[17:0]: DI[35:0];
   
   not (SR1, SRN);
   or INST1 (RST_sig, RST_node, SR1);
   or INST2 (RPRST_sig, RPRST_node, SR1);

  always @(posedge WCLK_node)
  begin
     RPRST_reg1 <= RPRST_sig;
     RPRST_reg2 <= RPRST_reg1;
  end
      
  always @(RST_sig or RPRST_sig or RPRST_reg1)
  begin
     if (RST_sig == 1)
     begin
        assign ADW_node = 14'b11111111111111;
        assign ADW_node_syncb = 14'b11111111111111;
     end
     else
     begin
        deassign ADW_node;
        deassign ADW_node_syncb;
     end

     if (RPRST_sig == 1 || RST_sig == 1)
     begin
        assign ADR_node = 14'b11111111111111;
     end
     else
     begin
        deassign ADR_node;
     end

     if (RPRST_reg1 == 1 || RST_sig == 1)
     begin
        assign ADR_node_syncb = 15'b111111111111111;
     end
     else
     begin
        deassign ADR_node_syncb;
     end
  end

  always @(SR1 or DI)
  begin
     if (SR1 == 1)
     begin
        assign DI_reg = 0;
        assign DO_reg = 0;
     end
     else
     begin
        deassign DI_reg;
        deassign DO_reg;
     end
  end

  always @(posedge RST_sig or posedge WCLK_node)
  begin
     if (RST_sig == 1)
     begin
        DI_reg_async <= 0;
     end
     else
     begin
        if (CSW_EN == 1 && WRE_node == 1)
           DI_reg_async <= DI;
     end
  end

  always @(posedge WCLK_node)
  begin
     if (RST_sig == 1)
     begin
        DI_reg_sync <= 0;
     end
     else
     begin
        if (CSW_EN == 1 && WRE_node == 1)
           DI_reg_sync <= DI;
     end
  end

  always @(DI_reg_sync or DI_reg_async)
  begin
     if (RESETMODE == "ASYNC")
        DI_reg = DI_reg_async;
     else
        DI_reg = DI_reg_sync;
  end
 
  always @(posedge WCLK_node)
  begin
     if (CSW_EN == 1 && WRE_node == 1)
     begin
        ADW_node <= ADW_node + 1;
     end
  end

  always @(posedge RCLK_node)
  begin
        ADW_node_syncb <= ADW_node;
  end

  always @(posedge RCLK_node)
  begin
     if (CSR_EN == 1 && RDE_node == 1)
     begin
        ADR_node <= ADR_node + 1;
     end
  end

  always @(posedge WCLK_node)
  begin
        ADR_node_syncb <= ADR_node;
  end

  always @(DI_reg or ADW_node)
  begin
     WADDR = ADW_node[ADDR_WIDTH_W - 1:0];

     if ((DATA_WIDTH_W == 36) | (DATA_WIDTH_W == 18) | (DATA_WIDTH_W == 9))
     begin
        for (i = 0; i < DATA_WIDTH_W; i = i+1)
          begin
             MEM[WADDR * DATA_WIDTH_W + i] = DI_reg[i];
          end
     end
     else
     begin
        for (i = 0; i < DATA_WIDTH_W; i = i+1)
          begin
             MEM[WADDR * DATA_WIDTH_W + (WADDR / div_a) + i] = DI_reg[i];
          end
     end
  end

  always @(ADR_node or posedge RST_sig or posedge RPRST_sig)
  begin
     RADDR = ADR_node[ADDR_WIDTH_R - 1:0];

     if (RST_sig == 1'b1 || RPRST_sig == 1'b1)
     begin
        DO_node = 0;
     end
     else if (RST_sig == 0 && RPRST_sig == 0)
     begin
        for (i = 0; i < DATA_WIDTH_R; i = i+1)
        begin
           DO_node[i] = MEM[(RADDR * DATA_WIDTH_R) + (RADDR / div_b) + i];
        end
     end
  end

  always @(posedge RST_sig or posedge RPRST_sig or posedge RCLK_node)
  begin
     if (RST_sig == 1 || RPRST_sig == 1)
     begin
        DO_reg_async <= 0;
     end
     else
     begin
        if (RDE_node == 1)
           DO_reg_async <= DO_node;
     end
  end

  always @(posedge RCLK_node)
  begin
     if (RST_sig == 1 || RPRST_sig == 1)
     begin
        DO_reg_sync <= 0;
     end
     else
     begin
        if (RDE_node == 1)
           DO_reg_sync <= DO_node;
     end
  end

  always @(DO_reg_sync or DO_reg_async)
  begin
     if (RESETMODE == "ASYNC")
        DO_reg <= DO_reg_async;
     else
        DO_reg <= DO_reg_sync;
  end

  always @(DO_reg or DO_node)
  begin
     if (REGMODE == "OUTREG")
     begin
        DO_int <= DO_reg;
     end
     else
     begin
        DO_int <= DO_node;
     end
  end

  always @(DO_int)
  begin
     if (DATA_WIDTH_R == 1)
        DO_out[0] = DO_int ;
     else if (DATA_WIDTH_R == 2)
        DO_out[1:0] = DO_int ;
     else if (DATA_WIDTH_R == 4)
        DO_out[3:0] = DO_int ;
     else if (DATA_WIDTH_R == 9)
        DO_out[8:0] = DO_int ;
     else if (DATA_WIDTH_R == 18)
        DO_out[17:0] = DO_int ;
     else if (DATA_WIDTH_R == 36)
     begin
        DO_intb = DO_int ;
        DO_out[35:18] = DO_intb[17:0] ;
        DO_out[17:0] = DO_intb[35:18] ;
     end
  end

// Flag Generation
  
  always @(ADW_node)
  begin
     ADW_var = ADW_node + 1;
     
     if (DATA_WIDTH_W == 1)
        ADWF_node <= ADW_var;
     else if (DATA_WIDTH_W == 2)
        ADWF_node <= {ADW_var, 1'b0};
     else if (DATA_WIDTH_W == 4)
        ADWF_node <= {ADW_var, 2'b00};
     else if (DATA_WIDTH_W == 9)
        ADWF_node <= {ADW_var, 3'b000};
     else if (DATA_WIDTH_W == 18)
        ADWF_node <= {ADW_var, 4'b0000};
     else if (DATA_WIDTH_W == 36)
        ADWF_node <= {ADW_var, 5'b00000};
  end

  always @(ADW_node_syncb or posedge RPRST_sig or posedge RCLK_node)
  begin
     ADW_var_syncb = ADW_node_syncb + 1;
    
     if (DATA_WIDTH_W == 1)
     begin
        if (RPRST_sig == 1)
           ADWF_node_syncb <= 14'b00000000000000;
        else
           ADWF_node_syncb <= ADW_var_syncb;
     end
     else if (DATA_WIDTH_W == 2)
     begin
        if (RPRST_sig == 1)
           ADWF_node_syncb <= 14'b00000000000000;
        else
           ADWF_node_syncb <= {ADW_var_syncb, 1'b0};
     end
     else if (DATA_WIDTH_W == 4)
     begin
        if (RPRST_sig == 1)
           ADWF_node_syncb <= 14'b00000000000000;
        else
           ADWF_node_syncb <= {ADW_var_syncb, 2'b00};
     end
     else if (DATA_WIDTH_W == 9)
     begin
        if (RPRST_sig == 1)
           ADWF_node_syncb <= 14'b00000000000000;
        else
           ADWF_node_syncb <= {ADW_var_syncb, 3'b000};
     end
     else if (DATA_WIDTH_W == 18)
     begin
        if (RPRST_sig == 1)
           ADWF_node_syncb <= 14'b00000000000000;
        else
           ADWF_node_syncb <= {ADW_var_syncb, 4'b0000};
     end
     else if (DATA_WIDTH_W == 36)
     begin
        if (RPRST_sig == 1)
           ADWF_node_syncb <= 14'b00000000000000;
        else
           ADWF_node_syncb <= {ADW_var_syncb, 5'b00000};
     end
  end

  always @(ADR_node)
  begin
     ADR_var = ADR_node + 1;
     
     if (DATA_WIDTH_R == 1)
        ADRF_node <= ADR_var;
     else if (DATA_WIDTH_R == 2)
        ADRF_node <= {ADR_var, 1'b0};
     else if (DATA_WIDTH_R == 4)
        ADRF_node <= {ADR_var, 2'b00};
     else if (DATA_WIDTH_R == 9)
        ADRF_node <= {ADR_var, 3'b000};
     else if (DATA_WIDTH_R == 18)
        ADRF_node <= {ADR_var, 4'b0000};
     else if (DATA_WIDTH_R == 36)
        ADRF_node <= {ADR_var, 5'b00000};
  end

  always @(ADR_node_syncb)
  begin
     ADR_var_syncb = ADR_node_syncb + 1;

     if (DATA_WIDTH_R == 1)
        ADRF_node_syncb <= ADR_var_syncb;
     else if (DATA_WIDTH_R == 2)
        ADRF_node_syncb <= {ADR_var_syncb, 1'b0};
     else if (DATA_WIDTH_R == 4)
        ADRF_node_syncb <= {ADR_var_syncb, 2'b00};
     else if (DATA_WIDTH_R == 9)
        ADRF_node_syncb <= {ADR_var_syncb, 3'b000};
     else if (DATA_WIDTH_R == 18)
        ADRF_node_syncb <= {ADR_var_syncb, 4'b0000};
     else if (DATA_WIDTH_R == 36)
        ADRF_node_syncb <= {ADR_var_syncb, 5'b00000};
  end

assign fifo_words_used_syncr = {ADWF_node_syncb[13] ^ ADRF_node[13], ADWF_node_syncb[12:0]} - {1'b0, ADRF_node[12:0]};

assign fifo_words_used_syncw = {ADRF_node_syncb[13] ^ ADWF_node[13], ADWF_node[12:0]} - {1'b0, ADRF_node_syncb[12:0]};

  assign pe_ptr = AEPOINTER[13:0];

  assign empty_ptr = (DATA_WIDTH_R == 1) ? 14'b00000000000000 :
             (DATA_WIDTH_R == 2) ? 14'b00000000000001 :
             (DATA_WIDTH_R == 4) ? 14'b00000000000011 :
             (DATA_WIDTH_R == 9) ? 14'b00000000000111 :
             (DATA_WIDTH_R == 18) ? 14'b00000000001111 : 14'b00000000011111 ;

  buf (EF, (fifo_words_used_syncr <= empty_ptr));
  buf (AEF, (fifo_words_used_syncr <= pe_ptr));
  buf (AFF, (fifo_words_used_syncw >= AFPOINTER));
  buf (FF, (fifo_words_used_syncw >= FULLPOINTER));

endmodule


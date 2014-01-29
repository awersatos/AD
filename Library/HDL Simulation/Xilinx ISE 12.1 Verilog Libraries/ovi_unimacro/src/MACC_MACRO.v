// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/unimacro/data/devlib/verilog/MACC_MACRO.v,v 1.12 2009/12/02 23:07:42 vandanad Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2008 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Macro for DSP48E, DSP48E1 
// /___/   /\     Filename : MACC_MACRO.v
// \   \  /  \    Timestamp : Fri June 06 16:44:06 PST 2008
//  \___\/\___\
//
// Revision:
//    06/06/08 - Initial version.
// End Revision

`timescale  1 ps / 1 ps

module MACC_MACRO (P, A, ADDSUB, B, CARRYIN, CE, CLK, LOAD, LOAD_DATA, RST);
	
// Visible parameters
   parameter DEVICE = "VIRTEX5";
  parameter LATENCY = 3;
  parameter WIDTH_A = 25;
  parameter WIDTH_B = 18;
  parameter WIDTH_P = 48;


//Parameter checks 
    initial begin

    if (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6");
    else
    begin
      $display("Attribute Syntax Error : The attribute DEVICE on MACC_MACRO instance %m is set to %s. Allowed values of this attribute are VIRTEX5, VIRTEX6, SPARTAN6", DEVICE);
      $finish;
    end
    if(DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6")
    begin
        if (LATENCY >= 1 && LATENCY <= 4);
        else
        begin
	  $display("Attribute Syntax Error : The attribute LATENCY on MACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 4", LATENCY);
          $finish;
	end
        if (WIDTH_A > 0 && WIDTH_A <= 25);
        else
        begin
	  $display("Attribute Syntax Error : The attribute WIDTH_A on MACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 25", WIDTH_A);
          $finish;
	end
        if (WIDTH_B > 0 && WIDTH_B <= 18);
        else
        begin
	  $display("Attribute Syntax Error : The attribute WIDTH_B on MACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18", WIDTH_B);
          $finish;
	end
        if (WIDTH_P > 0 && WIDTH_P <= 48);
        else
        begin
	  $display("Attribute Syntax Error : The attribute WIDTH_P on MACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 48", WIDTH_P);
          $finish;
        end
    end // end checks virtex5
    if (DEVICE == "SPARTAN6")
    begin
      if (LATENCY >= 1 && LATENCY <= 4);
      else
        begin
	  $display("Attribute Syntax Error : The attribute LATENCY on MACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 4", LATENCY);
          $finish;
	end
      if (WIDTH_A > 0 && WIDTH_A <= 18);
      else 
        begin
	  $display("Attribute Syntax Error : The attribute WIDTH_A on MACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18", WIDTH_A);
          $finish;
	end
      if (WIDTH_B > 0 && WIDTH_B <= 18);
      else
        begin
	  $display("Attribute Syntax Error : The attribute WIDTH_B on MACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18", WIDTH_B);
          $finish;
	end
      if (WIDTH_P > 0 && WIDTH_P <= 48);
      else
        begin
	  $display("Attribute Syntax Error : The attribute WIDTH_P on MACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 48", WIDTH_P);
          $finish;
	end
    end // end checks spartan6
    end // initial begin

//Parameters not visible in HDL template
  parameter MODEL_TYPE = 0;
  parameter VERBOSITY = 0;

// Output ports
  output [WIDTH_P-1:0] P;

// Input ports
  input [WIDTH_A-1:0] A;
  input               ADDSUB;
  input [WIDTH_B-1:0] B;
  input               CARRYIN;
  input               CE;
  input               CLK;       
  input               LOAD;
  input [WIDTH_P-1:0] LOAD_DATA;
  input               RST;

  wire [24:0] A_IN;
  wire [17:0] A_INST;
  wire [17:0] B_IN;
  wire [47:0] LOAD_DATA_IN;
  wire [47:0] P_OUT;
  wire CEA1_IN;
  wire CEB1_IN;
  wire CEA2_IN;
  wire CEB2_IN;


  localparam AREG_IN = (LATENCY == 2 || LATENCY == 3) ? 1 : (LATENCY == 4) ? 2 : 0;
  localparam BREG_IN = (LATENCY == 2 || LATENCY == 3) ? 1 : (LATENCY == 4) ? 2 : 0;
  localparam MREG_IN = (LATENCY == 3 || LATENCY == 4) ? 1 : 0;
  localparam PREG_IN = (LATENCY == 1 || LATENCY == 2 || LATENCY == 3 || LATENCY == 4) ? 1 : 0; 
  localparam A1REG_IN = (LATENCY == 2 || LATENCY == 3|| LATENCY == 4) ? 1 : 0;
  localparam A0REG_IN = (LATENCY == 4) ? 1 : 0;
  localparam B1REG_IN = (LATENCY == 2 || LATENCY == 3|| LATENCY == 4) ? 1 : 0;
  localparam B0REG_IN = (LATENCY == 4) ? 1 : 0;

  assign CEA1_IN = (AREG_IN == 2) ? CE : 1'b0;
  assign CEA2_IN = (AREG_IN == 1 || AREG_IN == 2) ? CE : 1'b0;
  assign CEB1_IN = (BREG_IN == 2) ? CE : 1'b0;
  assign CEB2_IN = (BREG_IN == 1 || BREG_IN == 2) ? CE : 1'b0;
// Sign extend inputs

  generate if(WIDTH_B == 18) begin : b18
    assign B_IN = B; 
  end
  endgenerate
  generate if(WIDTH_B < 18) begin : b17
    assign B_IN = (B[WIDTH_B-1] == 1'b1) ? {{(18-(WIDTH_B)){1'b1}}, B} : {{(18-(WIDTH_B)){1'b0}}, B}; 
  end
  endgenerate


  generate 
    case (DEVICE)
      "VIRTEX5", "VIRTEX6" :
       begin
         if(WIDTH_A == 25) begin : b25
             assign A_IN = A; 
          end
         if(WIDTH_A < 25) begin : b24
             assign A_IN =  (A[WIDTH_A-1] == 1'b1) ? {{(25-(WIDTH_A)){1'b1}}, A} : {{(25-(WIDTH_A)){1'b0}}, A}; 
          end
       end
      "SPARTAN6" :
       begin
         if(WIDTH_A == 18) begin : b18st
           assign A_INST =  A; 
         end
         if(WIDTH_A < 18) begin : b17st
           assign A_INST =  (A[WIDTH_A-1] == 1'b1) ? {{(18-(WIDTH_A)){1'b1}}, A} : {{(18-(WIDTH_A)){1'b0}}, A}; 
         end
       end
    endcase
  endgenerate

  generate if(WIDTH_P == 48) begin : l48
    assign LOAD_DATA_IN = LOAD_DATA;
  end
  endgenerate
  generate if(WIDTH_P < 48) begin : l47
    assign LOAD_DATA_IN = { {(48-(WIDTH_P)){1'b0}}, LOAD_DATA };
  end
  endgenerate
  assign P = P_OUT[WIDTH_P-1:0];
  

// Instantiation
  generate
  case(DEVICE)
    "VIRTEX5":
      if (LATENCY >= 0 && LATENCY <= 2) begin : dsp_v5
      DSP48E #(
        .ACASCREG(AREG_IN),       
        .AREG(AREG_IN),           
        .BCASCREG(BREG_IN),       
        .BREG(BREG_IN),           
        .MREG(MREG_IN),           
        .PREG(PREG_IN),
        .USE_MULT("MULT")           
      ) 
      DSP48E_V5 (
        .ACOUT(),   
        .BCOUT(),  
        .CARRYCASCOUT(), 
        .CARRYOUT(), 
        .MULTSIGNOUT(), 
        .OVERFLOW(), 
        .P(P_OUT),          
        .PATTERNBDETECT(), 
        .PATTERNDETECT(), 
        .PCOUT(),  
        .UNDERFLOW(), 
        .A({5'b0,A_IN}),          
        .ACIN(30'b0),    
        .ALUMODE({2'b00, ~ADDSUB,~ADDSUB}), 
        .B(B_IN),          
        .BCIN(18'b0),    
        .C(LOAD_DATA_IN),          
        .CARRYCASCIN(1'b0), 
        .CARRYIN(CARRYIN), 
        .CARRYINSEL(3'b0), 
        .CEA1(CEA1_IN),      
        .CEA2(CEA2_IN),      
        .CEALUMODE(CE), 
        .CEB1(CEB1_IN),      
        .CEB2(CEB2_IN),      
        .CEC(CE),      
        .CECARRYIN(CE), 
        .CECTRL(CE), 
        .CEM(CE),       
        .CEMULTCARRYIN(CE),
        .CEP(CE),       
        .CLK(CLK),       
        .MULTSIGNIN(1'b0), 
        .OPMODE({2'b01,LOAD,4'b0101}), 
        .PCIN(48'b0),      
        .RSTA(RST),     
        .RSTALLCARRYIN(RST), 
        .RSTALUMODE(RST), 
        .RSTB(RST),     
        .RSTC(RST),     
        .RSTCTRL(RST), 
        .RSTM(RST), 
        .RSTP(RST) 
     );
    end
    else if (LATENCY == 3 || LATENCY == 4) begin : dsp_v5_1
         DSP48E #(
        .ACASCREG(AREG_IN),       
        .AREG(AREG_IN),           
        .BCASCREG(BREG_IN),       
        .BREG(BREG_IN),           
        .MREG(MREG_IN),           
        .PREG(PREG_IN),
        .USE_MULT("MULT_S")           
      ) 
      DSP48E_V5 (
        .ACOUT(),   
        .BCOUT(),  
        .CARRYCASCOUT(), 
        .CARRYOUT(), 
        .MULTSIGNOUT(), 
        .OVERFLOW(), 
        .P(P_OUT),          
        .PATTERNBDETECT(), 
        .PATTERNDETECT(), 
        .PCOUT(),  
        .UNDERFLOW(), 
        .A({5'b0,A_IN}),          
        .ACIN(30'b0),    
        .ALUMODE({2'b00, ~ADDSUB,~ADDSUB}), 
        .B(B_IN),          
        .BCIN(18'b0),    
        .C(LOAD_DATA_IN),          
        .CARRYCASCIN(1'b0), 
        .CARRYIN(CARRYIN), 
        .CARRYINSEL(3'b0), 
        .CEA1(CEA1_IN),      
        .CEA2(CEA2_IN),      
        .CEALUMODE(CE), 
        .CEB1(CEB1_IN),      
        .CEB2(CEB2_IN),      
        .CEC(CE),      
        .CECARRYIN(CE), 
        .CECTRL(CE), 
        .CEM(CE),       
        .CEMULTCARRYIN(CE),
        .CEP(CE),       
        .CLK(CLK),       
        .MULTSIGNIN(1'b0), 
        .OPMODE({2'b01,LOAD,4'b0101}), 
        .PCIN(48'b0),      
        .RSTA(RST),     
        .RSTALLCARRYIN(RST), 
        .RSTALUMODE(RST), 
        .RSTB(RST),     
        .RSTC(RST),     
        .RSTCTRL(RST), 
        .RSTM(RST), 
        .RSTP(RST) 
     );
    end // end generate virtex5
    // begin generate virtex6
    "VIRTEX6" :
    begin : dsp_bl
      DSP48E1 #(
        .ACASCREG(AREG_IN),       
        .AREG(AREG_IN),           
        .ADREG(0),
        .BCASCREG(BREG_IN),       
        .BREG(BREG_IN), 
        .DREG(0),          
        .MREG(MREG_IN),           
        .PREG(PREG_IN)           
      ) 
      DSP48E_BL (
        .ACOUT(),   
        .BCOUT(),  
        .CARRYCASCOUT(), 
        .CARRYOUT(), 
        .MULTSIGNOUT(), 
        .OVERFLOW(), 
        .P(P_OUT),          
        .PATTERNBDETECT(), 
        .PATTERNDETECT(), 
        .PCOUT(),  
        .UNDERFLOW(), 
        .A({5'b0,A_IN}),          
        .ACIN(30'b0),    
        .ALUMODE({2'b00, ~ADDSUB,~ADDSUB}), 
        .B(B_IN),          
        .BCIN(18'b0),    
        .C(LOAD_DATA_IN),          
        .CARRYCASCIN(1'b0), 
        .CARRYIN(CARRYIN), 
        .CARRYINSEL(3'b0), 
        .CEA1(CEA1_IN),      
        .CEA2(CEA2_IN),      
        .CEAD(CE),
        .CEALUMODE(CE), 
        .CEB1(CEB1_IN),      
        .CEB2(CEB2_IN),      
        .CEC(CE),      
        .CECARRYIN(CE), 
        .CECTRL(CE),
        .CED(CE), 
        .CEINMODE(CE),
        .CEM(CE),       
        .CEP(CE),       
        .CLK(CLK),       
        .D(25'b0),
        .INMODE(5'b0),
        .MULTSIGNIN(1'b0), 
        .OPMODE({2'b01, LOAD, 4'b0101}), 
        .PCIN(48'b0),      
        .RSTA(RST),     
        .RSTALLCARRYIN(RST), 
        .RSTALUMODE(RST), 
        .RSTB(RST),     
        .RSTC(RST),     
        .RSTCTRL(RST), 
        .RSTD(RST),
        .RSTINMODE(RST),
        .RSTM(RST), 
        .RSTP(RST) 
       );
     end // end generate virtex6
     // begin generate spartan6
    "SPARTAN6" :
     begin : dsp_st
     DSP48A1 #(
       .A0REG(A0REG_IN),           
       .A1REG(A1REG_IN),           
       .B0REG(B0REG_IN),           
       .B1REG(B1REG_IN),           
       .MREG(MREG_IN),           
       .PREG(PREG_IN)           
     ) 
     DSP48AST (
       .BCOUT(), 
       .CARRYOUT(), 
       .CARRYOUTF(), 
       .M(),
       .P(P_OUT),
       .PCOUT(),
       .A(A_INST),
       .B(B_IN),
       .C(LOAD_DATA_IN), 
       .CARRYIN(CARRYIN), 
       .CEA(CE), 
       .CEB(CE), 
       .CEC(CE), 
       .CECARRYIN(CE), 
       .CED(CE), 
       .CEM(CE), 
       .CEOPMODE(CE), 
       .CEP(CE), 
       .CLK(CLK), 
       .D(18'b0), 
       .OPMODE({~ADDSUB, ~ADDSUB,3'b001,LOAD, 2'b01}), 
       .PCIN(48'b0), 
       .RSTA(RST), 
       .RSTB(RST), 
       .RSTC(RST), 
       .RSTCARRYIN(RST), 
       .RSTD(RST), 
       .RSTM(RST), 
       .RSTOPMODE(RST), 
       .RSTP(RST)
       );
  end // end generate spartan6
  default : ;
  endcase
  endgenerate
endmodule







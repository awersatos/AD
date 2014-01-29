// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/unimacro/data/devlib/verilog/MULT_MACRO.v,v 1.11 2009/12/02 23:07:42 vandanad Exp $
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
// /___/   /\     Filename : MULT_MACRO.v
// \   \  /  \    Timestamp : Fri June 06 16:44:06 PST 2008
//  \___\/\___\
//
// Revision:
//   06/06/08 - Initial version.
// End Revision

`timescale  1 ps / 1 ps

module MULT_MACRO (P, A, B, CE, CLK, RST);

//visible parameters
   parameter DEVICE = "VIRTEX5";
  parameter LATENCY = 3;
  parameter STYLE = "DSP";
  parameter WIDTH_A = 18;
  parameter WIDTH_B = 18;	


//Parameter checks 
    initial begin
     if (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6");
      else
        begin
          $display("Attribute Syntax Error : The attribute DEVICE on ADDMACC_MACRO instance %m is set to %s.  Allowed values of this attribute are VIRTEX5, VIRTEX6, SPARTAN6", DEVICE);
          $finish;
        end
    if (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6")
    begin  
     if (STYLE == "AUTO" || STYLE == "DSP");
      else
        begin
	  $display("Attribute Syntax Error : The attribute STYLE on MULT_MACRO instance %m is set to %s.  Legal values of this attribute are AUTO or DSP", STYLE);
          $finish;
	end
     if (LATENCY >= 0 && LATENCY <= 4);
      else
        begin
	  $display("Attribute Syntax Error : The attribute LATENCY on MULT_MACRO instance %m is set to %d.  Allowed values of this attribute are 0 to 4", LATENCY);
          $finish;
	end
     if (WIDTH_A > 0 && WIDTH_A <= 25);
     else
        begin
	  $display("Attribute Syntax Error : The attribute WIDTH_A on MULT_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 25", WIDTH_A);
          $finish;
	end
     if (WIDTH_B > 0 && WIDTH_B <= 18);
      else
        begin
	  $display("Attribute Syntax Error : The attribute WIDTH_B on MULT_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18", WIDTH_B);
          $finish;
	end 
   end // end checks virtex5
   if (DEVICE == "SPARTAN6")
   begin   
     if (STYLE == "AUTO" || STYLE == "DSP");
     else
        begin
	  $display("Attribute Syntax Error : The attribute STYLE on MULT_MACRO instance %m is set to %s.  Legal values of this attribute are AUTO or DSP", STYLE);
          $finish;
	end
     if (LATENCY >= 0 && LATENCY <= 4);
      else
        begin
	  $display("Attribute Syntax Error : The attribute LATENCY on MULT_MACRO instance %m is set to %d.  Allowed values of this attribute are 0 to 4", LATENCY);
          $finish;
	end
     if (WIDTH_A > 0 && WIDTH_A <= 18);
     else
        begin
	  $display("Attribute Syntax Error : The attribute WIDTH_A on MULT_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18", WIDTH_A);
          $finish;
	end
     if (WIDTH_B > 0 && WIDTH_B <= 18);
      else
        begin
	  $display("Attribute Syntax Error : The attribute WIDTH_B on MULT_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18", WIDTH_B);
          $finish;
	end
    end // end checks spartan6
    end // initial begin

//parameters not visible on HDL template
  parameter MODEL_TYPE = 0;
  parameter VERBOSITY = 0;

//Output ports
  output [(WIDTH_A+WIDTH_B-1):0] P;

//Input ports
  input [WIDTH_A-1:0] A;
  input [WIDTH_B-1:0] B;
  input               CE;
  input               CLK;
  input               RST;

  wire [24:0] A_IN;
  wire [17:0] A_INST;
  wire [17:0] B_IN;
  wire [47:0] P1_OUT;
  wire [35:0] P1_OUTST;
  wire CEA1_IN;
  wire CEB1_IN;
  wire CEA2_IN;
  wire CEB2_IN;

  localparam AREG_IN = (LATENCY == 2 || LATENCY == 3) ? 1 : (LATENCY == 4) ? 2 : 0;
  localparam BREG_IN = (LATENCY == 2 || LATENCY == 3) ? 1 : (LATENCY == 4) ? 2 : 0;
  localparam MREG_IN = (LATENCY == 1 || LATENCY == 2 || LATENCY == 3 || LATENCY == 4) ? 1 : 0; 
  localparam PREG_IN = (LATENCY == 3 || LATENCY == 4) ? 1 : 0;
  localparam A1REG_IN = (LATENCY == 2 || LATENCY == 3|| LATENCY == 4) ? 1 : 0;
  localparam A0REG_IN = (LATENCY == 4) ? 1 : 0;
  localparam B1REG_IN = (LATENCY == 2 || LATENCY == 3|| LATENCY == 4) ? 1 : 0;
  localparam B0REG_IN = (LATENCY == 4) ? 1 : 0;

  assign CEA1_IN = (AREG_IN == 2) ? CE : 1'b0;
  assign CEA2_IN = (AREG_IN == 1 || AREG_IN == 2) ? CE : 1'b0;
  assign CEB1_IN = (BREG_IN == 2) ? CE : 1'b0;
  assign CEB2_IN = (BREG_IN == 1 || BREG_IN == 2) ? CE : 1'b0;
 // squeeze Multiplier into MSBs
 
 generate
     case(DEVICE)
       "VIRTEX5", "VIRTEX6" : 
        begin
          if(WIDTH_A == 25) 
           assign A_IN =  A ; 
          if(WIDTH_B == 18) 
            assign B_IN =  B ; 
        end
       "SPARTAN6" :
        begin 
          if(WIDTH_A == 18) 
           assign A_INST =  A ; 
          if(WIDTH_B == 18) 
           assign B_IN =  B ;
        end // s1
      default : ;
    endcase
 endgenerate
 generate
     case(DEVICE)
       "VIRTEX5", "VIRTEX6" :
        begin 
          if(WIDTH_A < 25) 
           assign A_IN =  { A, {(25-(WIDTH_A)){1'b0}}}; 
          if(WIDTH_B < 18) 
           assign B_IN = { B, {(18-(WIDTH_B)){1'b0}}};
        end
       "SPARTAN6" : 
        begin
          if(WIDTH_A < 18) 
           assign A_INST =  { A, {(18-(WIDTH_A)){1'b0}}}; 
          if(WIDTH_B < 18) 
           assign B_IN = { B, {(18-(WIDTH_B)){1'b0}}}; 
        end // s2
      default : ;
    endcase
 endgenerate
 generate
     case(DEVICE)
       "VIRTEX5", "VIRTEX6" : 
          assign P = P1_OUT[42 : (42-((WIDTH_A+WIDTH_B)-1))];
       "SPARTAN6":
          assign P = P1_OUTST[35 : (35-((WIDTH_A+WIDTH_B)-1))];
          // s3
    endcase
 endgenerate

// Instantiation

  generate
    case(DEVICE)
    // begin generate virtex5
     "VIRTEX5" :
      if (LATENCY == 0) begin : dsp_v5
      DSP48E #(
        .ACASCREG(AREG_IN),       
        .AREG(AREG_IN),           
        .BCASCREG(BREG_IN),       
        .BREG(BREG_IN),           
        .MREG(MREG_IN),           
        .PREG(PREG_IN),
        .USE_MULT("MULT")           
      ) 
      DSP48_V5 (
        .ACOUT(),   
        .BCOUT(),  
        .CARRYCASCOUT(), 
        .CARRYOUT(), 
        .MULTSIGNOUT(), 
        .OVERFLOW(), 
        .P(P1_OUT),          
        .PATTERNBDETECT(), 
        .PATTERNDETECT(), 
        .PCOUT(),  
        .UNDERFLOW(), 
        .A({5'b0,A_IN}),          
        .ACIN(30'b0),    
        .ALUMODE(4'b0000), 
        .B(B_IN),          
        .BCIN(18'b0),    
        .C(48'b0),          
        .CARRYCASCIN(1'b0), 
        .CARRYIN(1'b0), 
        .CARRYINSEL(3'b0), 
        .CEA1(CEA1_IN),      
        .CEA2(CEA2_IN),      
        .CEALUMODE(1'b1), 
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
        .OPMODE(7'b0000101), 
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
    else if (LATENCY > 0) begin : dsp_v5_1
      DSP48E #(
        .ACASCREG(AREG_IN),       
        .AREG(AREG_IN),           
        .BCASCREG(BREG_IN),       
        .BREG(BREG_IN),           
        .MREG(MREG_IN),           
        .PREG(PREG_IN),
        .USE_MULT("MULT_S")           
      ) 
      DSP48_V5_1 (
        .ACOUT(),   
        .BCOUT(),  
        .CARRYCASCOUT(), 
        .CARRYOUT(), 
        .MULTSIGNOUT(), 
        .OVERFLOW(), 
        .P(P1_OUT),          
        .PATTERNBDETECT(), 
        .PATTERNDETECT(), 
        .PCOUT(),  
        .UNDERFLOW(), 
        .A({5'b0,A_IN}),          
        .ACIN(30'b0),    
        .ALUMODE(4'b0000), 
        .B(B_IN),          
        .BCIN(18'b0),    
        .C(48'b0),          
        .CARRYCASCIN(1'b0), 
        .CARRYIN(1'b0), 
        .CARRYINSEL(3'b0), 
        .CEA1(CEA1_IN),      
        .CEA2(CEA2_IN),      
        .CEALUMODE(1'b1), 
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
        .OPMODE(7'b0000101), 
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
        .DREG(0),
        .BCASCREG(BREG_IN),       
        .BREG(BREG_IN),           
        .MREG(MREG_IN),           
        .PREG(PREG_IN)           
      ) 
      DSP48_BL (
        .ACOUT(),   
        .BCOUT(),  
        .CARRYCASCOUT(), 
        .CARRYOUT(), 
        .MULTSIGNOUT(), 
        .OVERFLOW(), 
        .P(P1_OUT),          
        .PATTERNBDETECT(), 
        .PATTERNDETECT(), 
        .PCOUT(),  
        .UNDERFLOW(), 
        .A({5'b0,A_IN}),          
        .ACIN(30'b0),    
        .ALUMODE(4'b0000), 
        .B(B_IN),          
        .BCIN(18'b0),    
        .C(48'b0),          
        .CARRYCASCIN(1'b0), 
        .CARRYIN(1'b0), 
        .CARRYINSEL(3'b0), 
        .CEA1(CEA1_IN),      
        .CEA2(CEA2_IN),      
        .CEAD(1'b0),
        .CEALUMODE(1'b1), 
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
        .OPMODE(7'b0000101), 
        .PCIN(48'b0),      
        .RSTA(RST),     
        .RSTALLCARRYIN(RST), 
        .RSTALUMODE(RST), 
        .RSTB(RST),     
        .RSTC(RST),   
        .RSTD(RST),  
        .RSTCTRL(RST),
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
       .M(P1_OUTST),
       .P(),
       .PCOUT(),
       .A(A_INST),
       .B(B_IN),
       .C(48'b0), 
       .CARRYIN(1'b0), 
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
       .OPMODE(8'b00000001), 
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
  endcase
  endgenerate

endmodule







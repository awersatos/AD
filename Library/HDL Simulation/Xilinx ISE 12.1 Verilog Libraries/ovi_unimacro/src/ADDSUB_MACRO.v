// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/unimacro/data/devlib/verilog/ADDSUB_MACRO.v,v 1.10 2009/12/02 23:07:42 vandanad Exp $
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
// /___/   /\     Filename : ADDSUB_MACRO.v
// \   \  /  \    Timestamp : Fri June 6 16:44:06 PST 2008
//  \___\/\___\
//
// Revision:
//    06/06/08 - Initial version.
// End Revision

`timescale  1 ps / 1 ps

module ADDSUB_MACRO (CARRYOUT, RESULT, A, ADD_SUB, B, CARRYIN, CE, CLK, RST);

  // visible parameters in HDL template
   parameter DEVICE = "VIRTEX5";
  parameter LATENCY = 2;
  parameter STYLE = "DSP";
  parameter WIDTH = 48;


 //Parameter checks 
    initial begin
      if (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6");
      else
        begin
	  $display("Attribute Syntax Error : The attribute DEVICE on ADDSUB_MACRO instance %m is set to %s.  Allowed values of this attribute are VIRTEX5, VIRTEX6, SPARTAN6", DEVICE);
          $finish;
	end
     if (STYLE == "AUTO" || STYLE == "DSP");
      else
        begin
	  $display("Attribute Syntax Error : The attribute STYLE on ADDSUB_MACRO instance %m is set to %s.  Legal values of this attribute are AUTO or DSP", STYLE);
          $finish;
	end
     if (LATENCY >= 0 && LATENCY <= 2);
      else
        begin
	  $display("Attribute Syntax Error : The attribute LATENCY on ADDSUB_MACRO instance %m is set to %d.  Allowed values of this attribute are 0 to 2", LATENCY);
          $finish;
	end
     if (WIDTH > 0 && WIDTH <= 48);
      else
        begin
	  $display("Attribute Syntax Error : The attribute WIDTH on ADDSUB_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 48", WIDTH);
          $finish;
	end
    end // initial begin

 
 // parameters not visible in HDL template
  parameter WIDTH_B = 48;
  parameter WIDTH_RESULT = 48;
  parameter MODEL_TYPE = 0;
  parameter VERBOSITY = 0;
 	
 // output ports
  output             CARRYOUT;
  output [WIDTH-1:0] RESULT;

 // input ports
  input [WIDTH-1:0] A;
  input [WIDTH-1:0] B;
  input             ADD_SUB;
  input             CARRYIN;
  input             CE;
  input             CLK;
  input             RST;

  wire [47:0] A_IN;
  wire [47:0] B_IN;
  wire [47:0] RESULT_OUT;
  wire [3:0]  CARRYOUT_OUT;
  wire CARRYOUT_ST;
  wire CARRYIN_IN;

  localparam AREG_IN = (LATENCY == 2) ? 1 : 0;
  localparam BREG_IN = (LATENCY == 2) ? 1 : 0;
  localparam CREG_IN = (LATENCY == 2) ? 1 : 0;
  localparam PREG_IN = (LATENCY == 1 || LATENCY == 2) ? 1 : 0;

  // squeeze adder into MSBs
  generate if(WIDTH == 48) begin : add_48
    assign A_IN =  A ; 
    assign B_IN =  B ; 
  end
  endgenerate
  generate if(WIDTH == 47) begin : add
    assign A_IN = { A[(WIDTH-1):0], ADD_SUB}; 
    assign B_IN = { B[(WIDTH-1):0], CARRYIN}; 
  end
  endgenerate
  generate if(WIDTH < 47) begin : add1
    assign A_IN = { A, ADD_SUB,{(47-(WIDTH)){1'b0}}};
    assign B_IN = { B, CARRYIN,{(47-(WIDTH)){1'b0}}};
  end
  endgenerate

  assign CARRYIN_IN = (WIDTH == 48) ? CARRYIN : 1'b0;
  assign RESULT = RESULT_OUT[47 :(47-(WIDTH-1))];
  generate
     case(DEVICE)
       "VIRTEX5", "VIRTEX6" : 
        begin
          assign CARRYOUT = CARRYOUT_OUT[3];
        end
       "SPARTAN6" :
        begin
          assign CARRYOUT = CARRYOUT_ST;
        end
     endcase
  endgenerate
 
 // Instantiation
 generate
   case(DEVICE)
   // begin generate virtex5
   "VIRTEX5" :
   begin : dsp_v5 
      DSP48E #(
        .ACASCREG(AREG_IN),       
        .AREG(AREG_IN),           
        .BCASCREG(BREG_IN),       
        .BREG(BREG_IN),           
        .CREG(CREG_IN),           
        .PREG(PREG_IN),           
        .USE_MULT("NONE") 
      ) 
      DSP48E_V5 (
        .ACOUT(),   
        .BCOUT(),  
        .CARRYCASCOUT(), 
        .CARRYOUT(CARRYOUT_OUT[3:0]), 
        .MULTSIGNOUT(), 
        .OVERFLOW(), 
        .P(RESULT_OUT),          
        .PATTERNBDETECT(), 
        .PATTERNDETECT(), 
        .PCOUT(),  
        .UNDERFLOW(), 
        .A(B_IN[47:18]),          
        .ACIN(30'b0),    
        .ALUMODE({2'b00, ~ADD_SUB, ~ADD_SUB}), 
        .B(B_IN[17:0]),          
        .BCIN(18'b0),    
        .C(A_IN),          
        .CARRYCASCIN(1'b0), 
        .CARRYIN(CARRYIN_IN), 
        .CARRYINSEL(3'b0), 
        .CEA1(CE),      
        .CEA2(CE),      
        .CEALUMODE(CE), 
        .CEB1(CE),      
        .CEB2(CE),      
        .CEC(CE),      
        .CECARRYIN(CE), 
        .CECTRL(CE), 
        .CEM(CE),       
        .CEMULTCARRYIN(CE),
        .CEP(CE),       
        .CLK(CLK),       
        .MULTSIGNIN(1'b0), 
        .OPMODE(7'b0110011), 
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
    "VIRTEX6": 
     begin : dsp_bl
      DSP48E1 #(
       .ACASCREG(AREG_IN),
       .AREG(AREG_IN),           
       .ADREG(0),
       .BCASCREG(BREG_IN),       
       .BREG(BREG_IN),           
       .CREG(CREG_IN),           
       .DREG(0),
       .MREG(0),
       .PREG(PREG_IN),           
       .USE_MULT("NONE")
     ) 
     DSP48E_BL (
       .ACOUT(),   
       .BCOUT(),  
       .CARRYCASCOUT(), 
       .CARRYOUT(CARRYOUT_OUT), 
       .MULTSIGNOUT(), 
       .OVERFLOW(), 
       .P(RESULT_OUT),          
       .PATTERNBDETECT(), 
       .PATTERNDETECT(), 
       .PCOUT(),  
       .UNDERFLOW(), 
       .A(B_IN[47:18]),          
       .ACIN(30'b0),    
       .ALUMODE({2'b00, ~ADD_SUB, ~ADD_SUB}), 
       .B(B_IN[17:0]),          
       .BCIN(18'b0),    
       .C(A_IN),          
       .CARRYCASCIN(1'b0), 
       .CARRYIN(CARRYIN_IN), 
       .CARRYINSEL(3'b0), 
       .CEA1(CE),      
       .CEA2(CE),      
       .CEAD(CE),
       .CEALUMODE(CE), 
       .CEB1(CE),      
       .CEB2(CE),      
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
       .OPMODE(7'b0110011), 
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
       .A1REG(AREG_IN),           
       .B1REG(BREG_IN),           
       .CREG(CREG_IN),           
       .PREG(PREG_IN)           
      ) 
     DSP48AST (
       .BCOUT(), 
       .CARRYOUT(CARRYOUT_ST), 
       .CARRYOUTF(), 
       .M(),
       .P(RESULT_OUT),
       .PCOUT(),
       .A(B_IN[35:18]),
       .B(B_IN[17:0]),
       .C(A_IN), 
       .CARRYIN(CARRYIN_IN), 
       .CEA(CE), 
       .CEB(CE), 
       .CEC(CE), 
       .CECARRYIN(CE), 
       .CED(CE), 
       .CEM(1'b0), 
       .CEOPMODE(CE), 
       .CEP(CE), 
       .CLK(CLK), 
       .D({6'b0,B_IN[47:36]}), 
       .OPMODE({~ADD_SUB, ~ADD_SUB, 6'b001111}), 
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








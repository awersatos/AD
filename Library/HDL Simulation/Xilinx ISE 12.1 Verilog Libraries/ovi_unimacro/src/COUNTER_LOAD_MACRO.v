// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/unimacro/data/devlib/verilog/COUNTER_LOAD_MACRO.v,v 1.7 2009/08/27 18:32:47 vandanad Exp $
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
// /___/   /\     Filename : COUNTER_LOAD_MACRO.v
// \   \  /  \    Timestamp : Fri April 18 16:44:06 PST 2008
//  \___\/\___\
//
// Revision:
//    04/18/08 - Initial version.
// End Revision

`timescale  1 ps / 1 ps

module COUNTER_LOAD_MACRO (Q, CLK, CE, DIRECTION, LOAD, LOAD_DATA, RST) ;

// Visible parameters	
   parameter COUNT_BY = 48'h000000000001;
   parameter DEVICE = "VIRTEX5";
   parameter STYLE = "DSP";
   parameter WIDTH_DATA = 48;


//Parameter checks 
    initial begin
      if (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6");
      else
        begin
	  $display("Attribute Syntax Error : The attribute DEVICE on COUNTER_LOAD_MACRO instance %m is set to %s.  Allowed values of this attribute are VIRTEX5, VIRTEX6, SPARTAN6", DEVICE);
          $finish;
	end
      if (STYLE == "AUTO" || STYLE == "DSP");
      else
        begin
	  $display("Attribute Syntax Error : The attribute STYLE on COUNTER_LOAD_MACRO instance %m is set to %s.  Legal values of this attribute are AUTO or DSP", STYLE);
          $finish;
	end
      if (WIDTH_DATA > 0 && WIDTH_DATA <= 48);
      else
        begin
	  $display("Attribute Syntax Error : The attribute WIDTH_DATA on COUNTER_LOAD_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 48", WIDTH_DATA);
          $finish;
	end
    end // initial begin

// Output ports
  output [WIDTH_DATA-1:0] Q;

// Input ports
  input                  CLK;
  input                  CE;
  input                  DIRECTION;
  input                  LOAD;
  input [WIDTH_DATA-1:0] LOAD_DATA;
  input                  RST;


  wire [47:0] CNTR_OUT_INT;
  wire [47:0] LOAD_DATA_IN;

  generate if(WIDTH_DATA == 48) begin : c48
    assign LOAD_DATA_IN = LOAD_DATA;
  end
  endgenerate
  generate if(WIDTH_DATA < 48) begin : c46
    assign LOAD_DATA_IN = { {(48-(WIDTH_DATA)){1'b0}}, LOAD_DATA } ;
  end
  endgenerate

  assign Q = CNTR_OUT_INT[(WIDTH_DATA-1) : 0];

// Instantiation

  generate 
    case(DEVICE)
     // begin generate virtex5
     "VIRTEX5" :
      begin
        DSP48E #(
          .USE_MULT("NONE") 
        ) 
        DSP48E_V5 (
          .ACOUT(),   
          .BCOUT(),  
          .CARRYCASCOUT(), 
          .CARRYOUT(), 
          .MULTSIGNOUT(), 
          .OVERFLOW(), 
          .P(CNTR_OUT_INT),          
          .PATTERNBDETECT(), 
          .PATTERNDETECT(), 
          .PCOUT(),  
          .UNDERFLOW(), 
          .A(COUNT_BY[47:18]),          
          .ACIN(30'b0),    
          .ALUMODE({2'b00, ~DIRECTION, ~DIRECTION}), 
          .B(COUNT_BY[17:0]),          
          .BCIN(18'b0),    
          .C(LOAD_DATA_IN),          
          .CARRYCASCIN(1'b0), 
          .CARRYIN(1'b0), 
          .CARRYINSEL(3'b0), 
          .CEA1(1'b0),      
          .CEA2(CE),      
          .CEALUMODE(1'b1), 
          .CEB1(1'b0),      
          .CEB2(CE),      
          .CEC(CE),      
          .CECARRYIN(CE), 
          .CECTRL(CE), 
          .CEM(1'b0),       
          .CEMULTCARRYIN(1'b0),
          .CEP(CE),       
          .CLK(CLK),       
          .MULTSIGNIN(1'b0), 
          .OPMODE({2'b01, LOAD, 2'b00, ~LOAD, ~LOAD}), 
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
       begin
         DSP48E1 #(
          .ADREG(0),
          .DREG(0),
          .MREG(0),
          .USE_MULT("NONE") 
         ) 
         DSP48E_BL (
          .ACOUT(),   
          .BCOUT(),  
          .CARRYCASCOUT(), 
          .CARRYOUT(), 
          .MULTSIGNOUT(), 
          .OVERFLOW(), 
          .P(CNTR_OUT_INT),          
          .PATTERNBDETECT(), 
          .PATTERNDETECT(), 
          .PCOUT(),  
          .UNDERFLOW(), 
          .A(COUNT_BY[47:18]),          
          .ACIN(30'b0),    
          .ALUMODE({2'b00, ~DIRECTION, ~DIRECTION}), 
          .B(COUNT_BY[17:0]),          
          .BCIN(18'b0),    
          .C(LOAD_DATA_IN),          
          .CARRYCASCIN(1'b0), 
          .CARRYIN(1'b0), 
          .CARRYINSEL(3'b0), 
          .CEA1(1'b0),      
          .CEA2(CE),      
          .CEAD(1'b0),
          .CEALUMODE(1'b1), 
          .CEB1(1'b0),      
          .CEB2(CE),      
          .CEC(CE),      
          .CECARRYIN(1'b0), 
          .CECTRL(CE), 
          .CED(1'b0), 
          .CEINMODE(1'b0),
          .CEM(1'b0),       
          .CEP(CE),       
          .CLK(CLK),       
          .D(25'b0),
          .INMODE(5'b0),
          .MULTSIGNIN(1'b0), 
          .OPMODE({2'b01, LOAD, 2'b00, ~LOAD, ~LOAD}), 
          .PCIN(48'b0),      
          .RSTA(RST),     
          .RSTALLCARRYIN(RST), 
          .RSTALUMODE(RST), 
          .RSTB(RST),     
          .RSTC(RST),     
          .RSTD(RST),
          .RSTINMODE(RST),
          .RSTCTRL(RST), 
          .RSTM(RST), 
          .RSTP(RST) 
       );
     end // end generate virtex6
     // begin generate spartan6
      "SPARTAN6" :
       begin
         DSP48A1 DSP48AST (
         .BCOUT(), 
         .CARRYOUT(), 
         .CARRYOUTF(), 
         .M(),
         .P(CNTR_OUT_INT),
         .PCOUT(),
         .A(COUNT_BY[35:18]),
         .B(COUNT_BY[17:0]),
         .C(LOAD_DATA_IN), 
         .CARRYIN(1'b0), 
         .CEA(CE), 
         .CEB(CE), 
         .CEC(CE), 
         .CECARRYIN(1'b0), 
         .CED(CE), 
         .CEM(1'b0), 
         .CEOPMODE(CE), 
         .CEP(CE), 
         .CLK(CLK), 
         .D({6'b0,COUNT_BY[47:36]}), 
         .OPMODE({~DIRECTION, ~DIRECTION, 3'b001, LOAD, 2'b11}), 
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



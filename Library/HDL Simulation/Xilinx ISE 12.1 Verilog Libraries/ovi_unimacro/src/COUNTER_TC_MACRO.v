// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/unimacro/data/devlib/verilog/COUNTER_TC_MACRO.v,v 1.6 2009/08/27 18:32:47 vandanad Exp $
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
// /___/   /\     Filename : COUNTER_TC_MACRO.v
// \   \  /  \    Timestamp : Mon October 22 16:44:06 PST 2007
//  \___\/\___\
//
// Revision:
//    10/22/07 - Initial version.
// End Revision

`timescale  1 ps / 1 ps

module COUNTER_TC_MACRO (Q, TC, CLK, CE, RST);

// Visible parameters	
   parameter COUNT_BY = 48'h000000000001;
   parameter DEVICE = "VIRTEX5";
   parameter DIRECTION = "UP";
   parameter RESET_UPON_TC = "FALSE";
   parameter TC_VALUE = 48'h000000000000; 
   parameter STYLE = "DSP";
   parameter WIDTH_DATA = 48;
   

//Parameter checks 
    initial begin
      if (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6");
      else
        begin
	  $display("Attribute Syntax Error : The attribute DEVICE on COUNTER_TC_MACRO instance %m is set to %s.  Allowed values of this attribute are VIRTEX5, VIRTEX6", DEVICE);
          $finish;
	end
      if (DIRECTION == "UP" || DIRECTION == "DOWN");
      else
        begin
          $display("Attribute Syntax Error : The attribute DIRECTION on COUNTER_TC_MACRO instance %m is set to %s.  Legal values of this attribute are UP or DOWN", DIRECTION);
          $finish;
        end
      if(RESET_UPON_TC == "TRUE" || RESET_UPON_TC == "FALSE") ;
      else
      begin
        $display("Attribute Syntax Error : The attribute RESET_UPON_TC on COUNTER_TC_MACRO instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE", RESET_UPON_TC);
        $finish;
      end
      if (STYLE == "AUTO" || STYLE == "DSP");
      else
      begin
        $display("Attribute Syntax Error : The attribute STYLE on COUNTER_TC_MACRO instance %m is set to %s.  Legal values of this attribute are AUTO or DSP", STYLE);
        $finish;
      end
      if (WIDTH_DATA > 1 && WIDTH_DATA <= 48);
      else
      begin
        $display("Attribute Syntax Error : The attribute WIDTH_DATA on COUNTER_TC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 48", WIDTH_DATA);
        $finish;
      end
    end // initial begin

// Output ports
  output [WIDTH_DATA-1:0] Q;
  output TC;

// Input ports
  input CLK;
  input CE;
  input RST;

  wire        ADD_SUB;
  wire [47:0] CNTR_OUT_INT;
  wire [6:0]  OPMODE_INP;


  assign ADD_SUB = (DIRECTION == "UP") ? 0 : 1;
  assign OPMODE_INP = (RESET_UPON_TC == "TRUE") ? {1'b0, ~TC, 3'b000, ~TC, ~TC} : 7'b0100011;
  assign Q = (RST == 1'b1 || ( TC == 1'b1 && RESET_UPON_TC == "TRUE") ) ? {(WIDTH_DATA-1){1'b0}} : CNTR_OUT_INT[WIDTH_DATA-1:0];
  assign TC = (Q == TC_VALUE  && RST == 1'b0) ? 1'b1 : 1'b0;

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
          .ALUMODE({2'b00, ADD_SUB, ADD_SUB}), 
          .B(COUNT_BY[17:0]),          
          .BCIN(18'b0),    
          .C(48'b0),          
          .CARRYCASCIN(1'b0), 
          .CARRYIN(1'b0), 
          .CARRYINSEL(3'b0), 
          .CEA1(1'b0),      
          .CEA2(CE),      
          .CEALUMODE(CE), 
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
          .OPMODE(OPMODE_INP), 
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
          .ALUMODE({2'b00, ADD_SUB, ADD_SUB}), 
          .B(COUNT_BY[17:0]),          
          .BCIN(18'b0),    
          .C(48'b0),          
          .CARRYCASCIN(1'b0), 
          .CARRYIN(1'b0), 
          .CARRYINSEL(3'b0), 
          .CEA1(1'b0),      
          .CEA2(CE),      
          .CEAD(1'b0),
          .CEALUMODE(CE), 
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
          .OPMODE(OPMODE_INP), 
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
     default : ;
   endcase
 endgenerate

endmodule



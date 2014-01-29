// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/unimacro/data/devlib/verilog/EQ_COMPARE_MACRO.v,v 1.5 2009/08/27 18:32:47 vandanad Exp $
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
// /___/   /\     Filename : EQ_COMPARE_MACRO.v
// \   \  /  \    Timestamp : Mon October 22 16:44:06 PST 2007
//  \___\/\___\
//
// Revision:
//    10/22/07 - Initial version.
// End Revision

`timescale  1 ps / 1 ps

module EQ_COMPARE_MACRO (Q, CE, CLK, DATA_IN, DYNAMIC_PATTERN, RST);

// Visible parameters
   parameter DEVICE = "VIRTEX5";
   parameter LATENCY = 2;
   parameter MASK = 48'h000000000000;
   parameter SEL_MASK = "MASK";
   parameter SEL_PATTERN = "STATIC_PATTERN";
   parameter STATIC_PATTERN = 48'h000000000000;
   parameter WIDTH = 48;


//Parameter checks 
    initial begin

      if (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6");
      else
        begin
	  $display("Attribute Syntax Error : The attribute DEVICE on EQUAL_MACRO instance %m is set to %s.  Allowed values of this attribute are VIRTEX5, VIRTEX6", DEVICE);
          $finish;
	end
      if (SEL_PATTERN == "STATIC_PATTERN" || SEL_PATTERN == "DYNAMIC_PATTERN");
      else
        begin
	  $display("Attribute Syntax Error : The attribute SEL_PATTERN on EQUAL_MACRO instance %m is set to %s.  Allowed values of this attribute are STATIC_PATTERN or DYNAMIC_PATTERN", SEL_PATTERN);
          $finish;
	end
      if (SEL_MASK == "MASK" || SEL_MASK == "DYNAMIC_PATTERN");
      else
        begin
	  $display("Attribute Syntax Error : The attribute SEL_MASK on EQUAL_MACRO instance %m is set to %s.  Allowed values of this attribute are MASK or DYNAMIC_PATTERN", SEL_MASK);
          $finish;
	end
      if (LATENCY >= 0 && LATENCY <= 3);
      else
        begin
	  $display("Attribute Syntax Error : The attribute LATENCY on EQUAL instance %m is set to %d.  Allowed values of this attribute are 0 to 3", LATENCY);
          $finish;
	end
      if (WIDTH > 0 && WIDTH <= 48);
      else
        begin
	  $display("Attribute Syntax Error : The attribute WIDTH on EQUAL_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 48", WIDTH);
          $finish;
	end
    end // initial begin

// Output ports
  output Q;
  
// Input ports
  input CLK;
  input CE;
  input [WIDTH-1:0] DATA_IN;
  input [WIDTH-1:0] DYNAMIC_PATTERN;
  input RST;

  localparam AREG_IN = (LATENCY == 2) ? 1 : (LATENCY == 3) ? 2 : 0;
  localparam BREG_IN = (LATENCY == 2) ? 1 : (LATENCY == 3) ? 2 : 0;
  localparam CREG_IN = (LATENCY == 2 || LATENCY == 3) ? 1 : 0;
  localparam QREG    = (LATENCY == 1 || LATENCY == 2 || LATENCY == 3) ? 1 : 0; 
  localparam SEL_PATTERN_IN = (SEL_PATTERN == "DYNAMIC_PATTERN") ? "C" : (SEL_PATTERN == "STATIC_PATTERN") ? "PATTERN" : "PATTERN";
  localparam SEL_MASK_IN = (SEL_MASK == "DYNAMIC_PATTERN") ? "C" : (SEL_MASK == "STATIC_PATTERN") ? "MASK" : "MASK";
 
  wire CEA1_IN;
  wire CEB1_IN;
  wire CEA2_IN;
  wire CEB2_IN;
  wire [47:0] DATA_INP;
  wire [47:0] DYN_INP;

  assign CEA1_IN = (AREG_IN == 2) ? CE : 1'b0;
  assign CEA2_IN = (AREG_IN == 1 || AREG_IN == 2) ? CE : 1'b0;
  assign CEB1_IN = (BREG_IN == 2) ? CE : 1'b0;
  assign CEB2_IN = (BREG_IN == 1 || BREG_IN == 2) ? CE : 1'b0;

  generate if(WIDTH == 48) begin : d48
    assign DATA_INP = DATA_IN;
  end
  endgenerate
  generate if(WIDTH < 48) begin : d47
    assign DATA_INP = { {(48-(WIDTH)){1'b0}}, DATA_IN};
  end
  endgenerate
  generate if(WIDTH == 48) begin : dyn48
    assign DYN_INP = DYNAMIC_PATTERN;
  end
  endgenerate
  generate if(WIDTH < 48) begin : dyn47
    assign DYN_INP = { {(48-(WIDTH)){1'b0}}, DYNAMIC_PATTERN};
  end
  endgenerate


// Instantiation
  generate 
    case(DEVICE)
    // begin generate virtex5
    "VIRTEX5" :
       begin
       DSP48E #(
         .ACASCREG(AREG_IN),       
         .AREG(AREG_IN),           
         .BCASCREG(BREG_IN),       
         .BREG(BREG_IN),           
         .CREG(CREG_IN),           
         .MASK(MASK), 
         .PATTERN(STATIC_PATTERN), 
         .PREG(QREG),           
         .SEL_MASK(SEL_MASK_IN),  
         .SEL_PATTERN(SEL_PATTERN_IN), 
         .USE_MULT("NONE"), 
         .USE_PATTERN_DETECT("PATDET") 
          ) 
         DSP48E_V5 (
         .ACOUT(),   
         .BCOUT(),  
         .CARRYCASCOUT(), 
         .CARRYOUT(), 
         .MULTSIGNOUT(), 
         .OVERFLOW(), 
         .P(),          
         .PATTERNBDETECT(), 
         .PATTERNDETECT(Q), 
         .PCOUT(),  
         .UNDERFLOW(), 
         .A(DATA_INP[47:18]),          
         .ACIN(30'b0),    
         .ALUMODE(4'b0000), 
         .B(DATA_INP[17:0]),          
         .BCIN(18'b0),    
         .C(DYN_INP),          
         .CARRYCASCIN(1'b0), 
         .CARRYIN(1'b0), 
         .CARRYINSEL(3'b0), 
         .CEA1(CEA1_IN),      
         .CEA2(CEA2_IN),      
         .CEALUMODE(CE), 
         .CEB1(CEB1_IN),      
         .CEB2(CEB2_IN),      
         .CEC(CE),      
         .CECARRYIN(1'b0), 
         .CECTRL(CE), 
         .CEM(1'b0),       
         .CEMULTCARRYIN(1'b0),
         .CEP(CE),       
         .CLK(CLK),       
         .MULTSIGNIN(1'b0), 
         .OPMODE(7'b0000011), 
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
         .ACASCREG(AREG_IN),       
         .AREG(AREG_IN),           
         .ADREG(0),
         .BCASCREG(BREG_IN),       
         .BREG(BREG_IN),           
         .CREG(CREG_IN),  
         .DREG(0),
         .MASK(MASK), 
         .MREG(0),
         .PATTERN(STATIC_PATTERN), 
         .PREG(QREG),           
         .SEL_MASK(SEL_MASK_IN),  
         .SEL_PATTERN(SEL_PATTERN_IN), 
         .USE_MULT("NONE"), 
         .USE_PATTERN_DETECT("PATDET") 
          ) 
         DSP48E_BL (
         .ACOUT(),   
         .BCOUT(),  
         .CARRYCASCOUT(), 
         .CARRYOUT(), 
         .MULTSIGNOUT(), 
         .OVERFLOW(), 
         .P(),          
         .PATTERNBDETECT(), 
         .PATTERNDETECT(Q), 
         .PCOUT(),  
         .UNDERFLOW(), 
         .A(DATA_INP[47:18]),          
         .ACIN(30'b0),    
         .ALUMODE(4'b0000), 
         .B(DATA_INP[17:0]),          
         .BCIN(18'b0),    
         .C(DYN_INP),          
         .CARRYCASCIN(1'b0), 
         .CARRYIN(1'b0), 
         .CARRYINSEL(3'b0), 
         .CEA1(CEA1_IN),      
         .CEA2(CEA2_IN),      
         .CEAD(1'b0),
         .CEALUMODE(CE), 
         .CEB1(CEB1_IN),      
         .CEB2(CEB2_IN),      
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
         .OPMODE(7'b0000011), 
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








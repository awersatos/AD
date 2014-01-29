// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/unimacro/data/devlib/verilog/ADDMACC_MACRO.v,v 1.7 2009/12/02 23:07:42 vandanad Exp $
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
// /___/   /\     Filename : ADDMACC_MACRO.v
// \   \  /  \    Timestamp : Fri April 18 16:44:06 PST 2008
//  \___\/\___\
//
// Revision:
//    04/18/08 - Initial version.
// End Revision

`timescale  1 ps / 1 ps

module ADDMACC_MACRO (PRODUCT, CARRYIN, CLK, CE, LOAD, LOAD_DATA, MULTIPLIER, PREADD2, PREADD1, RST);
	
// Visible parameters
   parameter DEVICE = "VIRTEX6";
   parameter LATENCY = 4;
   parameter WIDTH_PREADD = 25;
   parameter WIDTH_MULTIPLIER = 18;
   parameter WIDTH_PRODUCT = 48;


//Parameter checks 
    initial begin
      if ( DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6");
      else
        begin
	  $display("Attribute Syntax Error : The attribute DEVICE on ADDMACC_MACRO instance %m is set to %s.  Allowed values of this attribute are VIRTEX6, SPARTAN6", DEVICE);
          $finish;
        end
      if(DEVICE == "VIRTEX6")
      begin 
        if (LATENCY >= 1 && LATENCY <= 4);
        else
          begin
	    $display("Attribute Syntax Error : The attribute LATENCY on ADDMACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 4", LATENCY);
            $finish;
	  end
        if (WIDTH_PREADD > 0 && WIDTH_PREADD <= 25);
        else
          begin
	    $display("Attribute Syntax Error : The attribute WIDTH_PREADD on ADDMACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 25", WIDTH_PREADD);
            $finish;
	  end
        if (WIDTH_MULTIPLIER > 0 && WIDTH_MULTIPLIER <= 18);
        else
          begin
	    $display("Attribute Syntax Error : The attribute WIDTH_MULTIPLIER on ADDMACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18", WIDTH_MULTIPLIER);
            $finish;
          end
        if (WIDTH_PRODUCT > 0 && WIDTH_PRODUCT <= 48);
        else
          begin
	    $display("Attribute Syntax Error : The attribute WIDTH_PRODUCT on ADDMACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 48", WIDTH_PRODUCT);
            $finish;
	  end 	
       end // end checks virtex6
       if(DEVICE == "SPARTAN6") 
       begin 
          if (LATENCY >= 1 && LATENCY <= 4);
          else
          begin
	    $display("Attribute Syntax Error : The attribute LATENCY on ADDMACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 4", LATENCY);
            $finish;
	  end
          if (WIDTH_PREADD > 0 && WIDTH_PREADD <= 18);
          else
          begin
	    $display("Attribute Syntax Error : The attribute WIDTH_PREADD on ADDMACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18", WIDTH_PREADD);
            $finish;
          end
          if (WIDTH_MULTIPLIER > 0 && WIDTH_MULTIPLIER <= 18);
          else
          begin
	    $display("Attribute Syntax Error : The attribute WIDTH_MULTIPLIER on ADDMACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18", WIDTH_MULTIPLIER);
            $finish;
	  end
          if (WIDTH_PRODUCT > 0 && WIDTH_PRODUCT <= 48);
          else
          begin
	    $display("Attribute Syntax Error : The attribute WIDTH_PRODUCT on ADDMACC_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 48", WIDTH_PRODUCT);
            $finish;
	  end 
      end // end checks spartan6
    end // initial begin

// Output ports
  output [WIDTH_PRODUCT-1:0] PRODUCT;

// Input ports
  input                        CARRYIN;
  input                        CE;
  input                        CLK;       
  input [WIDTH_MULTIPLIER-1:0] MULTIPLIER;
  input                        LOAD;
  input [WIDTH_PRODUCT-1:0]    LOAD_DATA;
  input [WIDTH_PREADD-1:0]     PREADD1;
  input [WIDTH_PREADD-1:0]     PREADD2;
  input                        RST;

  wire [24:0] PREADD1_IN;
  wire [24:0] PREADD2_IN;
  wire [17:0] MULTIPLIER_IN;
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

  generate if(WIDTH_PRODUCT == 48) begin : l48
    assign LOAD_DATA_IN = LOAD_DATA;
  end
  endgenerate
  generate if(WIDTH_PRODUCT < 48) begin : l47
    assign LOAD_DATA_IN = { {(48-(WIDTH_PRODUCT)){1'b0}}, LOAD_DATA };
  end
  endgenerate

// Sign extend inputs
  generate if(WIDTH_PREADD == 25) begin : pre25
    assign PREADD1_IN =  PREADD1; 
    assign PREADD2_IN =  PREADD2; 
  end
  endgenerate
  generate if(WIDTH_PREADD < 25) begin : pre24
    assign PREADD1_IN =  (PREADD1[WIDTH_PREADD-1] == 1'b1) ? {{(25-(WIDTH_PREADD)){1'b1}}, PREADD1} : {{(25-(WIDTH_PREADD)){1'b0}}, PREADD1}; 
    assign PREADD2_IN =  (PREADD2[WIDTH_PREADD-1] == 1'b1) ? {{(25-(WIDTH_PREADD)){1'b1}}, PREADD2} : {{(25-(WIDTH_PREADD)){1'b0}}, PREADD2}; 
  end
  endgenerate
  
  generate if(WIDTH_MULTIPLIER == 18) begin : mult18
    assign MULTIPLIER_IN =  MULTIPLIER; 
  end
  endgenerate
  generate if(WIDTH_MULTIPLIER < 18) begin : mult17
    assign MULTIPLIER_IN =  (MULTIPLIER[WIDTH_MULTIPLIER-1] == 1'b1) ? {{(18-(WIDTH_MULTIPLIER)){1'b1}}, MULTIPLIER} : {{(18-(WIDTH_MULTIPLIER)){1'b0}}, MULTIPLIER}; 
  end
  endgenerate

  assign PRODUCT = P_OUT[(WIDTH_PREADD+WIDTH_MULTIPLIER)-1:0];


// Instantiation
  generate 
    case(DEVICE)
    // begin generate virtex6
    "VIRTEX6" :
       begin
        DSP48E1 #(
          .ACASCREG(AREG_IN),       
          .AREG(AREG_IN),           
          .BCASCREG(BREG_IN),       
          .BREG(BREG_IN),           
          .MREG(MREG_IN),
          .PREG(PREG_IN),
          .USE_DPORT("TRUE")
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
          .A({5'b0, PREADD1_IN}),          
          .ACIN(30'b0),    
          .ALUMODE(4'b0000), 
          .B(MULTIPLIER_IN),          
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
          .D(PREADD2_IN),
          .INMODE(5'b00100),
          .MULTSIGNIN(1'b0), 
          .OPMODE({2'b01,LOAD,4'b0101}), 
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
      begin
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
         .A(MULTIPLIER_IN),
         .B(PREADD1_IN[17:0]),
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
         .D(PREADD2_IN[17:0]), 
         .OPMODE({5'b00011,LOAD, 2'b01}), 
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







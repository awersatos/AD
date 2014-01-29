/*  
               =========================================
               =                                       =
               =         act3 VERILOG  LIB              =
               =        ACTEL  CORPORATION             =
               =                                       =
               =========================================
*/ 
  
 //BUILT on 07/25/01 16:19:49 
  
/*  
               =========================================
               =             PART ONE                  =
               =         USER DEFINED PRIMITIVE CELLs  =
               =========================================
*/ 
  
/*  
               =========================================
               =             PART TWO                  =
               =           LIBRARY  CELLs              =
               =========================================
*/ 

`timescale 1 ns / 100 ps  
     
//--------------------------------------------------------------------
//-                    cell  A3IOMOD1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module A3IOMOD1(Y, PAD, D, E, IDE, SLEW);

    input D, E, IDE, SLEW;
    output Y;
    inout PAD;

    wire global_x = 1'bx;

    bufif1       BF1   (PAD, D, E);
    buf          BF2   (B, PAD);
    U_MUX_2    U0    (Y, global_x, B, IDE);

    specify

         specparam   LibName        = "act3";
         specparam   InputLoad$D    = 1;
         specparam   InputLoad$E    = 1;
         specparam   InputLoad$IDE  = 1;
         specparam   InputLoad$SLEW = 1;
         specparam   InputLoad$PAD  = 0;
         specparam   OutputLoad$PAD = 0;
         specparam   OutputLoad$Y   = 0;
         specparam   MacroType      = "io";


        (E => PAD) = (0.0,0.0,1.0:1.0:1.0,1.0:1.0:1.0,1.0:1.0:1.0,1.0:1.0:1.0);
        (D => PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (PAD => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  A3IOMOD2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module A3IOMOD2( Y, PAD, CLK, D, E, IDE, IEN, ODE, OTB, PCL, SLEW, SRS );
 
   input  CLK, D, E, IDE, IEN, ODE, OTB, PCL, SLEW, SRS;
   output Y;
   inout  PAD;
 
   reg    NOTIFY_REG;
 
   U_MUX_2  OMX2   (net1048, D, net1586, OTB);
   U_MUX_4  IMX4   (Y, net1460, net1446, net1444, net1444, IDE, IEN);
   bufif1     I1     (PAD, net1077, E);
 
   UFPX  IDFFE   (net1444, net1446, CLK, CLR_, PRE_, EN, NOTIFY_REG);
   UFPX  ODFFE   (net1586, D, CLK, CLR_, PRE_, ODEB, NOTIFY_REG);
 
   buf  DY   (net1446, PAD);
   buf  DD   (net1077, net1048);
   buf  DFB  (net1460, net1586);
   nor  I2   (CLR, PCL, net1467);
   nor  I3   (PRE, PCL, SRS);
   not  I4   (net1467, SRS);
   not  I5   (CLR_, CLR);
   not  I6   (PRE_, PRE);
 
   not   enable   (ODEB, ODE);
   nand  ODE2     (EN, IEN, IDE);
 
       and   AN1   (ENABLE1, CLR_, PRE_, ODEB);
       and   AN2   (EN1, CLR_, PRE_);
       and   AN3   (EN2, PRE_, ODEB);
       and   AN4   (EN3, CLR_, ODEB);
 
 
       and   AN5   (ENABLE2, CLR_, PRE_, EN);
       and   AN6   (EN4, PRE_, EN);
       and   AN7   (EN5, CLR_, EN);
 
 
specify
    specparam LibName        = "act3";
    specparam InputLoad$CLK  = 1;
    specparam InputLoad$D    = 1;
    specparam InputLoad$E    = 1;
    specparam InputLoad$IDE  = 1;
    specparam InputLoad$IEN  = 1;
    specparam InputLoad$ODE  = 1;
    specparam InputLoad$OTB  = 1;
    specparam InputLoad$PCL  = 1;
    specparam InputLoad$SLEW = 1;
    specparam InputLoad$SRS  = 1;
    specparam InputLoad$PAD  = 0;
    specparam OutputLoad$PAD = 0;
    specparam OutputLoad$Y   = 0;
 
    specparam EdgeType       = "pos";
    specparam MacroType      = "seq";
    specparam SeqType        = "flipflop";
    specparam FlipFlopType   = "io";
 
 
          (D => PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
          (PAD => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

          (negedge PCL => (PAD +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
          (E => PAD) = (0.0, 0.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0);

 
          if (ODEB && CLR && PRE )
              (posedge CLK =>  (PAD +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
 
          if (EN && CLR && PRE )
             (posedge CLK =>  (Y +: PAD))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
 
 
      $setup(D, posedge CLK &&& ENABLE1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& ENABLE1, 0.0, NOTIFY_REG);
 
      $setup(negedge ODE, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge ODE &&& EN1, 0.0, NOTIFY_REG);
 
 
 
      $setup(PAD, posedge CLK &&& ENABLE2, 0.0, NOTIFY_REG);
      $hold(posedge CLK, PAD &&& ENABLE2, 0.0, NOTIFY_REG);
 
      $setup(negedge IDE, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge IDE &&& EN1, 0.0, NOTIFY_REG);
 

      $hold(posedge CLK, PCL, 0.0, NOTIFY_REG);
      $width(negedge PCL, 0.0, 0, NOTIFY_REG);
 
 
      $width(posedge CLK &&& ENABLE1, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE1, 0.0, 0, NOTIFY_REG);
 
      $recovery(posedge PCL, posedge CLK &&& ODEB, 0.0, NOTIFY_REG);
 
 
      $width(posedge CLK &&& ENABLE2, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE2, 0.0, 0, NOTIFY_REG);
 
      $recovery(posedge PCL, posedge CLK &&& EN, 0.0, NOTIFY_REG);
 

endspecify
 
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  A3IOMOD3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module A3IOMOD3( Y, PAD, CLK, D, E, IDE, IEN, ODE, OTB, SLEW, SRS );
 
   input  CLK, D, E, IDE, IEN, ODE, OTB, SLEW, SRS;
   output Y;
   inout  PAD;
 
   reg    NOTIFY_REG;
 
   U_MUX_2  OMX2   (net1048, D, net1586, OTB);
   U_MUX_4  IMX4   (Y, net1460, net1446, net1444, net1444, IDE, IEN);
   bufif1     I1     (PAD, net1077, E);
 
   UFPCE  IDFFE   (net1444, net1446, CLK, EN, NOTIFY_REG);
   UFPCE  ODFFE   (net1586, D, CLK, ODEB, NOTIFY_REG);
 
   buf  DY   (net1446, PAD);
   buf  DD   (net1077, net1048);
   buf  DFB  (net1460, net1586);
   not  I4   (net1467, SRS);
 
   not   enable   (ODEB, ODE);
   nand  ODE2     (EN, IEN, IDE);

   buf SL (SSLEW, SLEW);
 
 
specify
    specparam LibName        = "act3";
    specparam InputLoad$CLK  = 1;
    specparam InputLoad$D    = 1;
    specparam InputLoad$E    = 1;
    specparam InputLoad$IDE  = 1;
    specparam InputLoad$IEN  = 1;
    specparam InputLoad$ODE  = 1;
    specparam InputLoad$OTB  = 1;
    specparam InputLoad$SLEW = 1;
    specparam InputLoad$SRS  = 1;
    specparam InputLoad$PAD  = 0;
    specparam OutputLoad$PAD = 0;
    specparam OutputLoad$Y   = 0;
 
    specparam EdgeType       = "pos";
    specparam MacroType      = "seq";
    specparam SeqType        = "flipflop";
    specparam FlipFlopType   = "io";
 
 
          (D => PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
          if (!IEN && IDE)
            (PAD => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
          (E => PAD) = (0.0, 0.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0);

 
          if (!ODE)
              (posedge CLK =>  (PAD +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
 
          if (EN)
             (posedge CLK =>  (Y +: PAD))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
 
 
      $setup(D, posedge CLK &&& ODEB, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& ODEB, 0.0, NOTIFY_REG);
 
      $setup(negedge ODE, posedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge ODE &&& EN, 0.0, NOTIFY_REG);
 
 
 
      $setup(PAD, posedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(posedge CLK, PAD &&& EN, 0.0, NOTIFY_REG);
 
      $setup(negedge IDE, posedge CLK , 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge IDE , 0.0, NOTIFY_REG);
 
 
      $width(posedge CLK &&& ODEB, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ODEB, 0.0, 0, NOTIFY_REG);
 
 
      $width(posedge CLK &&& EN, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& EN, 0.0, 0, NOTIFY_REG);
 

endspecify
 
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  BUF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module BUF(A, Y);
    
    input A;
    output Y;
    
    buf  BF1  (Y, A);
    
    specify

         specparam   LibName     = "act3";
         specparam   InputLoad$A = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";





        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFC1C (QN, CLK, CLR, D );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Tue Sep 23 16:02:59 1997
// from act2temp/dfc1c/logic


  output  QN;
  input  CLK;
  input  CLR;
  input  D;

  wire  UNNAMED_1_DFC1_U0_Q;

// begin page page1

// begin instances

  DFC1 Page1$U0  (.CLK(CLK),
	.CLR(CLR),
	.D(D),
	.Q(UNNAMED_1_DFC1_U0_Q));

  INV Page1$U1  (.A(UNNAMED_1_DFC1_U0_Q),
	.Y(QN));
// end page page1

endmodule // DFC1C(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1F.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFC1F (QN, CLK, CLR, D );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Tue Sep 23 16:12:37 1997
// from act2temp/dfc1f/logic


  output  QN;
  input  CLK;
  input  CLR;
  input  D;

  wire  X;

// begin page page1

// begin instances

  INV Page1$I5  (.A(X),
	.Y(QN));

  DFC1A Page1$U0  (.CLK(CLK),
	.CLR(CLR),
	.D(D),
	.Q(X));
// end page page1

endmodule // DFC1F(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE2D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFE2D (Q, CLK, CLR, D, E, PRE );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Fri Jan 16 14:55:23 1998
// from act2/dfe2d/logic


  output  Q;
  input  CLK;
  input  CLR;
  input  D;
  input  E;
  input  PRE;

  wire  Q_DRIVE;
  wire  X;

 assign Q = Q_DRIVE;

//  alias_bit tie_inst1 (Q, Q_DRIVE);

// begin page page1

// begin instances

  DFPCA Page1$I8  (.CLK(CLK),
	.CLR(CLR),
	.D(X),
	.PRE(PRE),
	.Q(Q_DRIVE));

  MX2 Page1$U0  (.A(D),
	.B(Q_DRIVE),
	.S(E),
	.Y(X));
// end page page1

endmodule // DFE2D(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFE4 (Q, CLK, D, E, PRE );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Fri Jan 16 15:03:03 1998
// from act2/dfe4/logic


  output  Q;
  input  CLK;
  input  D;
  input  E;
  input  PRE;

  wire  Q_DRIVE;
  wire  X;

  assign Q = Q_DRIVE;

//  alias_bit tie_inst1 (Q, Q_DRIVE);

// begin page page1

// begin instances

  MX2 Page1$U0  (.A(Q_DRIVE),
	.B(D),
	.S(E),
	.Y(X));

  DFP1 Page1$U1  (.CLK(CLK),
	.D(X),
	.PRE(PRE),
	.Q(Q_DRIVE));
// end page page1

endmodule // DFE4(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE4A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFE4A (Q, CLK, D, E, PRE );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Fri Jan 16 15:07:09 1998
// from act2/dfe4a/logic


  output  Q;
  input  CLK;
  input  D;
  input  E;
  input  PRE;

  wire  Q_DRIVE;
  wire  X;

  assign Q = Q_DRIVE;

//  alias_bit tie_inst1 (Q, Q_DRIVE);

// begin page page1

// begin instances

  DFP1A Page1$I7  (.CLK(CLK),
	.D(X),
	.PRE(PRE),
	.Q(Q_DRIVE));

  MX2 Page1$U0  (.A(Q_DRIVE),
	.B(D),
	.S(E),
	.Y(X));
// end page page1

endmodule // DFE4A(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE4B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFE4B (Q, CLK, D, E, PRE );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Fri Jan 16 15:18:39 1998
// from act2/dfe4b/logic


  output  Q;
  input  CLK;
  input  D;
  input  E;
  input  PRE;

  wire  Q_DRIVE;
  wire  X;

 assign Q = Q_DRIVE;

//  alias_bit tie_inst1 (Q, Q_DRIVE);

// begin page page1

// begin instances

  MX2 Page1$I7  (.A(D),
	.B(Q_DRIVE),
	.S(E),
	.Y(X));

  DFP1 Page1$U1  (.CLK(CLK),
	.D(X),
	.PRE(PRE),
	.Q(Q_DRIVE));
// end page page1

endmodule // DFE4B(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE4C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE4C( CLK, PRE, D, E, Q);

input CLK, D, E, PRE;
output Q;
wire net1, net2;

DFP1A I1( .CLK(CLK), .D(net1), .PRE(PRE), .Q(net2) );
MX2   I2( .A(D), .B(net2), .S(E), .Y(net1) );


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  DFEB.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFEB (Q, CLK, CLR, D, E, PRE );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Fri Jan 16 16:17:31 1998
// from act2/dfeb/logic


  output  Q;
  input  CLK;
  input  CLR;
  input  D;
  input  E;
  input  PRE;

  wire  Q_DRIVE;
  wire  X;

  assign Q = Q_DRIVE;

//  alias_bit tie_inst1 (Q, Q_DRIVE);

// begin page page1

// begin instances

  MX2 Page1$U0  (.A(Q_DRIVE),
	.B(D),
	.S(E),
	.Y(X));

  DFPC Page1$U1  (.CLK(CLK),
	.CLR(CLR),
	.D(X),
	.PRE(PRE),
	.Q(Q_DRIVE));
// end page page1

endmodule // DFEB(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFEC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFEC (Q, CLK, CLR, D, E, PRE );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Tue Jan 20 17:15:03 1998
// from act2/dfec/logic


  output  Q;
  input  CLK;
  input  CLR;
  input  D;
  input  E;
  input  PRE;

  wire  Q_DRIVE;
  wire  X;

  assign Q = Q_DRIVE;

//  alias_bit tie_inst1 (Q, Q_DRIVE);

// begin page page1

// begin instances

  DFPCA Page1$I8  (.CLK(CLK),
	.CLR(CLR),
	.D(X),
	.PRE(PRE),
	.Q(Q_DRIVE));

  MX2 Page1$U0  (.A(Q_DRIVE),
	.B(D),
	.S(E),
	.Y(X));
// end page page1

endmodule // DFEC(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFED.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFED (Q, CLK, CLR, D, E, PRE );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Tue Jan 20 17:25:14 1998
// from act2/dfed/logic


  output  Q;
  input  CLK;
  input  CLR;
  input  D;
  input  E;
  input  PRE;

  wire  Q_DRIVE;
  wire  X;

  assign Q = Q_DRIVE;

//  alias_bit tie_inst1 (Q, Q_DRIVE);

// begin page page1

// begin instances

  MX2 Page1$I8  (.A(D),
	.B(Q_DRIVE),
	.S(E),
	.Y(X));

  DFPC Page1$U1  (.CLK(CLK),
	.CLR(CLR),
	.D(X),
	.PRE(PRE),
	.Q(Q_DRIVE));
// end page page1

endmodule // DFED(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM3F.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFM3F (QN, A, B, CLK, CLR, S );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Tue Jan 20 17:29:12 1998
// from act2/dfm3f/logic


  output  QN;
  input  A;
  input  B;
  input  CLK;
  input  CLR;
  input  S;

  wire  X;

// begin page page1

// begin instances

  DFM3 Page1$U0  (.A(A),
	.B(B),
	.CLK(CLK),
	.CLR(CLR),
	.Q(X),
	.S(S));

  INV Page1$U1  (.A(X),
	.Y(QN));
// end page page1

endmodule // DFM3F(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM3G.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFM3G (QN, A, B, CLK, CLR, S );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Tue Jan 20 17:32:01 1998
// from act2/dfm3g/logic


  output  QN;
  input  A;
  input  B;
  input  CLK;
  input  CLR;
  input  S;

  wire  X;

// begin page page1

// begin instances

  DFM3E Page1$I8  (.A(A),
	.B(B),
	.CLK(CLK),
	.CLR(CLR),
	.Q(X),
	.S(S));

  INV Page1$U1  (.A(X),
	.Y(QN));
// end page page1

endmodule // DFM3G(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFM4 (Q, A, B, CLK, PRE, S );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Tue Jan 20 17:43:28 1998
// from act2/dfm4/logic


  output  Q;
  input  A;
  input  B;
  input  CLK;
  input  PRE;
  input  S;

  wire  X;

// begin page page1

// begin instances

  MX2 Page1$U0  (.A(A),
	.B(B),
	.S(S),
	.Y(X));

  DFP1 Page1$U1  (.CLK(CLK),
	.D(X),
	.PRE(PRE),
	.Q(Q));
// end page page1

endmodule // DFM4(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM4A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFM4A (Q, A, B, CLK, PRE, S );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Tue Jan 20 17:45:46 1998
// from act2/dfm4a/logic


  output  Q;
  input  A;
  input  B;
  input  CLK;
  input  PRE;
  input  S;

  wire  X;

// begin page page1

// begin instances

  DFP1B Page1$I8  (.CLK(CLK),
	.D(X),
	.PRE(PRE),
	.Q(Q));

  MX2 Page1$U0  (.A(A),
	.B(B),
	.S(S),
	.Y(X));
// end page page1

endmodule // DFM4A(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM4B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFM4B (Q, A, B, CLK, PRE, S );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Tue Jan 20 17:48:23 1998
// from act2/dfm4b/logic


  output  Q;
  input  A;
  input  B;
  input  CLK;
  input  PRE;
  input  S;

  wire  X;

// begin page page1

// begin instances

  DFP1D Page1$I8  (.CLK(CLK),
	.D(X),
	.PRE(PRE),
	.Q(Q));

  MX2 Page1$U0  (.A(A),
	.B(B),
	.S(S),
	.Y(X));
// end page page1

endmodule // DFM4B(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM4E.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFM4E (Q, A, B, CLK, PRE, S );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Tue Jan 20 17:50:16 1998
// from act2/dfm4e/logic


  output  Q;
  input  A;
  input  B;
  input  CLK;
  input  PRE;
  input  S;

  wire  X;

// begin page page1

// begin instances

  DFP1A Page1$I8  (.CLK(CLK),
	.D(X),
	.PRE(PRE),
	.Q(Q));

  MX2 Page1$U0  (.A(A),
	.B(B),
	.S(S),
	.Y(X));
// end page page1

endmodule // DFM4E(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM5A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFM5A (Q, A, B, CLK, CLR, PRE, S );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Wed Jan 21 10:24:04 1998
// from act2/dfm5a/logic


  output  Q;
  input  A;
  input  B;
  input  CLK;
  input  CLR;
  input  PRE;
  input  S;

  wire  X;

// begin page page1

// begin instances

  DFPC Page1$I9  (.CLK(CLK),
	.CLR(CLR),
	.D(X),
	.PRE(PRE),
	.Q(Q));

  MX2 Page1$U0  (.A(A),
	.B(B),
	.S(S),
	.Y(X));
// end page page1

endmodule // DFM5A(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM5B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFM5B (Q, A, B, CLK, CLR, PRE, S );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Wed Jan 21 10:32:29 1998
// from act2/dfm5b/logic


  output  Q;
  input  A;
  input  B;
  input  CLK;
  input  CLR;
  input  PRE;
  input  S;

  wire  X;

// begin page page1

// begin instances

  DFPCA Page1$I9  (.CLK(CLK),
	.CLR(CLR),
	.D(X),
	.PRE(PRE),
	.Q(Q));

  MX2 Page1$U0  (.A(A),
	.B(B),
	.S(S),
	.Y(X));
// end page page1

endmodule // DFM5B(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLE2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DLE2A (Q, CLR, D, E, G );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Wed Jan 21 10:40:36 1998
// from act2/dle2a/logic


  output  Q;
  input  CLR;
  input  D;
  input  E;
  input  G;

  wire  X;

// begin page page1

// begin instances

  DLE2C Page1$I7  (.CLR(CLR),
	.D(D),
	.E(X),
	.G(G),
	.Q(Q));

  INV Page1$U0  (.A(E),
	.Y(X));
// end page page1

endmodule // DLE2A(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLE3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DLE3A (Q, D, E, G, PRE );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Wed Jan 21 10:49:30 1998
// from act2/dle3a/logic


  output  Q;
  input  D;
  input  E;
  input  G;
  input  PRE;

  wire  Q_DRIVE;
  wire  UNNAMED_1_GND_2P_Y;
  wire  UNNAMED_1_VCC_1P_Y;
  wire  X;

 assign Q = Q_DRIVE;

//  alias_bit tie_inst1 (Q, Q_DRIVE);

// begin page page1

// begin instances

  VCC \Page1$1P   (.Y(UNNAMED_1_VCC_1P_Y));

  GND \Page1$2P   (.Y(UNNAMED_1_GND_2P_Y));

  CM8 Page1$U0  (.D0(UNNAMED_1_GND_2P_Y),
	.D1(UNNAMED_1_GND_2P_Y),
	.D2(Q_DRIVE),
	.D3(D),
	.S00(UNNAMED_1_VCC_1P_Y),
	.S01(E),
	.S10(UNNAMED_1_VCC_1P_Y),
	.S11(UNNAMED_1_GND_2P_Y),
	.Y(X));

  CM8 Page1$U1  (.D0(X),
	.D1(UNNAMED_1_VCC_1P_Y),
	.D2(Q_DRIVE),
	.D3(UNNAMED_1_VCC_1P_Y),
	.S00(PRE),
	.S01(UNNAMED_1_VCC_1P_Y),
	.S10(UNNAMED_1_GND_2P_Y),
	.S11(G),
	.Y(Q_DRIVE));
// end page page1

endmodule // DLE3A(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DLM2A (Q, A, B, CLR, G, S );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Wed Jan 21 11:12:23 1998
// from act2/dlm2a/logic


  output  Q;
  input  A;
  input  B;
  input  CLR;
  input  G;
  input  S;

  wire  X;

// begin page page1

// begin instances

  MX2 Page1$U0  (.A(A),
	.B(B),
	.S(S),
	.Y(X));

  DLC1A Page1$U1  (.CLR(CLR),
	.D(X),
	.G(G),
	.Q(Q));
// end page page1

endmodule // DLM2A(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module JKF3A (Q, CLK, J, K, PRE );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Wed Jan 21 11:43:10 1998
// from act2/jkf3a/logic


  output  Q;
  input  CLK;
  input  J;
  input  K;
  input  PRE;

  wire  Q_DRIVE;
  wire  X;

  assign Q = Q_DRIVE;

//  alias_bit tie_inst1 (Q, Q_DRIVE);

// begin page page1

// begin instances

  DFP1B Page1$I6  (.CLK(CLK),
	.D(X),
	.PRE(PRE),
	.Q(Q_DRIVE));

  MX2 Page1$U0  (.A(J),
	.B(K),
	.S(Q_DRIVE),
	.Y(X));
// end page page1

endmodule // JKF3A(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF3B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module JKF3B (Q, CLK, J, K, PRE );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Wed Jan 21 11:46:19 1998
// from act2/jkf3b/logic


  output  Q;
  input  CLK;
  input  J;
  input  K;
  input  PRE;

  wire  Q_DRIVE;
  wire  X;

  assign Q = Q_DRIVE;

//  alias_bit tie_inst1 (Q, Q_DRIVE);

// begin page page1

// begin instances

  DFP1D Page1$I6  (.CLK(CLK),
	.D(X),
	.PRE(PRE),
	.Q(Q_DRIVE));

  MX2 Page1$U0  (.A(J),
	.B(K),
	.S(Q_DRIVE),
	.Y(X));
// end page page1

endmodule // JKF3B(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF3C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module JKF3C (Q, CLK, J, K, PRE );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Wed Jan 21 11:48:09 1998
// from act2/jkf3c/logic


  output  Q;
  input  CLK;
  input  J;
  input  K;
  input  PRE;

  wire  Q_DRIVE;
  wire  X;

  assign Q = Q_DRIVE;

//  alias_bit tie_inst1 (Q, Q_DRIVE);

// begin page page1

// begin instances

  DFP1 Page1$I6  (.CLK(CLK),
	.D(X),
	.PRE(PRE),
	.Q(Q_DRIVE));

  MX2 Page1$U0  (.A(J),
	.B(K),
	.S(Q_DRIVE),
	.Y(X));
// end page page1

endmodule // JKF3C(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF3D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module JKF3D (Q, CLK, J, K, PRE );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Wed Jan 21 11:49:47 1998
// from act2/jkf3d/logic


  output  Q;
  input  CLK;
  input  J;
  input  K;
  input  PRE;

  wire  Q_DRIVE;
  wire  X;

  assign Q = Q_DRIVE;

//  alias_bit tie_inst1 (Q, Q_DRIVE);

// begin page page1

// begin instances

  DFP1A Page1$I6  (.CLK(CLK),
	.D(X),
	.PRE(PRE),
	.Q(Q_DRIVE));

  MX2 Page1$U0  (.A(J),
	.B(K),
	.S(Q_DRIVE),
	.Y(X));
// end page page1

endmodule // JKF3D(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF4B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module JKF4B (Q, CLK, CLR, J, K, PRE );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Wed Jan 21 14:21:47 1998
// from act2/jkf4b/logic


  output  Q;
  input  CLK;
  input  CLR;
  input  J;
  input  K;
  input  PRE;

  wire  Q_DRIVE;
  wire  X;

  assign Q = Q_DRIVE;

//  alias_bit tie_inst1 (Q, Q_DRIVE);

// begin page page1

// begin instances

  MX2 Page1$U0  (.A(J),
	.B(K),
	.S(Q_DRIVE),
	.Y(X));

  DFPCA Page1$U1  (.CLK(CLK),
	.CLR(CLR),
	.D(X),
	.PRE(PRE),
	.Q(Q_DRIVE));
// end page page1

endmodule // JKF4B(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKFPC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module JKFPC (Q, CLK, CLR, J, K, PRE );
// generated by Concept HDL Direct Version 3.01-p2 23-Jan-97
// on Wed Jan 21 14:24:17 1998
// from act2/jkfpc/logic


  output  Q;
  input  CLK;
  input  CLR;
  input  J;
  input  K;
  input  PRE;

  wire  Q_DRIVE;
  wire  X;

  assign Q = Q_DRIVE;

//  alias_bit tie_inst1 (Q, Q_DRIVE);

// begin page page1

// begin instances

  DFPC Page1$I8  (.CLK(CLK),
	.CLR(CLR),
	.D(X),
	.PRE(PRE),
	.Q(Q_DRIVE));

  MX2 Page1$U0  (.A(J),
	.B(K),
	.S(Q_DRIVE),
	.Y(X));
// end page page1

endmodule // JKFPC(LOGIC) 
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  TA153.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module TA153 ( C0, C1, C2, C3, A, B, EN, Y);
    
    input C0, C1, C2, C3, A, B, EN;
    output Y;
    
        U_MUX_4 inst1 (Y_EFF, C0, C1, C2, C3, A, B);
        not     inst2 (NEN, EN); 
        and     inst3 (Y, NEN, Y_EFF);

    specify

         specparam   LibName     = "act3";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C0 = 1; 
         specparam   InputLoad$C1 = 1; 
         specparam   InputLoad$C2 = 1; 
         specparam   InputLoad$C3 = 1; 
         specparam   InputLoad$EN = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C0$Y   = 1;
         specparam   ExtraDelayPaths$C1$Y   = 1;
         specparam   ExtraDelayPaths$C2$Y   = 1;
         specparam   ExtraDelayPaths$C3$Y   = 1;
         specparam   ExtraDelayPaths$EN$Y   = 0;



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C0 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C1 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C2 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C3 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (EN => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  TA157.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module TA157 ( A, B, S, EN, Y);
    
    input A, B, S, EN;
    output Y;
    
	U_MUX_2	inst1 (Y_EFF, A, B, S);
        not     inst2 (NEN, EN);
	and	inst3 (Y, NEN, Y_EFF);
          
    specify

         specparam   LibName     = "act3";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$EN = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (EN => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  XNOR.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XNOR(A, B, Y);
    
    input A, B;
    output Y;
    
    xnor XNR1   (Y, A, B);
    
    specify

         specparam   LibName     = "act3";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  XOR.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XOR(A, B, Y);
    
    input A, B;
    output Y;
    
    xor XR1   (Y, A, B);
    
    specify

         specparam   LibName     = "act3";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      

//  ------------------------------  END of act3_mig.v ----------------------------

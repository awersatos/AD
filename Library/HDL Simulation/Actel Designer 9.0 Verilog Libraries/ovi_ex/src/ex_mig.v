/*  
               =========================================
               =                                       =
               =         ex VERILOG  LIB              =
               =        ACTEL  CORPORATION             =
               =                                       =
               =========================================
*/ 
  
 //BUILT on 07/25/01 18:06:38 
  
  
     
//--------------------------------------------------------------------
//-                    cell  BBDLHS.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module BBDLHS(D,E,GIN,GOUT,PAD,Q);
input D, E, GIN, GOUT;
inout  PAD;
output  Q;

    wire NET0, NET1;
    
    BIBUF U2(.D(NET1), .E(E), .PAD(PAD), .Y(NET0));
    DL1B U1(.D(NET0), .G(GIN), .Q(Q));
    DL1 U0(.D(D), .G(GOUT), .Q(NET1));
    

    specify

        specparam Libname = "54sx";
       
    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  BBHS.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module BBHS(D,E,PAD,Y);
input D, E;
inout  PAD;
output  Y;

    wire NET0;
    
    BIBUF U2(.D(D), .E(E), .PAD(PAD), .Y(NET0));
    BUFF U1(.A(NET0), .Y(Y));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DF1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DF1A(D,CLK,QN);
input CLK, D;
output  QN;

    wire NET0;
    
    DF1 U1(.D(NET0), .CLK(CLK), .Q(QN));
    INV U0(.A(D), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DF1A_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DF1A_CC(D,CLK,QN);
input CLK, D;
output  QN;

    wire NET0;
    
    DF1 U1(.D(NET0), .CLK(CLK), .Q(QN));
    INV U0(.A(D), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DF1B_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DF1B_CC(D, CLK, Q);
    
    input    D, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFN  
                inst1 (Q, D, CLK, NOTIFY_REG);
    
    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
          (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  


      $setup(posedge D, negedge CLK, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D, 0.0, NOTIFY_REG);
      $setup(negedge D, negedge CLK, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D, 0.0, NOTIFY_REG);

      $width(posedge CLK, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DF1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DF1C(D,CLK,QN);
input CLK, D;
output  QN;

    wire NET0;
    
    DF1B U1(.D(NET0), .CLK(CLK), .Q(QN));
    INV U0(.A(D), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DF1C_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DF1C_CC(D,CLK,QN);
input CLK, D;
output  QN;

    wire NET0;
    
    DF1B U1(.D(NET0), .CLK(CLK), .Q(QN));
    INV U0(.A(D), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFC1(D,CLK,CLR,Q);
input CLK, CLR, D;
output  Q;

    wire NET0;
    
    DFC1B U1(.D(D), .CLR(NET0), .CLK(CLK), .Q(Q));
    INV U0(.A(CLR), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFC1A(D,CLK,CLR,Q);
input CLK, CLR, D;
output  Q;

    wire NET1;
    
    DFC1D U2(.D(D), .CLR(NET1), .CLK(CLK), .Q(Q));
    INV U1(.A(CLR), .Y(NET1));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1A_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFC1A_CC(D,CLK,CLR,Q);
input CLK, CLR, D;
output  Q;

    wire NET1;
    
    DFC1D U2(.D(D), .CLR(NET1), .CLK(CLK), .Q(Q));
    INV U1(.A(CLR), .Y(NET1));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1D_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFC1D_CC(D, CLK, CLR, Q);
    
    input    D, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNRB 
                inst1 (Q, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

     


          
         if (CLR)
          (negedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge CLR =>  (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(negedge D, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D &&& CLR,  0.0, NOTIFY_REG);
      $setup(posedge D, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D &&& CLR,  0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(posedge CLR, negedge CLK, 0.0, NOTIFY_REG);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1E.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFC1E(D,CLK,CLR,QN);
input CLK, CLR, D;
output  QN;

    wire NET0;
    
    DFC1B U1(.D(D), .CLR(CLR), .CLK(CLK), .Q(NET0));
    INV U0(.A(NET0), .Y(QN));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1G.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFC1G(D,CLK,CLR,QN);
input CLK, CLR, D;
output  QN;

    wire NET0;
    
    DFC1D U1(.D(D), .CLR(CLR), .CLK(CLK), .Q(NET0));
    INV U0(.A(NET0), .Y(QN));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFC1_CC(D,CLK,CLR,Q);
input CLK, CLR, D;
output  Q;

    wire NET0;
    
    DFC1B U1(.D(D), .CLR(NET0), .CLK(CLK), .Q(Q));
    INV U0(.A(CLR), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFE(D,E,CLK,Q);
input CLK, D, E;
output  Q;

    wire NET1;
    
    DF1 U2(.D(NET1), .CLK(CLK), .Q(Q));
    MX2 U1(.A(Q), .B(D), .S(E), .Y(NET1));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE1B_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE1B_CC(D, E, CLK, Q);
    
    input    D, E, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPCEB  
                inst1 (Q, D, CLK, E, NOTIFY_REG);
    
    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (!E)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, posedge CLK &&& (~E), 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D &&& (~E), 0.0, NOTIFY_REG);
      $setup(negedge D, posedge CLK &&& (~E), 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D &&& (~E), 0.0, NOTIFY_REG);

      $setup(posedge E, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge E, 0.0, NOTIFY_REG);
      $setup(negedge E, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge E, 0.0, NOTIFY_REG);
 
      $width(negedge CLK &&& (~E), 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& (~E), 0.0, 0, NOTIFY_REG);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE1C_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE1C_CC(D, E, CLK, Q);
    
    input    D, E, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNCEB  
                inst1 (Q, D, CLK, E, NOTIFY_REG);
    
    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (!E)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, negedge CLK &&& (~E), 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D &&& (~E), 0.0, NOTIFY_REG);
      $setup(negedge D, negedge CLK &&& (~E), 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D &&& (~E), 0.0, NOTIFY_REG);

      $setup(posedge E, negedge CLK, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge E, 0.0, NOTIFY_REG);
      $setup(negedge E, negedge CLK, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge E, 0.0, NOTIFY_REG);
 
      $width(negedge CLK &&& (~E), 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& (~E), 0.0, 0, NOTIFY_REG);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFE3A(D,E,CLK,CLR,Q);
input CLK, CLR, D, E;
output  Q;

    wire NET1;
    
    DFC1B U2(.D(NET1), .CLR(CLR), .CLK(CLK), .Q(Q));
    MX2 U1(.A(Q), .B(D), .S(E), .Y(NET1));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE3B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFE3B(D,E,CLK,CLR,Q);
input CLK, CLR, D, E;
output  Q;

    wire NET1;
    
    DFC1D U2(.D(NET1), .CLR(CLR), .CLK(CLK), .Q(Q));
    MX2 U1(.A(Q), .B(D), .S(E), .Y(NET1));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFEA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFEA(D,E,CLK,Q);
input CLK, D, E;
output  Q;

    wire NET1;
    
    DF1B U2(.D(NET1), .CLK(CLK), .Q(Q));
    MX2 U1(.A(Q), .B(D), .S(E), .Y(NET1));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFEA_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFEA_CC(D,E,CLK,Q);
input CLK, D, E;
output  Q;

    wire NET1;
    
    DF1B U2(.D(NET1), .CLK(CLK), .Q(Q));
    MX2 U1(.A(Q), .B(D), .S(E), .Y(NET1));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFE_CC(D,E,CLK,Q);
input CLK, D, E;
output  Q;

    wire NET1;
    
    DF1 U2(.D(NET1), .CLK(CLK), .Q(Q));
    MX2 U1(.A(Q), .B(D), .S(E), .Y(NET1));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFM(A,B,S,CLK,Q);
input A, B, CLK;
output  Q;
input  S;

    wire NET0;
    
    DF1 U1(.D(NET0), .CLK(CLK), .Q(Q));
    MX2 U0(.A(A), .B(B), .S(S), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module DFM1B(A,B,CLK,S,QN);
input A, B, CLK, S;
output  QN;
 
    wire NET0;
    
    DF1 U1(.D(NET0), .CLK(CLK), .Q(QN));
    MX2C U0(.A(A), .B(B), .S(S), .Y(NET0));


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM1B_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module DFM1B_CC(A,B,CLK,S,QN);
input A, B, CLK, S;
output  QN;
 
    wire NET0;
    
    DF1 U1(.D(NET0), .CLK(CLK), .Q(QN));
    MX2C U0(.A(A), .B(B), .S(S), .Y(NET0));


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module DFM1C(A,B,CLK,S,QN);
input A, B, CLK, S;
output  QN;
 
    wire NET0;
    
    DF1B U1(.D(NET0), .CLK(CLK), .Q(QN));
    MX2C U0(.A(A), .B(B), .S(S), .Y(NET0));


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM1C_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module DFM1C_CC(A,B,CLK,S,QN);
input A, B, CLK, S;
output  QN;
 
    wire NET0;
    
    DF1B U1(.D(NET0), .CLK(CLK), .Q(QN));
    MX2C U0(.A(A), .B(B), .S(S), .Y(NET0));


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFM3(A,B,S,CLK,CLR,Q);
input A, B, CLK, CLR;
output  Q;
input  S;

    wire NET0, NET1;
    
    DFC1B U2(.D(NET0), .CLR(NET1), .CLK(CLK), .Q(Q));
    INV U1(.A(CLR), .Y(NET1));
    MX2 U0(.A(A), .B(B), .S(S), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM3B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFM3B(A,B,S,CLK,CLR,Q);
input A, B, CLK, CLR;
output  Q;
input  S;

    wire NET0;
    
    DFC1D U1(.D(NET0), .CLR(CLR), .CLK(CLK), .Q(Q));
    MX2 U0(.A(A), .B(B), .S(S), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM3E.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFM3E(A,B,S,CLK,CLR,Q);
input A, B, CLK, CLR;
output  Q;
input  S;

    wire NET0, NET3;
    
    INV U2(.A(CLR), .Y(NET3));
    DFC1D U1(.D(NET0), .CLR(NET3), .CLK(CLK), .Q(Q));
    MX2 U0(.A(A), .B(B), .S(S), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM4C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFM4C(A,B,S,CLK,PRE,QN);
input A, B, CLK, PRE;
output  QN;
input  S;

    wire NET0, NET1;
    
    INV U2(.A(NET1), .Y(QN));
    DFP1B U1(.D(NET0), .PRE(PRE), .CLK(CLK), .Q(NET1));
    MX2 U0(.A(A), .B(B), .S(S), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM4D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFM4D(A,B,S,CLK,PRE,QN);
input A, B, CLK, PRE;
output  QN;
input  S;

    wire NET0, NET1;
    
    INV U2(.A(NET1), .Y(QN));
    DFP1D U1(.D(NET0), .PRE(PRE), .CLK(CLK), .Q(NET1));
    MX2 U0(.A(A), .B(B), .S(S), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM6A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module DFM6A(D0, D1, D2, D3, S0, S1, CLK, CLR, Q);
input CLK, CLR, D0, D1, D2, D3;
output  Q;
input  S0, S1;

    wire NET0;
    
    DFC1B U1(.D(NET0), .CLR(CLR), .CLK(CLK), .Q(Q));
    MX4 U0(.D0(D0), .D1(D1), .D2(D2), .D3(D3), .S0(S0), .S1(S1), 
        .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM6B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module DFM6B(D0, D1, D2, D3, S0, S1, CLK, CLR, Q);
input CLK, CLR, D0, D1, D2, D3;
output  Q;
input  S0, S1;

    wire NET0;
    
    DFC1D U1(.D(NET0), .CLR(CLR), .CLK(CLK), .Q(Q));
    MX4 U0(.D0(D0), .D1(D1), .D2(D2), .D3(D3), .S0(S0), .S1(S1), 
        .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM7A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps
module DFM7A(CLK,CLR,D0,D1,D2,D3,S0,S10,S11,Q);
input CLK, CLR, D0, D1, D2, D3, S0, S10, S11;
output  Q;
 
    wire NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    DFC1B U1(.D(NET0), .CLK(CLK), .CLR(CLR), .Q(Q));
    CM8 U0(.D0(D0), .D1(D1), .D2(D2), .D3(D3), .S00(S0), .S01(VDD)
        , .S10(S10), .S11(S11), .Y(NET0));


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM7B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module DFM7B ( D0, D1, D2, D3, S0, S10, S11, CLK, CLR, Q);
input CLK, CLR, D0, D1, D2, D3;
output  Q;
input  S0, S10, S11;

    wire NET0;
    
    DFC1D U1(.D(NET0), .CLR(CLR), .CLK(CLK), .Q(Q));
    CM8 U0(.D0(D0), .D1(D1), .D2(D2), .D3(D3), .S00(S0), .S01(S0), 
        .S10(S10), .S11(S11), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM8A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module DFM8A(D0, D1, D2, D3, S00, S01, S10, S11, CLK, CLR, Q);
input CLK, CLR, D0, D1, D2, D3;
output  Q;
input  S00, S01, S10, S11;

    wire NET0;
    
    DFC1B U1(.D(NET0), .CLR(CLR), .CLK(CLK), .Q(Q));
    CM8 U0(.D0(D0), .D1(D1), .D2(D2), .D3(D3), .S00(S00), .S01(
        S01), .S10(S10), .S11(S11), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM8B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module DFM8B (D0, D1, D2, D3, S00, S01, S10, S11, CLK, CLR, Q);
input CLK, CLR, D0, D1, D2, D3;
output  Q;
input  S00, S01, S10, S11;

    wire NET0;
    
    DFC1D U1(.D(NET0), .CLR(CLR), .CLK(CLK), .Q(Q));
    CM8 U0(.D0(D0), .D1(D1), .D2(D2), .D3(D3), .S00(S00), .S01(
        S01), .S10(S10), .S11(S11), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFMA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFMA(A,B,S,CLK,Q);
input A, B, CLK;
output  Q;
input  S;

    wire NET0;
    
    DF1B U1(.D(NET0), .CLK(CLK), .Q(Q));
    MX2 U0(.A(A), .B(B), .S(S), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFMA_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFMA_CC(A,B,S,CLK,Q);
input A, B, CLK;
output  Q;
input  S;

    wire NET0;
    
    DF1B U1(.D(NET0), .CLK(CLK), .Q(Q));
    MX2 U0(.A(A), .B(B), .S(S), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFMB.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFMB(A,B,S,CLK,CLR,Q);
input A, B, CLK, CLR;
output  Q;
input  S;

    wire NET0;
    
    DFC1B U1(.D(NET0), .CLR(CLR), .CLK(CLK), .Q(Q));
    MX2 U0(.A(A), .B(B), .S(S), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFME1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFME1A(A,B,S,E,CLK,Q);
input A, B, CLK, E;
output  Q;
input  S;

    wire NET0;
    
    DFE1B U1(.CLK(CLK), .D(NET0), .E(E), .Q(Q));
    MX2 U0(.A(A), .B(B), .S(S), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFM_CC(A,B,S,CLK,Q);
input A, B, CLK;
output  Q;
input  S;

    wire NET0;
    
    DF1 U1(.D(NET0), .CLK(CLK), .Q(Q));
    MX2 U0(.A(A), .B(B), .S(S), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1A_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1A_CC(D, CLK, PRE, Q);
    
    input    D, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNS 
                inst1 (Q, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

     


          
         if (!PRE)
          (negedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge PRE =>  (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, negedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D &&& (~PRE), 0.0,  NOTIFY_REG);
      $setup(negedge D, negedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D &&& (~PRE), 0.0,  NOTIFY_REG);
 

      $hold(negedge CLK, negedge PRE, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(negedge PRE, negedge CLK, 0.0, NOTIFY_REG);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFP1C(D,CLK,PRE,QN);
input CLK, D, PRE;
output  QN;

    wire NET0, NET1;
    
    INV U2(.A(NET1), .Y(QN));
    INV U1(.A(PRE), .Y(NET0));
    DFP1B U0(.D(D), .PRE(NET0), .CLK(CLK), .Q(NET1));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1D_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1D_CC(D, CLK, PRE, Q);
    
    input    D, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNSB 
                inst1 (Q, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
         if (PRE)
          (negedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge PRE =>  (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, negedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D &&& PRE, 0.0, NOTIFY_REG);
      $setup(negedge D, negedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D &&& PRE, 0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge PRE, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(posedge PRE, negedge CLK, 0.0, NOTIFY_REG);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1E.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFP1E(D,CLK,PRE,QN);
input CLK, D, PRE;
output  QN;

    wire NET0;
    
    INV U1(.A(NET0), .Y(QN));
    DFP1B U0(.D(D), .PRE(PRE), .CLK(CLK), .Q(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1F.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFP1F(D,CLK,PRE,QN);
input CLK, D, PRE;
output  QN;

    wire NET0, NET1;
    
    INV U2(.A(NET1), .Y(QN));
    INV U1(.A(PRE), .Y(NET0));
    DFP1D U0(.D(D), .PRE(NET0), .CLK(CLK), .Q(NET1));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1G.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DFP1G(D,CLK,PRE,QN);
input CLK, D, PRE;
output  QN;

    wire NET0;
    
    INV U1(.A(NET0), .Y(QN));
    DFP1D U0(.D(D), .PRE(PRE), .CLK(CLK), .Q(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1_CC(D, CLK, PRE, Q);
    
    input    D, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPS 
                inst1 (Q, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

     


          
         if (!PRE)
          (posedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge PRE =>  (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, posedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D &&& (~PRE), 0.0, NOTIFY_REG);
      $setup(negedge D, posedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D &&& (~PRE), 0.0, NOTIFY_REG);


      $hold(posedge CLK, negedge PRE, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFPCA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFPCA(D, CLK, PRE, CLR, Q);
    
    input    D, CLR, PRE, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNRBSX 
                inst1 (Q, D, CLK, CLR, PRE_, NOTIFY_REG);
       not  NT1  (PRE_, PRE);
       
       
       and  AN1  (ENABLE, PRE_, CLR);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
         if (CLR && !PRE)
          (negedge CLK => (Q +: D))     = (1.0:1.0:1.0, 1.0:1.0:1.0);  
         
         if (!PRE)
          (negedge CLR => (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
         
         if (CLR)
          (posedge PRE => (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

      
      $setup(posedge D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D &&& ENABLE,  0.0, NOTIFY_REG);
      $setup(negedge D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D &&& ENABLE,  0.0, NOTIFY_REG);


      $hold(negedge CLK &&& CLR, negedge PRE, 0.0, NOTIFY_REG);

      $hold(negedge CLK &&& PRE_, posedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge CLR, negedge CLK &&& PRE_, 0.0, NOTIFY_REG);
      $recovery(negedge PRE, negedge CLK &&& CLR, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFPCA_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFPCA_CC(D, CLK, PRE, CLR, Q);
    
    input    D, CLR, PRE, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNRBSX 
                inst1 (Q, D, CLK, CLR, PRE_, NOTIFY_REG);
       not  NT1  (PRE_, PRE);
       
       
       and  AN1  (ENABLE, PRE_, CLR);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
         if (CLR && !PRE)
          (negedge CLK => (Q +: D))     = (1.0:1.0:1.0, 1.0:1.0:1.0);  
         
         if (!PRE)
          (negedge CLR => (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
         
         if (CLR)
          (posedge PRE => (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

      
      $setup(posedge D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D &&& ENABLE,  0.0, NOTIFY_REG);
      $setup(negedge D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D &&& ENABLE,  0.0, NOTIFY_REG);


      $hold(negedge CLK &&& CLR, negedge PRE, 0.0, NOTIFY_REG);

      $hold(negedge CLK &&& PRE_, posedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge CLR, negedge CLK &&& PRE_, 0.0, NOTIFY_REG);
      $recovery(negedge PRE, negedge CLK &&& CLR, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFPC_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFPC_CC(D, CLK, PRE, CLR, Q);
    
    input    D, CLR, PRE, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UDP_DFPC 
                inst1 (Q, D, CLK, CLR, PRE_, NOTIFY_REG);
       not  NT1  (PRE_, PRE);
       
       
       and (ENABLE, PRE_, CLR);
    
    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

     


          
         if (CLR && !PRE)
          (posedge CLK => (Q +: D))     = (1.0:1.0:1.0, 1.0:1.0:1.0);  
         
         if (!PRE)
          (negedge CLR => (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
         
         if (CLR)
          (posedge PRE => (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

      
      $setup(posedge D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D &&& ENABLE,  0.0, NOTIFY_REG);
      $setup(negedge D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D &&& ENABLE,  0.0, NOTIFY_REG);
      


      $hold(posedge CLK &&& CLR, negedge PRE, 0.0, NOTIFY_REG);

      $hold(posedge CLK &&& PRE_, posedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge CLR, posedge CLK &&& PRE_, 0.0, NOTIFY_REG);
      $recovery(negedge PRE, posedge CLK &&& CLR, 0.0, NOTIFY_REG);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DL1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DL1A(D,G,QN);
input D, G;
output  QN;

    wire GND, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    CM8 U0(.D0(QN), .D1(QN), .D2(VDD), .D3(GND), .S00(D), .S01(
        VDD), .S10(G), .S11(GND), .Y(QN));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DL1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DL1C(D,G,QN);
input D, G;
output  QN;

    wire GND, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    CM8 U0(.D0(VDD), .D1(GND), .D2(QN), .D3(QN), .S00(VDD), .S01(
        D), .S10(G), .S11(GND), .Y(QN));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DL2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DL2B (D, G, PRE, CLR, QN);

   input   D, G, PRE, CLR;

   output   QN;


   reg NOTIFY_REG;

   not                NT1   (PRE_, PRE);
   UDP_DL2B           inst1 (QN, D, G, CLR, PRE_, NOTIFY_REG);
     
   nor                A1   (ENABLE, CLR, PRE_);


   specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && !CLR && PRE)
        (D -=> QN) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    if (!CLR && PRE)
    (negedge G => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (PRE)
    (posedge CLR => (QN +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!CLR)
    (negedge PRE => (QN +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && PRE)
    (negedge CLR => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && !CLR)
    (posedge PRE => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);



    $setup(posedge D, posedge G &&& ENABLE, 0.0, NOTIFY_REG);
    $hold(posedge G, posedge D &&& ENABLE, 0.0, NOTIFY_REG);
    $setup(negedge D, posedge G &&& ENABLE, 0.0, NOTIFY_REG);
    $hold(posedge G, negedge D &&& ENABLE, 0.0, NOTIFY_REG);


    $hold(posedge G &&& (~CLR), posedge PRE, 0.0, NOTIFY_REG);

    $hold(posedge G &&& PRE, negedge CLR, 0.0, NOTIFY_REG);
 
 
    $width(negedge G &&& ENABLE, 0.0, 0, NOTIFY_REG); 

    $width(negedge PRE &&& (~CLR), 0.0, 0, NOTIFY_REG); 
    $width(posedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge CLR, posedge G &&& PRE, 0.0, NOTIFY_REG);
    $recovery(posedge PRE, posedge G &&& (~CLR), 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DL2D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DL2D (D, G, PRE, CLR, QN);

   input  D, G, PRE, CLR;

   output QN;


   reg NOTIFY_REG;

   not                NT1   (PRE_, PRE);
   not                NT2   (CLR_, CLR);
   UDP_DL2D           inst1 (QN, D, G, CLR, PRE_, NOTIFY_REG);
     
   and                A1    (ENABLE, CLR_, PRE);


   specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (G && !CLR && PRE)
        (D -=> QN) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    if (!CLR && PRE)
    (posedge G => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (PRE)
    (posedge CLR => (QN +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!CLR)
    (negedge PRE => (QN +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G && PRE)
    (negedge CLR => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G && !CLR)
    (posedge PRE => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);



    $setup(posedge D, negedge G &&& ENABLE, 0.0, NOTIFY_REG);
    $hold(negedge G, posedge D &&& ENABLE, 0.0, NOTIFY_REG);
    $setup(negedge D, negedge G &&& ENABLE, 0.0, NOTIFY_REG);
    $hold(negedge G, negedge D &&& ENABLE, 0.0, NOTIFY_REG);
 

    $hold(negedge G &&& CLR_, posedge PRE, 0.0, NOTIFY_REG);

    $hold(negedge G &&& PRE, negedge CLR, 0.0, NOTIFY_REG);


    $width(posedge G &&& ENABLE, 0.0, 0, NOTIFY_REG); 

    $width(negedge PRE &&& CLR_, 0.0, 0, NOTIFY_REG); 
    $width(posedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge CLR, negedge G &&& PRE, 0.0, NOTIFY_REG);
    $recovery(posedge PRE, negedge G &&& CLR_, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLC1F.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLC1F(D,G,CLR,QN);
input CLR, D, G;
output  QN;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    INV U1(.A(D), .Y(NET0));
    CM8 U0(.D0(QN), .D1(NET0), .D2(VDD), .D3(VDD), .S00(VDD), 
        .S01(G), .S10(CLR), .S11(GND), .Y(QN));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLC1G.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLC1G(D,G,CLR,QN);
input CLR, D, G;
output  QN;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    INV U1(.A(D), .Y(NET0));
    CM8 U0(.D0(NET0), .D1(QN), .D2(VDD), .D3(VDD), .S00(VDD), 
        .S01(G), .S10(CLR), .S11(GND), .Y(QN));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLE.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLE(D,E,G,Q);
input D, E, G;
output  Q;

    wire GND, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    CM8 U0(.D0(Q), .D1(Q), .D2(Q), .D3(D), .S00(G), .S01(VDD), 
        .S10(E), .S11(GND), .Y(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLE1D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLE1D(D,E,G,QN);
input D, E, G;
output  QN;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    INV U1(.A(D), .Y(NET0));
    CM8 U0(.D0(NET0), .D1(QN), .D2(QN), .D3(QN), .S00(VDD), .S01(
        G), .S10(E), .S11(GND), .Y(QN));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLE2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLE2B(D,E,G,CLR,Q);
input CLR, D, E, G;
output  Q;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    CM8 U1(.D0(GND), .D1(GND), .D2(NET0), .D3(Q), .S00(VDD), .S01(
        E), .S10(CLR), .S11(GND), .Y(Q));
    CM8 U0(.D0(D), .D1(GND), .D2(Q), .D3(Q), .S00(GND), .S01(GND), 
        .S10(G), .S11(GND), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLEA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLEA(D,E,G,Q);
input D, E, G;
output  Q;

    wire GND, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    CM8 U0(.D0(Q), .D1(D), .D2(Q), .D3(Q), .S00(G), .S01(VDD), 
        .S10(E), .S11(GND), .Y(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLEB.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLEB(D,E,G,Q);
input D, E, G;
output  Q;

    wire GND, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    CM8 U0(.D0(Q), .D1(Q), .D2(D), .D3(Q), .S00(G), .S01(VDD), 
        .S10(E), .S11(GND), .Y(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLEC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLEC(D,E,G,Q);
input D, E, G;
output  Q;

    wire GND, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    CM8 U0(.D0(D), .D1(Q), .D2(Q), .D3(Q), .S00(G), .S01(VDD), 
        .S10(E), .S11(GND), .Y(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLM(A,B,S,G,Q);
input A, B, G;
output  Q;
input  S;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    MX2 U1(.A(A), .B(B), .S(S), .Y(NET0));
    CM8 U0(.D0(Q), .D1(NET0), .D2(GND), .D3(GND), .S00(VDD), .S01(
        G), .S10(GND), .S11(GND), .Y(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLM2(A, B, S, CLR, G, Q);
input A, B, CLR, G;
output  Q;
input  S;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    MX2 U1(.A(A), .B(B), .S(S), .Y(NET0));
    CM8 U0(.D0(GND), .D1(GND), .D2(Q), .D3(NET0), .S00(VDD), .S01(
        G), .S10(CLR), .S11(GND), .Y(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLM2B(A, B, S, CLR, G, Q);
input A, B, CLR, G;
output  Q;
input  S;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    MX2 U1(.A(A), .B(B), .S(S), .Y(NET0));
    CM8 U0(.D0(GND), .D1(GND), .D2(NET0), .D3(Q), .S00(G), .S01(
        VDD), .S10(CLR), .S11(GND), .Y(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module DLM3(D0, D1, D2, D3, S0, S1, G, Q);
input D0, D1, D2, D3, G;
output  Q;
input  S0, S1;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    MX4 U1(.D0(D0), .D1(D1), .D2(D2), .D3(D3), .S0(S0), .S1(S1), 
        .Y(NET0));
    CM8 U0(.D0(Q), .D1(NET0), .D2(GND), .D3(GND), .S00(VDD), .S01(
        G), .S10(GND), .S11(GND), .Y(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module DLM3A(D0, D1, D2, D3, S0, S1, G, Q);
input D0, D1, D2, D3, G;
output  Q;
input  S0, S1;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    MX4 U1(.D0(D0), .D1(D1), .D2(D2), .D3(D3), .S0(S0), .S1(S1), 
        .Y(NET0));
    CM8 U0(.D0(NET0), .D1(Q), .D2(GND), .D3(GND), .S00(VDD), .S01(
        G), .S10(GND), .S11(GND), .Y(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLM4( D0, D1, D2, D3, S0, S10, S11, G, Q);
input D0, D1, D2, D3, G;
output  Q;
input  S0, S10, S11;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    CM8 U1(.D0(D0), .D1(D1), .D2(D2), .D3(D3), .S00(S0), .S01(S0), 
        .S10(S10), .S11(S11), .Y(NET0));
    CM8 U0(.D0(Q), .D1(NET0), .D2(GND), .D3(GND), .S00(VDD), .S01(
        G), .S10(GND), .S11(GND), .Y(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM4A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLM4A( D0, D1, D2, D3, S0, S10, S11, G, Q);
input D0, D1, D2, D3, G;
output  Q;
input  S0, S10, S11;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    CM8 U1(.D0(D0), .D1(D1), .D2(D2), .D3(D3), .S00(S0), .S01(S0), 
        .S10(S10), .S11(S11), .Y(NET0));
    CM8 U0(.D0(NET0), .D1(Q), .D2(GND), .D3(GND), .S00(VDD), .S01(
        G), .S10(GND), .S11(GND), .Y(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM8A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module DLM8A(D0, D1, D2, D3, S00, S01, S10, S11, G, CLR, Q);
input CLR, D0, D1, D2, D3, G;
output  Q;
input  S00, S01, S10, S11;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    CM8 U1(.D0(GND), .D1(GND), .D2(Q), .D3(NET0), .S00(VDD), .S01(
        G), .S10(CLR), .S11(GND), .Y(Q));
    CM8 U0(.D0(D0), .D1(D1), .D2(D2), .D3(D3), .S00(S00), .S01(
        S01), .S10(S10), .S11(S11), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM8B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module DLM8B(D0, D1, D2, D3, S00, S01, S10, S11, G, CLR, Q);
input CLR, D0, D1, D2, D3, G;
output  Q;
input  S00, S01, S10, S11;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    CM8 U1(.D0(D0), .D1(D1), .D2(D2), .D3(D3), .S00(S00), .S01(
        S01), .S10(S10), .S11(S11), .Y(NET0));
    CM8 U0(.D0(GND), .D1(GND), .D2(NET0), .D3(Q), .S00(G), .S01(
        VDD), .S10(CLR), .S11(GND), .Y(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLMA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLMA(A,B,S,G,Q);
input A, B, G;
output  Q;
input  S;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    MX2 U1(.A(A), .B(B), .S(S), .Y(NET0));
    CM8 U0(.D0(NET0), .D1(Q), .D2(GND), .D3(GND), .S00(VDD), .S01(
        G), .S10(GND), .S11(GND), .Y(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLME1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module DLME1A(A,B,E,G,S,Q);
input A, B, E, G, S;
output  Q;
 
    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    CM8 U1(.D0(NET0), .D1(GND), .D2(Q), .D3(GND), .S00(GND), .S01(
        GND), .S10(G), .S11(GND), .Y(Q));
    CM8 U0(.D0(A), .D1(B), .D2(Q), .D3(Q), .S00(S), .S01(VDD), 
        .S10(E), .S11(GND), .Y(NET0));


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLP1D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLP1D(D,G,PRE,QN);
input D, G, PRE;
output  QN;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    INV U1(.A(D), .Y(NET0));
    CM8 U0(.D0(GND), .D1(GND), .D2(QN), .D3(NET0), .S00(VDD), 
        .S01(G), .S10(PRE), .S11(GND), .Y(QN));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLP1E.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DLP1E(D,G,PRE,QN);
input D, G, PRE;
output  QN;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    INV U1(.A(D), .Y(NET0));
    CM8 U0(.D0(GND), .D1(GND), .D2(NET0), .D3(QN), .S00(VDD), 
        .S01(G), .S10(PRE), .S11(GND), .Y(QN));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DXAND7.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DXAND7(A,B,C,D,E,F,G,Y);
input A, B, C, D, E, F, G;
output  Y;

    wire NET0;
    
    AND4 U1(.A(NET0), .B(E), .C(F), .D(G), .Y(Y));
    AND4 U0(.A(A), .B(B), .C(C), .D(D), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DXAX7.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DXAX7(A,B,C,D,E,F,G,H,Y);
input A, B, C, D, E, F, G, H;
output  Y;

    wire NET0, NET1;
    
    XOR2 U2(.A(NET1), .B(H), .Y(Y));
    AND4 U1(.A(NET0), .B(E), .C(F), .D(G), .Y(NET1));
    AND4 U0(.A(A), .B(B), .C(C), .D(D), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DXNAND7.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module DXNAND7(A,B,C,D,E,F,G,Y);
input A, B, C, D, E, F, G;
output  Y;

    wire NET0;
    
    NAND4 U1(.A(NET0), .B(E), .C(F), .D(G), .Y(Y));
    AND4 U0(.A(A), .B(B), .C(C), .D(D), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  IBDL.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module IBDL(PAD,G,Q);
input G, PAD;
output  Q;

    wire NET0;
    
    DL1B U1(.D(NET0), .G(G), .Q(Q));
    INBUF U0(.PAD(PAD), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  IR.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module IR(PAD,CLK,Q);
input CLK, PAD;
output  Q;

    wire NET0;
    
    DF1 U1(.D(NET0), .CLK(CLK), .Q(Q));
    INBUF U0(.PAD(PAD), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  IRI.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module IRI(CLK,PAD,QN);
input CLK, PAD;
output  QN;

    wire NET0, NET1;
    
    INV U2(.A(NET1), .Y(QN));
    DF1 U1(.D(NET0), .CLK(CLK), .Q(NET1));
    INBUF U0(.PAD(PAD), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF2C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module JKF2C (J, K, CLK, CLR, Q);
input CLK, CLR, J, K;
output  Q;

    wire NET0, NET1;
    
    INV U2(.A(CLR), .Y(NET1));
    MX2 U1(.A(J), .B(K), .S(Q), .Y(NET0));
    DFC1B U0(.D(NET0), .CLR(NET1), .CLK(CLK), .Q(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF2D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module JKF2D (J, K, CLK, CLR, Q);
input CLK, CLR, J, K;
output  Q;

    wire NET0, NET1;
    
    INV U2(.A(CLR), .Y(NET1));
    MX2 U1(.A(J), .B(K), .S(Q), .Y(NET0));
    DFC1D U0(.D(NET0), .CLR(NET1), .CLK(CLK), .Q(Q));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  MXC1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module MXC1(A,B,C,D,S,Y);
input A, B, C, D, S;
output  Y;

    wire X;
    
    MX2 U1(.A(C), .B(D), .S(X), .Y(Y));
    MX2 U0(.A(A), .B(B), .S(S), .Y(X));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  MXT.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module MXT(D0,D1,D2,D3,S0A,S0B,S1,Y);
input D0, D1, D2, D3, S0A, S0B, S1;
output  Y;

    wire X;
    
    MX4 U1(.D0(X), .D1(X), .D2(D2), .D3(D3), .S0(S0B), .S1(S1), 
        .Y(Y));
    MX2 U0(.A(D0), .B(D1), .S(S0A), .Y(X));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OBDLHS.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module OBDLHS(D,G,PAD);
input D, G;
output  PAD;

    wire NET0;
    
    OUTBUF U1(.D(NET0), .PAD(PAD));
    MX2 U0(.A(NET0), .B(D), .S(G), .Y(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OBHS.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps

module OBHS(D,PAD);
input D;
output  PAD;

    
    OUTBUF U0(.D(D), .PAD(PAD));
    

    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  ORH.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module ORH(D,CLK,PAD);
input CLK, D;
output  PAD;

    wire NET0;
    
    OUTBUF U1(.D(NET0), .PAD(PAD));
    DF1 U0(.D(D), .CLK(CLK), .Q(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  ORIH.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module ORIH(D,CLK,PAD);
input CLK, D;
output  PAD;

    wire NET0, NET1;
    
    OUTBUF U2(.D(NET1), .PAD(PAD));
    INV U1(.A(NET0), .Y(NET1));
    DF1 U0(.D(D), .CLK(CLK), .Q(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  ORITH.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module ORITH(D,CLK,E,PAD);
input CLK, D, E;
output  PAD;

    wire NET0, NET1;
    
    TRIBUFF U2(.D(NET1), .E(E), .PAD(PAD));
    INV U1(.A(NET0), .Y(NET1));
    DF1 U0(.D(D), .CLK(CLK), .Q(NET0));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  ORTH.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module ORTH(D,CLK,E,PAD);
input CLK, D, E;
output  PAD;

    wire NET1;
    
    TRIBUFF U2(.D(NET1), .E(E), .PAD(PAD));
    DF1 U0(.D(D), .CLK(CLK), .Q(NET1));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  TBDLHS.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module TBDLHS(D,E,G,PAD);
input D, E, G;
output  PAD;

    wire NET1;
    
    TRIBUFF U2(.D(NET1), .E(E), .PAD(PAD));
    DL1 U1(.D(D), .G(G), .Q(NET1));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  TBHS.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns/100 ps


module TBHS(D,E,PAD);
input D, E;
output  PAD;

    
    TRIBUFF U0(.D(D), .E(E), .PAD(PAD));
    


    specify

        specparam Libname = "54sx";
       

    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  UDP_DFPC.v                                  -
//--------------------------------------------------------------------
      
primitive UDP_DFPC (Q, D, CP, RB, SB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, RB, SB;
    reg    Q; 

// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET AND CLEAR. ILLEGAL OUPUT WHEN BOTH
//            SET AND CLEAR ARE LOW ( Q OUTPUT UDP ).


    table
 
    //  D   CP      RB  SB     NOTIFIER_REG  :   Qt  :  Qt+1

        1   (01)    1   1         ?          :   ?   :   1;  // clocked data
        1   (01)    1   x         ?          :   ?   :   1;  // pessimism

        1    ?      1   x         ?          :   1   :   1;  // pessimism

        0    0      1   x         ?          :   1   :   1;  // pessimism
        0    x      1 (?x)        ?          :   1   :   1;  // pessimism
        0    1      1 (?x)        ?          :   1   :   1;  // pessimism

        x    0      1   x         ?          :   1   :   1;  // pessimism
        x    x      1 (?x)        ?          :   1   :   1;  // pessimism
        x    1      1 (?x)        ?          :   1   :   1;  // pessimism

        0   (01)    1   1         ?          :   ?   :   0;  // clocked data
        0   (01)    x   1         ?          :   ?   :   0;  // pessimism

        0    ?      x   1         ?          :   0   :   0;  // pessimism

        1    0      x   1         ?          :   0   :   0;  // pessimism
        1    x    (?x)  1         ?          :   0   :   0;  // pessimism
        1    1    (?x)  1         ?          :   0   :   0;  // pessimism

        x    0      x   1         ?          :   0   :   0;  // pessimism
        x    x    (?x)  1         ?          :   0   :   0;  // pessimism
        x    1    (?x)  1         ?          :   0   :   0;  // pessimism
                                                           
        1   (x1)    1   1         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    1   1         ?          :   0   :   0;                          
        1   (0x)    1   1         ?          :   1   :   1;  
        0   (0x)    1   1         ?          :   0   :   0;  

        ?   ?       0   1         ?          :   ?   :   0;  // asynchronous clear
        ?   ?       1   0         ?          :   ?   :   1;  // asynchronous set
        ?   ?       0   0         ?          :   ?   :   0;  // asynchronous set

        ?   (?0)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?         ?          :   ?   :   -;  // ignore data edges 

        ?   ?     (?1)  ?         ?          :   ?   :   -;  // ignore the edges on 
        ?   ?       ?  (?1)       ?          :   ?   :   -;  //       set and clear                  
       
        ?   ?       ?   ?         *          :   ?   :   x;


    endtable

endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UDP_DL2B.v                                  -
//--------------------------------------------------------------------
      
primitive UDP_DL2B (QN, D, GN, R, S, NOTI_REG); 

 
 

    output QN; 
    reg    QN;                               
    input  D,               // DATA
           GN,               // CLOCK
           R,              // CLEAR ACTIVE HIGH
           S,              // SET ACTIVE HIGH
           NOTI_REG;        // NOTIFY_REG
// FUNCTION : NEGATIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE HIGH
//            ASYNCHRONOUS SET AND RESET.  ( QN OUTPUT UDP ).


   table
     //  D       GN     RB    SB   NOTI_REG       : QNtn :   QNtn+0
                                  
         *       1      0     0     ?             :  ?  :    -   ;
                                  
         ?       ?      1     0     ?             :  ?  :    1   ; // asynchro clear
     
         ?       ?      0     1     ?             :  ?  :    0   ; 

         ?       ?      1     1     ?             :  ?  :    1   ;   
                                                                     
         ?      (?1)    ?     ?     ?             :  ?  :    -   ;  //AB
         ?      (0x)    ?     ?     ?             :  ?  :    -   ;  //AB
                                  
         0      (1x)    0     0     ?             :  1  :    1   ;
         1      (1x)    0     0     ?             :  0  :    0   ;
         0      (x0)    0     0     ?             :  ?  :    1   ;
         1      (x0)    0     0     ?             :  ?  :    0   ;
                                  
        (?0)     0      0     0     ?             :  ?  :    1   ;
        (?1)     0      0     0     ?             :  ?  :    0   ; 
         0      (10)    0     0     ?             :  ?  :    1   ;
         1      (10)    0     0     ?             :  ?  :    0   ; 
                                  
       
         ?       1     (?x)   0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         ?       1      x    (?0)   ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       1      x     0     ?             :  1  :    1   ;   // Reducing pessimism//AB

        (?0)     x      x     0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0       x      *     0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0      (1x)    x     0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0       x      x    (?0)   ?             :  1  :    1   ;   // Reducing pessimism.//AB

         0      (?0)    x     0     ?             :  ?  :    1   ; // Reducing pessimism.
        (?0)     0      x     0     ?             :  ?  :    1   ; // Reducing pessimism.
         0       0     (?x)   0     ?             :  ?  :    1   ; // Reducing pessimism.//AB
         0       0      x    (?0)   ?             :  ?  :    1   ; // Reducing pessimism.//AB
     
        
         ?       1      0    (?x)   ?             :  0  :    0   ;   // Reducing pessimism.//AB
         ?       1     (?0)   x     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         *       1      0     x     ?             :  0  :    0   ;   // Reducing pessimism//AB
 
        (?1)     x      0     x     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1       x      0     *    ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1      (1x)    0     x     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1       x     (?0)   x     ?             :  0  :    0   ;   // Reducing pessimism.//AB

      
         1      (?0)    0     x     ?             :  ?  :    0   ; // Reducing pessimism.
        (?1)     0      0     x     ?             :  ?  :    0   ; // Reducing pessimism.
         1       0     (?0)   x     ?             :  ?  :    0   ; // Reducing pessimism.//AB
         1       0      0    (?x)   ?             :  ?  :    0   ; // Reducing pessimism.//AB
                                  
         ?       1     (?0)   0     ?             :  ?  :    -   ;   // ignore edge on clear
         0       0     (?0)   0     ?             :  ?  :    1   ;   // pessimism .
         1       0     (?0)   0     ?             :  ?  :    0   ;  

                                  
         ?       1      0    (?0)   ?             :  ?  :    -   ;   // ignore edge on set
         0       0      0    (?0)   ?             :  ?  :    1   ;   // pessimism .
         1       0      0    (?0)   ?             :  ?  :    0   ;  

        (?1)     x      0     0     ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      0     0     ?             :  1  :    1   ; // Reducing pessimism.
                                  
         ?       ?      ?     ?     *             :  ?  :    x   ;

   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UDP_DL2D.v                                  -
//--------------------------------------------------------------------
      
primitive UDP_DL2D (QN, D, G, R, S, NOTI_REG); 

 
 

    output QN; 
    reg    QN;                               
    input  D,               // DATA
           G,               // CLOCK
           R,              // CLEAR ACTIVE HIGH
           S,              // SET ACTIVE HIGH
           NOTI_REG;        // NOTIFY_REG
// FUNCTION : POSITIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE HIGH
//            ASYNCHRONOUS SET AND RESET.  ( QN OUTPUT UDP ).


   table
     //  D       G     RB    SB   NOTI_REG       : QNtn :   QNtn+0
                                  
         *       0      0     0     ?             :  ?  :    -   ;
                                  
         ?       ?      1     0     ?             :  ?  :    1   ; // asynchro clear
     
         ?       ?      0     1     ?             :  ?  :    0   ; 

         ?       ?      1     1     ?             :  ?  :    1   ;    
                                                                     
         ?      (?0)    ?     ?     ?             :  ?  :    -   ;  //AB
         ?      (1x)    ?     ?     ?             :  ?  :    -   ;  //AB
                                  
         0      (0x)    0     0     ?             :  1  :    1   ;
         1      (0x)    0     0     ?             :  0  :    0   ;
         0      (x1)    0     0     ?             :  ?  :    1   ;
         1      (x1)    0     0     ?             :  ?  :    0   ;
                                  
        (?0)     1      0     0     ?             :  ?  :    1   ;
        (?1)     1      0     0     ?             :  ?  :    0   ; 
         0      (01)    0     0     ?             :  ?  :    1   ;
         1      (01)    0     0     ?             :  ?  :    0   ; 
                                  
       
         ?       0     (?x)   0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         ?       0      x    (?0)   ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       0      x     0     ?             :  1  :    1   ;   // Reducing pessimism//AB

        (?0)     x      x     0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0       x      *     0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0      (0x)    x     0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0       x      x    (?0)   ?             :  1  :    1   ;   // Reducing pessimism.//AB

         0      (?1)    x     0     ?             :  ?  :    1   ; // Reducing pessimism.
        (?0)     1      x     0     ?             :  ?  :    1   ; // Reducing pessimism.
         0       1     (?x)   0     ?             :  ?  :    1   ; // Reducing pessimism.//AB
         0       1      x    (?0)   ?             :  ?  :    1   ; // Reducing pessimism.//AB
     
        
         ?       0      0    (?x)   ?             :  0  :    0   ;   // Reducing pessimism.//AB
         ?       0     (?0)   x     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         *       0      0     x     ?             :  0  :    0   ;   // Reducing pessimism//AB
 
        (?1)     x      0     x     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1       x      0     *     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1      (0x)    0     x     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1       x     (?0)   x     ?             :  0  :    0   ;   // Reducing pessimism.//AB

      
         1      (?1)    0     x     ?             :  ?  :    0   ; // Reducing pessimism.
        (?1)     1      0     x     ?             :  ?  :    0   ; // Reducing pessimism.
         1       1     (?0)   x     ?             :  ?  :    0   ; // Reducing pessimism.//AB
         1       1      0    (?x)   ?             :  ?  :    0   ; // Reducing pessimism.//AB
                                  
         ?       0     (?0)   0     ?             :  ?  :    -   ;   // ignore edge on clear
         0       1     (?0)   0     ?             :  ?  :    1   ;   // pessimism .
         1       1     (?0)   0     ?             :  ?  :    0   ;  

                                  
         ?       0      0    (?0)   ?             :  ?  :    -   ;   // ignore edge on set
         0       1      0    (?0)   ?             :  ?  :    1   ;   // pessimism .
         1       1      0    (?0)   ?             :  ?  :    0   ;  

        (?1)     x      0     0     ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      0     0     ?             :  1  :    1   ; // Reducing pessimism.
                                  
         ?       ?      ?     ?     *             :  ?  :    x   ;

   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFN.v                                  -
//--------------------------------------------------------------------
      
primitive UFN (Q, D, CP , NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP;
    reg    Q;  

// FUNCTION :  NEGATIVE EDGE TRIGGERED D FLIP-FLOP ( Q OUTPUT UDP ).


    table
 
    //  D   CP           NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)            ?          :   ?   :   1;  // clocked data
        0   (10)            ?          :   ?   :   0;
                                                           
        1   (1x)            ?          :   1   :   1;  // reducing pessimism
        0   (1x)            ?          :   0   :   0;                          
        1   (x0)            ?          :   1   :   1;  
        0   (x0)            ?          :   0   :   0; 
        
        ?   (0x)            ?          :   ?   :   -;  // no change on rising edge 
        ?   (?1)            ?          :   ?   :   -;  

        *    ?              ?          :   ?   :   -;  // ignore edges on data
        
        ?    ?              *          :   ?   :   x;
    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNCEB.v                                  -
//--------------------------------------------------------------------
      
primitive UFNCEB (Q, D, CP, CEB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, CEB;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH CLOCK ENABLE INPUT ( Q OUTPUT UDP ) 


    table
 
    //  D   CP      CEB     NOTIFIER_REG  :   Qt  :   Qt+1
                            
        1   (10)    0         ?          :   ?   :   1;  // clocked data
        0   (10)    0         ?          :   ?   :   0;
                            
        1   (1x)    0         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    0         ?          :   0   :   0;                          
        1   (x0)    0         ?          :   1   :   1;  
        0   (x0)    0         ?          :   0   :   0;  
                            
                            
        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data
                                  
        1   (10)    x         ?          :   1   :   1;  // reducing pessimism
        0   (10)    x         ?          :   0   :   0;                      
             
        1   (1x)    x         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    x         ?          :   0   :   0;                          
        1   (x0)    x         ?          :   1   :   1;  
        0   (x0)    x         ?          :   0   :   0;  

 
        ?   (?0)    1         ?          :   ?   :   -;  // reducing pessimism
        ?   (1x)    1         ?          :   ?   :   -;  // reducing pessimism

        ?    ?      *         ?          :   ?   :   -; // ignore edges on CE
        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFNRB.v                                  -
//--------------------------------------------------------------------
      
primitive UFNRB (Q, D, CP, RB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, RB;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR ( Q OUTPUT UDP ).


    table
 
    //  D   CP      RB     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    1         ?          :   ?   :   1;  // clocked data
        0   (10)    1         ?          :   ?   :   0;

        0   (10)    x         ?          :   ?   :   0;  // pessimism
        0    ?      x         ?          :   0   :   0;  // pessimism

        1    1      x         ?          :   0   :   0;  // pessimism
        1    x    (?x)        ?          :   0   :   0;  // pessimism
        1    0    (?x)        ?          :   0   :   0;  // pessimism

        x    1      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    0    (?x)        ?          :   0   :   0;  // pessimism

        1   (1x)    1         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    1         ?          :   0   :   0;                          
        1   (x0)    1         ?          :   1   :   1;  
        0   (x0)    1         ?          :   0   :   0;  


        ?   ?       0         ?          :   ?   :   0;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)        ?          :   ?   :   -;  // ignore the edges on clear 

        ?    ?      ?         *          :   ?   :   x;
 
    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNRBSX.v                                  -
//--------------------------------------------------------------------
      
primitive UFNRBSX  (Q, D, CP, RB, SB, NOTIFY_REG);

    output Q;  
    input  D, CP, RB, SB, NOTIFY_REG;
    reg    Q; 

// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET AND CLEAR. ILLEGAL OUPUT WHEN BOTH
//            SET AND CLEAR ARE LOW ( Q OUTPUT UDP ).

    table
 
    //  D    CP     RB  SB  NOTIFY_REG :   Qt  :   Qt+1

        1   (10)    1   1       ?      :   ?   :   1;  // clocked data
        1   (10)    1   x       ?      :   ?   :   1;  // pessimism

        1    ?      1   x       ?      :   1   :   1;  // pessimism

        0    1      1   x       ?      :   1   :   1;  // pessimism
        0    x      1 (?x)      ?      :   1   :   1;  // pessimism
        0    0      1 (?x)      ?      :   1   :   1;  // pessimism

        x    1      1   x       ?      :   1   :   1;  // pessimism
        x    x      1 (?x)      ?      :   1   :   1;  // pessimism
        x    0      1 (?x)      ?      :   1   :   1;  // pessimism


        0   (10)    1   1       ?      :   ?   :   0;  // clocked data
        0   (10)    x   1       ?      :   ?   :   0;  // pessimism

        0    ?      x   1       ?      :   0   :   0;  // pessimism

        1    1      x   1       ?      :   0   :   0;  // pessimism
        1    x    (?x)  1       ?      :   0   :   0;  // pessimism
        1    0    (?x)  1       ?      :   0   :   0;  // pessimism

        x    1      x   1       ?      :   0   :   0;  // pessimism
        x    x    (?x)  1       ?      :   0   :   0;  // pessimism
        x    0    (?x)  1       ?      :   0   :   0;  // pessimism
                                                           
        1   (1x)    1   1       ?      :   1   :   1;  // reducing pessimism
        0   (1x)    1   1       ?      :   0   :   0;                          
        1   (x0)    1   1       ?      :   1   :   1;  
        0   (x0)    1   1       ?      :   0   :   0;  

        ?   ?       0   1       ?      :   ?   :   0;  // asynchronous clear
        ?   ?       1   0       ?      :   ?   :   1;  // asynchronous set
        ?   ?       0   0       ?      :   ?   :   x;  // illegal output

        ?   (?1)    ?   ?       ?      :   ?   :   -;  // ignore rising clock
        ?   (0x)    ?   ?       ?      :   ?   :   -;  // ignore rising clock
        *    ?      ?   ?       ?      :   ?   :   -;  // ignore data edges 

        ?   ?     (?1)  ?       ?      :   ?   :   -;  // ignore the edges on 
        ?   ?       ?  (?1)     ?      :   ?   :   -;  // set and clear                  
        ?   ?       ?   ?       *      :   ?   :   x;  

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNS.v                                  -
//--------------------------------------------------------------------
      
primitive UFNS (Q, D, CP, S, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, S;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS SET ( Q OUTPUT UDP )


    table
 
    //  D   CP      S     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    0         ?          :   ?   :   1;  // clocked data
        0   (10)    0         ?          :   ?   :   0;
        1   (10)    x         ?          :   ?   :   1;  // reducing pessimism
        1    ?      x         ?          :   1   :   1;  // pessimism

        0    1      x         ?          :   1   :   1;  // pessimism
        0    x    (?x)        ?          :   1   :   1;  // pessimism
        0    0    (?x)        ?          :   1   :   1;  // pessimism

        x    1      x         ?          :   1   :   1;  // pessimism
        x    x    (?x)        ?          :   1   :   1;  // pessimism
        x    0    (?x)        ?          :   1   :   1;  // pessimism

        1   (1x)    0         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    0         ?          :   0   :   0;                          
        1   (x0)    0         ?          :   1   :   1;  
        0   (x0)    0         ?          :   0   :   0;  

        ?    ?      1         ?          :   ?   :   1;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?   ?     (?0)        ?          :   ?   :   -;  // ignore the edges on set
        
        ?   ?       ?         *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNSB.v                                  -
//--------------------------------------------------------------------
      
primitive UFNSB (Q, D, CP, SB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, SB;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET ( Q OUTPUT UDP )


    table
 
    //  D   CP      SB     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    1         ?          :   ?   :   1;  // clocked data
        0   (10)    1         ?          :   ?   :   0;
        1   (10)    x         ?          :   ?   :   1;  // reducing pessimism
        1    ?      x         ?          :   1   :   1;  // pessimism

        0    1      x         ?          :   1   :   1;  // pessimism
        0    x    (?x)        ?          :   1   :   1;  // pessimism
        0    0    (?x)        ?          :   1   :   1;  // pessimism

        x    1      x         ?          :   1   :   1;  // pessimism
        x    x    (?x)        ?          :   1   :   1;  // pessimism
        x    0    (?x)        ?          :   1   :   1;  // pessimism

        1   (1x)    1         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    1         ?          :   0   :   0;                          
        1   (x0)    1         ?          :   1   :   1;  
        0   (x0)    1         ?          :   0   :   0;  

        ?    ?      0         ?          :   ?   :   1;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?   ?     (?1)        ?          :   ?   :   -;  // ignore the edges on set
        
        ?   ?       ?         *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPCEB.v                                  -
//--------------------------------------------------------------------
      
primitive UFPCEB (Q, D, CP, CEB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, CEB;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH CLOCK ENABLE INPUT ( Q OUTPUT UDP ) 


    table
 
    //  D   CP      CEB     NOTIFIER_REG  :   Qt  :   Qt+1
                            
        1   (01)    0         ?          :   ?   :   1;  // clocked data
        0   (01)    0         ?          :   ?   :   0;
                            
        1   (x1)    0         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    0         ?          :   0   :   0;                          
        1   (0x)    0         ?          :   1   :   1;  
        0   (0x)    0         ?          :   0   :   0;  
                            
                            
        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data
                                  
        1   (01)    x         ?          :   1   :   1;  // reducing pessimism
        0   (01)    x         ?          :   0   :   0;                      
             
        1   (x1)    x         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    x         ?          :   0   :   0;                          
        1   (0x)    x         ?          :   1   :   1;  
        0   (0x)    x         ?          :   0   :   0;  

 
        ?   (?1)    1         ?          :   ?   :   -;  // reducing pessimism
        ?   (0x)    1         ?          :   ?   :   -;  // reducing pessimism

        ?    ?      *         ?          :   ?   :   -; // ignore edges on CE
        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFPS.v                                  -
//--------------------------------------------------------------------
      
primitive UFPS (Q, D, CP, S, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, S;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS SET ( Q OUTPUT UDP )


    table
 
    //  D   CP      S     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    0         ?          :   ?   :   1;  // clocked data
        0   (01)    0         ?          :   ?   :   0;
        1   (01)    x         ?          :   ?   :   1;  // reducing pessimism
        1    ?      x         ?          :   1   :   1;  // pessimism

        0    0      x         ?          :   1   :   1;  // pessimism
        0    x    (?x)        ?          :   1   :   1;  // pessimism
        0    1    (?x)        ?          :   1   :   1;  // pessimism

        x    0      x         ?          :   1   :   1;  // pessimism
        x    x    (?x)        ?          :   1   :   1;  // pessimism
        x    1    (?x)        ?          :   1   :   1;  // pessimism

        1   (x1)    0         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    0         ?          :   0   :   0;                          
        1   (0x)    0         ?          :   1   :   1;  
        0   (0x)    0         ?          :   0   :   0;  

        ?    ?      1         ?          :   ?   :   1;  // asynchronous clear

        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?   ?     (?0)        ?          :   ?   :   -;  // ignore the edges on set
        
        ?   ?       ?         *          :   ?   :   x;

    endtable
endprimitive


      

//  ------------------------------  END of ex_mig.v ----------------------------

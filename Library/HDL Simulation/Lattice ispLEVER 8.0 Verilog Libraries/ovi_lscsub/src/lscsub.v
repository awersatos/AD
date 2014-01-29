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
//                     U.S.A 
// 
//                     TEL: 1-800-Lattice (USA and Canada) 
//                          408-826-6000 (other locations) 
// 
//                     web: http://www.latticesemi.com/ 
//                     email: techsupport@latticesemi.com 
// 
// -------------------------------------------------------------------- 
// 
// Simulation Library File for LATTICE 2K/8K Macros
// 
// -------------------------------------------------------------------- 
// 
// Revision History : 
//
//`timescale 100ps/10ps
primitive D_LATCH (Q, D, G, RB);

//primitive U_LD_P_RB (Q, D, G, RB); 

//
// FUNCTION : D-LATCH, GATED  CLEAR DIRECT /GATE ACTIVE HIGH ( Q OUTPUT UDP ) 
//

    output Q; 
    reg    Q;                               
    input  D,
           G,                                       // Gate- active high
           RB;                                      // Clear-active low

    table
     //  D      G     RB       : Qt  :   Qt+1

         ?      0      1       :  ?  :    -   ;     // latch state 

         0      1      1       :  ?  :    0   ;     // latch data
         1      1      1       :  ?  :    1   ;            

         1      x      1       :  1  :    1   ;     // Reducing pessimism.
         0      x      1       :  0  :    0   ;     // Reducing pessimism
       
         ?      n      1       :  ?  :    -   ; 

         ?      ?      0       :  ?  :    0   ;      // Clear

         0      1      x       :  ?  :    0   ;      // Reducing pessimism.
         0      ?      x       :  0  :    0   ;      // Reducing pessimism.
         
         ?      0      x       :  0  :    0   ;      // Reducing pessimism 
   
      endtable

endprimitive

`timescale 100ps/10ps

primitive D_LATCH4 (Q, D, G, RB, SB);

    output Q; 
    reg    Q;                               
    input  D,
           G,                                       // Gate- active high
           RB,                                      // Clear-active low
           SB;                                      // Set-active low
    table
     //  D      G     RB     SB      : Qt  :   Qt+1

         ?      0      1      1      :  ?  :    -   ;     // latch state 

         0      1      1      1      :  ?  :    0   ;     // latch data
         1      1      1      1      :  ?  :    1   ;            

         1      x      1      1      :  1  :    1   ;     // Reducing pessimism.
         0      x      1      1      :  0  :    0   ;     // Reducing pessimism
       
         ?      n      1      1      :  ?  :    -   ;     // ignore negative edges on g

         ?      ?      0      ?      :  ?  :    0   ;      // Clear over set
         ?      ?      1      0      :  ?  :    1   ;      // Set

         0      1      x      1      :  ?  :    0   ;      // Reducing pessimism.
         0      ?      x      1      :  0  :    0   ;      // Reducing pessimism.
         1      1      1      x      :  ?  :    1   ;      // Reducing pessimism.
         1      ?      1      x      :  1  :    1   ;      // Reducing pessimism.
         
         ?      0      x      1      :  0  :    0   ;      // Reducing pessimism 
         ?      0      1      x      :  1  :    1   ;      // Reducing pessimism
   
      endtable

endprimitive


primitive DFF_IO  (Q, D, CP, RB);


    output Q;  
    input  D, CP, RB;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR ( Q OUTPUT UDP ).

    table
 
    //  D   CP      RB  :   Qt  :   Qt+1

        1   (01)    1   :   ?   :   1;  // clocked data
        0   (01)    1   :   ?   :   0;

        0   (01)    x   :   ?   :   0;  // pessimism

        0    ?      x   :   0   :   0;  // pessimism
                       
        1    0      x   :   0   :   0;  // pessimism
        1    x    (?x)  :   0   :   0;  // pessimism
        1    1    (?x)  :   0   :   0;  // pessimism
                       
        x    0      x   :   0   :   0;  // pessimism
        x    x    (?x)  :   0   :   0;  // pessimism
        x    1    (?x)  :   0   :   0;  // pessimism

        1   (x1)    1   :   1   :   1;  // reducing pessimism
        0   (x1)    1   :   0   :   0;                          
        1   (0x)    1   :   1   :   1;  
        0   (0x)    1   :   0   :   0;  


        ?   ?       0   :   ?   :   0;  // asynchronous clear

        ?   (?0)    ?   :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   :   ?   :   -;  // ignore falling clock
        *    ?      ?   :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)  :   ?   :   -;  // ignore the edges on clear 


    endtable
endprimitive




  primitive DFFFDPG (Q, D, CP, R, CD);



    output Q;  
    input  D, CP, R, CD;
    reg    Q; 
    
// FUNCTION :  POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//             ASYNCHRONOUS CLEAR ( Q OUTPUT UDP ).

    table
 
    //  D   CP      R   CD   :   Qt  :   Qt+1

        1   (01)    0    0   :   ?   :   1;  // clocked data - b = {0,1}
        0   (01)    0    0   :   ?   :   0;

        0   (01)    x    x   :   ?   :   0;  // pessimism
        0    ?      x    x   :   0   :   0;  // pessimism

        1    0      x    x   :   0   :   0;  // pessimism
        1    x    (?x)   ?   :   0   :   0;  // pessimism
        1    1    (?x)   ?   :   0   :   0;  // pessimism

        x    0      x    x   :   0   :   0;  // pessimism
        x    x    (?x)   ?   :   0   :   0;  // pessimism
        x    1    (?x)   ?   :   0   :   0;  // pessimism
                                                           
        1   (x1)    0    0   :   1   :   1;  // reducing pessimism
        0   (x1)    0    0   :   0   :   0;                          
        1   (0x)    0    0   :   1   :   1;  
        0   (0x)    0    0   :   0   :   0;  


        ?   ?       0    1   :   ?   :   0;  // asynchronous clear
        ?   ?       1    0   :   ?   :   0;  // asynchronous clear
        ?   ?       1    1   :   ?   :   0;  // asynchronous clear


        ?   (?0)    ?    ?   :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?    ?   :   ?   :   -;  // ignore falling clock
        *    ?      ?    ?   :   ?   :   -;  // ignore the edges on data

        ?    ?    (?0)   ?   :   ?   :   -;  // ignore the edges on clear
        ?    ?    (?1)   ?   :   ?   :   0;  // ignore the edges on clear
        ?    ?      ?  (?0)  :   ?   :   0;  // ignore the edges on clear 
 


    endtable
endprimitive


primitive DFFFDPGS (Q, D, CP, EN, R, S);

    output Q;  
    input  D, CP, EN, R, S;
    reg    Q; 
    
    table
 
    //  D   CP     EN      R      S   :   Qt  :   Qt+1

	1   (01)    1      0      0   :   ?   :   1;  // clocked data
	0   (01)    1      0      0   :   ?   :   0;
	?    ?      0      0      0   :   ?   :   -;  // disable

	0   (01)    1      x      0   :   ?   :   0;  // pessimism
	1   (01)    1      0      x   :   ?   :   1;  // pessimism
	0    ?      ?      x      0   :   0   :   0;  // pessimism
	1    ?      ?      0      x   :   1   :   1;  // pessimism

	1    0      ?      x      0   :   0   :   0;  // pessimism
	1    x      ?    (?x)     0   :   0   :   0;  // pessimism
	1    1      ?    (?x)     0   :   0   :   0;  // pessimism
	0    0      ?      0      x   :   1   :   1;  // pessimism
	0    x      ?      0    (?x)  :   1   :   1;  // pessimism


	x    0      ?      x      0   :   0   :   0;  // pessimism
	x    x      ?    (?x)     0   :   0   :   0;  // pessimism
	x    1      ?    (?x)     0   :   0   :   0;  // pessimism
	x    0      ?      0      x   :   1   :   1;  // pessimism
	x    x      ?      0    (?x)  :   1   :   1;  // pessimism
	x    1      ?      0    (?x)  :   1   :   1;  // pessimism
							   
	1   (x1)    ?      0      0   :   1   :   1;  // reducing pessimism
	0   (x1)    ?      0      0   :   0   :   0;                          
	1   (0x)    ?      0      0   :   1   :   1;  
	0   (0x)    ?      0      0   :   0   :   0;  


	?   ?       ?      1      ?   :   ?   :   0;  // asynchronous clear over set
	?   ?       ?      0      1   :   ?   :   1;  // asynchronous set

	?   (?0)    ?      ?      ?   :   ?   :   -;  // ignore falling clock
	?   (1x)    ?      ?      ?   :   ?   :   -;  // ignore falling clock
	*    ?      ?      ?      ?   :   ?   :   -;  // ignore the edges on data

	?    ?      ?    (?0)     ?   :   ?   :   -;  // ignore the edges on clear 
	?    ?      ?      ?    (?0)  :   ?   :   -;  // ignore the edges on set
	?    ?      *      ?      ?   :   ?   :   -;  // ignore the edges on enable


    endtable
endprimitive
`timescale 100ps/10ps
module GLOBAL;

//  wire  \!RESET; 
 reg  \!RESET ;

endmodule
/*
* "Cell PGAND1"                                                               *
*/

`timescale 100ps/10ps

module PGAND1 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule

/*
* "Cell PGAND10"                                                               *
*/

`timescale 100ps/10ps

module PGAND10 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);


   
endspecify

endmodule

/*
* "Cell PGAND11"                                                               *
*/

`timescale 100ps/10ps

module PGAND11 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);


   
endspecify

endmodule

/*
* "Cell PGAND12"                                                               *
*/

`timescale 100ps/10ps

module PGAND12 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);

   
endspecify

endmodule

/*
* "Cell PGAND13"                                                               *
*/

`timescale 100ps/10ps

module PGAND13 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);

   
endspecify

endmodule

/*
* "Cell PGAND14"                                                               *
*/

`timescale 100ps/10ps

module PGAND14 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
   
endspecify

endmodule

/*
* "Cell PGAND15"                                                               *
*/

`timescale 100ps/10ps

module PGAND15 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  

endspecify

endmodule

/*
* "Cell PGAND16"                                                               *
*/

`timescale 100ps/10ps

module PGAND16 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGAND17"                                                               *
*/

`timescale 100ps/10ps

module PGAND17 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;


    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGAND18"                                                               *
*/

`timescale 100ps/10ps

module PGAND18 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;


    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGAND19"                                                               *
*/

`timescale 100ps/10ps

module PGAND19 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;


    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND2"                                                               *
*/

`timescale 100ps/10ps

module PGAND2 (Z0, A0, A1);

    input  A0;
    input  A1;

    output  Z0;


    and blk1 (Z0, A0, A1);

specify

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGAND20"                                                               *
*/

`timescale 100ps/10ps

module PGAND20 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;


    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGAND21"                                                               *
*/

`timescale 100ps/10ps

module PGAND21 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;


    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGAND22"                                                               *
*/

`timescale 100ps/10ps

module PGAND22 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
 
endspecify

endmodule

/*
* "Cell PGAND23"                                                               *
*/

`timescale 100ps/10ps

module PGAND23 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGAND24"                                                               *
*/

`timescale 100ps/10ps

module PGAND24 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);




endspecify

endmodule

/*
* "Cell PGAND25"                                                               *
*/

`timescale 100ps/10ps

module PGAND25 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGAND26"                                                               *
*/

`timescale 100ps/10ps

module PGAND26 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND27"                                                               *
*/

`timescale 100ps/10ps

module PGAND27 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND28"                                                               *
*/

`timescale 100ps/10ps

module PGAND28 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND29"                                                               *
*/

`timescale 100ps/10ps

module PGAND29 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
`timescale 100ps/10ps

module PGAND3 (Z0, A0, A1, A2);

    input  A0;
    input  A1;
    input  A2;

    output  Z0;



    and blk1 (Z0, A0, A1, A2);


specify
	(A0 => Z0) = (1:1:1, 1:1:1);
	(A1 => Z0) = (1:1:1, 1:1:1);
	(A2 => Z0) = (1:1:1, 1:1:1);
endspecify
endmodule
/*
* "Cell PGAND30"                                                               *
*/

`timescale 100ps/10ps

module PGAND30 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND31"                                                               *
*/

`timescale 100ps/10ps

module PGAND31 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;
    input  A30;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);
    (A30 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND32"                                                               *
*/

`timescale 100ps/10ps

module PGAND32 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;
    input  A30;
    input  A31;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);
    (A30 => Z0) = (1:1:1, 1:1:1);
    (A31 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND33"                                                               *
*/

`timescale 100ps/10ps

module PGAND33 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;
    input  A30;
    input  A31;
    input  A32;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);
    (A30 => Z0) = (1:1:1, 1:1:1);
    (A31 => Z0) = (1:1:1, 1:1:1);
    (A32 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND34"                                                               *
*/

`timescale 100ps/10ps

module PGAND34 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;
    input  A30;
    input  A31;
    input  A32;
    input  A33;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);
    (A30 => Z0) = (1:1:1, 1:1:1);
    (A31 => Z0) = (1:1:1, 1:1:1);
    (A32 => Z0) = (1:1:1, 1:1:1);
    (A33 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND35"                                                               *
*/

`timescale 100ps/10ps

module PGAND35 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;
    input  A30;
    input  A31;
    input  A32;
    input  A33;
    input  A34;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);
    (A30 => Z0) = (1:1:1, 1:1:1);
    (A31 => Z0) = (1:1:1, 1:1:1);
    (A32 => Z0) = (1:1:1, 1:1:1);
    (A33 => Z0) = (1:1:1, 1:1:1);
    (A34 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND36"                                                               *
*/

`timescale 100ps/10ps

module PGAND36 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;
    input  A30;
    input  A31;
    input  A32;
    input  A33;
    input  A34;
    input  A35;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);
    (A30 => Z0) = (1:1:1, 1:1:1);
    (A31 => Z0) = (1:1:1, 1:1:1);
    (A32 => Z0) = (1:1:1, 1:1:1);
    (A33 => Z0) = (1:1:1, 1:1:1);
    (A34 => Z0) = (1:1:1, 1:1:1);
    (A35 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND37"                                                               *
*/

`timescale 100ps/10ps

module PGAND37 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;
    input  A30;
    input  A31;
    input  A32;
    input  A33;
    input  A34;
    input  A35;
    input  A36;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);
    (A30 => Z0) = (1:1:1, 1:1:1);
    (A31 => Z0) = (1:1:1, 1:1:1);
    (A32 => Z0) = (1:1:1, 1:1:1);
    (A33 => Z0) = (1:1:1, 1:1:1);
    (A34 => Z0) = (1:1:1, 1:1:1);
    (A35 => Z0) = (1:1:1, 1:1:1);
    (A36 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND38"                                                               *
*/

`timescale 100ps/10ps

module PGAND38 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;
    input  A30;
    input  A31;
    input  A32;
    input  A33;
    input  A34;
    input  A35;
    input  A36;
    input  A37;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);
    (A30 => Z0) = (1:1:1, 1:1:1);
    (A31 => Z0) = (1:1:1, 1:1:1);
    (A32 => Z0) = (1:1:1, 1:1:1);
    (A33 => Z0) = (1:1:1, 1:1:1);
    (A34 => Z0) = (1:1:1, 1:1:1);
    (A35 => Z0) = (1:1:1, 1:1:1);
    (A36 => Z0) = (1:1:1, 1:1:1);
    (A37 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND39"                                                               *
*/

`timescale 100ps/10ps

module PGAND39 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;
    input  A30;
    input  A31;
    input  A32;
    input  A33;
    input  A34;
    input  A35;
    input  A36;
    input  A37;
    input  A38;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);
    (A30 => Z0) = (1:1:1, 1:1:1);
    (A31 => Z0) = (1:1:1, 1:1:1);
    (A32 => Z0) = (1:1:1, 1:1:1);
    (A33 => Z0) = (1:1:1, 1:1:1);
    (A34 => Z0) = (1:1:1, 1:1:1);
    (A35 => Z0) = (1:1:1, 1:1:1);
    (A36 => Z0) = (1:1:1, 1:1:1);
    (A37 => Z0) = (1:1:1, 1:1:1);
    (A38 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGAND4"                                                               *
*/

`timescale 100ps/10ps

module PGAND4 (Z0, A0, A1, A2, A3);

    input  A0;
    input  A1;
    input  A2;
    input  A3;

    output  Z0;

    and blk1  (Z0, A0, A1, A2, A3);

specify
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND40"                                                               *
*/

`timescale 100ps/10ps

module PGAND40 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;
    input  A30;
    input  A31;
    input  A32;
    input  A33;
    input  A34;
    input  A35;
    input  A36;
    input  A37;
    input  A38;
    input  A39;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);
    (A30 => Z0) = (1:1:1, 1:1:1);
    (A31 => Z0) = (1:1:1, 1:1:1);
    (A32 => Z0) = (1:1:1, 1:1:1);
    (A33 => Z0) = (1:1:1, 1:1:1);
    (A34 => Z0) = (1:1:1, 1:1:1);
    (A35 => Z0) = (1:1:1, 1:1:1);
    (A36 => Z0) = (1:1:1, 1:1:1);
    (A37 => Z0) = (1:1:1, 1:1:1);
    (A38 => Z0) = (1:1:1, 1:1:1);
    (A39 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND41"                                                               *
*/

`timescale 100ps/10ps

module PGAND41 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;
    input  A30;
    input  A31;
    input  A32;
    input  A33;
    input  A34;
    input  A35;
    input  A36;
    input  A37;
    input  A38;
    input  A39;
    input  A40;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);
    (A30 => Z0) = (1:1:1, 1:1:1);
    (A31 => Z0) = (1:1:1, 1:1:1);
    (A32 => Z0) = (1:1:1, 1:1:1);
    (A33 => Z0) = (1:1:1, 1:1:1);
    (A34 => Z0) = (1:1:1, 1:1:1);
    (A35 => Z0) = (1:1:1, 1:1:1);
    (A36 => Z0) = (1:1:1, 1:1:1);
    (A37 => Z0) = (1:1:1, 1:1:1);
    (A38 => Z0) = (1:1:1, 1:1:1);
    (A39 => Z0) = (1:1:1, 1:1:1);
    (A40 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND42"                                                               *
*/

`timescale 100ps/10ps

module PGAND42 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;
    input  A30;
    input  A31;
    input  A32;
    input  A33;
    input  A34;
    input  A35;
    input  A36;
    input  A37;
    input  A38;
    input  A39;
    input  A40;
    input  A41;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);
    (A30 => Z0) = (1:1:1, 1:1:1);
    (A31 => Z0) = (1:1:1, 1:1:1);
    (A32 => Z0) = (1:1:1, 1:1:1);
    (A33 => Z0) = (1:1:1, 1:1:1);
    (A34 => Z0) = (1:1:1, 1:1:1);
    (A35 => Z0) = (1:1:1, 1:1:1);
    (A36 => Z0) = (1:1:1, 1:1:1);
    (A37 => Z0) = (1:1:1, 1:1:1);
    (A38 => Z0) = (1:1:1, 1:1:1);
    (A39 => Z0) = (1:1:1, 1:1:1);
    (A40 => Z0) = (1:1:1, 1:1:1);
    (A41 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND43"                                                               *
*/

`timescale 100ps/10ps

module PGAND43 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;
    input  A30;
    input  A31;
    input  A32;
    input  A33;
    input  A34;
    input  A35;
    input  A36;
    input  A37;
    input  A38;
    input  A39;
    input  A40;
    input  A41;
    input  A42;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);
    (A30 => Z0) = (1:1:1, 1:1:1);
    (A31 => Z0) = (1:1:1, 1:1:1);
    (A32 => Z0) = (1:1:1, 1:1:1);
    (A33 => Z0) = (1:1:1, 1:1:1);
    (A34 => Z0) = (1:1:1, 1:1:1);
    (A35 => Z0) = (1:1:1, 1:1:1);
    (A36 => Z0) = (1:1:1, 1:1:1);
    (A37 => Z0) = (1:1:1, 1:1:1);
    (A38 => Z0) = (1:1:1, 1:1:1);
    (A39 => Z0) = (1:1:1, 1:1:1);
    (A40 => Z0) = (1:1:1, 1:1:1);
    (A41 => Z0) = (1:1:1, 1:1:1);
    (A42 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND44"                                                               *
*/

`timescale 100ps/10ps

module PGAND44 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;
    input  A26;
    input  A27;
    input  A28;
    input  A29;
    input  A30;
    input  A31;
    input  A32;
    input  A33;
    input  A34;
    input  A35;
    input  A36;
    input  A37;
    input  A38;
    input  A39;
    input  A40;
    input  A41;
    input  A42;
    input  A43;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);
    (A26 => Z0) = (1:1:1, 1:1:1);
    (A27 => Z0) = (1:1:1, 1:1:1);
    (A28 => Z0) = (1:1:1, 1:1:1);
    (A29 => Z0) = (1:1:1, 1:1:1);
    (A30 => Z0) = (1:1:1, 1:1:1);
    (A31 => Z0) = (1:1:1, 1:1:1);
    (A32 => Z0) = (1:1:1, 1:1:1);
    (A33 => Z0) = (1:1:1, 1:1:1);
    (A34 => Z0) = (1:1:1, 1:1:1);
    (A35 => Z0) = (1:1:1, 1:1:1);
    (A36 => Z0) = (1:1:1, 1:1:1);
    (A37 => Z0) = (1:1:1, 1:1:1);
    (A38 => Z0) = (1:1:1, 1:1:1);
    (A39 => Z0) = (1:1:1, 1:1:1);
    (A40 => Z0) = (1:1:1, 1:1:1);
    (A41 => Z0) = (1:1:1, 1:1:1);
    (A42 => Z0) = (1:1:1, 1:1:1);
    (A43 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGAND5"                                                               *
*/

`timescale 100ps/10ps

module PGAND5 (Z0, A0, A1, A2, A3, A4);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;

    output  Z0;



  
    and blk1 (Z0, A0, A1, A2, A3, A4);

specify
  

    (A0 => Z0) = (1:1:1, 1:1:1);  /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);
    (A4 => Z0) = (1:1:1, 1:1:1);



endspecify


endmodule

/*
* "Cell PGAND6"                                                               *
*/

`timescale 100ps/10ps

module PGAND6 (Z0, A0, A1, A2, A3, A4, A5);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;

    output  Z0;

    and blk1 (Z0, A0, A1, A2, A3, A4, A5);


specify
   
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);


endspecify

endmodule

/*
* "Cell PGAND7"                                                               *
*/

`timescale 100ps/10ps

module PGAND7 (Z0, A0, A1, A2, A3, A4, A5, A6);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;

    output  Z0;

    and blk1 (Z0, A0, A1, A2, A3, A4, A5, A6);


specify
   
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);


endspecify


endmodule

/*
* "Cell PGAND8"                                                               *
*/

`timescale 100ps/10ps

module PGAND8 (Z0, A0, A1, A2, A3, A4, A5, A6, A7);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
   
endspecify

endmodule

/*
* "Cell PGAND9"                                                               *
*/

`timescale 100ps/10ps

module PGAND9 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);

   
endspecify

endmodule
/*
* "Cell PGANDD1"                                                               *
*/

`timescale 100ps/10ps

module PGANDD1 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


  specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
  endspecify

endmodule

/*
* "Cell PGANDD10"                                                               *
*/

`timescale 100ps/10ps

module PGANDD10 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);


   
endspecify

endmodule

/*
* "Cell PGANDD11"                                                               *
*/

`timescale 100ps/10ps

module PGANDD11 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);


   
endspecify

endmodule

/*
* "Cell PGANDD12"                                                               *
*/

`timescale 100ps/10ps

module PGANDD12 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);

   
endspecify

endmodule

/*
* "Cell PGANDD13"                                                               *
*/

`timescale 100ps/10ps

module PGANDD13 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);

   
endspecify

endmodule

/*
* "Cell PGANDD14"                                                               *
*/

`timescale 100ps/10ps

module PGANDD14 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
   
endspecify

endmodule

/*
* "Cell PGANDD15"                                                               *
*/

`timescale 100ps/10ps

module PGANDD15 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  

endspecify

endmodule

/*
* "Cell PGANDD16"                                                               *
*/

`timescale 100ps/10ps

module PGANDD16 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGANDD17"                                                               *
*/

`timescale 100ps/10ps

module PGANDD17 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;


    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGANDD18"                                                               *
*/

`timescale 100ps/10ps

module PGANDD18 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;


    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGANDD19"                                                               *
*/

`timescale 100ps/10ps

module PGANDD19 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;


    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGANDD2"                                                               *
*/

`timescale 100ps/10ps

module PGANDD2 (Z0, A0, A1);

    input  A0;
    input  A1;

    output  Z0;


    and blk1 (Z0, A0, A1);

specify

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGANDD20"                                                               *
*/

`timescale 100ps/10ps

module PGANDD20 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;


    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGANDD21"                                                               *
*/

`timescale 100ps/10ps

module PGANDD21 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;


    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGANDD22"                                                               *
*/

`timescale 100ps/10ps

module PGANDD22 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGANDD23"                                                               *
*/

`timescale 100ps/10ps

module PGANDD23 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGANDD24"                                                               *
*/

`timescale 100ps/10ps

module PGANDD24 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);




endspecify

endmodule

/*
* "Cell PGANDD25"                                                               *
*/

`timescale 100ps/10ps

module PGANDD25 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGANDD26"                                                               *
*/

`timescale 100ps/10ps

module PGANDD26 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;
    input  A9;
    input  A10;
    input  A11;
    input  A12;
    input  A13;
    input  A14;
    input  A15;
    input  A16;
    input  A17;
    input  A18;
    input  A19;
    input  A20;
    input  A21;
    input  A22;
    input  A23;
    input  A24;
    input  A25;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);
    (A9 => Z0) = (1:1:1, 1:1:1);
    (A10 => Z0) = (1:1:1, 1:1:1);
    (A11 => Z0) = (1:1:1, 1:1:1);
    (A12 => Z0) = (1:1:1, 1:1:1);
    (A13 => Z0) = (1:1:1, 1:1:1);
    (A14 => Z0) = (1:1:1, 1:1:1);  
    (A15 => Z0) = (1:1:1, 1:1:1);
    (A16 => Z0) = (1:1:1, 1:1:1);
    (A17 => Z0) = (1:1:1, 1:1:1);
    (A18 => Z0) = (1:1:1, 1:1:1);
    (A19 => Z0) = (1:1:1, 1:1:1);
    (A20 => Z0) = (1:1:1, 1:1:1);
    (A21 => Z0) = (1:1:1, 1:1:1);
    (A22 => Z0) = (1:1:1, 1:1:1);
    (A23 => Z0) = (1:1:1, 1:1:1);
    (A24 => Z0) = (1:1:1, 1:1:1);
    (A25 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
`timescale 100ps/10ps

module PGANDD3 (Z0, A0, A1, A2);

    input  A0;
    input  A1;
    input  A2;

    output  Z0;



    and blk1 (Z0, A0, A1, A2);


specify
	(A0 => Z0) = (1:1:1, 1:1:1);
	(A1 => Z0) = (1:1:1, 1:1:1);
	(A2 => Z0) = (1:1:1, 1:1:1);
endspecify
endmodule

/*
* "Cell PGANDD4"                                                               *
*/

`timescale 100ps/10ps

module PGANDD4 (Z0, A0, A1, A2, A3);

    input  A0;
    input  A1;
    input  A2;
    input  A3;

    output  Z0;

    and blk1  (Z0, A0, A1, A2, A3);

specify
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGANDD5"                                                               *
*/

`timescale 100ps/10ps

module PGANDD5 (Z0, A0, A1, A2, A3, A4);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;

    output  Z0;



  
    and blk1 (Z0, A0, A1, A2, A3, A4);

specify
  

    (A0 => Z0) = (1:1:1, 1:1:1);  /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);
    (A4 => Z0) = (1:1:1, 1:1:1);



endspecify


endmodule

/*
* "Cell PGANDD6"                                                               *
*/

`timescale 100ps/10ps

module PGANDD6 (Z0, A0, A1, A2, A3, A4, A5);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;

    output  Z0;

    and blk1 (Z0, A0, A1, A2, A3, A4, A5);


specify
   
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);


endspecify

endmodule

/*
* "Cell PGANDD7"                                                               *
*/

`timescale 100ps/10ps

module PGANDD7 (Z0, A0, A1, A2, A3, A4, A5, A6);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;

    output  Z0;

    and blk1 (Z0, A0, A1, A2, A3, A4, A5, A6);


specify
   
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);


endspecify


endmodule

/*
* "Cell PGANDD8"                                                               *
*/

`timescale 100ps/10ps

module PGANDD8 (Z0, A0, A1, A2, A3, A4, A5, A6, A7);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
   
endspecify

endmodule

/*
* "Cell PGANDD9"                                                               *
*/

`timescale 100ps/10ps

module PGANDD9 (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;
    input  A7;
    input  A8;

    output  Z0;


    and blk1  (Z0, A0, A1, A2, A3, A4, A5, A6, A7, A8);




specify
   

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);   
    (A4 => Z0) = (1:1:1, 1:1:1);
    (A5 => Z0) = (1:1:1, 1:1:1);
    (A6 => Z0) = (1:1:1, 1:1:1);
    (A7 => Z0) = (1:1:1, 1:1:1);
    (A8 => Z0) = (1:1:1, 1:1:1);

   
endspecify

endmodule
/*
* "Cell PGBUFE"                                                               *
*/

`timescale 100ps/10ps

module PGBUFE (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PGBUFF"                                                               *
*/

`timescale 100ps/10ps

module PGBUFF (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PGBUFI"                                                               *
*/

`timescale 100ps/10ps

module PGBUFI (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PGBUFK"                                                               *
*/

`timescale 100ps/10ps

module PGBUFK (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PGBUFKI"                                                               *
*/

`timescale 100ps/10ps

module PGBUFKI (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PGBUFR"                                                               *
*/

`timescale 100ps/10ps

module PGBUFR (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PGBUFXA"                                                               *
*/

`timescale 100ps/10ps

module PGBUFXA (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PGBUFXI"                                                               *
*/

`timescale 100ps/10ps

module PGBUFXI (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PGBUFXO"                                                               *
*/

`timescale 100ps/10ps

module PGBUFXO (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule

/**************
*    PGDFF   *
***************/

`timescale 100ps/10ps



`celldefine


module PGDFF  (Q0, CLK, D0, CD);



    input   D0, CLK, CD;

    output   Q0;
       
       not  blk0 (t1, GLOBAL.\!RESET );
       DFFFDPG inst1 (Q0_int, D0, CLK, t1 , CD);
       buf inst2 (Q0, Q0_int);

       or (clear, GLOBAL.\!RESET , CD);


`define HOLDD0	1   
`define HOLDD1	1  
`define SUD0	1
`define SUD1	1
`define NEGC0	1
`define NEGC1	1
`define POSC0	1
`define POSC1	1
`define LHCQ	1
`define HLCQ	1
`define HLRQ	1  
`define RECRC	0
`define HOLDRC	0
`define HLCLQ	0   
`define HLPDQ	0
`define LHPDQ   0
`define HLPEQ	0
`define HOLDRCE	0
`define LHPDQ	0
`define LHPEQ	0
`define PULSEE0	0
`define PULSEE1	0
`define RECRCE	0


    specify

    specparam   ck0_to_q_param =           `LHCQ;
    specparam   ck1_to_q_param =           `HLCQ;

    specparam   d_to_q_param0   =           `LHPDQ;
    specparam   d_to_q_param1   =          `HLPDQ;


    specparam   reset_to_q_param =         `HLRQ;
    specparam   cd_to_q_param    =         `HLCLQ;


    specparam   D_hold0_limit_param =      `HOLDD0;
    specparam   D_hold1_limit_param =      `HOLDD1;

    specparam   R_hold_limit_param =       `HOLDRC;
 
    specparam   CLR_hold_limit_param =     `HOLDRCE;

    specparam   pose0_pulse_width_param =  `POSC0;
    specparam   pose1_pulse_width_param =  `POSC1;

    specparam   nege0_pulse_width_param =  `NEGC0;
    specparam   nege1_pulse_width_param =  `NEGC1;

    specparam   PE_pulse_width_param =     `PULSEE0;

    specparam   recovery_limit_param =     `RECRC;
    specparam   PE_recovery_limit_param =  `RECRCE;

    specparam   D_setup0_limit_param =     `SUD0;
    specparam   D_setup1_limit_param =     `SUD1;




    // Specify path delays

  //  if (!clear)
        (posedge CLK =>  (Q0 +: D0)) = (ck0_to_q_param, ck1_to_q_param);


  //  if (clear)
        (posedge CD  =>  (Q0 +: 1'b0)) = (reset_to_q_param, reset_to_q_param);

 

      // Timing checks 


    $setup(D0, posedge CLK, D_setup0_limit_param);
    $hold(posedge CLK, D0, D_hold0_limit_param);
 
    $width(posedge CLK &&&  D0, pose0_pulse_width_param); 
    $width(negedge CLK &&&  D0, nege0_pulse_width_param);

    $width(posedge CLK &&&  ~D0, pose0_pulse_width_param); 
    $width(negedge CLK &&&  ~D0, nege0_pulse_width_param); 

 

    $recovery(posedge CLK, negedge CD, recovery_limit_param);  //
    $recovery(negedge CD, posedge CLK, recovery_limit_param);  //

    endspecify

endmodule
`endcelldefine

/**************
*    PGDFFR   *
***************/

`timescale 100ps/10ps



`celldefine

module PGDFFR (Q0, D0, CLK, CD, RNESET);


    input   D0, CLK, CD, RNESET;

    output   Q0;

       not  blk0 (t1, RNESET );
       DFFFDPG inst1 (Q0_int, D0, CLK, t1, CD);
       buf inst2 (Q0, Q0_int);

       or (clear, RNESET, CD);


`define HOLDD0	1  // Hold time from active clock edge to D when D is 0
`define HOLDD1	1  // Hold time from active clock edge to D when D is 1
`define SUD0	1
`define SUD1	1
`define NEGC0	1
`define NEGC1	1
`define POSC0	1
`define POSC1	1
`define LHCQ	1
`define HLCQ	1
`define HLRQ	1  // delay from reset to Q output
`define RECRC	0
`define HOLDRC	0
`define HLCLQ	0  // delay from cd to Q output 
`define HLPDQ	0
`define LHPDQ   0
`define HLPEQ	0
`define HOLDRCE	0
`define LHPDQ	0
`define LHPEQ	0
`define PULSEE0	0
`define PULSEE1	0
`define RECRCE	0


    specify

    specparam   ck0_to_q_param =           `LHCQ;
    specparam   ck1_to_q_param =           `HLCQ;

    specparam   d_to_q_param0   =           `LHPDQ;
    specparam   d_to_q_param1   =          `HLPDQ;


    specparam   reset_to_q_param =         `HLRQ;
    specparam   cd_to_q_param    =         `HLCLQ;


    specparam   D_hold0_limit_param =      `HOLDD0;
    specparam   D_hold1_limit_param =      `HOLDD1;

    specparam   R_hold_limit_param =       `HOLDRC;
 
    specparam   CLR_hold_limit_param =     `HOLDRCE;

    specparam   pose0_pulse_width_param =  `POSC0;
    specparam   pose1_pulse_width_param =  `POSC1;

    specparam   nege0_pulse_width_param =  `NEGC0;
    specparam   nege1_pulse_width_param =  `NEGC1;

    specparam   PE_pulse_width_param =     `PULSEE0;

    specparam   recovery_limit_param =     `RECRC;
    specparam   PE_recovery_limit_param =  `RECRCE;

    specparam   D_setup0_limit_param =     `SUD0;
    specparam   D_setup1_limit_param =     `SUD1;




    // Specify path delays

 //   if (!clear)
        (posedge CLK =>  (Q0 +: D0)) = (ck0_to_q_param, ck1_to_q_param);


 //   if (clear)
        (posedge CD  =>  (Q0 +: 1'b0)) = (reset_to_q_param, reset_to_q_param);

 //   if (clear)     
        (negedge RNESET  =>  (Q0 +: 1'b0)) = (reset_to_q_param, reset_to_q_param); 


      // Timing checks 

    $setup(D0, posedge CLK, D_setup0_limit_param);
    $hold(posedge CLK, D0, D_hold0_limit_param);
 
   
    $width(posedge CLK &&&  D0, pose0_pulse_width_param); 
    $width(negedge CLK &&&  D0, nege0_pulse_width_param);

    $width(posedge CLK &&&  ~D0, pose0_pulse_width_param); 
    $width(negedge CLK &&&  ~D0, nege0_pulse_width_param);  
 
 

    $recovery(posedge CLK, negedge CD, recovery_limit_param); 
    $recovery(posedge CLK, posedge RNESET, recovery_limit_param); 
    $recovery(negedge CD, posedge CLK, recovery_limit_param); 
    $recovery(posedge RNESET, posedge CLK, recovery_limit_param); 


    endspecify

endmodule
`endcelldefine
/********************************
*           PGDFFRS             *
********************************/

`timescale 100ps/10ps


`celldefine

module PGDFFRS (Q0, D0, CLK, EN, CD, SD);

  input D0, CLK, CD, SD, EN;
  output Q0;


  DFFFDPGS inst1 (Q0, D0, CLK, EN, CD, SD);

  `define HOLDD0    1
  `define SUD0      1
  `define NEGC0     1
  `define NEGC1     1
  `define POSC0     1
  `define POSC1     1
  `define LHCQ      1
  `define HLCQ      1
  `define HLRQ      1
  `define LHSQ      1
  `define PULSES    1
  `define PULSER    1
  `define SUEN      1
  `define HOLDEN    1
  `define RECRC     0
  `define HOLDRC    0
  `define RECSC     0
  `define HOLDSC    0


  specify
    specparam ck0_to_q_param          =   `LHCQ;
    specparam ck1_to_q_param          =   `LHCQ;

    specparam r_to_q_param            =   `HLRQ;
    specparam s_to_q_param            =   `LHSQ;   
    
    specparam d_setup_limit_param     =   `SUD0;
    specparam d_hold_limit_param      =   `HOLDD0;

    specparam r_hold_limit_param      =   `HOLDRC;
    specparam s_hold_limit_param      =   `HOLDSC;

    specparam pose0_pulse_width_param =   `POSC0;
    specparam pose1_pulse_width_param =   `POSC1;

    specparam nege0_pulse_width_param =   `NEGC0;
    specparam nege1_pulse_width_param =   `NEGC1;

    specparam r_recovery_limit_param  =   `RECRC;
    specparam s_recovery_limit_param  =   `RECSC;

    specparam en_setup_limit_param    =   `SUEN;
    specparam en_hold_limit_param     =   `HOLDEN;

    specparam r_pulse_width_param     =   `PULSER;
    specparam s_pulse_width_param     =   `PULSES;


//  Path Delay    

    // ck1_, ck0_ order changed since PXDFFR because polarity
    (posedge CLK => (Q0 +: D0)) = (ck1_to_q_param, ck0_to_q_param);
    (posedge CD  => (Q0 +: 1'b0)) = (r_to_q_param, r_to_q_param);
    (posedge SD  => (Q0 +: 1'b1)) = (s_to_q_param, s_to_q_param);


//  Timing check

    $setup(D0, posedge CLK, d_setup_limit_param);
    $hold(posedge CLK, D0, d_hold_limit_param);

    $setup(EN, posedge CLK, en_setup_limit_param);
    $hold(posedge CLK, EN, en_hold_limit_param);

    $width(posedge CLK &&& ~D0, pose0_pulse_width_param);
    $width(negedge CLK &&& ~D0, nege0_pulse_width_param);
    // POSC1 repleases POSC0 since PXDFFR
    $width(posedge CLK &&& D0, pose1_pulse_width_param);
    $width(negedge CLK &&& D0, nege1_pulse_width_param);

    // HOLD checking used since PXDFFR
    $recovery(negedge CD, posedge CLK, r_recovery_limit_param);
    $recovery(posedge CLK, negedge CD, r_hold_limit_param);
    $recovery(negedge SD, posedge CLK, s_recovery_limit_param);
    $recovery(posedge CLK, negedge SD, s_hold_limit_param);

    //CD/SD pulse width checking appended
    $width(posedge CD, r_pulse_width_param);
    $width(posedge SD, s_pulse_width_param);
  
  endspecify

endmodule

`endcelldefine
/*************************************
 *              PGDLRS               *
 ************************************/

`timescale 100ps/10ps

`celldefine

module PGDLRS (Q0, D0, G, CD, SD);

  input D0, G, CD, SD;
  output Q0;

  not blk0 (t0, CD);
  not blk1 (t1, SD);
  D_LATCH4 inst1 (Q0, D0, G, t0, t1);

  `define HOLDD0    1
  `define HOLDD1    1
  `define SUD0      1
  `define SUD1      1
  `define LHPDQ     1
  `define HLPDQ     1
  `define LHPEQ     1
  `define HLPEQ     1
  `define PULSEE0   1
  `define PULSEE1   1
  `define HLCLQ     1
  `define LHPQ      1
  `define PULSECL   1
  `define PULSEP    1
  `define RECRCE    0
  `define HOLDRCE   0
  `define RECPPE    0
  `define HOLDPPE   0

  specify
    specparam pd_hold0_limit_param     = `HOLDD0;
    specparam pd_hold1_limit_param     = `HOLDD1;

    specparam pd_setup0_limit_param    = `SUD0;
    specparam pd_setup1_limit_param    = `SUD1;

    specparam pd0_to_q_param           = `LHPDQ;
    specparam pd1_to_q_param           = `HLPDQ;

    specparam pe0_to_q_param           = `LHPEQ;
    specparam pe1_to_q_param           = `HLPEQ;

    specparam pe_pulse0_width_param    = `PULSEE0;
    specparam pe_pulse1_width_param    = `PULSEE1;

    specparam hl_clr_to_q_param        = `HLCLQ;
    specparam lh_pre_to_q_param        = `LHPQ;

    specparam clr_pulse_width_param    = `PULSECL;
    specparam pre_pulse_width_param    = `PULSEP;

    specparam clr_recovery_limit_param = `RECRCE;
    specparam pre_recovery_limit_param = `RECPPE;

    specparam clr_hold_limit_param     = `HOLDRCE;
    specparam pre_hold_limit_param     = `HOLDPPE;

    // specify the path delays

    (D0 => Q0) = (pd0_to_q_param, pd1_to_q_param);
    // += replaces = since PXDLR because polarity
    (posedge G => (Q0 +: D0)) = (pe1_to_q_param, pe0_to_q_param);
    (posedge CD => (Q0 +: 1'b0)) = (hl_clr_to_q_param, hl_clr_to_q_param);
    (posedge SD => (Q0 +: 1'b1)) = (lh_pre_to_q_param, lh_pre_to_q_param);

    // timing checking

    $setup(D0, negedge G, pd_setup0_limit_param);
    $hold(negedge G, D0, pd_hold0_limit_param);

    // modify since PXDLR for D0 polarity
    $width(posedge G &&& ~D0, pe_pulse0_width_param);
    $width(posedge G &&& D0, pe_pulse1_width_param);

    // append since PXDLR
    $width(posedge CD, clr_pulse_width_param);
    $width(posedge SD, pre_pulse_width_param);

    // HOLD checking used since PXDLR
    $recovery(negedge CD, negedge G, clr_recovery_limit_param);
    $recovery(negedge G, negedge CD, clr_hold_limit_param);
    $recovery(negedge SD, negedge G, pre_recovery_limit_param);
    $recovery(negedge G, negedge SD, pre_hold_limit_param);

  endspecify

endmodule
`endcelldefine

/*
* "Cell PGINVI"                                                               *
*/

`timescale 100ps/10ps

module PGINVI (ZN0, A0);

    input  A0;

    output  ZN0;

    not blk1 (ZN0, A0);


specify

   (A0 => ZN0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

endmodule

/*
* "Cell PGINVK"                                                               *
*/

`timescale 100ps/10ps

module PGINVK (ZN0, A0);

    input  A0;

    output  ZN0;

    not blk1 (ZN0, A0);


specify

   (A0 => ZN0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

endmodule

/*
* "Cell PGINVKI"                                                               *
*/

`timescale 100ps/10ps

module PGINVKI (ZN0, A0);

    input  A0;

    output  ZN0;

    not blk1 (ZN0, A0);


specify

   (A0 => ZN0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

endmodule

/*
* "Cell PGORF41"                                                              *
*/

`timescale 100ps/10ps

module PGORF41 (Z0, A0);

    input  A0;

    output  Z0;

    buf  blk1  (Z0, A0);

specify

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

  endmodule

/*
* "Cell PGORF42"                                                              *
*/

`timescale 100ps/10ps

module PGORF42 (Z0, A0, A1);

    input  A0;
    input  A1;

    output  Z0;

    or  blk1 (Z0, A0, A1);


specify


    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGORF43"                                                              *
*/

`timescale 100ps/10ps

module PGORF43 (Z0, A0, A1, A2);

    input  A0;
    input  A1;
    input  A2;

    output  Z0;

    or blk1 (Z0, A0, A1, A2);

specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);
   (A2 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGORF44"                                                              *
*/

`timescale 100ps/10ps

module PGORF44 (Z0, A0, A1, A2, A3);

    input  A0;
    input  A1;
    input  A2;
    input  A3;


    output  Z0;

    or blk1 (Z0, A0, A1, A2, A3);

specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);
   (A2 => Z0) = (1:1:1, 1:1:1);
   (A3 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGORF51"                                                              *
*/

`timescale 100ps/10ps

module PGORF51 (Z0, A0);

    input  A0;

    output  Z0;

    buf  blk1  (Z0, A0);

specify

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

endmodule

/*
* "Cell PGORF52"                                                              *
*/

`timescale 100ps/10ps

module PGORF52 (Z0, A0, A1);

    input  A0;
    input  A1;

    output  Z0;

    or  blk1 (Z0, A0, A1);


specify


    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGORF53"                                                              *
*/

`timescale 100ps/10ps

module PGORF53 (Z0, A0, A1, A2);

    input  A0;
    input  A1;
    input  A2;

    output  Z0;

    or blk1 (Z0, A0, A1, A2);

specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);
   (A2 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGORF54"                                                              *
*/

`timescale 100ps/10ps

module PGORF54 (Z0, A0, A1, A2, A3);

    input  A0;
    input  A1;
    input  A2;
    input  A3;


    output  Z0;

    or blk1 (Z0, A0, A1, A2, A3);

specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);
   (A2 => Z0) = (1:1:1, 1:1:1);
   (A3 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGORF55"                                                              *
*/

`timescale 100ps/10ps

module PGORF55 (Z0, A0, A1, A2, A3, A4);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;


    output  Z0;

    or blk1 (Z0, A0, A1, A2, A3, A4);

specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);
   (A2 => Z0) = (1:1:1, 1:1:1);
   (A3 => Z0) = (1:1:1, 1:1:1);
   (A4 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGORF71"                                                              *
*/

`timescale 100ps/10ps

module PGORF71 (Z0, A0);

    input  A0;

    output  Z0;

    buf  blk1  (Z0, A0);

specify

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

  endmodule

/*
* "Cell PGORF72"                                                              *
*/

`timescale 100ps/10ps

module PGORF72 (Z0, A0, A1);

    input  A0;
    input  A1;

    output  Z0;

    or  blk1 (Z0, A0, A1);


specify


    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGORF73"                                                              *
*/

`timescale 100ps/10ps

module PGORF73 (Z0, A0, A1, A2);

    input  A0;
    input  A1;
    input  A2;

    output  Z0;

    or blk1 (Z0, A0, A1, A2);

specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);
   (A2 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGORF74"                                                              *
*/

`timescale 100ps/10ps

module PGORF74 (Z0, A0, A1, A2, A3);

    input  A0;
    input  A1;
    input  A2;
    input  A3;


    output  Z0;

    or blk1 (Z0, A0, A1, A2, A3);

specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);
   (A2 => Z0) = (1:1:1, 1:1:1);
   (A3 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGORF75"                                                              *
*/

`timescale 100ps/10ps

module PGORF75 (Z0, A0, A1, A2, A3, A4);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;


    output  Z0;

    or blk1 (Z0, A0, A1, A2, A3, A4);

specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);
   (A2 => Z0) = (1:1:1, 1:1:1);
   (A3 => Z0) = (1:1:1, 1:1:1);
   (A4 => Z0) = (1:1:1, 1:1:1);


endspecify

endmodule

/*
* "Cell PGORF76"                                                              *
*/

`timescale 100ps/10ps

module PGORF76 (Z0, A0, A1, A2, A3, A4, A5);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;



    output  Z0;

    or blk1 (Z0, A0, A1, A2, A3, A4, A5);

specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);
   (A2 => Z0) = (1:1:1, 1:1:1);
   (A3 => Z0) = (1:1:1, 1:1:1);
   (A4 => Z0) = (1:1:1, 1:1:1);
   (A5 => Z0) = (1:1:1, 1:1:1);


endspecify

endmodule

/*
* "Cell PGORF77"                                                              *
*/

`timescale 100ps/10ps

module PGORF77 (Z0, A0, A1, A2, A3, A4, A5, A6);

    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  A4;
    input  A5;
    input  A6;




    output  Z0;

    or blk1 (Z0, A0, A1, A2, A3, A4, A5, A6);

specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);
   (A2 => Z0) = (1:1:1, 1:1:1);
   (A3 => Z0) = (1:1:1, 1:1:1);
   (A4 => Z0) = (1:1:1, 1:1:1);
   (A5 => Z0) = (1:1:1, 1:1:1);
   (A6 => Z0) = (1:1:1, 1:1:1);



endspecify

endmodule

/*
* "Cell PGORFB1"                                                              *
*/

`timescale 100ps/10ps

module PGORFB1 (Z0, A0);

    input  A0;

    output  Z0;

    buf  blk1  (Z0, A0);

specify

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

  endmodule

/*
* "Cell PGORFB2"                                                              *
*/

`timescale 100ps/10ps

module PGORFB2 (Z0, A0, A1);

    input  A0;
    input  A1;

    output  Z0;

    or  blk1 (Z0, A0, A1);


specify


    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGORFB3"                                                              *
*/

`timescale 100ps/10ps

module PGORFB3 (Z0, A0, A1, A2);

    input  A0;
    input  A1;
    input  A2;

    output  Z0;

    or blk1 (Z0, A0, A1, A2);

specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);
   (A2 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule

/*
* "Cell PGORFB4"                                                              *
*/

`timescale 100ps/10ps

module PGORFB4 (Z0, A0, A1, A2, A3);

    input  A0;
    input  A1;
    input  A2;
    input  A3;


    output  Z0;

    or blk1 (Z0, A0, A1, A2, A3);

specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);
   (A2 => Z0) = (1:1:1, 1:1:1);
   (A3 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PGORFBO1.v
"                                                               *
*/

`timescale 100ps/10ps

module  PGORFBO1 (Z0, A0);
    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule

/*
* "Cell PGORFBO2"                                                               *
*/

`timescale 100ps/10ps

module PGORFBO2 (Z0, A0, A1);

    input  A0;
    input  A1;

    output  Z0;

    or  blk1  (Z0, A0, A1);



specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);



endspecify

endmodule

/*
* "Cell PGORFBO3"                                                               *
*/

`timescale 100ps/10ps

module PGORFBO3 (Z0, A0, A1, A2);

    input  A0;
    input  A1;
    input  A2;

    output  Z0;

    or  blk1  (Z0, A0, A1, A2);



specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);
   (A2 => Z0) = (1:1:1, 1:1:1);



endspecify

endmodule

/*
* "Cell PGORFBO4"                                                               *
*/

`timescale 100ps/10ps

module PGORFBO4 (Z0, A0, A1, A2, A3);

    input  A0;
    input  A1;
    input  A2;
    input  A3;

    output  Z0;

    or  blk1  (Z0, A0, A1, A2, A3);



specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);
   (A2 => Z0) = (1:1:1, 1:1:1);
   (A3 => Z0) = (1:1:1, 1:1:1);


endspecify

endmodule

/*
* "Cell PGORG1"                                                               *
*/

`timescale 100ps/10ps

module PGORG1 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);

specify


    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */


endspecify


endmodule

/*
* "Cell PGORG2"                                                               *
*/

`timescale 100ps/10ps

module PGORG2 (Z0, A0, A1);

    input  A0;
    input  A1;

    output  Z0;

    or  blk1  (Z0, A0, A1);



specify

   (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   (A1 => Z0) = (1:1:1, 1:1:1);



endspecify

endmodule
`timescale 100ps/10ps

module PGORG3 (Z0, A0, A1, A2);

    input  A0;
    input  A1;
    input  A2;

    output  Z0;



    or blk1 (Z0, A0, A1, A2);


specify
	(A0 => Z0) = (1:1:1, 1:1:1);
	(A1 => Z0) = (1:1:1, 1:1:1);
	(A2 => Z0) = (1:1:1, 1:1:1);
endspecify
endmodule

/*
* "Cell PGORG4"                                                               *
*/

`timescale 100ps/10ps

module PGORG4 (Z0, A0, A1, A2, A3);

    input  A0;
    input  A1;
    input  A2;
    input  A3;

    output  Z0;

    or blk1  (Z0, A0, A1, A2, A3);

specify
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);
    (A2 => Z0) = (1:1:1, 1:1:1);
    (A3 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/************** 
     PGTRI    *
 **************/

`timescale 100ps/10ps

module PGTRI (XO0, A0, OE);

    input  A0;
    input  OE;

    output  XO0;

 bufif1 blk1 (XO0, A0, OE );

specify
    //module path declarations
     (A0 => XO0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
     (OE => XO0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
endspecify

endmodule

/*
* "Cell PGXOR2"                                                               *
*/

`timescale 100ps/10ps

module PGXOR2 (Z0, A0, A1);

    input  A0;
    input  A1;

    output  Z0;

    xor blk1  (Z0, A0, A1);


specify
    //module path declarations

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);


endspecify


endmodule
/*
* "Cell PKBUFG1"                                                               *
*/

`timescale 100ps/10ps

module PKBUFG1 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PKBUFG2"                                                               *
*/

`timescale 100ps/10ps

module PKBUFG2 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PKBUFX0"                                                               *
*/

`timescale 100ps/10ps

module PKBUFX0 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PKBUFX1"                                                               *
*/

`timescale 100ps/10ps

module PKBUFX1 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule

/*
* "Cell PKIN0"                                                              *
*/

`timescale 100ps/10ps

module PKIN0 (Z0, XI0);

    input XI0;

    output  Z0;

    buf  blk1  (Z0, XI0);

specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

  endmodule

/*
* "Cell PKIN1"                                                                *
*/

`timescale 100ps/10ps

module PKIN1 (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1 (Z0, XI0);

specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */


endspecify

endmodule

/*
* "Cell PKIN2"                                                                *
*/

`timescale 100ps/10ps

module PKIN2 (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1 (Z0, XI0);

specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */


endspecify

endmodule

/*
* "Cell PKIN3"                                                                *
*/

`timescale 100ps/10ps

module PKIN3 (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1 (Z0, XI0);

specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */


endspecify

endmodule

/*
* "Cell PKIN4"                                                                *
*/

`timescale 100ps/10ps

module PKIN4 (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1 (Z0, XI0);

specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */


endspecify

endmodule

/*
* "Cell PKIN5"                                                                *
*/

`timescale 100ps/10ps

module PKIN5 (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1 (Z0, XI0);

specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */


endspecify

endmodule

/*
* "Cell PKIN6"                                                                *
*/

`timescale 100ps/10ps

module PKIN6 (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1 (Z0, XI0);

specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */


endspecify

endmodule

/*
* "Cell PKIN7"                                                                *
*/

`timescale 100ps/10ps

module PKIN7 (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1 (Z0, XI0);

specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */


endspecify

endmodule
/*
* "Cell PRBUFB"                                                               *
*/

`timescale 100ps/10ps

module PRBUFB (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFD1"                                                               *
*/

`timescale 100ps/10ps

module PRBUFD1 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFD2"                                                               *
*/

`timescale 100ps/10ps

module PRBUFD2 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFD3"                                                               *
*/

`timescale 100ps/10ps

module PRBUFD3 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFD4"                                                               *
*/

`timescale 100ps/10ps

module PRBUFD4 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFD5"                                                               *
*/

`timescale 100ps/10ps

module PRBUFD5 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFD6"                                                               *
*/

`timescale 100ps/10ps

module PRBUFD6 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFD7"                                                               *
*/

`timescale 100ps/10ps

module PRBUFD7 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFD8"                                                               *
*/

`timescale 100ps/10ps

module PRBUFD8 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE1"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE1 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE10"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE10 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE11"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE11 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE12"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE12 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE13"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE13 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE14"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE14 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE15"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE15 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE16"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE16 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE17"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE17 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE18"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE18 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE19"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE19 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE2"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE2 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE20"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE20 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE21"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE21 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE22"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE22 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE23"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE23 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE24"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE24 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE25"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE25 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE26"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE26 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE27"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE27 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE28"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE28 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE29"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE29 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE3"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE3 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE30"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE30 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE31"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE31 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE32"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE32 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE4"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE4 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE5"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE5 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE6"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE6 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE7"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE7 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE8"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE8 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFE9"                                                               *
*/

`timescale 100ps/10ps

module PRBUFE9 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFG1.v"                                                               *
*/

`timescale 100ps/10ps

module PRBUFG1 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFG2.v"                                                               *
*/

`timescale 100ps/10ps

module PRBUFG2 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFG3.v"                                                               *
*/

`timescale 100ps/10ps

module PRBUFG3 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFG4.v"                                                               *
*/

`timescale 100ps/10ps

module PRBUFG4 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFGE.v"                                                               *
*/

`timescale 100ps/10ps

module PRBUFGE (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK1"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK1 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK10"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK10 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK11"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK11 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK12"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK12 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK13"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK13 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK14"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK14 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK15"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK15 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK16"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK16 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK17"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK17 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK18"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK18 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK19"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK19 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK2"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK2 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK20"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK20 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK21"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK21 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK22"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK22 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK23"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK23 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK24"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK24 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK25"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK25 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK26"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK26 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK27"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK27 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK28"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK28 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK29"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK29 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK3"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK3 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK30"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK30 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK31"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK31 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK32"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK32 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK33"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK33 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK34"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK34 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK35"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK35 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK36"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK36 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK37"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK37 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK38"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK38 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK39"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK39 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK4"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK4 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK40"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK40 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK41"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK41 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK42"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK42 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK43"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK43 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK44"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK44 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK45"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK45 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK46"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK46 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK47"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK47 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK48"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK48 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK5"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK5 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK6"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK6 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK7"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK7 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK8"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK8 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFK9"                                                               *
*/

`timescale 100ps/10ps

module PRBUFK9 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFL1.v"                                                               *
*/

`timescale 100ps/10ps

module PRBUFL1 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFL2.v"                                                               *
*/

`timescale 100ps/10ps

module PRBUFL2 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFL3.v"                                                               *
*/

`timescale 100ps/10ps

module PRBUFL3 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFL4.v"                                                               *
*/

`timescale 100ps/10ps

module PRBUFL4 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFL5.v"                                                               *
*/

`timescale 100ps/10ps

module PRBUFL5 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFL6.v"                                                               *
*/

`timescale 100ps/10ps

module PRBUFL6 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFL7.v"                                                               *
*/

`timescale 100ps/10ps

module PRBUFL7 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFL8.v"                                                               *
*/

`timescale 100ps/10ps

module PRBUFL8 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO1"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO1 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO10"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO10 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO11"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO11 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO12"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO12 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO13"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO13 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO14"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO14 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO15"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO15 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO16"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO16 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO17"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO17 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO18"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO18 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO19"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO19 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO2"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO2 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO20"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO20 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO21"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO21 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO22"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO22 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO23"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO23 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO24"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO24 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO25"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO25 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO26"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO26 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO27"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO27 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO28"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO28 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO29"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO29 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO3"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO3 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO30"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO30 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO31"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO31 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO32"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO32 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO33"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO33 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO34"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO34 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO35"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO35 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO36"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO36 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO37"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO37 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO38"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO38 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO39"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO39 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO4"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO4 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO40"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO40 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO41"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO41 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO42"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO42 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO43"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO43 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO44"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO44 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO45"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO45 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO46"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO46 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO47"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO47 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO48"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO48 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO5"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO5 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO6"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO6 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO7"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO7 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO8"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO8 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFO9"                                                               *
*/

`timescale 100ps/10ps

module PRBUFO9 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFQ"                                                               *
*/

`timescale 100ps/10ps

module PRBUFQ (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFT.v"                                                               *
*/

`timescale 100ps/10ps

module PRBUFT (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFX1"                                                               *
*/

`timescale 100ps/10ps

module PRBUFX1 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFX2"                                                               *
*/

`timescale 100ps/10ps

module PRBUFX2 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFX3"                                                               *
*/

`timescale 100ps/10ps

module PRBUFX3 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PRBUFX4"                                                               *
*/

`timescale 100ps/10ps

module PRBUFX4 (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PXAND2"                                                               *
*/

`timescale 100ps/10ps

module PXAND2 (Z0, A0, A1);

    input  A0;
    input  A1;

    output  Z0;


    and blk1 (Z0, A0, A1);

specify

    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
    (A1 => Z0) = (1:1:1, 1:1:1);

endspecify

endmodule
/*
* "Cell PXBUFACO.v"                                                               *
*/

`timescale 100ps/10ps

module PXBUFACO (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PXBUFE"                                                               *
*/

`timescale 100ps/10ps

module PXBUFE (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PXBUFI"                                                               *
*/

`timescale 100ps/10ps

module PXBUFI (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PXBUFK"                                                               *
*/

`timescale 100ps/10ps

module PXBUFK (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PXBUFO"                                                               *
*/

`timescale 100ps/10ps

module PXBUFO (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PXBUFQI"                                                               *
*/

`timescale 100ps/10ps

module PXBUFQI (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PXBUFT.v"                                                               *
*/

`timescale 100ps/10ps

module PXBUFT (Z0, A0);

    input  A0;

    output  Z0;

    buf blk1  (Z0, A0);


specify
    
    (A0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule


/*********************
*       PXDFF       *
**********************/

`timescale 100ps/10ps


 module PXDFF (Q0, D0, CLK);

    input    D0, CLK;

    output   Q0;
  
 //   wire RESET;

         DFF_IO inst1 (Q_int, D0, CLK,  GLOBAL.\!RESET  );
 
         buf    inst2 (Q0, Q_int);

  //  assign {RESET} = GLOBAL.\!RESET ;

`define HOLDD0	1  
`define HOLDD1	1  
`define SUD0	1
`define SUD1	1
`define NEGC0	1
`define NEGC1	1
`define POSC0	1
`define POSC1	1
`define LHCQ	1
`define HLCQ	1
`define HLRQ	1  
`define RECRC	0
`define HOLDRC	0
`define HLCLQ	0   
`define HLPDQ	0
`define HLPEQ	0
`define HOLDRCE	0
`define LHPDQ	0
`define LHPEQ	0
`define PULSEE0	0
`define PULSEE1	0
`define RECRCE	0

    specify

    specparam   ck0_to_q_param =           `LHCQ;
    specparam   ck1_to_q_param =           `HLCQ;


    specparam   reset_to_q_param =         `HLRQ;
    specparam   cd_to_q_param    =         `HLCLQ;


    specparam   D_hold0_limit_param =      `HOLDD0;
    specparam   D_hold1_limit_param =      `HOLDD1;

    specparam   R_hold_limit_param =       `HOLDRC;
 
    specparam   CLR_hold_limit_param =     `HOLDRCE;

    specparam   pose0_pulse_width_param =  `POSC0;
    specparam   pose1_pulse_width_param =  `POSC1;

    specparam   nege0_pulse_width_param =  `NEGC0;
    specparam   nege1_pulse_width_param =  `NEGC1;

    specparam   PE_pulse_width_param =     `PULSEE0;

    specparam   recovery_limit_param =     `RECRC;
    specparam   PE_recovery_limit_param =  `RECRCE;

    specparam   D_setup0_limit_param =     `SUD0;
    specparam   D_setup1_limit_param =     `SUD1;



    // Specify path delays

         (posedge CLK =>  (Q0 +: D0)) = (ck0_to_q_param, ck1_to_q_param);
   

    // Timing checks 

      $setup(D0, posedge CLK, D_setup0_limit_param);
      $hold(posedge CLK, D0, D_hold0_limit_param);
   
      $width(posedge CLK &&&  D0, pose0_pulse_width_param); 
      $width(negedge CLK &&&  D0, nege0_pulse_width_param);

      $width(posedge CLK &&&  ~D0, pose0_pulse_width_param); 
      $width(negedge CLK &&&  ~D0, nege0_pulse_width_param); 

    //  $recovery(posedge RESET, posedge CLK &&& D0, recovery_limit_param);

    endspecify

endmodule



/*********************
*       PXDFFR       *
**********************/

`timescale 100ps/10ps


 module PXDFFR (Q0, D0, CLK, RNESET);

    input    D0, CLK, RNESET;

    output   Q0;
  

         DFF_IO inst1 (Q_int, D0, CLK, RNESET);
 
         buf    inst2 (Q0, Q_int);

  
`define HOLDD0	1  
`define HOLDD1	1  
`define SUD0	1
`define SUD1	1
`define NEGC0	1
`define NEGC1	1
`define POSC0	1
`define POSC1	1
`define LHCQ	1
`define HLCQ	1
`define HLRQ	1  
`define RECRC	0
`define HOLDRC	0
`define HLCLQ	0   
`define HLPDQ	0
`define HLPEQ	0
`define HOLDRCE	0
`define LHPDQ	0
`define LHPEQ	0
`define PULSEE0	0
`define PULSEE1	0
`define RECRCE	0

    specify

    specparam   ck0_to_q_param =           `LHCQ;
    specparam   ck1_to_q_param =           `HLCQ;


    specparam   reset_to_q_param =         `HLRQ;
    specparam   cd_to_q_param    =         `HLCLQ;


    specparam   D_hold0_limit_param =      `HOLDD0;
    specparam   D_hold1_limit_param =      `HOLDD1;

    specparam   R_hold_limit_param =       `HOLDRC;
 
    specparam   CLR_hold_limit_param =     `HOLDRCE;

    specparam   pose0_pulse_width_param =  `POSC0;
    specparam   pose1_pulse_width_param =  `POSC1;

    specparam   nege0_pulse_width_param =  `NEGC0;
    specparam   nege1_pulse_width_param =  `NEGC1;

    specparam   PE_pulse_width_param =     `PULSEE0;

    specparam   recovery_limit_param =     `RECRC;
    specparam   PE_recovery_limit_param =  `RECRCE;

    specparam   D_setup0_limit_param =     `SUD0;
    specparam   D_setup1_limit_param =     `SUD1;


    // Specify path delays

    (posedge CLK =>  (Q0 +: D0)) = (ck0_to_q_param, ck1_to_q_param);
  
    (negedge RNESET =>  (Q0 +: 1'b0)) = (reset_to_q_param, reset_to_q_param);

    // Timing checks 



 
    $setup(D0, posedge CLK, D_setup0_limit_param);
    $hold(posedge CLK, D0, D_hold0_limit_param);
     
    $width(posedge CLK &&&  D0, pose0_pulse_width_param); 
    $width(negedge CLK &&&  D0, nege0_pulse_width_param);

    $width(posedge CLK &&&  ~D0, pose0_pulse_width_param); 
    $width(negedge CLK &&&  ~D0, nege0_pulse_width_param);  

    $recovery(posedge CLK, posedge RNESET, recovery_limit_param);  // Keith's hold 
    $recovery(posedge RNESET, posedge CLK, recovery_limit_param);  // after reset, 1-->Q


 

    endspecify

endmodule

/********************************
*           PXDFFRS             *
********************************/

`timescale 100ps/10ps


`celldefine

module PXDFFRS (Q0, D0, CLK, EN, CD, SD);

  input D0, CLK, CD, SD, EN;
  output Q0;


  DFFFDPGS inst1 (Q0, D0, CLK, EN, CD, SD);

  `define HOLDD0    1
  `define SUD0      1
  `define NEGC0     1
  `define NEGC1     1
  `define POSC0     1
  `define POSC1     1
  `define LHCQ      1
  `define HLCQ      1
  `define HLRQ      1
  `define LHSQ      1
  `define PULSES    1
  `define PULSER    1
  `define SUEN      1
  `define HOLDEN    1
  `define RECRC     0
  `define HOLDRC    0
  `define RECSC     0
  `define HOLDSC    0


  specify
    specparam ck0_to_q_param          =   `LHCQ;
    specparam ck1_to_q_param          =   `LHCQ;

    specparam r_to_q_param            =   `HLRQ;
    specparam s_to_q_param            =   `LHSQ;   
    
    specparam d_setup_limit_param     =   `SUD0;
    specparam d_hold_limit_param      =   `HOLDD0;

    specparam r_hold_limit_param      =   `HOLDRC;
    specparam s_hold_limit_param      =   `HOLDSC;

    specparam pose0_pulse_width_param =   `POSC0;
    specparam pose1_pulse_width_param =   `POSC1;

    specparam nege0_pulse_width_param =   `NEGC0;
    specparam nege1_pulse_width_param =   `NEGC1;

    specparam r_recovery_limit_param  =   `RECRC;
    specparam s_recovery_limit_param  =   `RECSC;

    specparam en_setup_limit_param    =   `SUEN;
    specparam en_hold_limit_param     =   `HOLDEN;

    specparam r_pulse_width_param     =   `PULSER;
    specparam s_pulse_width_param     =   `PULSES;


//  Path Delay    

    // ck1_, ck0_ order changed since PXDFFR because polarity
    (posedge CLK => (Q0 +: D0)) = (ck1_to_q_param, ck0_to_q_param);
    (posedge CD  => (Q0 +: 1'b0)) = (r_to_q_param, r_to_q_param);
    (posedge SD  => (Q0 +: 1'b1)) = (s_to_q_param, s_to_q_param);


//  Timing check

    $setup(D0, posedge CLK, d_setup_limit_param);
    $hold(posedge CLK, D0, d_hold_limit_param);

    $setup(EN, posedge CLK, en_setup_limit_param);
    $hold(posedge CLK, EN, en_hold_limit_param);

    $width(posedge CLK &&& ~D0, pose0_pulse_width_param);
    $width(negedge CLK &&& ~D0, nege0_pulse_width_param);
    // POSC1 repleases POSC0 since PXDFFR
    $width(posedge CLK &&& D0, pose1_pulse_width_param);
    $width(negedge CLK &&& D0, nege1_pulse_width_param);

    // HOLD checking used since PXDFFR
    $recovery(negedge CD, posedge CLK, r_recovery_limit_param);
    $recovery(posedge CLK, negedge CD, r_hold_limit_param);
    $recovery(negedge SD, posedge CLK, s_recovery_limit_param);
    $recovery(posedge CLK, negedge SD, s_hold_limit_param);

    //CD/SD pulse width checking appended
    $width(posedge CD, r_pulse_width_param);
    $width(posedge SD, s_pulse_width_param);
  
  endspecify

endmodule

`endcelldefine

/*******************
 *     PXDL        *
 *******************/

`timescale 100ps/10ps


`celldefine

module PXDL (Q0, D0, G);



    input   D0, G;

    output   Q0;

    D_LATCH  inst1 (Q0_int, D0, G, GLOBAL.\!RESET );


    buf  (Q0, Q0_int);



`define PXDL_HOLDD0	1 
`define PXDL_HOLDD1	1
`define PXDL_SUD0	1 
`define PXDL_SUD1	1
`define PXDL_PULSEE0	1
`define PXDL_PULSEE1	1
`define PXDL_LHPDQ0	1
`define PXDL_HLPDQ0	1  
`define PXDL_LHPEQ0	1
`define PXDL_HLPEQ0	1  
`define PXDL_HLCLQ0	1 
`define PXDL_RECRCE	0  
`define PXDL_HOLDRCE	0  
`define PXDL_HLCQ0	0
`define PXDL_HLRQ0	0
`define PXDL_HOLDRC	0
`define PXDL_LHCQ0	0
`define PXDL_NEGC0	0
`define PXDL_NEGC1	0
`define PXDL_POSC0	0
`define PXDL_POSC1	0
`define PXDL_RECRC	0



    specify

    specparam   lh_clr_to_q  =        `PXDL_HLCLQ0;
    specparam   hl_clr_to_q  =        `PXDL_HLCLQ0;
 
    specparam   pd0_to_q  =           `PXDL_LHPDQ0;
    specparam   pd1_to_q  =           `PXDL_HLPDQ0;
   
    specparam   pe0_to_q  =           `PXDL_LHPEQ0;
    specparam   pe1_to_q  =           `PXDL_HLPEQ0;
   

    specparam   PD_hold0_limit  =     `PXDL_HOLDD0;
    specparam   PD_hold1_limit  =     `PXDL_HOLDD1;

    specparam   CLR_hold_limit  =     `PXDL_HOLDRCE; 

    specparam   PE_pulse0_width  =    `PXDL_PULSEE0;
    specparam   PE_pulse1_width  =    `PXDL_PULSEE1;

    specparam   recovery_limit  =     `PXDL_RECRC;
    specparam   PE_recovery_limit  =  `PXDL_RECRCE;

    specparam   PE_setup0_limit  =    `PXDL_SUD0;
    specparam   PE_setup1_limit  =    `PXDL_SUD1;


    // Specify path delays

       (D0 +=> Q0 ) = (pd0_to_q , pd1_to_q );
      
       (posedge G =>  (Q0 +: D0)) = (pe0_to_q , pe1_to_q );
 
   
   
    // Timing checks 


    $setup(D0, negedge G, PE_setup0_limit ); 
    $hold(negedge G, D0, PD_hold0_limit );

    $width(posedge G  &&& D0, PE_pulse0_width ); 
    $width(posedge G  &&& ~D0, PE_pulse1_width ); 

 
    endspecify

endmodule
`endcelldefine

/*******************
 *     PXDLR       *
 *******************/

`timescale 100ps/10ps


`celldefine

module PXDLR (Q0, D0, G, RNESET);



    input   D0, G, RNESET;

    output   Q0;


 
    D_LATCH  inst1 (Q0_int, D0, G, RNESET);


    buf  (Q0, Q0_int);

`define PXDL_HOLDD0	1 
`define PXDL_HOLDD1	1
`define PXDL_SUD0	1 
`define PXDL_SUD1	1
`define PXDL_PULSEE0	1
`define PXDL_PULSEE1	1
`define PXDL_LHPDQ0	1
`define PXDL_HLPDQ0	1  
`define PXDL_LHPEQ0	1
`define PXDL_HLPEQ0	1  
`define PXDL_HLCLQ0	1 
`define PXDL_RECRCE	0  
`define PXDL_HOLDRCE	0  
`define PXDL_HLCQ0	0
`define PXDL_HLRQ0	0
`define PXDL_HOLDRC	0
`define PXDL_LHCQ0	0
`define PXDL_NEGC0	0
`define PXDL_NEGC1	0
`define PXDL_POSC0	0
`define PXDL_POSC1	0
`define PXDL_RECRC	0



    specify

    specparam   lh_clr_to_q  =        `PXDL_HLCLQ0;
    specparam   hl_clr_to_q  =        `PXDL_HLCLQ0;
 
    specparam   pd0_to_q  =           `PXDL_LHPDQ0;
    specparam   pd1_to_q  =           `PXDL_HLPDQ0;
   
    specparam   pe0_to_q  =           `PXDL_LHPEQ0;
    specparam   pe1_to_q  =           `PXDL_HLPEQ0;
   

    specparam   PD_hold0_limit  =     `PXDL_HOLDD0;
    specparam   PD_hold1_limit  =     `PXDL_HOLDD1;

    specparam   CLR_hold_limit  =     `PXDL_HOLDRCE; 

    specparam   PE_pulse0_width  =    `PXDL_PULSEE0;
    specparam   PE_pulse1_width  =    `PXDL_PULSEE1;

    specparam   recovery_limit  =     `PXDL_RECRC;
    specparam   PE_recovery_limit  =  `PXDL_RECRCE;

    specparam   PE_setup0_limit  =    `PXDL_SUD0;
    specparam   PE_setup1_limit  =    `PXDL_SUD1;


    // Specify path delays

        (D0 => Q0 ) = (pd0_to_q, pd1_to_q);      
        (posedge G =>  (Q0 : D0)) = (pe0_to_q, pe1_to_q);     
        (negedge RNESET =>  (Q0 : 1'b0)) = (lh_clr_to_q, hl_clr_to_q);

   
    // Timing checks 
 
    $setup(D0, negedge G, PE_setup0_limit );
    $hold (negedge G, D0, PD_hold0_limit );

    $width(posedge G  &&& D0, PE_pulse0_width ); 
    $width(posedge G  &&& ~D0, PE_pulse1_width ); 

    $recovery(posedge RNESET, negedge G, PE_recovery_limit );
    $recovery(negedge G, posedge RNESET, PE_recovery_limit );

    endspecify

endmodule
`endcelldefine
/*************************************
 *              PXDLRS               *
 ************************************/

`timescale 100ps/10ps

`celldefine

module PXDLRS (Q0, D0, G, CD, SD);

  input D0, G, CD, SD;
  output Q0;

  not blk0 (t0, CD);
  not blk1 (t1, SD);
  D_LATCH4 inst1 (Q0, D0, G, t0, t1);

  `define HOLDD0    1
  `define HOLDD1    1
  `define SUD0      1
  `define SUD1      1
  `define LHPDQ     1
  `define HLPDQ     1
  `define LHPEQ     1
  `define HLPEQ     1
  `define PULSEE0   1
  `define PULSEE1   1
  `define HLCLQ     1
  `define LHPQ      1
  `define PULSECL   1
  `define PULSEP    1
  `define RECRCE    0
  `define HOLDRCE   0
  `define RECPPE    0
  `define HOLDPPE   0

  specify
    specparam pd_hold0_limit_param     = `HOLDD0;
    specparam pd_hold1_limit_param     = `HOLDD1;

    specparam pd_setup0_limit_param    = `SUD0;
    specparam pd_setup1_limit_param    = `SUD1;

    specparam pd0_to_q_param           = `LHPDQ;
    specparam pd1_to_q_param           = `HLPDQ;

    specparam pe0_to_q_param           = `LHPEQ;
    specparam pe1_to_q_param           = `HLPEQ;

    specparam pe_pulse0_width_param    = `PULSEE0;
    specparam pe_pulse1_width_param    = `PULSEE1;

    specparam hl_clr_to_q_param        = `HLCLQ;
    specparam lh_pre_to_q_param        = `LHPQ;

    specparam clr_pulse_width_param    = `PULSECL;
    specparam pre_pulse_width_param    = `PULSEP;

    specparam clr_recovery_limit_param = `RECRCE;
    specparam pre_recovery_limit_param = `RECPPE;

    specparam clr_hold_limit_param     = `HOLDRCE;
    specparam pre_hold_limit_param     = `HOLDPPE;

    // specify the path delays

    (D0 => Q0) = (pd0_to_q_param, pd1_to_q_param);
    // += replaces = since PXDLR because polarity
    (posedge G => (Q0 +: D0)) = (pe1_to_q_param, pe0_to_q_param);
    (posedge CD => (Q0 +: 1'b0)) = (hl_clr_to_q_param, hl_clr_to_q_param);
    (posedge SD => (Q0 +: 1'b1)) = (lh_pre_to_q_param, lh_pre_to_q_param);

    // timing checking

    $setup(D0, negedge G, pd_setup0_limit_param);
    $hold(negedge G, D0, pd_hold0_limit_param);

    // modify since PXDLR for D0 polarity
    $width(posedge G &&& ~D0, pe_pulse0_width_param);
    $width(posedge G &&& D0, pe_pulse1_width_param);

    // append since PXDLR
    $width(posedge CD, clr_pulse_width_param);
    $width(posedge SD, pre_pulse_width_param);

    // HOLD checking used since PXDLR
    $recovery(negedge CD, negedge G, clr_recovery_limit_param);
    $recovery(negedge G, negedge CD, clr_hold_limit_param);
    $recovery(negedge SD, negedge G, pre_recovery_limit_param);
    $recovery(negedge G, negedge SD, pre_hold_limit_param);

  endspecify

endmodule
`endcelldefine

/*
* "Cell PXIN"                                                                 *
*/

`timescale 100ps/10ps

module PXIN (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1 (Z0, XI0);


specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

endmodule

/*
* "Cell PXIND"                                                                 *
*/

`timescale 100ps/10ps

module PXIND (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1 (Z0, XI0);


specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

endmodule
/*
* "Cell PXINE"                                                               *
*/

`timescale 100ps/10ps

module PXINE (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1  (Z0, XI0);


specify
    
    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule

/*
* "Cell PXINK"                                                                 *
*/

`timescale 100ps/10ps

module PXINK (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1 (Z0, XI0);


specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

endmodule

/*
* "Cell PXINR"                                                                 *
*/

`timescale 100ps/10ps

module PXINR (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1 (Z0, XI0);


specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

endmodule

/*
* "Cell PXINRG"                                                                 *
*/

`timescale 100ps/10ps

module PXINRG (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1 (Z0, XI0);


specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

endmodule

/*
* "Cell PXINRX"                                                                 *
*/

`timescale 100ps/10ps

module PXINRX (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1 (Z0, XI0);


specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

endmodule
/*
* "Cell PXINT"                                                               *
*/

`timescale 100ps/10ps

module PXINT (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1  (Z0, XI0);


specify
    
    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule

/*
* "Cell PXINVE"                                                               *
*/

`timescale 100ps/10ps

module PXINVE (ZN0, A0);

    input  A0;

    output  ZN0;

    not blk1  (ZN0, A0);

specify

    (A0 => ZN0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */


endspecify


endmodule

/*
* "Cell PXINVK"                                                               *
*/

`timescale 100ps/10ps

module PXINVK (ZN0, A0);

    input  A0;

    output  ZN0;

    not blk1  (ZN0, A0);

specify

    (A0 => ZN0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */


endspecify


endmodule

/*
* "Cell PXINVO"                                                               *
*/

`timescale 100ps/10ps

module PXINVO (ZN0, A0);

    input  A0;

    output  ZN0;

    not blk1  (ZN0, A0);

specify

    (A0 => ZN0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */


endspecify


endmodule
/*
* "Cell PXOUT"                                                               *
*/

`timescale 100ps/10ps

module PXOUT (XO0, A0);

    input  A0;

    output  XO0;

    buf blk1  (XO0, A0);


specify
    
    (A0 => XO0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PXOUTS"                                                               *
*/

`timescale 100ps/10ps

module PXOUTS (XO0, A0);

    input  A0;

    output  XO0;

    buf blk1  (XO0, A0);


specify
    
    (A0 => XO0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
   
endspecify
endmodule
/*
* "Cell PXTRI"                                                                *
*/

`timescale 100ps/10ps

module PXTRI (XO0, A0, OE);

    input  A0;
    input  OE;

    output  XO0;

 bufif1 blk1 (XO0, A0, OE );

  


specify
    //module path declarations
   
     (A0 => XO0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
     (OE => XO0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
endspecify

endmodule
/*
* "Cell PXTRIS"                                                                *
*/

`timescale 100ps/10ps

module PXTRIS (XO0, A0, OE);

    input  A0;
    input  OE;

    output  XO0;

    bufif1 blk1 (XO0, A0, OE );


specify
    //module path declarations
   
     (A0 => XO0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
     (OE => XO0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
endspecify

endmodule
/*
* "Cell XBIDI1"                                                                *
*/

`timescale 100ps/10ps

module XBIDI1 (Z0, XB0, A0, OE);

    input  OE, A0;

    inout  XB0;
    
    output Z0;
    
    

    buf    blk0 (Z0, XB0);
    bufif1 blk1 (XB0, A0, OE );
    

specify
    //module path declarations
   
     (A0  => XB0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
     (OE  => XB0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
     (XB0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

endmodule

/*
* "Cell XINPUT"                                                                 *
*/

`timescale 100ps/10ps

module XINPUT (Z0, XI0);

    input  XI0;

    output  Z0;

    buf blk1 (Z0, XI0);


specify

    (XI0 => Z0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

endmodule

/*
* "Cell XINV"                                                                 *
*/

`timescale 100ps/10ps


module XINV (ZN0, A0);


    input  A0;

    output  ZN0;

    not blk1 (ZN0, A0);


specify

    (A0 => ZN0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

endmodule

/*
* "Cell XOUTPUT"                                                                 *
*/

`timescale 100ps/10ps


module XOUTPUT (XO0, A0);


    input  A0;

    output  XO0;

    buf blk1 (XO0, A0);


specify

    (A0 => XO0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */

endspecify

endmodule
/*
* "Cell XTRI1"                                                                *
*/

`timescale 100ps/10ps

module XTRI1 (XO0, A0, OE);

    input  A0;
    input  OE;

    output  XO0;


    bufif1 blk1 (XO0, A0, OE );



specify
    //module path declarations
   
     (A0 => XO0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
     (OE => XO0) = (1:1:1, 1:1:1); /* min:nom:max Low to High */
 


endspecify

endmodule

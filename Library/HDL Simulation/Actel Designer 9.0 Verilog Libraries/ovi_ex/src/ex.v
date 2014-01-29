

 /********************************************************************

        Actel FPGA ex family Verilog simulation library

        NAME: ex.v
        DATE: Friday April 8, 2005 

 *********************************************************************/




`timescale 1 ns / 100 ps

//----------------------------------------------------------------------
//---             VERILOG LIBRRAY PRIMITIVE SECTION                     
//----------------------------------------------------------------------

 
//--------------------------------------------------------------------
//-                    cell  U_MAJ_3.v                                  -
//--------------------------------------------------------------------

primitive       U_MAJ_3 (Y, A, B, C);
        output Y;
        input  A, B, C;

        table
        //      A       B       C       :       Y

                0       0       ?       :       0       ;
                0       ?       0       :       0       ;
                ?       0       0       :       0       ;
                ?       1       1       :       1       ;
                1       ?       1       :       1       ;
                1       1       ?       :       1       ;

        endtable
endprimitive



 //---------------------------------------------------------------------
 // primitibe module (Dffpr) state table definition
 // FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
 //            ASYNCHRONOUS SET AND CLEAR. CLR PRIORITY WHEN BOTH
 //            SET AND CLEAR ARE LOW ( Q OUTPUT UDP ).
 //            Enable active low.

 //----------------------------------------------------------------------
primitive Dffpr (Q, D, CLK, CLR, PRE, E, NOTIFIER_REG);
  output Q;
  input  NOTIFIER_REG;
  input  D, CLK, E, CLR, PRE;
  reg Q;

	table
         //  D   CLK   CLR  PRE   E  NOTIFIER_REG  :   Qt  :  Qt+1

            1   (01)    1   1    0      ?         :   ?   :   1;  // clocked data
            0   (01)    1   1    0      ?         :   ?   :   0;  // clocked data
            1   (01)    1   1    x      ?         :   1   :   1;  // clocked data
            0   (01)    1   1    x      ?         :   0   :   0;
            0   (01)    1   1    x      ?         :   1   :   x;
            1   (01)    1   1    x      ?         :   0   :   x;
            0   (01)    x   1    0      ?         :   ?   :   0;  // pessimism
            1   (01)    1   x    0      ?         :   ?   :   1;  // pessimism
            ?    ?      1   x    ?      ?         :   1   :   1;  // pessimism
            0    ?      1   x    ?      ?         :   x   :   x;  // pessimism
            ?    ?      1   x    ?      ?         :   0   :   x;
            ?    ?      x   x    ?      ?         :   ?   :   x;
            ?    ?      x   0    ?      ?         :   ?   :   x;
            ?    ?      x   1    ?      ?         :   0   :   0;
            ?    ?      x   1    ?      ?         :   1   :   x;
            ?    ?      0   ?    ?      ?         :   ?   :   0;
            ?    ?      1   0    ?      ?         :   ?   :   1;
            1   (x1)    1   1    0      ?         :   1   :   1;  // reducing pessimism
            0   (x1)    1   1    0      ?         :   0   :   0;
            1   (0x)    1   1    0      ?         :   1   :   1;
     0   (0x)    1   1    0      ?         :   0   :   0;
            1   (x1)    1   1    x      ?         :   1   :   1;  // reducing pessimism
            0   (x1)    1   1    x      ?         :   0   :   0;
            1   (0x)    1   1    x      ?         :   1   :   1;
            0   (0x)    1   1    x      ?         :   0   :   0;
            ?  (?1)     1   1    1      ?         :   ?   :   -;  //no action for CE = 1
            ?  (0x)     1   1    1      ?         :   ?   :   -;  //no action for CE = 1
            ?   ?       ?   ?    *      ?         :   ?   :   -;
            ?   (?0)    ?   ?    ?      ?         :   ?   :   -;  // ignore falling clock
            ?   (1x)    ?   ?    ?      ?         :   ?   :   -;  // ignore falling clock
            *    ?      ?   ?    ?      ?         :   ?   :   -;  // ignore data edges
            ?   ?     (?1)  ?    ?      ?         :   ?   :   -;  // ignore the edges on
            ?   ?       ?  (?1)  ?      ?         :   ?   :   -;  //       set and clear
            ?   ?       ?   ?    ?      *         :   ?   :   x;


	endtable
 endprimitive


 //---------------------------------------------------------------------
 // primitibe module (Dffpf) logic table definition
 // FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
 //            ASYNCHRONOUS SET AND CLEAR. CLR PRIORITY WHEN BOTH
 //            SET AND CLEAR ARE LOW ( Q OUTPUT UDP ).
 //            Enable active low.

 //----------------------------------------------------------------------
primitive Dffpf (Q, D, CLK, CLR, PRE, E, NOTIFIER_REG);
  output Q;
  input  NOTIFIER_REG;
  input  D, CLK, E, CLR, PRE;
  reg Q;

 table

//    D   CLK     CLR PRE  E  NOTIFIER_REG  :   Qt  :  Qt+1	
	     1   (10)    1   1    0      ?         :   ?   :   1;  // clocked data
	     0   (10)    1   1    0      ?         :   ?   :   0;  // clocked data
	     1   (10)    1   1    x      ?         :   1   :   1;  // clocked data
	     0   (10)    1   1    x      ?         :   0   :   0;
	     0   (10)    1   x    x      ?         :   1   :   1;
	     0   (10)    1   1    x      ?         :   1   :   x;
	     1   (10)    1   1    x      ?         :   0   :   x;
	     0   (10)    1   x    0      ?         :   1   :   1;
	     0   (10)    x   1    0      ?         :   ?   :   0;
	     1   (10)    1   ?    0      ?         :   ?   :   1;  // pessimism
	     1    ?      1   x    0      ?         :   1   :   1;  // pessimism
	     ?    ?      1   x    ?      ?         :   0   :   x;
	     0    1      1   x    0      ?         :   1   :   1;  // pessimism
	     0    x      1 (?x)   0      ?         :   1   :   1;  // pessimism
	     0    ?      1 (?x)   0      ?         :   1   :   1;  // baoxian
	     0    ?      x   1    ?      ?         :   0   :   0;
	     0    ?      x   0    ?      ?         :   ?   :   x;
	     0    ?      x   1    ?      ?         :   1   :   x;
	     x    1      1   x    0      ?         :   1   :   1;  // pessimism
	     x    x      1 (?x)   0      ?         :   1   :   1;  // pessimism
	     x    0      1   x    0      ?         :   1   :   1;  // pessimism
	     1    ?      1   x    x      ?         :   1   :   1;  // pessimism
	     0    1      1   x    x      ?         :   1   :   1;  // pessimism
	     0    x      1 (?x)   x      ?         :   1   :   1;  // pessimism
	     0    0      1 (?x)   x      ?         :   1   :   1;  // pessimism
	     x    1      1   x    x      ?         :   1   :   1;  // pessimism
	     x    ?      1   x    x      ?         :   1   :   1;  // pessimism
	     1    0      x   1    0      ?         :   0   :   0;  // pessimism
	     1    x    (?x)  1    0      ?         :   0   :   0;  // pessimism
	     1    1    (?x)  1    0      ?         :   0   :   0;  // pessimism
	     x    0      x   1    0      ?         :   0   :   0;  // pessimism
	     x    x    (?x)  1    0      ?         :   0   :   0;  // pessimism
	     x    1    (?x)  1    0      ?         :   0   :   0;  // pessimism
	     1    0      x   1    x      ?         :   0   :   0;  // pessimism
	     1    x    (?x)  1    x      ?         :   0   :   0;  // pessimism
	     1    1    (?x)  1    x      ?         :   0   :   0;  // pessimism
	     x    0      x   1    x      ?         :   0   :   0;  // pessimism
	     x    x    (?x)  1    x      ?         :   0   :   0;  // pessimism
	     x    1    (?x)  1    x      ?         :   0   :   0;  // pessimism
	     1   (1x)    1   1    0      ?         :   1   :   1;  // reducing pessimism
	     0   (1x)    1   1    0      ?         :   0   :   0;
	     1   (x0)    1   1    0      ?         :   1   :   1;
	     0   (x0)    1   1    0      ?         :   0   :   0;
	     1   (1x)    1   1    x      ?         :   1   :   1;  // reducing pessimism
	     0   (1x)    1   1    x      ?         :   0   :   0;
	     1   (x0)    1   1    x      ?         :   1   :   1;
	     0   (x0)    1   1    x      ?         :   0   :   0;
	     ?   ?       0   1    ?      ?         :   ?   :   0;  // asynchronous clear
	     ?   ?       1   0    ?      ?         :   ?   :   1;  // asynchronous set
	     ?  (?0)     1   1    1      ?         :   ?   :   -;  //no action for CE = 1
	     ?  (1x)     1   1    1      ?         :   ?   :   -;  //no action for CE = 1
	     ?   (?0)    x   1    1      ?         :   0   :   0;  // chip is not enabled pessimism with reset
	     ?   (1x)    x   1    1      ?         :   0   :   0;  // chip is not enabled pessimism with reset
	     ?    ?    (?x)  1    1      ?         :   0   :   0;  // chip is not enabled pessimism with reset
	     ?   (?0)    1   x    1      ?         :   1   :   1;  // chip is not enabled pessimism with reset
	     ?   (1x)    1   x    1      ?         :   1   :   1;  // chip is not enabled pessimism with reset
	     ?    ?      1  (?x)  1      ?         :   1   :   1;  // chip is not enabled pessimism with reset
	     ?   ?       ?   ?    *      ?         :   ?   :   -;
	     ?   (?1)    ?   ?    ?      ?         :   ?   :   -;  // ignore falling clock
	     ?   (0x)    ?   ?    ?      ?         :   ?   :   -;  // ignore falling clock
	     *    ?      ?   ?    ?      ?         :   ?   :   -;  // ignore data edges
	     ?   ?     (?1)  ?    ?      ?         :   ?   :   -;  // ignore the edges on
	     ?   ?       ?  (?1)  ?      ?         :   ?   :   -;  //       set and clear
	     ?   ?       0   0    ?      ?         :   ?   :   0; // CLR Priority (added 0n 11/12/97)
	     ?   ?       0   x    ?      ?         :   ?   :   0; // CLR Priority (added 0n 11/12/97)
	     ?   ?       ?   ?    ?      *         :   ?   :   x;
	endtable
 endprimitive

//--------------------------------------------------------------------
//-                    cell  UFPRB.v                                  -
//--------------------------------------------------------------------

primitive UFPRB (Q, D, CP, RB, NOTIFIER_REG);

    output Q;
    input  NOTIFIER_REG,
           D, CP, RB;
    reg    Q;

// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR ( Q OUTPUT UDP ).

    table
    //  D   CP      RB     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    1         ?          :   ?   :   1;  // clocked data
        0   (01)    1         ?          :   ?   :   0;

        0   (01)    x         ?          :   ?   :   0;  // pessimism
        0    ?      x         ?          :   0   :   0;  // pessimism

        1    0      x         ?          :   0   :   0;  // pessimism
        1    x    (?x)        ?          :   0   :   0;  // pessimism
        1    1    (?x)        ?          :   0   :   0;  // pessimism
        x    0      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    1    (?x)        ?          :   0   :   0;  // pessimism
        1   (x1)    1         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    1         ?          :   0   :   0;
        1   (0x)    1         ?          :   1   :   1;
        0   (0x)    1         ?          :   0   :   0;
        ?   ?       0         ?          :   ?   :   0;  // asynchronous clear
        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data
        ?    ?    (?1)        ?          :   ?   :   -;  // ignore the edges on clear
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

//------------------------------------------------------------------------
// primitive DL2C_UDP functional description
// FUNCTION : NEGATIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE HIGH
//            ASYNCHRONOUS SET AND RESET.
//-------------------------------------------------------------------------

primitive DL2C_UDP (q, d, g, c, p, NOTIFIER_REG);

 output q;
 input  d,              // DATA
        g,              // CLOCK
        c,              // CLEAR ACTIVE HIGH
        p,              // SET ACTIVE HIGH
        NOTIFIER_REG;

 reg q;

    table
    //  D     G     C     P  NOTIFIER_REG  :   Qt  :   Qt+1
        ?     ?     1     ?     ?          :   ?   :   0;  // active low clear
        ?     ?     0     1     ?          :   ?   :   1;  // active high preset

        ?     1     0     0     ?          :   ?   :   -;  // latch
        0     0     0     0     ?          :   ?   :   0;  // transparent

        0     0     x     0     ?          :   ?   :   0;  // CLR==x
        ?     1     x     0     ?          :   0   :   0;  // CLR==x
        0     x     ?     0     ?          :   0   :   0;  // CLR,G==x

        1     x     0     ?     ?          :   1   :   1;  // PRE==x/?,G==x
        1     0     0     ?     ?          :   ?   :   1;  // PRE==x/?
        ?     1     0     x     ?          :   1   :   1;  // PRE==x
    endtable


endprimitive

//--------------------------------------------------------------------------
// primitive DLE3B_UDP
// FUNCTION : D LATCH WITH DUAL CLOCK INPUTS ACTIVE HIGH ASYNCHRONOUS PRESET.
//            TWO CLOCKS: E G
//-------------------------------------------------------------------------

primitive DLE3B_UDP (q, d, g, e, p, NOTIFIER_REG);

 output q;
 input  d,              // DATA
        g,              // CLOCK
        e,              // CLEAR ACTIVE HIGH
        p,              // SET ACTIVE HIGH
        NOTIFIER_REG;

 reg    q;

    table
    //  D     G     E     P  NOTIFIER_REG  :   Qt  :   Qt+1
        ?     ?     ?     1     ?          :   ?   :   1;  // active high preset

        ?     1     ?     0     ?          :   ?   :   -;  // latch
        ?     ?     1     0     ?          :   ?   :   -;  // latch

        1     0     0     0     ?          :   ?   :   1;  // transparent
        0     0     0     0     ?          :   ?   :   0;  // transparent

        1     x     ?     0     ?          :   1   :   1;  // o/p mux pessimism
        1     ?     x     0     ?          :   1   :   1;  // o/p mux pessimism
        0     x     ?     0     ?          :   0   :   0;  // o/p mux pessimism
        0     ?     x     0     ?          :   0   :   0;  // o/p mux pessimism

        1     0     0     x     ?          :   ?   :   1;  // PRE==x
        ?     1     ?     x     ?          :   1   :   1;  // PRE==x
        ?     ?     1     x     ?          :   1   :   1;  // PRE==x
        1     0     x     x     ?          :   1   :   1;  // PRE==x
        1     x     0     x     ?          :   1   :   1;  // PRE==x
        1     x     x     x     ?          :   1   :   1;  // PRE==x
    endtable

endprimitive

//--------------------------------------------------------------------------
// primitive DLE2B_UDP
// FUNCTION : D LATCH WITH DUAL CLOCK INPUTS ACTIVE HIGH ASYNCHRONOUS CLEAR.
//            TWO CLOCKS: E G
//-------------------------------------------------------------------------

primitive DLE2B_UDP (q, d, e, g, c, NOTIFIER_REG);

 output q;
 input  d,              // DATA
        e,              // CLOCK
        g,              // CLOCK
        c,              // CLEAR ACTIVE HIGH
        NOTIFIER_REG;

 reg    q;

    table
    //  D     E     G     C  NOTIFIER_REG  :   Qt  :   Qt+1
        ?     ?     ?     0     ?          :   ?   :   0;  // active low clear

        ?     ?     1     1     ?          :   ?   :   -;  // latch
        ?     1     ?     1     ?          :   ?   :   -;  // latch

        1     0     0     1     ?          :   ?   :   1;  // transparent
        0     0     0     1     ?          :   ?   :   0;  // transparent

        0     ?     ?     1     ?          :   0   :   0;  // o/p mux pessimism
        1     ?     ?     1     ?          :   1   :   1;  // o/p mux pessimism

        0     ?     ?     x     ?          :   0   :   0;  // CLR==x, o/p mux pessimism
        ?     ?     1     x     ?          :   0   :   0;  // PRE==x, o/p mux pessimism, latch
        ?     1     ?     x     ?          :   0   :   0;  // PRE==x, o/p mux pessimism, latch
        0     0     0     x     ?          :   ?   :   0;  // PRE==x, o/p mux pessimism
    endtable

endprimitive

//--------------------------------------------------------------------
//-                 primitive  JKFFF  -- falling edge                -
//--------------------------------------------------------------------

primitive JKFFF (Q, J, K, CP, RB, SB, NOTIFIER_REG);
    output Q;
    reg    Q; 
    input  NOTIFIER_REG,
           J,K,
            CP,                                  // Clock.
            RB,                                  // Clear input
            SB;                                  // Set input
// FUNCTION :NEGATIVE EDGE TRIGGERED JK FLIP FLOP, WITH ACTIVE LOW
//           ASYNCHRONOUS CLEAR AND  SET
//           OUTPUT GOES TO X WHEN BOTH CLEAR AND SET ARE ACTIVE
    table
      // J   K   CP  RB   SB       NOTIFIER_REG  : Qtn : Qtn+1
         0   1  (10) 1    1           ?          :  ?  :   - ;    // Output retains the
         0   0  (10) 1    1           ?          :  ?  :   0 ;    // Clocked J and K.
         0   0  (10) x    1           ?          :  ?  :   0 ;    // pessimism
         ?   ?   ?   x    1           ?          :  0  :   0 ;    // pessimism
         1   1  (10) 1    1           ?          :  ?  :   1 ;
         1   1  (10) 1    x           ?          :  ?  :   1 ;    // pessimism
         ?   ?   ?   1    x           ?          :  1  :   1 ;    // pessimis
         1   0  (10) 1    1           ?          :  0  :   1 ;    // Clocked toggle.
         1   0  (10) 1    1           ?          :  1  :   0 ;
         ?   0  (10) x    1           ?          :  1  :   0 ;    //pessimism
         1   ?  (10) 1    x           ?          :  0  :   1 ;
         0   1  (1x) 1    1           ?          :  ?  :   - ;    //possible clocked JK
         0   0  (1x) 1    1           ?          :  0  :   0 ;
         1   1  (1x) 1    1           ?          :  1  :   1 ;
         0   1  (x0) 1    1           ?          :  ?  :   - ;
         0   0  (x0) 1    1           ?          :  0  :   0 ;
         1   1  (x0) 1    1           ?          :  1  :   1 ;
         *   ?   ?   1    1           ?          :  ?  :   - ;    // Insensitive to
         ?   *   ?   1    1           ?          :  ?  :   - ;    // transitions on J and K
         ?   ?   ?   0    1           ?          :  ?  :   0 ;    // Clear
         ?   ?   ?   1    0           ?          :  ?  :   1 ;    // Set.
         ?   ?   ?   0    0           ?          :  ?  :   x ;    // ILLEGAL
         x   1   f   1    1           ?          :  1  :   1 ;
         x   0   f   1    1           ?          :  1  :   0 ;
         0   x   f   1    1           ?          :  0  :   0 ;
         1   x   f   1    1           ?          :  0  :   1 ;
         x   1 (1x)  1    1           ?          :  1  :   1 ;    //possible clocked with
         0   x (1x)  1    1           ?          :  0  :   0 ;    //possible J & K
         x   1 (x0)  1    1           ?          :  1  :   1 ;
         0   x (x0)  1    1           ?          :  0  :   0 ;
         ?   ? (?1)  ?    ?           ?          :  ?  :   - ;
         ?   ? (0x)  ?    ?           ?          :  ?  :   - ;
         ?   ?   ? (?1)   1           ?          :  ?  :   - ;    //ignore changes on set and
         ?   ?   ?   1  (?1)          ?          :  ?  :   - ;    //reset.
         ?   ?   ?   ?    ?           *          :  ?  :   x ;
    endtable
endprimitive

//--------------------------------------------------------------------
//-                   primitive  JKFFR                                -
//--------------------------------------------------------------------
primitive JKFFR (Q, J, K, CP, RB, SB, NOTIFIER_REG);
    output Q;
    reg    Q; 
    input  NOTIFIER_REG,
           J,K,
           CP,                                  // Clock.
           RB,                                  // Clear input
           SB;                                  // Set input
// FUNCTION :POSITIVE EDGE TRIGGERED JK FLIP FLOP, WITH ACTIVE LOW
//           ASYNCHRONOUS CLEAR AND  SET
//           OUTPUT GOES TO x WHEN BOTH CLEAR AND SET ARE ACTIVE
    table
      // J   K  CP  RB   SB        NOTIFIER_REG  : Qtn : Qtn+1
         0   1  (01) 1    1           ?          :  ?  :   - ;    // Output retains the
         0   0  (01) 1    1           ?          :  ?  :   0 ;    // Clocked J and K.
         0   0  (01) x    1           ?          :  ?  :   0 ;    // pessimism
         ?   ?   ?   x    1           ?          :  0  :   0 ;    // pessimism
         1   1  (01) 1    1           ?          :  ?  :   1 ;
         1   1  (01) 1    x           ?          :  ?  :   1 ;    // pessimism
         ?   ?   ?   1    x           ?          :  1  :   1 ;    // pessimism
         1   0  (01) 1    1           ?          :  0  :   1 ;    // Clocked toggle.
         1   0  (01) 1    1           ?          :  1  :   0 ;
         ?   0  (01) x    1           ?          :  1  :   0 ;     //pessimism
         1   ?  (01) 1    x           ?          :  0  :   1 ;
         0   1  (x1) 1    1           ?          :  ?  :   - ;   //possible clocked JK
         0   0  (x1) 1    1           ?          :  0  :   0 ;
         1   1  (x1) 1    1           ?          :  1  :   1 ;
         0   1  (0x) 1    1           ?          :  ?  :   - ;
         0   0  (0x) 1    1           ?          :  0  :   0 ;
         1   1  (0x) 1    1           ?          :  1  :   1 ;
         *   ?   ?   1    1           ?          :  ?  :   - ;    // Insensitive to
         ?   *   ?   1    1           ?          :  ?  :   - ;    // transitions on J and K
         ?   ?   ?   0    1           ?          :  ?  :   0 ;    // Clear
         ?   ?   ?   1    0           ?          :  ?  :   1 ;    // Set.
         ?   ?   ?   0    0           ?          :  ?  :   x ;    // ILLEGAL
         x   1   r   1    1           ?          :  1  :   1 ;
         x   0   r   1    1           ?          :  1  :   0 ;
         0   x   r   1    1           ?          :  0  :   0 ;
         1   x   r   1    1           ?          :  0  :   1 ;
         x   1 (x1)  1    1           ?          :  1  :   1 ;        //possible clocked with
         0   x (x1)  1    1           ?          :  0  :   0 ;        //possible J & K
         x   1 (0x)  1    1           ?          :  1  :   1 ;
         0   x (0x)  1    1           ?          :  0  :   0 ;
         ?   ? (?0)  1    1           ?          :  ?  :   - ;    //ignore falling clock.
         ?   ? (1x)  1    1           ?          :  ?  :   - ;
         ?   ?   ? (?1)   1           ?          :  ?  :   - ;    //ignore changes on set and
         ?   ?   ?   1  (?1)          ?          :  ?  :   - ;    //reset.
         ?   ?   ?   ?    ?           *          :  ?  :   x ;
    endtable
endprimitive
 // --------------------------------------------------------------------
 // 2-1 MUX  primitive   
 // FUNCTION : when select signal S= 1, A will be selected, S= 0, B will 
 //            be selected; when S=X, if A=B, A will be selected, if A!=B,
 //            X will be the output!
 // --------------------------------------------------------------------
primitive UDP_MUX2 (Q, A, B, SL);
output Q;
input A, B, SL;

// FUNCTION :  TWO TO ONE MULTIPLEXER

    table
    //  A   B   SL  :   Q
        0   0   ?   :   0 ;
        1   1   ?   :   1 ;

        0   ?   1   :   0 ;
        1   ?   1   :   1 ;

        ?   0   0   :   0 ;
        ?   1   0   :   1 ;

    endtable
endprimitive

primitive UDPN_MUX2 (Q, A, B, SL);
output Q;
input A, B, SL;

// FUNCTION :  TWO TO ONE MULTIPLEXER

    table
    //  A   B   SL  :   Q
        0   0   ?   :   1 ;
        1   1   ?   :   0 ;

        0   ?   1   :   1 ;
        1   ?   1   :   0 ;

        ?   0   0   :   1 ;
        ?   1   0   :   0 ;

    endtable
endprimitive


//---------------  END OF VERILOG PRIMITIVE SECTION --------------------

primitive CMA9_primitive (Y, D0,DB, D3,S01,S11);
output Y;
input D0,DB, D3,S01,S11;


	table
	// D0   DB   D3   S01  S11 :       Y
	   ?    0    ?    0    ?  :       1;
	   ?    1    ?    ?    1  :       0;
	   ?    0    0    1    ?  :       0;
	   1    1    ?    ?    0  :       1;
	   1    ?    1    ?    0  :       1;
	   ?    0    1    ?    ?  :       1;
	   0    1    ?    ?    ?  :       0;
	   0    ?    0    1    ?  :       0;
	   1    ?    ?    0    0  :       1;
	   ?    ?    0    1    1  :       0;

	endtable
endprimitive

primitive CMAF_primitive (Y, D0, D2,  D3, DB, S01, S11);
output Y;
input D0, D2,  D3, DB, S01, S11;


	table
	// D0   D2   D3   DB   S01  S11       Y
	   0    0    0     ?    ?    ? :    0;
	   1    1    1     ?    ?    ? :    1;
	   0    0    ?     ?    0    0 :    0;
	   1    1    ?     ?    0    0 :    1;
	   0    0    ?     1    ?    ? :    0;
	   1    1    ?     1    ?    ? :    1;
	   0    0    ?     ?    0    ? :    0;
	   1    1    ?     ?    0    ? :    1;
	   ?    0    0     ?    1    1 :    0;
	   ?    1    1     ?    1    1 :    1;
	   ?    0    0     0    ?    ? :    0;
	   ?    1    1     0    ?    ? :    1;
	   ?    0    0     ?    ?    1 :    0;
	   ?    1    1     ?    ?    1 :    1;
	   0    ?    0     ?    1    0 :    0;
	   1    ?    1     ?    1    0 :    1;
	   ?    0    ?     0    0    ? :    0;
	   ?    1    ?     0    0    ? :    1;
	   ?    0    ?     1    ?    1 :    0;
	   ?    1    ?     1    ?    1 :    1;
	   ?    0    ?     ?    0    1 :    0;
	   ?    1    ?     ?    0    1 :    1;
	   ?    ?    0     0    1    ? :    0;
	   ?    ?    1     0    1    ? :    1;
	   0    ?    ?     1    ?    0 :    0;
	   1    ?    ?     1    ?    0 :     1;

	endtable
endprimitive

primitive CMB7_primitive (Y, D0, D1, D2, DB, S00, S01, S11);
output Y;
input D0, D1, D2, DB, S00, S01, S11;


   table
	//D0   D1   D2   DB   S00  S01  S11          Y
	  0    0    0    1    ?    ?    ?  :       0;
	  ?    ?    1    0    ?    ?    ?  :      1;
	  ?    0    ?    1    1    1    0  :      0;
	  ?    1    ?    ?    1    1    0  :      1;
	  0    ?    ?    1    0    ?    0  :      0;
	  0    ?    ?    1    ?    0    0  :      0;
	  1    ?    ?    1    0    ?    0  :      1;
	  1    ?    ?    1    ?    0    0  :      1;
	  ?    ?    ?    1    1    1    1  :      0;
	  ?    ?    ?    0    1    1    ?  :      1;
	  ?    ?    0    0    0    ?    ?  :      0;
	  ?    ?    0    0    ?    0    ?  :      0;
	  ?    ?    0    ?    0    ?    1  :      0;
	  ?    ?    0    ?    ?    0    1  :      0;
	  0    ?    0    ?    0    ?    ?  :      0;
	  0    ?    0    ?    ?    0    ?  :      0;
	  1    ?    1    ?    0    ?    ?  :      1;
	  1    ?    1    ?    ?    0    ?  :      1;
	  ?    ?    1    ?    0    ?    1  :      1;
	  ?    ?    1    ?    ?    0    1  :      1;
	  ?    0    ?    1    1    1    ?  :      0;
	  0    0    ?    1    ?    ?    0  :      0;
	  1    1    ?    1    ?    ?    0  :      1;
	  ?    ?    0    1    ?    ?    1  :      0;
	  1    1    1    ?    ?    ?    0  :      1;

	endtable
endprimitive

primitive CMBB_primitive (Y, D0,D1,DB,D3,S00,S01,S11);
output Y;
input D0,D1,DB,D3,S00,S01,S11;


	table
// D0   D1   DB   D3   S00  S01  S11          Y
	0    0    1    0    ?    ?    ? :        0;
	?    ?    0    1    ?    ?    ? :       1;
	?    ?    0    ?    ?    0    ? :       1;
	?    ?    1    ?    ?    0    1 :       0;
	?    ?    0    ?    0    ?    ? :       1;
	?    ?    1    ?    0    ?    1 :       0;
	0    ?    1    ?    ?    0    0 :       0;
	1    ?    ?    ?    ?    0    0 :       1;
	0    ?    1    ?    0    ?    0 :       0;
	1    ?    ?    ?    0    ?    0 :       1;
	?    0    1    ?    1    1    0 :       0;
	?    1    1    ?    1    1    0 :       1;
	?    ?    ?    0    1    1    1 :       0;
	?    ?    ?    1    1    1    1 :       1;
	?    ?    0    0    1    1    ? :       0;
	?    ?    1    0    ?    ?    1 :       0;
	?    0    ?    0    1    1    ? :       0;
	?    1    ?    1    1    1    ? :       1;
	0    ?    1    ?    0    ?    ? :       0;
	0    0    1    ?    ?    ?    0 :       0;
	1    1    1    ?    ?    ?    0 :       1;
	0    ?    1    ?    ?    0    ? :       0;
	1    1    ?    1    ?    ?    0 :       1;

	endtable
endprimitive

primitive CMEA_primitive (Y, DB,D1,D3,S01,S10,S11);
output Y;
input DB,D1,D3,S01,S10,S11;


	table
// DB   D1   D3   S01  S10  S11          Y
	1     ?    ?    ?   ?    ? :       0;
	0     1    1    ?   ?    ? :       1;
	?     0    ?    1   0    0 :       0;
	0     1    ?    ?   0    0 :       1;
	?     ?    0    1   1    ? :       0;
	?     ?    0    1   ?    1 :       0;
	0     ?    ?    0   ?    ? :       1;
	?     0    0    1   ?    ? :       0;
	0     ?    1    ?   1    ? :       1;
	0     ?    1    ?   ?    1 :       1;

   endtable
endprimitive

primitive CMEB_primitive (Y,D0,D1,DB,D3,S01,S10,S11);
output Y;
input D0,D1,DB,D3,S01,S10,S11;


   table
	// D0   D1   DB   D3   S01  S10  S11          Y
	0   0   1   0   ?   ?   ? :        0;
	1   1   0   1   ?   ?   ? :       1;
	0   ?   ?   ?   0   0   0 :       0;
	1   ?   ?   ?   0   0   0 :       1;
	0   ?   1   ?   ?   0   0 :       0;
	1   ?   1   ?   ?   0   0 :       1;
	?   ?   0   1   1   1   ? :       1;
	?   ?   0   1   1   ?   1 :       1;
	?   0   0   ?   1   0   0 :       0;
	?   1   0   ?   1   0   0 :       1;
	?   ?   ?   0   1   1   ? :       0;
	?   ?   ?   0   1   ?   1 :       0;
	?   ?   1   ?   ?   1   ? :       0;
	?   ?   1   ?   ?   ?   1 :       0;
	?   ?   0   ?   0   1   ? :       1;
	?   0   0   0   1   ?   ? :       0;
	?   1   0   1   1   ?   ? :       1;
	0   0   ?   ?   ?   0   0 :       0;
	1   1   ?   ?   ?   0   0 :       1;
	0   ?   1   ?   ?   ?   ? :       0;
	1   ?   0   ?   0   ?   ? :       1;
	?   ?   0   1   ?   1   ? :       1;
	?   ?   0   1   ?   ?   1 :       1;
	?   ?   0   ?   0   ?   1 :       1;
	0   0   ?   0   1   ?   ? :       0;

	endtable
endprimitive

primitive CMEE_primitive (Y,DB, D1, D2, D3, S01,S10, S11);
output Y;
input DB, D1, D2, D3, S01,S10, S11;


   table
	//DB   D1   D2   D3   S01  S10  S11          Y
	1 0 0 0 ? ? ? :       0;
	0 1 1 1 ? ? ? :       1;
	? 0 ? ? 1 0 0 :       0;
	0 1 ? ? 1 0 0 :       1;
	0 ? ? 0 1 1 ? :       0;
	0 ? ? 1 1 1 ? :       1;
	0 ? ? 0 1 ? 1 :       0;
	0 ? ? 1 1 ? 1 :       1;
	1 ? ? ? ? 0 0 :       0;
	0 ? ? ? 0 0 0 :       1;
	? ? 0 ? 0 ? 1 :       0;
	? ? 1 ? 0 ? 1 :       1;
	? ? 0 ? 0 1 ? :       0;
	? ? 1 ? 0 1 ? :       1;
	1 ? 0 ? ? ? 1 :       0;
	1 ? 1 ? ? ? 1 :       1;
	1 ? 0 ? ? 1 ? :       0;
	1 ? 1 ? ? 1 ? :       1;
	1 ? 0 ? ? ? ? :       0;
	0 ? 1 ? 0 ? ? :       1;
	? ? 0 0 ? 1 ? :       0;
	? ? 1 1 ? 1 ? :       1;
	? ? 0 0 ? ? 1 :       0;
	0 0 ? 0 1 ? ? :       0;
	0 1 ? 1 1 ? ? :       1;
	? ? 1 1 ? ? 1 :       1;
	0 1 ? ? ? 0 0 :       1;
	? 0 0 0 1 ? ? :       0;

   endtable
endprimitive




/*--------------------------------------------------------------------
 CELL NAME : AND2
 CELL TYPE : comb
 CELL LOGIC : Y = A & B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND2(Y,A,B);
 input A,B;
 output Y;

 and      U2(Y, A, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND2A
 CELL TYPE : comb
 CELL LOGIC : Y = !A & B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND2A(Y,A,B);
 input A,B;
 output Y;

 not	INV_0(A_, A);
 and      U5(Y, A_, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND2B
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND2B(Y,A,B);
 input A,B;
 output Y;

 not	INV_1(A_, A);
 not	INV_2(B_, B);
 and      U8(Y, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND3
 CELL TYPE : comb
 CELL LOGIC : Y = A & B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 and      U12(NET_0_0, A, B);
 and      U13(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND3A
 CELL TYPE : comb
 CELL LOGIC : Y = !A & B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND3A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_3(A_, A);
 and      U17(NET_0_0, A_, B);
 and      U18(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND3B
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND3B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_4(A_, A);
 not	INV_5(B_, B);
 and      U22(NET_0_0, A_, B_);
 and      U23(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND3C
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND3C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_6(A_, A);
 not	INV_7(B_, B);
 not	INV_8(C_, C);
 and      U27(NET_0_0, A_, B_);
 and      U28(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND4
 CELL TYPE : comb
 CELL LOGIC : Y = A & B & C & D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND4(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 and      U33(NET_0_0, A, B);
 and      U34(NET_0_1, NET_0_0, C);
 and      U35(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND4A
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & B & C & D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND4A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_9(A_, A);
 and      U40(NET_0_0, A_, B);
 and      U41(NET_0_1, NET_0_0, C);
 and      U42(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND4B
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B & C & D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND4B(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_10(A_, A);
 not	INV_11(B_, B);
 and      U47(NET_0_0, A_, B_);
 and      U48(NET_0_1, NET_0_0, C);
 and      U49(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND4C
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B & !C & D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND4C(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_12(A_, A);
 not	INV_13(B_, B);
 not	INV_14(C_, C);
 and      U54(NET_0_0, A_, B_);
 and      U55(NET_0_1, NET_0_0, C_);
 and      U56(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND4D
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B & !C & !D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND4D(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_15(A_, A);
 not	INV_16(B_, B);
 not	INV_17(C_, C);
 not	INV_18(D_, D);
 and      U61(NET_0_0, A_, B_);
 and      U62(NET_0_1, NET_0_0, C_);
 and      U63(Y, NET_0_1, D_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND5A
 CELL TYPE : comb
 CELL LOGIC : Y = !A & B & C & D & E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND5A(Y,A,B,C,D,E);
 input A,B,C,D,E;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 not	INV_19(A_, A);
 and      U69(NET_0_0, A_, B);
 and      U70(NET_0_1, NET_0_0, C);
 and      U71(NET_0_2, NET_0_1, D);
 and      U72(Y, NET_0_2, E);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_E_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_E_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
		(E => Y ) = ( tpdLH_E_to_Y, tpdHL_E_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND5B
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B & C & D & E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND5B(Y,A,B,C,D,E);
 input A,B,C,D,E;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 not	INV_20(A_, A);
 not	INV_21(B_, B);
 and      U78(NET_0_0, A_, B_);
 and      U79(NET_0_1, NET_0_0, C);
 and      U80(NET_0_2, NET_0_1, D);
 and      U81(Y, NET_0_2, E);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_E_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_E_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
		(E => Y ) = ( tpdLH_E_to_Y, tpdHL_E_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AND5C
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B & !C & D & E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AND5C(Y,A,B,C,D,E);
 input A,B,C,D,E;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 not	INV_22(A_, A);
 not	INV_23(B_, B);
 not	INV_24(C_, C);
 and      U87(NET_0_0, A_, B_);
 and      U88(NET_0_1, NET_0_0, C_);
 and      U89(NET_0_2, NET_0_1, D);
 and      U90(Y, NET_0_2, E);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_E_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_E_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
		(E => Y ) = ( tpdLH_E_to_Y, tpdHL_E_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO1
 CELL TYPE : comb
 CELL LOGIC : Y = (A & B) + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 and      U94(NET_0_0, A, B);
 or       U95(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO10
 CELL TYPE : comb
 CELL LOGIC : Y = ((A & B) + C) & (D + E)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO10(Y,A,B,C,D,E);
 input A,B,C,D,E;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 and      U100(NET_0_0, A, B);
 or       U101(NET_0_1, NET_0_0, C);
 and      U102(Y, NET_0_1, NET_0_2);
 or       U104(NET_0_2, D, E);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_E_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_E_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
		(E => Y ) = ( tpdLH_E_to_Y, tpdHL_E_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO11
 CELL TYPE : comb
 CELL LOGIC : Y = (A & B) + ((A + B) & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO11(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 and      U108(NET_0_0, A, B);
 or       U109(Y, NET_0_0, NET_0_2);
 or       U112(NET_0_1, A, B);
 and      U113(NET_0_2, NET_0_1, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO12
 CELL TYPE : comb
 CELL LOGIC : Y = !A & B + !A & !C + A & !B & C + B & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO12(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_25(A_, A);
 not	INV_26(B_, B);
 not	INV_27(C_, C);
 UDP_MUX2   U117(NET_0_5, B, NET_0_3, C_);
 and      U120(NET_0_3, A, B_);
 or       U121(Y, NET_0_5, NET_0_2);
 and      U124(NET_0_0, A_, B);
 or       U125(NET_0_2, NET_0_0, NET_0_1);
 and      U127(NET_0_1, A_, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO13
 CELL TYPE : comb
 CELL LOGIC : Y = A & B + A & !C + B & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO13(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_28(C_, C);
 and      U132(NET_0_0, A, B);
 or       U133(NET_0_2, NET_0_0, NET_0_1);
 and      U135(NET_0_1, A, C_);
 or       U136(Y, NET_0_2, NET_0_3);
 and      U138(NET_0_3, B, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO14
 CELL TYPE : comb
 CELL LOGIC : Y = A & B + A & !C + B & !C + !A & !B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO14(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_29(A_, A);
 not	INV_30(B_, B);
 not	INV_31(C_, C);
 and      U143(NET_0_5, A_, B_);
 UDP_MUX2   U144(NET_0_4, NET_0_5, B, C);
 or       U146(Y, NET_0_4, NET_0_2);
 and      U149(NET_0_0, A, B);
 or       U150(NET_0_2, NET_0_0, NET_0_1);
 and      U152(NET_0_1, A, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO15
 CELL TYPE : comb
 CELL LOGIC : Y = A & !B & C + !A & B & C + !A & !B & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO15(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_32(A_, A);
 not	INV_33(B_, B);
 not	INV_34(C_, C);
 and      U157(NET_0_0, A, B_);
 UDP_MUX2   U158(NET_0_4, NET_0_0, NET_0_5, C);
 and      U161(NET_0_5, A_, B_);
 or       U162(Y, NET_0_4, NET_0_3);
 and      U165(NET_0_2, A_, B);
 and      U166(NET_0_3, NET_0_2, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO16
 CELL TYPE : comb
 CELL LOGIC : Y = A & B & !C + !A & !B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO16(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_35(A_, A);
 not	INV_36(B_, B);
 not	INV_37(C_, C);
 and      U170(NET_0_0, A, B);
 UDP_MUX2   U171(Y, NET_0_0, NET_0_2, C_);
 and      U174(NET_0_2, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO17
 CELL TYPE : comb
 CELL LOGIC : Y = A & B & C + !A & B & !C + !A & !B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO17(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_38(A_, A);
 not	INV_39(B_, B);
 not	INV_40(C_, C);
 and      U179(NET_0_5, A_, B_);
 UDP_MUX2   U180(NET_0_4, NET_0_5, NET_0_2, C);
 and      U183(NET_0_2, A_, B);
 or       U184(Y, NET_0_4, NET_0_1);
 and      U187(NET_0_0, A, B);
 and      U188(NET_0_1, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO18
 CELL TYPE : comb
 CELL LOGIC : Y = !A & B + !A & !C + B & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO18(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_41(A_, A);
 not	INV_42(C_, C);
 and      U193(NET_0_0, A_, B);
 or       U194(NET_0_2, NET_0_0, NET_0_1);
 and      U196(NET_0_1, A_, C_);
 or       U197(Y, NET_0_2, NET_0_3);
 and      U199(NET_0_3, B, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO1A
 CELL TYPE : comb
 CELL LOGIC : Y = !A & B + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO1A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_43(A_, A);
 and      U203(NET_0_0, A_, B);
 or       U204(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO1B
 CELL TYPE : comb
 CELL LOGIC : Y = A & B + !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO1B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_44(C_, C);
 and      U208(NET_0_0, A, B);
 or       U209(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO1C
 CELL TYPE : comb
 CELL LOGIC : Y = !A & B + !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO1C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_45(A_, A);
 not	INV_46(C_, C);
 and      U213(NET_0_0, A_, B);
 or       U214(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO1D
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO1D(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_47(A_, A);
 not	INV_48(B_, B);
 and      U218(NET_0_0, A_, B_);
 or       U219(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO1E
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B + !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO1E(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_49(A_, A);
 not	INV_50(B_, B);
 not	INV_51(C_, C);
 and      U223(NET_0_0, A_, B_);
 or       U224(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO2
 CELL TYPE : comb
 CELL LOGIC : Y = ((A & B) + C + D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO2(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 and      U229(NET_0_0, A, B);
 or       U230(NET_0_1, NET_0_0, C);
 or       U231(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO2A
 CELL TYPE : comb
 CELL LOGIC : Y = ((!A & B) + C + D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO2A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_52(A_, A);
 and      U236(NET_0_0, A_, B);
 or       U237(NET_0_1, NET_0_0, C);
 or       U238(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO2B
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B + C + D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO2B(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_53(A_, A);
 not	INV_54(B_, B);
 and      U243(NET_0_0, A_, B_);
 or       U244(NET_0_1, NET_0_0, C);
 or       U245(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO2C
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & B) + !C + D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO2C(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_55(A_, A);
 not	INV_56(C_, C);
 and      U250(NET_0_0, A_, B);
 or       U251(NET_0_1, NET_0_0, C_);
 or       U252(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO2D
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B + !C + D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO2D(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_57(A_, A);
 not	INV_58(B_, B);
 not	INV_59(C_, C);
 and      U257(NET_0_0, A_, B_);
 or       U258(NET_0_1, NET_0_0, C_);
 or       U259(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO2E
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B + !C + !D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO2E(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_60(A_, A);
 not	INV_61(B_, B);
 not	INV_62(C_, C);
 not	INV_63(D_, D);
 and      U264(NET_0_0, A_, B_);
 or       U265(NET_0_1, NET_0_0, C_);
 or       U266(Y, NET_0_1, D_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO3
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & B & C) + D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO3(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_64(A_, A);
 and      U271(NET_0_0, A_, B);
 and      U272(NET_0_1, NET_0_0, C);
 or       U273(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO3A
 CELL TYPE : comb
 CELL LOGIC : Y = (A & B & C) + D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO3A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 and      U278(NET_0_0, A, B);
 and      U279(NET_0_1, NET_0_0, C);
 or       U280(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO3B
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & !B & C) + D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO3B(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_65(A_, A);
 not	INV_66(B_, B);
 and      U285(NET_0_0, A_, B_);
 and      U286(NET_0_1, NET_0_0, C);
 or       U287(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO3C
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & !B & !C) + D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO3C(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_67(A_, A);
 not	INV_68(B_, B);
 not	INV_69(C_, C);
 and      U292(NET_0_0, A_, B_);
 and      U293(NET_0_1, NET_0_0, C_);
 or       U294(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO4A
 CELL TYPE : comb
 CELL LOGIC : Y = !A & (B & C) + A & (C & D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO4A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_70(A_, A);
 and      U298(NET_0_0, B, C);
 UDP_MUX2   U299(Y, NET_0_0, NET_0_2, A_);
 and      U302(NET_0_2, C, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO5A
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & B) + (A & C) + D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO5A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 not	INV_71(A_, A);
 UDP_MUX2   U306(NET_0_2, B, C, A_);
 or       U308(Y, NET_0_2, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO6
 CELL TYPE : comb
 CELL LOGIC : Y = A & B + C & D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO6(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 and      U312(NET_0_0, A, B);
 or       U313(Y, NET_0_0, NET_0_1);
 and      U315(NET_0_1, C, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO6A
 CELL TYPE : comb
 CELL LOGIC : Y = A & B + C & !D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO6A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_72(D_, D);
 and      U319(NET_0_0, A, B);
 or       U320(Y, NET_0_0, NET_0_1);
 and      U322(NET_0_1, C, D_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO7
 CELL TYPE : comb
 CELL LOGIC : Y = A & B & C + D + E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO7(Y,A,B,C,D,E);
 input A,B,C,D,E;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 and      U328(NET_0_0, A, B);
 and      U329(NET_0_1, NET_0_0, C);
 or       U330(NET_0_2, NET_0_1, D);
 or       U331(Y, NET_0_2, E);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_E_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_E_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
		(E => Y ) = ( tpdLH_E_to_Y, tpdHL_E_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO8
 CELL TYPE : comb
 CELL LOGIC : Y = A & B + !C & !D + E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO8(Y,A,B,C,D,E);
 input A,B,C,D,E;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 not	INV_73(C_, C);
 not	INV_74(D_, D);
 and      U336(NET_0_0, A, B);
 or       U337(NET_0_2, NET_0_0, NET_0_1);
 and      U339(NET_0_1, C_, D_);
 or       U340(Y, NET_0_2, E);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_E_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_E_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
		(E => Y ) = ( tpdLH_E_to_Y, tpdHL_E_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AO9
 CELL TYPE : comb
 CELL LOGIC : Y = A & B + C + D + E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AO9(Y,A,B,C,D,E);
 input A,B,C,D,E;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 and      U346(NET_0_0, A, B);
 or       U347(NET_0_1, NET_0_0, C);
 or       U348(NET_0_2, NET_0_1, D);
 or       U349(Y, NET_0_2, E);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_E_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_E_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
		(E => Y ) = ( tpdLH_E_to_Y, tpdHL_E_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI1
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B + C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 and      U353(NET_0_0, A, B);
 nor      U354(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI1A
 CELL TYPE : comb
 CELL LOGIC : Y = !((!A & B) + C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI1A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_75(A_, A);
 and      U358(NET_0_0, A_, B);
 nor      U359(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI1B
 CELL TYPE : comb
 CELL LOGIC : Y = !((A & B) + !C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI1B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_76(C_, C);
 and      U363(NET_0_0, A, B);
 nor      U364(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI1C
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B + C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI1C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_77(A_, A);
 not	INV_78(B_, B);
 and      U368(NET_0_0, A_, B_);
 nor      U369(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI1D
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B + !C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI1D(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_79(A_, A);
 not	INV_80(B_, B);
 not	INV_81(C_, C);
 and      U373(NET_0_0, A_, B_);
 nor      U374(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI2A
 CELL TYPE : comb
 CELL LOGIC : Y = !((!A & B) + C + D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI2A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_82(A_, A);
 and      U379(NET_0_0, A_, B);
 or       U380(NET_0_1, NET_0_0, C);
 nor      U381(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI2B
 CELL TYPE : comb
 CELL LOGIC : Y = !((!A & B) + !C + D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI2B(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_83(A_, A);
 not	INV_84(C_, C);
 and      U386(NET_0_0, A_, B);
 or       U387(NET_0_1, NET_0_0, C_);
 nor      U388(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI3A
 CELL TYPE : comb
 CELL LOGIC : Y = (A + B + C) & (A + D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI3A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 or       U393(NET_0_0, A, B);
 or       U394(NET_0_1, NET_0_0, C);
 and      U395(Y, NET_0_1, NET_0_2);
 or       U397(NET_0_2, A, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI4
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B+C & D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI4(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 and      U401(NET_0_0, A, B);
 nor      U402(Y, NET_0_0, NET_0_1);
 and      U404(NET_0_1, C, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI4A
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B + !C & D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI4A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_85(C_, C);
 and      U408(NET_0_0, A, B);
 nor      U409(Y, NET_0_0, NET_0_1);
 and      U411(NET_0_1, C_, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AOI5
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & B & C + A & !B & !C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AOI5(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_86(A_, A);
 not	INV_87(B_, B);
 not	INV_88(C_, C);
 and      U415(NET_0_0, A_, B);
 UDPN_MUX2  U416(Y, NET_0_0, NET_0_2, C);
 and      U419(NET_0_2, A, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AX1
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & B) ^ C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AX1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_89(A_, A);
 and      U423(NET_0_0, A_, B);
 xor      U424(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AX1A
 CELL TYPE : comb
 CELL LOGIC : Y = !((!A & B) ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AX1A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_90(A_, A);
 and      U428(NET_0_0, A_, B);
 xnor     U429(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AX1B
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & !B) ^ C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AX1B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_91(A_, A);
 not	INV_92(B_, B);
 and      U433(NET_0_0, A_, B_);
 xor      U434(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AX1C
 CELL TYPE : comb
 CELL LOGIC : Y = (A & B) ^ C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AX1C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 and      U438(NET_0_0, A, B);
 xor      U439(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AX1D
 CELL TYPE : comb
 CELL LOGIC : Y = !((!A & !B) ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AX1D(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_93(A_, A);
 not	INV_94(B_, B);
 and      U443(NET_0_0, A_, B_);
 xnor     U444(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AX1E
 CELL TYPE : comb
 CELL LOGIC : Y = !((A & B) ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AX1E(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 and      U448(NET_0_0, A, B);
 xnor     U449(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXO1
 CELL TYPE : comb
 CELL LOGIC : Y = A & B + (B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXO1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_95(B_, B);
 not	INV_96(C_, C);
 and      U453(NET_0_1_XOR_REXT, B, C_);
 or       U454(Y, NET_0_1_XOR_REXT, NET_0_1);
 UDP_MUX2   U456(NET_0_1, C, A, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXO2
 CELL TYPE : comb
 CELL LOGIC : Y = !A & B + (B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXO2(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_97(A_, A);
 not	INV_98(B_, B);
 not	INV_99(C_, C);
 and      U461(NET_0_1_XOR_REXT, B, C_);
 or       U462(Y, NET_0_1_XOR_REXT, NET_0_1);
 UDP_MUX2   U464(NET_0_1, C, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXO3
 CELL TYPE : comb
 CELL LOGIC : Y = A & !B + (B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXO3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_100(B_, B);
 not	INV_101(C_, C);
 and      U469(NET_0_1_XOR_LEXT, B_, C);
 or       U470(Y, NET_0_1_XOR_LEXT, NET_0_1);
 UDP_MUX2   U472(NET_0_1, A, C_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXO5
 CELL TYPE : comb
 CELL LOGIC : Y =  !A & B + (!B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXO5(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_102(A_, A);
 not	INV_103(B_, B);
 not	INV_104(C_, C);
 and      U477(NET_0_1_XOR_LEXT, B, C);
 or       U478(Y, NET_0_1_XOR_LEXT, NET_0_1);
 UDP_MUX2   U480(NET_0_1, A_, C_, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXO6
 CELL TYPE : comb
 CELL LOGIC : Y =  A & !B + (!B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXO6(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_105(B_, B);
 not	INV_106(C_, C);
 and      U485(NET_0_1_XOR_REXT, B_, C_);
 or       U486(Y, NET_0_1_XOR_REXT, NET_0_1);
 UDP_MUX2   U488(NET_0_1, C, A, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXO7
 CELL TYPE : comb
 CELL LOGIC : Y =  !A & !B + (B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXO7(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_107(A_, A);
 not	INV_108(B_, B);
 not	INV_109(C_, C);
 and      U493(NET_0_1_XOR_LEXT, B_, C);
 or       U494(Y, NET_0_1_XOR_LEXT, NET_0_1);
 UDP_MUX2   U496(NET_0_1, A_, C_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXOI1
 CELL TYPE : comb
 CELL LOGIC : Y =  !(A & B + (B ^ C))
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXOI1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_110(B_, B);
 not	INV_111(C_, C);
 and      U501(NET_0_1_XOR_REXT, B, C_);
 nor      U502(Y, NET_0_1_XOR_REXT, NET_0_1);
 UDP_MUX2   U504(NET_0_1, C, A, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXOI2
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & B + (B ^ C))
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXOI2(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_112(A_, A);
 not	INV_113(B_, B);
 not	INV_114(C_, C);
 and      U509(NET_0_1_XOR_REXT, B, C_);
 nor      U510(Y, NET_0_1_XOR_REXT, NET_0_1);
 UDP_MUX2   U512(NET_0_1, C, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXOI3
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & !B + (B ^ C))
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXOI3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_115(B_, B);
 not	INV_116(C_, C);
 and      U517(NET_0_1_XOR_LEXT, B_, C);
 nor      U518(Y, NET_0_1_XOR_LEXT, NET_0_1);
 UDP_MUX2   U520(NET_0_1, A, C_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXOI4
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B + (!B ^ C))
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXOI4(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_117(B_, B);
 not	INV_118(C_, C);
 and      U525(NET_0_1_XOR_LEXT, B, C);
 nor      U526(Y, NET_0_1_XOR_LEXT, NET_0_1);
 UDP_MUX2   U528(NET_0_1, A, C_, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXOI5
 CELL TYPE : comb
 CELL LOGIC : Y =  !(!A & B + (!B ^ C))
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXOI5(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_119(A_, A);
 not	INV_120(B_, B);
 not	INV_121(C_, C);
 and      U533(NET_0_1_XOR_LEXT, B, C);
 nor      U534(Y, NET_0_1_XOR_LEXT, NET_0_1);
 UDP_MUX2   U536(NET_0_1, A_, C_, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : AXOI7
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B + (B ^ C))
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module AXOI7(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_122(A_, A);
 not	INV_123(B_, B);
 not	INV_124(C_, C);
 and      U541(NET_0_1_XOR_LEXT, B_, C);
 nor      U542(Y, NET_0_1_XOR_LEXT, NET_0_1);
 UDP_MUX2   U544(NET_0_1, A_, C_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BIBUF
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E ; Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BIBUF(Y,D,E,PAD);
 input D,E;
 output Y;
 inout PAD;

 bufif1   U548(PAD, D, E);
 buf	BUF_U_01(Y,PAD);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if(~D)
                (E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
		(D => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(E => Y ) = (0.1:0.1:0.1, 0.1:0.1:0.1);
		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BUFA
 CELL TYPE : comb
 CELL LOGIC : Y = A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BUFA(Y,A);
 input A;
 output Y;

 buf	BUF_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BUFD
 CELL TYPE : comb
 CELL LOGIC : Y = A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BUFD(Y,A);
 input A;
 output Y;

 buf	BUF_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : BUFF
 CELL TYPE : comb
 CELL LOGIC : Y = A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module BUFF(Y,A);
 input A;
 output Y;

 buf	BUF_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CLKBUF
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CLKBUF(Y,PAD);
 input PAD;
 output Y;

 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );
       endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CLKBUFI
 CELL TYPE : comb
 CELL LOGIC : Y=!PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CLKBUFI(Y,PAD);
 input PAD;
 output Y;

 not	INV_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CLKINT
 CELL TYPE : comb
 CELL LOGIC : Y = A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CLKINT(Y,A);
 input A;
 output Y;

 buf	BUF_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CLKINTI
 CELL TYPE : comb
 CELL LOGIC : Y = !A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CLKINTI(Y,A);
 input A;
 output Y;

 not	INV_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CM7
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !S0 + D1 & S0) & !(S10+S11) + (D2 & !S0 + D3 & S0) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CM7(Y,D0,S0,D1,S10,S11,D2,D3);
 input D0,S0,D1,S10,S11,D2,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9;

 not	INV_125(S0_, S0);
 UDP_MUX2   U552(NET_0_2, D0, D1, S0_);
 UDP_MUX2   U554(Y, NET_0_2, NET_0_7, NET_0_3);
 nor      U556(NET_0_3, S10, S11);
 UDP_MUX2   U559(NET_0_7, D2, D3, S0_);

       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S0 => Y ) = ( tpdLH_S0_to_Y, tpdHL_S0_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CM8
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !(S00 & S01) + D1 & (S00 & S01)) & !(S10+S11) + (D2 & !(S00 & S01) + D3 & (S00 & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CM8(Y,D0,S00,S01,D1,S10,S11,D2,D3);
 input D0,S00,S01,D1,S10,S11,D2,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;

 UDP_MUX2   U564(NET_0_4, D0, D1, NET_0_0);
 nand     U566(NET_0_0, S00, S01);
 UDP_MUX2   U568(Y, NET_0_4, NET_0_11, NET_0_5);
 nor      U570(NET_0_5, S10, S11);
 UDP_MUX2   U573(NET_0_11, D2, D3, NET_0_7);
 nand     U575(NET_0_7, S00, S01);

       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CM8INV
 CELL TYPE : comb
 CELL LOGIC : Y = !A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CM8INV(Y,A);
 input A;
 output Y;

 not	INV_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMA9
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !(!DB & S01) + !DB & (!DB & S01)) & !(!DB+S11) + (!DB & !(!DB & S01) + D3 & (!DB & S01)) & (!DB+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMA9(Y,D0,DB,S01,S11,D3);
 input D0,DB,S01,S11,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;


	CMA9_primitive U_CMA9(Y, D0,   DB,   D3,   S01,  S11);


       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMAF
 CELL TYPE : comb
 CELL LOGIC : Y = D0 & (DB & !S11) + (D2 & !(!DB & S01) + D3 & (!DB & S01)) & (!DB+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMAF(Y,D0,DB,S11,D2,S01,D3);
 input D0,DB,S11,D2,S01,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8;


	CMAF_primitive U_CM9A(Y, D0,D2, D3,  DB, S01, S11);


       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMB3
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !(S00 & S01) + D1 & (S00 & S01)) & !(!DB+S11) + (!DB & !(S00 & S01) + !DB & (S00 & S01)) & (!DB+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMB3(Y,D0,S00,S01,D1,DB,S11);
 input D0,S00,S01,D1,DB,S11;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;

 not	INV_126(DB_, DB);
 UDP_MUX2   U580(NET_0_4, D0, D1, NET_0_0);
 nand     U582(NET_0_0, S00, S01);
 UDP_MUX2   U584(Y, NET_0_4, NET_0_11, NET_0_5);
 nor      U586(NET_0_5, DB_, S11);
 UDP_MUX2   U589(NET_0_11, DB_, DB_, NET_0_7);
 nand     U591(NET_0_7, S00, S01);

       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMB7
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !(S00 & S01)+D1 & (S00 & S01)) & !( !DB +S11)+(D2 & !(S00 & S01)+ !DB & (S00 & S01)) & ( !DB +S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMB7(Y,D0,S00,S01,D1,DB,S11,D2);
 input D0,S00,S01,D1,DB,S11,D2;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;


       CMB7_primitive U_CMB7(Y, D0, D1, D2, DB, S00, S01, S11);


       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMBB
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !(S00 & S01)+D1 & (S00 & S01)) & !( !DB +S11)+( !DB & !(S00 & S01)+D3 & (S00 & S01)) & ( !DB +S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMBB(Y,D0,S00,S01,D1,DB,S11,D3);
 input D0,S00,S01,D1,DB,S11,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;


	CMBB_primitive U_CMBB(Y, D0, D1, DB, D3, S00, S01, S11);


       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMBF
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !(S00 & S01)+D1 & (S00 & S01)) & !( !DB +S11)+(D2 & !(S00 & S01)+D3 & (S00 & S01)) & ( !DB +S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMBF(Y,D0,S00,S01,D1,DB,S11,D2,D3);
 input D0,S00,S01,D1,DB,S11,D2,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;

 not	INV_127(DB_, DB);
 UDP_MUX2   U596(NET_0_4, D0, D1, NET_0_0);
 nand     U598(NET_0_0, S00, S01);
 UDP_MUX2   U600(Y, NET_0_4, NET_0_11, NET_0_5);
 nor      U602(NET_0_5, DB_, S11);
 UDP_MUX2   U605(NET_0_11, D2, D3, NET_0_7);
 nand     U607(NET_0_7, S00, S01);

       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMEA
 CELL TYPE : comb
 CELL LOGIC : Y = (!DB & !(!DB & S01) + D1 & (!DB & S01)) & !(S10+S11) + (!DB & !(!DB & S01) + D3 & (!DB & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMEA(Y,DB,S01,D1,S10,S11,D3);
 input DB,S01,D1,S10,S11,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;


	CMEA_primitive U_CMEA(Y, DB, D1,  D3,  S01, S10,   S11);


       specify

		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMEB
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !( !DB & S01)+D1 & ( !DB & S01)) & !(S10+S11)+( !DB & !( !DB & S01)+D3 & ( !DB & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMEB(Y,D0,DB,S01,D1,S10,S11,D3);
 input D0,DB,S01,D1,S10,S11,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;


	CMEB_primitive U_CMEB(Y, D0,   D1,   DB,   D3,   S01,  S10,  S11);


       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMEE
 CELL TYPE : comb
 CELL LOGIC : Y = ( !DB & !( !DB & S01)+D1 & ( !DB & S01)) & !(S10+S11)+(D2 & !( !DB & S01)+D3 & ( !DB & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMEE(Y,DB,S01,D1,S10,S11,D2,D3);
 input DB,S01,D1,S10,S11,D2,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;


	CMEE_primitive U_CMEE(Y, DB, D1,   D2,   D3,   S01,  S10,  S11);


       specify

		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMEF
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !( !DB & S01)+D1 & ( !DB & S01)) & !(S10+S11)+(D2 & !( !DB & S01)+D3 & ( !DB & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMEF(Y,D0,DB,S01,D1,S10,S11,D2,D3);
 input D0,DB,S01,D1,S10,S11,D2,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;

 not	INV_128(DB_, DB);
 UDP_MUX2   U612(NET_0_4, D0, D1, NET_0_0);
 nand     U614(NET_0_0, DB_, S01);
 UDP_MUX2   U616(Y, NET_0_4, NET_0_11, NET_0_5);
 nor      U618(NET_0_5, S10, S11);
 UDP_MUX2   U621(NET_0_11, D2, D3, NET_0_7);
 nand     U623(NET_0_7, DB_, S01);

       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMF1
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !(S00 & S01) + !DB & (S00 & S01)) & !(S10+S11) + !DB & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMF1(Y,D0,S00,S01,DB,S10,S11);
 input D0,S00,S01,DB,S10,S11;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8;

 not	INV_129(DB_, DB);
 UDP_MUX2   U628(NET_0_4, D0, DB_, NET_0_0);
 nand     U630(NET_0_0, S00, S01);
 UDP_MUX2   U632(Y, NET_0_4, DB_, NET_0_5);
 nor      U634(NET_0_5, S10, S11);

       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMF2
 CELL TYPE : comb
 CELL LOGIC : Y = (!DB & !(S00 & S01) + D1 & (S00 & S01)) & !(S10+S11) + !DB & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMF2(Y,DB,S00,S01,D1,S10,S11);
 input DB,S00,S01,D1,S10,S11;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8;

 not	INV_130(DB_, DB);
 UDP_MUX2   U639(NET_0_4, DB_, D1, NET_0_0);
 nand     U641(NET_0_0, S00, S01);
 UDP_MUX2   U643(Y, NET_0_4, DB_, NET_0_5);
 nor      U645(NET_0_5, S10, S11);

       specify

		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMF3
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !(S00 & S01)+D1 & (S00 & S01)) & !(S10+S11)+ !DB & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMF3(Y,D0,S00,S01,D1,S10,S11,DB);
 input D0,S00,S01,D1,S10,S11,DB;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8;

 not	INV_131(DB_, DB);
 UDP_MUX2   U650(NET_0_4, D0, D1, NET_0_0);
 nand     U652(NET_0_0, S00, S01);
 UDP_MUX2   U654(Y, NET_0_4, DB_, NET_0_5);
 nor      U656(NET_0_5, S10, S11);

       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMF4
 CELL TYPE : comb
 CELL LOGIC : Y = !DB & !(S10+S11) + (D2 & !(S00 & S01) + !DB & (S00 & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMF4(Y,DB,S10,S11,D2,S00,S01);
 input DB,S10,S11,D2,S00,S01;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8;

 not	INV_132(DB_, DB);
 UDP_MUX2   U660(Y, DB_, NET_0_6, NET_0_0);
 nor      U662(NET_0_0, S10, S11);
 UDP_MUX2   U665(NET_0_6, D2, DB_, NET_0_2);
 nand     U667(NET_0_2, S00, S01);

       specify

		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMF5
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !(S10+S11) + D2 & (S10+S11)) & !(S00 & S01) +  !DB & (S00 & S01)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMF5(Y,D0,S10,S11,D2,S00,S01,DB);
 input D0,S10,S11,D2,S00,S01,DB;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8;

 not	INV_133(DB_, DB);
 UDP_MUX2   U672(NET_0_4, D0, D2, NET_0_0);
 nor      U674(NET_0_0, S10, S11);
 UDP_MUX2   U676(Y, NET_0_4, DB_, NET_0_5);
 nand     U678(NET_0_5, S00, S01);

       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMF6
 CELL TYPE : comb
 CELL LOGIC : Y = ( !DB & !(S00 & S01)+D1 & (S00 & S01)) & !(S10+S11) + (D2 & !(S00 & S01)+ !DB & (S00 & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMF6(Y,DB,S00,S01,D1,S10,S11,D2);
 input DB,S00,S01,D1,S10,S11,D2;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;

 not	INV_134(DB_, DB);
 UDP_MUX2   U683(NET_0_4, DB_, D1, NET_0_0);
 nand     U685(NET_0_0, S00, S01);
 UDP_MUX2   U687(Y, NET_0_4, NET_0_11, NET_0_5);
 nor      U689(NET_0_5, S10, S11);
 UDP_MUX2   U692(NET_0_11, D2, DB_, NET_0_7);
 nand     U694(NET_0_7, S00, S01);

       specify

		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMF7
 CELL TYPE : comb
 CELL LOGIC : Y = ( D0 & !(S00 & S01) + D1 & (S00 & S01)) & !(S10+S11) + (D2 & !(S00 & S01) +  !DB & (S00 & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMF7(Y,D0,S00,S01,D1,S10,S11,D2,DB);
 input D0,S00,S01,D1,S10,S11,D2,DB;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;

 not	INV_135(DB_, DB);
 UDP_MUX2   U699(NET_0_4, D0, D1, NET_0_0);
 nand     U701(NET_0_0, S00, S01);
 UDP_MUX2   U703(Y, NET_0_4, NET_0_11, NET_0_5);
 nor      U705(NET_0_5, S10, S11);
 UDP_MUX2   U708(NET_0_11, D2, DB_, NET_0_7);
 nand     U710(NET_0_7, S00, S01);

       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMF8
 CELL TYPE : comb
 CELL LOGIC : Y = !DB & !(S10+S11) + (!DB & !(S00 & S01) + D3 & (S00 & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMF8(Y,DB,S10,S11,S00,S01,D3);
 input DB,S10,S11,S00,S01,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8;

 not	INV_136(DB_, DB);
 UDP_MUX2   U714(Y, DB_, NET_0_6, NET_0_0);
 nor      U716(NET_0_0, S10, S11);
 UDP_MUX2   U719(NET_0_6, DB_, D3, NET_0_2);
 nand     U721(NET_0_2, S00, S01);

       specify

		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMF9
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !(S00 & S01)+ !DB & (S00 & S01)) & !(S10+S11) + ( !DB & !(S00 & S01)+D3 & (S00 & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMF9(Y,D0,S00,S01,DB,S10,S11,D3);
 input D0,S00,S01,DB,S10,S11,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;

 not	INV_137(DB_, DB);
 UDP_MUX2   U726(NET_0_4, D0, DB_, NET_0_0);
 nand     U728(NET_0_0, S00, S01);
 UDP_MUX2   U730(Y, NET_0_4, NET_0_11, NET_0_5);
 nor      U732(NET_0_5, S10, S11);
 UDP_MUX2   U735(NET_0_11, DB_, D3, NET_0_7);
 nand     U737(NET_0_7, S00, S01);

       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMFA
 CELL TYPE : comb
 CELL LOGIC : Y = (  !DB & !(S00 & S01)) + (D1 & !(S10+S11)+D3 & (S10+S11)) & (S00 & S01)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMFA(Y,DB,S00,S01,D1,S10,S11,D3);
 input DB,S00,S01,D1,S10,S11,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8;

 not	INV_138(DB_, DB);
 UDP_MUX2   U741(Y, DB_, NET_0_6, NET_0_0);
 nand     U743(NET_0_0, S00, S01);
 UDP_MUX2   U746(NET_0_6, D1, D3, NET_0_2);
 nor      U748(NET_0_2, S10, S11);

       specify

		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMFB
 CELL TYPE : comb
 CELL LOGIC : Y = ( D0 & !(S00 & S01) + D1 & (S00 & S01)) & !(S10+S11) + (  !DB & !(S00 & S01) + D3 & (S00 & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMFB(Y,D0,S00,S01,D1,S10,S11,DB,D3);
 input D0,S00,S01,D1,S10,S11,DB,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;

 not	INV_139(DB_, DB);
 UDP_MUX2   U753(NET_0_4, D0, D1, NET_0_0);
 nand     U755(NET_0_0, S00, S01);
 UDP_MUX2   U757(Y, NET_0_4, NET_0_11, NET_0_5);
 nor      U759(NET_0_5, S10, S11);
 UDP_MUX2   U762(NET_0_11, DB_, D3, NET_0_7);
 nand     U764(NET_0_7, S00, S01);

       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMFC
 CELL TYPE : comb
 CELL LOGIC : Y =  !DB & !(S10+S11) + (D2 & !(S00 & S01)+D3 & (S00 & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMFC(Y,DB,S10,S11,D2,S00,S01,D3);
 input DB,S10,S11,D2,S00,S01,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8;

 not	INV_140(DB_, DB);
 UDP_MUX2   U768(Y, DB_, NET_0_6, NET_0_0);
 nor      U770(NET_0_0, S10, S11);
 UDP_MUX2   U773(NET_0_6, D2, D3, NET_0_2);
 nand     U775(NET_0_2, S00, S01);

       specify

		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMFD
 CELL TYPE : comb
 CELL LOGIC : Y = ( D0 & !(S00 & S01) +  !DB & (S00 & S01)) & !(S10+S11) + (D2 & !(S00 & S01) + D3 & (S00 & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMFD(Y,D0,S00,S01,DB,S10,S11,D2,D3);
 input D0,S00,S01,DB,S10,S11,D2,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;

 not	INV_141(DB_, DB);
 UDP_MUX2   U780(NET_0_4, D0, DB_, NET_0_0);
 nand     U782(NET_0_0, S00, S01);
 UDP_MUX2   U784(Y, NET_0_4, NET_0_11, NET_0_5);
 nor      U786(NET_0_5, S10, S11);
 UDP_MUX2   U789(NET_0_11, D2, D3, NET_0_7);
 nand     U791(NET_0_7, S00, S01);

       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CMFE
 CELL TYPE : comb
 CELL LOGIC : Y = (  !DB & !(S00 & S01) + D1 & (S00 & S01)) & !(S10+S11) + (D2 & !(S00 & S01) + D3 & (S00 & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CMFE(Y,DB,S00,S01,D1,S10,S11,D2,D3);
 input DB,S00,S01,D1,S10,S11,D2,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;

 not	INV_142(DB_, DB);
 UDP_MUX2   U796(NET_0_4, DB_, D1, NET_0_0);
 nand     U798(NET_0_0, S00, S01);
 UDP_MUX2   U800(Y, NET_0_4, NET_0_11, NET_0_5);
 nor      U802(NET_0_5, S10, S11);
 UDP_MUX2   U805(NET_0_11, D2, D3, NET_0_7);
 nand     U807(NET_0_7, S00, S01);

       specify

		specparam tpdLH_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_DB_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(DB => Y ) = ( tpdLH_DB_to_Y, tpdHL_DB_to_Y );
		(S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
		(S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
		(S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CS1
 CELL TYPE : comb
 CELL LOGIC : Y = !(A + S & B) & C + D & (A + S & B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CS1(Y,A,S,B,C,D);
 input A,S,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;

 UDP_MUX2   U811(Y, C, D, NET_0_1);
 nor      U813(NET_0_1, A, NET_0_0);
 and      U815(NET_0_0, S, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(S => Y ) = ( tpdLH_S_to_Y, tpdHL_S_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CS2
 CELL TYPE : comb
 CELL LOGIC : Y = !((A+S) & B) & C + ((A+S) & B) & D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CS2(Y,A,S,B,C,D);
 input A,S,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;

 UDP_MUX2   U819(Y, C, D, NET_0_1);
 or       U822(NET_0_0, A, S);
 nand     U823(NET_0_1, NET_0_0, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(S => Y ) = ( tpdLH_S_to_Y, tpdHL_S_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CY2A
 CELL TYPE : comb
 CELL LOGIC : Y = A1 & B1 + A0 & B0 & A1 + A0 & B0 & B1
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CY2A(Y,A1,B1,A0,B0);
 input A1,B1,A0,B0;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;

 and      U829(NET_0_0, A1, B1);
 or       U830(NET_0_3, NET_0_0, NET_0_2);
 and      U833(NET_0_1, A0, B0);
 and      U834(NET_0_2, NET_0_1, A1);
 or       U835(Y, NET_0_3, NET_0_5);
 and      U838(NET_0_4, A0, B0);
 and      U839(NET_0_5, NET_0_4, B1);

       specify

		specparam tpdLH_A1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_A0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B0_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A1 => Y ) = ( tpdLH_A1_to_Y, tpdHL_A1_to_Y );
		(B1 => Y ) = ( tpdLH_B1_to_Y, tpdHL_B1_to_Y );
		(A0 => Y ) = ( tpdLH_A0_to_Y, tpdHL_A0_to_Y );
		(B0 => Y ) = ( tpdLH_B0_to_Y, tpdHL_B0_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : CY2B
 CELL TYPE : comb
 CELL LOGIC : Y = A1 & B1 + (A0+B0) & A1 + (A0+B0) & B1
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CY2B(Y,A1,B1,A0,B0);
 input A1,B1,A0,B0;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;

 and      U844(NET_0_0, A1, B1);
 or       U845(NET_0_3, NET_0_0, NET_0_2);
 or       U848(NET_0_1, A0, B0);
 and      U849(NET_0_2, NET_0_1, A1);
 or       U850(Y, NET_0_3, NET_0_5);
 or       U853(NET_0_4, A0, B0);
 and      U854(NET_0_5, NET_0_4, B1);

       specify

		specparam tpdLH_A1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_A0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B0_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A1 => Y ) = ( tpdLH_A1_to_Y, tpdHL_A1_to_Y );
		(B1 => Y ) = ( tpdLH_B1_to_Y, tpdHL_B1_to_Y );
		(A0 => Y ) = ( tpdLH_A0_to_Y, tpdHL_A0_to_Y );
		(B0 => Y ) = ( tpdLH_B0_to_Y, tpdHL_B0_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DF1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DF1(CLK, Q,D);
 input D,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,VCC_0, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DF1_CC
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DF1_CC(CLK, Q,D);
 input D,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,VCC_0, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DF1B
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DF1B(CLK, Q,D);
 input D,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpf DF_0(Q, D,CLK,VCC_0, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I0 (_CLK, CLK);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK, 0.0, NOTIFY_REG);
	$hold(negedge CLK, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFC1B
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFC1B(CLR, CLK, Q,D);
 input D,CLR,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,CLR, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I2 (_CLR, CLR);
      buf U_c0 (Enable1,CLR);
       buf U_c2 (Enable2, CLR);
      buf U_c6 (Enable5, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFC1B_CC
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFC1B_CC(CLR, CLK, Q,D);
 input D,CLR,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,CLR, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I2 (_CLR, CLR);
      buf U_c0 (Enable1,CLR);
       buf U_c2 (Enable2, CLR);
      buf U_c6 (Enable5, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFC1D
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFC1D(CLR, CLK, Q,D);
 input D,CLR,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpf DF_0(Q, D,CLK,CLR, VCC_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I0 (_CLK, CLK);
      not U_I2 (_CLR, CLR);
      buf U_c0 (Enable1,CLR);
       buf U_c2 (Enable2, CLR);
      buf U_c6 (Enable5, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(negedge CLK, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, negedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFE1B
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _E=E, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFE1B(E, CLK, Q,D);
 input D,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,VCC_0, VCC_0, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I3 (_E, E);
      buf U_c0 (Enable1,_E);
      buf U_c2 (Enable2, _E);
      buf U_c4 (Enable4, _E);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK,  0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge E,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFE1C
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, _E=E, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFE1C(E, CLK, Q,D);
 input D,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpf DF_0(Q, D,CLK,VCC_0, VCC_0, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I0 (_CLK, CLK);
      not U_I3 (_E, E);
      buf U_c0 (Enable1,_E);
      buf U_c2 (Enable2, _E);
      buf U_c4 (Enable4, _E);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK,  0.0, NOTIFY_REG);
	$hold(negedge CLK, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK, 0.0, NOTIFY_REG);
	$hold(negedge CLK, negedge E,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checing the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFE3C
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _E=E, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFE3C(CLR, E, CLK, Q,D);
 input D,CLR,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,CLR, VCC_0, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I2 (_CLR, CLR);
      not U_I3 (_E, E);
      and U_c0 (Enable1, _E, CLR);
      and U_c2 (Enable2, _E, CLR);
      buf U_c4 (Enable4, _E);
      buf U_c6 (Enable5, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable5,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable5, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable5, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable5, negedge E,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable4, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, posedge CLK &&& Enable4, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFE3D
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, _E=E, _CLR=CLR, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFE3D(CLR, E, CLK, Q,D);
 input D,CLR,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpf DF_0(Q, D,CLK,CLR, VCC_0, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I0 (_CLK, CLK);
      not U_I2 (_CLR, CLR);
      not U_I3 (_E, E);
      and U_c0 (Enable1, _E, CLR);
      and U_c2 (Enable2, _E, CLR);
      buf U_c4 (Enable4, _E);
      buf U_c6 (Enable5, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable5,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable5, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable5, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable5, negedge E,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable4, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge CLR, negedge CLK &&& Enable4, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFE4F
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _E=E, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFE4F(PRE, E, CLK, Q,D);
 input D,PRE,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,VCC_0, PRE, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I1 (_PRE, PRE);
      not U_I3 (_E, E);
      and U_c0 (Enable1, _E, PRE);
      buf U_c2 (Enable2, _E);
      and U_c4 (Enable4, _E, PRE);
       buf U_c6 (Enable5, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable5,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable5, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable5, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable5, negedge E,0.0, NOTIFY_REG);

	$hold(posedge CLK &&& Enable2, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, posedge CLK &&& Enable2, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFE4G
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, _E=E, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFE4G(PRE, E, CLK, Q,D);
 input D,PRE,E,CLK;
 output Q;
 supply1 VCC_0;
 reg NOTIFY_REG;


 Dffpf DF_0(Q, D,CLK,VCC_0, PRE, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I0 (_CLK, CLK);
      not U_I1 (_PRE, PRE);
      not U_I3 (_E, E);
      and U_c0 (Enable1, _E, PRE);
      buf U_c2 (Enable2, _E);
      and U_c4 (Enable4, _E, PRE);
       buf U_c6 (Enable5, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable5,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable5, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable5, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable5, negedge E,0.0, NOTIFY_REG);

	$hold(negedge CLK &&& Enable2, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, negedge CLK &&& Enable2, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFEG
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _E=E, _CLR=CLR, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFEG(PRE, CLR, E, CLK, Q,D);
 input D,PRE,CLR,E,CLK;
 output Q;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,CLR, PRE, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I1 (_PRE, PRE);
      not U_I2 (_CLR, CLR);
      not U_I3 (_E, E);
      and U_c0 (Enable1, _E, CLR, PRE);
      and U_c2 (Enable2, _E, CLR);
      and U_c4 (Enable4, _E, PRE);
      and U_c6 (Enable5, CLR, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,posedge CLK &&& Enable5,  0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable5, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,posedge CLK &&& Enable5, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable5, negedge E,0.0, NOTIFY_REG);

	$hold(posedge CLK &&& Enable2, posedge PRE,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable4, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);
	$width(negedge PRE &&& CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, posedge CLK &&& Enable2, 0.0, NOTIFY_REG);
	$recovery(posedge CLR, posedge CLK &&& Enable4, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFEH
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, _E=E, _CLR=CLR, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFEH(PRE, CLR, E, CLK, Q,D);
 input D,PRE,CLR,E,CLK;
 output Q;
 reg NOTIFY_REG;


 Dffpf DF_0(Q, D,CLK,CLR, PRE, E, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I0 (_CLK, CLK);
      not U_I1 (_PRE, PRE);
      not U_I2 (_CLR, CLR);
      not U_I3 (_E, E);
      and U_c0 (Enable1, _E, CLR, PRE);
      and U_c2 (Enable2, _E, CLR);
      and U_c4 (Enable4, _E, PRE);
      and U_c6 (Enable5, CLR, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge E,negedge CLK &&& Enable5,  0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable5, posedge E,0.0, NOTIFY_REG);
	$setup(negedge E,negedge CLK &&& Enable5, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable5, negedge E,0.0, NOTIFY_REG);

	$hold(negedge CLK &&& Enable2, posedge PRE,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable4, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);
	$width(negedge PRE &&& CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, negedge CLK &&& Enable2, 0.0, NOTIFY_REG);
	$recovery(posedge CLR, negedge CLK &&& Enable4, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFP1
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFP1(PRE, CLK, Q,D);
 input D,PRE,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpr DF_0(Q, D,CLK,VCC_0, PRE_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I1 (_PRE, PRE);
      buf U_c0 (Enable1, _PRE);
       buf U_c4 (Enable4, _PRE);
       buf U_c6 (Enable5, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFP1A
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFP1A(PRE, CLK, Q,D);
 input D,PRE,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpf DF_0(Q, D,CLK,VCC_0, PRE_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I0 (_CLK, CLK);
      not U_I1 (_PRE, PRE);
      buf U_c0 (Enable1, _PRE);
       buf U_c4 (Enable4, _PRE);
       buf U_c6 (Enable5, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(negedge CLK, negedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(posedge PRE,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, negedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFP1B
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFP1B(PRE, CLK, Q,D);
 input D,PRE,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,VCC_0, PRE, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I1 (_PRE, PRE);
      buf U_c0 (Enable1, PRE);       buf U_c4 (Enable4, PRE);
       buf U_c6 (Enable5, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFP1B_CC
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFP1B_CC(PRE, CLK, Q,D);
 input D,PRE,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,VCC_0, PRE, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I1 (_PRE, PRE);
      buf U_c0 (Enable1, PRE);       buf U_c4 (Enable4, PRE);
       buf U_c6 (Enable5, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFP1D
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFP1D(PRE, CLK, Q,D);
 input D,PRE,CLK;
 output Q;
 supply1 VCC_0;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpf DF_0(Q, D,CLK,VCC_0, PRE, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I0 (_CLK, CLK);
      not U_I1 (_PRE, PRE);
      buf U_c0 (Enable1, PRE);       buf U_c4 (Enable4, PRE);
       buf U_c6 (Enable5, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(negedge CLK, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, negedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFPC
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _CLR=CLR, PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFPC(PRE, CLR, CLK, Q,D);
 input D,PRE,CLR,CLK;
 output Q;
 supply0 GND_0;
 reg NOTIFY_REG;

 not INV_PRE_0(PRE_0, PRE);

 Dffpr DF_0(Q, D,CLK,CLR, PRE_0, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I1 (_PRE, PRE);
      not U_I2 (_CLR, CLR);
      and U_c0 (Enable1, CLR, _PRE);
       buf U_c2 (Enable2, CLR);
       buf U_c4 (Enable4, _PRE);
      and U_c6 (Enable5, CLR, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK &&& Enable2, negedge PRE,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable4, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE &&& CLR,  0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(negedge PRE, posedge CLK &&& Enable2, 0.0, NOTIFY_REG);
	$recovery(posedge CLR, posedge CLK &&& Enable4, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFPCB
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,CLK =CLK, _CLR=CLR, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFPCB(PRE, CLR, CLK, Q,D);
 input D,PRE,CLR,CLK;
 output Q;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpr DF_0(Q, D,CLK,CLR, PRE, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I1 (_PRE, PRE);
      not U_I2 (_CLR, CLR);
      and U_c0 (Enable1, CLR, PRE);
       buf U_c2 (Enable2, CLR);
       buf U_c4 (Enable4, PRE);
      and U_c6 (Enable5, CLR, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(posedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(posedge CLK &&& Enable2, posedge PRE,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable4, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);
	$width(negedge PRE &&& CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, posedge CLK &&& Enable2, 0.0, NOTIFY_REG);
	$recovery(posedge CLR, posedge CLK &&& Enable4, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : DFPCC
 CELL TYPE : sequential Logic
 CELL SEQ EQN : DFF[Q=Q,_CLK=CLK, _CLR=CLR, _PRE=PRE, D=D ];
----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module DFPCC(PRE, CLR, CLK, Q,D);
 input D,PRE,CLR,CLK;
 output Q;
 supply0 GND_0;
 reg NOTIFY_REG;


 Dffpf DF_0(Q, D,CLK,CLR, PRE, GND_0, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I0 (_CLK, CLK);
      not U_I1 (_PRE, PRE);
      not U_I2 (_CLR, CLR);
      and U_c0 (Enable1, CLR, PRE);
       buf U_c2 (Enable2, CLR);
       buf U_c4 (Enable4, PRE);
      and U_c6 (Enable5, CLR, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);
	specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);



	//check timing delay for output

	(negedge CLK => (Q +: D))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge D,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	$hold(negedge CLK &&& Enable2, posedge PRE,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable4, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable5 ,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable5, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);
	$width(negedge PRE &&& CLR, 0.0, 0, NOTIFY_REG);

	//checing the recovery data

	$recovery(posedge PRE, negedge CLK &&& Enable2, 0.0, NOTIFY_REG);
	$recovery(posedge CLR, negedge CLK &&& Enable4, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DL1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,CLK =G, D=D ];
-----------------------------------------------------------------*/

module DL1(G, Q,D);
 input D,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(Q, D, G_, GND, GND, NOTIFY_REG);

// some temp signals created for timing checking sections

	buf U_c1 (Enable2, G);
	buf U_c3 (Enable4, G);
	buf U_c5 (Enable6, G);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(G )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	(posedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G, 0.0, NOTIFY_REG);
	$hold(negedge G, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G, 0.0, NOTIFY_REG);
	$hold(negedge G, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G, 0.0, 0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DL1B
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, D=D ];
-----------------------------------------------------------------*/

module DL1B(G, Q,D);
 input D,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 DL2C_UDP DL_U0(Q, D, G, GND, GND, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	buf U_c1 (Enable2, _G);
	buf U_c3 (Enable4, _G);
	buf U_c5 (Enable6, _G);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(!G )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G, 0.0, NOTIFY_REG);
	$hold(posedge G, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G, 0.0, NOTIFY_REG);
	$hold(posedge G, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G, 0.0, 0, NOTIFY_REG);


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DL2A
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,CLK =G, _CLR=CLR, PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DL2A(PRE, CLR, G, Q,D);
 input D,PRE,CLR,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 not INV_CLR(CLR_, CLR);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(Q, D, G_, CLR_, PRE, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I1 (_PRE, PRE);
	not U_I2 (_CLR, CLR);
	and U_c0 (Enable1, CLR, _PRE);
	and U_c1 (Enable2, G, CLR, _PRE);
	buf U_c2 (Enable3, CLR);
	and U_c3 (Enable4, G, CLR);
	buf U_c4 (Enable5, _PRE);
	and U_c5 (Enable6, G, _PRE);
	and U_c6 (Enable7, CLR, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(G && CLR && !PRE )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if(Enable1)
	(posedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(posedge CLR => (Q+:D)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	if(CLR)
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
       if(G && CLR )
	(negedge PRE => (Q+:D)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE &&& CLR, 0.0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (negedge PRE, negedge G &&&  Enable3, 0.0, NOTIFY_REG);
	$hold (negedge G &&& Enable3 , negedge PRE, 0.0, NOTIFY_REG);
	$recovery (posedge  CLR, negedge G &&& Enable5, 0.0, NOTIFY_REG);
	$hold (negedge G &&& Enable5, posedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DL2C
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, _CLR=CLR, PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DL2C(PRE, CLR, G, Q,D);
 input D,PRE,CLR,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 not INV_CLR(CLR_, CLR);
 DL2C_UDP DL_U0(Q, D, G, CLR_, PRE, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I1 (_PRE, PRE);
	not U_I2 (_CLR, CLR);
	and U_c0 (Enable1, CLR, _PRE);
	and U_c1 (Enable2, _G, CLR, _PRE);
	buf U_c2 (Enable3, CLR);
	and U_c3 (Enable4, _G, CLR);
	buf U_c4 (Enable5, _PRE);
	and U_c5 (Enable6, _G, _PRE);
	and U_c6 (Enable7, CLR, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(!G && CLR && !PRE )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if(Enable1)
	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(posedge CLR => (Q+:D)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	if(CLR)
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
       if(!G && CLR )
	(negedge PRE => (Q+:D)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE &&& CLR, 0.0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (negedge PRE, posedge G &&&  Enable3, 0.0, NOTIFY_REG);
	$hold (posedge G &&& Enable3 , negedge PRE, 0.0, NOTIFY_REG);
	$recovery (posedge  CLR, posedge G &&& Enable5, 0.0, NOTIFY_REG);
	$hold (posedge G &&& Enable5, posedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLC
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,CLK =G, _CLR=CLR, D=D ];
-----------------------------------------------------------------*/

module DLC(CLR, G, Q,D);
 input D,CLR,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLR(CLR_, CLR);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(Q, D, G_, CLR_, GND, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I2 (_CLR, CLR);
	buf U_c0 (Enable1,CLR);
	and U_c1 (Enable2, G,CLR);
	buf U_c2 (Enable3, CLR);
	and U_c3 (Enable4, G, CLR);
	buf U_c5 (Enable6, G);
	buf U_c6 (Enable7, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(G && CLR )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if(Enable1)
	(posedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(posedge CLR => (Q+:D)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (posedge  CLR, negedge G, 0.0, NOTIFY_REG);
	$hold (negedge G, posedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLC1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,CLK =G, CLR=CLR, D=D ];
-----------------------------------------------------------------*/

module DLC1(CLR, G, Q,D);
 input D,CLR,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLR(CLR_, CLR);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(Q, D, G_, CLR, GND, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I2 (_CLR, CLR);
	buf U_c0 (Enable1,_CLR);
	and U_c1 (Enable2, G,_CLR);
	buf U_c2 (Enable3, _CLR);
	and U_c3 (Enable4, G, _CLR);
	buf U_c5 (Enable6, G);
	buf U_c6 (Enable7, _CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(G && !CLR )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if(Enable1)
	(posedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(negedge CLR => (Q+:D)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (negedge CLR, negedge G, 0.0, NOTIFY_REG);
	$hold (negedge G, negedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLC1A
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, CLR=CLR, D=D ];
-----------------------------------------------------------------*/

module DLC1A(CLR, G, Q,D);
 input D,CLR,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLR(CLR_, CLR);
 DL2C_UDP DL_U0(Q, D, G, CLR, GND, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I2 (_CLR, CLR);
	buf U_c0 (Enable1,_CLR);
	and U_c1 (Enable2, _G, _CLR);
	buf U_c2 (Enable3, _CLR);
	and U_c3 (Enable4, _G, _CLR);
	buf U_c5 (Enable6, _G);
	buf U_c6 (Enable7, _CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(!G && !CLR )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if(Enable1)
	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(negedge CLR => (Q+:D)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (negedge CLR, posedge G, 0.0, NOTIFY_REG);
	$hold (posedge G, negedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLCA
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, _CLR=CLR, D=D ];
-----------------------------------------------------------------*/

module DLCA(CLR, G, Q,D);
 input D,CLR,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLR(CLR_, CLR);
 DL2C_UDP DL_U0(Q, D, G, CLR_, GND, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I2 (_CLR, CLR);
	buf U_c0 (Enable1,CLR);
	and U_c1 (Enable2, _G, CLR);
	buf U_c2 (Enable3, CLR);
	and U_c3 (Enable4, _G, CLR);
	buf U_c5 (Enable6, _G);
	buf U_c6 (Enable7, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(!G && CLR )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if(Enable1)
	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(posedge CLR => (Q+:D)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (posedge  CLR, posedge G, 0.0, NOTIFY_REG);
	$hold (posedge G, posedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLE2C
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, _E=E, CLR=CLR, D=D ];
-----------------------------------------------------------------*/

module DLE2C(CLR, E, G, Q,D);
 input D,CLR,E,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_CLR(CLR_, CLR);
 not INV_EN(E_,E);
 DLE2B_UDP DL_U0(Q,D,E,G,CLR_,NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I2 (_CLR, CLR);
	not U_I3 (_E, E);
	and U_c0 (Enable1, _E, _CLR);
	and U_c1 (Enable2, _G, _CLR);
	and U_c2 (Enable3, _E, _CLR);
	and U_c3 (Enable4, _G, _CLR);
	buf U_c4 (Enable5, _E);
	buf U_c5 (Enable6, _G);
	buf U_c6 (Enable7, _CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_E_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_E_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(!G && !CLR && !E )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if(Enable1)
	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(posedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	(negedge CLR => (Q+:D)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);
	if(!CLR && !G)
	(negedge E => (Q+:D)) = (tpdLH_E_to_Q, tpdHL_E_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge D,posedge E &&& Enable2, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge E &&& Enable2, 0.0, NOTIFY_REG);
	$hold(posedge E &&& Enable2, posedge D,0.0, NOTIFY_REG);
	$hold(posedge E &&& Enable2, negedge D,0.0, NOTIFY_REG);

	// setup/hold check for the E to G

	$setup(negedge E, negedge G &&& Enable7, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable7, posedge E, 0.0, NOTIFY_REG);

	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge E &&& Enable7, 0.0, 0, NOTIFY_REG);
	$width(posedge CLR, 0.0, 0, NOTIFY_REG);

	$recovery (negedge CLR, posedge G &&& Enable5, 0.0, NOTIFY_REG);
	$hold (posedge G &&& Enable5, negedge CLR, 0.0, NOTIFY_REG);
	$recovery (negedge CLR,  posedge E &&& Enable6, 0.0, NOTIFY_REG);
	$hold (posedge E &&& Enable6, negedge CLR, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLE3B
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, _E=E, PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLE3B(PRE, E, G, Q,D);
 input D,PRE,E,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 not INV_EN(E_,E);
 DLE3B_UDP DL_U0(Q,D,G,E, PRE,NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I1 (_PRE, PRE);
	not U_I3 (_E, E);
	and U_C0 (Enable1, _E, _PRE);
	and U_c1 (Enable2, _G, _PRE);
	buf U_c2 (Enable3, _E);
	buf U_c3 (Enable4, _G);
	and U_c4 (Enable5, _E, _PRE);
	and U_c5 (Enable6, _G, _PRE);
	buf U_c6 (Enable7, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_E_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_E_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(!G && !PRE && !E )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if(Enable1)
	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
       if(!G && !E )
	(negedge PRE => (Q+:D)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
	if(!PRE && !G)
	(negedge E => (Q+:D)) = (tpdLH_E_to_Q, tpdHL_E_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge D,posedge E &&& Enable2, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge E &&& Enable2, 0.0, NOTIFY_REG);
	$hold(posedge E &&& Enable2, posedge D,0.0, NOTIFY_REG);
	$hold(posedge E &&& Enable2, negedge D,0.0, NOTIFY_REG);

	// setup/hold check for the E to G

	$setup(negedge E, negedge G &&& Enable7, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable7, posedge E, 0.0, NOTIFY_REG);

	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge E &&& Enable7, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE, 0.0, 0, NOTIFY_REG);

	$recovery (negedge PRE, posedge G &&&  Enable3, 0.0, NOTIFY_REG);
	$hold (posedge G &&& Enable3 , negedge PRE, 0.0, NOTIFY_REG);
	$recovery (negedge PRE,  posedge E &&& Enable4 , 0.0, NOTIFY_REG);
	$hold (posedge E &&& Enable4 , negedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLE3C
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, _E=E, _PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLE3C(PRE, E, G, Q,D);
 input D,PRE,E,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 not INV_EN(E_,E);
 DLE3B_UDP DL_U0(Q,D,G,E, PRE_,NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I1 (_PRE, PRE);
	not U_I3 (_E, E);
	and U_C0 (Enable1, _E, PRE);
	and U_c1 (Enable2, _G, PRE);
	buf U_c2 (Enable3, _E);
	buf U_c3 (Enable4, _G);
	and U_c4 (Enable5, _E, PRE);
	and U_c5 (Enable6, _G, PRE);
	buf U_c6 (Enable7, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_E_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_E_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(!G && PRE && !E )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if(Enable1)
	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
       if(!G && !E )
       (posedge PRE => (Q+:D)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
	if(PRE && !G)
	(negedge E => (Q+:D)) = (tpdLH_E_to_Q, tpdHL_E_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals

	$setup(posedge D,posedge E &&& Enable2, 0.0, NOTIFY_REG);
	$setup(negedge D,posedge E &&& Enable2, 0.0, NOTIFY_REG);
	$hold(posedge E &&& Enable2, posedge D,0.0, NOTIFY_REG);
	$hold(posedge E &&& Enable2, negedge D,0.0, NOTIFY_REG);

	// setup/hold check for the E to G

	$setup(negedge E, negedge G &&& Enable7, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable7, posedge E, 0.0, NOTIFY_REG);

	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge E &&& Enable7, 0.0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	$recovery (posedge  PRE, posedge G &&& Enable3 , 0.0, NOTIFY_REG);
	$hold (posedge G &&& Enable3 , posedge PRE, 0.0, NOTIFY_REG);
	$recovery (posedge PRE,  posedge E &&& Enable4 , 0.0, NOTIFY_REG);
	$hold (posedge E &&& Enable4 , posedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLP1
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,CLK =G, PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLP1(PRE, G, Q,D);
 input D,PRE,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(Q, D, G_, GND, PRE, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I1 (_PRE, PRE);
	buf U_c0 (Enable1,_PRE);
	and U_c1 (Enable2, G, _PRE);
	buf U_c3 (Enable4, G);
	buf U_c4 (Enable5, _PRE);
	and U_c5 (Enable6, G, _PRE);
	buf U_c6 (Enable7, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(G && !PRE )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if(Enable1)
	(posedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
       if(G )
	(negedge PRE => (Q+:D)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE, 0.0, 0, NOTIFY_REG);

	$recovery (negedge PRE, negedge G, 0.0, NOTIFY_REG);
	$hold (negedge G, negedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLP1A
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLP1A(PRE, G, Q,D);
 input D,PRE,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 DL2C_UDP DL_U0(Q, D, G, GND, PRE, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I1 (_PRE, PRE);
	buf U_c0 (Enable1,_PRE);
	and U_c1 (Enable2, _G, _PRE);
	buf U_c3 (Enable4, _G);
	buf U_c4 (Enable5, _PRE);
	and U_c5 (Enable6, _G, _PRE);
	buf U_c6 (Enable7, _PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(!G && !PRE )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if(Enable1)
	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(posedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
       if(!G )
	(negedge PRE => (Q+:D)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(posedge PRE, 0.0, 0, NOTIFY_REG);

	$recovery (negedge PRE, posedge G, 0.0, NOTIFY_REG);
	$hold (posedge G, negedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLP1B
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,CLK =G, _PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLP1B(PRE, G, Q,D);
 input D,PRE,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 not INV_CLK(G_, G);
 DL2C_UDP DL_U0(Q, D, G_, GND, PRE_, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I1 (_PRE, PRE);
	buf U_c0 (Enable1,PRE);	and U_c1 (Enable2, G, PRE);
	buf U_c3 (Enable4, G);
	buf U_c4 (Enable5, PRE);
	and U_c5 (Enable6, G, PRE);
	buf U_c6 (Enable7, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(G && PRE )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if(Enable1)
	(posedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
       if(G )
       (posedge PRE => (Q+:D)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,negedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(posedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	$recovery (posedge  PRE, negedge G, 0.0, NOTIFY_REG);
	$hold (negedge G, posedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : DLP1C
 CELL TYPE : D-Latch Logic
 CELL SEQ EQN : DL[Q=Q,_CLK=G, _PRE=PRE, D=D ];
-----------------------------------------------------------------*/

module DLP1C(PRE, G, Q,D);
 input D,PRE,G;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not INV_PRE(PRE_, PRE);
 DL2C_UDP DL_U0(Q, D, G, GND, PRE_, NOTIFY_REG);

// some temp signals created for timing checking sections

	not U_I0 (_G, G);
	not U_I1 (_PRE, PRE);
	buf U_c0 (Enable1,PRE);	and U_c1 (Enable2, _G, PRE);
	buf U_c3 (Enable4, _G);
	buf U_c4 (Enable5, PRE);
	and U_c5 (Enable6, _G, PRE);
	buf U_c6 (Enable7, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam    libname	="ex";
	specparam    macroType   ="seq_dlatch";
	specparam    InputLoad$G = 0.0;
	specparam    InputLoad$PRE = 0.0;
	specparam    InputLoad$D = 0.0;
        specparam    tpdLH_D_to_Q = (0.1:0.1:0.1);
        specparam    tpdHL_D_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_G_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_PRE_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_PRE_to_Q = (0.1:0.1:0.1);

        //check timing delay for output



	if(!G && PRE )
        (D => Q) = (tpdLH_D_to_Q, tpdHL_D_to_Q);

	if(Enable1)
	(negedge G => (Q+:D))=(tpdLH_G_to_Q, tpdHL_G_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);
       if(!G )
       (posedge PRE => (Q+:D)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, posedge D,0.0, NOTIFY_REG);
	$setup(negedge D,posedge G &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge G &&& Enable1, negedge D,0.0, NOTIFY_REG);

	//checking timing for control signals


	// check signal width

	$width(negedge G &&& Enable1, 0.0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	$recovery (posedge  PRE, posedge G, 0.0, NOTIFY_REG);
	$hold (posedge G, posedge PRE, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : FA1
 CELL TYPE : comb
 CELL LOGIC : S = A ^ B ^ CI ; CO =A & B + A & CI + B & CI
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module FA1(S,CO,A,B,CI);
 input A,B,CI;
 output S,CO;
 wire NET_0_0;
 wire NET_1_0, NET_1_1, NET_1_2, NET_1_3;

 not	INV_143(A_, A);
 not	INV_144(B_, B);
 UDP_MUX2   U858(NET_0_0, B, B_, A_);
 xor      U860(S, NET_0_0, CI);
 not	INV_145(A_, A);
 not	INV_146(B_, B);
 and      U865(NET_1_0, A, B);
 or       U866(NET_1_2, NET_1_0, NET_1_1);
 and      U868(NET_1_1, A, CI);
 or       U869(CO, NET_1_2, NET_1_3);
 and      U871(NET_1_3, B, CI);

       specify

		specparam tpdLH_A_to_S = (0.1:0.1:0.1);
		specparam tpdHL_A_to_S = (0.1:0.1:0.1);
		specparam tpdLH_B_to_S = (0.1:0.1:0.1);
		specparam tpdHL_B_to_S = (0.1:0.1:0.1);
		specparam tpdLH_CI_to_S = (0.1:0.1:0.1);
		specparam tpdHL_CI_to_S = (0.1:0.1:0.1);
		specparam tpdLH_A_to_CO = (0.1:0.1:0.1);
		specparam tpdHL_A_to_CO = (0.1:0.1:0.1);
		specparam tpdLH_B_to_CO = (0.1:0.1:0.1);
		specparam tpdHL_B_to_CO = (0.1:0.1:0.1);
		specparam tpdLH_CI_to_CO = (0.1:0.1:0.1);
		specparam tpdHL_CI_to_CO = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => S ) = ( tpdLH_A_to_S, tpdHL_A_to_S );
		(B => S ) = ( tpdLH_B_to_S, tpdHL_B_to_S );
		(CI => S ) = ( tpdLH_CI_to_S, tpdHL_CI_to_S );
		(A => CO ) = ( tpdLH_A_to_CO, tpdHL_A_to_CO );
		(B => CO ) = ( tpdLH_B_to_CO, tpdHL_B_to_CO );
		(CI => CO ) = ( tpdLH_CI_to_CO, tpdHL_CI_to_CO );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : GAND2
 CELL TYPE : comb
 CELL LOGIC : Y = A & G
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module GAND2(Y,A,G);
 input A,G;
 output Y;

 and      U874(Y, A, G);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_G_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_G_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(G => Y ) = ( tpdLH_G_to_Y, tpdHL_G_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : GMX4
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !S0 + D1 & S0) & !G + (D2 & !S0 + D3 & S0) & G
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module GMX4(Y,D0,S0,D1,G,D2,D3);
 input D0,S0,D1,G,D2,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7;

 not	INV_147(S0_, S0);
 not	INV_148(G_, G);
 UDP_MUX2   U878(NET_0_2, D0, D1, S0_);
 UDP_MUX2   U880(Y, NET_0_2, NET_0_6, G_);
 UDP_MUX2   U883(NET_0_6, D2, D3, S0_);

       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_G_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_G_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S0 => Y ) = ( tpdLH_S0_to_Y, tpdHL_S0_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(G => Y ) = ( tpdLH_G_to_Y, tpdHL_G_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : GNAND2
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & G)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module GNAND2(Y,A,G);
 input A,G;
 output Y;

 nand     U887(Y, A, G);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_G_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_G_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(G => Y ) = ( tpdLH_G_to_Y, tpdHL_G_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : GND
 CELL TYPE : comb
 CELL LOGIC : Y = 0
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module GND(Y);
 output Y;

 supply0	Y;

       specify

		specparam MacroType = "comb";

		//pin to pin path delay 

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : GNOR2
 CELL TYPE : comb
 CELL LOGIC : Y = !(A + G)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module GNOR2(Y,A,G);
 input A,G;
 output Y;

 nor      U890(Y, A, G);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_G_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_G_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(G => Y ) = ( tpdLH_G_to_Y, tpdHL_G_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : GOR2
 CELL TYPE : comb
 CELL LOGIC : Y = A + G
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module GOR2(Y,A,G);
 input A,G;
 output Y;

 or       U893(Y, A, G);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_G_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_G_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(G => Y ) = ( tpdLH_G_to_Y, tpdHL_G_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : GXOR2
 CELL TYPE : comb
 CELL LOGIC : Y = A ^ G
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module GXOR2(Y,A,G);
 input A,G;
 output Y;

 not	INV_149(A_, A);
 not	INV_150(G_, G);
 UDP_MUX2   U896(Y, G, G_, A_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_G_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_G_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(G => Y ) = ( tpdLH_G_to_Y, tpdHL_G_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : HA1
 CELL TYPE : comb
 CELL LOGIC : S=A ^ B ; CO = A & B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module HA1(S,CO,A,B);
 input A,B;
 output S,CO;

 not	INV_151(A_, A);
 not	INV_152(B_, B);
 UDP_MUX2   U900(S, B, B_, A_);
 not	INV_153(A_, A);
 not	INV_154(B_, B);
 and      U904(CO, A, B);

       specify

		specparam tpdLH_A_to_S = (0.1:0.1:0.1);
		specparam tpdHL_A_to_S = (0.1:0.1:0.1);
		specparam tpdLH_B_to_S = (0.1:0.1:0.1);
		specparam tpdHL_B_to_S = (0.1:0.1:0.1);
		specparam tpdLH_A_to_CO = (0.1:0.1:0.1);
		specparam tpdHL_A_to_CO = (0.1:0.1:0.1);
		specparam tpdLH_B_to_CO = (0.1:0.1:0.1);
		specparam tpdHL_B_to_CO = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => S ) = ( tpdLH_A_to_S, tpdHL_A_to_S );
		(B => S ) = ( tpdLH_B_to_S, tpdHL_B_to_S );
		(A => CO ) = ( tpdLH_A_to_CO, tpdHL_A_to_CO );
		(B => CO ) = ( tpdLH_B_to_CO, tpdHL_B_to_CO );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : HA1A
 CELL TYPE : comb
 CELL LOGIC : S=!A ^ B ; CO = !A & B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module HA1A(S,CO,A,B);
 input A,B;
 output S,CO;

 not	INV_155(A_, A);
 not	INV_156(B_, B);
 UDP_MUX2   U907(S, B, B_, A);
 not	INV_157(A_, A);
 not	INV_158(B_, B);
 and      U911(CO, A_, B);

       specify

		specparam tpdLH_A_to_S = (0.1:0.1:0.1);
		specparam tpdHL_A_to_S = (0.1:0.1:0.1);
		specparam tpdLH_B_to_S = (0.1:0.1:0.1);
		specparam tpdHL_B_to_S = (0.1:0.1:0.1);
		specparam tpdLH_A_to_CO = (0.1:0.1:0.1);
		specparam tpdHL_A_to_CO = (0.1:0.1:0.1);
		specparam tpdLH_B_to_CO = (0.1:0.1:0.1);
		specparam tpdHL_B_to_CO = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => S ) = ( tpdLH_A_to_S, tpdHL_A_to_S );
		(B => S ) = ( tpdLH_B_to_S, tpdHL_B_to_S );
		(A => CO ) = ( tpdLH_A_to_CO, tpdHL_A_to_CO );
		(B => CO ) = ( tpdLH_B_to_CO, tpdHL_B_to_CO );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : HA1B
 CELL TYPE : comb
 CELL LOGIC : S=!(A ^ B) ; CO = !(A & B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module HA1B(S,CO,A,B);
 input A,B;
 output S,CO;

 not	INV_159(A_, A);
 not	INV_160(B_, B);
 UDPN_MUX2  U914(S, B, B_, A_);
 not	INV_161(A_, A);
 not	INV_162(B_, B);
 nand     U918(CO, A, B);

       specify

		specparam tpdLH_A_to_S = (0.1:0.1:0.1);
		specparam tpdHL_A_to_S = (0.1:0.1:0.1);
		specparam tpdLH_B_to_S = (0.1:0.1:0.1);
		specparam tpdHL_B_to_S = (0.1:0.1:0.1);
		specparam tpdLH_A_to_CO = (0.1:0.1:0.1);
		specparam tpdHL_A_to_CO = (0.1:0.1:0.1);
		specparam tpdLH_B_to_CO = (0.1:0.1:0.1);
		specparam tpdHL_B_to_CO = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => S ) = ( tpdLH_A_to_S, tpdHL_A_to_S );
		(B => S ) = ( tpdLH_B_to_S, tpdHL_B_to_S );
		(A => CO ) = ( tpdLH_A_to_CO, tpdHL_A_to_CO );
		(B => CO ) = ( tpdLH_B_to_CO, tpdHL_B_to_CO );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : HA1C
 CELL TYPE : comb
 CELL LOGIC : S=A ^ B ; CO = !(A & B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module HA1C(S,CO,A,B);
 input A,B;
 output S,CO;

 not	INV_163(A_, A);
 not	INV_164(B_, B);
 UDP_MUX2   U921(S, B, B_, A_);
 not	INV_165(A_, A);
 not	INV_166(B_, B);
 nand     U925(CO, A, B);

       specify

		specparam tpdLH_A_to_S = (0.1:0.1:0.1);
		specparam tpdHL_A_to_S = (0.1:0.1:0.1);
		specparam tpdLH_B_to_S = (0.1:0.1:0.1);
		specparam tpdHL_B_to_S = (0.1:0.1:0.1);
		specparam tpdLH_A_to_CO = (0.1:0.1:0.1);
		specparam tpdHL_A_to_CO = (0.1:0.1:0.1);
		specparam tpdLH_B_to_CO = (0.1:0.1:0.1);
		specparam tpdHL_B_to_CO = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => S ) = ( tpdLH_A_to_S, tpdHL_A_to_S );
		(B => S ) = ( tpdLH_B_to_S, tpdHL_B_to_S );
		(A => CO ) = ( tpdLH_A_to_CO, tpdHL_A_to_CO );
		(B => CO ) = ( tpdLH_B_to_CO, tpdHL_B_to_CO );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : HCLKBUF
 CELL TYPE : comb
 CELL LOGIC : Y = PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module HCLKBUF(Y,PAD);
 input PAD;
 output Y;

 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INBUF
 CELL TYPE : comb
 CELL LOGIC : Y=PAD
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INBUF(Y,PAD);
 input PAD;
 output Y;

 buf	BUF_U_00(Y,PAD);

       specify

		specparam tpdLH_PAD_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_PAD_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(PAD => Y ) = ( tpdLH_PAD_to_Y, tpdHL_PAD_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INV
 CELL TYPE : comb
 CELL LOGIC : Y = !A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INV(Y,A);
 input A;
 output Y;

 not	INV_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INVA
 CELL TYPE : comb
 CELL LOGIC : Y = !A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INVA(Y,A);
 input A;
 output Y;

 not	INV_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : INVD
 CELL TYPE : comb
 CELL LOGIC : Y = !A
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module INVD(Y,A);
 input A;
 output Y;

 not	INV_U_00(Y,A);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : JKF
 CELL TYPE : sequential Logic
 CELL SEQ EQN: JKFF[Q=Q,CLK =CLK, J=J,k=!K];
-----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module JKF(CLK, Q,J,K);
 input J,K,CLK;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not	INV_167(K_, K);

 JKFFR JK_U0(Q, J,K,CLK,VCC,VCC, NOTIFY_REG);

// some temp signals created for timing checking sections


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   libname	="ex";
	specparam   InputLoad$CLK = 0.0;
	specparam   InputLoad$J = 0.0;
	specparam   InputLoad$K = 0.0;

        // checking timing path for combinatorial output

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);

	//check timing delay for output




        //check timing delay for output

	if(J == K)
	(posedge CLK => (Q +:J))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	if(J&& !K)
	(posedge CLK => (Q +: ~Q))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge J,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge J,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge J,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge J,0.0, NOTIFY_REG);
	$setup(posedge K,posedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge K,posedge CLK, 0.0, NOTIFY_REG);
	$hold(posedge CLK, posedge K,0.0, NOTIFY_REG);
	$hold(posedge CLK, negedge K,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checking the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : JKF1B
 CELL TYPE : sequential Logic
 CELL SEQ EQN: JKFF[Q=Q,_CLK=CLK, J=J,k=!K];
-----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module JKF1B(CLK, Q,J,K);
 input J,K,CLK;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not	INV_168(K_, K);

 JKFFF JK_U0(Q, J,K,CLK,VCC,VCC, NOTIFY_REG);

// some temp signals created for timing checking sections


//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   libname	="ex";
	specparam   InputLoad$CLK = 0.0;
	specparam   InputLoad$J = 0.0;
	specparam   InputLoad$K = 0.0;

        // checking timing path for combinatorial output

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);

	//check timing delay for output




        //check timing delay for output

	if(J == K)
	(negedge CLK => (Q +:J))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	if(J&& !K)
	(negedge CLK => (Q +: ~Q))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge J,negedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge J,negedge CLK, 0.0, NOTIFY_REG);
	$hold(negedge CLK, posedge J,0.0, NOTIFY_REG);
	$hold(negedge CLK, negedge J,0.0, NOTIFY_REG);
	$setup(posedge K,negedge CLK, 0.0, NOTIFY_REG);
	$setup(negedge K,negedge CLK, 0.0, NOTIFY_REG);
	$hold(negedge CLK, posedge K,0.0, NOTIFY_REG);
	$hold(negedge CLK, negedge K,0.0, NOTIFY_REG);

	//checking timing for control signals


	//checking the pulse width

	$width(posedge CLK,0,  0, NOTIFY_REG);
	$width(negedge CLK, 0, 0, NOTIFY_REG);

	//checking the recovery data


 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : JKF2A
 CELL TYPE : sequential Logic
 CELL SEQ EQN: JKFF[Q=Q,CLK =CLK, _CLR=CLR, J=J,k=!K];
-----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module JKF2A(CLR, CLK, Q,J,K);
 input J,K,CLR,CLK;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not	INV_169(K_, K);

 JKFFR JK_U0(Q, J,K,CLK,CLR,VCC, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I3 (_CLR, CLR);
      buf U_c0 (Enable1,CLR);
      buf U_c2 (Enable2, CLR);
      buf U_c6 (Enable7, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   libname	="ex";
	specparam   InputLoad$CLK = 0.0;
	specparam   InputLoad$J = 0.0;
	specparam   InputLoad$K = 0.0;

        // checking timing path for combinatorial output

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
        specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
        specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);

	//check timing delay for output




        //check timing delay for output

	if(J == K)
	(posedge CLK => (Q +:J))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	if(J&& !K)
	(posedge CLK => (Q +: ~Q))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge J,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge J,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge J,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge J,0.0, NOTIFY_REG);
	$setup(posedge K,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge K,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge K,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge K,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable7,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable7, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checking the recovery data

	$recovery(posedge CLR, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : JKF2B
 CELL TYPE : sequential Logic
 CELL SEQ EQN: JKFF[Q=Q,_CLK=CLK, _CLR=CLR, J=J,k=!K];
-----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module JKF2B(CLR, CLK, Q,J,K);
 input J,K,CLR,CLK;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not	INV_170(K_, K);

 JKFFF JK_U0(Q, J,K,CLK,CLR,VCC, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I3 (_CLR, CLR);
      buf U_c0 (Enable1,CLR);
      buf U_c2 (Enable2, CLR);
      buf U_c6 (Enable7, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   libname	="ex";
	specparam   InputLoad$CLK = 0.0;
	specparam   InputLoad$J = 0.0;
	specparam   InputLoad$K = 0.0;

        // checking timing path for combinatorial output

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
        specparam   tpdLH_CLR_to_Q = (0.1:0.1:0.1);
        specparam   tpdHL_CLR_to_Q = (0.1:0.1:0.1);

	//check timing delay for output




        //check timing delay for output

	if(J == K)
	(negedge CLK => (Q +:J))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	if(J&& !K)
	(negedge CLK => (Q +: ~Q))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge J,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge J,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, posedge J,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, negedge J,0.0, NOTIFY_REG);
	$setup(posedge K,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge K,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, posedge K,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, negedge K,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(negedge CLK,posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable7,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable7, 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checking the recovery data

	$recovery(posedge CLR, negedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : JKF3A
 CELL TYPE : sequential Logic
 CELL SEQ EQN: JKFF[Q=Q,CLK =CLK, _PRE=PRE, J=J,k=!K];
-----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module JKF3A(PRE, CLK, Q,J,K);
 input J,K,PRE,CLK;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not	INV_171(K_, K);

 JKFFR JK_U0(Q, J,K,CLK,VCC,PRE, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I1 (_PRE, PRE);
      buf U_c0 (Enable1,PRE);      buf U_c4 (Enable5, PRE);
      buf U_c6 (Enable7, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   libname	="ex";
	specparam   InputLoad$CLK = 0.0;
	specparam   InputLoad$PRE = 0.0;
	specparam   InputLoad$J = 0.0;
	specparam   InputLoad$K = 0.0;

        // checking timing path for combinatorial output

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
        specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
        specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);

	//check timing delay for output




        //check timing delay for output

	if(J == K)
	(posedge CLK => (Q +:J))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	if(J&& !K)
	(posedge CLK => (Q +: ~Q))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge J,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge J,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge J,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge J,0.0, NOTIFY_REG);
	$setup(posedge K,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge K,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge K,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge K,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable7,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable7, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checking the recovery data

	$recovery(posedge PRE, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*--------------------------------------------------------------
 CELL NAME : JKF3B
 CELL TYPE : sequential Logic
 CELL SEQ EQN: JKFF[Q=Q,_CLK=CLK, _PRE=PRE, J=J,k=!K];
-----------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module JKF3B(PRE, CLK, Q,J,K);
 input J,K,PRE,CLK;
 output Q;
 supply1 VCC;
 supply0 GND;
 reg NOTIFY_REG;

 not	INV_172(K_, K);

 JKFFF JK_U0(Q, J,K,CLK,VCC,PRE, NOTIFY_REG);

// some temp signals created for timing checking sections

      not U_I1 (_PRE, PRE);
      buf U_c0 (Enable1,PRE);      buf U_c4 (Enable5, PRE);
      buf U_c6 (Enable7, PRE);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   libname	="ex";
	specparam   InputLoad$CLK = 0.0;
	specparam   InputLoad$PRE = 0.0;
	specparam   InputLoad$J = 0.0;
	specparam   InputLoad$K = 0.0;

        // checking timing path for combinatorial output

	specparam   tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam   tpdHL_CLK_to_Q = (0.1:0.1:0.1);
        specparam   tpdLH_PRE_to_Q = (0.1:0.1:0.1);
        specparam   tpdHL_PRE_to_Q = (0.1:0.1:0.1);

	//check timing delay for output




        //check timing delay for output

	if(J == K)
	(negedge CLK => (Q +:J))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	if(J&& !K)
	(negedge CLK => (Q +: ~Q))=(tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge PRE => (Q +: 1'b1)) = (tpdLH_PRE_to_Q, tpdHL_PRE_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge J,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge J,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, posedge J,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, negedge J,0.0, NOTIFY_REG);
	$setup(posedge K,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge K,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, posedge K,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, negedge K,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(negedge CLK, posedge PRE,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable7,0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable7, 0, 0, NOTIFY_REG);
	$width(negedge PRE, 0.0, 0, NOTIFY_REG);

	//checking the recovery data

	$recovery(posedge PRE, negedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MAJ3
 CELL TYPE : comb
 CELL LOGIC : Y = (A & B) + (B & C) + (A & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MAJ3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 and      U930(NET_0_0, A, B);
 or       U931(NET_0_2, NET_0_0, NET_0_1);
 and      U933(NET_0_1, B, C);
 or       U934(Y, NET_0_2, NET_0_3);
 and      U936(NET_0_3, A, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MAJ3X
 CELL TYPE : comb
 CELL LOGIC : Y = A & B & !C + A & !B & C + !A & B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MAJ3X(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_173(A_, A);
 not	INV_174(B_, B);
 not	INV_175(C_, C);
 and      U941(NET_0_0, A, B);
 UDP_MUX2   U942(NET_0_4, NET_0_0, NET_0_5, C_);
 and      U945(NET_0_5, A_, B);
 or       U946(Y, NET_0_4, NET_0_3);
 and      U949(NET_0_2, A, B_);
 and      U950(NET_0_3, NET_0_2, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MAJ3XI
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B & !C + A & !B & C + !A & B & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MAJ3XI(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_176(A_, A);
 not	INV_177(B_, B);
 not	INV_178(C_, C);
 and      U955(NET_0_0, A, B);
 UDP_MUX2   U956(NET_0_4, NET_0_0, NET_0_5, C_);
 and      U959(NET_0_5, A_, B);
 nor      U960(Y, NET_0_4, NET_0_3);
 and      U963(NET_0_2, A, B_);
 and      U964(NET_0_3, NET_0_2, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MIN3
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B + !A & !C + !B & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MIN3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_179(A_, A);
 not	INV_180(B_, B);
 not	INV_181(C_, C);
 and      U969(NET_0_0, A_, B_);
 or       U970(NET_0_2, NET_0_0, NET_0_1);
 and      U972(NET_0_1, A_, C_);
 or       U973(Y, NET_0_2, NET_0_3);
 and      U975(NET_0_3, B_, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MIN3X
 CELL TYPE : comb
 CELL LOGIC : Y = A & !B & !C + !A & B & !C + !A & !B & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MIN3X(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_182(A_, A);
 not	INV_183(B_, B);
 not	INV_184(C_, C);
 and      U980(NET_0_0, A, B_);
 UDP_MUX2   U981(NET_0_4, NET_0_0, NET_0_5, C_);
 and      U984(NET_0_5, A_, B_);
 or       U985(Y, NET_0_4, NET_0_3);
 and      U988(NET_0_2, A_, B);
 and      U989(NET_0_3, NET_0_2, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MIN3XI
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & !B & !C + !A & B & !C + !A & !B & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MIN3XI(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6;

 not	INV_185(A_, A);
 not	INV_186(B_, B);
 not	INV_187(C_, C);
 and      U994(NET_0_0, A, B_);
 UDP_MUX2   U995(NET_0_4, NET_0_0, NET_0_5, C_);
 and      U998(NET_0_5, A_, B_);
 nor      U999(Y, NET_0_4, NET_0_3);
 and      U1002(NET_0_2, A_, B);
 and      U1003(NET_0_3, NET_0_2, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MX2
 CELL TYPE : comb
 CELL LOGIC : Y = (A & !S) + (B & S)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MX2(Y,A,S,B);
 input A,S,B;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_188(S_, S);
 UDP_MUX2   U1006(Y, A, B, S_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(S => Y ) = ( tpdLH_S_to_Y, tpdHL_S_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MX2A
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & !S) + (B & S)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MX2A(Y,A,S,B);
 input A,S,B;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_189(A_, A);
 not	INV_190(S_, S);
 UDP_MUX2   U1010(Y, A_, B, S_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(S => Y ) = ( tpdLH_S_to_Y, tpdHL_S_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MX2B
 CELL TYPE : comb
 CELL LOGIC : Y = (A & !S) + (!B & S)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MX2B(Y,A,S,B);
 input A,S,B;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_191(S_, S);
 not	INV_192(B_, B);
 UDP_MUX2   U1014(Y, A, B_, S_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(S => Y ) = ( tpdLH_S_to_Y, tpdHL_S_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MX2C
 CELL TYPE : comb
 CELL LOGIC : Y = (!A & !S) + (!B & S)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MX2C(Y,A,S,B);
 input A,S,B;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_193(A_, A);
 not	INV_194(S_, S);
 not	INV_195(B_, B);
 UDP_MUX2   U1018(Y, A_, B_, S_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(S => Y ) = ( tpdLH_S_to_Y, tpdHL_S_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : MX4
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !S0 + D1 & S0) & !S1 + (D2 & !S0 + D3 & S0) & S1
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module MX4(Y,D0,S0,D1,S1,D2,D3);
 input D0,S0,D1,S1,D2,D3;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7;

 not	INV_196(S0_, S0);
 not	INV_197(S1_, S1);
 UDP_MUX2   U1023(NET_0_2, D0, D1, S0_);
 UDP_MUX2   U1025(Y, NET_0_2, NET_0_6, S1_);
 UDP_MUX2   U1028(NET_0_6, D2, D3, S0_);

       specify

		specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S0_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S0_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_S1_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_S1_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
		(S0 => Y ) = ( tpdLH_S0_to_Y, tpdHL_S0_to_Y );
		(D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
		(S1 => Y ) = ( tpdLH_S1_to_Y, tpdHL_S1_to_Y );
		(D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
		(D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND2
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND2(Y,A,B);
 input A,B;
 output Y;

 nand     U1032(Y, A, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND2A
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND2A(Y,A,B);
 input A,B;
 output Y;

 not	INV_198(A_, A);
 nand     U1035(Y, A_, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND2B
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND2B(Y,A,B);
 input A,B;
 output Y;

 not	INV_199(A_, A);
 not	INV_200(B_, B);
 nand     U1038(Y, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND3
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 and      U1042(NET_0_0, A, B);
 nand     U1043(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND3A
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & B & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND3A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_201(A_, A);
 and      U1047(NET_0_0, A_, B);
 nand     U1048(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND3B
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND3B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_202(A_, A);
 not	INV_203(B_, B);
 and      U1052(NET_0_0, A_, B_);
 nand     U1053(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND3C
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B & !C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND3C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_204(A_, A);
 not	INV_205(B_, B);
 not	INV_206(C_, C);
 and      U1057(NET_0_0, A_, B_);
 nand     U1058(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND4
 CELL TYPE : comb
 CELL LOGIC : Y = !A+!B+!C+!D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND4(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_207(A_, A);
 not	INV_208(B_, B);
 not	INV_209(C_, C);
 not	INV_210(D_, D);
 or       U1063(NET_0_0, A_, B_);
 or       U1064(NET_0_1, NET_0_0, C_);
 or       U1065(Y, NET_0_1, D_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND4A
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & B & C & D )
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND4A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_211(A_, A);
 and      U1070(NET_0_0, A_, B);
 and      U1071(NET_0_1, NET_0_0, C);
 nand     U1072(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND4B
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B & C & D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND4B(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_212(A_, A);
 not	INV_213(B_, B);
 and      U1077(NET_0_0, A_, B_);
 and      U1078(NET_0_1, NET_0_0, C);
 nand     U1079(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND4C
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B & !C & D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND4C(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_214(A_, A);
 not	INV_215(B_, B);
 not	INV_216(C_, C);
 and      U1084(NET_0_0, A_, B_);
 and      U1085(NET_0_1, NET_0_0, C_);
 nand     U1086(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND4D
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B & !C & !D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND4D(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_217(A_, A);
 not	INV_218(B_, B);
 not	INV_219(C_, C);
 not	INV_220(D_, D);
 and      U1091(NET_0_0, A_, B_);
 and      U1092(NET_0_1, NET_0_0, C_);
 nand     U1093(Y, NET_0_1, D_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND5B
 CELL TYPE : comb
 CELL LOGIC : Y = ! ( !A & !B & C & D & E )
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND5B(Y,A,B,C,D,E);
 input A,B,C,D,E;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 not	INV_221(A_, A);
 not	INV_222(B_, B);
 and      U1099(NET_0_0, A_, B_);
 and      U1100(NET_0_1, NET_0_0, C);
 and      U1101(NET_0_2, NET_0_1, D);
 nand     U1102(Y, NET_0_2, E);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_E_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_E_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
		(E => Y ) = ( tpdLH_E_to_Y, tpdHL_E_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NAND5C
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A & !B & !C & D & E)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NAND5C(Y,A,B,C,D,E);
 input A,B,C,D,E;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 not	INV_223(A_, A);
 not	INV_224(B_, B);
 not	INV_225(C_, C);
 and      U1108(NET_0_0, A_, B_);
 and      U1109(NET_0_1, NET_0_0, C_);
 and      U1110(NET_0_2, NET_0_1, D);
 nand     U1111(Y, NET_0_2, E);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_E_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_E_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
		(E => Y ) = ( tpdLH_E_to_Y, tpdHL_E_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR2
 CELL TYPE : comb
 CELL LOGIC : Y = !(A + B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR2(Y,A,B);
 input A,B;
 output Y;

 nor      U1114(Y, A, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR2A
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR2A(Y,A,B);
 input A,B;
 output Y;

 not	INV_226(A_, A);
 nor      U1117(Y, A_, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR2B
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + !B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR2B(Y,A,B);
 input A,B;
 output Y;

 not	INV_227(A_, A);
 not	INV_228(B_, B);
 nor      U1120(Y, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR3
 CELL TYPE : comb
 CELL LOGIC : Y = !(A + B + C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 or       U1124(NET_0_0, A, B);
 nor      U1125(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR3A
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + B + C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR3A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_229(A_, A);
 or       U1129(NET_0_0, A_, B);
 nor      U1130(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR3B
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + !B + C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR3B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_230(A_, A);
 not	INV_231(B_, B);
 or       U1134(NET_0_0, A_, B_);
 nor      U1135(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR3C
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + !B + !C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR3C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_232(A_, A);
 not	INV_233(B_, B);
 not	INV_234(C_, C);
 or       U1139(NET_0_0, A_, B_);
 nor      U1140(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR4
 CELL TYPE : comb
 CELL LOGIC : Y = !A & !B & !C & !D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR4(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_235(A_, A);
 not	INV_236(B_, B);
 not	INV_237(C_, C);
 not	INV_238(D_, D);
 and      U1145(NET_0_0, A_, B_);
 and      U1146(NET_0_1, NET_0_0, C_);
 and      U1147(Y, NET_0_1, D_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR4A
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + B + C + D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR4A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_239(A_, A);
 or       U1152(NET_0_0, A_, B);
 or       U1153(NET_0_1, NET_0_0, C);
 nor      U1154(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR4B
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + !B + C + D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR4B(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_240(A_, A);
 not	INV_241(B_, B);
 or       U1159(NET_0_0, A_, B_);
 or       U1160(NET_0_1, NET_0_0, C);
 nor      U1161(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR4C
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + !B + !C + D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR4C(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_242(A_, A);
 not	INV_243(B_, B);
 not	INV_244(C_, C);
 or       U1166(NET_0_0, A_, B_);
 or       U1167(NET_0_1, NET_0_0, C_);
 nor      U1168(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR4D
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + !B + !C + !D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR4D(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_245(A_, A);
 not	INV_246(B_, B);
 not	INV_247(C_, C);
 not	INV_248(D_, D);
 or       U1173(NET_0_0, A_, B_);
 or       U1174(NET_0_1, NET_0_0, C_);
 nor      U1175(Y, NET_0_1, D_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR5B
 CELL TYPE : comb
 CELL LOGIC : Y = ! ( !A + !B + C + D + E )
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR5B(Y,A,B,C,D,E);
 input A,B,C,D,E;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 not	INV_249(A_, A);
 not	INV_250(B_, B);
 or       U1181(NET_0_0, A_, B_);
 or       U1182(NET_0_1, NET_0_0, C);
 or       U1183(NET_0_2, NET_0_1, D);
 nor      U1184(Y, NET_0_2, E);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_E_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_E_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
		(E => Y ) = ( tpdLH_E_to_Y, tpdHL_E_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : NOR5C
 CELL TYPE : comb
 CELL LOGIC : Y = !(!A + !B + !C + D + E)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module NOR5C(Y,A,B,C,D,E);
 input A,B,C,D,E;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 not	INV_251(A_, A);
 not	INV_252(B_, B);
 not	INV_253(C_, C);
 or       U1190(NET_0_0, A_, B_);
 or       U1191(NET_0_1, NET_0_0, C_);
 or       U1192(NET_0_2, NET_0_1, D);
 nor      U1193(Y, NET_0_2, E);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_E_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_E_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
		(E => Y ) = ( tpdLH_E_to_Y, tpdHL_E_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA1
 CELL TYPE : comb
 CELL LOGIC : Y = (A + B) & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 or       U1197(NET_0_0, A, B);
 and      U1198(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA1A
 CELL TYPE : comb
 CELL LOGIC : Y = (!A + B) & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA1A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_254(A_, A);
 or       U1202(NET_0_0, A_, B);
 and      U1203(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA1B
 CELL TYPE : comb
 CELL LOGIC : Y = (A + B) & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA1B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_255(C_, C);
 or       U1207(NET_0_0, A, B);
 and      U1208(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA1C
 CELL TYPE : comb
 CELL LOGIC : Y = (!A + B) & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA1C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_256(A_, A);
 not	INV_257(C_, C);
 or       U1212(NET_0_0, A_, B);
 and      U1213(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA2
 CELL TYPE : comb
 CELL LOGIC : Y = (A + B) & (C + D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA2(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 or       U1217(NET_0_0, A, B);
 and      U1218(Y, NET_0_0, NET_0_1);
 or       U1220(NET_0_1, C, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA2A
 CELL TYPE : comb
 CELL LOGIC : Y = (!A + B) & (C + D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA2A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_258(A_, A);
 or       U1224(NET_0_0, A_, B);
 and      U1225(Y, NET_0_0, NET_0_1);
 or       U1227(NET_0_1, C, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA3
 CELL TYPE : comb
 CELL LOGIC : Y = ((A + B) & C & D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA3(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 or       U1232(NET_0_0, A, B);
 and      U1233(NET_0_1, NET_0_0, C);
 and      U1234(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA3A
 CELL TYPE : comb
 CELL LOGIC : Y = ((A + B) & !C & D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA3A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_259(C_, C);
 or       U1239(NET_0_0, A, B);
 and      U1240(NET_0_1, NET_0_0, C_);
 and      U1241(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA3B
 CELL TYPE : comb
 CELL LOGIC : Y = ((!A + B) & !C & D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA3B(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_260(A_, A);
 not	INV_261(C_, C);
 or       U1246(NET_0_0, A_, B);
 and      U1247(NET_0_1, NET_0_0, C_);
 and      U1248(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA4
 CELL TYPE : comb
 CELL LOGIC : Y = (A + B + C) & D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA4(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 or       U1253(NET_0_0, A, B);
 or       U1254(NET_0_1, NET_0_0, C);
 and      U1255(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA4A
 CELL TYPE : comb
 CELL LOGIC : Y = ((A + B + !C) & D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA4A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_262(C_, C);
 or       U1260(NET_0_0, A, B);
 or       U1261(NET_0_1, NET_0_0, C_);
 and      U1262(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OA5
 CELL TYPE : comb
 CELL LOGIC : Y = (A+B+C) & (A+D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OA5(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 or       U1267(NET_0_0, A, B);
 or       U1268(NET_0_1, NET_0_0, C);
 and      U1269(Y, NET_0_1, NET_0_2);
 or       U1271(NET_0_2, A, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OAI1
 CELL TYPE : comb
 CELL LOGIC : Y = !((A + B) & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OAI1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 or       U1275(NET_0_0, A, B);
 nand     U1276(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OAI2A
 CELL TYPE : comb
 CELL LOGIC : Y = !((A + B + C) & !D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OAI2A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_263(D_, D);
 or       U1281(NET_0_0, A, B);
 or       U1282(NET_0_1, NET_0_0, C);
 nand     U1283(Y, NET_0_1, D_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OAI3
 CELL TYPE : comb
 CELL LOGIC : Y = !((A + B) & C & D)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OAI3(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 or       U1288(NET_0_0, A, B);
 and      U1289(NET_0_1, NET_0_0, C);
 nand     U1290(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OAI3A
 CELL TYPE : comb
 CELL LOGIC : Y = !((A + B) & !C & !D )
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OAI3A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_264(C_, C);
 not	INV_265(D_, D);
 or       U1295(NET_0_0, A, B);
 and      U1296(NET_0_1, NET_0_0, C_);
 nand     U1297(Y, NET_0_1, D_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR2
 CELL TYPE : comb
 CELL LOGIC : Y = A + B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR2(Y,A,B);
 input A,B;
 output Y;

 or       U1300(Y, A, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR2A
 CELL TYPE : comb
 CELL LOGIC : Y = !A + B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR2A(Y,A,B);
 input A,B;
 output Y;

 not	INV_266(A_, A);
 or       U1303(Y, A_, B);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR2B
 CELL TYPE : comb
 CELL LOGIC : Y = !A + !B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR2B(Y,A,B);
 input A,B;
 output Y;

 not	INV_267(A_, A);
 not	INV_268(B_, B);
 or       U1306(Y, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR3
 CELL TYPE : comb
 CELL LOGIC : Y = A + B + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 or       U1310(NET_0_0, A, B);
 or       U1311(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR3A
 CELL TYPE : comb
 CELL LOGIC : Y = !A + B + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR3A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_269(A_, A);
 or       U1315(NET_0_0, A_, B);
 or       U1316(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR3B
 CELL TYPE : comb
 CELL LOGIC : Y = !A + !B + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR3B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_270(A_, A);
 not	INV_271(B_, B);
 or       U1320(NET_0_0, A_, B_);
 or       U1321(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR3C
 CELL TYPE : comb
 CELL LOGIC : Y = !A + !B + !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR3C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_272(A_, A);
 not	INV_273(B_, B);
 not	INV_274(C_, C);
 or       U1325(NET_0_0, A_, B_);
 or       U1326(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR4
 CELL TYPE : comb
 CELL LOGIC : Y = A + B + C + D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR4(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 or       U1331(NET_0_0, A, B);
 or       U1332(NET_0_1, NET_0_0, C);
 or       U1333(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR4A
 CELL TYPE : comb
 CELL LOGIC : Y = !A + B + C + D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR4A(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_275(A_, A);
 or       U1338(NET_0_0, A_, B);
 or       U1339(NET_0_1, NET_0_0, C);
 or       U1340(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR4B
 CELL TYPE : comb
 CELL LOGIC : Y = !A + !B + C + D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR4B(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_276(A_, A);
 not	INV_277(B_, B);
 or       U1345(NET_0_0, A_, B_);
 or       U1346(NET_0_1, NET_0_0, C);
 or       U1347(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR4C
 CELL TYPE : comb
 CELL LOGIC : Y = !A + !B + !C + D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR4C(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_278(A_, A);
 not	INV_279(B_, B);
 not	INV_280(C_, C);
 or       U1352(NET_0_0, A_, B_);
 or       U1353(NET_0_1, NET_0_0, C_);
 or       U1354(Y, NET_0_1, D);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR4D
 CELL TYPE : comb
 CELL LOGIC : Y = !A+!B+!C+!D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR4D(Y,A,B,C,D);
 input A,B,C,D;
 output Y;
 wire NET_0_0, NET_0_1;

 not	INV_281(A_, A);
 not	INV_282(B_, B);
 not	INV_283(C_, C);
 not	INV_284(D_, D);
 or       U1359(NET_0_0, A_, B_);
 or       U1360(NET_0_1, NET_0_0, C_);
 or       U1361(Y, NET_0_1, D_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR5A
 CELL TYPE : comb
 CELL LOGIC : Y =  !A + B + C + D + E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR5A(Y,A,B,C,D,E);
 input A,B,C,D,E;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 not	INV_285(A_, A);
 or       U1367(NET_0_0, A_, B);
 or       U1368(NET_0_1, NET_0_0, C);
 or       U1369(NET_0_2, NET_0_1, D);
 or       U1370(Y, NET_0_2, E);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_E_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_E_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
		(E => Y ) = ( tpdLH_E_to_Y, tpdHL_E_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR5B
 CELL TYPE : comb
 CELL LOGIC : Y = !A + !B + C + D + E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR5B(Y,A,B,C,D,E);
 input A,B,C,D,E;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 not	INV_286(A_, A);
 not	INV_287(B_, B);
 or       U1376(NET_0_0, A_, B_);
 or       U1377(NET_0_1, NET_0_0, C);
 or       U1378(NET_0_2, NET_0_1, D);
 or       U1379(Y, NET_0_2, E);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_E_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_E_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
		(E => Y ) = ( tpdLH_E_to_Y, tpdHL_E_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OR5C
 CELL TYPE : comb
 CELL LOGIC : Y = !A+!B+!C+D+E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OR5C(Y,A,B,C,D,E);
 input A,B,C,D,E;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2;

 not	INV_288(A_, A);
 not	INV_289(B_, B);
 not	INV_290(C_, C);
 or       U1385(NET_0_0, A_, B_);
 or       U1386(NET_0_1, NET_0_0, C_);
 or       U1387(NET_0_2, NET_0_1, D);
 or       U1388(Y, NET_0_2, E);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_D_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_D_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_E_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_E_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
		(D => Y ) = ( tpdLH_D_to_Y, tpdHL_D_to_Y );
		(E => Y ) = ( tpdLH_E_to_Y, tpdHL_E_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : OUTBUF
 CELL TYPE : comb
 CELL LOGIC : PAD=D
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF(PAD,D);
 input D;
 output PAD;

 buf	BUF_U_00(PAD,D);

       specify

		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(D => PAD ) = ( tpdLH_D_to_PAD, tpdHL_D_to_PAD );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : TF1A
 CELL TYPE : TFF Logic
 CELL SEQ EQN : TFF[Q=Q,CLK =CLK, _CLR=CLR, T=T]
-----------------------------------------------------------------*/


`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TF1A(CLR, CLK, Q,T);
 input T,CLR,CLK;
 output Q;
 reg NOTIFY_REG;

 not NT1 (Q_, Q_INT);
 UDP_MUX2 #(0.1:0.1:0.1) inst1 (D_EFF,Q_, Q_INT,T);

 UFPRB TFF_U0(Q_INT, D_EFF,CLK, CLR,NOTIFY_REG);
  buf QBUF(Q,Q_INT);

// some temp signals created for timing checking sections

        not U_I2 (_CLR, CLR);
      buf U_c0 (Enable1,CLR);
      buf U_c6 (Enable7, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   libname	= "ex";
	specparam   macrotype   = "T-flipflop";
	specparam   InputLoad$CLK = 0.0;
	specparam   InputLoad$T = 0.0;

	specparam    tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);

        //check timing delay for output




	if(T && CLR)
	(posedge CLK => (Q -:Q)) = (tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge T,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge T,posedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, posedge T,0.0, NOTIFY_REG);
	$hold(posedge CLK &&& Enable1, negedge T,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(posedge CLK, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable1 , 0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable1 , 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checking the recovery data

	$recovery(posedge CLR, posedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults


/*---------------------------------------------------------------
 CELL NAME : TF1B
 CELL TYPE : TFF Logic
 CELL SEQ EQN : TFF[Q=Q,_CLK=CLK, _CLR=CLR, T=T]
-----------------------------------------------------------------*/


`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TF1B(CLR, CLK, Q,T);
 input T,CLR,CLK;
 output Q;
 reg NOTIFY_REG;

 not NT1 (Q_, Q_INT);
 UDP_MUX2 #(0.1:0.1:0.1) inst1 (D_EFF,Q_, Q_INT,T);

 UFNRB TFF_U0(Q_INT, D_EFF,CLK, CLR,NOTIFY_REG);
  buf QBUF(Q,Q_INT);

// some temp signals created for timing checking sections

        not U_I0 (_CLK, CLK);
        not U_I2 (_CLR, CLR);
      buf U_c0 (Enable1,CLR);
      buf U_c6 (Enable7, CLR);

//--------------------------------------------------------------
//              Timing Checking Section 
//-------------------------------------------------------------

 specify

	specparam   libname	= "ex";
	specparam   macrotype   = "T-flipflop";
	specparam   InputLoad$CLK = 0.0;
	specparam   InputLoad$T = 0.0;

	specparam    tpdLH_CLK_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLK_to_Q = (0.1:0.1:0.1);
	specparam    tpdLH_CLR_to_Q = (0.1:0.1:0.1);
	specparam    tpdHL_CLR_to_Q = (0.1:0.1:0.1);

        //check timing delay for output




	if(T && CLR)
	(negedge CLK => (Q -:Q)) = (tpdLH_CLK_to_Q, tpdHL_CLK_to_Q);
	(negedge CLR => (Q +: 1'b0)) = (tpdLH_CLR_to_Q, tpdHL_CLR_to_Q);

	//checking setup and hold timing for inputs

	$setup(posedge T,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$setup(negedge T,negedge CLK &&& Enable1, 0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, posedge T,0.0, NOTIFY_REG);
	$hold(negedge CLK &&& Enable1, negedge T,0.0, NOTIFY_REG);

	//checking timing for control signals

	$hold(negedge CLK, posedge CLR,0.0, NOTIFY_REG);

	//checking the pulse width

	$width(posedge CLK &&& Enable1 , 0,  0, NOTIFY_REG);
	$width(negedge CLK &&& Enable1 , 0, 0, NOTIFY_REG);
	$width(negedge CLR, 0.0, 0, NOTIFY_REG);

	//checking the recovery data

	$recovery(posedge CLR, negedge CLK, 0.0, NOTIFY_REG);

 endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : TRIBUFF
 CELL TYPE : comb
 CELL LOGIC : PAD=D@E
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module TRIBUFF(PAD,D,E);
 input D,E;
 output PAD;

 bufif1   U1391(PAD, D, E);

       specify

		specparam tpdLH_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdHL_E_to_PAD = (0.0:0.0:0.0);
		specparam tpdLZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZL_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdHZ_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdZH_E_to_PAD = (0.1:0.1:0.1);
		specparam tpdLH_D_to_PAD = (0.1:0.1:0.1);
		specparam tpdHL_D_to_PAD = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

	    //if(~D)
                (E => PAD ) = ( tpdLH_E_to_PAD,tpdHL_E_to_PAD,tpdLZ_E_to_PAD,tpdZH_E_to_PAD,tpdHZ_E_to_PAD,tpdZL_E_to_PAD);

	        (D => PAD ) = ( tpdLH_D_to_PAD,tpdHL_D_to_PAD);
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : VCC
 CELL TYPE : comb
 CELL LOGIC : Y = 1
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module VCC(Y);
 output Y;

 supply1    Y;

       specify

		specparam MacroType = "comb";

		//pin to pin path delay 

   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XA1
 CELL TYPE : comb
 CELL LOGIC : Y = (A ^ B) & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XA1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_291(A_, A);
 not	INV_292(B_, B);
 UDP_MUX2   U1395(NET_0_0, B, B_, A_);
 and      U1397(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XA1A
 CELL TYPE : comb
 CELL LOGIC : Y = !(A ^ B) & C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XA1A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_293(A_, A);
 not	INV_294(B_, B);
 UDPN_MUX2  U1401(NET_0_0, B, B_, A_);
 and      U1403(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XA1B
 CELL TYPE : comb
 CELL LOGIC : Y = (A ^ B) & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XA1B(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_295(A_, A);
 not	INV_296(B_, B);
 not	INV_297(C_, C);
 UDP_MUX2   U1407(NET_0_0, B, B_, A_);
 and      U1409(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XA1C
 CELL TYPE : comb
 CELL LOGIC : Y = !(A ^ B) & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XA1C(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_298(A_, A);
 not	INV_299(B_, B);
 not	INV_300(C_, C);
 UDPN_MUX2  U1413(NET_0_0, B, B_, A_);
 and      U1415(Y, NET_0_0, C_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XAI1
 CELL TYPE : comb
 CELL LOGIC : Y = !((A ^ B) & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XAI1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_301(A_, A);
 not	INV_302(B_, B);
 UDP_MUX2   U1419(NET_0_0, B, B_, A_);
 nand     U1421(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XAI1A
 CELL TYPE : comb
 CELL LOGIC : Y = !(!(A ^ B) & C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XAI1A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_303(A_, A);
 not	INV_304(B_, B);
 UDPN_MUX2  U1425(NET_0_0, B, B_, A_);
 nand     U1427(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XNOR2
 CELL TYPE : comb
 CELL LOGIC : Y = !(A ^ B)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XNOR2(Y,A,B);
 input A,B;
 output Y;

 not	INV_305(A_, A);
 not	INV_306(B_, B);
 UDPN_MUX2  U1430(Y, B, B_, A_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XNOR3
 CELL TYPE : comb
 CELL LOGIC : Y = !(A ^ B ^ C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XNOR3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_307(A_, A);
 not	INV_308(B_, B);
 UDP_MUX2   U1435(NET_0_0, B, B_, A_);
 xnor     U1437(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XO1
 CELL TYPE : comb
 CELL LOGIC : Y = (A ^ B) + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XO1(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_309(A_, A);
 not	INV_310(B_, B);
 UDP_MUX2   U1441(NET_0_0, B, B_, A_);
 or       U1443(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XO1A
 CELL TYPE : comb
 CELL LOGIC : Y = !(A ^ B) + C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XO1A(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_311(A_, A);
 not	INV_312(B_, B);
 UDPN_MUX2  U1447(NET_0_0, B, B_, A_);
 or       U1449(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XOR2
 CELL TYPE : comb
 CELL LOGIC : Y = A ^ B
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XOR2(Y,A,B);
 input A,B;
 output Y;

 not	INV_313(A_, A);
 not	INV_314(B_, B);
 UDP_MUX2   U1452(Y, B, B_, A_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : XOR3
 CELL TYPE : comb
 CELL LOGIC : Y = A ^ B ^ C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module XOR3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0;

 not	INV_315(A_, A);
 not	INV_316(B_, B);
 UDP_MUX2   U1457(NET_0_0, B, B_, A_);
 xor      U1459(Y, NET_0_0, C);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : ZOR3
 CELL TYPE : comb
 CELL LOGIC : Y = A & B & C + !A & !B & !C
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module ZOR3(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_317(A_, A);
 not	INV_318(B_, B);
 not	INV_319(C_, C);
 and      U1463(NET_0_0, A, B);
 UDP_MUX2   U1464(Y, NET_0_0, NET_0_2, C);
 and      U1467(NET_0_2, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : ZOR3I
 CELL TYPE : comb
 CELL LOGIC : Y = !(A & B & C + !A & !B & !C)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module ZOR3I(Y,A,B,C);
 input A,B,C;
 output Y;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3;

 not	INV_320(A_, A);
 not	INV_321(B_, B);
 not	INV_322(C_, C);
 and      U1471(NET_0_0, A, B);
 UDPN_MUX2  U1472(Y, NET_0_0, NET_0_2, C);
 and      U1475(NET_0_2, A_, B_);

       specify

		specparam tpdLH_A_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_A_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_B_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_B_to_Y = (0.1:0.1:0.1);
		specparam tpdLH_C_to_Y = (0.1:0.1:0.1);
		specparam tpdHL_C_to_Y = (0.1:0.1:0.1);
		specparam MacroType = "comb";

		//pin to pin path delay 

		(A => Y ) = ( tpdLH_A_to_Y, tpdHL_A_to_Y );
		(B => Y ) = ( tpdLH_B_to_Y, tpdHL_B_to_Y );
		(C => Y ) = ( tpdLH_C_to_Y, tpdHL_C_to_Y );
   endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : FA1A
 CELL TYPE : comb
 CELL LOGIC : CO=(CI & !B & !A) + (A & !B ) + (B & CI & A) % S=!CI & ( !A & B + A & !B ) + CI & ( !A & !B + A & B )
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module FA1A(CO,S,CI,B,A);
 input CI,B,A;
 output CO,S;



    not     NT4    (B_INT, B);
    xnor    XNR1    (S, A, B_INT, CI);
    U_MAJ_3 inst1  (CO, A, B_INT, CI);


        specify
                specparam tpdLH_CI_to_CO = (0.1:0.1:0.1);
                specparam tpdHL_CI_to_CO = (0.1:0.1:0.1);
                specparam tpdLH_B_to_CO = (0.1:0.1:0.1);
                specparam tpdHL_B_to_CO = (0.1:0.1:0.1);
                specparam tpdLH_A_to_CO = (0.1:0.1:0.1);
                specparam tpdHL_A_to_CO = (0.1:0.1:0.1);
                specparam tpdLH_CI_to_S = (0.1:0.1:0.1);
                specparam tpdHL_CI_to_S = (0.1:0.1:0.1);
                specparam tpdLH_A_to_S = (0.1:0.1:0.1);
                specparam tpdHL_A_to_S = (0.1:0.1:0.1);
                specparam tpdLH_B_to_S = (0.1:0.1:0.1);
                specparam tpdHL_B_to_S = (0.1:0.1:0.1);
                specparam MacroType = "comb";

                //pin to pin path delay

                (CI => CO ) = ( tpdLH_CI_to_CO, tpdHL_CI_to_CO );
                (B => CO ) = ( tpdLH_B_to_CO, tpdHL_B_to_CO );
                (A => CO ) = ( tpdLH_A_to_CO, tpdHL_A_to_CO );
                (CI => S ) = ( tpdLH_CI_to_S, tpdHL_CI_to_S );
                (A => S ) = ( tpdLH_A_to_S, tpdHL_A_to_S );
                (B => S ) = ( tpdLH_B_to_S, tpdHL_B_to_S );
        endspecify


endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



/*--------------------------------------------------------------------
 CELL NAME : FA1B
 CELL TYPE : comb
 CELL LOGIC : CO=!A & (!B + B & CI) + A & (!B & CI) % S=!CI & ( !A & !B + A & B ) + CI & ( !A & B + A & !B )
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module FA1B(CO,S,A,B,CI);
 input A,B,CI;
 output CO,S;


    not     NT3    (A_INT, A);
    not     NT4    (B_INT, B);
    xnor    XNR1   (S, A_INT, B_INT, CI);
    U_MAJ_3 inst1  (CO, A_INT, B_INT, CI);


        specify
                specparam tpdLH_A_to_CO = (0.1:0.1:0.1);
                specparam tpdHL_A_to_CO = (0.1:0.1:0.1);
                specparam tpdLH_B_to_CO = (0.1:0.1:0.1);
                specparam tpdHL_B_to_CO = (0.1:0.1:0.1);
                specparam tpdLH_CI_to_CO = (0.1:0.1:0.1);
                specparam tpdHL_CI_to_CO = (0.1:0.1:0.1);
                specparam tpdLH_CI_to_S = (0.1:0.1:0.1);
                specparam tpdHL_CI_to_S = (0.1:0.1:0.1);
                specparam tpdLH_A_to_S = (0.1:0.1:0.1);
                specparam tpdHL_A_to_S = (0.1:0.1:0.1);
                specparam tpdLH_B_to_S = (0.1:0.1:0.1);
                specparam tpdHL_B_to_S = (0.1:0.1:0.1);
                specparam MacroType = "comb";

                //pin to pin path delay

                (A => CO ) = ( tpdLH_A_to_CO, tpdHL_A_to_CO );
                (B => CO ) = ( tpdLH_B_to_CO, tpdHL_B_to_CO );
                (CI => CO ) = ( tpdLH_CI_to_CO, tpdHL_CI_to_CO );
                (CI => S ) = ( tpdLH_CI_to_S, tpdHL_CI_to_S );
                (A => S ) = ( tpdLH_A_to_S, tpdHL_A_to_S );
                (B => S ) = ( tpdLH_B_to_S, tpdHL_B_to_S );
        endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults





/*--------------------------------------------------------------------
 CELL NAME : FA2A
 CELL TYPE : comb
 CELL LOGIC : CO=(CI & !B & !(A0+A1)) + (!B & (A0+A1)) + (B & CI & (A0+A1))
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module FA2A(S, CO,CI,B,A0,A1);
 input CI,B,A0,A1;
 output CO, S ;




    or      OR1    (A_INT, A0, A1);
    not     NT3    (B_INT, B);
    xnor    XNR1   (S, A_INT, B_INT, CI);
    U_MAJ_3 inst1  (CO, A_INT, B_INT, CI);


        specify
                specparam tpdLH_CI_to_CO = (0.1:0.1:0.1);
                specparam tpdHL_CI_to_CO = (0.1:0.1:0.1);
                specparam tpdLH_B_to_CO = (0.1:0.1:0.1);
                specparam tpdHL_B_to_CO = (0.1:0.1:0.1);
                specparam tpdLH_A0_to_CO = (0.1:0.1:0.1);
                specparam tpdHL_A0_to_CO = (0.1:0.1:0.1);
                specparam tpdLH_A1_to_CO = (0.1:0.1:0.1);
                specparam tpdHL_A1_to_CO = (0.1:0.1:0.1);
                specparam MacroType = "comb";

                //pin to pin path delay

                (CI => CO ) = ( tpdLH_CI_to_CO, tpdHL_CI_to_CO );
                (B => CO ) = ( tpdLH_B_to_CO, tpdHL_B_to_CO );
                (A0 => CO ) = ( tpdLH_A0_to_CO, tpdHL_A0_to_CO );
                (A1 => CO ) = ( tpdLH_A1_to_CO, tpdHL_A1_to_CO );

                (CI => S ) = ( tpdLH_CI_to_CO, tpdHL_CI_to_CO );
                (B => S ) = ( tpdLH_B_to_CO, tpdHL_B_to_CO );
                (A0 => S ) = ( tpdLH_A0_to_CO, tpdHL_A0_to_CO );
                (A1 => S ) = ( tpdLH_A1_to_CO, tpdHL_A1_to_CO );

        endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults




/*--------------------------------------------------------------------
 CELL NAME : CM8F
 CELL TYPE : comb
 CELL LOGIC : Y = (D0 & !(S00 & S01) + D1 & (S00 & S01)) & !(S10+S11) + (D2 & !(S00 & S01) + D3 & (S00 & S01)) & (S10+S11) % FY =(D0 & !(
S00 & S01) + D1 & (S00 & S01)) & !(S10+S11) + (D2 & !(S00 & S01) + D3 & (S00 & S01)) & (S10+S11)
---------------------------------------------------------------------*/

`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module CM8F(Y,FY,D0,S00,S01,D1,S10,S11,D2,D3);
 input D0,S00,S01,D1,S10,S11,D2,D3;
 output Y,FY;
 wire NET_0_0, NET_0_1, NET_0_2, NET_0_3, NET_0_4, NET_0_5;
 wire NET_0_6, NET_0_7, NET_0_8, NET_0_9, NET_0_10, NET_0_11, NET_0_12, NET_0_13;
 wire NET_1_0, NET_1_1, NET_1_2, NET_1_3, NET_1_4, NET_1_5;
 wire NET_1_6, NET_1_7, NET_1_8, NET_1_9, NET_1_10, NET_1_11, NET_1_12, NET_1_13;

 UDP_MUX2   U580(NET_0_4, D0, D1, NET_0_0);
 nand     U582(NET_0_0, S00, S01);
 UDP_MUX2   U584(Y, NET_0_4, NET_0_11, NET_0_5);
 nor      U586(NET_0_5, S10, S11);
 UDP_MUX2   U589(NET_0_11, D2, D3, NET_0_7);
 nand     U591(NET_0_7, S00, S01);
 UDP_MUX2   U596(NET_1_4, D0, D1, NET_1_0);
 nand     U598(NET_1_0, S00, S01);
 UDP_MUX2   U600(FY, NET_1_4, NET_1_11, NET_1_5);
 nor      U602(NET_1_5, S10, S11);
 UDP_MUX2   U605(NET_1_11, D2, D3, NET_1_7);
 nand     U607(NET_1_7, S00, S01);

      specify
                specparam tpdLH_D0_to_Y = (0.1:0.1:0.1);
                specparam tpdHL_D0_to_Y = (0.1:0.1:0.1);
                specparam tpdLH_S00_to_Y = (0.1:0.1:0.1);
                specparam tpdHL_S00_to_Y = (0.1:0.1:0.1);
                specparam tpdLH_S01_to_Y = (0.1:0.1:0.1);
                specparam tpdHL_S01_to_Y = (0.1:0.1:0.1);
                specparam tpdLH_D1_to_Y = (0.1:0.1:0.1);
                specparam tpdHL_D1_to_Y = (0.1:0.1:0.1);
                specparam tpdLH_S10_to_Y = (0.1:0.1:0.1);
                specparam tpdHL_S10_to_Y = (0.1:0.1:0.1);
                specparam tpdLH_S11_to_Y = (0.1:0.1:0.1);
                specparam tpdHL_S11_to_Y = (0.1:0.1:0.1);
                specparam tpdLH_D2_to_Y = (0.1:0.1:0.1);
                specparam tpdHL_D2_to_Y = (0.1:0.1:0.1);
                specparam tpdLH_D3_to_Y = (0.1:0.1:0.1);
                specparam tpdHL_D3_to_Y = (0.1:0.1:0.1);
                specparam tpdLH_D0_to_FY = (0.1:0.1:0.1);
                specparam tpdHL_D0_to_FY = (0.1:0.1:0.1);
                specparam tpdLH_S00_to_FY = (0.1:0.1:0.1);
                specparam tpdHL_S00_to_FY = (0.1:0.1:0.1);
                specparam tpdLH_S01_to_FY = (0.1:0.1:0.1);
                specparam tpdHL_S01_to_FY = (0.1:0.1:0.1);
                specparam tpdLH_D1_to_FY = (0.1:0.1:0.1);
                specparam tpdHL_D1_to_FY = (0.1:0.1:0.1);
                specparam tpdLH_S10_to_FY = (0.1:0.1:0.1);
                specparam tpdHL_S10_to_FY = (0.1:0.1:0.1);
                specparam tpdLH_S11_to_FY = (0.1:0.1:0.1);
                specparam tpdHL_S11_to_FY = (0.1:0.1:0.1);
                specparam tpdLH_D2_to_FY = (0.1:0.1:0.1);
                specparam tpdHL_D2_to_FY = (0.1:0.1:0.1);
                specparam tpdLH_D3_to_FY = (0.1:0.1:0.1);
                specparam tpdHL_D3_to_FY = (0.1:0.1:0.1);
                specparam MacroType = "comb";

                //pin to pin path delay

                (D0 => Y ) = ( tpdLH_D0_to_Y, tpdHL_D0_to_Y );
                (S00 => Y ) = ( tpdLH_S00_to_Y, tpdHL_S00_to_Y );
                (S01 => Y ) = ( tpdLH_S01_to_Y, tpdHL_S01_to_Y );
                (D1 => Y ) = ( tpdLH_D1_to_Y, tpdHL_D1_to_Y );
                (S10 => Y ) = ( tpdLH_S10_to_Y, tpdHL_S10_to_Y );
                (S11 => Y ) = ( tpdLH_S11_to_Y, tpdHL_S11_to_Y );
                (D2 => Y ) = ( tpdLH_D2_to_Y, tpdHL_D2_to_Y );
                (D3 => Y ) = ( tpdLH_D3_to_Y, tpdHL_D3_to_Y );
                (D0 => FY ) = ( tpdLH_D0_to_FY, tpdHL_D0_to_FY );
                (S00 => FY ) = ( tpdLH_S00_to_FY, tpdHL_S00_to_FY );
                (S01 => FY ) = ( tpdLH_S01_to_FY, tpdHL_S01_to_FY );
                (D1 => FY ) = ( tpdLH_D1_to_FY, tpdHL_D1_to_FY );
                (S10 => FY ) = ( tpdLH_S10_to_FY, tpdHL_S10_to_FY );
                (S11 => FY ) = ( tpdLH_S11_to_FY, tpdHL_S11_to_FY );
                (D2 => FY ) = ( tpdLH_D2_to_FY, tpdHL_D2_to_FY );
                (D3 => FY ) = ( tpdLH_D3_to_FY, tpdHL_D3_to_FY );
        endspecify

endmodule

`endcelldefine
`disable_portfaults
`nosuppress_faults



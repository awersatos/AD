/*  
               =========================================
               =                                       =
               =         AXCELERATOR VERILOG  LIB              =
               =        ACTEL  CORPORATION             =
               =                                       =
               =========================================
*/ 
  
 //BUILT on 07/25/01 18:04:13 
 // Updated 2/3/05 by DNW.


 `timescale 1 ns / 100 ps

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
//-                    cell  UDP_UFNRBSX.v                                  -
//--------------------------------------------------------------------


primitive UDP_UFNRBSX  (Q, D, CP, RB, SB, NOTIFY_REG);

    output Q;
    input  D, CP, RB, SB, NOTIFY_REG;
    reg    Q;

// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET AND CLEAR. CLEAR PRIORITY WHEN BOTH
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
        ?   ?       0   0       ?      :   ?   :   0;  // CLR Priority

        ?   (?1)    ?   ?       ?      :   ?   :   -;  // ignore rising clock
        ?   (0x)    ?   ?       ?      :   ?   :   -;  // ignore rising clock
        *    ?      ?   ?       ?      :   ?   :   -;  // ignore data edges

        ?   ?     (?1)  ?       ?      :   ?   :   -;  // ignore the edges on
        ?   ?       ?  (?1)     ?      :   ?   :   -;  // set and clear
        ?   ?       ?   ?       *      :   ?   :   x;

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


     


primitive UFPCERB (Q, D, CP, RB, CE, NOTIFIER_REG);

    output Q;
    input  NOTIFIER_REG,
           D, CP, RB, CE;
    reg    Q;
   
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR and ENABLE ( Q OUTPUT UDP ).


    table

    //  D   CP      RB   CE      NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    1    1          ?          :   ?   :   1;  // clocked data
        0   (01)    1    1          ?          :   ?   :   0;

        1   (01)    1    x          ?          :   1   :   1;  // clocked data
        0   (01)    1    x          ?          :   0   :   0;

        0   (01)    x    1          ?          :   ?   :   0;  // pessimism
        0    ?      x    1          ?          :   0   :   0;  // pessimism

        1    0      x    1          ?          :   0   :   0;  // pessimism
        1    x    (?x)   1          ?          :   0   :   0;  // pessimism
        1    1    (?x)   1          ?          :   0   :   0;  // pessimism

        x    0      x    1          ?          :   0   :   0;  // pessimism
        x    x    (?x)   1          ?          :   0   :   0;  // pessimism
        x    1    (?x)   1          ?          :   0   :   0;  // pessimism

        0    ?      x    x          ?          :   0   :   0;  // pessimism

        1    0      x    x          ?          :   0   :   0;  // pessimism
        1    x    (?x)   x          ?          :   0   :   0;  // pessimism
        1    1    (?x)   x          ?          :   0   :   0;  // pessimism

        x    0      x    x          ?          :   0   :   0;  // pessimism
        x    x    (?x)   x          ?          :   0   :   0;  // pessimism
        x    1    (?x)   x          ?          :   0   :   0;  // pessimism


        1   (x1)    1    1          ?          :   1   :   1;  // reducing pessimism
        0   (x1)    1    1          ?          :   0   :   0;
        1   (0x)    1    1          ?          :   1   :   1;
        0   (0x)    1    1          ?          :   0   :   0;

        1   (x1)    1    x          ?          :   1   :   1;  // reducing pessimism
        0   (x1)    1    x          ?          :   0   :   0;
        1   (0x)    1    x          ?          :   1   :   1;
        0   (0x)    1    x          ?          :   0   :   0;


        ?    ?      0    ?          ?          :   ?   :   0;  // asynchronous clear

        ?   (?1)    1    0          ?          :   ?   :   -;  // chip is not enabled
        ?   (0x)    1    0          ?          :   ?   :   -;  // chip is not enabled

        ?   (?1)    x    0          ?          :   0   :   0;  // chip is not enabled pessimism with reset
        ?   (0x)    x    0          ?          :   0   :   0;  // chip is not enabled pessimism with reset
        ?    ?    (?x)   0          ?          :   0   :   0;  // chip is not enabled pessimism with reset


        ?   (?0)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?    ?          ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)   ?          ?          :   ?   :   -;  // ignore the edges on clear
 
        ?    ?      ?    *          ?          :   ?   :   -;

        ?    ?      ?    ?          *          :   ?   :   x;

    endtable
endprimitive



primitive UFNCERB (Q, D, CP, RB, CE, NOTIFIER_REG);

    output Q;
    input  NOTIFIER_REG,
           D, CP, RB, CE;
    reg    Q;
   
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR and ENABLE ( Q OUTPUT UDP ).


    table

    //  D   CP      RB   CE      NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    1    1          ?          :   ?   :   1;  // clocked data
        0   (10)    1    1          ?          :   ?   :   0;

        1   (10)    1    x          ?          :   1   :   1;  // clocked data
        0   (10)    1    x          ?          :   0   :   0;

        0   (10)    x    1          ?          :   ?   :   0;  // pessimism
        0    ?      x    1          ?          :   0   :   0;  // pessimism

        1    1      x    1          ?          :   0   :   0;  // pessimism
        1    x    (?x)   1          ?          :   0   :   0;  // pessimism
        1    0    (?x)   1          ?          :   0   :   0;  // pessimism

        x    1      x    1          ?          :   0   :   0;  // pessimism
        x    x    (?x)   1          ?          :   0   :   0;  // pessimism
        x    0    (?x)   1          ?          :   0   :   0;  // pessimism

        0    ?      x    x          ?          :   0   :   0;  // pessimism

        1    1      x    x          ?          :   0   :   0;  // pessimism
        1    x    (?x)   x          ?          :   0   :   0;  // pessimism
        1    0    (?x)   x          ?          :   0   :   0;  // pessimism

        x    1      x    x          ?          :   0   :   0;  // pessimism
        x    x    (?x)   x          ?          :   0   :   0;  // pessimism
        x    0    (?x)   x          ?          :   0   :   0;  // pessimism


        1   (1x)    1    1          ?          :   1   :   1;  // reducing pessimism
        0   (1x)    1    1          ?          :   0   :   0;
        1   (x0)    1    1          ?          :   1   :   1;
        0   (x0)    1    1          ?          :   0   :   0;

        1   (1x)    1    x          ?          :   1   :   1;  // reducing pessimism
        0   (1x)    1    x          ?          :   0   :   0;
        1   (x0)    1    x          ?          :   1   :   1;
        0   (x0)    1    x          ?          :   0   :   0;


        ?    ?      0    ?          ?          :   ?   :   0;  // asynchronous clear

        ?   (?0)    1    0          ?          :   ?   :   -;  // chip is not enabled
        ?   (1x)    1    0          ?          :   ?   :   -;  // chip is not enabled

        ?   (?0)    x    0          ?          :   0   :   0;  // chip is not enabled pessimism with reset
        ?   (1x)    x    0          ?          :   0   :   0;  // chip is not enabled pessimism with reset
        ?    ?    (?x)   0          ?          :   0   :   0;  // chip is not enabled pessimism with reset


        ?   (?1)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?    ?          ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)   ?          ?          :   ?   :   -;  // ignore the edges on clear
 
        ?    ?      ?    *          ?          :   ?   :   -;

        ?    ?      ?    ?          *          :   ?   :   x;

    endtable
endprimitive




//--------------------------------------------------------------------
//-                    cell  ULPQ.v                                  -
//--------------------------------------------------------------------

`timescale 1 ns / 100 ps

primitive ULPQ (QN, D, G, NOTI_REG);



    output QN;
    reg    QN;
    input  D,              // data
           G,              // clock
           NOTI_REG;       // NOTIFY REG
// FUNCTION : D-LATCH, GATED  STANDARD DRIVE / ACTIVE HIGH ( QN OUTPUT UDP )
//


   table
     //  D       G    NOTI_REG        : Qtn :   Qtn+1

         *       0      ?             :  ?  :    -   ;

         ?      (?0)    ?             :  ?  :    -   ;
         ?      (1x)    ?             :  ?  :    -   ;

         0      (0x)    ?             :  1  :    1   ;
         1      (0x)    ?             :  0  :    0   ;
         0      (x1)    ?             :  ?  :    1   ;
         1      (x1)    ?             :  ?  :    0   ;

        (?0)     1      ?             :  ?  :    1   ;
        (?1)     1      ?             :  ?  :    0   ;
         0      (01)    ?             :  ?  :    1   ;
         1      (01)    ?             :  ?  :    0   ;

        (?1)     x      ?             :  0  :    0   ;    // Reducing pessimism.
        (?0)     x      ?             :  1  :    1   ;

         ?       ?      *             :  ?  :    x   ;

   endtable

endprimitive


//--------------------------------------------------------------------
//-                    cell  ULNQ.v                                  -
//--------------------------------------------------------------------


primitive ULNQ (QN, D, GN, NOTI_REG);



    output QN;
    reg    QN;
    input  D,                // data
           GN,                // clock
           NOTI_REG;         // NOTIFY REG
// FUNCTION : DLATCH, GATED  ACTIVE LOW / STANDARD DRIVE ( QN OUTPUT UDP )
//


   table
     //  D       GN   NOTI_REG        : Qtn :   Qtn+1

         ?      (0x)    ?             :  ?  :    -   ;
         ?      (?1)    ?             :  ?  :    -   ;

         *       1      ?             :  ?  :    -   ;

       (?0)      0      ?             :  ?  :    1   ;
       (?1)      0      ?             :  ?  :    0   ;
        0       (10)    ?             :  ?  :    1   ;
        1       (10)    ?             :  ?  :    0   ;

       (?1)      x      ?             :  0  :    0   ;    // Reducing pessimism.
       (?0)      x      ?             :  1  :    1   ;

         0      (1x)    ?             :  1  :    1   ;   // Reducing pessimism.
         1      (1x)    ?             :  0  :    0   ;
         0      (x0)    ?             :  ?  :    1   ;
         1      (x0)    ?             :  ?  :    0   ;

         ?       ?      *             :  ?  :    x   ;

   endtable

endprimitive



//--------------------------------------------------------------------
//-                    cell  ULP.v                                  -
//--------------------------------------------------------------------


primitive ULP (Q, D, G, NOTI_REG);





    output Q;
    reg    Q;
    input  D,              // data
           G,              // clock
           NOTI_REG;
// FUNCTION : DLATCH, GATED  STANDARD DRIVE / ACTIVE HIGH ( Q OUTPUT UDP )
//


   table
     //  D       G    NOTI_REG        : Qtn :   Qtn+1

         *       0      ?             :  ?  :    -   ;

         ?      (?0)    ?             :  ?  :    -   ;
         ?      (1x)    ?             :  ?  :    -   ;

         0      (0x)    ?             :  0  :    0   ;
         1      (0x)    ?             :  1  :    1   ;
         0      (x1)    ?             :  ?  :    0   ;
         1      (x1)    ?             :  ?  :    1   ;

        (?0)     1      ?             :  ?  :    0   ;
        (?1)     1      ?             :  ?  :    1   ;
         0      (01)    ?             :  ?  :    0   ;
         1      (01)    ?             :  ?  :    1   ;

        (?1)     x      ?             :  1  :    1   ;    // Reducing pessimism.
        (?0)     x      ?             :  0  :    0   ;

         ?       ?      *             :  ?  :    x   ;


   endtable

endprimitive



primitive ULN (Q, D, GN, NOTI_REG);





    output Q;
    reg    Q;
    input  D,                // data
           GN,                // clock
           NOTI_REG;         // NOTIFY_REG
// FUNCTION :  D-LATCH, GATED  ACTIVE LOW / STANDARD DRIVE ( Q OUTPUT UDP )
//


   table
     //  D       GN    NOTI_REG        : Qt  :   Qt+1

         ?      (0x)    ?             :  ?  :    -   ;
         ?      (?1)    ?             :  ?  :    -   ;

         *       1      ?             :  ?  :    -   ;

       (?0)      0      ?             :  ?  :    0   ;
       (?1)      0      ?             :  ?  :    1   ;
        0       (10)    ?             :  ?  :    0   ;
        1       (10)    ?             :  ?  :    1   ;

       (?1)      x      ?             :  1  :    1   ;    // Reducing pessimism.
       (?0)      x      ?             :  0  :    0   ;

         0      (1x)    ?             :  0  :    0   ;   // Reducing pessimism.
         1      (1x)    ?             :  1  :    1   ;
         0      (x0)    ?             :  ?  :    0   ;
         1      (x0)    ?             :  ?  :    1   ;

         ?       ?      *             :  ?  :    x   ;

   endtable

endprimitive


     


primitive U_MUX_4 (Y, D0, D1, D2, D3, S0, S1);

    input D0, D1, D2, D3, S0, S1;
    output Y;
  
// FUNCTION :  FOUR TO ONE MULTIPLEXER WITH 2 SELECT CONTROLS

    table

//   D0  D1  D2 D3  S0  S1 : Y

     0   ?   ?  ?    0  0  : 0 ;
     1   ?   ?  ?    0  0  : 1 ;

     ?   0   ?  ?    1  0  : 0 ;
     ?   1   ?  ?    1  0  : 1 ;

     ?   ?   0  ?    0  1  : 0 ;
     ?   ?   1  ?    0  1  : 1 ;

     ?   ?   ?  0    1  1  : 0 ;
     ?   ?   ?  1    1  1  : 1 ;


     0   0   0   0   ?  ?  : 0 ;

     1   1   1   1   ?  ?  : 1 ;

     0   0   ?   ?   ?  0  : 0 ;
     1   1   ?   ?   ?  0  : 1 ;

     ?   ?   0   0   ?  1  : 0 ;
     ?   ?   1   1   ?  1  : 1 ;

     0   ?   0   ?   0  ?  : 0 ;
     1   ?   1   ?   0  ?  : 1 ;

     ?   0   ?   0   1  ?  : 0 ;
     ?   1   ?   1   1  ?  : 1 ;

     endtable
endprimitive

     


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


primitive U_MUX_2 (Q, A, B, SL);
    output Q;
    input A, B, SL;

// FUNCTION :  TWO TO ONE MULTIPLEXER

    table
    //  A   B   SL  :   Q
        0   0   ?   :   0 ;
        1   1   ?   :   1 ;

        0   ?   0   :   0 ;
        1   ?   0   :   1 ;

        ?   0   1   :   0 ;
        ?   1   1   :   1 ;

    endtable
endprimitive

//--------------------------------------------------------------------
//-                    cell  UFJKBNR.v                                  -
//--------------------------------------------------------------------

primitive UFJKBNR (Q, J, K, CP, R, NOTIFIER_REG);


    output Q;
    reg    Q; 
    input  NOTIFIER_REG,
           J,K,
           CP,                                  // CLOCK.
           R;                                   // CLEAR INPUT.

// FUNCTION : NEGATIVE EDGE TRIGGERED JK FLIP FLOP, WITH CLEAR
//            ACTIVE HIGH

    table
      // J   K   CP   R      NOTIFIER_REG  :  Qtn : Qtn+1

         0   1  (10)  0         ?          :   ?  :   - ;         // Output retains the
                                                                  // present state if both
                                                                  // J and K are 0.
         0   0  (10)  0         ?          :   ?  :   0 ;         // Clocked J and K.
         1   1  (10)  0         ?          :   ?  :   1 ;

         0   0  (10)  x         ?          :   ?  :   0 ;         // pessimism
         ?   ?   ?    x         ?          :   0  :   0 ;         // pessimism

         1   0  (10)  0         ?          :   0  :   1 ;         // Clocked toggle.
         1   0  (10)  0         ?          :   1  :   0 ;

         ?   0  (10)  x         ?          :   1  :   0 ;         // pessimism

         0   1  (x0)  0         ?          :   ?  :   - ;         //possible clocked JK
         0   0  (x0)  0         ?          :   0  :   0 ;
         1   1  (x0)  0         ?          :   1  :   1 ;
         0   1  (1x)  0         ?          :   ?  :   - ;
         0   0  (1x)  0         ?          :   0  :   0 ;
         1   1  (1x)  0         ?          :   1  :   1 ;


         *   ?   ?    ?         ?          :   ?  :   - ;         // Insensitive to
         ?   *   ?    ?         ?          :   ?  :   - ;         // transitions on J and K
                                                                  // with steady clock.
         ?   ? (?1)   0         ?          :   ?  :   - ;         //ignore falling clock.
         ?   ? (0x)   0         ?          :   ?  :   - ;

         x   1   f    0         ?          :   1  :   1 ;         // reducing pessimism for unknown J
         x   0   f    0         ?          :   1  :   0 ;         // reducing pessimism for unknown J
         0   x   f    0         ?          :   0  :   0 ;         // reducing pessimism for unknown K
         1   x   f    0         ?          :   0  :   1 ;         // reducing pessimism for unknown K


         x   1  (x0)  0         ?          :   1  :   1 ;         //possible clocked with
         0   x  (x0)  0         ?          :   0  :   0 ;         //possible J & K
         x   1  (1x)  0         ?          :   1  :   1 ;
         0   x  (1x)  0         ?          :   0  :   0 ;

         ?   ?   ?    1         ?          :   ?  :   0 ;         // Clear.

         ?   ?   ?   (?0)       ?          :   ?  :   - ;         // insensitive to a falling
         ?   ?   ?    ?         *          :   ?  :   x ;         // edge on RESET.


    endtable

endprimitive

  

//--------------------------------------------------------------------
//-                    cell  UFNSDR.v                                  -
//--------------------------------------------------------------------

primitive UFNSDR (Q, D, CP, TI, TE, R, NOTIFIER_REG);

    output Q;
    input  NOTIFIER_REG,
           D, CP, TI, TE, R;
    reg    Q;
   
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS CLEAR WITH  SCAN INPUTS ( Q OUTPUT UDP )


    table

    //  D   CP      TI  TE  R     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    ?   0   0         ?          :   ?   :   1;  // clocked data
        0   (10)    ?   0   0         ?          :   ?   :   0;

        0   (10)    ?   0   x         ?          :   ?   :   0;  // pessimism

        0    ?      ?   0   x         ?          :   0   :   0;  // pessimism

        1    1      ?   0   x         ?          :   0   :   0;  // pessimism
        1    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        1    0      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        x    1      ?   0   x         ?          :   0   :   0;  // pessimism
        x    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        x    0      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      0   1   x         ?          :   0   :   0;  // pessimism

        ?    1      1   1   x         ?          :   0   :   0;  // pessimism
        ?    x      1   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    0      1   1 (?x)        ?          :   0   :   0;  // pessimism

        ?    1      x   1   x         ?          :   0   :   0;  // pessimism
        ?    x      x   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    0      x   1 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      ?   x (?x)        ?          :   0   :   0;  // AB

        1   (1x)    ?   0   0         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    ?   0   0         ?          :   0   :   0;
        1   (x0)    ?   0   0         ?          :   1   :   1;
        0   (x0)    ?   0   0         ?          :   0   :   0;


        ?    ?      ?   ?   1         ?          :   ?   :   0;  // asynchronous clear

        ?   (?1)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?      ?   ?  (?0)       ?          :   ?   :   -;  // ignore the edges on clear

        ?   (10)    0   1   0         ?          :   ?   :   0;  // scan data
        ?   (10)    1   1   0         ?          :   ?   :   1;  //

        ?   (10)    0   1   x         ?          :   ?   :   0;

        ?   (1x)    1   1   0         ?          :   1   :   1;  // reducing pessimism
        ?   (1x)    0   1   0         ?          :   0   :   0;  // for scan data
        ?   (x0)    1   1   0         ?          :   1   :   1;
        ?   (x0)    0   1   0         ?          :   0   :   0;

        1   (10)    1   x   0         ?          :   ?   :   1; // reducing pessimism
        0   (10)    0   x   0         ?          :   ?   :   0;

        0   (1x)    0   x   0         ?          :   0   :   0; //AB
        0   (x0)    0   x   0         ?          :   0   :   0; //AB

        1   (1x)    1   x   0         ?          :   1   :   1; //AB
        1   (x0)    1   x   0         ?          :   1   :   1; //AB

        0   (10)    0   x   x         ?          :   ?   :   0;
        0   (1x)    0   x   x         ?          :   0   :   0; //AB
        0   (x0)    0   x   x         ?          :   0   :   0; //AB

        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges
        ?    ?      ?   *   ?         ?          :   ?   :   -;  // ignore edges on TE
        ?    ?      ?   ?   ?         *          :   ?   :   x;

    endtable
endprimitive


//--------------------------------------------------------------------
//-                    cell  UFNSDQ.v                                  -
//--------------------------------------------------------------------

primitive UFNSDQ (QN, D, CP, TI, TE, NOTIFIER_REG);

    output QN;
    input  NOTIFIER_REG,
           D, CP, TI, TE;
    reg    QN;
   
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH SCAN INPUTS ( QN OUTPUT UDP )

    table

    //  D    CP     TI  TE     NOTIFIER_REG  :   Qtn :   Qtn+1

        1   (10)    ?   0         ?          :   ?   :   0;  // clocked data
        0   (10)    ?   0         ?          :   ?   :   1;

        1   (1x)    ?   0         ?          :   0   :   0;  // reducing pessimism
        0   (1x)    ?   0         ?          :   1   :   1;
        1   (x0)    ?   0         ?          :   0   :   0;
        0   (x0)    ?   0         ?          :   1   :   1;


        ?   (?1)    ?   ?         ?          :   ?   :   -;  // ignore rising clock
        ?   (0x)    ?   ?         ?          :   ?   :   -;  // ignore rising clock
        *    ?      ?   ?         ?          :   ?   :   -;  // ignore the edges on data

        ?   (10)    0   1         ?          :   ?   :   1;  // SCAN DATA
        ?   (10)    1   1         ?          :   ?   :   0;  //

        ?   (1x)    1   1         ?          :   0   :   0;  // reducing pessimism
        ?   (1x)    0   1         ?          :   1   :   1;  // for scan data
        ?   (x0)    1   1         ?          :   0   :   0;
        ?   (x0)    0   1         ?          :   1   :   1;

        1   (10)    1   x         ?          :   ?   :   0; // reducing pessimism
        0   (10)    0   x         ?          :   ?   :   1;

        1   (1x)    1   x         ?          :   0   :   0;  // reducing pessimism
        0   (1x)    0   x         ?          :   1   :   1;
        1   (x0)    1   x         ?          :   0   :   0;
        0   (x0)    0   x         ?          :   1   :   1;

        ?    ?      *   ?         ?          :   ?   :   -;  // ignore edges

        ?    ?      ?   *         ?          :   ?   :   -;  // ignore edges on TE

        ?    ?      ?   ?         *          :   ?   :   x;

    endtable
endprimitive



//--------------------------------------------------------------------
//-                    cell  UFNSDSBQ.v                                  -
//--------------------------------------------------------------------

primitive UFNSDSBQ (QN, D, CP, TI, TE, SB, NOTIFIER_REG);

    output QN;
    input  NOTIFIER_REG,
           D, CP, TI, TE, SB;
    reg    QN;
   
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET WITH  scan inputs ( QN OUTPUT UDP )


    table

    //  D   CP      TI  TE  SB     NOTIFIER_REG  :   QNt  :   QNt+0

        1   (10)    ?   0   1         ?          :   ?   :   0;  // clocked data
        0   (10)    ?   0   1         ?          :   ?   :   1;

        1   (10)    ?   1   x         ?          :   ?   :   0;  // pessimism

        1    ?      ?   0   x         ?          :   0   :   0;  // pessimism

        0    1      ?   0   x         ?          :   0   :   0;  // pessimism
        0    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        0    0      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        x    1      ?   0   x         ?          :   0   :   0;  // pessimism
        x    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        x    0      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      1   1   x         ?          :   0   :   0;  // pessimism

        ?    1      0   1   x         ?          :   0   :   0;  // pessimism
        ?    x      0   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    0      0   1 (?x)        ?          :   0   :   0;  // pessimism

        ?    1      x   1   x         ?          :   0   :   0;  // pessimism
        ?    x      x   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    0      x   1 (?x)        ?          :   0   :   0;  // pessimism
 
        ?    ?      ?   x (?x)        ?          :   0   :   0;  // AB

        1   (1x)    ?   0   1         ?          :   0   :   0;  // reducing pessimism
        0   (1x)    ?   0   1         ?          :   1   :   1;
        1   (x0)    ?   0   1         ?          :   0   :   0;
        0   (x0)    ?   0   1         ?          :   1   :   1;


        ?    ?      ?   ?   0         ?          :   ?   :   0;  // asynchronous set

        ?   (?1)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?      ?   ?  (?1)       ?          :   ?   :   -;  // ignore the edges on set

        ?   (10)    0   1   1         ?          :   ?   :   1;  // scan data
        ?   (10)    1   1   1         ?          :   ?   :   0;  //

        ?   (10)    1   1   x         ?          :   ?   :   0;

        ?   (1x)    1   1   1         ?          :   0   :   0;  // reducing pessimism
        ?   (1x)    0   1   1         ?          :   1   :   1;  // for scan data
        ?   (x0)    1   1   1         ?          :   0   :   0;
        ?   (x0)    0   1   1         ?          :   1   :   1;

        1   (10)    1   x   1         ?          :   ?   :   0; // reducing pessimism
        0   (10)    0   x   1         ?          :   ?   :   1;

        0   (1x)    0   x   1         ?          :   1   :   1; //AB
        0   (x0)    0   x   1         ?          :   1   :   1; //AB

        1   (1x)    1   x   1         ?          :   0   :   0; //AB
        1   (x0)    1   x   1         ?          :   0   :   0; //AB

        1   (10)    1   x   x         ?          :   ?   :   0;
        1   (1x)    1   x   x         ?          :   0   :   0; //AB
        1   (x0)    1   x   x         ?          :   0   :   0; //AB

        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges
        ?    ?      ?   *   ?         ?          :   ?   :   -;  // ignore edges on TE
        ?    ?      ?   ?   ?         *          :   ?   :   x;

    endtable
endprimitive

//--------------------------------------------------------------------
//-                    cell  UFNSD.v                                  -
//--------------------------------------------------------------------

primitive UFNSD (Q, D, CP, TI, TE, NOTIFIER_REG);

    output Q;
    input  NOTIFIER_REG,
           D, CP, TI, TE;
    reg    Q;
   
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH SCAN INPUTS ( Q OUTPUT UDP )

    table

    //  D    CP     TI  TE     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    ?   0         ?          :   ?   :   1;  // clocked data
        0   (10)    ?   0         ?          :   ?   :   0;

        1   (1x)    ?   0         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    ?   0         ?          :   0   :   0;
        1   (x0)    ?   0         ?          :   1   :   1;
        0   (x0)    ?   0         ?          :   0   :   0;


        ?   (?1)    ?   ?         ?          :   ?   :   -;  // ignore rising clock
        ?   (0x)    ?   ?         ?          :   ?   :   -;  // ignore rising clock
        *    ?      ?   ?         ?          :   ?   :   -;  // ignore the edges on data

        ?   (10)    0   1         ?          :   ?   :   0;  // scan data
        ?   (10)    1   1         ?          :   ?   :   1;  // scan data

        ?   (1x)    1   1         ?          :   1   :   1;  // reducing pessimism
        ?   (1x)    0   1         ?          :   0   :   0;  // for scan data
        ?   (x0)    1   1         ?          :   1   :   1;
        ?   (x0)    0   1         ?          :   0   :   0;

        1   (10)    1   x         ?          :   ?   :   1;  // reducing pessimism

        0   (10)    0   x         ?          :   ?   :   0;

        1   (1x)    1   x         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    0   x         ?          :   0   :   0;
        1   (x0)    1   x         ?          :   1   :   1;
        0   (x0)    0   x         ?          :   0   :   0;

        ?    ?      *   ?         ?          :   ?   :   -;  // ignore edges

        ?    ?      ?   *         ?          :   ?   :   -;  // ignore edges on TE
        ?    ?      ?   ?         *          :   ?   :   x;

    endtable
endprimitive

//--------------------------------------------------------------------
//-                    cell  UFNCE.v                                  -
//--------------------------------------------------------------------

primitive UFNCE (Q, D, CP, CEB, NOTIFIER_REG);

    output Q;
    input  NOTIFIER_REG,
           D, CP, CEB;
    reg    Q;
   
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH CLOCK ENABLE INPUT ( Q OUTPUT UDP )


    table

    //  D   CP      CEB     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    1         ?          :   ?   :   1;  // clocked data
        0   (10)    1         ?          :   ?   :   0;

        1   (1x)    1         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    1         ?          :   0   :   0;
        1   (x0)    1         ?          :   1   :   1;
        0   (x0)    1         ?          :   0   :   0;


        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        1   (10)    x         ?          :   1   :   1;  // reducing pessimism
        0   (10)    x         ?          :   0   :   0;

        1   (1x)    x         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    x         ?          :   0   :   0;
        1   (x0)    x         ?          :   1   :   1;
        0   (x0)    x         ?          :   0   :   0;


        ?   (?0)    0         ?          :   ?   :   -;  // reducing pessimism
        ?   (1x)    0         ?          :   ?   :   -;  // reducing pessimism

        ?    ?      *         ?          :   ?   :   -; // ignore edges on CE
        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive


//--------------------------------------------------------------------
//-                    cell  UFPSDQ.v                                  -
//--------------------------------------------------------------------

primitive UFPSDQ (QN, D, CP, TI, TE, NOTIFIER_REG);

    output QN;
    input  NOTIFIER_REG,
           D, CP, TI, TE;
    reg    QN;
   
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH SCAN INPUTS ( QN OUTPUT UDP )


    table

    //  D   CP      TI  TE     NOTIFIER_REG  :   Qtn :   Qtn+1

        1   (01)    ?   0         ?          :   ?   :   0;  // clocked data
        0   (01)    ?   0         ?          :   ?   :   1;

        1   (x1)    ?   0         ?          :   0   :   0;  // reducing pessimism
        0   (x1)    ?   0         ?          :   1   :   1;
        1   (0x)    ?   0         ?          :   0   :   0;
        0   (0x)    ?   0         ?          :   1   :   1;


        ?   (?0)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?         ?          :   ?   :   -;  // ignore the edges on data

        ?   (01)    0   1         ?          :   ?   :   1;  // SCAN DATA
        ?   (01)    1   1         ?          :   ?   :   0;  //

        ?   (x1)    1   1         ?          :   0   :   0;  // reducing pessimism
        ?   (x1)    0   1         ?          :   1   :   1;  // for scan data
        ?   (0x)    1   1         ?          :   0   :   0;
        ?   (0x)    0   1         ?          :   1   :   1;

        1   (01)    1   x         ?          :   ?   :   0; // reducing pessimism
        0   (01)    0   x         ?          :   ?   :   1;

        1   (x1)    1   x         ?          :   0   :   0;  // reducing pessimism
        0   (x1)    0   x         ?          :   1   :   1;
        1   (0x)    1   x         ?          :   0   :   0;
        0   (0x)    0   x         ?          :   1   :   1;




        ?    ?      *   ?         ?          :   ?   :   -;  // ignore edges
//added by sp
        ?    ?      ?   *         ?          :   ?   :   -;  // ignore edges on TE
//end
        ?    ?      ?   ?         *          :   ?   :   x;


    endtable
endprimitive

//--------------------------------------------------------------------
//-                    cell  UFPSQ.v                                  -
//--------------------------------------------------------------------

primitive UFPSQ (QN, D, CP, S, NOTIFIER_REG);

    output QN;
    input  NOTIFIER_REG,
           D, CP, S;
    reg    QN;
   
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS SET ( QN OUTPUT UDP )


    table

    //  D   CP      S     NOTIFIER_REG  :   QNt  :   QNt+0

        1   (01)    0         ?          :   ?   :   0;  // clocked data
        0   (01)    0         ?          :   ?   :   1;
        1   (01)    x         ?          :   ?   :   0;  // reducing pessimism
        1    ?      x         ?          :   0   :   0;  // pessimism

        0    0      x         ?          :   0   :   0;  // pessimism
        0    x    (?x)        ?          :   0   :   0;  // pessimism
        0    1    (?x)        ?          :   0   :   0;  // pessimism

        x    0      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    1    (?x)        ?          :   0   :   0;  // pessimism

        1   (x1)    0         ?          :   0   :   0;  // reducing pessimism
        0   (x1)    0         ?          :   1   :   1;
        1   (0x)    0         ?          :   0   :   0;
        0   (0x)    0         ?          :   1   :   1;

        ?    ?      1         ?          :   ?   :   0;  // asynchronous clear

        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?   ?     (?0)        ?          :   ?   :   -;  // ignore the edges on set

        ?   ?       ?         *          :   ?   :   x;

    endtable
endprimitive


//--------------------------------------------------------------------
//-                    cell  UFPSDR.v                                  -
//--------------------------------------------------------------------

primitive UFPSDR (Q, D, CP, TI, TE, R, NOTIFIER_REG);

    output Q;
    input  NOTIFIER_REG,
           D, CP, TI, TE, R;
    reg    Q;
   
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS CLEAR WITH  SCAN INPUTS ( Q OUTPUT UDP )


    table

    //  D   CP      TI  TE  R     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    ?   0   0         ?          :   ?   :   1;  // clocked data
        0   (01)    ?   0   0         ?          :   ?   :   0;

        0   (01)    ?   0   x         ?          :   ?   :   0;  // pessimism

        0    ?      ?   0   x         ?          :   0   :   0;  // pessimism

        1    0      ?   0   x         ?          :   0   :   0;  // pessimism
        1    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        1    1      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        x    0      ?   0   x         ?          :   0   :   0;  // pessimism
        x    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        x    1      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      0   1   x         ?          :   0   :   0;  // pessimism

        ?    0      1   1   x         ?          :   0   :   0;  // pessimism
        ?    x      1   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    1      1   1 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      ?   x (?x)        ?          :   0   :   0;  // AB

        ?    0      x   1   x         ?          :   0   :   0;  // pessimism
        ?    x      x   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    1      x   1 (?x)        ?          :   0   :   0;  // pessimism

        1   (x1)    ?   0   0         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    ?   0   0         ?          :   0   :   0;
        1   (0x)    ?   0   0         ?          :   1   :   1;
        0   (0x)    ?   0   0         ?          :   0   :   0;


        ?    ?      ?   ?   1        ?          :   ?   :   0;  // asynchronous clear

        ?   (?0)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?      ?   ?  (?0)       ?          :   ?   :   -;  // ignore the edges on clear

        ?   (01)    0   1   0         ?          :   ?   :   0;  // scan data
        ?   (01)    1   1   0         ?          :   ?   :   1;  //

        ?   (01)    0   1   x         ?          :   ?   :   0;

        ?   (x1)    1   1   0         ?          :   1   :   1;  // reducing pessimism
        ?   (x1)    0   1   0         ?          :   0   :   0;  // for scan data
        ?   (0x)    1   1   0         ?          :   1   :   1;
        ?   (0x)    0   1   0         ?          :   0   :   0;

        1   (01)    1   x   0         ?          :   ?   :   1; // reducing pessimism
        0   (01)    0   x   0         ?          :   ?   :   0;
        0   (0x)    0   x   0         ?          :   0   :   0; //AB
        0   (x1)    0   x   0         ?          :   0   :   0; //AB

        1   (0x)    1   x   0         ?          :   1   :   1; //AB
        1   (x1)    1   x   0         ?          :   1   :   1; //AB

        0   (01)    0   x   x         ?          :   ?   :   0;
        0   (0x)    0   x   x         ?          :   0   :   0; //AB
        0   (x1)    0   x   x         ?          :   0   :   0; //AB


        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges
        ?    ?      ?   *   ?         ?          :   ?   :   -;  // ignore edges on TE
        ?    ?      ?   ?   ?         *          :   ?   :   x;

    endtable
endprimitive



//--------------------------------------------------------------------
//-                    cell  UFPSDSBQ.v                                  -
//--------------------------------------------------------------------

primitive UFPSDSBQ (QN, D, CP, TI, TE, SB, NOTIFIER_REG);

    output QN;
    input  NOTIFIER_REG,
           D, CP, TI, TE, SB;
    reg    QN;
   
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET WITH  scan inputs ( QN OUTPUT UDP )


    table

    //  D   CP      TI  TE  SB     NOTIFIER_REG  :   QNt  :   QNt+0

        1   (01)    ?   0   1         ?          :   ?   :   0;  // clocked data
        0   (01)    ?   0   1         ?          :   ?   :   1;

        1   (01)    ?   1   x         ?          :   ?   :   0;  // pessimism

        1    ?      ?   0   x         ?          :   0   :   0;  // pessimism

        0    0      ?   0   x         ?          :   0   :   0;  // pessimism
        0    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        0    1      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        x    0      ?   0   x         ?          :   0   :   0;  // pessimism
        x    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        x    1      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      1   1   x         ?          :   0   :   0;  // pessimism

        ?    0      0   1   x         ?          :   0   :   0;  // pessimism
        ?    x      0   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    1      0   1 (?x)        ?          :   0   :   0;  // pessimism

        ?    0      x   1   x         ?          :   0   :   0;  // pessimism
        ?    x      x   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    1      x   1 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      ?   x (?x)        ?          :   0   :   0;  // AB

        1   (x1)    ?   0   1         ?          :   0   :   0;  // reducing pessimism
        0   (x1)    ?   0   1         ?          :   1   :   1;
        1   (0x)    ?   0   1         ?          :   0   :   0;
        0   (0x)    ?   0   1         ?          :   1   :   1;



        ?    ?      ?   ?   0         ?          :   ?   :   0;  // asynchronous set

        ?   (?0)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?      ?   ?  (?1)       ?          :   ?   :   -;  // ignore the edges on set

        ?   (01)    0   1   1         ?          :   ?   :   1;  // scan data
        ?   (01)    1   1   1         ?          :   ?   :   0;  //

        ?   (01)    1   1   x         ?          :   ?   :   0;

        ?   (x1)    1   1   1         ?          :   0   :   0;  // reducing pessimism
        ?   (x1)    0   1   1         ?          :   1   :   1;  // for scan data
        ?   (0x)    1   1   1         ?          :   0   :   0;
        ?   (0x)    0   1   1         ?          :   1   :   1;

        1   (01)    1   x   1         ?          :   ?   :   0; // reducing pessimism
        0   (01)    0   x   1         ?          :   ?   :   1;

        0   (0x)    0   x   1         ?          :   1   :   1; //AB
        0   (x1)    0   x   1         ?          :   1   :   1; //AB

        1   (0x)    1   x   1         ?          :   0   :   0; //AB
        1   (x1)    1   x   1         ?          :   0   :   0; //AB

        1   (01)    1   x   x         ?          :   ?   :   0;
        1   (0x)    1   x   x         ?          :   0   :   0; //AB
        1   (x1)    1   x   x         ?          :   0   :   0; //AB

        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges
//added by sp
        ?    ?      ?   *   1         ?          :   ?   :   -;  // ignore edges on TE
//end    
        ?    ?      ?   ?   1         *          :   ?   :   x;

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
//-                    cell  UFJKBPR.v                                  -
//--------------------------------------------------------------------

primitive UFJKBPR (Q, J, K, CP, R, NOTIFIER_REG);



    output Q;
    reg    Q; 
    input  NOTIFIER_REG,
           J,K,
           CP,                                  // CLOCK.
           R;                                   // CLEAR INPUT.

// FUNCTION : POSITIVE EDGE TRIGGERED JK FLIP FLOP, WITH CLEAR
//            ACTIVE HIGH

    table
      // J   K   CP   R      NOTIFIER_REG  :  Qtn : Qtn+1

         0   1  (01)  0         ?          :   ?  :   - ;         // Output retains the
                                                 // present state if both
                                                 // J and K are 0.

         0   0  (01)  0         ?          :   ?  :   0 ;         // Clocked J and K.
         1   1  (01)  0         ?          :   ?  :   1 ;

         0   0  (01)  x         ?          :   ?  :   0 ;         // pessimism
         ?   ?   ?    x         ?          :   0  :   0 ;         // pessimism

         1   0  (01)  0         ?          :   0  :   1 ;         // Clocked toggle.
         1   0  (01)  0         ?          :   1  :   0 ;

         ?   0  (01)  x         ?          :   1  :   0 ;         // pessimism

         0   1  (x1)  0         ?          :   ?  :   - ;         //possible clocked JK
         0   0  (x1)  0         ?          :   0  :   0 ;
         1   1  (x1)  0         ?          :   1  :   1 ;
         0   1  (0x)  0         ?          :   ?  :   - ;
         0   0  (0x)  0         ?          :   0  :   0 ;
         1   1  (0x)  0         ?          :   1  :   1 ;


         *   ?   ?    ?         ?          :   ?  :   - ;         // Insensitive to
         ?   *   ?    ?         ?          :   ?  :   - ;         // transitions on J and K
                                                 // with steady clock.
         ?   ? (?0)   0         ?          :   ?  :   - ;         //ignore falling clock.
         ?   ? (1x)   0         ?          :   ?  :   - ;

         x   1   r    0         ?          :   1  :   1 ;         // reducing pessimism for unknown J
         x   0   r    0         ?          :   1  :   0 ;         // reducing pessimism for unknown J
         0   x   r    0         ?          :   0  :   0 ;         // reducing pessimism for unknown K
         1   x   r    0         ?          :   0  :   1 ;         // reducing pessimism for unknown K

         x   1  (x1)  0         ?          :   1  :   1 ;        //possible clocked with
         0   x  (x1)  0         ?          :   0  :   0 ;        //possible J & K
         x   1  (0x)  0         ?          :   1  :   1 ;
         0   x  (0x)  0         ?          :   0  :   0 ;

         ?   ?   ?    1         ?          :   ?  :   0 ;         // Clear.

         ?   ?   ?   (?0)       ?          :   ?  :   - ;         // Insensitive to a rising
         ?   ?   ?    ?         *          :   ?  :   x ;         // edge on RESET.


    endtable

endprimitive




//--------------------------------------------------------------------
//-                    cell  UFPQ.v                                  -
//--------------------------------------------------------------------

primitive UFPQ (QN, D, CP , NOTIFIER_REG);

    output QN;
    input  NOTIFIER_REG,
           D, CP;
    reg    QN;

// FUNCTION :  POSITIVE EDGE TRIGGERED D FLIP-FLOP ( QN OUTPUT UDP ).


    table

    //  D   CP           NOTIFIER_REG  :   Qtn :   Qtn+1

        1   (01)            ?          :   ?   :   0;  // clocked data
        0   (01)            ?          :   ?   :   1;

        1   (x1)            ?          :   0   :   0;  // reducing pessimism
        0   (x1)            ?          :   1   :   1;
        1   (0x)            ?          :   0   :   0;
        0   (0x)            ?          :   1   :   1;

        ?   (1x)            ?          :   ?   :   -;  // no change on falling edge
        ?   (?0)            ?          :   ?   :   -;

        *    ?              ?          :   ?   :   -;  // ignore edges on data

        ?    ?              *          :   ?   :   x;

    endtable
endprimitive


//--------------------------------------------------------------------
//-                    cell  UFPR.v                                  -
//--------------------------------------------------------------------

primitive UFPR (Q, D, CP, R, NOTIFIER_REG);

    output Q; 
    input  NOTIFIER_REG,
           D, CP, R;
    reg    Q;

// FUNCTION :  POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//             ASYNCHRONOUS CLEAR ( Q OUTPUT UDP ).


    table

    //  D   CP      R      NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    0         ?          :   ?   :   1;  // clocked data
        0   (01)    0         ?          :   ?   :   0;

        0   (01)    x         ?          :   ?   :   0;  // pessimism
        0    ?      x         ?          :   0   :   0;  // pessimism

        1    0      x         ?          :   0   :   0;  // pessimism
        1    x    (?x)        ?          :   0   :   0;  // pessimism
        1    1    (?x)        ?          :   0   :   0;  // pessimism

        x    0      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    1    (?x)        ?          :   0   :   0;  // pessimism

        1   (x1)    0         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    0         ?          :   0   :   0;
        1   (0x)    0         ?          :   1   :   1;
        0   (0x)    0         ?          :   0   :   0;


        ?   ?       1         ?          :   ?   :   0;  // asynchronous clear

        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?0)        ?          :   ?   :   -;  // ignore the edges on clear
        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive



//--------------------------------------------------------------------
//-                    cell  UFNQ.v                                  -
//--------------------------------------------------------------------

primitive UFNQ (QN, D, CP , NOTIFIER_REG);

    output QN;
    input  NOTIFIER_REG,
           D, CP;
    reg    QN;

// FUNCTION :  NEGATIVE EDGE TRIGGERED D FLIP-FLOP ( QN OUTPUT UDP ).


    table

    //  D   CP           NOTIFIER_REG  :   Qtn :   Qtn+1

        1   (10)            ?          :   ?   :   0;  // clocked data
        0   (10)            ?          :   ?   :   1;

        1   (1x)            ?          :   0   :   0;  // reducing pessimism
        0   (1x)            ?          :   1   :   1;
        1   (x0)            ?          :   0   :   0;
        0   (x0)            ?          :   1   :   1;

        ?   (0x)            ?          :   ?   :   -;  // no change on rising edge
        ?   (?1)            ?          :   ?   :   -;

        *    ?              ?          :   ?   :   -;  // ignore edges on data

        ?    ?              *          :   ?   :   x;

    endtable
endprimitive


//--------------------------------------------------------------------
//-                    cell  UFNR.v                                  -
//--------------------------------------------------------------------

primitive UFNR (Q, D, CP, R, NOTIFIER_REG);

    output Q; 
    input  NOTIFIER_REG,
           D, CP, R;
    reg    Q;

// FUNCTION :  NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//             ASYNCHRONOUS CLEAR ( Q OUTPUT UDP ).


    table

    //  D   CP      R      NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    0         ?          :   ?   :   1;  // clocked data
        0   (10)    0         ?          :   ?   :   0;

        0   (10)    x         ?          :   ?   :   0;  // pessimism
        0    ?      x         ?          :   0   :   0;  // pessimism

        1    1      x         ?          :   0   :   0;  // pessimism
        1    x    (?x)        ?          :   0   :   0;  // pessimism
        1    0    (?x)        ?          :   0   :   0;  // pessimism

        x    1      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    0    (?x)        ?          :   0   :   0;  // pessimism

        1   (1x)    0         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    0         ?          :   0   :   0;
        1   (x0)    0         ?          :   1   :   1;
        0   (x0)    0         ?          :   0   :   0;


        ?   ?       1         ?          :   ?   :   0;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?0)        ?          :   ?   :   -;  // ignore the edges on clear
        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive

//--------------------------------------------------------------------
//-                    cell  UFPRBQ.v                                  -
//--------------------------------------------------------------------

primitive UFPRBQ (QN, D, CP, RB, NOTIFIER_REG);

    output QN;
    input  NOTIFIER_REG,
           D, CP, RB;
    reg    QN;
   
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR ( QN OUTPUT UDP )


    table

    //  D   CP      RB     NOTIFIER_REG  :   Qtn :   Qtn+1

        1   (01)    1         ?          :   ?   :   0;  // clocked data
        0   (01)    1         ?          :   ?   :   1;

        0   (01)    x         ?          :   ?   :   1;  // pessimism
        0    ?      x         ?          :   1   :   1;  // pessimism

        1    0      x         ?          :   1   :   1;  // pessimism
        1    x    (?x)        ?          :   1   :   1;  // pessimism
        1    1    (?x)        ?          :   1   :   1;  // pessimism

        x    0      x         ?          :   1   :   1;  // pessimism
        x    x    (?x)        ?          :   1   :   1;  // pessimism
        x    1    (?x)        ?          :   1   :   1;  // pessimism


        1   (x1)    1         ?          :   0   :   0;  // reducing pessimism
        0   (x1)    1         ?          :   1   :   1;
        1   (0x)    1         ?          :   0   :   0;
        0   (0x)    1         ?          :   1   :   1;


        ?   ?       0         ?          :   ?   :   1;  // asynchronous clear

        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)        ?          :   ?   :   -;  // ignore the edges on clear

        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive

//--------------------------------------------------------------------
//-                    cell  UFNRBQ.v                                  -
//--------------------------------------------------------------------

primitive UFNRBQ (QN, D, CP, RB, NOTIFIER_REG);

    output QN;
    input  NOTIFIER_REG,
           D, CP, RB;
    reg    QN;
   
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR ( QN OUTPUT UDP )


    table

    //  D   CP      RB     NOTIFIER_REG  :   Qtn :   Qtn+1

        1   (10)    1         ?          :   ?   :   0;  // clocked data
        0   (10)    1         ?          :   ?   :   1;

        0   (10)    x         ?          :   ?   :   1;  // pessimism
        0    ?      x         ?          :   1   :   1;  // pessimism

        1    1      x         ?          :   1   :   1;  // pessimism
        1    x    (?x)        ?          :   1   :   1;  // pessimism
        1    0    (?x)        ?          :   1   :   1;  // pessimism

        x    1      x         ?          :   1   :   1;  // pessimism
        x    x    (?x)        ?          :   1   :   1;  // pessimism
        x    0    (?x)        ?          :   1   :   1;  // pessimism


        1   (1x)    1         ?          :   0   :   0;  // reducing pessimism
        0   (1x)    1         ?          :   1   :   1;
        1   (x0)    1         ?          :   0   :   0;
        0   (x0)    1         ?          :   1   :   1;


        ?   ?       0         ?          :   ?   :   1;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)        ?          :   ?   :   -;  // ignore the edges on clear

        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive


//--------------------------------------------------------------------
//-                    cell  UFPCE.v                                  -
//--------------------------------------------------------------------

primitive UFPCE (Q, D, CP, CE, NOTIFIER_REG);

    output Q;
    input  NOTIFIER_REG,
           D, CP, CE;
    reg    Q;
   
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH CLOCK ENABLE INPUT ( Q OUTPUT UDP )


    table

    //  D   CP      CE     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    1         ?          :   ?   :   1;  // clocked data
        0   (01)    1         ?          :   ?   :   0;

        1   (x1)    1         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    1         ?          :   0   :   0;
        1   (0x)    1         ?          :   1   :   1;
        0   (0x)    1         ?          :   0   :   0;


        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        1   (01)    x         ?          :   1   :   1;  // reducing pessimism
        0   (01)    x         ?          :   0   :   0;

        1   (x1)    x         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    x         ?          :   0   :   0;
        1   (0x)    x         ?          :   1   :   1;
        0   (0x)    x         ?          :   0   :   0;


        ?   (?1)    0         ?          :   ?   :   -;  // reducing pessimism
        ?   (0x)    0         ?          :   ?   :   -;  // reducing pessimism

        ?    ?      *         ?          :   ?   :   -; // ignore edges on CE
        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive
     
     
//--------------------------------------------------------------------
//-                    cell  UFPSBQ.v                                  -
//--------------------------------------------------------------------

primitive UFPSBQ (QN, D, CP, SB, NOTIFIER_REG);

    output QN;
    input  NOTIFIER_REG,
           D, CP, SB;
    reg    QN;
   
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET ( QN OUTPUT UDP )


    table

    //  D   CP      SB     NOTIFIER_REG  :   Qtn :   Qtn+1

        1   (01)    1         ?          :   ?   :   0;  // clocked data
        0   (01)    1         ?          :   ?   :   1;
        1   (01)    x         ?          :   ?   :   0;  // reducing pessimism

        1    ?      x         ?          :   0   :   0;  // pessimism

        0    0      x         ?          :   0   :   0;  // pessimism
        0    x    (?x)        ?          :   0   :   0;  // pessimism
        0    1    (?x)        ?          :   0   :   0;  // pessimism

        x    0      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    1    (?x)        ?          :   0   :   0;  // pessimism


        1   (x1)    1         ?          :   0   :   0;  // reducing pessimism
        0   (x1)    1         ?          :   1   :   1;
        1   (0x)    1         ?          :   0   :   0;
        0   (0x)    1         ?          :   1   :   1;

        ?    ?      0         ?          :   ?   :   0;  // asynchronous clear

        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?    ?     (?1)       ?          :   ?   :   -;  // ignore the edges on set

        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive


//--------------------------------------------------------------------
//-                    cell  UFNSQ.v                                  -
//--------------------------------------------------------------------

primitive UFNSQ (QN, D, CP, S, NOTIFIER_REG);

    output QN;
    input  NOTIFIER_REG,
           D, CP, S;
    reg    QN;
   
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS SET ( QN OUTPUT UDP )


    table

    //  D   CP      S     NOTIFIER_REG  :   QNt  :   QNt+0

        1   (10)    0         ?          :   ?   :   0;  // clocked data
        0   (10)    0         ?          :   ?   :   1;
        1   (10)    x         ?          :   ?   :   0;  // reducing pessimism
        1    ?      x         ?          :   0   :   0;  // pessimism

        0    1      x         ?          :   0   :   0;  // pessimism
        0    x    (?x)        ?          :   0   :   0;  // pessimism
        0    0    (?x)        ?          :   0   :   0;  // pessimism

        x    1      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    0    (?x)        ?          :   0   :   0;  // pessimism

        1   (1x)    0         ?          :   0   :   0;  // reducing pessimism
        0   (1x)    0         ?          :   1   :   1;
        1   (x0)    0         ?          :   0   :   0;
        0   (x0)    0         ?          :   1   :   1;

        ?    ?      1         ?          :   ?   :   0;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?   ?     (?0)        ?          :   ?   :   -;  // ignore the edges on set

        ?   ?       ?         *          :   ?   :   x;

    endtable
endprimitive

//--------------------------------------------------------------------
//-                    cell  UFNSBQ.v                                  -
//--------------------------------------------------------------------

primitive UFNSBQ (QN, D, CP, SB, NOTIFIER_REG);

    output QN;
    input  NOTIFIER_REG,
           D, CP, SB;
    reg    QN;
   
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET ( QN OUTPUT UDP )


    table

    //  D   CP      SB     NOTIFIER_REG  :   QNt  :   QNt+0

        1   (10)    1         ?          :   ?   :   0;  // clocked data
        0   (10)    1         ?          :   ?   :   1;
        1   (10)    x         ?          :   ?   :   0;  // reducing pessimism
        1    ?      x         ?          :   0   :   0;  // pessimism

        0    1      x         ?          :   0   :   0;  // pessimism
        0    x    (?x)        ?          :   0   :   0;  // pessimism
        0    0    (?x)        ?          :   0   :   0;  // pessimism

        x    1      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    0    (?x)        ?          :   0   :   0;  // pessimism

        1   (1x)    1         ?          :   0   :   0;  // reducing pessimism
        0   (1x)    1         ?          :   1   :   1;
        1   (x0)    1         ?          :   0   :   0;
        0   (x0)    1         ?          :   1   :   1;

        ?    ?      0         ?          :   ?   :   0;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?   ?     (?1)        ?          :   ?   :   -;  // ignore the edges on set

        ?   ?       ?         *          :   ?   :   x;

    endtable
endprimitive

//--------------------------------------------------------------------
//-                    cell  UFPSD.v                                  -
//--------------------------------------------------------------------

primitive UFPSD (Q, D, CP, TI, TE, NOTIFIER_REG);

    output Q;
    input  NOTIFIER_REG,
           D, CP, TI, TE;
    reg    Q;
   
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH SCAN INPUTS ( Q OUTPUT UDP )


    table

    //  D   CP      TI  TE     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    ?   0         ?          :   ?   :   1;  // clocked data
        0   (01)    ?   0         ?          :   ?   :   0;

        1   (x1)    ?   0         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    ?   0         ?          :   0   :   0;
        1   (0x)    ?   0         ?          :   1   :   1;
        0   (0x)    ?   0         ?          :   0   :   0;


        ?   (?0)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?         ?          :   ?   :   -;  // ignore the edges on data

        ?   (01)    0   1         ?          :   ?   :   0;  // scan data
        ?   (01)    1   1         ?          :   ?   :   1;  // scan data

        ?   (x1)    1   1         ?          :   1   :   1;  // reducing pessimism
        ?   (x1)    0   1         ?          :   0   :   0;  // for scan data
        ?   (0x)    1   1         ?          :   1   :   1;
        ?   (0x)    0   1         ?          :   0   :   0;

        1   (01)    1   x         ?          :   ?   :   1;  // reducing pessimism
        0   (01)    0   x         ?          :   ?   :   0;

        1   (x1)    1   x         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    0   x         ?          :   0   :   0;
        1   (0x)    1   x         ?          :   1   :   1;
        0   (0x)    0   x         ?          :   0   :   0;

        ?    ?      *   ?         ?          :   ?   :   -;  // ignore edges
        ?    ?      ?   *          ?          :   ?   :   -; // ignore edges on TE
        ?    ?      ?   ?         *          :   ?   :   x;

    endtable
endprimitive

  
     
//--------------------------------------------------------------------
//-                    cell  BBDLHS.v                                  -
//--------------------------------------------------------------------
   

   
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module BBDLHS(D, E, GIN, GOUT, PAD, Q);
    
    input   D, E, GIN, GOUT;
    output  Q;
    inout   PAD;
    
    reg     NOTIFY_REG;
    
    ULP   inst1  (PAD_INT, D, GOUT, NOTIFY_REG);
    bufif1      BFIF1  (PAD, PAD_INT, E);
    ULN   inst2  (Q, PAD, GIN, NOTIFY_REG);

                 
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$GIN = 1; 
         specparam   InputLoad$GOUT = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PAD = 0; 
         specparam   OutputLoad$PAD = 0; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "io";
         



    if(GOUT && E)
    (D +=> PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
  
    if(E)
    (posedge GOUT => (PAD +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    (E => PAD) = (0, 0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0);
    
    if(!GIN)
    (PAD +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    
    (negedge GIN => (Q +: PAD)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   

    $setup(posedge D, negedge GOUT, 0.0, NOTIFY_REG);
    $hold(negedge GOUT, posedge D, 0.0, NOTIFY_REG);
    $setup(negedge D, negedge GOUT, 0.0, NOTIFY_REG);
    $hold(negedge GOUT, negedge D, 0.0, NOTIFY_REG);


    $setup(posedge PAD, posedge GIN, 0.0, NOTIFY_REG);
    $hold(posedge GIN, posedge PAD, 0.0, NOTIFY_REG);
    $setup(negedge PAD, posedge GIN, 0.0, NOTIFY_REG);
    $hold(posedge GIN, negedge PAD, 0.0, NOTIFY_REG);

    $width(posedge GOUT, 0.0, 0, NOTIFY_REG); 
    $width(negedge GIN, 0.0, 0, NOTIFY_REG); 

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
`timescale 1 ns / 100 ps
module BBHS(D, E, PAD, Y);
    
    input   D, E;
    output  Y;
    inout   PAD;
        
    bufif1      BFIF1  (PAD, D, E);
    buf         BF1    (Y, PAD);

    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$PAD = 0; 
         specparam   OutputLoad$PAD = 0; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "io";
  



    (E => PAD) = (0, 0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0);
    (PAD => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    (D => PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);

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
`timescale 1 ns / 100 ps
module DF1A(D, CLK, QN);
    
    input    D, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPQ  
                inst1 (QN, D, CLK, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
          (posedge CLK =>  (QN -: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  


      $setup(posedge D, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D, 0.0, NOTIFY_REG);
      $setup(negedge D, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D, 0.0, NOTIFY_REG);

      $width(posedge CLK, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DF1A_CC(D, CLK, QN);
    
    input    D, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPQ  
                inst1 (QN, D, CLK, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
          (posedge CLK =>  (QN -: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  


      $setup(posedge D, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D, 0.0, NOTIFY_REG);
      $setup(negedge D, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D, 0.0, NOTIFY_REG);

      $width(posedge CLK, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);

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

         specparam   LibName     = "axcelerator";
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
`timescale 1 ns / 100 ps
module DF1C(D, CLK, QN);
    
    input    D, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNQ 
                inst1 (QN, D, CLK, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
          (negedge CLK =>  (QN -: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  


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
//-                    cell  DF1C_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DF1C_CC(D, CLK, QN);
    
    input    D, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNQ 
                inst1 (QN, D, CLK, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
          (negedge CLK =>  (QN -: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  


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
//-                    cell  DFC1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFC1(D, CLK, CLR, Q);
    
    input    D, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPR 
                inst1 (Q, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "CLRN";
         specparam   ExtraDelayPin   = "CLR";
         
        
     


          
         if (!CLR)
          (posedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge CLR =>  (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, posedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D &&& (~CLR), 0.0, NOTIFY_REG);
      $setup(negedge D, posedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D &&& (~CLR), 0.0, NOTIFY_REG);
 

      $hold(posedge CLK, negedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(posedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFC1_CC(D, CLK, CLR, Q);
    
    input    D, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPR 
                inst1 (Q, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "CLRN";
         specparam   ExtraDelayPin   = "CLR";
         
        
     


          
         if (!CLR)
          (posedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge CLR =>  (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, posedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D &&& (~CLR), 0.0, NOTIFY_REG);
      $setup(negedge D, posedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D &&& (~CLR), 0.0, NOTIFY_REG);
 

      $hold(posedge CLK, negedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(posedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFC1A(D, CLK, CLR, Q);
    
    input    D, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNR 
                inst1 (Q, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "CLRN";
         specparam   ExtraDelayPin   = "CLR";

     


          
         if (!CLR)
          (negedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge CLR =>  (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, negedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D &&& (~CLR), 0.0, NOTIFY_REG);
      $setup(negedge D, negedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D &&& (~CLR), 0.0, NOTIFY_REG);


      $hold(negedge CLK, negedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(posedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(negedge CLR, negedge CLK, 0.0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFC1A_CC(D, CLK, CLR, Q);
    
    input    D, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNR 
                inst1 (Q, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "CLRN";
         specparam   ExtraDelayPin   = "CLR";

     


          
         if (!CLR)
          (negedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge CLR =>  (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, negedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D &&& (~CLR), 0.0, NOTIFY_REG);
      $setup(negedge D, negedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D &&& (~CLR), 0.0, NOTIFY_REG);


      $hold(negedge CLK, negedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(posedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(negedge CLR, negedge CLK, 0.0, NOTIFY_REG);

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

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
         if (CLR)
          (negedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge CLR =>  (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D &&& CLR,  0.0, NOTIFY_REG);
      $setup(negedge D, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D &&& CLR,  0.0, NOTIFY_REG);
      


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
`timescale 1 ns / 100 ps
module DFC1E(D, CLK, CLR, QN);
    
    input    D, CLK, CLR;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPRBQ 
                inst1 (QN, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
         if (CLR)
          (posedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge CLR =>  (QN +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D &&& CLR, 0.0, NOTIFY_REG);
      $setup(negedge D, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D &&& CLR, 0.0, NOTIFY_REG);
      


      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(posedge CLR, posedge CLK, 0.0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFC1G(D, CLK, CLR, QN);
    
    input    D, CLK, CLR;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNRBQ 
                inst1 (QN, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
         if (CLR)
         (negedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge CLR =>  (QN +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D &&& CLR, 0.0, NOTIFY_REG);
      $setup(negedge D, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D &&& CLR, 0.0, NOTIFY_REG);


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
//-                    cell  DFE.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE(D, E, CLK, Q);
    
    input    D, E, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPCE  
                inst1 (Q, D, CLK, E, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (E)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, posedge CLK &&& E, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D &&& E, 0.0, NOTIFY_REG);
      $setup(negedge D, posedge CLK &&& E, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D &&& E, 0.0, NOTIFY_REG);

      $setup(E, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, E, 0.0, NOTIFY_REG);
  
      $width(posedge CLK &&& E, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& E, 0.0, 0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFE_CC(D, E, CLK, Q);
    
    input    D, E, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPCE  
                inst1 (Q, D, CLK, E, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (E)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, posedge CLK &&& E, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D &&& E, 0.0, NOTIFY_REG);
      $setup(negedge D, posedge CLK &&& E, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D &&& E, 0.0, NOTIFY_REG);

      $setup(posedge E, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge E, 0.0, NOTIFY_REG);
      $setup(negedge E, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge E, 0.0, NOTIFY_REG);
 
      $width(posedge CLK &&& E, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& E, 0.0, 0, NOTIFY_REG);

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

         specparam   LibName     = "axcelerator";
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

         specparam   LibName     = "axcelerator";
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
//-                    cell  DFE3B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE3B(D, E, CLK, CLR, Q);
    
    input    D, E, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNCERB  
                inst1 (Q, D, CLK, CLR, E, NOTIFY_REG);
                
       
       and  AN1   (ENABLE, E, CLR);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (E && CLR)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(posedge D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D &&& ENABLE, 0.0, NOTIFY_REG);
      $setup(negedge D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D &&& ENABLE, 0.0, NOTIFY_REG);
      

      $setup(posedge E, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge E &&& CLR, 0.0, NOTIFY_REG);
      $setup(negedge E, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge E &&& CLR, 0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);

      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $recovery(posedge CLR, negedge CLK &&& E, 0.0, NOTIFY_REG);

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
//-                    cell  DFM_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM_CC(A, B, S, CLK, Q);
    
    input    A, B, S, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPSD  
                inst1 (Q, A, CLK, B, S, NOTIFY_REG);
    
       xor XR1 (EN, A, B);

    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
          if (!S)
            (posedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S)
            (posedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge A, posedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge A &&& (~S), 0.0, NOTIFY_REG);
      $setup(negedge A, posedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge A &&& (~S), 0.0, NOTIFY_REG);

      $setup(posedge B, posedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge B &&& S, 0.0, NOTIFY_REG);
      $setup(negedge B, posedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge B &&& S, 0.0, NOTIFY_REG);
      
 
      $setup(posedge S, posedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge S &&& EN, 0.0, NOTIFY_REG);
      $setup(negedge S, posedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge S &&& EN, 0.0, NOTIFY_REG);

      $width(posedge CLK, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFM1B_CC(A, B, S, CLK, QN);
    
    input    A, B, S, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPSDQ  
                inst1 (QN, A, CLK, B, S, NOTIFY_REG);

       xor XR1 (EN, A, B);

    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 2; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
          if (!S)
            (posedge CLK =>  (QN -: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S)
            (posedge CLK =>  (QN -: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge A, posedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge A &&& (~S), 0.0, NOTIFY_REG);
      
      $setup(negedge A, posedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge A &&& (~S), 0.0, NOTIFY_REG);

      $setup(posedge B, posedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge B &&& S, 0.0, NOTIFY_REG);
      $setup(negedge B, posedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge B &&& S, 0.0, NOTIFY_REG);
      

      $setup(posedge S, posedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge S &&& EN, 0.0, NOTIFY_REG);
      $setup(negedge S, posedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge S &&& EN, 0.0, NOTIFY_REG);
 
      $width(posedge CLK, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFM1C_CC(A, B, S, CLK, QN);
    
    input    A, B, S, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNSDQ  
                inst1 (QN, A, CLK, B, S, NOTIFY_REG);
    
       xor XR1 (EN, A, B);

    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 2; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
          if (!S)
            (negedge CLK =>  (QN -: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S)
            (negedge CLK =>  (QN -: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge A, negedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge A &&& (~S), 0.0, NOTIFY_REG);
      $setup(posedge B, negedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge B &&& S, 0.0, NOTIFY_REG);
  
      $setup(posedge S, negedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge S &&& EN, 0.0, NOTIFY_REG);

      $setup(negedge A, negedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge A &&& (~S), 0.0, NOTIFY_REG);
      $setup(negedge B, negedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge B &&& S, 0.0, NOTIFY_REG);
 
      $setup(negedge S, negedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge S &&& EN, 0.0, NOTIFY_REG);

 
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK, 0.0, 0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFM3E(A, B, S, CLK, CLR, Q);
    
    input    A, B, S, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNSDR  
                inst1 (Q, A, CLK, B, S, CLR, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, CLR_, S);
      not    N1    (CLR_, CLR);
      nor    AN2   (EN_A, S, CLR);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, CLR_, EN);

    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "X";
         specparam   ExtraDelayPin   = "CLR";
     


      
          if (!S && !CLR)
            (negedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && !CLR)
            (negedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (posedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge A, negedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge A &&& EN_A, 0.0, NOTIFY_REG);

      $setup(negedge A, negedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge A &&& EN_A, 0.0, NOTIFY_REG);

      $setup(posedge B, negedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge B &&& EN_B, 0.0, NOTIFY_REG);
      $setup(negedge B, negedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(posedge S, negedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge S &&& EN1, 0.0, NOTIFY_REG);
      $setup(negedge S, negedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge S &&& EN1, 0.0, NOTIFY_REG);
      


      $hold(negedge CLK, negedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR_, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& CLR_, 0.0, 0, NOTIFY_REG);
      
      $recovery(negedge CLR, negedge CLK, 0.0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFM4D(A, B, S, CLK, PRE, QN);
    
    input    A, B, S, CLK, PRE;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNSDSBQ  
                inst1 (QN, A, CLK, B, S, PRE, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, PRE, S);
      not    N1    (S_, S);
      and    AN2   (EN_A, S_, PRE);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, PRE, EN);

    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 2; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
          if (!S && PRE)
            (negedge CLK =>  (QN -: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && PRE)
            (negedge CLK =>  (QN -: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge PRE => (QN +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge A, negedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(negedge A, negedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge A &&& EN_A, 0.0, NOTIFY_REG);

      $setup(posedge B, negedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge B &&& EN_B, 0.0, NOTIFY_REG);
      
      $setup(negedge B, negedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge B &&& EN_B, 0.0, NOTIFY_REG);
      

      $setup(posedge S, negedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge S &&& EN1, 0.0, NOTIFY_REG);
      
      $setup(negedge S, negedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge S &&& EN1, 0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge PRE, 0.0, NOTIFY_REG);

  
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge PRE, negedge CLK, 0.0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFM6A(D0, D1, D2, D3, S0, S1, CLK, CLR, Q);
    
    input    D0, D1, D2, D3, S0, S1, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
    
       U_MUX_4     inst1 (D_EFF, D0, D1, D2, D3, S0, S1);

       UFPRB  inst2 (Q, D_EFF, CLK, CLR, NOTIFY_REG);
    
                
      
      not    NT1   (S0_, S0);
      not    NT2   (S1_, S1);
      and    AN1   (EN_D0, CLR, S0_, S1_);
      and    AN2   (EN_D1, CLR, S0, S1_);
      and    AN3   (EN_D2, CLR, S0_, S1);
      and    AN4   (EN_D3, CLR, S0, S1);
      
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0 = 1; 
         specparam   InputLoad$S1 = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";     


      
          if (!S0 && !S1 &&  CLR)
            (posedge CLK =>  (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && !S1 &&  CLR)
            (posedge CLK =>  (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (!S0 && S1 &&  CLR)
            (posedge CLK =>  (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && S1 &&  CLR)
            (posedge CLK =>  (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge CLR => (Q +: 1'b0))   = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D0, posedge CLK &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D0 &&& EN_D0, 0.0, NOTIFY_REG);
      $setup(negedge D0, posedge CLK &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D0 &&& EN_D0, 0.0, NOTIFY_REG);
      

      $setup(posedge D1, posedge CLK &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D1 &&& EN_D1, 0.0, NOTIFY_REG);
      $setup(negedge D1, posedge CLK &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D1 &&& EN_D1, 0.0, NOTIFY_REG);

      $setup(posedge D2, posedge CLK &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D2 &&& EN_D2, 0.0, NOTIFY_REG);
      $setup(negedge D2, posedge CLK &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D2 &&& EN_D2, 0.0, NOTIFY_REG);

      $setup(posedge D3, posedge CLK &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D3 &&& EN_D3, 0.0, NOTIFY_REG);
      $setup(negedge D3, posedge CLK &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D3 &&& EN_D3, 0.0, NOTIFY_REG);
 
      $setup(posedge S0, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge S0 &&& CLR, 0.0, NOTIFY_REG);
      $setup(negedge S0, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge S0 &&& CLR, 0.0, NOTIFY_REG);

      $setup(posedge S1, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge S1 &&& CLR, 0.0, NOTIFY_REG);
      $setup(negedge S1, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge S1 &&& CLR, 0.0, NOTIFY_REG);

 
      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);
 
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge CLR, posedge CLK, 0.0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFM7A ( D0, D1, D2, D3, S0, S10, S11, CLK, CLR, Q);
    
    input    D0, D1, D2, D3, S0, S10, S11, CLR, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
    
        or 	OR1_inst ( S1, S10, S11);
	U_MUX_4 inst2 ( D_EFF, D0, D1, D2, D3, S0, S1);

	UFPRB  	inst3 (Q, D_EFF, CLK, CLR, NOTIFY_REG);
      
      or     OR1   (ORs10s11, S10, S11);
      not    NT1   (S0_, S0);
      not    NT2   (ORs10s11_, ORs10s11);
      and    AN1   (EN_D0, CLR, S0_, ORs10s11_);
      and    AN2   (EN_D1, CLR, S0, ORs10s11_);
      and    AN3   (EN_D2, CLR, S0_, ORs10s11);
      and    AN4   (EN_D3, CLR, S0, ORs10s11);
      
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";     


      
          if (!S0 && !(S10 || S11) &&  CLR)
            (posedge CLK =>  (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && !(S10 || S11) &&  CLR)
            (posedge CLK =>  (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (!S0 && (S10 || S11) &&  CLR)
            (posedge CLK =>  (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && (S10 || S11) &&  CLR)
            (posedge CLK =>  (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge CLR => (Q +: 1'b0))   = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D0, posedge CLK &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D0 &&& EN_D0, 0.0, NOTIFY_REG);
      $setup(negedge D0, posedge CLK &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D0 &&& EN_D0, 0.0, NOTIFY_REG);

      $setup(posedge D1, posedge CLK &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D1 &&& EN_D1, 0.0, NOTIFY_REG);
      
      $setup(negedge D1, posedge CLK &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D1 &&& EN_D1, 0.0, NOTIFY_REG);

      $setup(posedge D2, posedge CLK &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D2 &&& EN_D2, 0.0, NOTIFY_REG);
      $setup(negedge D2, posedge CLK &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D2 &&& EN_D2, 0.0, NOTIFY_REG);
      

      $setup(posedge D3, posedge CLK &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D3 &&& EN_D3, 0.0, NOTIFY_REG);
      
      $setup(negedge D3, posedge CLK &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D3 &&& EN_D3, 0.0, NOTIFY_REG);
 
      $setup(posedge S0, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge S0 &&& CLR, 0.0, NOTIFY_REG);
      $setup(negedge S0, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge S0 &&& CLR, 0.0, NOTIFY_REG);

      $setup(posedge S10, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge S10 &&& CLR, 0.0, NOTIFY_REG);
      
      $setup(negedge S10, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge S10 &&& CLR, 0.0, NOTIFY_REG);

      $setup(posedge S11, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge S11 &&& CLR, 0.0, NOTIFY_REG);
      $setup(negedge S11, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge S11 &&& CLR, 0.0, NOTIFY_REG);
      

      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);
 
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge CLR, posedge CLK, 0.0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFM7B ( D0, D1, D2, D3, S0, S10, S11, CLK, CLR, Q);
    
    input    D0, D1, D2, D3, S0, S10, S11, CLR, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
    
        or      OR1_inst ( S1, S10, S11);
        U_MUX_4 inst2 ( D_EFF, D0, D1, D2, D3, S0, S1);

       UFNRB  inst3 (Q, D_EFF, CLK, CLR, NOTIFY_REG);
    
                
      
      or     OR1   (ORs10s11, S10, S11);
      not    NT1   (S0_, S0);
      not    NT2   (ORs10s11_, ORs10s11);
      and    AN1   (EN_D0, CLR, S0_, ORs10s11_);
      and    AN2   (EN_D1, CLR, S0, ORs10s11_);
      and    AN3   (EN_D2, CLR, S0_, ORs10s11);
      and    AN4   (EN_D3, CLR, S0, ORs10s11);
      
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";     


      
          if (!S0 && !(S10 || S11) &&  CLR)
            (negedge CLK =>  (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && !(S10 || S11) &&  CLR)
            (negedge CLK =>  (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (!S0 && (S10 || S11) &&  CLR)
            (negedge CLK =>  (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && (S10 || S11) &&  CLR)
            (negedge CLK =>  (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge CLR => (Q +: 1'b0))   = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D0, negedge CLK &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D0 &&& EN_D0, 0.0, NOTIFY_REG);
      $setup(posedge D1, negedge CLK &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D1 &&& EN_D1, 0.0, NOTIFY_REG);
      $setup(posedge D2, negedge CLK &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D2 &&& EN_D2, 0.0, NOTIFY_REG);
      $setup(posedge D3, negedge CLK &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D3 &&& EN_D3, 0.0, NOTIFY_REG);
  
      $setup(posedge S0, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge S0 &&& CLR, 0.0, NOTIFY_REG);
      $setup(posedge S10, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge S10 &&& CLR, 0.0, NOTIFY_REG);
      $setup(posedge S11, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge S11 &&& CLR, 0.0, NOTIFY_REG);

      $setup(negedge D0, negedge CLK &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D0 &&& EN_D0, 0.0, NOTIFY_REG);
      $setup(negedge D1, negedge CLK &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D1 &&& EN_D1, 0.0, NOTIFY_REG);
      $setup(negedge D2, negedge CLK &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D2 &&& EN_D2, 0.0, NOTIFY_REG);
      $setup(negedge D3, negedge CLK &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D3 &&& EN_D3, 0.0, NOTIFY_REG);
 
      $setup(negedge S0, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge S0 &&& CLR, 0.0, NOTIFY_REG);
      $setup(negedge S10, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge S10 &&& CLR, 0.0, NOTIFY_REG);
      $setup(negedge S11, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge S11 &&& CLR, 0.0, NOTIFY_REG);


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
//-                    cell  DFMA_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFMA_CC(A, B, S, CLK, Q);
    
    input    A, B, S, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNSD  
                inst1 (Q, A, CLK, B, S, NOTIFY_REG);

       xor XR1 (EN, A, B);

    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
          if (!S)
            (negedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S)
            (negedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge A, negedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge A &&& (~S), 0.0, NOTIFY_REG);
      $setup(posedge B, negedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(negedge CLK,posedge  B &&& S, 0.0, NOTIFY_REG);
 
      $setup(posedge S, negedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge S &&& EN, 0.0, NOTIFY_REG);

      

      $setup(negedge A, negedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge A &&& (~S), 0.0, NOTIFY_REG);
      $setup(negedge B, negedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(negedge CLK,negedge  B &&& S, 0.0, NOTIFY_REG);

      $setup(negedge S, negedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge S &&& EN, 0.0, NOTIFY_REG);


      $width(negedge CLK, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK, 0.0, 0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFE3A(D, E, CLK, CLR, Q);
    
    input    D, E, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPCERB  
                inst1 (Q, D, CLK, CLR, E, NOTIFY_REG);
                
       
       and  AN1   (ENABLE, E, CLR);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (E && CLR)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(posedge D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK,posedge D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(posedge E, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge E &&& CLR, 0.0, NOTIFY_REG);

      
      $setup(negedge D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK,negedge D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(negedge E, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge E &&& CLR, 0.0, NOTIFY_REG);



      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);


 
  
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);

      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $recovery(posedge CLR, posedge CLK &&& E, 0.0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFEA(D, E, CLK, Q);
    
    input    D, E, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNCE  
                inst1 (Q, D, CLK, E, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

     


          
          if (E)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, negedge CLK &&& E, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D &&& E, 0.0, NOTIFY_REG);

      $setup(posedge E, negedge CLK, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge E, 0.0, NOTIFY_REG);

      
      $setup(negedge D, negedge CLK &&& E, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D &&& E, 0.0, NOTIFY_REG);

      $setup(negedge E, negedge CLK, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge E, 0.0, NOTIFY_REG);


  
      $width(posedge CLK &&& E, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& E, 0.0, 0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFM1B(A, B, S, CLK, QN);
    
    input    A, B, S, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPSDQ  
                inst1 (QN, A, CLK, B, S, NOTIFY_REG);

       xor XR1 (EN, A, B);

    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 2; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
          if (!S)
            (posedge CLK =>  (QN -: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S)
            (posedge CLK =>  (QN -: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge A, posedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge A &&& (~S), 0.0, NOTIFY_REG);
      $setup(posedge B, posedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge B &&& S, 0.0, NOTIFY_REG);

      $setup(posedge S, posedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge S &&& EN, 0.0, NOTIFY_REG);

      

      $setup(negedge A, posedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge A &&& (~S), 0.0, NOTIFY_REG);
      $setup(negedge B, posedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge B &&& S, 0.0, NOTIFY_REG);


      $setup(negedge S, posedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge S &&& EN, 0.0, NOTIFY_REG);


 
      $width(posedge CLK, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFM1C(A, B, S, CLK, QN);
    
    input    A, B, S, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNSDQ  
                inst1 (QN, A, CLK, B, S, NOTIFY_REG);
    
       xor XR1 (EN, A, B);

    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 2; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
          if (!S)
            (negedge CLK =>  (QN -: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S)
            (negedge CLK =>  (QN -: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge A, negedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge A &&& (~S), 0.0, NOTIFY_REG);
      $setup(posedge B, negedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge B &&& S, 0.0, NOTIFY_REG);
 
      
      $setup(negedge A, negedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge A &&& (~S), 0.0, NOTIFY_REG);
      $setup(negedge B, negedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge B &&& S, 0.0, NOTIFY_REG);
 
 
      $setup(posedge S, negedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge S &&& EN, 0.0, NOTIFY_REG);
      $setup(negedge S, negedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge S &&& EN, 0.0, NOTIFY_REG);
 
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK, 0.0, 0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFM3(A, B, S, CLK, CLR, Q);
    
    input    A, B, S, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPSDR  
                inst1 (Q, A, CLK, B, S, CLR, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, CLR_, S);
      not    N1    (CLR_, CLR);
      nor    AN2   (EN_A, S, CLR);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, CLR_, EN);

    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "X";
         specparam   ExtraDelayPin   = "CLR";
     


      
          if (!S && !CLR)
            (posedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && !CLR)
            (posedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (posedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge A, posedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(posedge B, posedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(posedge S, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge S &&& EN1, 0.0, NOTIFY_REG);

      
      $setup(negedge A, posedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(negedge B, posedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(negedge S, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge S &&& EN1, 0.0, NOTIFY_REG);

      



      $hold(posedge CLK, negedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& CLR_, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR_, 0.0, 0, NOTIFY_REG);
      
      $recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFM4C(A, B, S, CLK, PRE, QN);
    
    input    A, B, S, CLK, PRE;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPSDSBQ  
                inst1 (QN, A, CLK, B, S, PRE, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, PRE, S);
      not    N1    (S_, S);
      and    AN2   (EN_A, S_, PRE);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, PRE, EN);

    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 2; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
          if (!S && PRE)
            (posedge CLK =>  (QN -: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && PRE)
            (posedge CLK =>  (QN -: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge PRE => (QN +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge A, posedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(posedge B, posedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(posedge S, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge S &&& EN1, 0.0, NOTIFY_REG);

      
      $setup(negedge A, posedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(negedge B, posedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(negedge S, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge S &&& EN1, 0.0, NOTIFY_REG);


      $hold(posedge CLK, posedge PRE, 0.0, NOTIFY_REG);

  
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge PRE, posedge CLK, 0.0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFM6B(D0, D1, D2, D3, S0, S1, CLK, CLR, Q);
    
    input    D0, D1, D2, D3, S0, S1, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
    
       U_MUX_4     inst1 (D_EFF, D0, D1, D2, D3, S0, S1);

       UFNRB  inst2 (Q, D_EFF, CLK, CLR, NOTIFY_REG);
    
                
      
      not    NT1   (S0_, S0);
      not    NT2   (S1_, S1);
      and    AN1   (EN_D0, CLR, S0_, S1_);
      and    AN2   (EN_D1, CLR, S0, S1_);
      and    AN3   (EN_D2, CLR, S0_, S1);
      and    AN4   (EN_D3, CLR, S0, S1);
      
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0 = 1; 
         specparam   InputLoad$S1 = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";     


      
          if (!S0 && !S1 &&  CLR)
            (negedge CLK =>  (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && !S1 &&  CLR)
            (negedge CLK =>  (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (!S0 && S1 &&  CLR)
            (negedge CLK =>  (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && S1 &&  CLR)
            (negedge CLK =>  (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge CLR => (Q +: 1'b0))   = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D0, negedge CLK &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D0 &&& EN_D0, 0.0, NOTIFY_REG);
      $setup(posedge D1, negedge CLK &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D1 &&& EN_D1, 0.0, NOTIFY_REG);
      $setup(posedge D2, negedge CLK &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D2 &&& EN_D2, 0.0, NOTIFY_REG);
      $setup(posedge D3, negedge CLK &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D3 &&& EN_D3, 0.0, NOTIFY_REG);

      $setup(posedge S0, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge S0 &&& CLR, 0.0, NOTIFY_REG);
      $setup(posedge S1, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge S1 &&& CLR, 0.0, NOTIFY_REG);

      
      $setup(negedge D0, negedge CLK &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D0 &&& EN_D0, 0.0, NOTIFY_REG);
      $setup(negedge D1, negedge CLK &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D1 &&& EN_D1, 0.0, NOTIFY_REG);
      $setup(negedge D2, negedge CLK &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D2 &&& EN_D2, 0.0, NOTIFY_REG);
      $setup(negedge D3, negedge CLK &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D3 &&& EN_D3, 0.0, NOTIFY_REG);

      $setup(negedge S0, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge S0 &&& CLR, 0.0, NOTIFY_REG);
      $setup(negedge S1, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge S1 &&& CLR, 0.0, NOTIFY_REG);



      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);
 
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge CLR, negedge CLK, 0.0, NOTIFY_REG);

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

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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
`timescale 1 ns / 100 ps
module DFP1C(D, CLK, PRE, QN);
    
    input    D, CLK, PRE;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPSQ 
                inst1 (QN, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "PREN";
         specparam   ExtraDelayPin   = "PRE";
     


          
         if (!PRE)
          (posedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge PRE =>  (QN +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
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

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
         if (PRE)
          (negedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge PRE =>  (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, negedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $hold(negedge CLK,posedge  D &&& PRE, 0.0, NOTIFY_REG);
      $setup(negedge D, negedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $hold(negedge CLK,negedge  D &&& PRE, 0.0, NOTIFY_REG);


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
`timescale 1 ns / 100 ps
module DFP1E(D, CLK, PRE, QN);
    
    input    D, CLK, PRE;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPSBQ 
                inst1 (QN, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
         if (PRE)
          (posedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge PRE =>  (QN +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, posedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge D &&& PRE, 0.0, NOTIFY_REG);
      $setup(negedge D, posedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge D &&& PRE, 0.0, NOTIFY_REG);


      $hold(posedge CLK, posedge PRE, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(posedge PRE, posedge CLK, 0.0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module DFP1F(D, CLK, PRE, QN);
    
    input    D, CLK, PRE;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNSQ 
                inst1 (QN, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "PREN";
         specparam   ExtraDelayPin   = "PRE";
     


          
         if (!PRE)
          (negedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge PRE =>  (QN +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, negedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D &&& (~PRE), 0.0, NOTIFY_REG);
      
      $setup(negedge D, negedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D &&& (~PRE), 0.0, NOTIFY_REG);


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
//-                    cell  DFP1G.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1G(D, CLK, PRE, QN);
    
    input    D, CLK, PRE;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNSBQ 
                inst1 (QN, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
         if (PRE)
          (negedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge PRE =>  (QN +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(posedge D, negedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge D &&& PRE, 0.0, NOTIFY_REG);
      $setup(negedge D, negedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge D &&& PRE, 0.0, NOTIFY_REG);
      


      $hold(negedge CLK, posedge PRE, 0.0, NOTIFY_REG);


  
      $width(posedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(posedge PRE, negedge CLK, 0.0, NOTIFY_REG);

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

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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

         specparam   LibName     = "axcelerator";
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

    $width(negedge PRE, 0.0, 0, NOTIFY_REG); 
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

         specparam   LibName     = "axcelerator";
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

    $width(negedge PRE, 0.0, 0, NOTIFY_REG); 
    $width(posedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge CLR, negedge G &&& PRE, 0.0, NOTIFY_REG);
    $recovery(posedge PRE, negedge G &&& CLR_, 0.0, NOTIFY_REG);

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
  reg NOTIFY_REG;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    CM8 U1(.D0(GND), .D1(GND), .D2(Q), .D3(NET0), .S00(VDD), .S01(
        G), .S10(CLR), .S11(GND), .Y(Q));
    CM8 U0(.D0(D0), .D1(D1), .D2(D2), .D3(D3), .S00(S00), .S01(
        S01), .S10(S10), .S11(S11), .Y(NET0));
    

    
      not    NT1   (S0_, S0);
      nor    NR1   (EN_D0, S0, S1);
      nor    NR2   (EN_D1, S0_, S1);
      and    AN1   (EN_D2, S0_, S1);
      and    AN2   (EN_D3, S0, S1);


    specify

        specparam Libname = "54sx";
         specparam   InputLoad$D0 = 1;
         specparam   InputLoad$D1 = 1;
         specparam   InputLoad$D2 = 1;
         specparam   InputLoad$D3 = 1;
         specparam   InputLoad$S00 = 1;
         specparam   InputLoad$S01 = 1;
         specparam   InputLoad$S10 = 1;
         specparam   InputLoad$S11 = 1;
         specparam   InputLoad$G = 1;
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";

       (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (G)
         (posedge CLR => (Q +: D0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (G)
         (posedge CLR => (Q +: D1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (G)
         (posedge CLR => (Q +: D2)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (G)
         (posedge CLR => (Q +: D3)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

   if (!S0 && !S1 && G)
         (D0 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S0 && !S1 && G)
         (D1 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S0 && S1 && G)
         (D2 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S0 && S1 && G)
         (D3 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (!S0 && !S1)
         (posedge G => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S0 && !S1)
         (posedge G => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S0 && S1)
         (posedge G => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S0 && S1)
         (posedge G => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (!S0 && G && !S10)
         (negedge S11 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S0 && G && !S11)
         (negedge S10 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S1 && G && S01)
         (negedge S00 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S1 && G && S00)
         (negedge S01 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (S0 && G && !S10)
         (negedge S11 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S0 && G && !S11)
         (negedge S10 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S1 && G && S01)
         (posedge S00 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S1 && G && S00)
         (posedge S01 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (!S0 && G && !S10)
         (posedge S11 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S0 && G && !S11)
         (posedge S10 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S1 && G && S01)
         (negedge S00 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S1 && G && S00)
         (negedge S01 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (S0 && G && !S10)
         (posedge S11 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S0 && G && !S11)
         (posedge S10 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S1 && G && S01)
         (posedge S00 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S1 && G && S00)
         (posedge S01 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);





      $setup(D0, negedge G &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(negedge G &&& EN_D0, D0, 0.0, NOTIFY_REG);
      $setup(D1, negedge G &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(negedge G &&& EN_D1, D1, 0.0, NOTIFY_REG);
      $setup(D2, negedge G &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(negedge G &&& EN_D2, D2, 0.0, NOTIFY_REG);
      $setup(D3, negedge G &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(negedge G &&& EN_D3, D3, 0.0, NOTIFY_REG);
 
      $setup(S00, negedge G, 0.0, NOTIFY_REG);
      $hold(negedge G, S00, 0.0, NOTIFY_REG);
      $setup(S01, negedge G, 0.0, NOTIFY_REG);
      $hold(negedge G, S01, 0.0, NOTIFY_REG);
      $setup(S10, negedge G, 0.0, NOTIFY_REG);
      $hold(negedge G, S10, 0.0, NOTIFY_REG);
      $setup(S11, negedge G, 0.0, NOTIFY_REG);
      $hold(negedge G, S11, 0.0, NOTIFY_REG);

      $width(posedge G, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);

     $hold(negedge G, posedge CLR, 0.0, NOTIFY_REG);
     $recovery(posedge CLR, negedge G, 0.0, NOTIFY_REG);

 

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
  reg NOTIFY_REG;

    wire GND, NET0, VDD;
    
    VCC VCC_1(.Y(VDD));
    GND GND_1(.Y(GND));
    CM8 U1(.D0(D0), .D1(D1), .D2(D2), .D3(D3), .S00(S00), .S01(
        S01), .S10(S10), .S11(S11), .Y(NET0));
    CM8 U0(.D0(GND), .D1(GND), .D2(NET0), .D3(Q), .S00(G), .S01(
        VDD), .S10(CLR), .S11(GND), .Y(Q));
    
    
      not    NT1   (S0_, S0);
      nor    NR1   (EN_D0, S0, S1);
      nor    NR2   (EN_D1, S0_, S1);
      and    AN1   (EN_D2, S0_, S1);
      and    AN2   (EN_D3, S0, S1);



    specify

        specparam Libname = "54sx";
         specparam   InputLoad$D0 = 1;
         specparam   InputLoad$D1 = 1;
         specparam   InputLoad$D2 = 1;
         specparam   InputLoad$D3 = 1;
         specparam   InputLoad$S00 = 1;
         specparam   InputLoad$S01 = 1;
         specparam   InputLoad$S10 = 1;
         specparam   InputLoad$S11 = 1;
         specparam   InputLoad$G = 1;
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";


       (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (!G)
         (posedge CLR => (Q +: D0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (!G)
         (posedge CLR => (Q +: D1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (!G)
         (posedge CLR => (Q +: D2)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (!G)
         (posedge CLR => (Q +: D3)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (!S0 && !S1 && !G)
         (D0 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S0 && !S1 && !G)
         (D1 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S0 && S1 && !G)
         (D2 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S0 && S1 && !G)
         (D3 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

  if (!S0 && !S1)
         (negedge G => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S0 && !S1)
         (negedge G => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S0 && S1)
         (negedge G => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S0 && S1)
         (negedge G => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (!S0 && !G && !S10)
         (negedge S11 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S0 && !G && !S11)
         (negedge S10 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S1 && !G && S01)
         (negedge S00 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S1 && !G && S00)
         (negedge S01 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (S0 && !G && !S10)
         (negedge S11 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S0 && !G && !S11)
         (negedge S10 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S1 && !G && S01)
         (posedge S00 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S1 && !G && S00)
         (posedge S01 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (!S0 && !G && !S10)
         (posedge S11 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (!S0 && !G && !S11)
         (posedge S10 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S1 && !G && S01)
         (negedge S00 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S1 && !G && S00)
         (negedge S01 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);

       if (S0 && !G && !S10)
         (posedge S11 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S0 && !G && !S11)
         (posedge S10 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S1 && !G && S01)
         (posedge S00 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);
       if (S1 && !G && S00)
         (posedge S01 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);




      $setup(D0, posedge G &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(posedge G &&& EN_D0, D0, 0.0, NOTIFY_REG);
      $setup(D1, posedge G &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(posedge G &&& EN_D1, D1, 0.0, NOTIFY_REG);
      $setup(D2, posedge G &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(posedge G &&& EN_D2, D2, 0.0, NOTIFY_REG);
      $setup(D3, posedge G &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(posedge G &&& EN_D3, D3, 0.0, NOTIFY_REG);

      $setup(S00, posedge G, 0.0, NOTIFY_REG);
      $hold(posedge G, S00, 0.0, NOTIFY_REG);
      $setup(S01, posedge G, 0.0, NOTIFY_REG);
      $hold(posedge G, S01, 0.0, NOTIFY_REG);
      $setup(S10, posedge G, 0.0, NOTIFY_REG);
      $hold(posedge G, S10, 0.0, NOTIFY_REG);
      $setup(S11, posedge G, 0.0, NOTIFY_REG);
      $hold(posedge G, S11, 0.0, NOTIFY_REG);

      $width(negedge G, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);

     $hold(posedge G, posedge CLR, 0.0, NOTIFY_REG);
     $recovery(posedge CLR, posedge G, 0.0, NOTIFY_REG);


       

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
`timescale 1 ns / 100 ps
module DXAND7(A, B, C, D, E, F, G, Y);
    
    input A, B, C, D, E, F, G;
    output Y;
    
    and AN1   (Y, A, B, C, D, E, F, G);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$F = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";





    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (E => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (F => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (G => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
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
`timescale 1 ns / 100 ps
module DXAX7(A, B, C, D, E, F, G, H, Y);
    
    input A, B, C, D, E, F, G, H;
    output Y;
    
    and AN1   (Y1, A, B, C, D, E, F, G);
    xor XO1   (Y, Y1, H);	
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$F = 1; 
         specparam   InputLoad$G = 1; 
         specparam   InputLoad$H = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";





    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (E => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (F => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (G => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (H => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
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
`timescale 1 ns / 100 ps
module DXNAND7(A, B, C, D, E, F, G, Y);
    
    input A, B, C, D, E, F, G;
    output Y;
    
    nand AN1   (Y, A, B, C, D, E, F, G);
    
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$F = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";





    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (E => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (F => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (G => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
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
`timescale 1 ns / 100 ps
module IR ( PAD, CLK, Q);

input PAD, CLK;
output Q;

reg NOTIFY_REG;

	ULN	U0 (int_q, PAD, CLK, NOTIFY_REG);
	ULP	U1 (Q, int_q, CLK, NOTIFY_REG);

    specify

        specparam Libname = "axcelerator";
        specparam MacroType = "io";

    if (CLK)
    (PAD +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    (posedge CLK => (Q +: PAD)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
 
    $setup(posedge PAD, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, posedge PAD, 0.0, NOTIFY_REG);
    $setup(negedge PAD, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, negedge PAD, 0.0, NOTIFY_REG);
 
    $width(posedge CLK, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLK, 0.0, 0, NOTIFY_REG);


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
`timescale 1 ns / 100 ps
module IRI(CLK,PAD,QN);
input CLK, PAD;
output  QN;

reg NOTIFY_REG;
    
    ULN U0(int_q, PAD, CLK, NOTIFY_REG);
    ULPQ U1(QN, int_q, CLK, NOTIFY_REG);

    specify
      
    specparam Libname = "axcelerator";
 
    if (CLK)
    (PAD +=> QN) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    (posedge CLK => (QN +: PAD)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        

    $setup(posedge PAD, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, posedge PAD, 0.0, NOTIFY_REG);
    $setup(negedge PAD, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, negedge PAD, 0.0, NOTIFY_REG);
    
 
    $width(posedge CLK, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLK, 0.0, 0, NOTIFY_REG);

 
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
`timescale 1 ns / 100 ps
module JKF2C (J, K, CLK, CLR, Q);

    input   J, K, CLK, CLR;

    output   Q;


        reg  NOTIFY_REG;
        
        UFJKBPR inst1 (Q, J, K, CLK, CLR, NOTIFY_REG);   


    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "X";
         specparam   ExtraDelayPin   = "CLR";




        if (!CLR && (J == K))
        (posedge CLK =>  (Q +: J)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (!CLR && J && !K)
        (posedge CLK =>  (Q +: ~Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        (posedge CLR =>  (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(posedge J, posedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(posedge CLK, posedge J &&& (~CLR), 0.0, NOTIFY_REG);

    $setup(posedge K, posedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(posedge CLK, posedge K &&& (~CLR), 0.0, NOTIFY_REG);

    $setup(negedge J, posedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(posedge CLK, negedge J &&& (~CLR), 0.0, NOTIFY_REG);

    $setup(negedge K, posedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(posedge CLK, negedge K &&& (~CLR), 0.0, NOTIFY_REG);


    $hold(posedge CLK, negedge CLR, 0.0, NOTIFY_REG);


    $width(posedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG); 
    $width(negedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG); 

    $width(posedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module JKF2D (J, K, CLK, CLR, Q);

    input  J, K, CLK, CLR;

    output Q;

        reg  NOTIFY_REG;
        
        UFJKBNR inst1 (Q, J, K, CLK, CLR, NOTIFY_REG);   


    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "X";
         specparam   ExtraDelayPin   = "CLR";




        if (!CLR && (J == K))
        (negedge CLK => (Q +: J)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (!CLR && J && !K)
        (negedge CLK => (Q +: ~Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        (posedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(posedge J, negedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(negedge CLK, posedge J &&& (~CLR), 0.0, NOTIFY_REG);

    $setup(posedge K, negedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(negedge CLK, posedge K &&& (~CLR), 0.0, NOTIFY_REG);

    $setup(negedge J, negedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(negedge CLK, negedge J &&& (~CLR), 0.0, NOTIFY_REG);

    $setup(negedge K, negedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(negedge CLK, negedge K &&& (~CLR), 0.0, NOTIFY_REG);



    $hold(negedge CLK, negedge CLR, 0.0, NOTIFY_REG);


    $width(negedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG); 
    $width(posedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG); 

    $width(posedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge CLR, negedge CLK, 0.0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module MXC1(A, B, C, D, S, Y);
    
    input S, A, B, C, D;
    output Y;


    U_MUX_2  inst1   (SL, A, B, S);   
    U_MUX_2  inst2   (Y, C, D, SL);   
      
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$S = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$S$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;





        (A => Y)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S => Y)  = (1.0:1.0:1.0, 1.0:1.0:1.0);

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
`timescale 1 ns / 100 ps
module MXT(D0, D1, D2, D3, S0A, S0B, S1, Y);
    
    input D0, D1, D2, D3, S0A, S0B, S1;
    output Y;
    

    U_MUX_2  inst1   (Y_INT1, D0, D1, S0A);   
    U_MUX_2  inst2   (Y_INT2, D2, D3, S0B);   
    U_MUX_2  inst3   (Y, Y_INT1, Y_INT2, S1);   

     
    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0A = 1; 
         specparam   InputLoad$S0B = 1; 
         specparam   InputLoad$S1 = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$D0$Y   = 1;
         specparam   ExtraDelayPaths$D1$Y   = 1;
         specparam   ExtraDelayPaths$S0A$Y  = 1;
         specparam   ExtraDelayPaths$D2$Y   = 0;
         specparam   ExtraDelayPaths$D3$Y   = 0;
         specparam   ExtraDelayPaths$S0B$Y  = 0;
         specparam   ExtraDelayPaths$S1$Y   = 0;





        (D0 => Y)   = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D1 => Y)   = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D2 => Y)   = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D3 => Y)   = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S0A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S0B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S1 => Y)  = (1.0:1.0:1.0, 1.0:1.0:1.0);

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
`timescale 1 ns / 100 ps
module OBDLHS(D, G, PAD);
    
    input   D, G;
    output  PAD;
        
    reg  NOTIFY_REG ;

    ULP   inst1  (PAD, D, G, NOTIFY_REG); 

    specify

         specparam   LibName     = "axcelerator";
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$PAD = 0; 
         specparam   InputLoad$D = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "io";
  



    if (G)
    (D +=> PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    (posedge G => (PAD +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        

    $setup(posedge D, negedge G, 0.0, NOTIFY_REG);
    $hold(negedge G, posedge D, 0.0, NOTIFY_REG);
    $setup(negedge D, negedge G, 0.0, NOTIFY_REG);
    $hold(negedge G, negedge D, 0.0, NOTIFY_REG);
    

    $width(posedge G, 0.0, 0, NOTIFY_REG); 

    
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
`timescale 1 ns / 100 ps
module OBHS(D, PAD);
    
    input   D;
    output  PAD;
        
    buf      BF1  (PAD, D);

    specify

         specparam   LibName     = "axcelerator";
         specparam   OutputLoad$PAD = 0; 
         specparam   InputLoad$D = 1;

         specparam   MacroType = "io";
  



    (D => PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    
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
`timescale 1 ns / 100 ps
module ORH ( D, CLK, PAD);

input D, CLK;
output PAD;

reg NOTIFY_REG;

	ULN	U0 (int_q, D, CLK, NOTIFY_REG);
	ULP	U1 (PAD, int_q, CLK, NOTIFY_REG);

    specify

    if (CLK)
    (D +=> PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    (posedge CLK => (PAD +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
 
    $setup(posedge D, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, posedge D, 0.0, NOTIFY_REG);
    
    $setup(negedge D, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, negedge D, 0.0, NOTIFY_REG);

    $width(posedge CLK, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLK, 0.0, 0, NOTIFY_REG);
    
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
`timescale 1 ns / 100 ps
module ORIH ( D, CLK, PAD);

input D, CLK;
output PAD;

reg NOTIFY_REG;

	ULNQ	U0 (int_q, D, CLK, NOTIFY_REG);
	ULP	U1 (PAD, int_q, CLK, NOTIFY_REG);


specify

 if (CLK)
    (D +=> PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    (posedge CLK => (PAD +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        

    $setup(posedge D, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, posedge D, 0.0, NOTIFY_REG);

    $setup(negedge D, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, negedge D, 0.0, NOTIFY_REG);

    $width(posedge CLK, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLK, 0.0, 0, NOTIFY_REG);

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
`timescale 1 ns / 100 ps
module ORITH ( D, CLK, E, PAD);

input D, E, CLK;
output PAD;

reg NOTIFY_REG;

	ULNQ	U0 (int_q, D, CLK, NOTIFY_REG);
	ULP	U1 (PAD_INT, int_q, CLK, NOTIFY_REG);
        bufif1  BUFIF1 (PAD, PAD_INT, E);

    specify

    if (CLK && E)
    (D +=> PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    if(E)
    (posedge CLK => (PAD +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
    (E => PAD) = (0, 0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0);
        

    $setup(posedge D, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, posedge D, 0.0, NOTIFY_REG);

    $setup(negedge D, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, negedge D, 0.0, NOTIFY_REG);
 
    $width(posedge CLK, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLK, 0.0, 0, NOTIFY_REG);


    
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
`timescale 1 ns / 100 ps
module ORTH ( D, CLK, E, PAD);

input D, E, CLK;
output PAD;

reg NOTIFY_REG;

	ULN	U0 (int_q, D, CLK, NOTIFY_REG);
	ULP	U1 (PAD_INT, int_q, CLK, NOTIFY_REG);
        bufif1  BFIF1 (PAD, PAD_INT, E);


    specify

    if (CLK && E)
    (D +=> PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    if(E)
    (posedge CLK => (PAD +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
    (E => PAD) = (0, 0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0);
        

    $setup(posedge D, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, posedge D, 0.0, NOTIFY_REG);

    $setup(negedge D, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, negedge D, 0.0, NOTIFY_REG);
 
    $width(posedge CLK, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLK, 0.0, 0, NOTIFY_REG);

    
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
      

//  ------------------------------  END of ax_mig.v ----------------------------
